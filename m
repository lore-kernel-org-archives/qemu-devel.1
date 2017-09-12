Received: from eggs.gnu.org ([2001:4830:134:3::10]:40485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn13-0004jd-5I
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn12-00071B-7B
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:21 -0400
Received: from mail-pg0-x231.google.com ([2607:f8b0:400e:c05::231]:37854)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1drn12-00070d-0q
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 11:22:20 -0400
Received: by mail-pg0-x231.google.com with SMTP id d8so21859067pgt.4
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 08:22:19 -0700 (PDT)
MIME-Version: 1.0
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Date: Tue, 12 Sep 2017 08:21:49 -0700
Message-Id: <20170912152153.7729-4-brandon.carpenter@cypherpath.com>
In-Reply-To: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
References: <20170912152153.7729-1-brandon.carpenter@cypherpath.com>
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH v3 3/7] io: Add support for fragmented
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
Cc: berrange@redhat.com, brandon.carpenter@cypherpath.com

Allows fragmented binary frames by saving the previous opcode. Handles
the case where an intermediary (i.e., web proxy) fragments frames
originally sent unfragmented by the client.

Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
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
index 185bd31be5..ced24135ec 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -542,28 +542,38 @@ static int qio_channel_websock_decode_header(QIOChannelWebsock *ioc,
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
2.14.1


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
