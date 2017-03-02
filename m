Received: from eggs.gnu.org ([2001:4830:134:3::10]:49131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjTJV-00065w-Mf
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:10:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cjTJU-0008Tj-Be
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:10:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53056)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cjTJU-0008TR-2u
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 11:10:44 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu,  2 Mar 2017 16:10:33 +0000
Message-Id: <20170302161033.4787-4-berrange@redhat.com>
In-Reply-To: <20170302161033.4787-1-berrange@redhat.com>
References: <20170302161033.4787-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v2 3/3] io: fully parse & validate HTTP headers
 for websocket protocol handshake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>

The current websockets protocol handshake code is very relaxed, just
doing crude string searching across the HTTP header data. This causes
it to both reject valid connections and fail to reject invalid
connections. For example, according to the RFC 6455 it:

 - MUST reject any method other than "GET"
 - MUST reject any HTTP version less than "HTTP/1.1"
 - MUST reject Connection header without "Upgrade" listed
 - MUST reject Upgrade header which is not 'websocket'
 - MUST reject missing Host header
 - MUST treat HTTP header names as case insensitive

To do all this validation correctly requires that we fully parse the
HTTP headers, populating a data structure containing the header
fields.

After this change, we also reject any path other than '/'

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 236 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 194 insertions(+), 42 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index a06a4a8..8fabade 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -33,11 +33,16 @@
 #define QIO_CHANNEL_WEBSOCK_GUID "258EAFA5-E914-47DA-95CA-C5AB0DC85B11"
 #define QIO_CHANNEL_WEBSOCK_GUID_LEN strlen(QIO_CHANNEL_WEBSOCK_GUID)
 
-#define QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL "Sec-WebSocket-Protocol"
-#define QIO_CHANNEL_WEBSOCK_HEADER_VERSION "Sec-WebSocket-Version"
-#define QIO_CHANNEL_WEBSOCK_HEADER_KEY "Sec-WebSocket-Key"
+#define QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL "sec-websocket-protocol"
+#define QIO_CHANNEL_WEBSOCK_HEADER_VERSION "sec-websocket-version"
+#define QIO_CHANNEL_WEBSOCK_HEADER_KEY "sec-websocket-key"
+#define QIO_CHANNEL_WEBSOCK_HEADER_UPGRADE "upgrade"
+#define QIO_CHANNEL_WEBSOCK_HEADER_HOST "host"
+#define QIO_CHANNEL_WEBSOCK_HEADER_CONNECTION "connection"
 
 #define QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY "binary"
+#define QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE "Upgrade"
+#define QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET "websocket"
 
 #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_RESPONSE  \
     "HTTP/1.1 101 Switching Protocols\r\n"      \
@@ -49,6 +54,9 @@
 #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM "\r\n"
 #define QIO_CHANNEL_WEBSOCK_HANDSHAKE_END "\r\n\r\n"
 #define QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION "13"
+#define QIO_CHANNEL_WEBSOCK_HTTP_METHOD "GET"
+#define QIO_CHANNEL_WEBSOCK_HTTP_PATH "/"
+#define QIO_CHANNEL_WEBSOCK_HTTP_VERSION "HTTP/1.1"
 
 /* The websockets packet header is variable length
  * depending on the size of the payload... */
@@ -99,6 +107,13 @@ struct QEMU_PACKED QIOChannelWebsockHeader {
     } u;
 };
 
