Received: from eggs.gnu.org ([2001:4830:134:3::10]:40093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqNFQ-0000KF-4k
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:39:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqNFO-0008Jy-MX
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:39:20 -0400
Received: from mail-pf0-x236.google.com ([2607:f8b0:400e:c00::236]:36684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <brandon.carpenter@cypherpath.com>)
	id 1dqNFO-0008JU-H7
	for qemu-devel@nongnu.org; Fri, 08 Sep 2017 13:39:18 -0400
Received: by mail-pf0-x236.google.com with SMTP id e199so5536540pfh.3
	for <qemu-devel@nongnu.org>; Fri, 08 Sep 2017 10:39:18 -0700 (PDT)
MIME-Version: 1.0
From: Brandon Carpenter <brandon.carpenter@cypherpath.com>
Date: Fri,  8 Sep 2017 10:37:59 -0700
Message-Id: <20170908173801.15205-5-brandon.carpenter@cypherpath.com>
In-Reply-To: <20170908173801.15205-1-brandon.carpenter@cypherpath.com>
References: <20170908173801.15205-1-brandon.carpenter@cypherpath.com>
In-Reply-To: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
References: <20170724184217.21381-1-brandon.carpenter@cypherpath.com>
Content-Type: text/plain; charset="US-ASCII"
Subject: [Qemu-devel] [PATCH v2 4/6] io: Allow empty websocket payload
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

Some browsers send pings/pongs with no payload, so allow empty payloads
instead of closing the connection.

Signed-off-by: Brandon Carpenter <brandon.carpenter@cypherpath.com>
---
 io/channel-websock.c | 62 +++++++++++++++++++++++++---------------------------
 1 file changed, 30 insertions(+), 32 deletions(-)

diff --git a/io/channel-websock.c b/io/channel-websock.c
index ced24135ec..3183aeff77 100644
--- a/io/channel-websock.c
+++ b/io/channel-websock.c
@@ -603,44 +603,42 @@ static int qio_channel_websock_decode_payload(QIOChannelWebsock *ioc,
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
2.14.1


-- 


CONFIDENTIALITY NOTICE: This e-mail message, including any attachments, is 
for the sole use of the intended recipient(s) and may contain proprietary, 
confidential or privileged information or otherwise be protected by law. 
Any unauthorized review, use, disclosure or distribution is prohibited. If 
you are not the intended recipient, please notify the sender and destroy 
all copies and the original message.
