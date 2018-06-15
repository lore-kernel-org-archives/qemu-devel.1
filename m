Received: from eggs.gnu.org ([2001:4830:134:3::10]:60859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfX-0001fa-Kx
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfV-0006FZ-Q9
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:39 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:42766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fTpfV-0006Bk-8p
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 10:25:37 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1fTpfH-0003aI-GF
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 15:25:23 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 15 Jun 2018 15:24:39 +0100
Message-Id: <20180615142521.19143-2-peter.maydell@linaro.org>
In-Reply-To: <20180615142521.19143-1-peter.maydell@linaro.org>
References: <20180615142521.19143-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/43] arm_gicv3_kvm: kvm_dist_get/put_priority:
 skip the registers banked by GICR_IPRIORITYR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Shannon Zhao <zhaoshenglong@huawei.com>

While for_each_dist_irq_reg loop starts from GIC_INTERNAL, it forgot to
offset the date array and index. This will overlap the GICR registers
value and leave the last GIC_INTERNAL irq's registers out of update.

Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
Cc: qemu-stable@nongnu.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_kvm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 5649cac46ee..d8d3b254035 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -135,7 +135,14 @@ static void kvm_dist_get_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
     uint32_t reg, *field;
     int irq;
 
-    field = (uint32_t *)bmp;
+    /* For the KVM GICv3, affinity routing is always enabled, and the first 8
+     * GICD_IPRIORITYR<n> registers are always RAZ/WI. The corresponding
+     * functionality is replaced by GICR_IPRIORITYR<n>. It doesn't need to
+     * sync them. So it needs to skip the field of GIC_INTERNAL irqs in bmp and
+     * offset.
+     */
+    field = (uint32_t *)(bmp + GIC_INTERNAL);
+    offset += (GIC_INTERNAL * 8) / 8;
     for_each_dist_irq_reg(irq, s->num_irq, 8) {
         kvm_gicd_access(s, offset, &reg, false);
         *field = reg;
@@ -149,7 +156,14 @@ static void kvm_dist_put_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
     uint32_t reg, *field;
     int irq;
 
-    field = (uint32_t *)bmp;
+    /* For the KVM GICv3, affinity routing is always enabled, and the first 8
+     * GICD_IPRIORITYR<n> registers are always RAZ/WI. The corresponding
+     * functionality is replaced by GICR_IPRIORITYR<n>. It doesn't need to
+     * sync them. So it needs to skip the field of GIC_INTERNAL irqs in bmp and
+     * offset.
+     */
+    field = (uint32_t *)(bmp + GIC_INTERNAL);
+    offset += (GIC_INTERNAL * 8) / 8;
     for_each_dist_irq_reg(irq, s->num_irq, 8) {
         reg = *field;
         kvm_gicd_access(s, offset, &reg, true);
-- 
2.17.1
