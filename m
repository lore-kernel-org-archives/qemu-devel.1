Received: from eggs.gnu.org ([2001:4830:134:3::10]:40480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn12-0004jZ-Km
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn11-00070Q-5v
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:20 -0400
Received: from mail-pg0-x232.google.com ([2607:f8b0:400e:c05::232]:38468)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn10-0006zw-UA
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:19 -0400
Received: by mail-pg0-x232.google.com with SMTP id v66so21807360pgb.5
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 08:22:18 -0700 (PDT)
MIME-Version: 1.0
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Date: Tue, 12 Sep 2017 08:21:48 -0700
Message-Id: <20170912152153.7729-3-brandon.carpenter@cypherpath.com>
In-Reply-To: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
References: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH v3 2/7] io: Small updates in preparation for
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
Cc: berrange@redhat.com, brandon.carpenter@cypherpath.com

Gets rid of unnecessary bit shifting and performs proper EOF checking to
avoid a large number of repeated calls to recvmsg() when a client
abruptly terminates a connection (bug fix).

Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
---
 io/channel-websock.c | 62 +++++++++++++++-------------------------------------
 1 file changed, 18 insertions(+), 44 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 5a3badbec2..185bd31be5 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -86,8 +86,6 @@
 #define QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE 0x0f
 #define QIO_CHANNEL_WEBSOCK_HEADER_FIELD_HAS_MASK 0x80
 #define QIO_CHANNEL_WEBSOCK_HEADER_FIELD_PAYLOAD_LEN 0x7f
-#define QIO_CHANNEL_WEBSOCK_HEADER_SHIFT_FIN 7
-#define QIO_CHANNEL_WEBSOCK_HEADER_SHIFT_HAS_MASK 7
 
 typedef struct QIOChannelWebsockHeader QIOChannelWebsockHeader;
 
@@ -492,7 +490,7 @@ static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
         return;
     }
 
-    header.ws.b0 = (1 << QIO_CHANNEL_WEBSOCK_HEADER_SHIFT_FIN) |
+    header.ws.b0 = QIO_CHANNEL_WEBSOCK_HEADER_FIELD_FIN |
         (QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME &
          QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE);
     if (ioc->rawoutput.offset <
@@ -519,8 +517,8 @@ static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
 }
 
 
-static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
-                                                 Error **errp)
+static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
+                                             Error **errp)
 {
     unsigned char opcode, fin, has_mask;
     size_t header_size;
@@ -539,11 +537,9 @@ static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
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
@@ -561,7 +557,7 @@ static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
         return -1;
     }
     if (!has_mask) {
-        error_setg(errp, "websocket frames must be masked");
+        error_setg(errp, "client websocket frames must be masked");
         return -1;
     }
     if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
@@ -593,8 +589,8 @@ static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
 }
 
 
-static ssize_t qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
-                                                  Error **errp)
+static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
+                                              Error **errp)
 {
     size_t i;
     size_t payload_len;
@@ -635,7 +631,7 @@ static ssize_t qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
     buffer_reserve(&ioc->rawinput, payload_len);
     buffer_append(&ioc->rawinput, ioc->encinput.buffer, payload_len);
     buffer_advance(&ioc->encinput, payload_len);
-    return payload_len;
+    return 0;
 }
 
 
@@ -715,8 +711,8 @@ static ssize_t qio_channel_websock_read_wire(QIOChannelWebsock *ioc,
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
@@ -728,10 +724,6 @@ static ssize_t qio_channel_websock_read_wire(QIOChannelWebsock *ioc,
             if (ret < 0) {
                 return ret;
             }
-            if (ret == 0) {
-                ioc->io_eof = TRUE;
-                break;
-            }
         }
 
         ret = qio_channel_websock_decode_payload(ioc, errp);
@@ -996,14 +988,12 @@ struct QIOChannelWebsockSource {
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
@@ -1014,19 +1004,11 @@ qio_channel_websock_source_prepare(GSource *source,
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
@@ -1036,17 +1018,9 @@ qio_channel_websock_source_dispatch(GSource *source,
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
2.14.1


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
