# 1. Use a tiny Python base
FROM python:3.10-slim

# 2. Install essential system tools
RUN apt-get update && apt-get install -y \
    git ffmpeg curl && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /usr/src/app

# 3. Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# 4. Copy project files
COPY . .

# 5. The "Web Service" Hack 
# Render Free Tier requires an open port. We use a one-liner to start a tiny web server.
CMD python3 -m http.server $PORT & bash start.sh
