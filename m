Received: from eggs.gnu.org ([209.51.188.92]:59884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0T-0005Mx-Qk
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hJu0S-0004Gv-Nz
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 02:06:45 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 26 Apr 2019 16:05:55 +1000
Message-Id: <20190426060627.18153-5-david@gibson.dropbear.id.au>
In-Reply-To: <20190426060627.18153-1-david@gibson.dropbear.id.au>
References: <20190426060627.18153-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/36] spapr/irq: remove spapr_ics_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: gkurz@kaod.org, clg@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

spapr_ics_create() is only called once. Merge it in spapr_irq_init_xics()
and simplify a bit the error handling by using 'error_fatal' .

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190321144914.19934-13-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_irq.c | 44 ++++++++++++++------------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/spapr_irq.c b/hw/ppc/spapr_irq.c
index 0a84e4cf63..b1f79ea9de 100644
--- a/hw/ppc/spapr_irq.c
+++ b/hw/ppc/spapr_irq.c
@@ -67,36 +67,11 @@ void spapr_irq_msi_reset(SpaprMachineState *spapr)
  * XICS IRQ backend.
  */
=20
-static ICSState *spapr_ics_create(SpaprMachineState *spapr,
-                                  int nr_irqs, Error **errp)
-{
-    Error *local_err =3D NULL;
-    Object *obj;
-
-    obj =3D object_new(TYPE_ICS_SIMPLE);
-    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
-    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
-                                   &error_abort);
-    object_property_set_int(obj, nr_irqs, "nr-irqs", &local_err);
-    if (local_err) {
-        goto error;
-    }
-    object_property_set_bool(obj, true, "realized", &local_err);
-    if (local_err) {
-        goto error;
-    }
-
-    return ICS_BASE(obj);
-
-error:
-    error_propagate(errp, local_err);
-    return NULL;
-}
-
 static void spapr_irq_init_xics(SpaprMachineState *spapr, int nr_irqs,
                                 Error **errp)
 {
     MachineState *machine =3D MACHINE(spapr);
+    Object *obj;
     Error *local_err =3D NULL;
     bool xics_kvm =3D false;
=20
@@ -108,7 +83,8 @@ static void spapr_irq_init_xics(SpaprMachineState *spa=
pr, int nr_irqs,
         if (machine_kernel_irqchip_required(machine) && !xics_kvm) {
             error_prepend(&local_err,
                           "kernel_irqchip requested but unavailable: ");
-            goto error;
+            error_propagate(errp, local_err);
+            return;
         }
         error_free(local_err);
         local_err =3D NULL;
@@ -118,10 +94,18 @@ static void spapr_irq_init_xics(SpaprMachineState *s=
papr, int nr_irqs,
         xics_spapr_init(spapr);
     }
=20
-    spapr->ics =3D spapr_ics_create(spapr, nr_irqs, &local_err);
+    obj =3D object_new(TYPE_ICS_SIMPLE);
+    object_property_add_child(OBJECT(spapr), "ics", obj, &error_abort);
+    object_property_add_const_link(obj, ICS_PROP_XICS, OBJECT(spapr),
+                                   &error_fatal);
+    object_property_set_int(obj, nr_irqs, "nr-irqs",  &error_fatal);
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
=20
-error:
-    error_propagate(errp, local_err);
+    spapr->ics =3D ICS_BASE(obj);
 }
=20
 #define ICS_IRQ_FREE(ics, srcno)   \
--=20
2.20.1
