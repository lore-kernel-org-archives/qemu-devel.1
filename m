Received: from eggs.gnu.org ([2001:4830:134:3::10]:44084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgWs-0006lo-5F
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gUgWn-0003IG-Sl
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:29 -0500
Received: from 7.mo4.mail-out.ovh.net ([178.33.253.54]:46813)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gUgWl-0003G3-Tn
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 18:24:24 -0500
Received: from player714.ha.ovh.net (unknown [10.109.160.239])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id C03A11C4631
	for <qemu-devel@nongnu.org>; Thu,  6 Dec 2018 00:24:21 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  6 Dec 2018 00:22:28 +0100
Message-Id: <20181205232251.10446-15-clg@kaod.org>
In-Reply-To: <20181205232251.10446-1-clg@kaod.org>
References: <20181205232251.10446-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 14/37] spapr: modify the irq backend 'init'
 method
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

Add a 'nr_irqs' parameter to the 'init' method to remove the use of
the machine class. This will be useful when we introduce the machine
supporting the two sPAPR IRQ backends : XICS and XIVE.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/spapr_irq.h | 2 +-
 hw/ppc/spapr_irq.c         | 7 +++----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index bd7301e6d9c6..0e9229bf219e 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -33,7 +33,7 @@ typedef struct sPAPRIrq {
     uint32_t    nr_irqs;
     uint32_t    nr_msis;
=20
-    void (*init)(sPAPRMachineState *spapr, Error **errp);
+    void (*init)(sPAPRMachineState *spapr, int nr_irqs, Error **errp);
     int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **er=
rp);
     void (*free)(sPAPRMachineState *spapr, int irq, int num);
     qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index f8b651de0ec9..bac450ffff23 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -90,11 +90,10 @@ error:
     return NULL;
 }
=20
-static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **errp)
+static void spapr_irq_init_xics(sPAPRMachineState *spapr, int nr_irqs,
+                                Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
-    sPAPRMachineClass *smc =3D SPAPR_MACHINE_GET_CLASS(spapr);
-    int nr_irqs =3D smc->irq->nr_irqs;
     Error *local_err =3D NULL;
=20
     if (kvm_enabled()) {
@@ -217,7 +216,7 @@ void spapr_irq_init(sPAPRMachineState *spapr, Error *=
*errp)
         spapr_irq_msi_init(spapr, smc->irq->nr_msis);
     }
=20
-    smc->irq->init(spapr, errp);
+    smc->irq->init(spapr, smc->irq->nr_irqs, errp);
 }
=20
 int spapr_irq_claim(sPAPRMachineState *spapr, int irq, bool lsi, Error *=
*errp)
--=20
2.17.2
