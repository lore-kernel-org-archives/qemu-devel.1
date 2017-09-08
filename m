Received: from eggs.gnu.org ([2001:4830:134:3::10]:56311)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqGYK-0005Zx-8B
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dqGYE-0006bh-PY
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dqGYE-0006bI-GB
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 06:30:18 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  8 Sep 2017 11:30:09 +0100
Message-Id: <20170908103011.25821-2-berrange@redhat.com>
In-Reply-To: <20170908103011.25821-1-berrange@redhat.com>
References: <20170908103011.25821-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/3] io: send proper HTTP response for
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

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 181 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 135 insertions(+), 46 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 5a3badbec2..24920c78df 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -44,13 +44,40 @@
 #define QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE "Upgrade"
 #define QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET "websocket"
 
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
@@ -123,8 +150,44 @@ enum {
     QIO_CHANNEL_WEBSOCK_OPCODE_PONG = 0xA
 };
 
+static void qio_channel_websock_handshake_send_res(QIOChannelWebsock *ioc,
+                                                   const char *resmsg,
+                                                   ...)
+{
+    va_list vargs;
+    char *response;
+    size_t responselen;
+
+    va_start(vargs, resmsg);
+    response = g_strdup_vprintf(resmsg, vargs);
+    responselen = strlen(response);
+    buffer_reserve(&ioc->encoutput, responselen);
+    buffer_append(&ioc->encoutput, response, responselen);
+    va_end(vargs);
+}
+
+static gchar *qio_channel_websock_date_str(void)
+{
+    GTimeZone *utc = g_time_zone_new_utc();
+    GDateTime *now = g_date_time_new_now(utc);
+    gchar *ret = g_date_time_format(now, "%a, %d %b %Y %H:%M:%S GMT");
+    g_assert(ret);
+    g_date_time_unref(now);
+    g_time_zone_unref(utc);
+    return ret;
+}
+
+static void qio_channel_websock_handshake_send_res_err(QIOChannelWebsock *ioc,
+                                                       const char *resdata)
+{
+    char *date = qio_channel_websock_date_str();
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
@@ -145,7 +208,7 @@ qio_channel_websock_extract_headers(char *buffer,
     nl = strstr(buffer, QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
     if (!nl) {
         error_setg(errp, "Missing HTTP header delimiter");
-        return 0;
+        goto bad_request;
     }
     *nl = '\0';
 
@@ -158,18 +221,20 @@ qio_channel_websock_extract_headers(char *buffer,
 
     if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_METHOD)) {
         error_setg(errp, "Unsupported HTTP method %s", buffer);
-        return 0;
+        goto bad_request;
     }
 
     buffer = tmp + 1;
     tmp = strchr(buffer, ' ');
     if (!tmp) {
         error_setg(errp, "Missing HTTP version delimiter");
-        return 0;
+        goto bad_request;
     }
     *tmp = '\0';
 
     if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_PATH)) {
+        qio_channel_websock_handshake_send_res_err(
+            ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_NOT_FOUND);
         error_setg(errp, "Unexpected HTTP path %s", buffer);
         return 0;
     }
@@ -178,7 +243,7 @@ qio_channel_websock_extract_headers(char *buffer,
 
     if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_VERSION)) {
         error_setg(errp, "Unsupported HTTP version %s", buffer);
-        return 0;
+        goto bad_request;
     }
 
     buffer = nl + strlen(QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
@@ -203,7 +268,7 @@ qio_channel_websock_extract_headers(char *buffer,
         sep = strchr(buffer, ':');
         if (!sep) {
             error_setg(errp, "Malformed HTTP header");
-            return 0;
+            goto bad_request;
         }
         *sep = '\0';
         sep++;
@@ -213,7 +278,7 @@ qio_channel_websock_extract_headers(char *buffer,
 
         if (nhdrs >= nhdrsalloc) {
             error_setg(errp, "Too many HTTP headers");
-            return 0;
+            goto bad_request;
         }
 
         hdr = &hdrs[nhdrs++];
@@ -231,6 +296,11 @@ qio_channel_websock_extract_headers(char *buffer,
     } while (nl != NULL);
 
     return nhdrs;
+
+ bad_request:
+    qio_channel_websock_handshake_send_res_err(
+        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_BAD_REQUEST);
+    return 0;
 }
 
 static const char *
@@ -250,14 +320,14 @@ qio_channel_websock_find_header(QIOChannelWebsockHTTPHeader *hdrs,
 }
 
 
-static int qio_channel_websock_handshake_send_response(QIOChannelWebsock *ioc,
-                                                       const char *key,
-                                                       Error **errp)
+static void qio_channel_websock_handshake_send_res_ok(QIOChannelWebsock *ioc,
+                                                      const char *key,
+                                                      Error **errp)
 {
     char combined_key[QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN +
                       QIO_CHANNEL_WEBSOCK_GUID_LEN + 1];
-    char *accept = NULL, *response = NULL;
-    size_t responselen;
+    char *accept = NULL;
+    char *date = qio_channel_websock_date_str();
 
     g_strlcpy(combined_key, key, QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN + 1);
     g_strlcat(combined_key, QIO_CHANNEL_WEBSOCK_GUID,
@@ -271,105 +341,108 @@ static int qio_channel_websock_handshake_send_response(QIOChannelWebsock *ioc,
                             QIO_CHANNEL_WEBSOCK_GUID_LEN,
                             &accept,
                             errp) < 0) {
-        return -1;
+        qio_channel_websock_handshake_send_res_err(
+            ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_SERVER_ERR);
+        return;
     }
 
-    response = g_strdup_printf(QIO_CHANNEL_WEBSOCK_HANDSHAKE_RESPONSE, accept);
-    responselen = strlen(response);
-    buffer_reserve(&ioc->encoutput, responselen);
-    buffer_append(&ioc->encoutput, response, responselen);
+    qio_channel_websock_handshake_send_res(
+        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_OK, date, accept);
 
+    g_free(date);
     g_free(accept);
-    g_free(response);
-
-    return 0;
 }
 
-static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
-                                                 char *buffer,
-                                                 Error **errp)
+static void qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
+                                                  char *buffer,
+                                                  Error **errp)
 {
     QIOChannelWebsockHTTPHeader hdrs[32];
     size_t nhdrs = G_N_ELEMENTS(hdrs);
     const char *protocols = NULL, *version = NULL, *key = NULL,
         *host = NULL, *connection = NULL, *upgrade = NULL;
 
-    nhdrs = qio_channel_websock_extract_headers(buffer, hdrs, nhdrs, errp);
+    nhdrs = qio_channel_websock_extract_headers(ioc, buffer, hdrs, nhdrs, errp);
     if (!nhdrs) {
-        return -1;
+        return;
     }
 
     protocols = qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
     if (!protocols) {
         error_setg(errp, "Missing websocket protocol header data");
-        return -1;
+        goto bad_request;
     }
 
     version = qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
     if (!version) {
         error_setg(errp, "Missing websocket version header data");
-        return -1;
+        goto bad_request;
     }
 
     key = qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_KEY);
     if (!key) {
         error_setg(errp, "Missing websocket key header data");
-        return -1;
+        goto bad_request;
     }
 
     host = qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_HOST);
     if (!host) {
         error_setg(errp, "Missing websocket host header data");
-        return -1;
+        goto bad_request;
     }
 
     connection = qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_CONNECTION);
     if (!connection) {
         error_setg(errp, "Missing websocket connection header data");
-        return -1;
+        goto bad_request;
     }
 
     upgrade = qio_channel_websock_find_header(
         hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_UPGRADE);
     if (!upgrade) {
         error_setg(errp, "Missing websocket upgrade header data");
-        return -1;
+        goto bad_request;
     }
 
     if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
         error_setg(errp, "No '%s' protocol is supported by client '%s'",
                    QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);
