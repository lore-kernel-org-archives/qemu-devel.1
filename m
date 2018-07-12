Received: from eggs.gnu.org ([2001:4830:134:3::10]:41248)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fddjJ-0004bN-RJ
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fddjI-0008QQ-RV
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 11:42:05 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jul 2018 16:41:52 +0100
Message-Id: <20180712154152.32183-3-peter.maydell@linaro.org>
In-Reply-To: <20180712154152.32183-1-peter.maydell@linaro.org>
References: <20180712154152.32183-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 2/2] hw/intc/arm_gic: Fix handling of
 GICD_ITARGETSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Jan Kiszka <jan.kiszka@web.de>, Luc Michel <luc.michel@greensocs.com>

The GICD_ITARGETSR implementation still has some 11MPCore behaviour
that we were incorrectly using in our GICv1 and GICv2 implementations
for the case where the interrupt number is less than GIC_INTERNAL.
The desired behaviour here is:
 * for 11MPCore: RAZ/WI for irqs 0..28; read a number matching the
   CPU doing the read for irqs 29..31
 * for GICv1 and v2: RAZ/WI if uniprocessor; otherwise read a
   number matching the CPU doing the read for all irqs < 32

Stop squashing GICD_ITARGETSR to 0 for IRQs 0..28 unless this
is an 11MPCore GIC.

Reported-by: Jan Kiszka <jan.kiszka@web.de>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
index b0a69d6386e..34dc84ae813 100644
--- a/hw/intc/arm_gic.c
+++ b/hw/intc/arm_gic.c
@@ -751,7 +751,9 @@ static uint32_t gic_dist_readb(void *opaque, hwaddr offset, MemTxAttrs attrs)
             if (irq >= s->num_irq) {
                 goto bad_reg;
             }
-            if (irq >= 29 && irq <= 31) {
+            if (irq < 29 && s->revision == REV_11MPCORE) {
+                res = 0;
+            } else if (irq < GIC_INTERNAL) {
                 res = cm;
             } else {
                 res = GIC_TARGET(irq);
@@ -1014,7 +1016,7 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
             if (irq >= s->num_irq) {
                 goto bad_reg;
             }
-            if (irq < 29) {
+            if (irq < 29 && s->revision == REV_11MPCORE) {
                 value = 0;
             } else if (irq < GIC_INTERNAL) {
                 value = ALL_CPU_MASK;
-- 
2.17.1
