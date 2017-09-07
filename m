Received: from eggs.gnu.org ([2001:4830:134:3::10]:56439)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwr3-000103-2N
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqx-0007dy-Ut
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:25 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dpwqx-0007Xf-Nv
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 09:28:19 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1dpwqj-0001VW-S5
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 14:28:05 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu,  7 Sep 2017 14:27:56 +0100
Message-Id: <1504790904-17018-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
References: <1504790904-17018-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 03/31] gicv3: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-id: 20170905131149.10669-4-famz@redhat.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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
2.7.4
