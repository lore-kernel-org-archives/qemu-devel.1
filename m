Received: from eggs.gnu.org ([2001:4830:134:3::10]:41519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJ9-0002J7-K4
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhJ6-0003pN-9M
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:19:51 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:46 -0500
Message-Id: <20180723201748.25573-38-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 37/99] arm_gicv3_kvm: kvm_dist_get/put: skip
 the registers banked by GICR
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

While we skip the GIC_INTERNAL irqs, we don't change the register offset
accordingly. This will overlap the GICR registers value and leave the
last GIC_INTERNAL irq's registers out of update.

Fix this by skipping the registers banked by GICR.

Also for migration compatibility if the migration source (old version
qemu) doesn't send gicd_no_migration_shift_bug = 1 to destination, then
we shift the data of PPI to get the right data for SPI.

Fixes: 367b9f527becdd20ddf116e17a3c0c2bbc486920
Cc: qemu-stable@nongnu.org
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Shannon Zhao <zhaoshenglong@huawei.com>
Message-id: 1527816987-16108-1-git-send-email-zhaoshenglong@huawei.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
(cherry picked from commit 910e204841954b95c051b2ee49ab0f5c735ff93c)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/intc/arm_gicv3_common.c         | 79 ++++++++++++++++++++++++++++++
 hw/intc/arm_gicv3_kvm.c            | 38 ++++++++++++++
 include/hw/intc/arm_gicv3_common.h |  1 +
 3 files changed, 118 insertions(+)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 7b54d52376..864b7c6515 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -27,6 +27,7 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "gicv3_internal.h"
 #include "hw/arm/linux-boot-if.h"
+#include "sysemu/kvm.h"
 
 static int gicv3_pre_save(void *opaque)
 {
@@ -141,6 +142,79 @@ static const VMStateDescription vmstate_gicv3_cpu = {
     }
 };
 
+static int gicv3_gicd_no_migration_shift_bug_pre_load(void *opaque)
+{
+    GICv3State *cs = opaque;
+
+   /*
+    * The gicd_no_migration_shift_bug flag is used for migration compatibility
+    * for old version QEMU which may have the GICD bmp shift bug under KVM mode.
+    * Strictly, what we want to know is whether the migration source is using
+    * KVM. Since we don't have any way to determine that, we look at whether the
+    * destination is using KVM; this is close enough because for the older QEMU
+    * versions with this bug KVM -> TCG migration didn't work anyway. If the
+    * source is a newer QEMU without this bug it will transmit the migration
+    * subsection which sets the flag to true; otherwise it will remain set to
+    * the value we select here.
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
+    if (cs->gicd_no_migration_shift_bug) {
+        return 0;
+    }
+
+    /* Older versions of QEMU had a bug in the handling of state save/restore
+     * to the KVM GICv3: they got the offset in the bitmap arrays wrong,
+     * so that instead of the data for external interrupts 32 and up
+     * starting at bit position 32 in the bitmap, it started at bit
+     * position 64. If we're receiving data from a QEMU with that bug,
+     * we must move the data down into the right place.
+     */
+    memmove(cs->group, (uint8_t *)cs->group + GIC_INTERNAL / 8,
+            sizeof(cs->group) - GIC_INTERNAL / 8);
+    memmove(cs->grpmod, (uint8_t *)cs->grpmod + GIC_INTERNAL / 8,
+            sizeof(cs->grpmod) - GIC_INTERNAL / 8);
+    memmove(cs->enabled, (uint8_t *)cs->enabled + GIC_INTERNAL / 8,
+            sizeof(cs->enabled) - GIC_INTERNAL / 8);
+    memmove(cs->pending, (uint8_t *)cs->pending + GIC_INTERNAL / 8,
+            sizeof(cs->pending) - GIC_INTERNAL / 8);
+    memmove(cs->active, (uint8_t *)cs->active + GIC_INTERNAL / 8,
+            sizeof(cs->active) - GIC_INTERNAL / 8);
+    memmove(cs->edge_trigger, (uint8_t *)cs->edge_trigger + GIC_INTERNAL / 8,
+            sizeof(cs->edge_trigger) - GIC_INTERNAL / 8);
+
+    /*
+     * While this new version QEMU doesn't have this kind of bug as we fix it,
+     * so it needs to set the flag to true to indicate that and it's necessary
+     * for next migration to work from this new version QEMU.
+     */
+    cs->gicd_no_migration_shift_bug = true;
+
+    return 0;
+}
+
+const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
+    .name = "arm_gicv3/gicd_no_migration_shift_bug",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .pre_load = gicv3_gicd_no_migration_shift_bug_pre_load,
+    .post_load = gicv3_gicd_no_migration_shift_bug_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(gicd_no_migration_shift_bug, GICv3State),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static const VMStateDescription vmstate_gicv3 = {
     .name = "arm_gicv3",
     .version_id = 1,
@@ -165,6 +239,10 @@ static const VMStateDescription vmstate_gicv3 = {
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(cpu, GICv3State, num_cpu,
                                              vmstate_gicv3_cpu, GICv3CPUState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &vmstate_gicv3_gicd_no_migration_shift_bug,
+        NULL
     }
 };
 
@@ -364,6 +442,7 @@ static void arm_gicv3_common_reset(DeviceState *dev)
             gicv3_gicd_group_set(s, i);
         }
     }
