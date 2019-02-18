Received: from eggs.gnu.org ([209.51.188.92]:39106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxm-0006Ns-11
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxh-00032M-Sa
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:04 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:21 +1100
Message-Id: <20190218143049.17142-16-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/43] spapr/irq: add an 'nr_irq' parameter to
 initialize the backend.
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

When using the 'dual' interrupt mode, the source numbers of both sPAPR
IRQ backends are aligned to share a common IRQ number space and to use
a similar mapping of the machine qemu_irq array which is indexed by
the source number.

The XICS IRQ number range initially being [ 0x1000 - 0x2000 ], this
requires to change the XICS ICSState offset to 0 and to provision for
an extra 4K of source numbers and qemu_irqs which will never be used
by the machine when running under the XICS interrupt mode. This is not
an optimal solution.

Change the init() method to allocate an IRQ number space of the
expected size for the XICS sPAPR IRQ backend. It breaks the interrupt
signaling when under the 'dual' mode because source numbers have
unexpected values but next patch will fix that.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190213210756.27032-2-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c         | 18 ++++++++++--------
 include/hw/ppc/spapr_irq.h |  2 +-
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 80b0083b8e..da52a46e80 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -93,10 +93,10 @@ error:
     return NULL;
 }
=20
-static void spapr_irq_init_xics(sPAPRMachineState *spapr, Error **errp)
+static void spapr_irq_init_xics(sPAPRMachineState *spapr, int nr_irqs,
+                                Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
-    int nr_irqs =3D spapr->irq->nr_irqs;
     Error *local_err =3D NULL;
=20
     if (kvm_enabled()) {
@@ -262,7 +262,8 @@ sPAPRIrq spapr_irq_xics =3D {
 /*
  * XIVE IRQ backend.
  */
-static void spapr_irq_init_xive(sPAPRMachineState *spapr, Error **errp)
+static void spapr_irq_init_xive(sPAPRMachineState *spapr, int nr_irqs,
+                                Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
     uint32_t nr_servers =3D spapr_max_server_number(spapr);
@@ -278,7 +279,7 @@ static void spapr_irq_init_xive(sPAPRMachineState *sp=
apr, Error **errp)
     }
=20
     dev =3D qdev_create(NULL, TYPE_SPAPR_XIVE);
-    qdev_prop_set_uint32(dev, "nr-irqs", spapr->irq->nr_irqs);
+    qdev_prop_set_uint32(dev, "nr-irqs", nr_irqs);
     /*
      * 8 XIVE END structures per CPU. One for each available priority
      */
@@ -435,7 +436,8 @@ static sPAPRIrq *spapr_irq_current(sPAPRMachineState =
*spapr)
         &spapr_irq_xive : &spapr_irq_xics;
 }
=20
-static void spapr_irq_init_dual(sPAPRMachineState *spapr, Error **errp)
+static void spapr_irq_init_dual(sPAPRMachineState *spapr, int nr_irqs,
+                                Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
     Error *local_err =3D NULL;
@@ -445,7 +447,7 @@ static void spapr_irq_init_dual(sPAPRMachineState *sp=
apr, Error **errp)
         return;
     }
=20
-    spapr_irq_xics.init(spapr, &local_err);
+    spapr_irq_xics.init(spapr, spapr_irq_xics.nr_irqs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -462,7 +464,7 @@ static void spapr_irq_init_dual(sPAPRMachineState *sp=
apr, Error **errp)
      */
     spapr->ics->offset =3D 0;
=20
-    spapr_irq_xive.init(spapr, &local_err);
+    spapr_irq_xive.init(spapr, spapr_irq_xive.nr_irqs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -618,7 +620,7 @@ void spapr_irq_init(sPAPRMachineState *spapr, Error *=
*errp)
         spapr_irq_msi_init(spapr, spapr->irq->nr_msis);
     }
=20
-    spapr->irq->init(spapr, errp);
+    spapr->irq->init(spapr, spapr->irq->nr_irqs, errp);
=20
     spapr->qirqs =3D qemu_allocate_irqs(spapr->irq->set_irq, spapr,
                                       spapr->irq->nr_irqs);
diff --git a/include/hw/ppc/spapr_irq.h b/include/hw/ppc/spapr_irq.h
index 14b02c3aca..488511c3d8 100644
--- a/include/hw/ppc/spapr_irq.h
+++ b/include/hw/ppc/spapr_irq.h
@@ -35,7 +35,7 @@ typedef struct sPAPRIrq {
     uint32_t    nr_msis;
     uint8_t     ov5;
=20
-    void (*init)(sPAPRMachineState *spapr, Error **errp);
+    void (*init)(sPAPRMachineState *spapr, int nr_irqs, Error **errp);
     int (*claim)(sPAPRMachineState *spapr, int irq, bool lsi, Error **er=
rp);
     void (*free)(sPAPRMachineState *spapr, int irq, int num);
     qemu_irq (*qirq)(sPAPRMachineState *spapr, int irq);
--=20
2.20.1
