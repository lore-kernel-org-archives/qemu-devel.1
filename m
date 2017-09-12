Received: from eggs.gnu.org ([2001:4830:134:3::10]:40099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drl5i-0005B8-Nd
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:19:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drl5d-0001Gh-V0
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:19:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1drl5d-0001G2-Ll
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 09:18:57 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 14:18:45 +0100
Message-Id: <20170912131847.27684-2-berrange@redhat.com>
In-Reply-To: <20170912131847.27684-1-berrange@redhat.com>
References: <20170912131847.27684-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/3] io: send proper HTTP response for
 websocket errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Eric Blake <eblake@redhat.com>, Brian Rak <brak@vultr.com>, "Daniel P. Berrange" <berrange@redhat.com>

When any error occurs while processing the websockets handshake,
QEMU just terminates the connection abruptly. This is in violation
of the HTTP specs and does not help the client understand what they
did wrong. This is particularly bad when the client gives the wrong
path, as a "404 Not Found" would be very helpful.

Refactor the handshake code so that it always sends a response to
the client unless there was an I/O error.

Fixes bug: #1715186

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 185 ++++++++++++++++++++++++++++++++++++++-------=
------
 1 file changed, 139 insertions(+), 46 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 5a3badbec2..f5fac5b422 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -25,6 +25,8 @@
 #include "crypto/hash.h"
 #include "trace.h"
=20
+#include <time.h>
+
=20
 /* Max amount to allow in rawinput/rawoutput buffers */
 #define QIO_CHANNEL_WEBSOCK_MAX_BUFFER 8192
@@ -44,13 +46,40 @@
 #define QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE "Upgrade"
 #define QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET "websocket"
=20
-#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RESPONSE  \
+#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON \
+    "Server: QEMU VNC\r\n"                       \
+    "Date: %s\r\n"
+
+#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK    \
     "HTTP/1.1 101 Switching Protocols\r\n"      \
+    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON    \
     "Upgrade: websocket\r\n"                    \
     "Connection: Upgrade\r\n"                   \
     "Sec-WebSocket-Accept: %s\r\n"              \
     "Sec-WebSocket-Protocol: binary\r\n"        \
     "\r\n"
+#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_NOT_FOUND \
+    "HTTP/1.1 404 Not Found\r\n"                    \
+    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON        \
+    "Connection: close\r\n"                         \
+    "\r\n"
+#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_BAD_REQUEST \
+    "HTTP/1.1 400 Bad Request\r\n"                    \
+    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON          \
+    "Connection: close\r\n"                           \
+    "Sec-WebSocket-Version: "                         \
+    QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION             \
+    "\r\n"
+#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_SERVER_ERR \
+    "HTTP/1.1 500 Internal Server Error\r\n"         \
+    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON         \
+    "Connection: close\r\n"                          \
+    "\r\n"
+#define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_TOO_LARGE  \
+    "HTTP/1.1 403 Request Entity Too Large\r\n"      \
+    QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_COMMON         \
+    "Connection: close\r\n"                          \
+    "\r\n"
 #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM "\r\n"
 #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_END "\r\n\r\n"
 #define QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION "13"
@@ -123,8 +152,46 @@ enum {
     QIO_CHANNEL_WEBSOCK_OPCODE_PONG =3D 0xA
 };
=20
+static void qio_channel_websock_handshake_send_res(QIOChannelWebsock *io=
c,
+                                                   const char *resmsg,
+                                                   ...)
+{
+    va_list vargs;
+    char *response;
+    size_t responselen;
+
+    va_start(vargs, resmsg);
+    response =3D g_strdup_vprintf(resmsg, vargs);
+    responselen =3D strlen(response);
+    buffer_reserve(&ioc->encoutput, responselen);
+    buffer_append(&ioc->encoutput, response, responselen);
+    va_end(vargs);
+}
+
+static gchar *qio_channel_websock_date_str(void)
+{
+    struct tm tm;
+    time_t now =3D time(NULL);
+    char datebuf[128];
+
+    gmtime_r(&now, &tm);
+
+    strftime(datebuf, sizeof(datebuf), "%a, %d %b %Y %H:%M:%S GMT", &tm)=
;
+
+    return g_strdup(datebuf);
+}
+
+static void qio_channel_websock_handshake_send_res_err(QIOChannelWebsock=
 *ioc,
+                                                       const char *resda=
ta)
+{
+    char *date =3D qio_channel_websock_date_str();
+    qio_channel_websock_handshake_send_res(ioc, resdata, date);
+    g_free(date);
+}
+
 static size_t
