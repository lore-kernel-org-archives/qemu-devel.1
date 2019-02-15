Received: from eggs.gnu.org ([209.51.188.92]:51103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubrW-0004pW-CU
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubrU-0006KN-Ad
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40602
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gubrT-0006AJ-LI
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:56 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FBXvT4080813
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:47 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qnt8tf4a5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:47 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 15 Feb 2019 11:40:45 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Feb 2019 12:40:41 +0100
In-Reply-To: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155023084177.1011724.14693955932559990358.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 10/10] xics: Drop the KVM ICS class
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

The KVM ICS class isn't used anymore. Drop it.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/intc/xics_kvm.c    |   40 ----------------------------------------
 hw/ppc/spapr_irq.c    |    2 +-
 include/hw/ppc/xics.h |    3 ---
 3 files changed, 1 insertion(+), 44 deletions(-)

diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index f34eacda03e7..a00d0a7962e1 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -279,39 +279,6 @@ void ics_kvm_set_irq(ICSState *ics, int srcno, int val)
     }
 }
 
-static void ics_kvm_realize(DeviceState *dev, Error **errp)
-{
-    ICSState *ics = ICS_KVM(dev);
-    ICSStateClass *icsc = ICS_BASE_GET_CLASS(ics);
-    Error *local_err = NULL;
-
-    icsc->parent_realize(dev, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        return;
-    }
-}
-
-static void ics_kvm_class_init(ObjectClass *klass, void *data)
-{
-    ICSStateClass *icsc = ICS_BASE_CLASS(klass);
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    device_class_set_parent_realize(dc, ics_kvm_realize,
-                                    &icsc->parent_realize);
-}
-
-static const TypeInfo ics_kvm_info = {
-    .name = TYPE_ICS_KVM,
-    .parent = TYPE_ICS_BASE,
-    .instance_size = sizeof(ICSState),
-    .class_init = ics_kvm_class_init,
-};
-
-/*
- * XICS-KVM
- */
-
 static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                        uint32_t token,
                        uint32_t nargs, target_ulong args,
@@ -381,10 +348,3 @@ fail:
     kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
     return -1;
 }
-
-static void xics_kvm_register_types(void)
-{
-    type_register_static(&ics_kvm_info);
-}
-
-type_init(xics_kvm_register_types)
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 4aa8165307c7..4297eed600f9 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -208,7 +208,7 @@ static void spapr_irq_cpu_intc_create_xics(sPAPRMachineState *spapr,
 
 static int spapr_irq_post_load_xics(sPAPRMachineState *spapr, int version_id)
 {
-    if (!object_dynamic_cast(OBJECT(spapr->ics), TYPE_ICS_KVM)) {
+    if (!kvm_irqchip_in_kernel()) {
         CPUState *cs;
         CPU_FOREACH(cs) {
             PowerPCCPU *cpu = POWERPC_CPU(cs);
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 61bd0fb9784f..d36bbe11ee2e 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -95,9 +95,6 @@ struct PnvICPState {
 #define TYPE_ICS_SIMPLE "ics"
 #define ICS_SIMPLE(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_SIMPLE)
 
-#define TYPE_ICS_KVM "icskvm"
-#define ICS_KVM(obj) OBJECT_CHECK(ICSState, (obj), TYPE_ICS_KVM)
-
 #define ICS_BASE_CLASS(klass) \
      OBJECT_CLASS_CHECK(ICSStateClass, (klass), TYPE_ICS_BASE)
 #define ICS_BASE_GET_CLASS(obj) \
