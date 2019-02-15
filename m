Received: from eggs.gnu.org ([209.51.188.92]:51117)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubrW-0004q9-NV
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubrU-0006Ke-GA
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:58 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49592
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gubrU-000672-5n
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:56 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FBXvxW009041
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:43 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2qnvc2s1vb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:43 -0500
Received: from localhost
	by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 15 Feb 2019 11:40:41 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Feb 2019 12:40:35 +0100
In-Reply-To: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155023083585.1011724.2868047424353921455.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 09/10] spapr/irq: Use the "simple" ICS class
 for KVM
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

The "simple" ICS class knows how to interract with KVM. Adapt sPAPR to use
it instead of the ICS KVM class.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_irq.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 9f43b7b3bf16..4aa8165307c7 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -67,13 +67,12 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr)
  */
 
 static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
-                                  const char *type_ics,
                                   int nr_irqs, Error **errp)
 {
     Error *local_err = NULL;
     Object *obj;
 
-    obj = object_new(type_ics);
+    obj = object_new(TYPE_ICS_SIMPLE);
     object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
     object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
                                    &error_abort);
@@ -98,14 +97,14 @@ static void spapr_irq_init_xics(sPAPRMachineState *spapr, int nr_irqs,
 {
     MachineState *machine = MACHINE(spapr);
     Error *local_err = NULL;
+    bool xics_kvm = false;
 
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
             !xics_kvm_init(spapr, &local_err)) {
-            spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
-                                          &local_err);
+            xics_kvm = true;
         }
-        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
+        if (machine_kernel_irqchip_required(machine) && !xics_kvm) {
             error_prepend(&local_err,
                           "kernel_irqchip requested but unavailable: ");
             goto error;
@@ -114,12 +113,12 @@ static void spapr_irq_init_xics(sPAPRMachineState *spapr, int nr_irqs,
         local_err = NULL;
     }
 
-    if (!spapr->ics) {
+    if (!xics_kvm) {
         xics_spapr_init(spapr);
-        spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
-                                      &local_err);
     }
 
+    spapr->ics = spapr_ics_create(spapr, nr_irqs, &local_err);
+
 error:
     error_propagate(errp, local_err);
 }
