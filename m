Received: from eggs.gnu.org ([2001:4830:134:3::10]:38425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fmej2-00033k-L8
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 08:35:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fmej1-0006g3-Nm
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 08:35:04 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  6 Aug 2018 13:34:44 +0100
Message-Id: <20180806123445.1459-5-peter.maydell@linaro.org>
In-Reply-To: <20180806123445.1459-1-peter.maydell@linaro.org>
References: <20180806123445.1459-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH for-3.0 v2 4/5] hw/intc/arm_gicv3_common: Move
 post_load hooks to top-level VMSD
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

Contrary to the the impression given in docs/devel/migration.rst,
the migration code does not run the pre_load hook for a
subsection unless the subsection appears on the wire, and so
this is not a place where you can set the default value for
state for the "subsection not present" case. Instead this needs
to be done in a pre_load hook for whatever is the parent VMSD
of the subsection.

We got this wrong in two of the subsection definitions in
the GICv3 migration structs; fix this.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/intc/arm_gicv3_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index e1a8999cf5b..8175889f1e7 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -73,7 +73,7 @@ static const VMStateDescription vmstate_gicv3_cpu_virt = {
     }
 };
 
-static int icc_sre_el1_reg_pre_load(void *opaque)
+static int vmstate_gicv3_cpu_pre_load(void *opaque)
 {
     GICv3CPUState *cs = opaque;
 
@@ -97,7 +97,6 @@ const VMStateDescription vmstate_gicv3_cpu_sre_el1 = {
     .name = "arm_gicv3_cpu/sre_el1",
     .version_id = 1,
     .minimum_version_id = 1,
-    .pre_load = icc_sre_el1_reg_pre_load,
     .needed = icc_sre_el1_reg_needed,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(icc_sre_el1, GICv3CPUState),
@@ -109,6 +108,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
     .name = "arm_gicv3_cpu",
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_load = vmstate_gicv3_cpu_pre_load,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(level, GICv3CPUState),
         VMSTATE_UINT32(gicr_ctlr, GICv3CPUState),
@@ -139,7 +139,7 @@ static const VMStateDescription vmstate_gicv3_cpu = {
     }
 };
 
-static int gicv3_gicd_no_migration_shift_bug_pre_load(void *opaque)
+static int gicv3_pre_load(void *opaque)
 {
     GICv3State *cs = opaque;
 
@@ -210,7 +210,6 @@ const VMStateDescription vmstate_gicv3_gicd_no_migration_shift_bug = {
     .version_id = 1,
     .minimum_version_id = 1,
     .needed = needed_always,
-    .pre_load = gicv3_gicd_no_migration_shift_bug_pre_load,
     .post_load = gicv3_gicd_no_migration_shift_bug_post_load,
     .fields = (VMStateField[]) {
         VMSTATE_BOOL(gicd_no_migration_shift_bug, GICv3State),
@@ -222,6 +221,7 @@ static const VMStateDescription vmstate_gicv3 = {
     .name = "arm_gicv3",
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_load = gicv3_pre_load,
     .pre_save = gicv3_pre_save,
     .post_load = gicv3_post_load,
     .priority = MIG_PRI_GICV3,
-- 
2.17.1
