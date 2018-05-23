Received: from eggs.gnu.org ([2001:4830:134:3::10]:51268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fLKs6-0000AU-NA
	for qemu-devel@nongnu.org; Tue, 22 May 2018 23:55:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fLKs5-0000bo-BQ
	for qemu-devel@nongnu.org; Tue, 22 May 2018 23:55:30 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Wed, 23 May 2018 11:53:53 +0800
Message-ID: <1527047633-12368-2-git-send-email-zhaoshenglong@huawei.com>
In-Reply-To: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
References: <1527047633-12368-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V3 2/2] arm_gicv3_kvm: kvm_dist_get/put: skip
 the registers banked by GICR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com

While we skip the GIC_INTERNAL irqs, we don't change the register offset
accordingly. This will overlap the GICR registers value and leave the
last GIC_INTERNAL irq's registers out of update.

Fix this by skipping the registers banked by GICR.

Also for migration compatibility if the migration source (old version
qemu) doesn't send gicd_no_shift_bug = 1 to destination, then we shift
the data of PPI to get the right data for SPI.

Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
Cc: qemu-stable@nongnu.org
Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
---
Changes in V3: add migration compatibility and fix code style
---
 hw/intc/arm_gicv3_common.c         | 36 ++++++++++++++++++++++++
 hw/intc/arm_gicv3_kvm.c            | 56 +++++++++++++++++++++++++++++++++++++-
 include/hw/intc/arm_gicv3_common.h |  1 +
 3 files changed, 92 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 7b54d52..f93e5d2 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -141,6 +141,38 @@ static const VMStateDescription vmstate_gicv3_cpu = {
     }
 };
 
