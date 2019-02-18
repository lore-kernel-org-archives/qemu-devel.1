Received: from eggs.gnu.org ([209.51.188.92]:38930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxN-00063M-A7
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxE-0002ra-S1
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:31:36 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:22 +1100
Message-Id: <20190218143049.17142-17-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/43] spapr/irq: remove the XICS offset
 adjustment
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

From: C=C3=A9dric Le Goater <clg@kaod.org>

Now that we have changed the XICS and the XIVE interrupt backend to
have different size for their IRQ number space, we do not need to
align their source numbers anymore. Remove the offset adjustment and
wire the dual 'qirq' handler to the 'qirq' handler of the current
interrupt mode in use.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190213210756.27032-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index da52a46e80..48d6b2daed 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -453,17 +453,6 @@ static void spapr_irq_init_dual(sPAPRMachineState *s=
papr, int nr_irqs,
         return;
     }
=20
-    /*
-     * Align the XICS and the XIVE IRQ number space under QEMU.
-     *
-     * However, the XICS KVM device still considers that the IRQ
-     * numbers should start at XICS_IRQ_BASE (0x1000). Either we
-     * should introduce a KVM device ioctl to set the offset or ignore
-     * the lower 4K numbers when using the get/set ioctl of the XICS
-     * KVM device. The second option seems the least intrusive.
-     */
-    spapr->ics->offset =3D 0;
-
     spapr_irq_xive.init(spapr, spapr_irq_xive.nr_irqs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -500,21 +489,7 @@ static void spapr_irq_free_dual(sPAPRMachineState *s=
papr, int irq, int num)
=20
 static qemu_irq spapr_qirq_dual(sPAPRMachineState *spapr, int irq)
 {
-    sPAPRXive *xive =3D spapr->xive;
-    ICSState *ics =3D spapr->ics;
-
-    if (irq >=3D spapr->irq->nr_irqs) {
-        return NULL;
-    }
-
-    /*
-     * The IRQ number should have been claimed under both interrupt
-     * controllers.
-     */
-    assert(!ICS_IRQ_FREE(ics, irq - ics->offset));
-    assert(xive_eas_is_valid(&xive->eat[irq]));
-
-    return spapr->qirqs[irq];
+    return spapr_irq_current(spapr)->qirq(spapr, irq);
 }
=20
 static void spapr_irq_print_info_dual(sPAPRMachineState *spapr, Monitor =
*mon)
--=20
2.20.1
