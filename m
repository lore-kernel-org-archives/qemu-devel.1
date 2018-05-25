Received: from eggs.gnu.org ([2001:4830:134:3::10]:53871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fMAog-0003MQ-H3
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:23:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhaoshenglong@huawei.com>) id 1fMAof-0002zQ-5i
	for qemu-devel@nongnu.org; Fri, 25 May 2018 07:23:26 -0400
From: Shannon Zhao <zhaoshenglong@huawei.com>
Date: Fri, 25 May 2018 19:22:51 +0800
Message-ID: <1527247371-10592-3-git-send-email-zhaoshenglong@huawei.com>
In-Reply-To: <1527247371-10592-1-git-send-email-zhaoshenglong@huawei.com>
References: <1527247371-10592-1-git-send-email-zhaoshenglong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v4 2/2] arm_gicv3_kvm: kvm_dist_get/put: skip
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
Cc: peter.maydell@linaro.org, eric.auger@redhat.com, qemu-devel@nongnu.org, shannon.zhaosl@gmail.com, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-stable@nongnu.org

While we skip the GIC_INTERNAL irqs, we don't change the register offset
accordingly. This will overlap the GICR registers value and leave the
last GIC_INTERNAL irq's registers out of update.

Fix this by skipping the registers banked by GICR.

Also for migration compatibility if the migration source (old version
qemu) doesn't send gicd_no_migration_shift_bug = 1 to destination, then
we shift the data of PPI to get the right data for SPI.

Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
Cc: qemu-stable@nongnu.org
Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
---
 hw/intc/arm_gicv3_common.c         | 66 ++++++++++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_kvm.c            | 30 +++++++++++++++++
 include/hw/intc/arm_gicv3_common.h |  1 +
 3 files changed, 97 insertions(+)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 7b54d52..f72a6f7 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -27,6 +27,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
+#include "sysemu/kvm.h"
 
 static int gicv3_pre_save(void *opaque)
 {
@@ -141,6 +142,66 @@ static const VMStateDescription vmstate_gicv3_cpu = {
     }
 };
 
+static int gicv3_gicd_no_migration_shift_bug_pre_load(void *opaque)
+{
+    GICv3State *cs = opaque;
+
+   /*
+    * The gicd_no_migration_shift_bug flag is used for migration compatibilty
+    * for old version QEMU which may have the GICD bmp shift bug under KVM mode.
+    */
+    if (kvm_enabled()) {
+        cs->gicd_no_migration_shift_bug = false;
+    }
+
+    return 0;
+}
+
+static int gicv3_gicd_no_migration_shift_bug_post_load(void *opaque,
+                                                       int version_id)
+{
+    GICv3State *cs = opaque;
+
+    if (gicd_no_migration_shift_bug) {
+        return 0;
+    }
+
+    memcpy(cs->group, (uint8_t *)cs->group + GIC_INTERNAL / 8,
+           sizeof(cs->group) - GIC_INTERNAL / 8);
+    memcpy(cs->grpmod, (uint8_t *)cs->grpmod + GIC_INTERNAL / 8,
+           sizeof(cs->grpmod) - GIC_INTERNAL / 8);
+    memcpy(cs->enabled, (uint8_t *)cs->enabled + GIC_INTERNAL / 8,
+           sizeof(cs->enabled) - GIC_INTERNAL / 8);
+    memcpy(cs->pending, (uint8_t *)cs->pending + GIC_INTERNAL / 8,
+           sizeof(cs->pending) - GIC_INTERNAL / 8);
+    memcpy(cs->active, (uint8_t *)cs->active + GIC_INTERNAL / 8,
+           sizeof(cs->active) - GIC_INTERNAL / 8);
+    memcpy(cs->edge_trigger, (uint8_t *)cs->edge_trigger + GIC_INTERNAL / 8,
+           sizeof(cs->edge_trigger) - GIC_INTERNAL / 8);
+
+    return 0;
+}
+
+static bool gicv3_gicd_no_migration_shift_bug_needed(void *opaque)
+{
+    GICv3State *cs = opaque;
+
+    return cs->gicd_no_migration_shift_bug;
+}
+
+const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
+    .name = "arm_gicv3/gicd_no_migration_shift_bug",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_load = gicv3_gicd_no_migration_shift_bug_pre_load,
+    .post_load = gicv3_gicd_no_migration_shift_bug_post_load,
+    .needed = gicv3_gicd_no_migration_shift_bug_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(gicd_no_migration_shift_bug, GICv3State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_gicv3 = {
     .name = "arm_gicv3",
     .version_id = 1,
@@ -165,6 +226,10 @@ static const VMStateDescription vmstate_gicv3 = {
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, GICv3State, num_cpu,
                                              vmstate_gicv3_cpu, GICv3CPUState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_gicv3_gicd_no_migration_shift_bug,
+        NULL
     }
 };
 
@@ -364,6 +429,7 @@ static void arm_gicv3_common_reset(DeviceState *dev)
             gicv3_gicd_group_set(s, i);
         }
     }