-qio_channel_websock_extract_headers(char *buffer,
+qio_channel_websock_extract_headers(QIOChannelWebsock *ioc,
+                                    char *buffer,
                                     QIOChannelWebsockHTTPHeader *hdrs,
                                     size_t nhdrsalloc,
                                     Error **errp)
@@ -145,7 +212,7 @@ qio_channel_websock_extract_headers(char *buffer,
     nl =3D strstr(buffer, QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
     if (!nl) {
         error_setg(errp, "Missing HTTP header delimiter");
-        return 0;
+        goto bad_request;
     }
     *nl =3D '\0';
=20
@@ -158,18 +225,20 @@ qio_channel_websock_extract_headers(char *buffer,
=20
     if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_METHOD)) {
         error_setg(errp, "Unsupported HTTP method %s", buffer);
-        return 0;
+        goto bad_request;
     }
=20
     buffer =3D tmp + 1;
     tmp =3D strchr(buffer, ' ');
     if (!tmp) {
         error_setg(errp, "Missing HTTP version delimiter");
-        return 0;
+        goto bad_request;
     }
     *tmp =3D '\0';
=20
     if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_PATH)) {
+        qio_channel_websock_handshake_send_res_err(
+            ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_NOT_FOUND);
         error_setg(errp, "Unexpected HTTP path %s", buffer);
         return 0;
     }
@@ -178,7 +247,7 @@ qio_channel_websock_extract_headers(char *buffer,
=20
     if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_VERSION)) {
         error_setg(errp, "Unsupported HTTP version %s", buffer);
-        return 0;
+        goto bad_request;
     }
=20
     buffer =3D nl + strlen(QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
@@ -203,7 +272,7 @@ qio_channel_websock_extract_headers(char *buffer,
         sep =3D strchr(buffer, ':');
         if (!sep) {
             error_setg(errp, "Malformed HTTP header");
-            return 0;
+            goto bad_request;
         }
         *sep =3D '\0';
         sep++;
@@ -213,7 +282,7 @@ qio_channel_websock_extract_headers(char *buffer,
=20
         if (nhdrs >=3D nhdrsalloc) {
             error_setg(errp, "Too many HTTP headers");
-            return 0;
+            goto bad_request;
         }
=20
         hdr =3D &hdrs[nhdrs++];
@@ -231,6 +300,11 @@ qio_channel_websock_extract_headers(char *buffer,
     } while (nl !=3D NULL);
=20
     return nhdrs;
+
+ bad_request:
+    qio_channel_websock_handshake_send_res_err(
+        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_BAD_REQUEST);
+    return 0;
 }
=20
 static const char *
@@ -250,14 +324,14 @@ qio_channel_websock_find_header(QIOChannelWebsockHT=
TPHeader *hdrs,
 }
=20
=20
-static int qio_channel_websock_handshake_send_response(QIOChannelWebsock=
 *ioc,
-                                                       const char *key,
-                                                       Error **errp)
+static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock =
*ioc,
+                                                      const char *key,
+                                                      Error **errp)
 {
     char combined_key[QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN +
                       QIO_CHANNEL_WEBSOCK_GUID_LEN + 1];
-    char *accept =3D NULL, *response =3D NULL;
-    size_t responselen;
+    char *accept =3D NULL;
+    char *date =3D qio_channel_websock_date_str();
=20
     g_strlcpy(combined_key, key, QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN + 1)=
;
     g_strlcat(combined_key, QIO_CHANNEL_WEBSOCK_GUID,
@@ -271,105 +345,108 @@ static int qio_channel_websock_handshake_send_res=
ponse(QIOChannelWebsock *ioc,
                             QIO_CHANNEL_WEBSOCK_GUID_LEN,
                             &accept,
                             errp) < 0) {
-        return -1;
+        qio_channel_websock_handshake_send_res_err(
+            ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_SERVER_ERR);
+        return;
     }
=20
-    response =3D g_strdup_printf(QIO_CHANNEL_WEBSOCK_HANDSHAKE_RESPONSE,=
 accept);
-    responselen =3D strlen(response);
-    buffer_reserve(&ioc->encoutput, responselen);
-    buffer_append(&ioc->encoutput, response, responselen);
+    qio_channel_websock_handshake_send_res(
+        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);
=20
+    g_free(date);
     g_free(accept);
-    g_free(response);
-
-    return 0;
 }
=20
-static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
-                                                 char *buffer,
-                                                 Error **errp)
+static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc=
,
+                                                  char *buffer,
+                                                  Error **errp)
 {
     QIOChannelWebsockHTTPHeader hdrs[32];
     size_t nhdrs =3D G_N_ELEMENTS(hdrs);
     const char *protocols =3D NULL, *version =3D NULL, *key =3D NULL,
         *host =3D NULL, *connection =3D NULL, *upgrade =3D NULL;
=20
-    nhdrs =3D qio_channel_websock_extract_headers(buffer, hdrs, nhdrs, e=
rrp);
+    nhdrs =3D qio_channel_websock_extract_headers(ioc, buffer, hdrs, nhd=
rs, errp);
     if (!nhdrs) {
-        return -1;
+        return;
     }
=20
     protocols =3D qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
     if (!protocols) {
         error_setg(errp, "Missing websocket protocol header data");
-        return -1;
+        goto bad_request;
     }
=20
     version =3D qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
     if (!version) {
         error_setg(errp, "Missing websocket version header data");
-        return -1;
+        goto bad_request;
     }
=20
     key =3D qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_KEY);
     if (!key) {
         error_setg(errp, "Missing websocket key header data");
-        return -1;
+        goto bad_request;
     }
