Received: from eggs.gnu.org ([2001:4830:134:3::10]:40550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn1A-0004pD-NB
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn16-00073e-91
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:28 -0400
Received: from mail-pg0-x234.google.com ([2607:f8b0:400e:c05::234]:33058)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn16-00073F-0E
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:24 -0400
Received: by mail-pg0-x234.google.com with SMTP id u18so5254648pgo.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 08:22:23 -0700 (PDT)
MIME-Version: 1.0
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Date: Tue, 12 Sep 2017 08:21:52 -0700
Message-Id: <20170912152153.7729-7-brandon.carpenter@cypherpath.com>
In-Reply-To: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
References: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH v3 6/7] io: Reply to ping frames
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

Add an immediate ping reply (pong) to the outgoing stream when a ping
is received. Unsolicited pongs are ignored.

Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
---
 include/io/channel-websock.h |  1 +
 io/channel-websock.c         | 64 +++++++++++++++++++++++++++++---------------
 2 files changed, 44 insertions(+), 21 deletions(-)

diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
index 7c896557c5..ff32d8651b 100644
--- a/include/io/channel-websock.h
+++ b/include/io/channel-websock.h
@@ -60,6 +60,7 @@ struct QIOChannelWebsock {
     Buffer encoutput;
     Buffer rawinput;
     Buffer rawoutput;
+    Buffer ping_reply;
     size_t payload_remain;
     QIOChannelWebsockMask mask;
     guint io_tag;
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 50387050d5..a29fee42d5 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -479,7 +479,8 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
 }
 
 
-static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
+static void qio_channel_websock_encode_buffer(Buffer *output,
+                                              uint8_t opcode, Buffer *buffer)
 {
     size_t header_size;
     union {
@@ -487,33 +488,37 @@ static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
         QIOChannelWebsockHeader ws;
     } header;
 
-    if (!ioc->rawoutput.offset) {
-        return;
-    }
-
     header.ws.b0 = QIO_CHANNEL_WEBSOCK_HEADER_FIELD_FIN |
-        (QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME &
-         QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE);
-    if (ioc->rawoutput.offset <
+        (opcode & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE);
+    if (buffer->offset <
         QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_THRESHOLD_7_BIT) {
-        header.ws.b1 = (uint8_t)ioc->rawoutput.offset;
+        header.ws.b1 = (uint8_t)buffer->offset;
         header_size = QIO_CHANNEL_WEBSOCK_HEADER_LEN_7_BIT;
-    } else if (ioc->rawoutput.offset <
+    } else if (buffer->offset <
                QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_THRESHOLD_16_BIT) {
         header.ws.b1 = QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_MAGIC_16_BIT;
-        header.ws.u.s16.l16 = cpu_to_be16((uint16_t)ioc->rawoutput.offset);
+        header.ws.u.s16.l16 = cpu_to_be16((uint16_t)buffer->offset);
         header_size = QIO_CHANNEL_WEBSOCK_HEADER_LEN_16_BIT;
     } else {
         header.ws.b1 = QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_MAGIC_64_BIT;
-        header.ws.u.s64.l64 = cpu_to_be64(ioc->rawoutput.offset);
+        header.ws.u.s64.l64 = cpu_to_be64(buffer->offset);
         header_size = QIO_CHANNEL_WEBSOCK_HEADER_LEN_64_BIT;
     }
     header_size -= QIO_CHANNEL_WEBSOCK_HEADER_LEN_MASK;
 
-    buffer_reserve(&ioc->encoutput, header_size + ioc->rawoutput.offset);
-    buffer_append(&ioc->encoutput, header.buf, header_size);
-    buffer_append(&ioc->encoutput, ioc->rawoutput.buffer,
-                  ioc->rawoutput.offset);
+    buffer_reserve(output, header_size + buffer->offset);
+    buffer_append(output, header.buf, header_size);
+    buffer_append(output, buffer->buffer, buffer->offset);
+}
+
+
+static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
+{
+    if (!ioc->rawoutput.offset) {
+        return;
+    }
+    qio_channel_websock_encode_buffer(&ioc->encoutput,
+            QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME, &ioc->rawoutput);
     buffer_reset(&ioc->rawoutput);
 }
 
@@ -558,7 +563,7 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
     /* Websocket frame sanity check:
      * * Fragmentation is only supported for binary frames.
      * * All frames sent by a client MUST be masked.
-     * * Only binary encoding is supported.
+     * * Only binary and ping/pong encoding is supported.
      */
     if (!fin) {
         if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
@@ -619,6 +624,11 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
          * for purpose of unmasking, except at end of payload
          */
         if (ioc->encinput.offset < ioc->payload_remain) {
+            /* Wait for the entire payload before processing control frames
+             * because the payload will most likely be echoed back. */
+            if (ioc->opcode & QIO_CHANNEL_WEBSOCK_CONTROL_OPCODE_MASK) {
+                return QIO_CHANNEL_ERR_BLOCK;
+            }
             payload_len = ioc->encinput.offset - (ioc->encinput.offset % 4);
         } else {
             payload_len = ioc->payload_remain;
@@ -641,13 +651,18 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
         }
     }
 
-    /* Drop the payload of ping/pong packets */
     if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
         if (payload_len) {
+            /* binary frames are passed on */
             buffer_reserve(&ioc->rawinput, payload_len);
             buffer_append(&ioc->rawinput, ioc->encinput.buffer, payload_len);
         }
-    }
+    } else if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_PING) {
+        /* ping frames produce an immediate reply */
+        buffer_reset(&ioc->ping_reply);
+        qio_channel_websock_encode_buffer(&ioc->ping_reply,
+                QIO_CHANNEL_WEBSOCK_OPCODE_PONG, &ioc->encinput);
+    }   /* pong frames are ignored */
 
     if (payload_len) {
         buffer_advance(&ioc->encinput, payload_len);
@@ -705,6 +720,7 @@ static void qio_channel_websock_finalize(Object *obj)
     buffer_free(&ioc->encoutput);
     buffer_free(&ioc->rawinput);
     buffer_free(&ioc->rawoutput);
+    buffer_free(&ioc->ping_reply);
     object_unref(OBJECT(ioc->master));
     if (ioc->io_tag) {
         g_source_remove(ioc->io_tag);
@@ -761,7 +777,13 @@ static ssize_t qio_channel_websock_write_wire(QIOChannelWebsock *ioc,
 {
     ssize_t ret;
     ssize_t done = 0;
-    qio_channel_websock_encode(ioc);
+
+    /* ping replies take priority over binary data */
+    if (!ioc->ping_reply.offset) {
+        qio_channel_websock_encode(ioc);
+    } else if (!ioc->encoutput.offset) {
+        buffer_move_empty(&ioc->encoutput, &ioc->ping_reply);
+    }
 
     while (ioc->encoutput.offset > 0) {
         ret = qio_channel_write(ioc->master,
@@ -836,7 +858,7 @@ static void qio_channel_websock_set_watch(QIOChannelWebsock *ioc)
         return;
     }
 
-    if (ioc->encoutput.offset) {
+    if (ioc->encoutput.offset || ioc->ping_reply.offset) {
         cond |= G_IO_OUT;
     }
     if (ioc->encinput.offset < QIO_CHANNEL_WEBSOCK_MAX_BUFFER &&
-- 
2.14.1


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
