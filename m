Received: from eggs.gnu.org ([2001:4830:134:3::10]:57285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e6elv-0002kH-J9
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:36:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1e6elu-0004ld-JK
	for qemu-devel@nongnu.org; Mon, 23 Oct 2017 11:36:11 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Mon, 23 Oct 2017 17:35:35 +0200
Message-Id: <1508772937-21054-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1508772937-21054-1-git-send-email-eric.auger@redhat.com>
References: <1508772937-21054-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v2 2/4] hw/intc/arm_gicv3_its: Implement a
 minimalist reset
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

At the moment the ITS is not properly reset and this causes
various bugs on save/restore. We implement a minimalist cold reset
through individual register writes. This does not void the ITS cache
though. This full reset will be addressed through a specific ioctl.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---

this patch would deserve being cc'ed stable (2.10)
This goes along with patches 1-5 of
[PATCH v5 00/10] vITS Migration fixes and reset, candidate
for being cc'ed stable
---
 hw/intc/arm_gicv3_its_kvm.c | 35 ++++++++++++++++++++++++++++++++++-
 1 file changed, 34 insertions(+), 1 deletion(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 1ae205f..537cea1 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -28,6 +28,16 @@
 
 #define TYPE_KVM_ARM_ITS "arm-its-kvm"
 #define KVM_ARM_ITS(obj) OBJECT_CHECK(GICv3ITSState, (obj), TYPE_KVM_ARM_ITS)
+#define KVM_ARM_ITS_CLASS(klass) \
+     OBJECT_CLASS_CHECK(KVMARMITSClass, (klass), TYPE_KVM_ARM_ITS)
+#define KVM_ARM_ITS_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(KVMARMITSClass, (obj), TYPE_KVM_ARM_ITS)
+
+typedef struct KVMARMITSClass {
+    GICv3ITSCommonClass parent_class;
+    void (*parent_reset)(DeviceState *dev);
+} KVMARMITSClass;
+
 
 static int kvm_its_send_msi(GICv3ITSState *s, uint32_t value, uint16_t devid)
 {
@@ -153,12 +163,25 @@ static void kvm_arm_its_pre_save(GICv3ITSState *s)
  */
 static void kvm_arm_its_post_load(GICv3ITSState *s)
 {
+    bool cold_reset = !s->iidr;
     int i;
 
-    if (!s->iidr) {
+    if (cold_reset) {
+        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                          GITS_CTLR, &s->ctlr, true, &error_abort);
+
+        kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                          GITS_CBASER, &s->cbaser, true, &error_abort);
+
+        for (i = 0; i < 8; i++) {
+            kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
+                              GITS_BASER + i * 8, &s->baser[i], true,
+                              &error_abort);
+        }
         return;
     }
 
+    /* restore */
     kvm_device_access(s->dev_fd, KVM_DEV_ARM_VGIC_GRP_ITS_REGS,
                       GITS_IIDR, &s->iidr, true, &error_abort);
 
@@ -190,6 +213,13 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
                       GITS_CTLR, &s->ctlr, true, &error_abort);
 }
 
+static void kvm_arm_its_reset(DeviceState *dev)
+{
+    KVMARMITSClass *c = KVM_ARM_ITS_GET_CLASS(s);
+
+    c->parent_reset(dev);
+}
+
 static Property kvm_arm_its_props[] = {
     DEFINE_PROP_LINK("parent-gicv3", GICv3ITSState, gicv3, "kvm-arm-gicv3",
                      GICv3State *),
@@ -200,12 +230,15 @@ static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     GICv3ITSCommonClass *icc = ARM_GICV3_ITS_COMMON_CLASS(klass);
+    KVMARMITSClass *ic = KVM_ARM_ITS_CLASS(klass);
 
     dc->realize = kvm_arm_its_realize;
     dc->props   = kvm_arm_its_props;
+    ic->parent_reset = dc->reset;
     icc->send_msi = kvm_its_send_msi;
     icc->pre_save = kvm_arm_its_pre_save;
     icc->post_load = kvm_arm_its_post_load;
+    dc->reset = kvm_arm_its_reset;
 }
 
 static const TypeInfo kvm_arm_its_info = {
-- 
2.5.5
