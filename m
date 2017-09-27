Received: from eggs.gnu.org ([2001:4830:134:3::10]:56707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dxDmL-0000rf-Qb
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dxDmK-0001iL-W8
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 10:57:37 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Wed, 27 Sep 2017 16:56:45 +0200
Message-Id: <1506524205-20763-4-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1506524205-20763-1-git-send-email-eric.auger@redhat.com>
References: <1506524205-20763-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 3/3] hw/intc/arm_gicv3_its: Implement reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, wanghaibin.wang@huawei.com
Cc: vijay.kilari@gmail.com, drjones@redhat.com, wei@redhat.com, quintela@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org, wu.wubin@huawei.com

Currently the ITS is not reset and this causes trouble
when state backup is initiated before the guest has initialized
the ITS registers and especially GITS_CBASER<n>.

We are likely to save register values set before the reset/
restart. The register values may not be consistent with the
data structures in RAM.

So let's use the ITS KVM device new combo,
KVM_DEV_ARM_VGIC_GRP_CTRL/KVM_DEV_ARM_ITS_CTRL_RESET
to explicitly force the in-kernel emulated reset.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/intc/arm_gicv3_its_common.c         |  5 ++---
 hw/intc/arm_gicv3_its_kvm.c            | 22 ++++++++++++++++++----
 include/hw/intc/arm_gicv3_its_common.h |  1 +
 3 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_common.c b/hw/intc/arm_gicv3_its_common.c
index 68b20fc..a2fe561 100644
--- a/hw/intc/arm_gicv3_its_common.c
+++ b/hw/intc/arm_gicv3_its_common.c
@@ -129,15 +129,14 @@ static void gicv3_its_common_reset(DeviceState *dev)
     s->creadr = 0;
     s->iidr = 0;
     memset(&s->baser, 0, sizeof(s->baser));
-
-    gicv3_its_post_load(s, 0);
 }
 
 static void gicv3_its_common_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
+    GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_CLASS(klass);
 
-    dc->reset = gicv3_its_common_reset;
+    c->parent_reset = gicv3_its_common_reset;
     dc->vmsd = &vmstate_its;
 }
 
diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 120b86d..3c2e724 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -156,10 +156,6 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
     Error *err = NULL;
     int i;
 
-    if (!s->iidr) {
-        return;
-    }
-
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
                       GITS_IIDR, &s->iidr, true, &error_abort);
 
@@ -195,6 +191,23 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
                       GITS_CTLR, &s->ctlr, true, &error_abort);
 }
 
+static void kvm_arm_its_reset(DeviceState *dev)
+{
+    GICv3ITSState *s = ARM_GICV3_ITS_COMMON(dev);
+    GICv3ITSCommonClass *c = ARM_GICV3_ITS_COMMON_GET_CLASS(s);
+
+    c->parent_reset(dev);
+
+    if (!kvm_device_check_attr(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                               KVM_DEV_ARM_ITS_CTRL_RESET)) {
+        error_report("ITS KVM: reset is not supported by the kernel");
+        return;
+    }
+
+    kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_CTRL,
+                      KVM_DEV_ARM_ITS_CTRL_RESET, NULL, true, &error_abort);
+}
+
 static Property kvm_arm_its_props[] = {
     DEFINE_PROP_LINK("parent-gicv3", GICv3ITSState, gicv3, "kvm-arm-gicv3",
                      GICv3State *),
@@ -211,6 +224,7 @@ static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
     icc->send_msi = kvm_its_send_msi;
     icc->pre_save = kvm_arm_its_pre_save;
     icc->post_load = kvm_arm_its_post_load;
+    dc->reset = kvm_arm_its_reset;
 }
 
 static const TypeInfo kvm_arm_its_info = {
diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index fd1fe64..c158e9f 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -79,6 +79,7 @@ struct GICv3ITSCommonClass {
     int (*send_msi)(GICv3ITSState *s, uint32_t data, uint16_t devid);
     void (*pre_save)(GICv3ITSState *s);
     void (*post_load)(GICv3ITSState *s);
+    void (*parent_reset)(DeviceState *dev);
 };
 
 typedef struct GICv3ITSCommonClass GICv3ITSCommonClass;
-- 
2.5.5
