Received: from eggs.gnu.org ([209.51.188.92]:58840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09s-00074W-1x
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gh09r-0007lb-0f
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:47:39 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  9 Jan 2019 09:45:56 +1100
Message-Id: <20190108224600.23125-26-david@gibson.dropbear.id.au>
In-Reply-To: <20190108224600.23125-1-david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/29] pnv/psi: move the ICSState qemu_irq array
 under the PSI device model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

Future changes of the ICSState object will remove the qemu_irq array
from under the interrupt controller model. Prepare ground for the PSI
interrupt sources and introduce a new one directly under the PSI
device model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv_psi.c         | 7 ++++---
 include/hw/ppc/pnv_psi.h | 1 +
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5b969127c3..8ced095063 100644
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
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index f6af5eae1f..64ac73512e 100644
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
--=20
2.20.1
