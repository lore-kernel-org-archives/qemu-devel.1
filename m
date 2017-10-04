Received: from eggs.gnu.org ([2001:4830:134:3::10]:55196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzik1-0002p5-2D
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dzijz-0005VS-3f
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44500)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1dzijy-0005U1-QW
	for qemu-devel@nongnu.org; Wed, 04 Oct 2017 08:25:31 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed,  4 Oct 2017 13:25:11 +0100
Message-Id: <20171004122515.20627-8-berrange@redhat.com>
In-Reply-To: <20171004122515.20627-1-berrange@redhat.com>
References: <20171004122515.20627-1-berrange@redhat.com>
Subject: [Qemu-devel] [PULL v1 07/11] io: Allow empty websocket payload
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

Some browsers send pings/pongs with no payload, so allow empty payloads
instead of closing the connection.

Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 io/channel-websock.c | 62 +++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index 909d6367f0..b19b5d96da 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -697,44 +697,42 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
                                               Error **errp)
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
-
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
-    }
+    if (ioc->payload_remain) {
+        /* If we aren't at the end of the payload, then drop
+         * off the last bytes, so we're always multiple of 4
+         * for purpose of unmasking, except at end of payload
+         */
+        if (ioc->encinput.offset < ioc->payload_remain) {
+            payload_len = ioc->encinput.offset - (ioc->encinput.offset % 4);
+        } else {
+            payload_len = ioc->payload_remain;
+        }
+        if (payload_len == 0) {
+            return QIO_CHANNEL_ERR_BLOCK;
+        }
 
-    ioc->payload_remain -= payload_len;
+        ioc->payload_remain -= payload_len;
 
-    /* unmask frame */
-    /* process 1 frame (32 bit op) */
-    payload32 = (uint32_t *)ioc->encinput.buffer;
-    for (i = 0; i < payload_len / 4; i++) {
-        payload32[i] ^= ioc->mask.u;
-    }
-    /* process the remaining bytes (if any) */
-    for (i *= 4; i < payload_len; i++) {
-        ioc->encinput.buffer[i] ^= ioc->mask.c[i % 4];
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
 
-    buffer_reserve(&ioc->rawinput, payload_len);
-    buffer_append(&ioc->rawinput, ioc->encinput.buffer, payload_len);
-    buffer_advance(&ioc->encinput, payload_len);
+    if (payload_len) {
+        buffer_reserve(&ioc->rawinput, payload_len);
+        buffer_append(&ioc->rawinput, ioc->encinput.buffer, payload_len);
+        buffer_advance(&ioc->encinput, payload_len);
+    }
     return 0;
 }
 
-- 
2.13.5
