Received: from eggs.gnu.org ([2001:4830:134:3::10]:36565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVHIi-0007da-8X
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:08:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVHId-0002nz-5B
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:08:04 -0400
Received: from 19.mo7.mail-out.ovh.net ([178.33.251.118]:38006)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVHIc-0002mL-Vg
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 10:07:59 -0400
Received: from player786.ha.ovh.net (unknown [10.109.120.22])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 7235CB49D7
	for <qemu-devel@nongnu.org>; Tue, 19 Jun 2018 16:07:57 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Tue, 19 Jun 2018 16:07:29 +0200
Message-Id: <20180619140729.21949-4-clg@kaod.org>
In-Reply-To: <20180619140729.21949-1-clg@kaod.org>
References: <20180619140729.21949-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 3/3] spapr: increase the size of the IRQ
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
for pre-3.0 machines to maintain compatibility.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h |  1 +
 hw/ppc/spapr.c             |  1 +
 hw/ppc/spapr_irq.c         | 12 +++++++++++-
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index f2ae0ac0e6cb..f02544934c93 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -38,6 +38,7 @@ typedef struct sPAPRIrq {
 } sPAPRIrq;
=20
 extern sPAPRIrq spapr_irq_xics;
+extern sPAPRIrq spapr_irq_xics_legacy;
=20
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp);
 void spapr_irq_free(sPAPRMachineState *spapr, int irq, int num);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ec21df432380..fb3ba90eaefa 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3964,6 +3964,7 @@ static void spapr_machine_2_12_class_options(Machin=
eClass *mc)
=20
     spapr_machine_3_0_class_options(mc);
     SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
+    smc->irq =3D &spapr_irq_xics_legacy;
     smc->legacy_irq_allocation =3D true;
 }
=20
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index e50a512a2d9c..603541f175bd 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -197,7 +197,7 @@ static void spapr_irq_print_info_xics(sPAPRMachineSta=
te *spapr,
 }
=20
 sPAPRIrq spapr_irq_xics =3D {
-    .nr_irqs     =3D XICS_IRQS_SPAPR,
+    .nr_irqs     =3D 0x1000,
=20
     .init        =3D spapr_irq_init_xics,
     .claim       =3D spapr_irq_claim_xics,
@@ -285,3 +285,13 @@ int spapr_irq_find(sPAPRMachineState *spapr, int num=
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
2.13.6
