Received: from eggs.gnu.org ([2001:4830:134:3::10]:55172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzijx-0002li-Lu
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzijw-0005R0-1X
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18403)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dzijv-0005PM-OS
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:27 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  4 Oct 2017 13:25:09 +0100
Message-Id: <20171004122515.20627-6-berrange@redhat.com>
In-Reply-To: <20171004122515.20627-1-berrange@redhat.com>
References: <20171004122515.20627-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 05/11] io: Small updates in preparation for
 websocket changes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Brandon Carpenter <brandon.carpenter@cypherpath.com>, "Daniel P . Berrange" <berrange@redhat.com>

From: Brandon Carpenter <brandon.carpenter@cypherpath.com>

Gets rid of unnecessary bit shifting and performs proper EOF checking to
avoid a large number of repeated calls to recvmsg() when a client
abruptly terminates a connection (bug fix).

Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 64 ++++++++++++++++------------------------------------
 1 file changed, 19 insertions(+), 45 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 2258557a21..4e5afb2e95 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -110,13 +110,11 @@
 /* Magic 7-bit length to indicate use of 64-bit payload length */
 #define QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_MAGIC_64_BIT 127
 
-/* Bitmasks & shifts for accessing header fields */
+/* Bitmasks for accessing header fields */
 #define QIO_CHANNEL_WEBSOCK_HEADER_FIELD_FIN 0x80
 #define QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE 0x0f
 #define QIO_CHANNEL_WEBSOCK_HEADER_FIELD_HAS_MASK 0x80
 #define QIO_CHANNEL_WEBSOCK_HEADER_FIELD_PAYLOAD_LEN 0x7f
-#define QIO_CHANNEL_WEBSOCK_HEADER_SHIFT_FIN 7
-#define QIO_CHANNEL_WEBSOCK_HEADER_SHIFT_HAS_MASK 7
 
 typedef struct QIOChannelWebsockHeader QIOChannelWebsockHeader;
 
@@ -586,7 +584,7 @@ static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
         return;
     }
 
-    header.ws.b0 = (1 << QIO_CHANNEL_WEBSOCK_HEADER_SHIFT_FIN) |
+    header.ws.b0 = QIO_CHANNEL_WEBSOCK_HEADER_FIELD_FIN |
         (QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME &
          QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE);
     if (ioc->rawoutput.offset <
@@ -613,8 +611,8 @@ static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
 }
 
 
-static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
-                                                 Error **errp)
+static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
+                                             Error **errp)
 {
     unsigned char opcode, fin, has_mask;
     size_t header_size;
@@ -633,11 +631,9 @@ static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
         return QIO_CHANNEL_ERR_BLOCK;
     }
 
-    fin = (header->b0 & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_FIN) >>
-        QIO_CHANNEL_WEBSOCK_HEADER_SHIFT_FIN;
+    fin = header->b0 & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_FIN;
     opcode = header->b0 & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE;
-    has_mask = (header->b1 & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_HAS_MASK) >>
-        QIO_CHANNEL_WEBSOCK_HEADER_SHIFT_HAS_MASK;
+    has_mask = header->b1 & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_HAS_MASK;
     payload_len = header->b1 & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_PAYLOAD_LEN;
 
     if (opcode == QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE) {
@@ -655,7 +651,7 @@ static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
         return -1;
     }
     if (!has_mask) {
-        error_setg(errp, "websocket frames must be masked");
+        error_setg(errp, "client websocket frames must be masked");
         return -1;
     }
     if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
@@ -687,8 +683,8 @@ static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
 }
 
 
-static ssize_t qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
-                                                  Error **errp)
+static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
+                                              Error **errp)
 {
     size_t i;
     size_t payload_len;
@@ -729,7 +725,7 @@ static ssize_t qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
     buffer_reserve(&ioc->rawinput, payload_len);
     buffer_append(&ioc->rawinput, ioc->encinput.buffer, payload_len);
     buffer_advance(&ioc->encinput, payload_len);
-    return payload_len;
+    return 0;
 }
 
 
@@ -809,8 +805,8 @@ static ssize_t qio_channel_websock_read_wire(QIOChannelWebsock *ioc,
         if (ret < 0) {
             return ret;
         }
-        if (ret == 0 &&
-            ioc->encinput.offset == 0) {
+        if (ret == 0 && ioc->encinput.offset == 0) {
+            ioc->io_eof = TRUE;
             return 0;
         }
         ioc->encinput.offset += ret;
@@ -822,10 +818,6 @@ static ssize_t qio_channel_websock_read_wire(QIOChannelWebsock *ioc,
             if (ret < 0) {
                 return ret;
             }
-            if (ret == 0) {
-                ioc->io_eof = TRUE;
-                break;
-            }
         }
 
         ret = qio_channel_websock_decode_payload(ioc, errp);
@@ -1090,14 +1082,12 @@ struct QIOChannelWebsockSource {
 };
 
 static gboolean
-qio_channel_websock_source_prepare(GSource *source,
-                                   gint *timeout)
+qio_channel_websock_source_check(GSource *source)
 {
     QIOChannelWebsockSource *wsource = (QIOChannelWebsockSource *)source;
     GIOCondition cond = 0;
-    *timeout = -1;
 
-    if (wsource->wioc->rawinput.offset) {
+    if (wsource->wioc->rawinput.offset || wsource->wioc->io_eof) {
         cond |= G_IO_IN;
     }
     if (wsource->wioc->rawoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
@@ -1108,19 +1098,11 @@ qio_channel_websock_source_prepare(GSource *source,
 }
 
 static gboolean
-qio_channel_websock_source_check(GSource *source)
+qio_channel_websock_source_prepare(GSource *source,
+                                   gint *timeout)
 {
-    QIOChannelWebsockSource *wsource = (QIOChannelWebsockSource *)source;
-    GIOCondition cond = 0;
-
-    if (wsource->wioc->rawinput.offset) {
-        cond |= G_IO_IN;
-    }
-    if (wsource->wioc->rawoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
-        cond |= G_IO_OUT;
-    }
-
-    return cond & wsource->condition;
+    *timeout = -1;
+    return qio_channel_websock_source_check(source);
 }
 
 static gboolean
@@ -1130,17 +1112,9 @@ qio_channel_websock_source_dispatch(GSource *source,
 {
     QIOChannelFunc func = (QIOChannelFunc)callback;
     QIOChannelWebsockSource *wsource = (QIOChannelWebsockSource *)source;
-    GIOCondition cond = 0;
-
-    if (wsource->wioc->rawinput.offset) {
-        cond |= G_IO_IN;
-    }
-    if (wsource->wioc->rawoutput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER) {
-        cond |= G_IO_OUT;
-    }
 
     return (*func)(QIO_CHANNEL(wsource->wioc),
-                   (cond & wsource->condition),
+                   qio_channel_websock_source_check(source),
                    user_data);
 }
 
-- 
2.13.5
