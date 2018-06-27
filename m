Received: from eggs.gnu.org ([2001:4830:134:3::10]:48613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJtX-00084Y-5B
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:30:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYJtV-0003mq-9K
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 19:30:39 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Thu, 28 Jun 2018 01:29:50 +0200
Message-Id: <20180627232951.14725-10-laurent@vivier.eu>
In-Reply-To: <20180627232951.14725-1-laurent@vivier.eu>
References: <20180627232951.14725-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC v3 09/10] dp8393x: manage big endian bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Jason Wang <jasowang@redhat.com>, Fam Zheng <famz@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is needed by Quadra 800, this card can run on little-endian
or big-endian bus.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Hervé Poussineau <hpoussin@reactos.org>
---
 hw/net/dp8393x.c | 88 ++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 31 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index f2d2ce344c..62adff9ba3 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -150,6 +150,7 @@ typedef struct dp8393xState {
 
     /* Hardware */
     uint8_t it_shift;
+    bool big_endian;
     qemu_irq irq;
 #ifdef DEBUG_SONIC
     int irq_level;
@@ -220,6 +221,29 @@ static uint32_t dp8393x_wt(dp8393xState *s)
     return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
 }
 
+static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
+                            int offset)
+{
+    uint16_t val;
+
+    if (s->big_endian) {
+        val = be16_to_cpu(base[offset * width + width - 1]);
+    } else {
+        val = le16_to_cpu(base[offset * width]);
+    }
+    return val;
+}
+
+static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int offset,
+                        uint16_t val)
+{
+    if (s->big_endian) {
+        base[offset * width + width - 1] = cpu_to_be16(val);
+    } else {
+        base[offset * width] = cpu_to_le16(val);
+    }
+}
+
 static void dp8393x_update_irq(dp8393xState *s)
 {
     int level = (s->regs[SONIC_IMR] & s->regs[SONIC_ISR]) ? 1 : 0;
@@ -251,12 +275,12 @@ static void dp8393x_do_load_cam(dp8393xState *s)
         /* Fill current entry */
         address_space_rw(&s->as, dp8393x_cdp(s),
             MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-        s->cam[index][0] = data[1 * width] & 0xff;
-        s->cam[index][1] = data[1 * width] >> 8;
-        s->cam[index][2] = data[2 * width] & 0xff;
-        s->cam[index][3] = data[2 * width] >> 8;
-        s->cam[index][4] = data[3 * width] & 0xff;
-        s->cam[index][5] = data[3 * width] >> 8;
+        s->cam[index][0] = dp8393x_get(s, width, data, 1) & 0xff;
+        s->cam[index][1] = dp8393x_get(s, width, data, 1) >> 8;
+        s->cam[index][2] = dp8393x_get(s, width, data, 2) & 0xff;
+        s->cam[index][3] = dp8393x_get(s, width, data, 2) >> 8;
+        s->cam[index][4] = dp8393x_get(s, width, data, 3) & 0xff;
+        s->cam[index][5] = dp8393x_get(s, width, data, 3) >> 8;
         DPRINTF("load cam[%d] with %02x%02x%02x%02x%02x%02x\n", index,
             s->cam[index][0], s->cam[index][1], s->cam[index][2],
             s->cam[index][3], s->cam[index][4], s->cam[index][5]);
@@ -269,7 +293,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     /* Read CAM enable */
     address_space_rw(&s->as, dp8393x_cdp(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_CE] = data[0 * width];
+    s->regs[SONIC_CE] = dp8393x_get(s, width, data, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
 
     /* Done */
@@ -290,10 +314,10 @@ static void dp8393x_do_read_rra(dp8393xState *s)
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
 
     /* Update SONIC registers */
-    s->regs[SONIC_CRBA0] = data[0 * width];
-    s->regs[SONIC_CRBA1] = data[1 * width];
-    s->regs[SONIC_RBWC0] = data[2 * width];
-    s->regs[SONIC_RBWC1] = data[3 * width];
+    s->regs[SONIC_CRBA0] = dp8393x_get(s, width, data, 0);
+    s->regs[SONIC_CRBA1] = dp8393x_get(s, width, data, 1);
+    s->regs[SONIC_RBWC0] = dp8393x_get(s, width, data, 2);
+    s->regs[SONIC_RBWC1] = dp8393x_get(s, width, data, 3);
     DPRINTF("CRBA0/1: 0x%04x/0x%04x, RBWC0/1: 0x%04x/0x%04x\n",
         s->regs[SONIC_CRBA0], s->regs[SONIC_CRBA1],
         s->regs[SONIC_RBWC0], s->regs[SONIC_RBWC1]);
@@ -408,12 +432,12 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         tx_len = 0;
 
         /* Update registers */
-        s->regs[SONIC_TCR] = data[0 * width] & 0xf000;
-        s->regs[SONIC_TPS] = data[1 * width];
-        s->regs[SONIC_TFC] = data[2 * width];
-        s->regs[SONIC_TSA0] = data[3 * width];
-        s->regs[SONIC_TSA1] = data[4 * width];
-        s->regs[SONIC_TFS] = data[5 * width];
+        s->regs[SONIC_TCR] = dp8393x_get(s, width, data, 0) & 0xf000;
+        s->regs[SONIC_TPS] = dp8393x_get(s, width, data, 1);
+        s->regs[SONIC_TFC] = dp8393x_get(s, width, data, 2);
+        s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 3);
+        s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 4);
+        s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 5);
 
         /* Handle programmable interrupt */
         if (s->regs[SONIC_TCR] & SONIC_TCR_PINT) {
@@ -439,9 +463,9 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                 address_space_rw(&s->as,
                     dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * width,
                     MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-                s->regs[SONIC_TSA0] = data[0 * width];
-                s->regs[SONIC_TSA1] = data[1 * width];
-                s->regs[SONIC_TFS] = data[2 * width];
+                s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 0);
+                s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 1);
+                s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 2);
             }
         }
 
