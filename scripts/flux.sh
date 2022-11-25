#!/usr/bin/env bash
export LC_ALL=en_US.UTF-8

current_dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)"
source $current_dir/utils.sh

tmux set -g status-left-length "100"
tmux set -g status-right-length "100"
tmux set -g status "2"

secondary="#a1af9f"
flux_bg="#282a36"
flux_fg="#f6edd9"
status="#3d4052"
green="#9cde9f"
yellow="#ffda84"
red="#bf0603"
blue="#437c90"
light_blue="#c4d7f2"

prefix_en="ﯦ"
prefix_dis=""
right=""
left=""

tmux set -g window-style "bg=$flux_bg"
tmux set -g pane-border-style "bg=$flux_bg,fg=$secondary"
tmux set -g pane-active-border-style "bg=$flux_bg,fg=$flux_fg"
status_style_1="#[bg=$status,fg=$flux_fg]"

tmux set -g status-style "bg=$status,fg=$flux_fg"
tmux set -g status-right "$status_style_1#[fill=$status]"
tmux set -g status-left "$status_style_1#[fill=$status]"
tmux set -g status-format[1] "#[bg=$flux_bg,fg=$flux_fg,fill=$flux_bg]"

# MODE
mode_style="#{?client_prefix,#[bg=$green],}"
mode_label="$(padding 3)#{?client_prefix,$prefix_en,$prefix_dis}$(padding 3)"

tmux set -ga status-left "$mode_style$mode_label$right"

# TIME
tmux set -g clock-mode-style 24
timezone=""
time_label="%a %d.%m %R${timezone}"
tmux set -ga status-left "#[bg=$flux_fg,fg=$flux_bg]$(padding 1)$time_label$(padding 1)#[bg=$flux_fg,fg=$status]$right"

# WINDOW STATUS
tmux set -wg window-status-current-format ""
tmux set -wg window-status-format ""
tmux set -g window-status-separator ""

window_label="#I#{?pane_in_mode,  #{pane_mode},}  #W"

tmux set -wga window-status-format "#[fg=$secondary]$right#[bg=$secondary,fg=$flux_bg]$(padding 2)$window_label$(padding 2)#[bg=$secondary,fg=$status]$right"
tmux set -wga window-status-current-format "#[fg=$flux_fg]$right#[bg=$flux_fg,fg=$flux_bg]$(padding 2)$window_label$(padding 2)#[bg=$flux_fg,fg=$status]$right"

# WEATHER
weather_bg="$secondary"
weather_fg="$flux_bg"
tmux set -g @forecast-location "Warszawa"
tmux set -g @forecast-format "%l+%C+%t+(%f)+%w\n"
weather_label="#(~/.tmux/plugins/tmux-weather/scripts/forecast.sh)"
tmux set -ga status-right "#[bg=$weather_bg,fg=$status]$left#[bg=$weather_bg,fg=$weather_fg]$(padding 2)$weather_label$(padding 2)"

# WHOAMI
whoami_label="#(whoami)@#h"
tmux set -ga status-right "#[bg=$flux_fg,fg=$weather_bg]$left#[bg=$flux_fg,fg=$status]$(padding 3)$whoami_label$(padding 3)"

# SPOTIFY
tmux set -ga status-format[1] "#[align=left]"

spotify_icon=""
spotify_song="#(~/.tmux/plugins/tmux-spotify-tui/scripts/get_actual_song.sh)"
spotify_label="$(padding 2)$spotify_song$(padding 2)"

tmux set -ga status-format[1] "$spotify_label"

# NETWORK STATUS (PING)
ping_bg="$green"
ping_status="#(~/.tmux/plugins/tmux-ping/scripts/ping_status.sh)"
tmux set -ga status-right "#[bg=$ping_bg,fg=$flux_fg]$left#[bg=$ping_bg,fg=$flux_bg]$(padding 1)$ping_status$(padding 1)"

# NETWORK SPEED
tmux set -g @net_speed_format "↓ %10s - ↑ %10s"
network_label="#(~/.tmux/plugins/tmux-net-speed/scripts/net_speed.sh)"
tmux set -ga status-format[1] "#[align=right]"
tmux set -ga status-format[1] "$(padding 2) $network_label$(padding 2)"

# CPU AND RAM
tmux set -g @cpu_temp_format "%3.0f"

tmux set -g @cpu_low_bg_color "#[bg=$green]"
tmux set -g @cpu_medium_bg_color "#[bg=$yellow]"
tmux set -g @cpu_high_bg_color "#[bg=$red]"

tmux set -g @cpu_low_fg_color "#[fg=$green]"
tmux set -g @cpu_medium_fg_color "#[fg=$yellow]"
tmux set -g @cpu_high_fg_color "#[fg=$red]"

tmux set -g @cpu_percentage_format "%5.1f%%"

tmux set -g @ram_low_bg_color "#[bg=$green]"
tmux set -g @ram_medium_bg_color "#[bg=$yellow]"
tmux set -g @ram_high_bg_color "#[bg=$red]"

tmux set -g @ram_percentage_format "%5.1f%%"

cpu_bg="#(~/.tmux/plugins/tmux-cpu/scripts/cpu_bg_color.sh)"
cpu_fg="#(~/.tmux/plugins/tmux-cpu/scripts/cpu_fg_color.sh)"
cpu_percentage="#(~/.tmux/plugins/tmux-cpu/scripts/cpu_percentage.sh)"
cpu_icon="#(~/.tmux/plugins/tmux-cpu/scripts/cpu_icon.sh)"

ram_bg="#(~/.tmux/plugins/tmux-cpu/scripts/ram_bg_color.sh)"
ram_fg="#(~/.tmux/plugins/tmux-cpu/scripts/ram_fg_color.sh)"
ram_percentage="#(~/.tmux/plugins/tmux-cpu/scripts/ram_percentage.sh)"
ram_icon="#(~/.tmux/plugins/tmux-cpu/scripts/ram_icon.sh)"

cpu_label="$cpu_bg#[fg=$flux_bg]$left$(padding 2)#[fg=$flux_bg] $cpu_percentage $cpu_icon"
ram_label="$ram_bg$cpu_fg$left$(padding 2)#[fg=$flux_bg]$(echo -e '\ufb19') $ram_percentage $ram_icon"

tmux set -ga status-format[1] "$(padding 2)$cpu_label$(padding 1)$ram_label$(padding 2)"

