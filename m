Received: from eggs.gnu.org ([2001:4830:134:3::10]:47008)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1exvvC-0000ld-15
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1exvvB-00062n-2Y
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:37:58 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Mon, 19 Mar 2018 22:36:17 +0800
Message-ID: <1521470177-14760-3-git-send-email-zhaoshenglong@huawei.com>
In-Reply-To: <1521470177-14760-1-git-send-email-zhaoshenglong@huawei.com>
References: <1521470177-14760-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 2/2] arm_gicv3_kvm: kvm_dist_get/put: skip the
 registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com

It should skip to getting/putting the registers banked by GICR so that
it could get/put the correct ones.

Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
---
 hw/intc/arm_gicv3_kvm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 7000716..e967e4f 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -136,6 +136,8 @@ static void kvm_dist_get_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
     int irq;
 
     field = (uint32_t *)bmp;
+    /* The first 8 GICD_IPRIORITYR should skip. */
+    offset += (8 * sizeof(uint32_t));
     for_each_dist_irq_reg(irq, s->num_irq, 8) {
         kvm_gicd_access(s, offset, &reg, false);
         *field = reg;
@@ -150,6 +152,8 @@ static void kvm_dist_put_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
     int irq;
 
     field = (uint32_t *)bmp;
+    /* The first 8 GICD_IPRIORITYR should skip. */
+    offset += (8 * sizeof(uint32_t));
     for_each_dist_irq_reg(irq, s->num_irq, 8) {
         reg = *field;
         kvm_gicd_access(s, offset, &reg, true);
@@ -164,6 +168,8 @@ static void kvm_dist_get_edge_trigger(GICv3State *s, uint32_t offset,
     uint32_t reg;
     int irq;
 
+    /* The first 2 GICD_ICFGR should skip. */
+    offset += (2 * sizeof(uint32_t));
     for_each_dist_irq_reg(irq, s->num_irq, 2) {
         kvm_gicd_access(s, offset, &reg, false);
         reg = half_unshuffle32(reg >> 1);
@@ -181,6 +187,8 @@ static void kvm_dist_put_edge_trigger(GICv3State *s, uint32_t offset,
     uint32_t reg;
     int irq;
 
+    /* The first 2 GICD_ICFGR should skip. */
+    offset += (2 * sizeof(uint32_t));
     for_each_dist_irq_reg(irq, s->num_irq, 2) {
         reg = *gic_bmp_ptr32(bmp, irq);
         if (irq % 32 != 0) {
@@ -222,6 +230,8 @@ static void kvm_dist_getbmp(GICv3State *s, uint32_t offset, uint32_t *bmp)
     uint32_t reg;
     int irq;
 
+    /* The first 1 GICD_XXXX should skip. */
+    offset += (1 * sizeof(uint32_t));
     for_each_dist_irq_reg(irq, s->num_irq, 1) {
         kvm_gicd_access(s, offset, &reg, false);
         *gic_bmp_ptr32(bmp, irq) = reg;
@@ -236,6 +246,10 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
     int irq;
 
     clroffset_index = clroffset;
+    /* The first 1 GICD_XXXX should skip. */
+    offset += (1 * sizeof(uint32_t));
+    if (clroffset != 0)
+        clroffset_index += (1 * sizeof(uint32_t));
     for_each_dist_irq_reg(irq, s->num_irq, 1) {
         /* If this bitmap is a set/clear register pair, first write to the
          * clear-reg to clear all bits before using the set-reg to write
-- 
2.0.4
