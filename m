Received: from eggs.gnu.org ([209.51.188.92]:39406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxw-0006cd-FU
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxt-0003CD-MP
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:16 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:26 +1100
Message-Id: <20190218143049.17142-21-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/43] spapr/irq: Use the base ICP class for KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: Greg Kurz <groug@kaod.org>

The base ICP class knows how to interact with KVM. Adapt sPAPR to use it
instead of the ICP KVM class.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155023080638.1011724.792095453419098948.stgit@bahia.lan>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c     | 4 +---
 include/hw/ppc/spapr.h | 1 -
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 48d6b2daed..e6893df61e 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -102,7 +102,6 @@ static void spapr_irq_init_xics(sPAPRMachineState *sp=
apr, int nr_irqs,
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
             !xics_kvm_init(spapr, &local_err)) {
-            spapr->icp_type =3D TYPE_KVM_ICP;
             spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
,
                                           &local_err);
         }
@@ -117,7 +116,6 @@ static void spapr_irq_init_xics(sPAPRMachineState *sp=
apr, int nr_irqs,
=20
     if (!spapr->ics) {
         xics_spapr_init(spapr);
-        spapr->icp_type =3D TYPE_ICP;
         spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
                                       &local_err);
     }
@@ -199,7 +197,7 @@ static void spapr_irq_cpu_intc_create_xics(sPAPRMachi=
neState *spapr,
     Object *obj;
     sPAPRCPUState *spapr_cpu =3D spapr_cpu_state(cpu);
=20
-    obj =3D icp_create(OBJECT(cpu), spapr->icp_type, XICS_FABRIC(spapr),
+    obj =3D icp_create(OBJECT(cpu), TYPE_ICP, XICS_FABRIC(spapr),
                      &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index cbd276ed2b..631fc5103b 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -178,7 +178,6 @@ struct sPAPRMachineState {
     /*< public >*/
     char *kvm_type;
=20
-    const char *icp_type;
     int32_t irq_map_nr;
     unsigned long *irq_map;
     sPAPRXive  *xive;
--=20
2.20.1
