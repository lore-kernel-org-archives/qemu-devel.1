Received: from eggs.gnu.org ([2001:4830:134:3::10]:42006)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJa-0002nP-I9
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJX-0004a5-V4
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:20:18 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:58 -0500
Message-Id: <20180723201748.25573-50-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 49/99] arm_gicv3_kvm:
 kvm_dist_get/put_priority: skip the registers banked by GICR_IPRIORITYR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>, Peter Maydell <peter.maydell@linaro.org>

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
(cherry picked from commit 1dcf3675196a1cec616ce71b067d9498590a60a6)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/intc/arm_gicv3_kvm.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 81cbd16817..bc6fa415b2 100644
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
