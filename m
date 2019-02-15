Received: from eggs.gnu.org ([209.51.188.92]:51028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubrQ-0004kj-04
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubrM-0006Av-6m
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56836)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gubrG-0005tw-Iy
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:46 -0500
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FBXvd0030896
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:26 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qnt8sq7t4-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:26 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 15 Feb 2019 11:40:23 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Feb 2019 12:40:18 +0100
In-Reply-To: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155023081817.1011724.14078777320394028836.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 06/10] xics: Explicitely call KVM ICS methods
 from the common code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?utf-8?q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

The pre_save(), post_load() and synchronize_state() methods of the
ICSStateClass type are really KVM only things. Make that obvious
by dropping the indirections and directly calling the KVM functions
instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics.c        |   23 ++++++++++-------------
 hw/intc/xics_kvm.c    |   12 ++++--------
 include/hw/ppc/xics.h |    7 ++++---
 3 files changed, 18 insertions(+), 24 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index acd63ab5e0b9..ae5d5ea135b8 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -58,7 +58,6 @@ void icp_pic_print_info(ICPState *icp, Monitor *mon)
 
 void ics_pic_print_info(ICSState *ics, Monitor *mon)
 {
-    ICSStateClass *icsc = ICS_BASE_GET_CLASS(ics);
     uint32_t i;
 
     monitor_printf(mon, "ICS %4x..%4x %p\n",
@@ -68,8 +67,8 @@ void ics_pic_print_info(ICSState *ics, Monitor *mon)
         return;
     }
 
-    if (icsc->synchronize_state) {
-        icsc->synchronize_state(ics);
+    if (kvm_irqchip_in_kernel()) {
+        ics_synchronize_state(ics);
     }
 
     for (i = 0; i < ics->nr_irqs; i++) {
@@ -647,25 +646,23 @@ static void ics_base_instance_init(Object *obj)
     ics->offset = XICS_IRQ_BASE;
 }
 
-static int ics_base_dispatch_pre_save(void *opaque)
+static int ics_base_pre_save(void *opaque)
 {
     ICSState *ics = opaque;
-    ICSStateClass *info = ICS_BASE_GET_CLASS(ics);
 
-    if (info->pre_save) {
-        info->pre_save(ics);
+    if (kvm_irqchip_in_kernel()) {
+        ics_get_kvm_state(ics);
     }
 
     return 0;
 }
 
-static int ics_base_dispatch_post_load(void *opaque, int version_id)
+static int ics_base_post_load(void *opaque, int version_id)
 {
     ICSState *ics = opaque;
-    ICSStateClass *info = ICS_BASE_GET_CLASS(ics);
 
-    if (info->post_load) {
-        return info->post_load(ics, version_id);
+    if (kvm_irqchip_in_kernel()) {
+        return ics_set_kvm_state(ics);
     }
 
     return 0;
@@ -689,8 +686,8 @@ static const VMStateDescription vmstate_ics_base = {
     .name = "ics",
     .version_id = 1,
     .minimum_version_id = 1,
-    .pre_save = ics_base_dispatch_pre_save,
-    .post_load = ics_base_dispatch_post_load,
+    .pre_save = ics_base_pre_save,
+    .post_load = ics_base_post_load,
     .fields = (VMStateField[]) {
         /* Sanity check */
         VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index fae4ac431f2f..642351e5790f 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -155,7 +155,7 @@ void icp_kvm_realize(DeviceState *dev, Error **errp)
 /*
  * ICS-KVM
  */
-static void ics_get_kvm_state(ICSState *ics)
+void ics_get_kvm_state(ICSState *ics)
 {
     uint64_t state;
     int i;
@@ -208,12 +208,12 @@ static void ics_get_kvm_state(ICSState *ics)
     }
 }
 
-static void ics_synchronize_state(ICSState *ics)
+void ics_synchronize_state(ICSState *ics)
 {
     ics_get_kvm_state(ics);
 }
 
-static int ics_set_kvm_state(ICSState *ics, int version_id)
+int ics_set_kvm_state(ICSState *ics)
 {
     uint64_t state;
     int i;
@@ -286,7 +286,7 @@ static void ics_kvm_reset(DeviceState *dev)
 
     icsc->parent_reset(dev);
 
-    ics_set_kvm_state(ICS_KVM(dev), 1);
+    ics_set_kvm_state(ICS_KVM(dev));
 }
 
 static void ics_kvm_reset_handler(void *dev)
@@ -318,10 +318,6 @@ static void ics_kvm_class_init(ObjectClass *klass, void *data)
                                     &icsc->parent_realize);
     device_class_set_parent_reset(dc, ics_kvm_reset,
                                   &icsc->parent_reset);
-
-    icsc->pre_save = ics_get_kvm_state;
-    icsc->post_load = ics_set_kvm_state;
-    icsc->synchronize_state = ics_synchronize_state;
 }
 
 static const TypeInfo ics_kvm_info = {
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index fae54e6f28ae..06e87128f88e 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -109,12 +109,9 @@ struct ICSStateClass {
     DeviceRealize parent_realize;
     DeviceReset parent_reset;
 
-    void (*pre_save)(ICSState *s);
-    int (*post_load)(ICSState *s, int version_id);
     void (*reject)(ICSState *s, uint32_t irq);
     void (*resend)(ICSState *s);
     void (*eoi)(ICSState *s, uint32_t irq);
-    void (*synchronize_state)(ICSState *s);
 };
 
 struct ICSState {
@@ -201,4 +198,8 @@ int icp_set_kvm_state(ICPState *icp);
 void icp_synchronize_state(ICPState *icp);
 void icp_kvm_realize(DeviceState *dev, Error **errp);
 
+void ics_get_kvm_state(ICSState *ics);
+int ics_set_kvm_state(ICSState *ics);
+void ics_synchronize_state(ICSState *ics);
+
 #endif /* XICS_H */
