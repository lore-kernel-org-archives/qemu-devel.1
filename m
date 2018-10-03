Received: from eggs.gnu.org ([2001:4830:134:3::10]:47933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1g7inS-0006SE-Dh
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1g7inO-0004oZ-Ae
	for qemu-devel@nongnu.org; Wed, 03 Oct 2018 11:10:42 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Wed,  3 Oct 2018 22:07:38 +0700
Message-Id: <1538579266-8389-5-git-send-email-edgar.iglesias@gmail.com>
In-Reply-To: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
References: <1538579266-8389-1-git-send-email-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v1 04/12] net: cadence_gem: Add macro with max
 number of descriptor words
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

Add macro with max number of DMA descriptor words.
No functional change.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 hw/net/cadence_gem.c         | 4 ++--
 include/hw/net/cadence_gem.h | 5 ++++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 31f3fe0..4d769b0 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -1042,7 +1042,7 @@ static void gem_transmit_updatestats(CadenceGEMState *s, const uint8_t *packet,
  */
 static void gem_transmit(CadenceGEMState *s)
 {
-    uint32_t desc[2];
+    uint32_t desc[DESC_MAX_NUM_WORDS];
     hwaddr packet_desc_addr;
     uint8_t     tx_packet[2048];
     uint8_t     *p;
@@ -1108,7 +1108,7 @@ static void gem_transmit(CadenceGEMState *s)
 
             /* Last descriptor for this packet; hand the whole thing off */
             if (tx_desc_get_last(desc)) {
-                uint32_t desc_first[2];
+                uint32_t desc_first[DESC_MAX_NUM_WORDS];
 
                 /* Modify the 1st descriptor of this packet to be owned by
                  * the processor.
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 633d564..b33ef65 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -32,6 +32,9 @@
 
 #define CADENCE_GEM_MAXREG        (0x00000800 / 4) /* Last valid GEM address */
 
+/* Max number of words in a DMA descriptor.  */
+#define DESC_MAX_NUM_WORDS              2
+
 #define MAX_PRIORITY_QUEUES             8
 #define MAX_TYPE1_SCREENERS             16
 #define MAX_TYPE2_SCREENERS             16
@@ -74,7 +77,7 @@ typedef struct CadenceGEMState {
 
     uint8_t can_rx_state; /* Debug only */
 
-    uint32_t rx_desc[MAX_PRIORITY_QUEUES][2];
+    uint32_t rx_desc[MAX_PRIORITY_QUEUES][DESC_MAX_NUM_WORDS];
 
     bool sar_active[4];
 } CadenceGEMState;
-- 
2.7.4
