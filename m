Received: from eggs.gnu.org ([2001:4830:134:3::10]:49952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd2-0003Tb-OG
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLd1-0005K5-KC
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:28 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fWLd1-00055S-8t
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 08:57:27 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fWLco-0003pH-IJ
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 13:57:14 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 22 Jun 2018 13:56:46 +0100
Message-Id: <20180622125713.15303-2-peter.maydell@linaro.org>
In-Reply-To: <20180622125713.15303-1-peter.maydell@linaro.org>
References: <20180622125713.15303-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/28] hw/intc/arm_gicv3: fix an extra
 left-shift when reading IPRIORITYR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Amol Surati <suratiamol@gmail.com>

When either GICD_IPRIORITYR or GICR_IPRIORITYR is read as a 32-bit
register, the post left-shift operator in the for loop causes an
extra shift after the least significant byte has been placed.

The 32-bit value actually returned is therefore the expected value
shifted left by 8 bits.

Signed-off-by: Amol Surati <suratiamol@gmail.com>
Message-id: 20180614054857.26248-1-suratiamol@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_dist.c   | 3 ++-
 hw/intc/arm_gicv3_redist.c | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_dist.c b/hw/intc/arm_gicv3_dist.c
index 93fe936862a..53c55c57291 100644
--- a/hw/intc/arm_gicv3_dist.c
+++ b/hw/intc/arm_gicv3_dist.c
@@ -441,7 +441,8 @@ static MemTxResult gicd_readl(GICv3State *s, hwaddr offset,
         int i, irq = offset - GICD_IPRIORITYR;
         uint32_t value = 0;
 
-        for (i = irq + 3; i >= irq; i--, value <<= 8) {
+        for (i = irq + 3; i >= irq; i--) {
+            value <<= 8;
             value |= gicd_read_ipriorityr(s, attrs, i);
         }
         *data = value;
diff --git a/hw/intc/arm_gicv3_redist.c b/hw/intc/arm_gicv3_redist.c
index 8a8684d76ed..3b0ba6de1ab 100644
--- a/hw/intc/arm_gicv3_redist.c
+++ b/hw/intc/arm_gicv3_redist.c
@@ -192,7 +192,8 @@ static MemTxResult gicr_readl(GICv3CPUState *cs, hwaddr offset,
         int i, irq = offset - GICR_IPRIORITYR;
         uint32_t value = 0;
 
-        for (i = irq + 3; i >= irq; i--, value <<= 8) {
+        for (i = irq + 3; i >= irq; i--) {
+            value <<= 8;
             value |= gicr_read_ipriorityr(cs, attrs, i);
         }
         *data = value;
-- 
2.17.1
