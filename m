Received: from eggs.gnu.org ([2001:4830:134:3::10]:42919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC7-0000eI-O3
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC6-0007so-LK
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51900)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRC6-0007ll-7F
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:38 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC5-0003nv-3A
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:37 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:14 +0100
Message-Id: <20181016152325.31367-9-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 08/19] net: cadence_gem: Use uint32_t for 32bit
 descriptor words
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Use uint32_t instead of unsigned to describe 32bit descriptor words.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20181011021931.4249-4-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/cadence_gem.h |  2 +-
 hw/net/cadence_gem.c         | 42 ++++++++++++++++++------------------
 2 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 35de622063e..633d564dc3b 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -74,7 +74,7 @@ typedef struct CadenceGEMState {
 
     uint8_t can_rx_state; /* Debug only */
 
-    unsigned rx_desc[MAX_PRIORITY_QUEUES][2];
+    uint32_t rx_desc[MAX_PRIORITY_QUEUES][2];
 
     bool sar_active[4];
 } CadenceGEMState;
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 901c1739709..31f3fe0e816 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -302,42 +302,42 @@
 
 #define GEM_MODID_VALUE 0x00020118
 
-static inline unsigned tx_desc_get_buffer(unsigned *desc)
+static inline unsigned tx_desc_get_buffer(uint32_t *desc)
 {
     return desc[0];
 }
 
-static inline unsigned tx_desc_get_used(unsigned *desc)
+static inline unsigned tx_desc_get_used(uint32_t *desc)
 {
     return (desc[1] & DESC_1_USED) ? 1 : 0;
 }
 
-static inline void tx_desc_set_used(unsigned *desc)
+static inline void tx_desc_set_used(uint32_t *desc)
 {
     desc[1] |= DESC_1_USED;
 }
 
-static inline unsigned tx_desc_get_wrap(unsigned *desc)
+static inline unsigned tx_desc_get_wrap(uint32_t *desc)
 {
     return (desc[1] & DESC_1_TX_WRAP) ? 1 : 0;
 }
 
-static inline unsigned tx_desc_get_last(unsigned *desc)
+static inline unsigned tx_desc_get_last(uint32_t *desc)
 {
     return (desc[1] & DESC_1_TX_LAST) ? 1 : 0;
 }
 
-static inline void tx_desc_set_last(unsigned *desc)
+static inline void tx_desc_set_last(uint32_t *desc)
 {
     desc[1] |= DESC_1_TX_LAST;
 }
 
-static inline unsigned tx_desc_get_length(unsigned *desc)
+static inline unsigned tx_desc_get_length(uint32_t *desc)
 {
     return desc[1] & DESC_1_LENGTH;
 }
 
-static inline void print_gem_tx_desc(unsigned *desc, uint8_t queue)
+static inline void print_gem_tx_desc(uint32_t *desc, uint8_t queue)
 {
     DB_PRINT("TXDESC (queue %" PRId8 "):\n", queue);
     DB_PRINT("bufaddr: 0x%08x\n", *desc);
@@ -347,58 +347,58 @@ static inline void print_gem_tx_desc(unsigned *desc, uint8_t queue)
     DB_PRINT("length:  %d\n", tx_desc_get_length(desc));
 }
 
-static inline unsigned rx_desc_get_buffer(unsigned *desc)
+static inline unsigned rx_desc_get_buffer(uint32_t *desc)
 {
     return desc[0] & ~0x3UL;
 }
 
-static inline unsigned rx_desc_get_wrap(unsigned *desc)
+static inline unsigned rx_desc_get_wrap(uint32_t *desc)
 {
     return desc[0] & DESC_0_RX_WRAP ? 1 : 0;
 }
 
-static inline unsigned rx_desc_get_ownership(unsigned *desc)
+static inline unsigned rx_desc_get_ownership(uint32_t *desc)
 {
     return desc[0] & DESC_0_RX_OWNERSHIP ? 1 : 0;
 }
 
-static inline void rx_desc_set_ownership(unsigned *desc)
+static inline void rx_desc_set_ownership(uint32_t *desc)
 {
     desc[0] |= DESC_0_RX_OWNERSHIP;
 }
 
-static inline void rx_desc_set_sof(unsigned *desc)
+static inline void rx_desc_set_sof(uint32_t *desc)
 {
     desc[1] |= DESC_1_RX_SOF;
 }
 
-static inline void rx_desc_set_eof(unsigned *desc)
+static inline void rx_desc_set_eof(uint32_t *desc)
 {
     desc[1] |= DESC_1_RX_EOF;
 }
 
-static inline void rx_desc_set_length(unsigned *desc, unsigned len)
+static inline void rx_desc_set_length(uint32_t *desc, unsigned len)
 {
     desc[1] &= ~DESC_1_LENGTH;
     desc[1] |= len;
 }
 
-static inline void rx_desc_set_broadcast(unsigned *desc)
+static inline void rx_desc_set_broadcast(uint32_t *desc)
 {
     desc[1] |= R_DESC_1_RX_BROADCAST;
 }
 
-static inline void rx_desc_set_unicast_hash(unsigned *desc)
+static inline void rx_desc_set_unicast_hash(uint32_t *desc)
 {
     desc[1] |= R_DESC_1_RX_UNICAST_HASH;
 }
 
-static inline void rx_desc_set_multicast_hash(unsigned *desc)
+static inline void rx_desc_set_multicast_hash(uint32_t *desc)
 {
     desc[1] |= R_DESC_1_RX_MULTICAST_HASH;
 }
 
-static inline void rx_desc_set_sar(unsigned *desc, int sar_idx)
+static inline void rx_desc_set_sar(uint32_t *desc, int sar_idx)
 {
     desc[1] = deposit32(desc[1], R_DESC_1_RX_SAR_SHIFT, R_DESC_1_RX_SAR_LENGTH,
                         sar_idx);
@@ -1042,7 +1042,7 @@ static void gem_transmit_updatestats(CadenceGEMState *s, const uint8_t *packet,
  */
 static void gem_transmit(CadenceGEMState *s)
 {
-    unsigned    desc[2];
+    uint32_t desc[2];
     hwaddr packet_desc_addr;
     uint8_t     tx_packet[2048];
     uint8_t     *p;
@@ -1108,7 +1108,7 @@ static void gem_transmit(CadenceGEMState *s)
 
             /* Last descriptor for this packet; hand the whole thing off */
             if (tx_desc_get_last(desc)) {
-                unsigned    desc_first[2];
+                uint32_t desc_first[2];
 
                 /* Modify the 1st descriptor of this packet to be owned by
                  * the processor.
-- 
2.19.0
