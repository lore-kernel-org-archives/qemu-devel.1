Received: from eggs.gnu.org ([209.51.188.92]:39362)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxu-0006aX-If
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxs-0003Ae-SQ
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:31 +1100
Message-Id: <20190218143049.17142-26-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 25/43] spapr/irq: Use the "simple" ICS class for
 KVM
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

The "simple" ICS class knows how to interract with KVM. Adapt sPAPR to us=
e
it instead of the ICS KVM class.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <155023083585.1011724.2868047424353921455.stgit@bahia.lan>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 9f43b7b3bf..4aa8165307 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -67,13 +67,12 @@ void spapr_irq_msi_reset(sPAPRMachineState *spapr)
  */
=20
 static ICSState *spapr_ics_create(sPAPRMachineState *spapr,
-                                  const char *type_ics,
                                   int nr_irqs, Error **errp)
 {
     Error *local_err =3D NULL;
     Object *obj;
=20
-    obj =3D object_new(type_ics);
+    obj =3D object_new(TYPE_ICS_SIMPLE);
     object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
     object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
                                    &error_abort);
@@ -98,14 +97,14 @@ static void spapr_irq_init_xics(sPAPRMachineState *sp=
apr, int nr_irqs,
 {
     MachineState *machine =3D MACHINE(spapr);
     Error *local_err =3D NULL;
+    bool xics_kvm =3D false;
=20
     if (kvm_enabled()) {
         if (machine_kernel_irqchip_allowed(machine) &&
             !xics_kvm_init(spapr, &local_err)) {
-            spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_KVM, nr_irqs=
,
-                                          &local_err);
+            xics_kvm =3D true;
         }
-        if (machine_kernel_irqchip_required(machine) && !spapr->ics) {
+        if (machine_kernel_irqchip_required(machine) && !xics_kvm) {
             error_prepend(&local_err,
                           "kernel_irqchip requested but unavailable: ");
             goto error;
@@ -114,12 +113,12 @@ static void spapr_irq_init_xics(sPAPRMachineState *=
spapr, int nr_irqs,
         local_err =3D NULL;
     }
=20
-    if (!spapr->ics) {
+    if (!xics_kvm) {
         xics_spapr_init(spapr);
-        spapr->ics =3D spapr_ics_create(spapr, TYPE_ICS_SIMPLE, nr_irqs,
-                                      &local_err);
     }
=20
+    spapr->ics =3D spapr_ics_create(spapr, nr_irqs, &local_err);
+
 error:
     error_propagate(errp, local_err);
 }
--=20
2.20.1
