Received: from eggs.gnu.org ([2001:4830:134:3::10]:40532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn18-0004mP-IO
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn17-00074I-Bn
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:26 -0400
Received: from mail-pg0-x230.google.com ([2607:f8b0:400e:c05::230]:37855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn17-00073q-44
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:25 -0400
Received: by mail-pg0-x230.google.com with SMTP id d8so21859635pgt.4
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 08:22:25 -0700 (PDT)
MIME-Version: 1.0
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Date: Tue, 12 Sep 2017 08:21:53 -0700
Message-Id: <20170912152153.7729-8-brandon.carpenter@cypherpath.com>
In-Reply-To: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
References: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH v3 7/7] io: Attempt to send websocket close
 messages to client
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

Make a best effort attempt to close websocket connections according to
the RFC. Sends the close message, as room permits in the socket buffer,
and immediately closes the socket.

Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
---
 io/channel-websock.c | 65 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index a29fee42d5..c50f8c6c50 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -122,6 +122,15 @@ enum {
     QIO_CHANNEL_WEBSOCK_OPCODE_PONG = 0xA
 };
 
+enum {
+    QIO_CHANNEL_WEBSOCK_STATUS_NORMAL = 1000,
+    QIO_CHANNEL_WEBSOCK_STATUS_PROTOCOL_ERR = 1002,
+    QIO_CHANNEL_WEBSOCK_STATUS_INVALID_DATA = 1003,
+    QIO_CHANNEL_WEBSOCK_STATUS_POLICY = 1008,
+    QIO_CHANNEL_WEBSOCK_STATUS_TOO_LARGE = 1009,
+    QIO_CHANNEL_WEBSOCK_STATUS_SERVER_ERR = 1011,
+};
+
 static size_t
 qio_channel_websock_extract_headers(char *buffer,
                                     QIOChannelWebsockHTTPHeader *hdrs,
@@ -523,6 +532,26 @@ static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
 }
 
 
+static ssize_t qio_channel_websock_write_wire(QIOChannelWebsock *, Error **);
+
+
+static void qio_channel_websock_write_close(QIOChannelWebsock *ioc,
+                                              uint16_t code, const char *reason)
+{
+    buffer_reserve(&ioc->rawoutput, 2 + (reason ? strlen(reason) : 0));
+    *(uint16_t *)(ioc->rawoutput.buffer + ioc->rawoutput.offset) = cpu_to_be16(code);
+    ioc->rawoutput.offset += 2;
+    if (reason) {
+        buffer_append(&ioc->rawoutput, reason, strlen(reason));
+    }
+    qio_channel_websock_encode_buffer(&ioc->encoutput,
+            QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE, &ioc->rawoutput);
+    buffer_reset(&ioc->rawoutput);
+    qio_channel_websock_write_wire(ioc, NULL);
+    qio_channel_shutdown(ioc->master, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+}
+
+
 static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
                                              Error **errp)
 {
@@ -536,6 +565,8 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
         error_setg(errp,
                    "Decoding header but %zu bytes of payload remain",
                    ioc->payload_remain);
+        qio_channel_websock_write_close(ioc,
+                QIO_CHANNEL_WEBSOCK_STATUS_SERVER_ERR, "internal server error");
         return -1;
     }
     if (ioc->encinput.offset < QIO_CHANNEL_WEBSOCK_HEADER_LEN_7_BIT) {
@@ -568,19 +599,29 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
     if (!fin) {
         if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
             error_setg(errp, "only binary websocket frames may be fragmented");
+            qio_channel_websock_write_close(ioc,
+                    QIO_CHANNEL_WEBSOCK_STATUS_POLICY ,
+                    "only binary frames may be fragmented");
             return -1;
         }
     } else {
         if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME &&
+                opcode != QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE &&
                 opcode != QIO_CHANNEL_WEBSOCK_OPCODE_PING &&
                 opcode != QIO_CHANNEL_WEBSOCK_OPCODE_PONG) {
-            error_setg(errp, "unsupported opcode: %#04x; only binary, ping, "
-                             "and pong websocket frames are supported", opcode);
+            error_setg(errp, "unsupported opcode: %#04x; only binary, close, "
+                       "ping, and pong websocket frames are supported", opcode);
+            qio_channel_websock_write_close(ioc,
+                    QIO_CHANNEL_WEBSOCK_STATUS_INVALID_DATA ,
+                    "only binary, close, ping, and pong frames are supported");
             return -1;
         }
     }
     if (!has_mask) {
         error_setg(errp, "client websocket frames must be masked");
+        qio_channel_websock_write_close(ioc,
+                QIO_CHANNEL_WEBSOCK_STATUS_PROTOCOL_ERR,
+                "client frames must be masked");
         return -1;
     }
 
@@ -590,6 +631,9 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
         ioc->mask = header->u.m;
     } else if (opcode & QIO_CHANNEL_WEBSOCK_CONTROL_OPCODE_MASK) {
         error_setg(errp, "websocket control frame is too large");
+        qio_channel_websock_write_close(ioc,
+                QIO_CHANNEL_WEBSOCK_STATUS_PROTOCOL_ERR,
+                "control frame is too large");
         return -1;
     } else if (payload_len == QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_MAGIC_16_BIT &&
                ioc->encinput.offset >= QIO_CHANNEL_WEBSOCK_HEADER_LEN_16_BIT) {
@@ -607,7 +651,7 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
     }
 
     buffer_advance(&ioc->encinput, header_size);
-    return 1;
+    return 0;
 }
 
 
@@ -657,6 +701,21 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
             buffer_reserve(&ioc->rawinput, payload_len);
             buffer_append(&ioc->rawinput, ioc->encinput.buffer, payload_len);
         }
+    } else if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE) {
+        /* close frames are echoed back */
+        error_setg(errp, "websocket closed by peer");
+        if (payload_len) {
+            /* echo client status */
+            qio_channel_websock_encode_buffer(&ioc->encoutput,
+                    QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE, &ioc->encinput);
+            qio_channel_websock_write_wire(ioc, NULL);
+            qio_channel_shutdown(ioc->master, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+        } else {
+            /* send our own status */
+            qio_channel_websock_write_close(ioc,
+                    QIO_CHANNEL_WEBSOCK_STATUS_NORMAL, "peer requested close");
+        }
+        return -1;
     } else if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_PING) {
         /* ping frames produce an immediate reply */
         buffer_reset(&ioc->ping_reply);
-- 
2.14.1


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