+    s->gicd_no_migration_shift_bug = true;
 }
 
 static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 147e691..1068444 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -178,6 +178,12 @@ static void kvm_dist_get_edge_trigger(GICv3State *s, uint32_t offset,
     uint32_t reg;
     int irq;
 
+    /* For the KVM GICv3, affinity routing is always enabled, and the first 2
+     * GICD_ICFGR<n> registers are always RAZ/WI. The corresponding
+     * functionality is replaced by GICR_ICFGR<n>. It doesn't need to sync
+     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
+     */
+    offset += (GIC_INTERNAL * 2) / 8;
     for_each_dist_irq_reg(irq, s->num_irq, 2) {
         kvm_gicd_access(s, offset, &reg, false);
         reg = half_unshuffle32(reg >> 1);
@@ -195,6 +201,12 @@ static void kvm_dist_put_edge_trigger(GICv3State *s, uint32_t offset,
     uint32_t reg;
     int irq;
 
+    /* For the KVM GICv3, affinity routing is always enabled, and the first 2
+     * GICD_ICFGR<n> registers are always RAZ/WI. The corresponding
+     * functionality is replaced by GICR_ICFGR<n>. It doesn't need to sync
+     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
+     */
+    offset += (GIC_INTERNAL * 2) / 8;
     for_each_dist_irq_reg(irq, s->num_irq, 2) {
         reg = *gic_bmp_ptr32(bmp, irq);
         if (irq % 32 != 0) {
@@ -236,6 +248,13 @@ static void kvm_dist_getbmp(GICv3State *s, uint32_t offset, uint32_t *bmp)
     uint32_t reg;
     int irq;
 
+    /* For the KVM GICv3, affinity routing is always enabled, and the
+     * GICD_IGROUPR0/GICD_IGRPMODR0/GICD_ISENABLER0/GICD_ISPENDR0/
+     * GICD_ISACTIVER0 registers are always RAZ/WI. The corresponding
+     * functionality is replaced by the GICR registers. It doesn't need to sync
+     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
+     */
+    offset += (GIC_INTERNAL * 1) / 8;
     for_each_dist_irq_reg(irq, s->num_irq, 1) {
         kvm_gicd_access(s, offset, &reg, false);
         *gic_bmp_ptr32(bmp, irq) = reg;
@@ -249,6 +268,17 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
     uint32_t reg;
     int irq;
 
+    /* For the KVM GICv3, affinity routing is always enabled, and the
+     * GICD_IGROUPR0/GICD_IGRPMODR0/GICD_ISENABLER0/GICD_ISPENDR0/
+     * GICD_ISACTIVER0 registers are always RAZ/WI. The corresponding
+     * functionality is replaced by the GICR registers. It doesn't need to sync
+     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
+     */
+    offset += (GIC_INTERNAL * 1) / 8;
+    if (clroffset != 0) {
+        clroffset += (1 * sizeof(uint32_t));
+    }
+
     for_each_dist_irq_reg(irq, s->num_irq, 1) {
         /* If this bitmap is a set/clear register pair, first write to the
          * clear-reg to clear all bits before using the set-reg to write
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index bccdfe1..d75b49d 100644
--- a/include/hw/intc/arm_gicv3_common.h
+++ b/include/hw/intc/arm_gicv3_common.h
@@ -217,6 +217,7 @@ struct GICv3State {
     uint32_t revision;
     bool security_extn;
     bool irq_reset_nonsecure;
+    bool gicd_no_migration_shift_bug;
 
     int dev_fd; /* kvm device fd if backed by kvm vgic support */
     Error *migration_blocker;
-- 
2.0.4
