Received: from eggs.gnu.org ([2001:4830:134:3::10]:34045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvi-0000RR-6D
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dWvvh-0001XO-Eo
	for qemu-devel@nongnu.org; Sun, 16 Jul 2017 22:38:38 -0400
From: Fam Zheng <famz@redhat.com>
Date: Mon, 17 Jul 2017 10:38:21 +0800
Message-Id: <20170717023824.18796-4-famz@redhat.com>
In-Reply-To: <20170717023824.18796-1-famz@redhat.com>
References: <20170717023824.18796-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v5 3/6] gicv3: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/intc/arm_gicv3_its_kvm.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 1f8991b..39903d5 100644
--- a/hw/intc/arm_gicv3_its_kvm.c
+++ b/hw/intc/arm_gicv3_its_kvm.c
@@ -120,17 +120,6 @@ static void kvm_arm_its_realize(DeviceState *dev, Error **errp)
     qemu_add_vm_change_state_handler(vm_change_state_handler, s);
 }
 
-static void kvm_arm_its_init(Object *obj)
-{
-    GICv3ITSState *s = KVM_ARM_ITS(obj);
-
-    object_property_add_link(obj, "parent-gicv3",
-                             "kvm-arm-gicv3", (Object **)&s->gicv3,
-                             object_property_allow_set_link,
-                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
-                             &error_abort);
-}
-
 /**
  * kvm_arm_its_pre_save - handles the saving of ITS registers.
  * ITS tables are flushed into guest RAM separately and earlier,
@@ -205,12 +194,19 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
                       GITS_CTLR, &s->ctlr, true, &error_abort);
 }
 
+static Property kvm_arm_its_props[] = {
+    DEFINE_PROP_LINK("parent-gicv3", GICv3ITSState, gicv3, "kvm-arm-gicv3",
+                     GICv3State *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void kvm_arm_its_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     GICv3ITSCommonClass *icc = ARM_GICV3_ITS_COMMON_CLASS(klass);
 
     dc->realize = kvm_arm_its_realize;
+    dc->props   = kvm_arm_its_props;
     icc->send_msi = kvm_its_send_msi;
     icc->pre_save = kvm_arm_its_pre_save;
     icc->post_load = kvm_arm_its_post_load;
@@ -220,7 +216,6 @@ static const TypeInfo kvm_arm_its_info = {
     .name = TYPE_KVM_ARM_ITS,
     .parent = TYPE_ARM_GICV3_ITS_COMMON,
     .instance_size = sizeof(GICv3ITSState),
-    .instance_init = kvm_arm_its_init,
     .class_init = kvm_arm_its_class_init,
 };
 
-- 
2.9.4