+typedef struct QIOChannelWebsockHTTPHeader QIOChannelWebsockHTTPHeader;
+
+struct QIOChannelWebsockHTTPHeader {
+    char *name;
+    char *value;
+};
+
 enum {
     QIO_CHANNEL_WEBSOCK_OPCODE_CONTINUATION = 0x0,
     QIO_CHANNEL_WEBSOCK_OPCODE_TEXT_FRAME = 0x1,
@@ -108,25 +123,130 @@ enum {
     QIO_CHANNEL_WEBSOCK_OPCODE_PONG = 0xA
 };
 
-static char *qio_channel_websock_handshake_entry(const char *handshake,
-                                                 size_t handshake_len,
-                                                 const char *name)
-{
-    char *begin, *end, *ret = NULL;
-    char *line = g_strdup_printf("%s%s: ",
-                                 QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM,
-                                 name);
-    begin = g_strstr_len(handshake, handshake_len, line);
-    if (begin != NULL) {
-        begin += strlen(line);
-        end = g_strstr_len(begin, handshake_len - (begin - handshake),
-                QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
-        if (end != NULL) {
-            ret = g_strndup(begin, end - begin);
+static size_t
+qio_channel_websock_extract_headers(char *buffer,
+                                    QIOChannelWebsockHTTPHeader *hdrs,
+                                    size_t nhdrsalloc,
+                                    Error **errp)
+{
+    char *nl, *sep, *tmp;
+    size_t nhdrs = 0;
+
+    /*
+     * First parse the HTTP protocol greeting of format:
+     *
+     *   $METHOD $PATH $VERSION
+     *
+     * e.g.
+     *
+     *   GET / HTTP/1.1
+     */
+
+    nl = strstr(buffer, QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
+    if (!nl) {
+        error_setg(errp, "Missing HTTP header delimiter");
+        return 0;
+    }
+    *nl = '\0';
+
+    tmp = strchr(buffer, ' ');
+    if (!tmp) {
+        error_setg(errp, "Missing HTTP path delimiter");
+        return 0;
+    }
+    *tmp = '\0';
+
+    if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_METHOD)) {
+        error_setg(errp, "Unsupported HTTP method %s", buffer);
+        return 0;
+    }
+
+    buffer = tmp + 1;
+    tmp = strchr(buffer, ' ');
+    if (!tmp) {
+        error_setg(errp, "Missing HTTP version delimiter");
+        return 0;
+    }
+    *tmp = '\0';
+
+    if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_PATH)) {
+        error_setg(errp, "Unexpected HTTP path %s", buffer);
+        return 0;
+    }
+
+    buffer = tmp + 1;
+
+    if (!g_str_equal(buffer, QIO_CHANNEL_WEBSOCK_HTTP_VERSION)) {
+        error_setg(errp, "Unsupported HTTP version %s", buffer);
+        return 0;
+    }
+
+    buffer = nl + strlen(QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
+
+    /*
+     * Now parse all the header fields of format
+     *
+     *   $NAME: $VALUE
+     *
+     * e.g.
+     *
+     *   Cache-control: no-cache
+     */
+    do {
+        QIOChannelWebsockHTTPHeader *hdr;
+
+        nl = strstr(buffer, QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
+        if (nl) {
+            *nl = '\0';
+        }
+
+        sep = strchr(buffer, ':');
+        if (!sep) {
+            error_setg(errp, "Malformed HTTP header");
+            return 0;
+        }
+        *sep = '\0';
+        sep++;
+        while (*sep == ' ') {
+            sep++;
+        }
+
+        if (nhdrs >= nhdrsalloc) {
+            error_setg(errp, "Too many HTTP headers");
+            return 0;
+        }
+
+        hdr = &hdrs[nhdrs++];
+        hdr->name = buffer;
+        hdr->value = sep;
+
+        /* Canonicalize header name for easier identification later */
+        for (tmp = hdr->name; *tmp; tmp++) {
+            *tmp = g_ascii_tolower(*tmp);
+        }
+
+        if (nl) {
+            buffer = nl + strlen(QIO_CHANNEL_WEBSOCK_HANDSHAKE_DELIM);
+        }
+    } while (nl != NULL);
+
+    return nhdrs;
+}
+
+static const char *
+qio_channel_websock_find_header(QIOChannelWebsockHTTPHeader *hdrs,
+                                size_t nhdrs,
+                                const char *name)
+{
+    size_t i;
+
+    for (i = 0; i < nhdrs; i++) {
+        if (g_str_equal(hdrs[i].name, name)) {
+            return hdrs[i].value;
         }
     }
-    g_free(line);
-    return ret;
+
+    return NULL;
 }
 
 
@@ -166,58 +286,90 @@ static int qio_channel_websock_handshake_send_response(QIOChannelWebsock *ioc,
 }
 
 static int qio_channel_websock_handshake_process(QIOChannelWebsock *ioc,
-                                                 const char *line,
-                                                 size_t size,
+                                                 char *buffer,
                                                  Error **errp)
 {
-    int ret = -1;
-    char *protocols = qio_channel_websock_handshake_entry(
-        line, size, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
-    char *version = qio_channel_websock_handshake_entry(
-        line, size, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
-    char *key = qio_channel_websock_handshake_entry(
-        line, size, QIO_CHANNEL_WEBSOCK_HEADER_KEY);
+    QIOChannelWebsockHTTPHeader hdrs[32];
+    size_t nhdrs = G_N_ELEMENTS(hdrs);
+    const char *protocols = NULL, *version = NULL, *key = NULL,
+        *host = NULL, *connection = NULL, *upgrade = NULL;
 
+    nhdrs = qio_channel_websock_extract_headers(buffer, hdrs, nhdrs, errp);
+    if (!nhdrs) {
+        return -1;
+    }
+
+    protocols = qio_channel_websock_find_header(
+        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_PROTOCOL);
     if (!protocols) {
         error_setg(errp, "Missing websocket protocol header data");
-        goto cleanup;
+        return -1;
     }
 
+    version = qio_channel_websock_find_header(
+        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_VERSION);
     if (!version) {
         error_setg(errp, "Missing websocket version header data");
-        goto cleanup;
+        return -1;
     }
 
+    key = qio_channel_websock_find_header(
+        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_KEY);
     if (!key) {
         error_setg(errp, "Missing websocket key header data");
-        goto cleanup;
+        return -1;
+    }
+
+    host = qio_channel_websock_find_header(
+        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_HOST);
+    if (!host) {
+        error_setg(errp, "Missing websocket host header data");
+        return -1;
+    }
+
+    connection = qio_channel_websock_find_header(
+        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_CONNECTION);
+    if (!connection) {
+        error_setg(errp, "Missing websocket connection header data");
+        return -1;
+    }
+
+    upgrade = qio_channel_websock_find_header(
+        hdrs, nhdrs, QIO_CHANNEL_WEBSOCK_HEADER_UPGRADE);
+    if (!upgrade) {
+        error_setg(errp, "Missing websocket upgrade header data");
+        return -1;
     }
 
     if (!g_strrstr(protocols, QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY)) {
         error_setg(errp, "No '%s' protocol is supported by client '%s'",
                    QIO_CHANNEL_WEBSOCK_PROTOCOL_BINARY, protocols);
-        goto cleanup;
+        return -1;
     }
 
     if (!g_str_equal(version, QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION)) {
         error_setg(errp, "Version '%s' is not supported by client '%s'",
                    QIO_CHANNEL_WEBSOCK_SUPPORTED_VERSION, version);
-        goto cleanup;
+        return -1;
     }
 
     if (strlen(key) != QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN) {
         error_setg(errp, "Key length '%zu' was not as expected '%d'",
                    strlen(key), QIO_CHANNEL_WEBSOCK_CLIENT_KEY_LEN);
-        goto cleanup;
+        return -1;
     }
 
-    ret = qio_channel_websock_handshake_send_response(ioc, key, errp);
+    if (!g_strrstr(connection, QIO_CHANNEL_WEBSOCK_CONNECTION_UPGRADE)) {
+        error_setg(errp, "No connection upgrade requested '%s'", connection);
+        return -1;
+    }
 
- cleanup:
-    g_free(protocols);
-    g_free(version);
-    g_free(key);
-    return ret;
+    if (!g_str_equal(upgrade, QIO_CHANNEL_WEBSOCK_UPGRADE_WEBSOCKET)) {
+        error_setg(errp, "Incorrect upgrade method '%s'", upgrade);
+        return -1;
+    }
+
+    return qio_channel_websock_handshake_send_response(ioc, key, errp);
 }
 
 static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
@@ -248,10 +400,10 @@ static int qio_channel_websock_handshake_read(QIOChannelWebsock *ioc,
             return 0;
         }
     }
+    *handshake_end = '\0';
 
     if (qio_channel_websock_handshake_process(ioc,
                                               (char *)ioc->encinput.buffer,
-                                              ioc->encinput.offset,
                                               errp) < 0) {
         return -1;
     }
-- 
2.9.3
