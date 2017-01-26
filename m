Received: from eggs.gnu.org ([2001:4830:134:3::10]:34223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWgED-0004Lh-01
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:20:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWgEC-0003vc-2Q
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:20:25 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 26 Jan 2017 10:19:41 +0100
Message-Id: <1485422381-29019-5-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
References: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 4/4] hw/intc/arm_gicv3_its: Allow save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, shannon.zhao@linaro.org
Cc: christoffer.dall@linaro.org, drjones@redhat.com, vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com

We change the restoration priority of both the GICv3 and ITS. The
GICv3 must be restored before the ITS and the ITS needs to be restored
before PCIe devices since it translates their MSI transactions.

We typically observe the virtio-pci-net device sending MSI transactions
very early (even before the first vcpu run) which looks weird. It
appears that not servicing those transactions cause the virtio-pci-net
to stall.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/intc/arm_gicv3_common.c     | 1 +
 hw/intc/arm_gicv3_its_common.c | 3 ++-
 hw/intc/arm_gicv3_its_kvm.c    | 8 ++++++--
 include/migration/vmstate.h    | 2 ++
 4 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
index 0f8c4b8..f80e60d 100644
--- a/hw/intc/arm_gicv3_common.c
+++ b/hw/intc/arm_gicv3_common.c
@@ -84,6 +84,7 @@ static const VMStateDescription vmstate_gicv3 = {
     .minimum_version_id = 1,
     .pre_save = gicv3_pre_save,
     .post_load = gicv3_post_load,
+    .priority = MIG_PRI_GICV3,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(gicd_ctlr, GICv3State),
         VMSTATE_UINT32_ARRAY(gicd_statusr, GICv3State, 2),
diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 75b9f04..854709f 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -48,7 +48,8 @@ static const VMStateDescription vmstate_its = {
     .name = "arm_gicv3_its",
     .pre_save = gicv3_its_pre_save,
     .post_load = gicv3_its_post_load,
-    .unmigratable = true,
+    .unmigratable = false,
+    .priority = MIG_PRI_GICV3_ITS,
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(ctlr, GICv3ITSState),
         VMSTATE_UINT64(cbaser, GICv3ITSState),
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 3f8017d..7f81d33 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -95,8 +95,12 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
      * Block migration of a KVM GICv3 ITS device: the API for saving and
      * restoring the state in the kernel is not yet available
      */
-    error_setg(&s->migration_blocker, "vITS migration is not implemented");
-    migrate_add_blocker(s->migration_blocker);
+    if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                               GITS_CTLR)) {
+        error_setg(&s->migration_blocker, "This operating system kernel does "
+                                          "not support vITS migration");
+        migrate_add_blocker(s->migration_blocker);
+    }
 
     kvm_msi_use_devid = true;
     kvm_gsi_direct_mapping = false;
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1a22887..ebd755c 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -188,6 +188,8 @@ enum VMStateFlags {
 
 typedef enum {
     MIG_PRI_DEFAULT = 0,
+    MIG_PRI_GICV3_ITS,
+    MIG_PRI_GICV3,
     MIG_PRI_MAX,
 } MigrationPriority;
 
-- 
2.5.5
