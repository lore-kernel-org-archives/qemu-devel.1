Received: from eggs.gnu.org ([2001:4830:134:3::10]:42929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC8-0000ec-41
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC7-0007uB-8b
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:40 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:51902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gCRC7-0007sS-0x
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 11:23:39 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gCRC6-0003oD-2T
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 16:23:38 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 16:23:15 +0100
Message-Id: <20181016152325.31367-10-peter.maydell@linaro.org>
In-Reply-To: <20181016152325.31367-1-peter.maydell@linaro.org>
References: <20181016152325.31367-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/19] net: cadence_gem: Add macro with max
 number of descriptor words
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

Add macro with max number of DMA descriptor words.
No functional change.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20181011021931.4249-5-edgar.iglesias@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/cadence_gem.h | 5 ++++-
 hw/net/cadence_gem.c         | 4 ++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index 633d564dc3b..b33ef6513b9 100644
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
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index 31f3fe0e816..4d769b02440 100644
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
-- 
2.19.0
