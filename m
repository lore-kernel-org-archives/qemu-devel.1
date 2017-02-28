Received: from eggs.gnu.org ([2001:4830:134:3::10]:56404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cii8v-0003YJ-PX
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:48:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1cii8t-00054T-4U
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:48:41 -0500
Received: from mail-lf0-x242.google.com ([2a00:1450:4010:c07::242]:36628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1cii8s-00054G-Jk
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 08:48:39 -0500
Received: by mail-lf0-x242.google.com with SMTP id g70so54443lfh.3
	for <qemu-devel@nongnu.org>; Tue, 28 Feb 2017 05:48:36 -0800 (PST)
MIME-Version: 1.0
References: <20170228120754.7947-1-berrange@redhat.com>
In-Reply-To: <20170228120754.7947-1-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 28 Feb 2017 13:48:23 +0000
Message-ID: <CAJ+F1CJ2WiJy9+atWvJ7cb0C_gzq1_N8zKo6t-KQArVJDuQ6zA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] io: fully parse & validate HTTP headers
 for websocket protocol handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Anton Nefedov <anton.nefedov@virtuozzo.com>

Hi

On Tue, Feb 28, 2017 at 4:11 PM Daniel P. Berrange <berrange@redhat.com>
wrote:

> The current websockets protocol handshake code is very relaxed, just
> doing crude string searching across the HTTP header data. This causes
> it to both reject valid connections and fail to reject invalid
> connections. For example, according to the RFC 6455 it:
>
>  - MUST reject any method other than "GET"
>  - MUST reject any HTTP version less than "HTTP/1.1"
>  - MUST reject Connection header without "Upgrade" listed
>  - MUST reject Upgrade header which is not 'websocket'
>  - MUST reject missing Host header
>  - MUST treat HTTP header names as case insensitive
>
> To do all this validation correctly requires that we fully parse the
> HTTP headers, populating a data structure containing the header
> fields.
>
> After this change, we also reject any path other than '/'


> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  io/channel-websock.c | 236
> ++++++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 194 insertions(+), 42 deletions(-)
>

Looks good, but tests would be welcome, do you have plans for it?


> diff --git a/io/channel-websock.c b/io/channel-websock.c
> index a06a4a8..8fabade 100644
> --- a/io/channel-websock.c
> +++ b/io/channel-websock.c
> @@ -33,11 +33,16 @@
>  #define QIO_CHANNEL_WEBSOCK_GUID "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"
>  #define QIO_CHANNEL_WEBSOCK_GUID_LEN strlen(QIO_CHANNEL_WEBSOCK_GUID)
>
> -#define QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL "Sec-WebSocket-Protocol"
> -#define QIO_CHANNEL_WEBSOCK_HEADER_VERSION "Sec-WebSocket-Version"
> -#define QIO_CHANNEL_WEBSOCK_HEADER_KEY "Sec-WebSocket-Key"
> +#define QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL "sec-websocket-protocol"
> +#define QIO_CHANNEL_WEBSOCK_HEADER_VERSION "sec-websocket-version"
> +#define QIO_CHANNEL_WEBSOCK_HEADER_KEY "sec-websocket-key"
> +#define QIO_CHANNEL_WEBSOCK_HEADER_UPGRADE "upgrade"
> +#define QIO_CHANNEL_WEBSOCK_HEADER_HOST "host"
> +#define QIO_CHANNEL_WEBSOCK_HEADER_CONNECTION "connection"
>
>  #define QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY "binary"
> +#define QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE "Upgrade"
> +#define QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET "websocket"
>
>  #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RESPONSE  \
>      "HTTP/1.1 101 Switching Protocols\r\n"      \
> @@ -49,6 +54,9 @@
>  #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM "\r\n"
>  #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_END "\r\n\r\n"
>  #define QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION "13"
> +#define QIO_CHANNEL_WEBSOCK_HTTP_METHOD "GET"
> +#define QIO_CHANNEL_WEBSOCK_HTTP_PATH "/"
> +#define QIO_CHANNEL_WEBSOCK_HTTP_VERSION "HTTP/1.1"
>
>  /* The websockets packet header is variable length
>   * depending on the size of the payload... */
> @@ -99,6 +107,13 @@ struct QEMU_PACKED QIOChannelWebsockHeader {
>      } u;
>  };
>
> +typedef struct QIOChannelWebsockHTTPHeader QIOChannelWebsockHTTPHeader;
> +
> +struct QIOChannelWebsockHTTPHeader {
> +    char *name;
> +    char *value;
> +};
> +
>  enum {
>      QIO_CHANNEL_WEBSOCK_OPCODE_CONTINUATION =3D 0x0,
>      QIO_CHANNEL_WEBSOCK_OPCODE_TEXT_FRAME =3D 0x1,
> @@ -108,25 +123,130 @@ enum {
>      QIO_CHANNEL_WEBSOCK_OPCODE_PONG =3D 0xA
>  };
>
> -static char *qio_channel_websock_handshake_entry(const char *handshake,
> -                                                 size_t handshake_len,
> -                                                 const char *name)
> -{
> -    char *begin, *end, *ret =3D NULL;
> -    char *line =3D g_strdup_printf("%s%s: ",
> -                                 QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM,
> -                                 name);
> -    begin =3D g_strstr_len(handshake, handshake_len, line);
> -    if (begin !=3D NULL) {
> -        begin +=3D strlen(line);
> -        end =3D g_strstr_len(begin, handshake_len - (begin - handshake),
> -                QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
> -        if (end !=3D NULL) {
> -            ret =3D g_strndup(begin, end - begin);
> +static size_t
> +qio_channel_websock_extract_headers(char *buffer,
> +                                    QIOChannelWebsockHTTPHeader *hdrs,
> +                                    size_t nhdrsalloc,
> +                                    Error **errp)
> +{
> +    char *nl, *sep, *tmp;
> +    size_t nhdrs =3D 0;
> +
> +    /*
> +     * First parse the HTTP protocol greeting of format:
> +     *
> +     *   $METHOD $PATH $VERSION
> +     *
> +     * e.g.
> +     *
> +     *   GET / HTTP/1.1
> +     */
> +
> +    nl =3D strstr(buffer, QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
> +    if (!nl) {
> +        error_setg(errp, "Missing HTTP header delimiter");
> +        return 0;
> +    }
> +    *nl =3D '\0';
> +
> +    tmp =3D strchr(buffer, ' ');
> +    if (!tmp) {
> +        error_setg(errp, "Missing HTTP path delimiter");
> +        return 0;
> +    }
> +    *tmp =3D '\0';
> +
> +    if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_METHOD)) {
> +        error_setg(errp, "Unsupported HTTP method %s", buffer);
> +        return 0;
> +    }
> +
> +    buffer =3D tmp + 1;
> +    tmp =3D strchr(buffer, ' ');
> +    if (!tmp) {
> +        error_setg(errp, "Missing HTTP version delimiter");
> +        return 0;
> +    }
> +    *tmp =3D '\0';
> +
> +    if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_PATH)) {
> +        error_setg(errp, "Unexpected HTTP path %s", buffer);
> +        return 0;
> +    }
> +
> +    buffer =3D tmp + 1;
> +
> +    if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_VERSION)) {
> +        error_setg(errp, "Unsupported HTTP version %s", buffer);
> +        return 0;
> +    }
> +
> +    buffer =3D nl + strlen(QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
> +
> +    /*
> +     * Now parse all the header fields of format
> +     *
> +     *   $NAME: $VALUE
> +     *
> +     * e.g.
> +     *
> +     *   Cache-control: no-cache
> +     */
> +    do {
> +        QIOChannelWebsockHTTPHeader *hdr;
> +
> +        nl =3D strstr(buffer, QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
> +        if (nl) {
> +            *nl =3D '\0';
> +        }
> +
> +        sep =3D strchr(buffer, ':');
> +        if (!sep) {
> +            error_setg(errp, "Malformed HTTP header");
> +            return 0;
> +        }
> +        *sep =3D '\0';
> +        sep++;
> +        while (*sep =3D=3D ' ') {
> +            sep++;
> +        }
> +
> +        if (nhdrs >=3D nhdrsalloc) {
> +            error_setg(errp, "Too many HTTP headers");
> +            return 0;
> +        }
> +
> +        hdr =3D &hdrs[nhdrs++];
> +        hdr->name =3D buffer;
> +        hdr->value =3D sep;
> +
> +        /* Canonicalize header name for easier identification later */
> +        for (tmp =3D hdr->name; *tmp; tmp++) {
> +            *tmp =3D g_ascii_tolower(*tmp);
> +        }
> +
> +        if (nl) {
> +            buffer =3D nl + strlen(QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
> +        }
> +    } while (nl !=3D NULL);
> +
> +    return nhdrs;
> +}
> +
> +static const char *
> +qio_channel_websock_find_header(QIOChannelWebsockHTTPHeader *hdrs,
> +                                size_t nhdrs,
> +                                const char *name)
> +{
> +    size_t i;
> +
> +    for (i =3D 0; i < nhdrs; i++) {
> +        if (g_str_equal(hdrs[i].name, name)) {
> +            return hdrs[i].value;
>          }
>      }
> -    g_free(line);
> -    return ret;
> +
> +    return NULL;
>  }
>
>
> @@ -166,58 +286,90 @@ static int
> qio_channel_websock_handshake_send_response(QIOChannelWebsock *ioc,
>  }
>
>  static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
> -                                                 const char *line,
> -                                                 size_t size,
> +                                                 char *buffer,
>                                                   Error **errp)
>  {
> -    int ret =3D -1;
> -    char *protocols =3D qio_channel_websock_handshake_entry(
> -        line, size, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
> -    char *version =3D qio_channel_websock_handshake_entry(
> -        line, size, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
> -    char *key =3D qio_channel_websock_handshake_entry(
> -        line, size, QIO_CHANNEL_WEBSOCK_HEADER_KEY);
> +    QIOChannelWebsockHTTPHeader hdrs[32];
> +    size_t nhdrs =3D G_N_ELEMENTS(hdrs);
> +    const char *protocols =3D NULL, *version =3D NULL, *key =3D NULL,
> +        *host =3D NULL, *connection =3D NULL, *upgrade =3D NULL;
>
> +    nhdrs =3D qio_channel_websock_extract_headers(buffer, hdrs, nhdrs,
> errp);
> +    if (!nhdrs) {
> +        return -1;
> +    }
> +
> +    protocols =3D qio_channel_websock_find_header(
> +        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
>      if (!protocols) {
>          error_setg(errp, "Missing websocket protocol header data");
> -        goto cleanup;
> +        return -1;
>      }
>
> +    version =3D qio_channel_websock_find_header(
> +        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
>      if (!version) {
>          error_setg(errp, "Missing websocket version header data");
> -        goto cleanup;
> +        return -1;
>      }
>
> +    key =3D qio_channel_websock_find_header(
> +        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_KEY);
>      if (!key) {
>          error_setg(errp, "Missing websocket key header data");
> -        goto cleanup;
> +        return -1;
> +    }
> +
> +    host =3D qio_channel_websock_find_header(
> +        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_HOST);
> +    if (!host) {
> +        error_setg(errp, "Missing websocket host header data");
> +        return -1;
> +    }
> +
> +    connection =3D qio_channel_websock_find_header(
> +        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_CONNECTION);
> +    if (!connection) {
> +        error_setg(errp, "Missing websocket connection header data");
> +        return -1;
> +    }
> +
> +    upgrade =3D qio_channel_websock_find_header(
> +        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_UPGRADE);
> +    if (!upgrade) {
> +        error_setg(errp, "Missing websocket upgrade header data");
> +        return -1;
>      }
>
>      if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
>          error_setg(errp, "No '%s' protocol is supported by client '%s'",
>                     QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);
> -        goto cleanup;
> +        return -1;
>      }
>
>      if (!g_str_equal(version, QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION)) {
>          error_setg(errp, "Version '%s' is not supported by client '%s'",
>                     QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION, version);
> -        goto cleanup;
> +        return -1;
>      }
>
>      if (strlen(key) !=3D QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN) {
>          error_setg(errp, "Key length '%zu' was not as expected '%d'",
>                     strlen(key), QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN);
> -        goto cleanup;
> +        return -1;
>      }
>
> -    ret =3D qio_channel_websock_handshake_send_response(ioc, key, errp);
> +    if (!g_strrstr(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE)) =
{
> +        error_setg(errp, "No connection upgrade requested '%s'",
> connection);
> +        return -1;
> +    }
>
> - cleanup:
> -    g_free(protocols);
> -    g_free(version);
> -    g_free(key);
> -    return ret;
> +    if (!g_str_equal(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET)) {
> +        error_setg(errp, "Incorrect upgrade method '%s'", upgrade);
> +        return -1;
> +    }
> +
> +    return qio_channel_websock_handshake_send_response(ioc, key, errp);
>  }
>
>  static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
> @@ -248,10 +400,10 @@ static int
> qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
>              return 0;
>          }
>      }
> +    *handshake_end =3D '\0';
>
>      if (qio_channel_websock_handshake_process(ioc,
>                                                (char
> *)ioc->encinput.buffer,
> -                                              ioc->encinput.offset,
>                                                errp) < 0) {
>          return -1;
>      }
> --
> 2.9.3
>
>
> --
Marc-Andr=C3=A9 Lureau
