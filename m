Received: from eggs.gnu.org ([2001:4830:134:3::10]:38421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fmej2-00033g-IW
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 08:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fmej1-0006fq-D2
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 08:35:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  6 Aug 2018 13:34:45 +0100
Message-Id: <20180806123445.1459-6-peter.maydell@linaro.org>
In-Reply-To: <20180806123445.1459-1-peter.maydell@linaro.org>
References: <20180806123445.1459-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 v2 5/5] hw/intc/arm_gicv3_common: Move
 gicd shift bug handling to gicv3_post_load
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Shannon Zhao <shannon.zhaosl@gmail.com>

The code currently in gicv3_gicd_no_migration_shift_bug_post_load()
that handles migration from older QEMU versions with a particular
bug is misplaced. We need to run this after migration in all cases,
not just the cases where the "arm_gicv3/gicd_no_migration_shift_bug"
subsection is present, so it must go in a post_load hook for the
top level VMSD, not for the subsection. Move it.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_common.c | 77 ++++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 40 deletions(-)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 8175889f1e7..52480c3b4cf 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -29,6 +29,41 @@
 #include "hw/arm/linux-boot-if.h"
 #include "sysemu/kvm.h"
 
+
+static void gicv3_gicd_no_migration_shift_bug_post_load(GICv3State *cs)
+{
+    if (cs->gicd_no_migration_shift_bug) {
+        return;
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
+}
+
 static int gicv3_pre_save(void *opaque)
 {
     GICv3State *s = (GICv3State *)opaque;
@@ -46,6 +81,8 @@ static int gicv3_post_load(void *opaque, int version_id)
     GICv3State *s = (GICv3State *)opaque;
     ARMGICv3CommonClass *c = ARM_GICV3_COMMON_GET_CLASS(s);
 
+    gicv3_gicd_no_migration_shift_bug_post_load(s);
+
     if (c->post_load) {
         c->post_load(s);
     }
@@ -161,45 +198,6 @@ static int gicv3_pre_load(void *opaque)
     return 0;
 }
 
-static int gicv3_gicd_no_migration_shift_bug_post_load(void *opaque,
-                                                       int version_id)
-{
-    GICv3State *cs = opaque;
-
-    if (cs->gicd_no_migration_shift_bug) {
-        return 0;
-    }
-
-    /* Older versions of QEMU had a bug in the handling of state save/restore
-     * to the KVM GICv3: they got the offset in the bitmap arrays wrong,
-     * so that instead of the data for external interrupts 32 and up
-     * starting at bit position 32 in the bitmap, it started at bit
-     * position 64. If we're receiving data from a QEMU with that bug,
-     * we must move the data down into the right place.
-     */
-    memmove(cs->group, (uint8_t *)cs->group + GIC_INTERNAL / 8,
-            sizeof(cs->group) - GIC_INTERNAL / 8);
-    memmove(cs->grpmod, (uint8_t *)cs->grpmod + GIC_INTERNAL / 8,
-            sizeof(cs->grpmod) - GIC_INTERNAL / 8);
-    memmove(cs->enabled, (uint8_t *)cs->enabled + GIC_INTERNAL / 8,
-            sizeof(cs->enabled) - GIC_INTERNAL / 8);
-    memmove(cs->pending, (uint8_t *)cs->pending + GIC_INTERNAL / 8,
-            sizeof(cs->pending) - GIC_INTERNAL / 8);
-    memmove(cs->active, (uint8_t *)cs->active + GIC_INTERNAL / 8,
-            sizeof(cs->active) - GIC_INTERNAL / 8);
-    memmove(cs->edge_trigger, (uint8_t *)cs->edge_trigger + GIC_INTERNAL / 8,
-            sizeof(cs->edge_trigger) - GIC_INTERNAL / 8);
-
-    /*
-     * While this new version QEMU doesn't have this kind of bug as we fix it,
-     * so it needs to set the flag to true to indicate that and it's necessary
-     * for next migration to work from this new version QEMU.
-     */
-    cs->gicd_no_migration_shift_bug = true;
-
-    return 0;
-}
-
 static bool needed_always(void *opaque)
 {
     return true;
@@ -210,7 +208,6 @@ const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = needed_always,
-    .post_load = gicv3_gicd_no_migration_shift_bug_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_BOOL(gicd_no_migration_shift_bug, GICv3State),
         VMSTATE_END_OF_LIST()
-- 
2.17.1
