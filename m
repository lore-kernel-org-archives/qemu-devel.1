Received: from eggs.gnu.org ([2001:4830:134:3::10]:52670)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1figSr-0000VN-Uj
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:38:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1figSo-0001Y3-Vh
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:37:57 -0400
Received: from 3.mo4.mail-out.ovh.net ([46.105.57.129]:39220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1figSo-0001Wj-Ok
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 09:37:54 -0400
Received: from player687.ha.ovh.net (unknown [10.109.146.137])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 441BB189FDD
	for <qemu-devel@nongnu.org>; Thu, 26 Jul 2018 15:37:53 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 26 Jul 2018 15:37:23 +0200
Message-Id: <20180726133723.17041-4-clg@kaod.org>
In-Reply-To: <20180726133723.17041-1-clg@kaod.org>
References: <20180726133723.17041-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v5 3/3] spapr: increase the size of the IRQ
 number space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The new layout using static IRQ number does not leave much space to
the dynamic MSI range, only 0x100 IRQ numbers. Increase the total
number of IRQS for newer machines and introduce a legacy XICS backend
for pre-3.1 machines to maintain compatibility.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h |  1 +
 hw/ppc/spapr.c             |  1 +
 hw/ppc/spapr_irq.c         | 12 +++++++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 0e98c4474bb2..626160ba475e 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -40,6 +40,7 @@ typedef struct sPAPRIrq {
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_xics;
+extern sPAPRIrq spapr_irq_xics_legacy;
=20
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 693144e40d49..44b7423ebeaa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3926,6 +3926,7 @@ static void spapr_machine_3_0_class_options(Machine=
Class *mc)
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
=20
     smc->legacy_irq_allocation =3D true;
+    smc->irq =3D &spapr_irq_xics_legacy;
 }
=20
 DEFINE_SPAPR_MACHINE(3_0, "3.0", true);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 0cbb5dd39368..620c49b38455 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -196,7 +196,7 @@ static void spapr_irq_print_info_xics(sPAPRMachineSta=
te *spapr, Monitor *mon)
 }
=20
 sPAPRIrq spapr_irq_xics =3D {
-    .nr_irqs     =3D XICS_IRQS_SPAPR,
+    .nr_irqs     =3D 0x1000,
=20
     .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
@@ -284,3 +284,13 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num=
, bool align, Error **errp)
=20
     return first + ics->offset;
 }
+
+sPAPRIrq spapr_irq_xics_legacy =3D {
+    .nr_irqs     =3D XICS_IRQS_SPAPR,
+
+    .init        =3D spapr_irq_init_xics,
+    .claim       =3D spapr_irq_claim_xics,
+    .free        =3D spapr_irq_free_xics,
+    .qirq        =3D spapr_qirq_xics,
+    .print_info  =3D spapr_irq_print_info_xics,
+};
--=20
2.17.1
