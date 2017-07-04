Received: from eggs.gnu.org ([2001:4830:134:3::10]:41777)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZP-0004Bn-SC
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dSHZO-00038P-Ue
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47650)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dSHZO-00037z-OU
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:44:22 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A43ADC04B924
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 06:44:21 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Tue,  4 Jul 2017 14:43:41 +0800
Message-Id: <20170704064347.7022-15-famz@redhat.com>
In-Reply-To: <20170704064347.7022-1-famz@redhat.com>
References: <20170704064347.7022-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v3 14/20] gicv3: Convert to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 hw/intc/arm_gicv3_its_kvm.c            | 18 ++++++------------
 include/hw/intc/arm_gicv3_its_common.h |  3 ++-
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/hw/intc/arm_gicv3_its_kvm.c b/hw/intc/arm_gicv3_its_kvm.c
index 1f8991b..5520c28 100644
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
@@ -205,12 +194,18 @@ static void kvm_arm_its_post_load(GICv3ITSState *s)
                       GITS_CTLR, &s->ctlr, true, &error_abort);
 }
 
+static Property kvm_arm_its_props[] = {
+    DEFINE_PROP_LINK("parent-gicv3", GICv3ITSState, gicv3, "kvm-arm-gicv3"),
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
@@ -220,7 +215,6 @@ static const TypeInfo kvm_arm_its_info = {
     .name = TYPE_KVM_ARM_ITS,
     .parent = TYPE_ARM_GICV3_ITS_COMMON,
     .instance_size = sizeof(GICv3ITSState),
-    .instance_init = kvm_arm_its_init,
     .class_init = kvm_arm_its_class_init,
 };
 
diff --git a/include/hw/intc/arm_gicv3_its_common.h b/include/hw/intc/arm_gicv3_its_common.h
index fd1fe64..29ec114 100644
--- a/include/hw/intc/arm_gicv3_its_common.h
+++ b/include/hw/intc/arm_gicv3_its_common.h
@@ -42,7 +42,8 @@ struct GICv3ITSState {
     MemoryRegion iomem_its_cntrl;
     MemoryRegion iomem_its_translation;
 
-    GICv3State *gicv3;
+    /* GICv3State pointer to be filled by link property */
+    Object *gicv3;
 
     int dev_fd; /* kvm device fd if backed by kvm vgic support */
     uint64_t gits_translater_gpa;
-- 
2.9.4
