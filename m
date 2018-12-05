Received: from eggs.gnu.org ([2001:4830:134:3::10]:44017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgWp-0006je-Ut
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgWm-0003HL-3D
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:27 -0500
Received: from 5.mo177.mail-out.ovh.net ([46.105.39.154]:37548)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgWj-0003EE-VS
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:23 -0500
Received: from player714.ha.ovh.net (unknown [10.109.143.146])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 90C3BD5DD1
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:24:16 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:27 +0100
Message-Id: <20181205232251.10446-14-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 13/37] spapr: introduce a spapr_irq_init()
 routine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Initialize the MSI bitmap from it as this will be necessary for the
sPAPR IRQ backend for XIVE.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 include/hw/ppc/spapr_irq.h |  1 +
 hw/ppc/spapr.c             |  2 +-
 hw/ppc/spapr_irq.c         | 16 +++++++++++-----
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index a467ce696ee4..bd7301e6d9c6 100644
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
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 50cb9f9f4a02..e470efe7993c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2594,7 +2594,7 @@ static void spapr_machine_init(MachineState *machin=
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
index e77b94cc685e..f8b651de0ec9 100644
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
--=20
2.17.2
