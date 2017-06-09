Received: from eggs.gnu.org ([2001:4830:134:3::10]:45002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dJMDu-0003Jk-Is
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:53:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dJMDt-0005FR-7Y
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:53:18 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  9 Jun 2017 17:52:31 +0200
Message-Id: <1497023553-18411-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1497023553-18411-1-git-send-email-eric.auger@redhat.com>
References: <1497023553-18411-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v6 2/4] hw/intc/arm_gicv3_its: Implement state
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org, zhaoshenglong@huawei.com, wei@redhat.com

We need to handle both registers and ITS tables. While
register handling is standard, ITS table handling is more
challenging since the kernel API is devised so that the
tables are flushed into guest RAM and not in vmstate buffers.

Flushing the ITS tables on device pre_save() is too late
since the guest RAM is already saved at this point.

Table flushing needs to happen when we are sure the vcpus
are stopped and before the last dirty page saving. The
right point is RUN_STATE_FINISH_MIGRATE but sometimes the
VM gets stopped before migration launch so let's simply
flush the tables each time the VM gets stopped.

For regular ITS registers we just can use vmstate pre_save()
and post_load() callbacks.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

v5 -> v6:
- use &s->ctlr directly when writing GITS_CTLR
- don't abort on -EFAULT
- s->iidr reset in gicv3_its_common_reset
---
 hw/intc/arm_gicv3_its_common.c         |  10 ++++
 hw/intc/arm_gicv3_its_kvm.c            | 105 +++++++++++++++++++++++++++++++++
 include/hw/intc/arm_gicv3_its_common.h |   8 +++
 3 files changed, 123 insertions(+)

diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 9d67c5c..696c11c 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -49,6 +49,15 @@ static const VMStateDescription vmstate_its = {
     .pre_save = gicv3_its_pre_save,
     .post_load = gicv3_its_post_load,
     .unmigratable = true,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT32(ctlr, GICv3ITSState),
+        VMSTATE_UINT32(iidr, GICv3ITSState),
+        VMSTATE_UINT64(cbaser, GICv3ITSState),
+        VMSTATE_UINT64(cwriter, GICv3ITSState),
+        VMSTATE_UINT64(creadr, GICv3ITSState),
+        VMSTATE_UINT64_ARRAY(baser, GICv3ITSState, 8),
+        VMSTATE_END_OF_LIST()
+    },
 };
 
 static MemTxResult gicv3_its_trans_read(void *opaque, hwaddr offset,
@@ -118,6 +127,7 @@ static void gicv3_its_common_reset(DeviceState *dev)
     s->cbaser = 0;
     s->cwriter = 0;
     s->creadr = 0;
+    s->iidr = 0;
     memset(&s->baser, 0, sizeof(s->baser));
 
     gicv3_its_post_load(s, 0);
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 340c2b0..4cd8f5f 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -53,6 +53,33 @@ static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t devid)
     return kvm_vm_ioctl(kvm_state, KVM_SIGNAL_MSI, &msi);
 }
 
+/**
+ * vm_change_state_handler - VM change state callback aiming at flushing
+ * ITS tables into guest RAM
+ *
+ * The tables get flushed to guest RAM whenever the VM gets stopped.
+ */
+static void vm_change_state_handler(void *opaque, int running,
+                                    RunState state)
+{
+    GICv3ITSState *s = (GICv3ITSState *)opaque;
+    Error *err = NULL;
+    int ret;
+
+    if (running) {
+        return;
+    }
+
+    ret = kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                            KVM_DEV_ARM_ITS_SAVE_TABLES, NULL, true, &err);
+    if (err) {
+        error_report_err(err);
+    }
+    if (ret < 0 && ret != -EFAULT) {
+        abort();
+    }
+}
+
 static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
 {
     GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
@@ -89,6 +116,8 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
     kvm_msi_use_devid = true;
     kvm_gsi_direct_mapping = false;
     kvm_msi_via_irqfd_allowed = kvm_irqfds_enabled();
+
+    qemu_add_vm_change_state_handler(vm_change_state_handler, s);
 }
 
 static void kvm_arm_its_init(Object *obj)
@@ -102,6 +131,80 @@ static void kvm_arm_its_init(Object *obj)
                              &error_abort);
 }
 
+/**
+ * kvm_arm_its_pre_save - handles the saving of ITS registers.
+ * ITS tables are flushed into guest RAM separately and earlier,
+ * through the VM change state handler, since at the moment pre_save()
+ * is called, the guest RAM has already been saved.
+ */
+static void kvm_arm_its_pre_save(GICv3ITSState *s)
+{
+    int i;
+
+    for (i = 0; i < 8; i++) {
+        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                          GITS_BASER + i * 8, &s->baser[i], false,
+                          &error_abort);
+    }
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                      GITS_CTLR, &s->ctlr, false, &error_abort);
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                      GITS_CBASER, &s->cbaser, false, &error_abort);
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                      GITS_CREADR, &s->creadr, false, &error_abort);
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                      GITS_CWRITER, &s->cwriter, false, &error_abort);
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                      GITS_IIDR, &s->iidr, false, &error_abort);
+}
+
+/**
+ * kvm_arm_its_post_load - Restore both the ITS registers and tables
+ */
+static void kvm_arm_its_post_load(GICv3ITSState *s)
+{
+    int i;
+
+    if (!s->iidr) {
+        return;
+    }
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                      GITS_IIDR, &s->iidr, true, &error_abort);
+
+    /*
+     * must be written before GITS_CREADR since GITS_CBASER write
+     * access resets GITS_CREADR.
+     */
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                      GITS_CBASER, &s->cbaser, true, &error_abort);
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                      GITS_CREADR, &s->creadr, true, &error_abort);
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                      GITS_CWRITER, &s->cwriter, true, &error_abort);
+
+
+    for (i = 0; i < 8; i++) {
+        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                          GITS_BASER + i * 8, &s->baser[i], true,
+                          &error_abort);
+    }
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                      KVM_DEV_ARM_ITS_RESTORE_TABLES, NULL, true,
+                      &error_abort);
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                      GITS_CTLR, &s->ctlr, true, &error_abort);
+}
+
 static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -109,6 +212,8 @@ static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
 
     dc->realize = kvm_arm_its_realize;
     icc->send_msi = kvm_its_send_msi;
+    icc->pre_save = kvm_arm_its_pre_save;
+    icc->post_load = kvm_arm_its_post_load;
 }
 
 static const TypeInfo kvm_arm_its_info = {
diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index 1ba1894..fd1fe64 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -28,6 +28,13 @@
 #define ITS_TRANS_SIZE   0x10000
 #define ITS_SIZE         (ITS_CONTROL_SIZE + ITS_TRANS_SIZE)
 
+#define GITS_CTLR        0x0
+#define GITS_IIDR        0x4
+#define GITS_CBASER      0x80
+#define GITS_CWRITER     0x88
+#define GITS_CREADR      0x90
+#define GITS_BASER       0x100
+
 struct GICv3ITSState {
     SysBusDevice parent_obj;
 
@@ -43,6 +50,7 @@ struct GICv3ITSState {
 
     /* Registers */
     uint32_t ctlr;
+    uint32_t iidr;
     uint64_t cbaser;
     uint64_t cwriter;
     uint64_t creadr;
-- 
2.5.5
