Received: from eggs.gnu.org ([2001:4830:134:3::10]:53660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdHKH-0000QU-OK
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:10:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cdHKE-0008C5-Cg
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:09:57 -0500
Received: from 6.mo4.mail-out.ovh.net ([188.165.36.253]:55043)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cdHKE-0008Bl-3M
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 09:09:54 -0500
Received: from player772.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 79EFB48E50
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 15:09:52 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 13 Feb 2017 15:09:17 +0100
Message-Id: <1486994957-20400-3-git-send-email-clg@kaod.org>
In-Reply-To: <1486994957-20400-1-git-send-email-clg@kaod.org>
References: <1486994957-20400-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] ppc/xics: remove set_nr_servers() handler
 from XICSStateClass
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

Today, the ICP (Interrupt Controller Presenter) objects are created by
the 'nr_servers' property handler of the XICS object and a class
handler. They are realized in the XICS object realize routine.

Let's simplify the process by creating the ICP objects along with the
XICS object at the machine level.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/intc/xics.c       | 37 -------------------------------------
 hw/intc/xics_kvm.c   | 21 +--------------------
 hw/intc/xics_spapr.c | 26 --------------------------
 hw/ppc/spapr.c       | 24 +++++++++++++++++-------
 4 files changed, 18 insertions(+), 90 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 58e7f2f86ed4..002d142a4792 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -170,48 +170,11 @@ void xics_set_nr_servers(XICSState *xics, uint32_t =
nr_servers,
     }
 }
=20
-static void xics_prop_get_nr_servers(Object *obj, Visitor *v,
-                                     const char *name, void *opaque,
-                                     Error **errp)
-{
-    XICSState *xics =3D XICS_COMMON(obj);
-    int64_t value =3D xics->nr_servers;
-
-    visit_type_int(v, name, &value, errp);
-}
-
-static void xics_prop_set_nr_servers(Object *obj, Visitor *v,
-                                     const char *name, void *opaque,
-                                     Error **errp)
-{
-    XICSState *xics =3D XICS_COMMON(obj);
-    XICSStateClass *xsc =3D XICS_COMMON_GET_CLASS(xics);
-    Error *error =3D NULL;
-    int64_t value;
-
-    visit_type_int(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-    if (xics->nr_servers) {
-        error_setg(errp, "Number of servers is already set to %u",
-                   xics->nr_servers);
-        return;
-    }
-
-    assert(xsc->set_nr_servers);
-    xsc->set_nr_servers(xics, value, errp);
-}
-
 static void xics_common_initfn(Object *obj)
 {
     XICSState *xics =3D XICS_COMMON(obj);
=20
     QLIST_INIT(&xics->ics);
-    object_property_add(obj, "nr_servers", "int",
-                        xics_prop_get_nr_servers, xics_prop_set_nr_serve=
rs,
-                        NULL, NULL, NULL);
 }
=20
 static void xics_common_class_init(ObjectClass *oc, void *data)
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 6bb8c6d14865..9ec33c9b0d94 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -358,12 +358,6 @@ static void xics_kvm_cpu_setup(XICSState *xics, Powe=
rPCCPU *cpu)
     ss->cap_irq_xics_enabled =3D true;
 }
=20
-static void xics_kvm_set_nr_servers(XICSState *xics, uint32_t nr_servers=
,
-                                    Error **errp)
-{
-    xics_set_nr_servers(xics, nr_servers, TYPE_KVM_ICP, errp);
-}
-
 static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                        uint32_t token,
                        uint32_t nargs, target_ulong args,
