Received: from eggs.gnu.org ([2001:4830:134:3::10]:48031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNf4-0007lb-Mg
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fRNf2-0006w8-QK
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 16:07:02 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri,  8 Jun 2018 22:05:57 +0200
Message-Id: <20180608200558.386-13-laurent@vivier.eu>
In-Reply-To: <20180608200558.386-1-laurent@vivier.eu>
References: <20180608200558.386-1-laurent@vivier.eu>
Subject: [Qemu-devel] [RFC 12/13] dp8393x: put DMA temp buffer in the state,
 not in the stack
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

It's only 32 bytes, and this simplifies the dp8393x_get()/
dp8393x_put() interface.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/dp8393x.c | 107 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 51 insertions(+), 56 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 5061474e6b..40e5f8257b 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -168,6 +168,7 @@ typedef struct dp8393xState {
 
     /* Temporaries */
     uint8_t tx_buffer[0x10000];
+    uint16_t data[16];
     int loopback_packet;
 
     /* Memory access */
@@ -227,15 +228,14 @@ static uint32_t dp8393x_wt(dp8393xState *s)
     return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
 }
 
-static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
-                            int offset)
+static uint16_t dp8393x_get(dp8393xState *s, int width, int offset)
 {
     uint16_t val;
 
     if (s->big_endian) {
-        val = base[offset * width + width - 1];
+        val = s->data[offset * width + width - 1];
     } else {
-        val = base[offset * width];
+        val = s->data[offset * width];
     }
     if (s->big_endian != host_big_endian) {
         val = bswap16(val);
@@ -243,7 +243,7 @@ static uint16_t dp8393x_get(dp8393xState *s, int width, uint16_t *base,
     return val;
 }
 
-static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int offset,
+static void dp8393x_put(dp8393xState *s, int width, int offset,
                         uint16_t val)
 {
     if (s->big_endian != host_big_endian) {
@@ -251,9 +251,9 @@ static void dp8393x_put(dp8393xState *s, int width, uint16_t *base, int offset,
     }
 
     if (s->big_endian) {
-        base[offset * width + width - 1] = val;
+        s->data[offset * width + width - 1] = val;
     } else {
-        base[offset * width] = val;
+        s->data[offset * width] = val;
     }
 }
 
@@ -277,7 +277,6 @@ static void dp8393x_update_irq(dp8393xState *s)
 
 static void dp8393x_do_load_cam(dp8393xState *s)
 {
-    uint16_t data[8];
     int width, size;
     uint16_t index = 0;
 
@@ -287,13 +286,13 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     while (s->regs[SONIC_CDC] & 0x1f) {
         /* Fill current entry */
         address_space_rw(&s->as, dp8393x_cdp(s),
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-        s->cam[index][0] = dp8393x_get(s, width, data, 1) & 0xff;
-        s->cam[index][1] = dp8393x_get(s, width, data, 1) >> 8;
-        s->cam[index][2] = dp8393x_get(s, width, data, 2) & 0xff;
-        s->cam[index][3] = dp8393x_get(s, width, data, 2) >> 8;
-        s->cam[index][4] = dp8393x_get(s, width, data, 3) & 0xff;
-        s->cam[index][5] = dp8393x_get(s, width, data, 3) >> 8;
+            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+        s->cam[index][0] = dp8393x_get(s, width, 1) & 0xff;
+        s->cam[index][1] = dp8393x_get(s, width, 1) >> 8;
+        s->cam[index][2] = dp8393x_get(s, width, 2) & 0xff;
+        s->cam[index][3] = dp8393x_get(s, width, 2) >> 8;
+        s->cam[index][4] = dp8393x_get(s, width, 3) & 0xff;
+        s->cam[index][5] = dp8393x_get(s, width, 3) >> 8;
         DPRINTF("load cam[%d] with %02x%02x%02x%02x%02x%02x\n", index,
             s->cam[index][0], s->cam[index][1], s->cam[index][2],
             s->cam[index][3], s->cam[index][4], s->cam[index][5]);
@@ -305,8 +304,8 @@ static void dp8393x_do_load_cam(dp8393xState *s)
 
     /* Read CAM enable */
     address_space_rw(&s->as, dp8393x_cdp(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_CE] = dp8393x_get(s, width, data, 0);
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+    s->regs[SONIC_CE] = dp8393x_get(s, width, 0);
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]);
 
     /* Done */
@@ -317,20 +316,19 @@ static void dp8393x_do_load_cam(dp8393xState *s)
 
 static void dp8393x_do_read_rra(dp8393xState *s)
 {
-    uint16_t data[8];
     int width, size;
 
     /* Read memory */
     width = (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
     size = sizeof(uint16_t) * 4 * width;
     address_space_rw(&s->as, dp8393x_rrp(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
 
     /* Update SONIC registers */
-    s->regs[SONIC_CRBA0] = dp8393x_get(s, width, data, 0);
-    s->regs[SONIC_CRBA1] = dp8393x_get(s, width, data, 1);
-    s->regs[SONIC_RBWC0] = dp8393x_get(s, width, data, 2);
-    s->regs[SONIC_RBWC1] = dp8393x_get(s, width, data, 3);
+    s->regs[SONIC_CRBA0] = dp8393x_get(s, width, 0);
+    s->regs[SONIC_CRBA1] = dp8393x_get(s, width, 1);
+    s->regs[SONIC_RBWC0] = dp8393x_get(s, width, 2);
+    s->regs[SONIC_RBWC1] = dp8393x_get(s, width, 3);
     DPRINTF("CRBA0/1: 0x%04x/0x%04x, RBWC0/1: 0x%04x/0x%04x\n",
         s->regs[SONIC_CRBA0], s->regs[SONIC_CRBA1],
         s->regs[SONIC_RBWC0], s->regs[SONIC_RBWC1]);
@@ -427,7 +425,6 @@ static void dp8393x_do_receiver_disable(dp8393xState *s)
 static void dp8393x_do_transmit_packets(dp8393xState *s)
 {
     NetClientState *nc = qemu_get_queue(s->nic);
-    uint16_t data[12];
     int width, size;
     int tx_len, len;
     uint16_t i;
@@ -436,21 +433,20 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
 
     while (1) {
         /* Read memory */
-        size = sizeof(uint16_t) * 6 * width;
+        size = sizeof(uint16_t) * 7 * width;
         s->regs[SONIC_TTDA] = s->regs[SONIC_CTDA];
         DPRINTF("Transmit packet at %08x\n", dp8393x_ttda(s));
-        address_space_rw(&s->as,
-            dp8393x_ttda(s) + sizeof(uint16_t) * width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
+        address_space_rw(&s->as, dp8393x_ttda(s),
+            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
         tx_len = 0;
 
         /* Update registers */
-        s->regs[SONIC_TCR] = dp8393x_get(s, width, data, 0) & 0xf000;
-        s->regs[SONIC_TPS] = dp8393x_get(s, width, data, 1);
-        s->regs[SONIC_TFC] = dp8393x_get(s, width, data, 2);
-        s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 3);
-        s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 4);
-        s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 5);
+        s->regs[SONIC_TCR] = dp8393x_get(s, width, 1) & 0xf000;
+        s->regs[SONIC_TPS] = dp8393x_get(s, width, 2);
+        s->regs[SONIC_TFC] = dp8393x_get(s, width, 3);
+        s->regs[SONIC_TSA0] = dp8393x_get(s, width, 4);
+        s->regs[SONIC_TSA1] = dp8393x_get(s, width, 5);
+        s->regs[SONIC_TFS] = dp8393x_get(s, width, 6);
 
         /* Handle programmable interrupt */
         if (s->regs[SONIC_TCR] & SONIC_TCR_PINT) {
@@ -475,10 +471,10 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                 size = sizeof(uint16_t) * 3 * width;
                 address_space_rw(&s->as,
                     dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * width,
-                    MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-                s->regs[SONIC_TSA0] = dp8393x_get(s, width, data, 0);
-                s->regs[SONIC_TSA1] = dp8393x_get(s, width, data, 1);
-                s->regs[SONIC_TFS] = dp8393x_get(s, width, data, 2);
+                    MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+                s->regs[SONIC_TSA0] = dp8393x_get(s, width, 0);
+                s->regs[SONIC_TSA1] = dp8393x_get(s, width, 1);
+                s->regs[SONIC_TFS] = dp8393x_get(s, width, 2);
             }
         }
 
@@ -505,12 +501,12 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
         s->regs[SONIC_TCR] |= SONIC_TCR_PTX;
 
         /* Write status */
-        dp8393x_put(s, width, data, 0,
+        dp8393x_put(s, width, 0,
                     s->regs[SONIC_TCR] & 0x0fff); /* status */
         size = sizeof(uint16_t) * width;
         address_space_rw(&s->as,
             dp8393x_ttda(s),
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
+            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
 
         if (!(s->regs[SONIC_CR] & SONIC_CR_HTX)) {
             /* Read footer of packet */
@@ -519,9 +515,9 @@ static void dp8393x_do_transmit_packets(dp8393xState *s)
                 dp8393x_ttda(s) +
                              sizeof(uint16_t) *
                              (4 + 3 * s->regs[SONIC_TFC]) * width,
-                MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-            s->regs[SONIC_CTDA] = dp8393x_get(s, width, data, 0) & ~0x1;
-            if (dp8393x_get(s, width, data, 0) & 0x1) {
+                MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+            s->regs[SONIC_CTDA] = dp8393x_get(s, width, 0) & ~0x1;
+            if (dp8393x_get(s, width, 0) & 0x1) {
                 /* EOL detected */
                 break;
             }
@@ -758,7 +754,6 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
                                size_t size)
 {
     dp8393xState *s = qemu_get_nic_opaque(nc);
-    uint16_t data[10];
     int packet_type;
     uint32_t available, address;
     int width, rx_len = size;
@@ -783,8 +778,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
         size = sizeof(uint16_t) * 1 * width;
         address = dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
-                         (uint8_t *)data, size, 0);
-        if (dp8393x_get(s, width, data, 0) & 0x1) {
+                         (uint8_t *)s->data, size, 0);
+        if (dp8393x_get(s, width, 0) & 0x1) {
             /* Still EOL ; stop reception */
             return -1;
         } else {
@@ -828,29 +823,29 @@ static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
 
     /* Write status to memory */
     DPRINTF("Write status at %08x\n", dp8393x_crda(s));
-    dp8393x_put(s, width, data, 0, s->regs[SONIC_RCR]); /* status */
-    dp8393x_put(s, width, data, 1, rx_len); /* byte count */
-    dp8393x_put(s, width, data, 2, s->regs[SONIC_TRBA0]); /* pkt_ptr0 */
-    dp8393x_put(s, width, data, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
-    dp8393x_put(s, width, data, 4, s->regs[SONIC_RSC]); /* seq_no */
+    dp8393x_put(s, width, 0, s->regs[SONIC_RCR]); /* status */
+    dp8393x_put(s, width, 1, rx_len); /* byte count */
+    dp8393x_put(s, width, 2, s->regs[SONIC_TRBA0]); /* pkt_ptr0 */
+    dp8393x_put(s, width, 3, s->regs[SONIC_TRBA1]); /* pkt_ptr1 */
+    dp8393x_put(s, width, 4, s->regs[SONIC_RSC]); /* seq_no */
     size = sizeof(uint16_t) * 5 * width;
     address_space_rw(&s->as, dp8393x_crda(s),
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
 
     /* Move to next descriptor */
     size = sizeof(uint16_t) * width;
     address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
-        MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
-    s->regs[SONIC_LLFA] = dp8393x_get(s, width, data, 0);
+        MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 0);
+    s->regs[SONIC_LLFA] = dp8393x_get(s, width, 0);
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* EOL detected */
         s->regs[SONIC_ISR] |= SONIC_ISR_RDE;
     } else {
         size = sizeof(uint16_t) * width;
-        dp8393x_put(s, width, data, 0, 0); /* in_use */
+        dp8393x_put(s, width, 0, 0); /* in_use */
         address_space_rw(&s->as,
             dp8393x_crda(s) + sizeof(uint16_t) * 6 * width,
-            MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
+            MEMTXATTRS_UNSPECIFIED, (uint8_t *)s->data, size, 1);
         s->regs[SONIC_CRDA] = s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |= SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] = (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
-- 
2.14.4
