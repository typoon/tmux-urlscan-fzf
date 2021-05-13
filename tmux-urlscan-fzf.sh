#!/usr/bin/env bash

fzf_filter() {
    fzf-tmux -d 50% -m -0 --no-preview -p
}

open_url() {
    if command -v xdg-open &>/dev/null; then
        nohup xdg-open "$@"
    elif command -v open &>/dev/null; then
        nohup open "$@"
    elif [[ -n $BROWSER ]]; then
        nohup "$BROWSER" "$@"
    fi
}

content="$(tmux capture-pane -J -p)"

items=$(echo $content|urlscan -n -c -d)
mapfile -t chosen < <(fzf_filter <<< "$items")

for item in "${chosen[@]}"; do
    open_url "$item" 
done
