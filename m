Received: from eggs.gnu.org ([2001:4830:134:3::10]:39610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duyMV-0002Lq-50
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1duyMR-0000oF-Uq
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:05:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1duyMR-0000ix-MW
	for qemu-devel@nongnu.org; Thu, 21 Sep 2017 06:05:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A73DA804E3
	for <qemu-devel@nongnu.org>; Thu, 21 Sep 2017 10:05:34 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 21 Sep 2017 11:05:29 +0100
Message-Id: <20170921100529.2462-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] io: add trace events for websockets frame
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It is useful to trace websockets frame encoding/decoding when debugging
problems.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 23 ++++++++++++++++++-----
 io/trace-events      |  5 +++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 3195eb2eb8..d1d471f86e 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -582,7 +582,8 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
 }
 
 
-static void qio_channel_websock_encode_buffer(Buffer *output,
+static void qio_channel_websock_encode_buffer(QIOChannelWebsock *ioc,
+                                              Buffer *output,
                                               uint8_t opcode, Buffer *buffer)
 {
     size_t header_size;
@@ -608,6 +609,7 @@ static void qio_channel_websock_encode_buffer(Buffer *output,
     }
     header_size -= QIO_CHANNEL_WEBSOCK_HEADER_LEN_MASK;
 
+    trace_qio_channel_websock_encode(ioc, opcode, header_size, buffer->offset);
     buffer_reserve(output, header_size + buffer->offset);
     buffer_append(output, header.buf, header_size);
     buffer_append(output, buffer->buffer, buffer->offset);
@@ -620,7 +622,7 @@ static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
         return;
     }
     qio_channel_websock_encode_buffer(
-        &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME,
+        ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME,
         &ioc->rawoutput);
     buffer_reset(&ioc->rawoutput);
 }
@@ -640,7 +642,8 @@ static void qio_channel_websock_write_close(QIOChannelWebsock *ioc,
         buffer_append(&ioc->rawoutput, reason, strlen(reason));
     }
     qio_channel_websock_encode_buffer(
-        &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE, &ioc->rawoutput);
+        ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE,
+        &ioc->rawoutput);
     buffer_reset(&ioc->rawoutput);
     qio_channel_websock_write_wire(ioc, NULL);
     qio_channel_shutdown(ioc->master, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
@@ -682,6 +685,9 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
         opcode = ioc->opcode;
     }
 
+    trace_qio_channel_websock_header_partial_decode(ioc, payload_len,
+                                                    fin, opcode, (int)has_mask);
+
     if (opcode == QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE) {
         /* disconnect */
         return 0;
@@ -746,6 +752,8 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
         return QIO_CHANNEL_ERR_BLOCK;
     }
 
+    trace_qio_channel_websock_header_full_decode(
+        ioc, header_size, ioc->payload_remain, ioc->mask.u);
     buffer_advance(&ioc->encinput, header_size);
     return 0;
 }
@@ -791,6 +799,9 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
         }
     }
 
+    trace_qio_channel_websock_payload_decode(
+        ioc, ioc->opcode, ioc->payload_remain);
+
     if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
         if (payload_len) {
             /* binary frames are passed on */
@@ -803,7 +814,7 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
         if (payload_len) {
             /* echo client status */
             qio_channel_websock_encode_buffer(
-                &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE,
+                ioc, &ioc->encoutput, QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE,
                 &ioc->encinput);
             qio_channel_websock_write_wire(ioc, NULL);
             qio_channel_shutdown(ioc->master, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
@@ -817,7 +828,8 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
         /* ping frames produce an immediate reply */
         buffer_reset(&ioc->ping_reply);
         qio_channel_websock_encode_buffer(
-            &ioc->ping_reply, QIO_CHANNEL_WEBSOCK_OPCODE_PONG, &ioc->encinput);
+            ioc, &ioc->ping_reply, QIO_CHANNEL_WEBSOCK_OPCODE_PONG,
+            &ioc->encinput);
     }   /* pong frames are ignored */
 
     if (payload_len) {
@@ -1176,6 +1188,7 @@ static int qio_channel_websock_close(QIOChannel *ioc,
 {
     QIOChannelWebsock *wioc = QIO_CHANNEL_WEBSOCK(ioc);
 
+    trace_qio_channel_websock_close(ioc);
     return qio_channel_close(wioc->master, errp);
 }
 
diff --git a/io/trace-events b/io/trace-events
index 6459f71f5b..801b5dcb61 100644
--- a/io/trace-events
+++ b/io/trace-events
@@ -48,6 +48,11 @@ qio_channel_websock_handshake_pending(void *ioc, int status) "Websock handshake
 qio_channel_websock_handshake_reply(void *ioc) "Websock handshake reply ioc=%p"
 qio_channel_websock_handshake_fail(void *ioc, const char *msg) "Websock handshake fail ioc=%p err=%s"
 qio_channel_websock_handshake_complete(void *ioc) "Websock handshake complete ioc=%p"
+qio_channel_websock_header_partial_decode(void *ioc, size_t payloadlen, unsigned char fin, unsigned char opcode, unsigned char has_mask) "Websocket header decoded ioc=%p payload-len=%zu fin=0x%x opcode=0x%x has_mask=0x%x"
+qio_channel_websock_header_full_decode(void *ioc, size_t headerlen, size_t payloadlen, uint32_t mask) "Websocket header decoded ioc=%p header-len=%zu payload-len=%zu mask=0x%x"
+qio_channel_websock_payload_decode(void *ioc, uint8_t opcode, size_t payload_remain) "Websocket header decoded ioc=%p opcode=0x%x payload-remain=%zu"
+qio_channel_websock_encode(void *ioc, uint8_t opcode, size_t payloadlen, size_t headerlen) "Websocket encoded ioc=%p opcode=0x%x header-len=%zu payload-len=%zu"
+qio_channel_websock_close(void *ioc) "Websocket close ioc=%p"
 
 # io/channel-command.c
 qio_channel_command_new_pid(void *ioc, int writefd, int readfd, int pid) "Command new pid ioc=%p writefd=%d readfd=%d pid=%d"
-- 
2.13.5