+static int gicv3_gicd_no_shift_bug_pre_load(void *opaque)
+{
+    GICv3State *cs = opaque;
+
+   /*
+    * If the gicd_no_shift_bug subsection is not transferred this
+    * means gicd_no_shift_bug is 0x0 (which might not be the same as
+    * our reset value).
+    */
+    cs->gicd_no_shift_bug = 0x0;
+    return 0;
+}
+
+static bool gicv3_gicd_no_shift_bug_needed(void *opaque)
+{
+    GICv3State *cs = opaque;
+
+    return cs->gicd_no_shift_bug;
+}
+
+const VMStateDescription vmstate_gicv3_gicd_no_shift_bug = {
+    .name = "arm_gicv3/gicd_no_shift_bug",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_load = gicv3_gicd_no_shift_bug_pre_load,
+    .needed = gicv3_gicd_no_shift_bug_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(gicd_no_shift_bug, GICv3State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_gicv3 = {
     .name = "arm_gicv3",
     .version_id = 1,
@@ -165,6 +197,10 @@ static const VMStateDescription vmstate_gicv3 = {
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, GICv3State, num_cpu,
                                              vmstate_gicv3_cpu, GICv3CPUState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_gicv3_gicd_no_shift_bug,
+        NULL
     }
 };
 
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 3536795..bd961f1 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -136,6 +136,12 @@ static void kvm_dist_get_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
     int irq;
 
     field = (uint32_t *)bmp;
+    /* For the KVM GICv3, affinity routing is always enabled, and the first 8
+     * GICD_IPRIORITYR<n> registers are always RAZ/WI. The corresponding
+     * functionality is replaced by GICR_IPRIORITYR<n>. So it doesn't need to
+     * sync them.
+     */
+    offset += (8 * sizeof(uint32_t));
     for_each_dist_irq_reg(irq, s->num_irq, 8) {
         kvm_gicd_access(s, offset, &reg, false);
         *field = reg;
@@ -149,7 +155,18 @@ static void kvm_dist_put_priority(GICv3State *s, uint32_t offset, uint8_t *bmp)
     uint32_t reg, *field;
     int irq;
 
-    field = (uint32_t *)bmp;
+    if (!s->gicd_no_shift_bug) {
+        field = (uint32_t *)(bmp + 8 * sizeof(uint32_t));
+    } else {
+        field = (uint32_t *)bmp;
+    }
+
+    /* For the KVM GICv3, affinity routing is always enabled, and the first 8
+     * GICD_IPRIORITYR<n> registers are always RAZ/WI. The corresponding
+     * functionality is replaced by GICR_IPRIORITYR<n>. So it doesn't need to
+     * sync them.
+     */
+    offset += (8 * sizeof(uint32_t));
     for_each_dist_irq_reg(irq, s->num_irq, 8) {
         reg = *field;
         kvm_gicd_access(s, offset, &reg, true);
@@ -164,6 +181,12 @@ static void kvm_dist_get_edge_trigger(GICv3State *s, uint32_t offset,
     uint32_t reg;
     int irq;
 
+    /* For the KVM GICv3, affinity routing is always enabled, and the first 2
+     * GICD_ICFGR<n> registers are always RAZ/WI. The corresponding
+     * functionality is replaced by GICR_ICFGR<n>. So it doesn't need to sync
+     * them.
+     */
+    offset += (2 * sizeof(uint32_t));
     for_each_dist_irq_reg(irq, s->num_irq, 2) {
         kvm_gicd_access(s, offset, &reg, false);
         reg = half_unshuffle32(reg >> 1);
@@ -181,6 +204,16 @@ static void kvm_dist_put_edge_trigger(GICv3State *s, uint32_t offset,
     uint32_t reg;
     int irq;
 
+    if (!s->gicd_no_shift_bug) {
+        bmp += (2 * sizeof(uint32_t));
+    }
+
+    /* For the KVM GICv3, affinity routing is always enabled, and the first 2
+     * GICD_ICFGR<n> registers are always RAZ/WI. The corresponding
+     * functionality is replaced by GICR_ICFGR<n>. So it doesn't need to sync
+     * them.
+     */
+    offset += (2 * sizeof(uint32_t));
     for_each_dist_irq_reg(irq, s->num_irq, 2) {
         reg = *gic_bmp_ptr32(bmp, irq);
         if (irq % 32 != 0) {
@@ -222,6 +255,12 @@ static void kvm_dist_getbmp(GICv3State *s, uint32_t offset, uint32_t *bmp)
     uint32_t reg;
     int irq;
 
+    /* For the KVM GICv3, affinity routing is always enabled, and the
+     * GICD_IGROUPR0/GICD_ISENABLER0/GICD_ISPENDR0/GICD_ISACTIVER0 registers
+     * are always RAZ/WI. The corresponding functionality is replaced by the
+     * GICR registers. So it doesn't need to sync them.
+     */
+    offset += (1 * sizeof(uint32_t));
     for_each_dist_irq_reg(irq, s->num_irq, 1) {
         kvm_gicd_access(s, offset, &reg, false);
         *gic_bmp_ptr32(bmp, irq) = reg;
@@ -235,6 +274,20 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
     uint32_t reg;
     int irq;
 
+    if (!s->gicd_no_shift_bug) {
+        bmp += (1 * sizeof(uint32_t));
+    }
+
+    /* For the KVM GICv3, affinity routing is always enabled, and the
+     * GICD_IGROUPR0/GICD_ISENABLER0/GICD_ISPENDR0/GICD_ISACTIVER0 registers
+     * are always RAZ/WI. The corresponding functionality is replaced by the
+     * GICR registers. So it doesn't need to sync them.
+     */
+    offset += (1 * sizeof(uint32_t));
+    if (clroffset != 0) {
+        clroffset += (1 * sizeof(uint32_t));
+    }
+
     for_each_dist_irq_reg(irq, s->num_irq, 1) {
         /* If this bitmap is a set/clear register pair, first write to the
          * clear-reg to clear all bits before using the set-reg to write
@@ -651,6 +704,7 @@ static void kvm_arm_gicv3_reset(DeviceState *dev)
         return;
     }
 
+    s->gicd_no_shift_bug = 1;
     kvm_arm_gicv3_put(s);
 }
 
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index bccdfe1..13c28c0 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -217,6 +217,7 @@ struct GICv3State {
     uint32_t revision;
     bool security_extn;
     bool irq_reset_nonsecure;
+    bool gicd_no_shift_bug;
 
     int dev_fd; /* kvm device fd if backed by kvm vgic support */
     Error *migration_blocker;
-- 
2.0.4