+    s->gicd_no_migration_shift_bug = true;
 }
 
 static void arm_gic_common_linux_init(ARMLinuxBootIf *obj,
diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
index 3536795501..81cbd16817 100644
--- a/hw/intc/arm_gicv3_kvm.c
+++ b/hw/intc/arm_gicv3_kvm.c
@@ -164,6 +164,14 @@ static void kvm_dist_get_edge_trigger(GICv3State *s, uint32_t offset,
     uint32_t reg;
     int irq;
 
+    /* For the KVM GICv3, affinity routing is always enabled, and the first 2
+     * GICD_ICFGR<n> registers are always RAZ/WI. The corresponding
+     * functionality is replaced by GICR_ICFGR<n>. It doesn't need to sync
+     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
+     * This matches the for_each_dist_irq_reg() macro which also skips the
+     * first GIC_INTERNAL irqs.
+     */
+    offset += (GIC_INTERNAL * 2) / 8;
     for_each_dist_irq_reg(irq, s->num_irq, 2) {
         kvm_gicd_access(s, offset, &reg, false);
         reg = half_unshuffle32(reg >> 1);
@@ -181,6 +189,14 @@ static void kvm_dist_put_edge_trigger(GICv3State *s, uint32_t offset,
     uint32_t reg;
     int irq;
 
+    /* For the KVM GICv3, affinity routing is always enabled, and the first 2
+     * GICD_ICFGR<n> registers are always RAZ/WI. The corresponding
+     * functionality is replaced by GICR_ICFGR<n>. It doesn't need to sync
+     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
+     * This matches the for_each_dist_irq_reg() macro which also skips the
+     * first GIC_INTERNAL irqs.
+     */
+    offset += (GIC_INTERNAL * 2) / 8;
     for_each_dist_irq_reg(irq, s->num_irq, 2) {
         reg = *gic_bmp_ptr32(bmp, irq);
         if (irq % 32 != 0) {
@@ -222,6 +238,15 @@ static void kvm_dist_getbmp(GICv3State *s, uint32_t offset, uint32_t *bmp)
     uint32_t reg;
     int irq;
 
+    /* For the KVM GICv3, affinity routing is always enabled, and the
+     * GICD_IGROUPR0/GICD_IGRPMODR0/GICD_ISENABLER0/GICD_ISPENDR0/
+     * GICD_ISACTIVER0 registers are always RAZ/WI. The corresponding
+     * functionality is replaced by the GICR registers. It doesn't need to sync
+     * them. So it should increase the offset to skip GIC_INTERNAL irqs.
+     * This matches the for_each_dist_irq_reg() macro which also skips the
+     * first GIC_INTERNAL irqs.
+     */
+    offset += (GIC_INTERNAL * 1) / 8;
     for_each_dist_irq_reg(irq, s->num_irq, 1) {
         kvm_gicd_access(s, offset, &reg, false);
         *gic_bmp_ptr32(bmp, irq) = reg;
@@ -235,6 +260,19 @@ static void kvm_dist_putbmp(GICv3State *s, uint32_t offset,
     uint32_t reg;
     int irq;
 
+    /* For the KVM GICv3, affinity routing is always enabled, and the
+     * GICD_IGROUPR0/GICD_IGRPMODR0/GICD_ISENABLER0/GICD_ISPENDR0/
+     * GICD_ISACTIVER0 registers are always RAZ/WI. The corresponding
+     * functionality is replaced by the GICR registers. It doesn't need to sync
+     * them. So it should increase the offset and clroffset to skip GIC_INTERNAL
+     * irqs. This matches the for_each_dist_irq_reg() macro which also skips the
+     * first GIC_INTERNAL irqs.
+     */
+    offset += (GIC_INTERNAL * 1) / 8;
+    if (clroffset != 0) {
+        clroffset += (GIC_INTERNAL * 1) / 8;
+    }
+
     for_each_dist_irq_reg(irq, s->num_irq, 1) {
         /* If this bitmap is a set/clear register pair, first write to the
          * clear-reg to clear all bits before using the set-reg to write
diff --git a/include/hw/intc/arm_gicv3_common.h b/include/hw/intc/arm_gicv3_common.h
index bccdfe17c6..d75b49d558 100644
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
2.17.1
