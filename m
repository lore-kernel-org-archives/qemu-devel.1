Received: from eggs.gnu.org ([2001:4830:134:3::10]:52915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dZiJO-0003ac-Fi
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dZiJJ-0004V7-GA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:42:34 -0400
Received: from mail-pf0-x235.google.com ([2607:f8b0:400e:c00::235]:34340)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dZiJJ-0004Ud-6I
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 14:42:29 -0400
Received: by mail-pf0-x235.google.com with SMTP id q85so50067383pfq.1
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 11:42:29 -0700 (PDT)
MIME-Version: 1.0
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Date: Mon, 24 Jul 2017 11:42:17 -0700
Message-Id: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH] io: Improve websocket support by becoming more
 RFC compliant.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, Brandon Carpenter <brandon.carpenter@cypherpath.com>

Remembering the opcode is sufficient for handling fragmented frames from
the client, which may be introduced by an intermediary server/proxy.
Respond to pings and ignore pongs rather than close the connection as
many browsers use ping/pong to test an idle connection. Close
connections according to the RFC, including providing reason code and
message to aid debugging of unexpected disconnects. Empty payloads
should not cause a disconnect.

Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
---
 include/io/channel-websock.h |   1 +
 io/channel-websock.c         | 243 ++++++++++++++++++++++++++++---------------
 2 files changed, 162 insertions(+), 82 deletions(-)

diff --git a/include/io/channel-websock.h b/include/io/channel-websock.h
index 3c9ff84727..7c896557c5 100644
--- a/include/io/channel-websock.h
+++ b/include/io/channel-websock.h
@@ -65,6 +65,7 @@ struct QIOChannelWebsock {
     guint io_tag;
     Error *io_err;
     gboolean io_eof;
+    uint8_t opcode;
 };
 
 /**
diff --git a/io/channel-websock.c b/io/channel-websock.c
index 5a3badbec2..45ac2605bb 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -86,8 +86,7 @@
 #define QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE 0x0f
 #define QIO_CHANNEL_WEBSOCK_HEADER_FIELD_HAS_MASK 0x80
 #define QIO_CHANNEL_WEBSOCK_HEADER_FIELD_PAYLOAD_LEN 0x7f
-#define QIO_CHANNEL_WEBSOCK_HEADER_SHIFT_FIN 7
-#define QIO_CHANNEL_WEBSOCK_HEADER_SHIFT_HAS_MASK 7
+#define QIO_CHANNEL_WEBSOCK_CONTROL_OPCODE_MASK 0x8
 
 typedef struct QIOChannelWebsockHeader QIOChannelWebsockHeader;
 
@@ -123,6 +122,15 @@ enum {
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
@@ -480,7 +488,8 @@ static gboolean qio_channel_websock_handshake_io(QIOChannel *ioc,
 }
 
 
-static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
+static void qio_channel_websock_encode_buffer(QIOChannelWebsock *ioc,
+                                              uint8_t opcode, Buffer *buffer)
 {
     size_t header_size;
     union {
@@ -488,39 +497,63 @@ static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
         QIOChannelWebsockHeader ws;
     } header;
 
-    if (!ioc->rawoutput.offset) {
-        return;
-    }
-
-    header.ws.b0 = (1 << QIO_CHANNEL_WEBSOCK_HEADER_SHIFT_FIN) |
-        (QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME &
-         QIO_CHANNEL_WEBSOCK_HEADER_FIELD_OPCODE);
-    if (ioc->rawoutput.offset <
+    header.ws.b0 = QIO_CHANNEL_WEBSOCK_HEADER_FIELD_FIN |
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
+    buffer_reserve(&ioc->encoutput, header_size + buffer->offset);
     buffer_append(&ioc->encoutput, header.buf, header_size);
-    buffer_append(&ioc->encoutput, ioc->rawoutput.buffer,
-                  ioc->rawoutput.offset);
+    buffer_append(&ioc->encoutput, buffer->buffer, buffer->offset);
+}
+
+
+static void qio_channel_websock_encode(QIOChannelWebsock *ioc)
+{
+    if (!ioc->rawoutput.offset) {
+        return;
+    }
+    qio_channel_websock_encode_buffer(ioc,
+            QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME, &ioc->rawoutput);
     buffer_reset(&ioc->rawoutput);
 }
 
 
-static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
-                                                 Error **errp)
+static ssize_t qio_channel_websock_write_wire(QIOChannelWebsock *, Error **);
+
+
+static void qio_channel_websock_write_close(QIOChannelWebsock *ioc,
+                                              uint16_t code, const char *reason)
+{
+    buffer_reserve(&ioc->rawoutput, 2 + (reason ? strlen(reason) : 0));
+    ioc->rawoutput.offset += 2;
+    *(uint16_t *)(ioc->rawoutput.buffer + ioc->rawoutput.offset) = cpu_to_be16(code);
+    if (reason) {
+        buffer_append(&ioc->rawoutput, reason, strlen(reason));
+    }
+    qio_channel_websock_encode_buffer(ioc,
+            QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE, &ioc->rawoutput);
+    buffer_reset(&ioc->rawoutput);
+    qio_channel_websock_write_wire(ioc, NULL);
+    qio_channel_shutdown(ioc->master, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+}
+
+
+static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
+                                             Error **errp)
 {
     unsigned char opcode, fin, has_mask;
     size_t header_size;
@@ -529,9 +562,10 @@ static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
         (QIOChannelWebsockHeader *)ioc->encinput.buffer;
 
     if (ioc->payload_remain) {
-        error_setg(errp,
-                   "Decoding header but %zu bytes of payload remain",
+        error_setg(errp, "Decoding header but %zu bytes of payload remain",
                    ioc->payload_remain);
+        qio_channel_websock_write_close(ioc,
+                QIO_CHANNEL_WEBSOCK_STATUS_SERVER_ERR, "internal server error");
         return -1;
     }
     if (ioc->encinput.offset < QIO_CHANNEL_WEBSOCK_HEADER_LEN_7_BIT) {
@@ -539,33 +573,49 @@ static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
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
 
-    if (opcode == QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE) {
-        /* disconnect */
-        return 0;
+    /* Save or restore opcode. */
+    if (opcode) {
+        ioc->opcode = opcode;
+    } else {
+        opcode = ioc->opcode;
     }
 
     /* Websocket frame sanity check:
-     * * Websocket fragmentation is not supported.
-     * * All  websockets frames sent by a client have to be masked.
-     * * Only binary encoding is supported.
+     * * Only binary and ping/pong encoding is supported.
+     * * Fragmentation is only allowed for binary frames.
+     * * All frames sent by a client MUST be masked.
      */
     if (!fin) {
-        error_setg(errp, "websocket fragmentation is not supported");
-        return -1;
+        if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
+            error_setg(errp, "only binary websocket frames may be fragmented");
+            qio_channel_websock_write_close(ioc,
+                    QIO_CHANNEL_WEBSOCK_STATUS_POLICY ,
+                    "only binary frames may be fragmented");
+            return -1;
+        }
+    } else {
+        if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME &&
+                opcode != QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE &&
+                opcode != QIO_CHANNEL_WEBSOCK_OPCODE_PING &&
+                opcode != QIO_CHANNEL_WEBSOCK_OPCODE_PONG) {
+            error_setg(errp, "unsupported opcode: %#04x; only binary, close, "
+                    "ping, and pong websocket frames are supported", opcode);
+            qio_channel_websock_write_close(ioc,
+                    QIO_CHANNEL_WEBSOCK_STATUS_INVALID_DATA ,
+                    "only binary, close, ping, and pong frames are supported");
+            return -1;
+        }
     }
     if (!has_mask) {
-        error_setg(errp, "websocket frames must be masked");
-        return -1;
-    }
-    if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
-        error_setg(errp, "only binary websocket frames are supported");
+        error_setg(errp, "client websocket frames must be masked");
+        qio_channel_websock_write_close(ioc,
+                QIO_CHANNEL_WEBSOCK_STATUS_PROTOCOL_ERR,
+                "client frames must be masked");
         return -1;
     }
 
