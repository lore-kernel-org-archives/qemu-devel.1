Received: from eggs.gnu.org ([2001:4830:134:3::10]:33186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTd-0005JI-Gr
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTY-0006fx-BH
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37257)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dKmTY-0006cz-2O
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 10:07:20 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1dKmTX-000168-7U
	for qemu-devel@nongnu.org; Tue, 13 Jun 2017 15:07:19 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Jun 2017 15:07:06 +0100
Message-Id: <1497362826-21125-18-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
References: <1497362826-21125-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 17/17] hw/intc/arm_gicv3_its: Allow save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Eric Auger <eric.auger@redhat.com>

We change the restoration priority of both the GICv3 and ITS. The
GICv3 must be restored before the ITS and the ITS needs to be restored
before PCIe devices since it translates their MSI transactions.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-id: 1497023553-18411-5-git-send-email-eric.auger@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/migration/vmstate.h    |  2 ++
 hw/intc/arm_gicv3_common.c     |  1 +
 hw/intc/arm_gicv3_its_common.c |  2 +-
 hw/intc/arm_gicv3_its_kvm.c    | 24 ++++++++++++------------
 4 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 79a4b35..f3f3c2a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -149,6 +149,8 @@ enum VMStateFlags {
 typedef enum {
     MIG_PRI_DEFAULT = 0,
     MIG_PRI_IOMMU,              /* Must happen before PCI devices */
+    MIG_PRI_GICV3_ITS,          /* Must happen before PCI devices */
+    MIG_PRI_GICV3,              /* Must happen before the ITS */
     MIG_PRI_MAX,
 } MigrationPriority;
 
diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index c6493d6..4228b7c 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -145,6 +145,7 @@ static const VMStateDescription vmstate_gicv3 = {
     .minimum_version_id = 1,
     .pre_save = gicv3_pre_save,
     .post_load = gicv3_post_load,
+    .priority = MIG_PRI_GICV3,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(gicd_ctlr, GICv3State),
         VMSTATE_UINT32_ARRAY(gicd_statusr, GICv3State, 2),
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 696c11c..68b20fc 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -48,7 +48,7 @@ static const VMStateDescription vmstate_its = {
     .name = "arm_gicv3_its",
     .pre_save = gicv3_its_pre_save,
     .post_load = gicv3_its_post_load,
-    .unmigratable = true,
+    .priority = MIG_PRI_GICV3_ITS,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(ctlr, GICv3ITSState),
         VMSTATE_UINT32(iidr, GICv3ITSState),
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 4cd8f5f..1f8991b 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -85,18 +85,6 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
     GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
     Error *local_err = NULL;
 
-    /*
-     * Block migration of a KVM GICv3 ITS device: the API for saving and
-     * restoring the state in the kernel is not yet available
-     */
-    error_setg(&s->migration_blocker, "vITS migration is not implemented");
-    migrate_add_blocker(s->migration_blocker, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        error_free(s->migration_blocker);
-        return;
-    }
-
     s->dev_fd = kvm_create_device(kvm_state, KVM_DEV_TYPE_ARM_VGIC_ITS, false);
     if (s->dev_fd < 0) {
         error_setg_errno(errp, -s->dev_fd, "error creating in-kernel ITS");
@@ -113,6 +101,18 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 
     gicv3_its_init_mmio(s, NULL);
 
+    if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+        GITS_CTLR)) {
+        error_setg(&s->migration_blocker, "This operating system kernel "
+                   "does not support vITS migration");
+        migrate_add_blocker(s->migration_blocker, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            error_free(s->migration_blocker);
+            return;
+        }
+    }
+
     kvm_msi_use_devid = true;
     kvm_gsi_direct_mapping = false;
     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
-- 
2.7.4