@@ -468,7 +492,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         s->regs[SONIC_TCR] |= SONIC_TCR_PTX;
 
         /* Write status */
-        data[0 * width] = s->regs[SONIC_TCR] & 0x0fff; /* status */
+        dp8393x_put(s, width, data, 0,
+                    s->regs[SONIC_TCR] & 0x0fff); /* status */
         size = sizeof(uint16_t) * width;
         address_space_rw(&s->as,
             dp8393x_ttda(s),
@@ -482,8 +507,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                              sizeof(uint16_t) *
                              (4 + 3 * s->regs[SONIC_TFC]) * width,
                 MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-            s->regs[SONIC_CTDA] = data[0 * width] & ~0x1;
-            if (data[0 * width] & 0x1) {
+            s->regs[SONIC_CTDA] = dp8393x_get(s, width, data, 0) & ~0x1;
+            if (dp8393x_get(s, width, data, 0) & 0x1) {
                 /* EOL detected */
                 break;
             }
@@ -746,7 +771,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)data, size, 0);
-        if (data[0 * width] & 0x1) {
+        if (dp8393x_get(s, width, data, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
         } else {
@@ -790,11 +815,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
 
     /* Write status to memory */
     DPRINTF("Write status at %08x\n", dp8393x_crda(s));
-    data[0 * width] = s->regs[SONIC_RCR]; /* status */
-    data[1 * width] = rx_len; /* byte count */
-    data[2 * width] = s->regs[SONIC_TRBA0]; /* pkt_ptr0 */
-    data[3 * width] = s->regs[SONIC_TRBA1]; /* pkt_ptr1 */
-    data[4 * width] = s->regs[SONIC_RSC]; /* seq_no */
+    dp8393x_put(s, width, data, 0, s->regs[SONIC_RCR]); /* status */
+    dp8393x_put(s, width, data, 1, rx_len); /* byte count */
+    dp8393x_put(s, width, data, 2, s->regs[SONIC_TRBA0]); /* pkt_ptr0 */
+    dp8393x_put(s, width, data, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
+    dp8393x_put(s, width, data, 4, s->regs[SONIC_RSC]); /* seq_no */
     size = sizeof(uint16_t) * 5 * width;
     address_space_rw(&s->as, dp8393x_crda(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
@@ -803,12 +828,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     size = sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_LLFA] = data[0 * width];
+    s->regs[SONIC_LLFA] = dp8393x_get(s, width, data, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
-        data[0 * width] = 0; /* in_use */
+        dp8393x_put(s, width, data, 0, 0); /* in_use */
         address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
             MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t), 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
@@ -921,6 +946,7 @@ static Property dp8393x_properties[] = {
     DEFINE_NIC_PROPERTIES(dp8393xState, conf),
     DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
     DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
+    DEFINE_PROP_BOOL("big_endian", dp8393xState, big_endian, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.14.4