-        return -1;
+        goto bad_request;
     }
 
     if (!g_str_equal(version, QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION)) {
         error_setg(errp, "Version '%s' is not supported by client '%s'",
                    QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION, version);
-        return -1;
+        goto bad_request;
     }
 
     if (strlen(key) != QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN) {
         error_setg(errp, "Key length '%zu' was not as expected '%d'",
                    strlen(key), QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN);
-        return -1;
+        goto bad_request;
     }
 
     if (!g_strrstr(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE)) {
         error_setg(errp, "No connection upgrade requested '%s'", connection);
-        return -1;
+        goto bad_request;
     }
 
     if (!g_str_equal(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET)) {
         error_setg(errp, "Incorrect upgrade method '%s'", upgrade);
-        return -1;
+        goto bad_request;
     }
 
-    return qio_channel_websock_handshake_send_response(ioc, key, errp);
+    qio_channel_websock_handshake_send_res_ok(ioc, key, errp);
+    return;
+
+ bad_request:
+    qio_channel_websock_handshake_send_res_err(
+        ioc, QIO_CHANNEL_WEBSOCK_HANDSHAKE_RES_BAD_REQUEST);
 }
 
 static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
@@ -393,20 +466,20 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
                                  QIO_CHANNEL_WEBSOCK_HANDSHAKE_END);
     if (!handshake_end) {
         if (ioc->encinput.offset >= 4096) {
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
     *handshake_end = '\0';
 
-    if (qio_channel_websock_handshake_process(ioc,
-                                              (char *)ioc->encinput.buffer,
-                                              errp) < 0) {
-        return -1;
-    }
+    qio_channel_websock_handshake_process(ioc,
+                                          (char *)ioc->encinput.buffer,
+                                          errp);
 
     buffer_advance(&ioc->encinput,
                    handshake_end - (char *)ioc->encinput.buffer +
@@ -438,8 +511,15 @@ static gboolean qio_channel_websock_handshake_send(QIOChannel *ioc,
 
     buffer_advance(&wioc->encoutput, ret);
     if (wioc->encoutput.offset == 0) {
-        trace_qio_channel_websock_handshake_complete(ioc);
-        qio_task_complete(task);
+        if (wioc->io_err) {
+            trace_qio_channel_websock_handshake_fail(ioc);
+            qio_task_set_error(task, wioc->io_err);
+            wioc->io_err = NULL;
+            qio_task_complete(task);
+        } else {
+            trace_qio_channel_websock_handshake_complete(ioc);
+            qio_task_complete(task);
+        }
         return FALSE;
     }
     trace_qio_channel_websock_handshake_pending(ioc, G_IO_OUT);
@@ -458,6 +538,11 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
 
     ret = qio_channel_websock_handshake_read(wioc, &err);
     if (ret < 0) {
+        /*
+         * We only take this path on a fatal I/O error reading from
+         * client connection, as most of the time we have an
+         * HTTP 4xx err response to send instead
+         */
         trace_qio_channel_websock_handshake_fail(ioc);
         qio_task_set_error(task, err);
         qio_task_complete(task);
@@ -469,6 +554,10 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
         return TRUE;
     }
 
+    if (err) {
+        error_propagate(&wioc->io_err, err);
+    }
+
     trace_qio_channel_websock_handshake_reply(ioc);
     qio_channel_add_watch(
         wioc->master,
-- 
2.13.5