@@ -376,9 +370,7 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineS=
tate *spapr,
 static void xics_kvm_realize(DeviceState *dev, Error **errp)
 {
     KVMXICSState *xicskvm =3D XICS_SPAPR_KVM(dev);
-    XICSState *xics =3D XICS_COMMON(dev);
-    int i, rc;
-    Error *error =3D NULL;
+    int rc;
     struct kvm_create_device xics_create_device =3D {
         .type =3D KVM_DEV_TYPE_XICS,
         .flags =3D 0,
@@ -428,16 +420,6 @@ static void xics_kvm_realize(DeviceState *dev, Error=
 **errp)
=20
     xicskvm->kernel_xics_fd =3D xics_create_device.fd;
=20
-    assert(xics->nr_servers);
-    for (i =3D 0; i < xics->nr_servers; i++) {
-        object_property_set_bool(OBJECT(&xics->ss[i]), true, "realized",
-                                 &error);
-        if (error) {
-            error_propagate(errp, error);
-            goto fail;
-        }
-    }
-
     kvm_kernel_irqchip =3D true;
     kvm_msi_via_irqfd_allowed =3D true;
     kvm_gsi_direct_mapping =3D true;
@@ -458,7 +440,6 @@ static void xics_kvm_class_init(ObjectClass *oc, void=
 *data)
=20
     dc->realize =3D xics_kvm_realize;
     xsc->cpu_setup =3D xics_kvm_cpu_setup;
-    xsc->set_nr_servers =3D xics_kvm_set_nr_servers;
 }
=20
 static const TypeInfo xics_spapr_kvm_info =3D {
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 03e42a866603..859b5675e175 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -239,23 +239,8 @@ static void rtas_int_on(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-static void xics_spapr_set_nr_servers(XICSState *xics, uint32_t nr_serve=
rs,
-                                      Error **errp)
-{
-    xics_set_nr_servers(xics, nr_servers, TYPE_ICP, errp);
-}
-
 static void xics_spapr_realize(DeviceState *dev, Error **errp)
 {
-    XICSState *xics =3D XICS_SPAPR(dev);
-    Error *error =3D NULL;
-    int i;
-
-    if (!xics->nr_servers) {
-        error_setg(errp, "Number of servers needs to be greater 0");
-        return;
-    }
-
     /* Registration of global state belongs into realize */
     spapr_rtas_register(RTAS_IBM_SET_XIVE, "ibm,set-xive", rtas_set_xive=
);
     spapr_rtas_register(RTAS_IBM_GET_XIVE, "ibm,get-xive", rtas_get_xive=
);
@@ -268,24 +253,13 @@ static void xics_spapr_realize(DeviceState *dev, Er=
ror **errp)
     spapr_register_hypercall(H_XIRR_X, h_xirr_x);
     spapr_register_hypercall(H_EOI, h_eoi);
     spapr_register_hypercall(H_IPOLL, h_ipoll);
-
-    for (i =3D 0; i < xics->nr_servers; i++) {
-        object_property_set_bool(OBJECT(&xics->ss[i]), true, "realized",
-                                 &error);
-        if (error) {
-            error_propagate(errp, error);
-            return;
-        }
-    }
 }
=20
 static void xics_spapr_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
-    XICSStateClass *xsc =3D XICS_SPAPR_CLASS(oc);
=20
     dc->realize =3D xics_spapr_realize;
-    xsc->set_nr_servers =3D xics_spapr_set_nr_servers;
 }
=20
 static const TypeInfo xics_spapr_info =3D {
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index c84b2f4f938e..d7e484f75c55 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -96,17 +96,17 @@
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
=20
 static XICSState *try_create_xics(const char *type, const char *type_ics=
,
-                                  int nr_servers, int nr_irqs, Error **e=
rrp)
+                                  const char *type_icp, int nr_servers,
+                                  int nr_irqs, Error **errp)
 {
     Error *err =3D NULL, *local_err =3D NULL;
     XICSState *xics;
     ICSState *ics =3D NULL;
+    int i;
=20
     xics =3D XICS_COMMON(object_new(type));
     qdev_set_parent_bus(DEVICE(xics), sysbus_get_default());
-    object_property_set_int(OBJECT(xics), nr_servers, "nr_servers", &err=
);
-    object_property_set_bool(OBJECT(xics), true, "realized", &local_err)=
;
-    error_propagate(&err, local_err);
+    object_property_set_bool(OBJECT(xics), true, "realized", &err);
     if (err) {
         goto error;
     }
@@ -123,6 +123,16 @@ static XICSState *try_create_xics(const char *type, =
const char *type_ics,
     ics->xics =3D xics;
     QLIST_INSERT_HEAD(&xics->ics, ics, list);
=20
+    xics_set_nr_servers(xics, nr_servers, type_icp, NULL);
+
+    for (i =3D 0; i < nr_servers; i++) {
+        object_property_set_bool(OBJECT(&xics->ss[i]), true, "realized",
+                                 &err);
+        if (err) {
+            goto error;
+        }
+    }
+
     return xics;
=20
 error:
@@ -144,7 +154,7 @@ static XICSState *xics_system_init(MachineState *mach=
ine,
=20
         if (machine_kernel_irqchip_allowed(machine)) {
             xics =3D try_create_xics(TYPE_XICS_SPAPR_KVM, TYPE_ICS_KVM,
-                                   nr_servers, nr_irqs, &err);
+                                   TYPE_KVM_ICP, nr_servers, nr_irqs, &e=
rr);
         }
         if (machine_kernel_irqchip_required(machine) && !xics) {
             error_reportf_err(err,
@@ -155,8 +165,8 @@ static XICSState *xics_system_init(MachineState *mach=
ine,
     }
=20
     if (!xics) {
-        xics =3D try_create_xics(TYPE_XICS_SPAPR, TYPE_ICS_SIMPLE, nr_se=
rvers,
-                               nr_irqs, errp);
+        xics =3D try_create_xics(TYPE_XICS_SPAPR, TYPE_ICS_SIMPLE, TYPE_=
ICP,
+                               nr_servers, nr_irqs, errp);
     }
=20
     return xics;
--=20
2.7.4
