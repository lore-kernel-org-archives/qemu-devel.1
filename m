Received: from eggs.gnu.org ([2001:4830:134:3::10]:60587)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDeE-00012Q-Qj
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gaDeB-0008Nr-C9
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 00:46:58 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 21 Dec 2018 16:45:47 +1100
Message-Id: <20181221054606.22007-22-david@gibson.dropbear.id.au>
In-Reply-To: <20181221054606.22007-1-david@gibson.dropbear.id.au>
References: <20181221054606.22007-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 21/40] spapr: introduce a spapr_irq_init()
 routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, gkurz@redhat.com, lvivier@redhat.com, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Initialize the MSI bitmap from it as this will be necessary for the
sPAPR IRQ backend for XIVE.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c             |  2 +-
 hw/ppc/spapr_irq.c         | 16 +++++++++++-----
 include/hw/ppc/spapr_irq.h |  1 +
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2b2df6b848..c1c0e75fcd 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2593,7 +2593,7 @@ static void spapr_machine_init(MachineState *machin=
e)
     spapr_set_vsmt_mode(spapr, &error_fatal);
=20
     /* Set up Interrupt Controller before we create the VCPUs */
-    smc->irq->init(spapr, &error_fatal);
+    spapr_irq_init(spapr, &error_fatal);
=20
     /* Set up containers for ibm,client-architecture-support negotiated =
options
      */
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index e77b94cc68..f8b651de0e 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -97,11 +97,6 @@ static void spapr_irq_init_xics(sPAPRMachineState *spa=
pr, Error **errp)
     int nr_irqs =3D smc->irq->nr_irqs;
     Error *local_err =3D NULL;
=20
-    /* Initialize the MSI IRQ allocator. */
-    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
-    }
-
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
             !xics_kvm_init(spapr, &local_err)) {
@@ -213,6 +208,17 @@ sPAPRIrq spapr_irq_xics =3D {
 /*
  * sPAPR IRQ frontend routines for devices
  */
+void spapr_irq_init(sPAPRMachineState *spapr, Error **errp)
+{
+    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
+
+    /* Initialize the MSI IRQ allocator. */
+    if (!SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
+        spapr_irq_msi_init(spapr, smc->irq->nr_msis);
+    }
+
+    smc->irq->init(spapr, errp);
+}
=20
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp)
 {
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index a467ce696e..bd7301e6d9 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -43,6 +43,7 @@ typedef struct sPAPRIrq {
 extern sPAPRIrq spapr_irq_xics;
 extern sPAPRIrq spapr_irq_xics_legacy;
=20
+void spapr_irq_init(sPAPRMachineState *spapr, Error **errp);
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
 qemu_irq spapr_qirq(sPAPRMachineState *spapr, int irq);
--=20
2.19.2
