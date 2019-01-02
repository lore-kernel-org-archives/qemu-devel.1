Received: from eggs.gnu.org ([208.118.235.92]:48858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1geZYJ-0003JX-M4
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:58:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1geZYG-0006JI-Gx
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:58:51 -0500
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:54644)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1geZYG-0006In-AR
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 00:58:48 -0500
Received: from player773.ha.ovh.net (unknown [10.109.159.222])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0E5F41EE0A0
	for <qemu-devel@nongnu.org>; Wed,  2 Jan 2019 06:58:47 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  2 Jan 2019 06:57:39 +0100
Message-Id: <20190102055743.5052-7-clg@kaod.org>
In-Reply-To: <20190102055743.5052-1-clg@kaod.org>
References: <20190102055743.5052-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 06/10] pnv/psi: move the ICSState qemu_irq
 array under the PSI device model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

Future changes of the ICSState object will remove the qemu_irq array
from under the interrupt controller model. Prepare ground for the PSI
interrupt sources and introduce a new one directly under the PSI
device model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_psi.h | 1 +
 hw/ppc/pnv_psi.c         | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index f6af5eae1fa8..64ac73512e81 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -40,6 +40,7 @@ typedef struct PnvPsi {
=20
     /* Interrupt generation */
     ICSState ics;
+    qemu_irq *qirqs;
=20
     /* Registers */
     uint64_t regs[PSIHB_XSCOM_MAX];
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5b969127c303..8ced09506321 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -207,7 +207,6 @@ static const uint64_t stat_bits[] =3D {
=20
 void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool state)
 {
-    ICSState *ics =3D &psi->ics;
     uint32_t xivr_reg;
     uint32_t stat_reg;
     uint32_t src;
@@ -227,14 +226,14 @@ void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bo=
ol state)
         /* TODO: optimization, check mask here. That means
          * re-evaluating when unmasking
          */
-        qemu_irq_raise(ics->qirqs[src]);
+        qemu_irq_raise(psi->qirqs[src]);
     } else {
         psi->regs[stat_reg] &=3D ~stat_bits[irq];
=20
         /* FSP and PSI are muxed so don't lower if either is still set *=
/
         if (stat_reg !=3D PSIHB_XSCOM_CR ||
             !(psi->regs[stat_reg] & (PSIHB_CR_PSI_IRQ | PSIHB_CR_FSP_IRQ=
))) {
-            qemu_irq_lower(ics->qirqs[src]);
+            qemu_irq_lower(psi->qirqs[src]);
         } else {
             state =3D true;
         }
@@ -491,6 +490,8 @@ static void pnv_psi_realize(DeviceState *dev, Error *=
*errp)
         ics_set_irq_type(ics, i, true);
     }
=20
+    psi->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_i=
rqs);
+
     /* XSCOM region for PSI registers */
     pnv_xscom_region_init(&psi->xscom_regs, OBJECT(dev), &pnv_psi_xscom_=
ops,
                 psi, "xscom-psi", PNV_XSCOM_PSIHB_SIZE);
--=20
2.20.1
