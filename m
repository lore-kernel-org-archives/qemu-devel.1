Received: from eggs.gnu.org ([2001:4830:134:3::10]:48142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1g7io5-0007az-4Z
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:11:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1g7io1-00051A-DK
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:11:21 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed,  3 Oct 2018 22:07:39 +0700
Message-Id: <1538579266-8389-6-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 05/12] net: cadence_gem: Add support for
 extended descriptors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add support for extended descriptors with optional 64bit
addressing and timestamping. QEMU will not yet provide
timestamps (always leaving the valid timestamp bit as zero).

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c         | 69 ++++++++++++++++++++++++++++++++------------
 include/hw/net/cadence_gem.h |  2 +-
 2 files changed, 52 insertions(+), 19 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 4d769b0..759c1d7 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -207,6 +207,9 @@
 #define GEM_NWCFG_BCAST_REJ    0x00000020 /* Reject broadcast packets */
 #define GEM_NWCFG_PROMISC      0x00000010 /* Accept all packets */
 
+#define GEM_DMACFG_ADDR_64B    (1U << 30)
+#define GEM_DMACFG_TX_BD_EXT   (1U << 29)
+#define GEM_DMACFG_RX_BD_EXT   (1U << 28)
 #define GEM_DMACFG_RBUFSZ_M    0x00FF0000 /* DMA RX Buffer Size mask */
 #define GEM_DMACFG_RBUFSZ_S    16         /* DMA RX Buffer Size shift */
 #define GEM_DMACFG_RBUFSZ_MUL  64         /* DMA RX Buffer Size multiplier */
@@ -302,9 +305,14 @@
 
 #define GEM_MODID_VALUE 0x00020118
 
-static inline unsigned tx_desc_get_buffer(uint32_t *desc)
+static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
-    return desc[0];
+    uint64_t ret = desc[0];
+
+    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+        ret |= (uint64_t)desc[2] << 32;
+    }
+    return ret;
 }
 
 static inline unsigned tx_desc_get_used(uint32_t *desc)
@@ -347,9 +355,30 @@ static inline void print_gem_tx_desc(uint32_t *desc, uint8_t queue)
     DB_PRINT("length:  %d\n", tx_desc_get_length(desc));
 }
 
-static inline unsigned rx_desc_get_buffer(uint32_t *desc)
+static inline uint64_t rx_desc_get_buffer(CadenceGEMState *s, uint32_t *desc)
 {
-    return desc[0] & ~0x3UL;
+    uint64_t ret = desc[0] & ~0x3UL;
+
+    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+        ret |= (uint64_t)desc[2] << 32;
+    }
+    return ret;
+}
+
+static inline int gem_get_desc_len(CadenceGEMState *s, bool rx_n_tx)
+{
+    int ret = 2;
+
+    if (s->regs[GEM_DMACFG] & GEM_DMACFG_ADDR_64B) {
+        ret += 2;
+    }
+    if (s->regs[GEM_DMACFG] & (rx_n_tx ? GEM_DMACFG_RX_BD_EXT
+                                       : GEM_DMACFG_TX_BD_EXT)) {
+        ret += 2;
+    }
+
+    assert(ret <= DESC_MAX_NUM_WORDS);
+    return ret;
 }
 
 static inline unsigned rx_desc_get_wrap(uint32_t *desc)
@@ -419,7 +448,7 @@ static void gem_init_register_masks(CadenceGEMState *s)
     memset(&s->regs_ro[0], 0, sizeof(s->regs_ro));
     s->regs_ro[GEM_NWCTRL]   = 0xFFF80000;
     s->regs_ro[GEM_NWSTATUS] = 0xFFFFFFFF;
-    s->regs_ro[GEM_DMACFG]   = 0xFE00F000;
+    s->regs_ro[GEM_DMACFG]   = 0x8E00F000;
     s->regs_ro[GEM_TXSTATUS] = 0xFFFFFE08;
     s->regs_ro[GEM_RXQBASE]  = 0x00000003;
     s->regs_ro[GEM_TXQBASE]  = 0x00000003;
@@ -807,7 +836,8 @@ static void gem_get_rx_desc(CadenceGEMState *s, int q)
     DB_PRINT("read descriptor 0x%x\n", (unsigned)s->rx_desc_addr[q]);
     /* read current descriptor */
     cpu_physical_memory_read(s->rx_desc_addr[q],
-                             (uint8_t *)s->rx_desc[q], sizeof(s->rx_desc[q]));
+                             (uint8_t *)s->rx_desc[q],
+                             sizeof(uint32_t) * gem_get_desc_len(s, true));
 
     /* Descriptor owned by software ? */
     if (rx_desc_get_ownership(s->rx_desc[q]) == 1) {
@@ -926,9 +956,10 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
                 rx_desc_get_buffer(s->rx_desc[q]));
 
         /* Copy packet data to emulated DMA buffer */
