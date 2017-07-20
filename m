Received: from eggs.gnu.org ([2001:4830:134:3::10]:44361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY7N9-0006MY-CP
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sf@sfritsch.de>) id 1dY7N8-0004Pg-Hb
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:51 -0400
Received: from manul.sfritsch.de ([2a01:4f8:172:195f:112::2]:36994)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sf@sfritsch.de>) id 1dY7N8-0004PG-Bh
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:03:50 -0400
From: Stefan Fritsch <sf@sfritsch.de>
Date: Thu, 20 Jul 2017 11:02:44 +0200
Message-Id: <1500541371-24788-2-git-send-email-sf@sfritsch.de>
In-Reply-To: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
References: <1500541371-24788-1-git-send-email-sf@sfritsch.de>
Subject: [Qemu-devel] [PATCH v2 1/8] usb-ccid: Add support to dump all USB
 packets
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

The dump can be activated by the debug command line option for the
device like this "qemu ... -dev usb,ccid,debug=5"

While there move the short read debug message to a higher debug level.
It triggers very often and makes debug output unreadable.

Signed-off-by: Stefan Fritsch <stefan_fritsch@genua.de>
Signed-off-by: Christian Ehrhardt <christian_ehrhardt@genua.de>
---
 hw/usb/dev-smartcard-reader.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/hw/usb/dev-smartcard-reader.c b/hw/usb/dev-smartcard-reader.c
index bef1f03c42..624dc2c447 100644
--- a/hw/usb/dev-smartcard-reader.c
+++ b/hw/usb/dev-smartcard-reader.c
@@ -54,9 +54,25 @@ do { \
 #define D_INFO 2
 #define D_MORE_INFO 3
 #define D_VERBOSE 4
+#define D_TRACE 5
+#define D_REMOTEIO 10
 
 #define CCID_DEV_NAME "usb-ccid"
 #define USB_CCID_DEV(obj) OBJECT_CHECK(USBCCIDState, (obj), CCID_DEV_NAME)
+
+static void usb_packet_dump(int lvl, const char *dir, uint8_t *buf, size_t len)
+{
+    int i;
+    if (lvl < D_TRACE) {
+        return;
+    }
+    printf("usb-ccid: usb packet(%s/%zd):", dir, len);
+    for (i = 0; i < len; ++i) {
+        printf(" %02x", buf[i]);
+    }
+    printf("\n");
+}
+
 /*
  * The two options for variable sized buffers:
  * make them constant size, for large enough constant,
@@ -1007,6 +1023,8 @@ static void ccid_handle_bulk_out(USBCCIDState *s, USBPacket *p)
         goto err;
     }
     usb_packet_copy(p, s->bulk_out_data + s->bulk_out_pos, p->iov.size);
+    usb_packet_dump(s->debug, "out", s->bulk_out_data + s->bulk_out_pos,
+                    p->iov.size);
     s->bulk_out_pos += p->iov.size;
     if (s->bulk_out_pos < 10) {
         DPRINTF(s, 1, "%s: header incomplete\n", __func__);
@@ -1102,6 +1120,9 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p)
                   p->iov.size);
         usb_packet_copy(p, s->current_bulk_in->data +
                         s->current_bulk_in->pos, len);
+        usb_packet_dump(s->debug, " in",
+                        s->current_bulk_in->data + s->current_bulk_in->pos,
+                        len);
         s->current_bulk_in->pos += len;
         if (s->current_bulk_in->pos == s->current_bulk_in->len) {
             ccid_bulk_in_release(s);
@@ -1116,7 +1137,7 @@ static void ccid_bulk_in_copy_to_guest(USBCCIDState *s, USBPacket *p)
                 __func__, p->iov.size, len);
     }
     if (len < p->iov.size) {
-        DPRINTF(s, 1,
+        DPRINTF(s, D_REMOTEIO,
                 "%s: returning short (EREMOTEIO) %d < %zd\n",
                 __func__, len, p->iov.size);
     }
@@ -1143,6 +1164,7 @@ static void ccid_handle_data(USBDevice *dev, USBPacket *p)
                 buf[0] = CCID_MESSAGE_TYPE_RDR_to_PC_NotifySlotChange;
                 buf[1] = s->bmSlotICCState;
                 usb_packet_copy(p, buf, 2);
+                usb_packet_dump(s->debug, "irq", buf, 2);
                 s->notify_slot_change = false;
                 s->bmSlotICCState &= ~SLOT_0_CHANGED_MASK;
                 DPRINTF(s, D_INFO,
-- 
2.11.0
