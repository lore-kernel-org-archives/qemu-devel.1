Received: from eggs.gnu.org ([2001:4830:134:3::10]:38044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMQ2-0001IG-Lj
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ceMPz-000522-HB
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:48:22 -0500
Received: from 10.mo173.mail-out.ovh.net ([46.105.74.148]:56246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ceMPz-00051C-8M
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 08:48:19 -0500
Received: from player791.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 970B923EB6
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 14:48:17 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 16 Feb 2017 14:47:25 +0100
Message-Id: <1487252865-12064-3-git-send-email-clg@kaod.org>
In-Reply-To: <1487252865-12064-1-git-send-email-clg@kaod.org>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 02/22] ppc/xics: remove set_nr_servers()
 handler from XICSStateClass
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

 Changes since v1:

 - added a XICS link to the ICS object
 - removed xics_set_nr_servers() routine
 - removed set_nr_servers() class handler

 hw/intc/xics.c        | 74 +++++++++++++--------------------------------=
------
 hw/intc/xics_kvm.c    | 21 +--------------
 hw/intc/xics_spapr.c  | 26 ------------------
 hw/ppc/spapr.c        | 30 ++++++++++++++++-----
 include/hw/ppc/xics.h |  3 ---
 5 files changed, 42 insertions(+), 112 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e70d3b8b1095..9f22814815c9 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -151,67 +151,11 @@ static void xics_common_reset(DeviceState *d)
     }
 }
=20
-void xics_set_nr_servers(XICSState *xics, uint32_t nr_servers,
-                         const char *typename, Error **errp)
-{
-    int i;
-
-    xics->nr_servers =3D nr_servers;
-
-    xics->ss =3D g_malloc0(xics->nr_servers * sizeof(ICPState));
-    for (i =3D 0; i < xics->nr_servers; i++) {
-        char name[32];
-        ICPState *icp =3D &xics->ss[i];
-
-        object_initialize(icp, sizeof(*icp), typename);
-        snprintf(name, sizeof(name), "icp[%d]", i);
-        object_property_add_child(OBJECT(xics), name, OBJECT(icp), errp)=
;
-        icp->xics =3D xics;
-    }
-}
-
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
@@ -450,12 +394,30 @@ static void icp_reset(DeviceState *dev)
     qemu_set_irq(icp->output, 0);
 }
=20
+static void icp_realize(DeviceState *dev, Error **errp)
+{
+    ICPState *icp =3D ICP(dev);
+    Object *obj;
+    Error *err =3D NULL;
+
+    obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
+    if (!obj) {
+        error_setg(errp, "%s: required link 'xics' not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
+    }
+
+    icp->xics =3D XICS_COMMON(obj);
+}
+
+
 static void icp_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->reset =3D icp_reset;
     dc->vmsd =3D &vmstate_icp_server;
+    dc->realize =3D icp_realize;
 }
=20
 static const TypeInfo icp_info =3D {
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 4a6c0522feb6..6cabc11f6be1 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -368,12 +368,6 @@ static void xics_kvm_cpu_setup(XICSState *xics, Powe=
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
@@ -386,9 +380,7 @@ static void rtas_dummy(PowerPCCPU *cpu, sPAPRMachineS=
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
@@ -438,16 +430,6 @@ static void xics_kvm_realize(DeviceState *dev, Error=
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
@@ -468,7 +450,6 @@ static void xics_kvm_class_init(ObjectClass *oc, void=
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
index 94b1e8e3227a..5d7c35de8cd9 100644
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
@@ -122,6 +122,22 @@ static XICSState *try_create_xics(const char *type, =
const char *type_ics,
     }
     QLIST_INSERT_HEAD(&xics->ics, ics, list);
=20
+    xics->ss =3D g_malloc0(nr_servers * sizeof(ICPState));
+    xics->nr_servers =3D nr_servers;
+
+    for (i =3D 0; i < nr_servers; i++) {
+        ICPState *icp =3D &xics->ss[i];
+
+        object_initialize(icp, sizeof(*icp), type_icp);
+        object_property_add_child(OBJECT(xics), "icp[*]", OBJECT(icp), N=
ULL);
+        object_property_add_const_link(OBJECT(icp), "xics", OBJECT(xics)=
, NULL);
+        object_property_set_bool(OBJECT(icp), true, "realized", &err);
+        if (err) {
+            goto error;
+        }
+        object_unref(OBJECT(icp));
+    }
+
     return xics;
=20
 error:
@@ -143,7 +159,7 @@ static XICSState *xics_system_init(MachineState *mach=
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
@@ -154,8 +170,8 @@ static XICSState *xics_system_init(MachineState *mach=
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
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 8fe3c4d2ceab..fc4abcd4e796 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -74,7 +74,6 @@ struct XICSStateClass {
     DeviceClass parent_class;
=20
     void (*cpu_setup)(XICSState *icp, PowerPCCPU *cpu);
-    void (*set_nr_servers)(XICSState *icp, uint32_t nr_servers, Error **=
errp);
 };
=20
 struct XICSState {
@@ -189,8 +188,6 @@ void spapr_dt_xics(XICSState *xics, void *fdt, uint32=
_t phandle);
=20
 void xics_cpu_setup(XICSState *icp, PowerPCCPU *cpu);
 void xics_cpu_destroy(XICSState *icp, PowerPCCPU *cpu);
-void xics_set_nr_servers(XICSState *xics, uint32_t nr_servers,
-                         const char *typename, Error **errp);
=20
 /* Internal XICS interfaces */
 int xics_get_cpu_index_by_dt_id(int cpu_dt_id);
--=20
2.7.4