@@ -573,6 +623,12 @@ static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
         ioc->payload_remain = payload_len;
         header_size = QIO_CHANNEL_WEBSOCK_HEADER_LEN_7_BIT;
         ioc->mask = header->u.m;
+    } else if (opcode & QIO_CHANNEL_WEBSOCK_CONTROL_OPCODE_MASK) {
+        error_setg(errp, "websocket control frame is too large");
+        qio_channel_websock_write_close(ioc,
+                QIO_CHANNEL_WEBSOCK_STATUS_PROTOCOL_ERR,
+                "control frame is too large");
+        return -1;
     } else if (payload_len == QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_MAGIC_16_BIT &&
                ioc->encinput.offset >= QIO_CHANNEL_WEBSOCK_HEADER_LEN_16_BIT) {
         ioc->payload_remain = be16_to_cpu(header->u.s16.l16);
@@ -589,53 +645,81 @@ static ssize_t qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
     }
 
     buffer_advance(&ioc->encinput, header_size);
-    return 1;
+    return 0;
 }
 
 
-static ssize_t qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
-                                                  Error **errp)
+static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
+                                              Error **errp)
 {
     size_t i;
-    size_t payload_len;
+    size_t payload_len = 0;
     uint32_t *payload32;
 
-    if (!ioc->payload_remain) {
-        error_setg(errp,
-                   "Decoding payload but no bytes of payload remain");
-        return -1;
-    }
+    if (ioc->payload_remain) {
+        /* If we aren't at the end of the payload, then drop
+         * off the last bytes, so we're always multiple of 4
+         * for purpose of unmasking, except at end of payload
+         */
+        if (ioc->encinput.offset < ioc->payload_remain) {
+            /* Wait for the entire payload before processing control frames
+             * because the payload will most likely be echoed back. */
+            if (ioc->opcode & QIO_CHANNEL_WEBSOCK_CONTROL_OPCODE_MASK) {
+                return QIO_CHANNEL_ERR_BLOCK;
+            }
+            payload_len = ioc->encinput.offset - (ioc->encinput.offset % 4);
+        } else {
+            payload_len = ioc->payload_remain;
+        }
+        if (payload_len == 0) {
+            return QIO_CHANNEL_ERR_BLOCK;
+        }
 
-    /* If we aren't at the end of the payload, then drop
-     * off the last bytes, so we're always multiple of 4
-     * for purpose of unmasking, except at end of payload
-     */
-    if (ioc->encinput.offset < ioc->payload_remain) {
-        payload_len = ioc->encinput.offset - (ioc->encinput.offset % 4);
-    } else {
-        payload_len = ioc->payload_remain;
-    }
-    if (payload_len == 0) {
-        return QIO_CHANNEL_ERR_BLOCK;
+        ioc->payload_remain -= payload_len;
+
+        /* unmask frame */
+        /* process 1 frame (32 bit op) */
+        payload32 = (uint32_t *)ioc->encinput.buffer;
+        for (i = 0; i < payload_len / 4; i++) {
+            payload32[i] ^= ioc->mask.u;
+        }
+        /* process the remaining bytes (if any) */
+        for (i *= 4; i < payload_len; i++) {
+            ioc->encinput.buffer[i] ^= ioc->mask.c[i % 4];
+        }
     }
 
-    ioc->payload_remain -= payload_len;
+    if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
+        if (payload_len) {
+            /* binary frames are passed on */
+            buffer_reserve(&ioc->rawinput, payload_len);
+            buffer_append(&ioc->rawinput, ioc->encinput.buffer, payload_len);
+        }
+    } else if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE) {
+        /* close frames are echoed back */
+        error_setg(errp, "websocket closed by peer");
+        if (payload_len) {
+            /* echo client status */
+            qio_channel_websock_encode_buffer(ioc,
+                    QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE, &ioc->encinput);
+            qio_channel_websock_write_wire(ioc, NULL);
+            qio_channel_shutdown(ioc->master, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
+        } else {
+            /* send our own status */
+            qio_channel_websock_write_close(ioc,
+                    QIO_CHANNEL_WEBSOCK_STATUS_NORMAL, "peer requested close");
+        }
+        return -1;
+    } else if (ioc->opcode == QIO_CHANNEL_WEBSOCK_OPCODE_PING) {
+        /* ping frames produce an immediate pong reply */
+        qio_channel_websock_encode_buffer(ioc,
+                QIO_CHANNEL_WEBSOCK_OPCODE_PONG, &ioc->encinput);
+    }   /* pong frames are ignored */
 
-    /* unmask frame */
-    /* process 1 frame (32 bit op) */
-    payload32 = (uint32_t *)ioc->encinput.buffer;
-    for (i = 0; i < payload_len / 4; i++) {
-        payload32[i] ^= ioc->mask.u;
+    if (payload_len) {
+        buffer_advance(&ioc->encinput, payload_len);
     }
-    /* process the remaining bytes (if any) */
-    for (i *= 4; i < payload_len; i++) {
-        ioc->encinput.buffer[i] ^= ioc->mask.c[i % 4];
-    }
-
-    buffer_reserve(&ioc->rawinput, payload_len);
-    buffer_append(&ioc->rawinput, ioc->encinput.buffer, payload_len);
-    buffer_advance(&ioc->encinput, payload_len);
-    return payload_len;
+    return 0;
 }
 
 
@@ -715,8 +799,7 @@ static ssize_t qio_channel_websock_read_wire(QIOChannelWebsock *ioc,
         if (ret < 0) {
             return ret;
         }
-        if (ret == 0 &&
-            ioc->encinput.offset == 0) {
+        if (ret == 0 && ioc->encinput.offset == 0) {
             return 0;
         }
         ioc->encinput.offset += ret;
@@ -725,17 +808,13 @@ static ssize_t qio_channel_websock_read_wire(QIOChannelWebsock *ioc,
     while (ioc->encinput.offset != 0) {
         if (ioc->payload_remain == 0) {
             ret = qio_channel_websock_decode_header(ioc, errp);
-            if (ret < 0) {
+            if (ret) {
                 return ret;
             }
-            if (ret == 0) {
-                ioc->io_eof = TRUE;
-                break;
-            }
         }
 
         ret = qio_channel_websock_decode_payload(ioc, errp);
-        if (ret < 0) {
+        if (ret) {
             return ret;
         }
     }
-- 
2.13.3


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