-        cpu_physical_memory_write(rx_desc_get_buffer(s->rx_desc[q]) +
-                                                                 rxbuf_offset,
-                                  rxbuf_ptr, MIN(bytes_to_copy, rxbufsize));
+        cpu_physical_memory_write(rx_desc_get_buffer(s, s->rx_desc[q]) +
+                                                                  rxbuf_offset,
+                                  rxbuf_ptr,
+                                  MIN(bytes_to_copy, rxbufsize));
         rxbuf_ptr += MIN(bytes_to_copy, rxbufsize);
         bytes_to_copy -= MIN(bytes_to_copy, rxbufsize);
 
@@ -964,7 +995,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
         /* Descriptor write-back.  */
         cpu_physical_memory_write(s->rx_desc_addr[q],
                                   (uint8_t *)s->rx_desc[q],
-                                  sizeof(s->rx_desc[q]));
+                                  sizeof(uint32_t) * gem_get_desc_len(s, true));
 
         /* Next descriptor */
         if (rx_desc_get_wrap(s->rx_desc[q])) {
@@ -972,7 +1003,7 @@ static ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
             s->rx_desc_addr[q] = s->regs[GEM_RXQBASE];
         } else {
             DB_PRINT("incrementing RX descriptor list\n");
-            s->rx_desc_addr[q] += 8;
+            s->rx_desc_addr[q] += 4 * gem_get_desc_len(s, true);
         }
 
         gem_get_rx_desc(s, q);
@@ -1069,7 +1100,8 @@ static void gem_transmit(CadenceGEMState *s)
 
         DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", packet_desc_addr);
         cpu_physical_memory_read(packet_desc_addr,
-                                 (uint8_t *)desc, sizeof(desc));
+                                 (uint8_t *)desc,
+                                 sizeof(uint32_t) * gem_get_desc_len(s, false));
         /* Handle all descriptors owned by hardware */
         while (tx_desc_get_used(desc) == 0) {
 
@@ -1082,7 +1114,7 @@ static void gem_transmit(CadenceGEMState *s)
             /* The real hardware would eat this (and possibly crash).
              * For QEMU let's lend a helping hand.
              */
-            if ((tx_desc_get_buffer(desc) == 0) ||
+            if ((tx_desc_get_buffer(s, desc) == 0) ||
                 (tx_desc_get_length(desc) == 0)) {
                 DB_PRINT("Invalid TX descriptor @ 0x%x\n",
                          (unsigned)packet_desc_addr);
@@ -1101,7 +1133,7 @@ static void gem_transmit(CadenceGEMState *s)
             /* Gather this fragment of the packet from "dma memory" to our
              * contig buffer.
              */
-            cpu_physical_memory_read(tx_desc_get_buffer(desc), p,
+            cpu_physical_memory_read(tx_desc_get_buffer(s, desc), p,
                                      tx_desc_get_length(desc));
             p += tx_desc_get_length(desc);
             total_bytes += tx_desc_get_length(desc);
@@ -1124,7 +1156,8 @@ static void gem_transmit(CadenceGEMState *s)
                 if (tx_desc_get_wrap(desc)) {
                     s->tx_desc_addr[q] = s->regs[GEM_TXQBASE];
                 } else {
-                    s->tx_desc_addr[q] = packet_desc_addr + 8;
+                    s->tx_desc_addr[q] = packet_desc_addr +
+                                         4 * gem_get_desc_len(s, false);
                 }
                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[q]);
 
@@ -1168,11 +1201,11 @@ static void gem_transmit(CadenceGEMState *s)
                 tx_desc_set_last(desc);
                 packet_desc_addr = s->regs[GEM_TXQBASE];
             } else {
-                packet_desc_addr += 8;
+                packet_desc_addr += 4 * gem_get_desc_len(s, false);
             }
             DB_PRINT("read descriptor 0x%" HWADDR_PRIx "\n", packet_desc_addr);
-            cpu_physical_memory_read(packet_desc_addr,
-                                     (uint8_t *)desc, sizeof(desc));
+            cpu_physical_memory_read(packet_desc_addr, (uint8_t *)desc,
+                                sizeof(uint32_t) * gem_get_desc_len(s, false));
         }
 
         if (tx_desc_get_used(desc)) {
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index b33ef65..00dbf4f 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -33,7 +33,7 @@
 #define CADENCE_GEM_MAXREG        (0x00000800 / 4) /* Last valid GEM address */
 
 /* Max number of words in a DMA descriptor.  */
-#define DESC_MAX_NUM_WORDS              2
+#define DESC_MAX_NUM_WORDS              6
 
 #define MAX_PRIORITY_QUEUES             8
 #define MAX_TYPE1_SCREENERS             16
-- 
2.7.4
