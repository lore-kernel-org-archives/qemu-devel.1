Received: from eggs.gnu.org ([2001:4830:134:3::10]:55195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzik1-0002p4-24
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzijx-0005T7-NZ
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dzijx-0005S0-6R
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:29 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  4 Oct 2017 13:25:10 +0100
Message-Id: <20171004122515.20627-7-berrange@redhat.com>
In-Reply-To: <20171004122515.20627-1-berrange@redhat.com>
References: <20171004122515.20627-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 06/11] io: Add support for fragmented
 websocket binary frames
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

Allows fragmented binary frames by saving the previous opcode. Handles
the case where an intermediary (i.e., web proxy) fragments frames
originally sent unfragmented by the client.

Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 include/io/channel-websock.h |  1 +
 io/channel-websock.c         | 26 ++++++++++++++++++--------
 2 files changed, 19 insertions(+), 8 deletions(-)

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
index 4e5afb2e95..909d6367f0 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -636,28 +636,38 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
     has_mask = header->b1 & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_HAS_MASK;
     payload_len = header->b1 & QIO_CHANNEL_WEBSOCK_HEADER_FIELD_PAYLOAD_LEN;
 
+    /* Save or restore opcode. */
+    if (opcode) {
+        ioc->opcode = opcode;
+    } else {
+        opcode = ioc->opcode;
+    }
+
     if (opcode == QIO_CHANNEL_WEBSOCK_OPCODE_CLOSE) {
         /* disconnect */
         return 0;
     }
 
     /* Websocket frame sanity check:
-     * * Websocket fragmentation is not supported.
-     * * All  websockets frames sent by a client have to be masked.
+     * * Fragmentation is only supported for binary frames.
+     * * All frames sent by a client MUST be masked.
      * * Only binary encoding is supported.
      */
     if (!fin) {
-        error_setg(errp, "websocket fragmentation is not supported");
-        return -1;
+        if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
+            error_setg(errp, "only binary websocket frames may be fragmented");
+            return -1;
+        }
+    } else {
+        if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
+            error_setg(errp, "only binary websocket frames are supported");
+            return -1;
+        }
     }
     if (!has_mask) {
         error_setg(errp, "client websocket frames must be masked");
         return -1;
     }
-    if (opcode != QIO_CHANNEL_WEBSOCK_OPCODE_BINARY_FRAME) {
-        error_setg(errp, "only binary websocket frames are supported");
-        return -1;
-    }
 
     if (payload_len < QIO_CHANNEL_WEBSOCK_PAYLOAD_LEN_MAGIC_16_BIT) {
         ioc->payload_remain = payload_len;
-- 
2.13.5
