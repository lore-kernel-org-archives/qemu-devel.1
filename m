Received: from eggs.gnu.org ([2001:4830:134:3::10]:47617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1whB-0002eu-1D
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1e1wh7-00034x-VW
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43252)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1e1wh7-00033m-Mx
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 11:43:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B4AAC81245
	for <qemu-devel@nongnu.org>; Tue, 10 Oct 2017 15:43:44 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 10 Oct 2017 16:43:25 +0100
Message-Id: <20171010154328.8419-5-berrange@redhat.com>
In-Reply-To: <20171010154328.8419-1-berrange@redhat.com>
References: <20171010154328.8419-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 4/7] io: pass a struct iovec into
 qio_channel_websock_encode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Instead of requiring use of another Buffer, pass a struct iovec
into qio_channel_websock_encode, which gives callers more
flexibility in how they process data.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 69 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 42 insertions(+), 27 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 17f50f5bb1..ad62dda479 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -582,11 +582,14 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
 }
 
 
-static void qio_channel_websock_encode_buffer(QIOChannelWebsock *ioc,
-                                              Buffer *output,
-                                              uint8_t opcode, Buffer *buffer)
+static void qio_channel_websock_encode(QIOChannelWebsock *ioc,
+                                       uint8_t opcode,
+                                       const struct iovec *iov,
+                                       size_t niov,
+                                       size_t size)
 {
     size_t header_size;
+    size_t i;
     union {
         char buf[QIO_CHANNEL_WEBSOCK_HEADER_LEN_64_BIT];
         QIOChannelWebsockHeader ws;
@@ -594,25 +597,31 @@ static void qio_channel_websock_encode_buffer(QIOChannelWebsock *ioc,
 
     header.ws.b0 = QIO_CHANNEL_WEBSOCK_HEADER_FIELD_FIN |
         (opcode & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE);
-    if (buffer->offset < QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_THRESHOLD_7_BIT) {
-        header.ws.b1 = (uint8_t)buffer->offset;
+    if (size < QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_THRESHOLD_7_BIT) {
+        header.ws.b1 = (uint8_t)size;
         header_size = QIO_CHANNEL_WEBSOCK_HEADER_LEN_7_BIT;
-    } else if (buffer->offset <
-               QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_THRESHOLD_16_BIT) {
+    } else if (size < QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_THRESHOLD_16_BIT) {
         header.ws.b1 = QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_MAGIC_16_BIT;
-        header.ws.u.s16.l16 = cpu_to_be16((uint16_t)buffer->offset);
+        header.ws.u.s16.l16 = cpu_to_be16((uint16_t)size);
         header_size = QIO_CHANNEL_WEBSOCK_HEADER_LEN_16_BIT;
     } else {
         header.ws.b1 = QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_MAGIC_64_BIT;
-        header.ws.u.s64.l64 = cpu_to_be64(buffer->offset);
+        header.ws.u.s64.l64 = cpu_to_be64(size);
         header_size = QIO_CHANNEL_WEBSOCK_HEADER_LEN_64_BIT;
     }
     header_size -= QIO_CHANNEL_WEBSOCK_HEADER_LEN_MASK;
 
-    trace_qio_channel_websock_encode(ioc, opcode, header_size, buffer->offset);
-    buffer_reserve(output, header_size + buffer->offset);
-    buffer_append(output, header.buf, header_size);
-    buffer_append(output, buffer->buffer, buffer->offset);
+    trace_qio_channel_websock_encode(ioc, opcode, header_size, size);
+    buffer_reserve(&ioc->encoutput, header_size + size);
+    buffer_append(&ioc->encoutput, header.buf, header_size);
+    for (i = 0; i < niov && size != 0; i++) {
+        size_t want = iov->iov_len;
+        if (want > size) {
+            want = size;
+        }
+        buffer_append(&ioc->encoutput, iov->iov_base, want);
+        size -= want;
+    }
 }
 
 
@@ -622,6 +631,7 @@ static ssize_t qio_channel_websock_write_wire(QIOChannelWebsock *, Error **);
 static void qio_channel_websock_write_close(QIOChannelWebsock *ioc,
                                             uint16_t code, const char *reason)
 {
+    struct iovec iov;
     buffer_reserve(&ioc->rawoutput, 2 + (reason ? strlen(reason) : 0));
     *(uint16_t *)(ioc->rawoutput.buffer + ioc->rawoutput.offset) =
         cpu_to_be16(code);
@@ -629,9 +639,10 @@ static void qio_channel_websock_write_close(QIOChannelWebsock *ioc,
     if (reason) {
         buffer_append(&ioc->rawoutput, reason, strlen(reason));
     }
-    qio_channel_websock_encode_buffer(
-        ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE,
-        &ioc->rawoutput);
+    iov.iov_base = ioc->rawoutput.buffer;
+    iov.iov_len = ioc->rawoutput.offset;
+    qio_channel_websock_encode(ioc, QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE,
+                               &iov, 1, iov.iov_len);
     buffer_reset(&ioc->rawoutput);
     qio_channel_websock_write_wire(ioc, NULL);
     qio_channel_shutdown(ioc->master, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
@@ -801,9 +812,10 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
         error_setg(errp, "websocket closed by peer");
         if (payload_len) {
             /* echo client status */
-            qio_channel_websock_encode_buffer(
-                ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE,
-                &ioc->encinput);
+            struct iovec iov = { .iov_base = ioc->encinput.buffer,
+                                 .iov_len = ioc->encinput.offset };
+            qio_channel_websock_encode(ioc, QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE,
+                                       &iov, 1, iov.iov_len);
             qio_channel_websock_write_wire(ioc, NULL);
             qio_channel_shutdown(ioc->master, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
         } else {
@@ -816,9 +828,10 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
         /* ping frames produce an immediate reply, as long as we've not still
          * got a previous ping queued, in which case we drop the new pong */
         if (ioc->ping_remain == 0) {
-            qio_channel_websock_encode_buffer(
-                ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_PONG,
-                &ioc->encinput);
+            struct iovec iov = { .iov_base = ioc->encinput.buffer,
+                                 .iov_len = ioc->encinput.offset };
+            qio_channel_websock_encode(ioc, QIO_CHANNEL_WEBSOCK_OPCODE_PONG,
+                                       &iov, 1, iov.iov_len);
             ioc->ping_remain = ioc->encoutput.offset;
         }
     }   /* pong frames are ignored */
@@ -1120,11 +1133,13 @@ static ssize_t qio_channel_websock_writev(QIOChannel *ioc,
     }
 
  done:
-    if (ioc->rawoutput.offset) {
-        qio_channel_websock_encode_buffer(
-            ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME,
-            &ioc->rawoutput);
-        buffer_reset(&ioc->rawoutput);
+    if (wioc->rawoutput.offset) {
+        struct iovec iov = { .iov_base = wioc->rawoutput.buffer,
+                             .iov_len = wioc->rawoutput.offset };
+        qio_channel_websock_encode(wioc,
+                                   QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME,
+                                   &iov, 1, iov.iov_len);
+        buffer_reset(&wioc->rawoutput);
     }
     ret = qio_channel_websock_write_wire(wioc, errp);
     if (ret < 0 &&
-- 
2.13.5
