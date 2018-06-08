Received: from eggs.gnu.org ([2001:4830:134:3::10]:47922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNez-0007fk-4e
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNet-0006lQ-Eg
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:06:57 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  8 Jun 2018 22:05:56 +0200
Message-Id: <20180608200558.386-12-laurent@vivier.eu>
In-Reply-To: <20180608200558.386-1-laurent@vivier.eu>
References: <20180608200558.386-1-laurent@vivier.eu>
Subject: [Qemu-devel] [RFC 11/13] dp8393x: manage big endian bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, qemu-block@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Laurent Vivier <laurent@vivier.eu>

This is needed by Quadra 800, this card can run on little-endian
or big-endian bus.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/dp8393x.c | 101 ++++++++++++++++++++++++++++++++++++++-----------------
 1 file changed, 70 insertions(+), 31 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index ef5f1eb94f..5061474e6b 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -150,6 +150,7 @@ typedef struct dp8393xState {
 
     /* Hardware */
     uint8_t it_shift;
+    bool big_endian;
     qemu_irq irq;
 #ifdef DEBUG_SONIC
     int irq_level;
@@ -174,6 +175,12 @@ typedef struct dp8393xState {
     AddressSpace as;
 } dp8393xState;
 
+#ifdef HOST_WORDS_BIGENDIAN
+static const bool host_big_endian = true;
+#else
+static const bool host_big_endian = false;
+#endif
+
 /* Accessor functions for values which are formed by
  * concatenating two 16 bit device registers. By putting these
  * in their own functions with a uint32_t return type we avoid the
@@ -220,6 +227,36 @@ static uint32_t dp8393x_wt(dp8393xState *s)
     return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
 }
 
+static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
+                            int offset)
+{
+    uint16_t val;
+
+    if (s->big_endian) {
+        val = base[offset * width + width - 1];
+    } else {
+        val = base[offset * width];
+    }
+    if (s->big_endian != host_big_endian) {
+        val = bswap16(val);
+    }
+    return val;
+}
+
+static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int offset,
+                        uint16_t val)
+{
+    if (s->big_endian != host_big_endian) {
+        val = bswap16(val);
+    }
+
+    if (s->big_endian) {
+        base[offset * width + width - 1] = val;
+    } else {
+        base[offset * width] = val;
+    }
+}
+
 static void dp8393x_update_irq(dp8393xState *s)
 {
     int level = (s->regs[SONIC_IMR] & s->regs[SONIC_ISR]) ? 1 : 0;
@@ -251,12 +288,12 @@ static void dp8393x_do_load_cam(dp8393xState *s)
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
@@ -269,7 +306,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     /* Read CAM enable */
     address_space_rw(&s->as, dp8393x_cdp(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_CE] = data[0 * width];
+    s->regs[SONIC_CE] = dp8393x_get(s, width, data, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
 
     /* Done */
@@ -290,10 +327,10 @@ static void dp8393x_do_read_rra(dp8393xState *s)
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
@@ -408,12 +445,12 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
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
@@ -439,9 +476,9 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
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
 
@@ -468,7 +505,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         s->regs[SONIC_TCR] |= SONIC_TCR_PTX;
 
         /* Write status */
-        data[0 * width] = s->regs[SONIC_TCR] & 0x0fff; /* status */
+        dp8393x_put(s, width, data, 0,
+                    s->regs[SONIC_TCR] & 0x0fff); /* status */
         size = sizeof(uint16_t) * width;
         address_space_rw(&s->as,
             dp8393x_ttda(s),
@@ -482,8 +520,8 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
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
@@ -746,7 +784,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)data, size, 0);
-        if (data[0 * width] & 0x1) {
+        if (dp8393x_get(s, width, data, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
         } else {
@@ -790,11 +828,11 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
 
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
@@ -803,13 +841,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
     size = sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_LLFA] = data[0 * width];
+    s->regs[SONIC_LLFA] = dp8393x_get(s, width, data, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
         size = sizeof(uint16_t) * width;
-        data[0 * width] = 0; /* in_use */
+        dp8393x_put(s, width, data, 0, 0); /* in_use */
         address_space_rw(&s->as,
             dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
             MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
@@ -923,6 +961,7 @@ static Property dp8393x_properties[] = {
     DEFINE_NIC_PROPERTIES(dp8393xState, conf),
     DEFINE_PROP_PTR("dma_mr", dp8393xState, dma_mr),
     DEFINE_PROP_UINT8("it_shift", dp8393xState, it_shift, 0),
+    DEFINE_PROP_BOOL("big_endian", dp8393xState, big_endian, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.14.4