=20
     host =3D qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_HOST);
     if (!host) {
         error_setg(errp, "Missing websocket host header data");
-        return -1;
+        goto bad_request;
     }
=20
     connection =3D qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_CONNECTION);
     if (!connection) {
         error_setg(errp, "Missing websocket connection header data");
-        return -1;
+        goto bad_request;
     }
=20
     upgrade =3D qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_UPGRADE);
     if (!upgrade) {
         error_setg(errp, "Missing websocket upgrade header data");
-        return -1;
+        goto bad_request;
     }
=20
     if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
         error_setg(errp, "No '%s' protocol is supported by client '%s'",
                    QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);
-        return -1;
+        goto bad_request;
     }
=20
     if (!g_str_equal(version, QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION)) {
         error_setg(errp, "Version '%s' is not supported by client '%s'",
                    QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION, version);
-        return -1;
+        goto bad_request;
     }
=20
     if (strlen(key) !=3D QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN) {
         error_setg(errp, "Key length '%zu' was not as expected '%d'",
                    strlen(key), QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN);
-        return -1;
+        goto bad_request;
     }
=20
     if (!g_strrstr(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE)) =
{
         error_setg(errp, "No connection upgrade requested '%s'", connect=
ion);
-        return -1;
+        goto bad_request;
     }
=20
     if (!g_str_equal(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET)) {
         error_setg(errp, "Incorrect upgrade method '%s'", upgrade);
-        return -1;
+        goto bad_request;
     }
=20
-    return qio_channel_websock_handshake_send_response(ioc, key, errp);
+    qio_channel_websock_handshake_send_res_ok(ioc, key, errp);
+    return;
+
+ bad_request:
+    qio_channel_websock_handshake_send_res_err(
+        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_BAD_REQUEST);
 }
=20
 static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
@@ -393,20 +470,20 @@ static int qio_channel_websock_handshake_read(QIOCh=
annelWebsock *ioc,
                                  QIO_CHANNEL_WEBSOCK_HANDSHAKE_END);
     if (!handshake_end) {
         if (ioc->encinput.offset >=3D 4096) {
+            qio_channel_websock_handshake_send_res_err(
+                ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_TOO_LARGE);
             error_setg(errp,
                        "End of headers not found in first 4096 bytes");
-            return -1;
+            return 1;
         } else {
             return 0;
         }
     }
     *handshake_end =3D '\0';
=20
-    if (qio_channel_websock_handshake_process(ioc,
-                                              (char *)ioc->encinput.buff=
er,
-                                              errp) < 0) {
-        return -1;
-    }
+    qio_channel_websock_handshake_process(ioc,
+                                          (char *)ioc->encinput.buffer,
+                                          errp);
=20
     buffer_advance(&ioc->encinput,
                    handshake_end - (char *)ioc->encinput.buffer +
@@ -438,8 +515,15 @@ static gboolean qio_channel_websock_handshake_send(Q=
IOChannel *ioc,
=20
     buffer_advance(&wioc->encoutput, ret);
     if (wioc->encoutput.offset =3D=3D 0) {
-        trace_qio_channel_websock_handshake_complete(ioc);
-        qio_task_complete(task);
+        if (wioc->io_err) {
+            trace_qio_channel_websock_handshake_fail(ioc);
+            qio_task_set_error(task, wioc->io_err);
+            wioc->io_err =3D NULL;
+            qio_task_complete(task);
+        } else {
+            trace_qio_channel_websock_handshake_complete(ioc);
+            qio_task_complete(task);
+        }
         return FALSE;
     }
     trace_qio_channel_websock_handshake_pending(ioc, G_IO_OUT);
@@ -458,6 +542,11 @@ static gboolean qio_channel_websock_handshake_io(QIO=
Channel *ioc,
=20
     ret =3D qio_channel_websock_handshake_read(wioc, &err);
     if (ret < 0) {
+        /*
+         * We only take this path on a fatal I/O error reading from
+         * client connection, as most of the time we have an
+         * HTTP 4xx err response to send instead
+         */
         trace_qio_channel_websock_handshake_fail(ioc);
         qio_task_set_error(task, err);
         qio_task_complete(task);
@@ -469,6 +558,10 @@ static gboolean qio_channel_websock_handshake_io(QIO=
Channel *ioc,
         return TRUE;
     }
=20
+    if (err) {
+        error_propagate(&wioc->io_err, err);
+    }
+
     trace_qio_channel_websock_handshake_reply(ioc);
     qio_channel_add_watch(
         wioc->master,
--=20
2.13.5
