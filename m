Received: from eggs.gnu.org ([2001:4830:134:3::10]:44368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY7N9-0006Me-Gi
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY7N8-0004Pn-KM
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:51 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36996)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dY7N8-0004PI-F1
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:50 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 20 Jul 2017 11:02:45 +0200
Message-Id: <1500541371-24788-3-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
References: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH v2 2/8] usb-ccid: Fix USB packet generation for
 64-Bytes sized packets.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org

From: Stefan Fritsch <stefan_fritsch@genua.de>

An USB transfer must be terminated by a packet that is shorter than
the maximum USB packet size (usually 64Byte) reported by the device
in its descriptor(s). Thus if the last packet of a transfer is exactly
64-Bytes long,  we must send an additional zero length packet.
Fix this for bulk in transfers.

For bulk out transfers this is already ok, for interrupt transfers
this is not a problem as the pipe has a maximum packet size of 8
and transfers are only two bytes long.

Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
Signed-off-by: Christian Ehrhardt <christian_ehrhardt@genua.de>
---
 hw/usb/dev-smartcard-reader.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index 624dc2c447..49791492ea 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -1124,7 +1124,13 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p)
                         s->current_bulk_in->data + s->current_bulk_in->pos,
                         len);
         s->current_bulk_in->pos += len;
-        if (s->current_bulk_in->pos == s->current_bulk_in->len) {
+        /*
+         * The caller assumes that the packet continues if we fill the
+         * entire iov and the iov length matches the max packet size.
+         * Add an empty USB packet in this case.
+         */
+        if (s->current_bulk_in->pos == s->current_bulk_in->len
+            && (len < p->iov.size || p->iov.size < CCID_MAX_PACKET_SIZE)) {
             ccid_bulk_in_release(s);
         }
     } else {
-- 
2.11.0
