# 
FROM alpine:latest AS build

RUN apk update && apk add hugo

COPY website /hugo-site

ENV HUGO_ENV=production
RUN hugo -v --source=/hugo-site --destination=/hugo-site/public --gc --minify

FROM nginx:stable-alpine
RUN mv /usr/share/nginx/html/index.html /usr/share/nginx/html/index.html.old
COPY --from=build /hugo-site/public /usr/share/nginx/html/

EXPOSE 80

