Received: from eggs.gnu.org ([209.51.188.92]:50923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqr-0004Dp-9d
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1gubqq-0005hs-Dq
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:17 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40424)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1gubqo-0005dU-K7
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:40:16 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1FBY0MC100727
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:12 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qnt977ryt-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 06:40:12 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 15 Feb 2019 11:40:10 -0000
From: Greg Kurz <groug@kaod.org>
Date: Fri, 15 Feb 2019 12:40:06 +0100
In-Reply-To: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
References: <155023078266.1011724.5995737218088270486.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155023080638.1011724.792095453419098948.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH 04/10] spapr/irq: Use the base ICP class for KVM
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

The base ICP class knows how to interact with KVM. Adapt sPAPR to use it
instead of the ICP KVM class.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr_irq.c     |    4 +---
 include/hw/ppc/spapr.h |    1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 48d6b2daed6e..e6893df61e76 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -102,7 +102,6 @@ static void spapr_irq_init_xics(sPAPRMachineState *spapr, int nr_irqs,
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
             !xics_kvm_init(spapr, &local_err)) {
-            spapr->icp_type = TYPE_KVM_ICP;
             spapr->ics = spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs,
                                           &local_err);
         }
@@ -117,7 +116,6 @@ static void spapr_irq_init_xics(sPAPRMachineState *spapr, int nr_irqs,
 
     if (!spapr->ics) {
         xics_spapr_init(spapr);
-        spapr->icp_type = TYPE_ICP;
         spapr->ics = spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
                                       &local_err);
     }
@@ -199,7 +197,7 @@ static void spapr_irq_cpu_intc_create_xics(sPAPRMachineState *spapr,
     Object *obj;
     sPAPRCPUState *spapr_cpu = spapr_cpu_state(cpu);
 
-    obj = icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(spapr),
+    obj = icp_create(OBJECT(cpu), TYPE_ICP, XICS_FABRIC(spapr),
                      &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index cbd276ed2b6a..631fc5103b7b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -178,7 +178,6 @@ struct sPAPRMachineState {
     /*< public >*/
     char *kvm_type;
 
-    const char *icp_type;
     int32_t irq_map_nr;
     unsigned long *irq_map;
     sPAPRXive  *xive;
