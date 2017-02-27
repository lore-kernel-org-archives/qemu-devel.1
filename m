Received: from eggs.gnu.org ([2001:4830:134:3::10]:37755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJR-0000XK-K7
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ciMJN-0007Aj-JE
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:05 -0500
Received: from 17.mo6.mail-out.ovh.net ([46.105.36.150]:54736)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ciMJN-00079d-9q
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 09:30:01 -0500
Received: from player761.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id C4090B3A7A
	for <qemu-devel@nongnu.org>; Mon, 27 Feb 2017 15:29:59 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon, 27 Feb 2017 15:29:10 +0100
Message-Id: <1488205773-30436-4-git-send-email-clg@kaod.org>
In-Reply-To: <1488205773-30436-1-git-send-email-clg@kaod.org>
References: <1488205773-30436-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 03/26] ppc/xics: remove set_nr_irqs()
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

Today, the ICS (Interrupt Controller Source) object is created and
realized by the init and realize routines of the XICS object, but some
of the parameters are only known at the machine level.

These parameters are passed from the sPAPR machine to the ICS object
in a rather convoluted way using property handlers and a class handler
of the XICS object. The number of irqs required to allocate the IRQ
state objects in the ICS realize routine is one of them.

Let's simplify the process by creating the ICS object along with the
XICS object at the machine level and link the ICS into the XICS list
of ICSs at this level also. In the sPAPR machine, there is only a
single ICS but that will change with the PowerNV machine.

Also, QOMify the creation of the objects and get rid of the
superfluous code.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes since v3:

 - moved the retrieval link at ICS_BASE level=20
 - added a realize() handler to the ICSStateClass and updated the
   descendent classes accordingly

Changes since v1:

 - added a XICS link to the ICS object

 hw/intc/xics.c        | 72 +++++++++++++++++++++++++--------------------=
------
 hw/intc/xics_kvm.c    | 36 +-------------------------
 hw/intc/xics_spapr.c  | 34 ------------------------
 hw/ppc/spapr.c        | 54 ++++++++++++++++++++++++++------------
 include/hw/ppc/xics.h |  3 +--
 5 files changed, 75 insertions(+), 124 deletions(-)

diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index 372b8311fb8b..f00b77ae15f4 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -151,38 +151,6 @@ static void xics_common_reset(DeviceState *d)
     }
 }
=20
-static void xics_prop_get_nr_irqs(Object *obj, Visitor *v, const char *n=
ame,
-                                  void *opaque, Error **errp)
-{
-    XICSState *xics =3D XICS_COMMON(obj);
-    int64_t value =3D xics->nr_irqs;
-
-    visit_type_int(v, name, &value, errp);
-}
-
-static void xics_prop_set_nr_irqs(Object *obj, Visitor *v, const char *n=
ame,
-                                  void *opaque, Error **errp)
-{
-    XICSState *xics =3D XICS_COMMON(obj);
-    XICSStateClass *info =3D XICS_COMMON_GET_CLASS(xics);
-    Error *error =3D NULL;
-    int64_t value;
-
-    visit_type_int(v, name, &value, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-    if (xics->nr_irqs) {
-        error_setg(errp, "Number of interrupts is already set to %u",
-                   xics->nr_irqs);
-        return;
-    }
-
-    assert(info->set_nr_irqs);
-    info->set_nr_irqs(xics, value, errp);
-}
-
 void xics_set_nr_servers(XICSState *xics, uint32_t nr_servers,
                          const char *typename, Error **errp)
 {
@@ -241,9 +209,6 @@ static void xics_common_initfn(Object *obj)
     XICSState *xics =3D XICS_COMMON(obj);
=20
     QLIST_INIT(&xics->ics);
-    object_property_add(obj, "nr_irqs", "int",
-                        xics_prop_get_nr_irqs, xics_prop_set_nr_irqs,
-                        NULL, NULL, NULL);
     object_property_add(obj, "nr_servers", "int",
                         xics_prop_get_nr_servers, xics_prop_set_nr_serve=
rs,
                         NULL, NULL, NULL);
@@ -746,12 +711,18 @@ static void ics_simple_realize(DeviceState *dev, Er=
ror **errp)
     ics->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_i=
rqs);
 }
=20
+static Property ics_simple_properties[] =3D {
+    DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void ics_simple_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
=20
-    dc->realize =3D ics_simple_realize;
+    isc->realize =3D ics_simple_realize;
+    dc->props =3D ics_simple_properties;
     dc->vmsd =3D &vmstate_ics_simple;
     dc->reset =3D ics_simple_reset;
     isc->post_load =3D ics_simple_post_load;
@@ -769,11 +740,40 @@ static const TypeInfo ics_simple_info =3D {
     .instance_init =3D ics_simple_initfn,
 };
=20
+static void ics_base_realize(DeviceState *dev, Error **errp)
+{
+    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
+    ICSState *ics =3D ICS_BASE(dev);
+    Object *obj;
+    Error *err =3D NULL;
+
+    obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
+    if (!obj) {
+        error_setg(errp, "%s: required link 'xics' not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
+    }
+    ics->xics =3D XICS_COMMON(obj);
+
+
+    if (icsc->realize) {
+        icsc->realize(dev, errp);
+    }
+}
+
+static void ics_base_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->realize =3D ics_base_realize;
+}
+
 static const TypeInfo ics_base_info =3D {
     .name =3D TYPE_ICS_BASE,
     .parent =3D TYPE_DEVICE,
     .abstract =3D true,
     .instance_size =3D sizeof(ICSState),
+    .class_init =3D ics_base_class_init,
     .class_size =3D sizeof(ICSStateClass),
 };
=20
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 17694eaa8709..e5ab00b22361 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -308,7 +308,7 @@ static void ics_kvm_class_init(ObjectClass *klass, vo=
id *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     ICSStateClass *icsc =3D ICS_BASE_CLASS(klass);
=20
-    dc->realize =3D ics_kvm_realize;
+    icsc->realize =3D ics_kvm_realize;
     dc->reset =3D ics_kvm_reset;
     icsc->pre_save =3D ics_get_kvm_state;
     icsc->post_load =3D ics_set_kvm_state;
@@ -358,18 +358,6 @@ static void xics_kvm_cpu_setup(XICSState *xics, Powe=
rPCCPU *cpu)
     ss->cap_irq_xics_enabled =3D true;
 }
=20
-static void xics_kvm_set_nr_irqs(XICSState *xics, uint32_t nr_irqs,
-                                 Error **errp)
-{
-    ICSState *ics =3D QLIST_FIRST(&xics->ics);
-
-    /* This needs to be deprecated ... */
-    xics->nr_irqs =3D nr_irqs;
-    if (ics) {
-        ics->nr_irqs =3D nr_irqs;
-    }
-}
-
 static void xics_kvm_set_nr_servers(XICSState *xics, uint32_t nr_servers=
,
                                     Error **errp)
 {
@@ -389,7 +377,6 @@ static void xics_kvm_realize(DeviceState *dev, Error =
**errp)
 {
     KVMXICSState *xicskvm =3D XICS_SPAPR_KVM(dev);
     XICSState *xics =3D XICS_COMMON(dev);
-    ICSState *ics;
     int i, rc;
     Error *error =3D NULL;
     struct kvm_create_device xics_create_device =3D {
@@ -441,14 +428,6 @@ static void xics_kvm_realize(DeviceState *dev, Error=
 **errp)
=20
     xicskvm->kernel_xics_fd =3D xics_create_device.fd;
=20
-    QLIST_FOREACH(ics, &xics->ics, list) {
-        object_property_set_bool(OBJECT(ics), true, "realized", &error);
-        if (error) {
-            error_propagate(errp, error);
-            goto fail;
-        }
-    }
-
     assert(xics->nr_servers);
     for (i =3D 0; i < xics->nr_servers; i++) {
         object_property_set_bool(OBJECT(&xics->ss[i]), true, "realized",
@@ -472,17 +451,6 @@ fail:
     kvmppc_define_rtas_kernel_token(0, "ibm,int-off");
 }
=20
-static void xics_kvm_initfn(Object *obj)
-{
-    XICSState *xics =3D XICS_COMMON(obj);
-    ICSState *ics;
-
-    ics =3D ICS_SIMPLE(object_new(TYPE_ICS_KVM));
-    object_property_add_child(obj, "ics", OBJECT(ics), NULL);
-    ics->xics =3D xics;
-    QLIST_INSERT_HEAD(&xics->ics, ics, list);
-}
-
 static void xics_kvm_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
@@ -490,7 +458,6 @@ static void xics_kvm_class_init(ObjectClass *oc, void=
 *data)
=20
     dc->realize =3D xics_kvm_realize;
     xsc->cpu_setup =3D xics_kvm_cpu_setup;
-    xsc->set_nr_irqs =3D xics_kvm_set_nr_irqs;
     xsc->set_nr_servers =3D xics_kvm_set_nr_servers;
 }
=20
@@ -499,7 +466,6 @@ static const TypeInfo xics_spapr_kvm_info =3D {
     .parent        =3D TYPE_XICS_COMMON,
     .instance_size =3D sizeof(KVMXICSState),
     .class_init    =3D xics_kvm_class_init,
-    .instance_init =3D xics_kvm_initfn,
 };
=20
 static void xics_kvm_register_types(void)
diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
index 2e3f1c5e95b2..03e42a866603 100644
--- a/hw/intc/xics_spapr.c
+++ b/hw/intc/xics_spapr.c
@@ -239,18 +239,6 @@ static void rtas_int_on(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
=20
-static void xics_spapr_set_nr_irqs(XICSState *xics, uint32_t nr_irqs,
-                                   Error **errp)
-{
-    ICSState *ics =3D QLIST_FIRST(&xics->ics);
-
-    /* This needs to be deprecated ... */
-    xics->nr_irqs =3D nr_irqs;
-    if (ics) {
-        ics->nr_irqs =3D nr_irqs;
-    }
-}
-
 static void xics_spapr_set_nr_servers(XICSState *xics, uint32_t nr_serve=
rs,
                                       Error **errp)
 {
@@ -260,7 +248,6 @@ static void xics_spapr_set_nr_servers(XICSState *xics=
, uint32_t nr_servers,
 static void xics_spapr_realize(DeviceState *dev, Error **errp)
 {
     XICSState *xics =3D XICS_SPAPR(dev);
-    ICSState *ics;
     Error *error =3D NULL;
     int i;
=20
@@ -282,14 +269,6 @@ static void xics_spapr_realize(DeviceState *dev, Err=
or **errp)
     spapr_register_hypercall(H_EOI, h_eoi);
     spapr_register_hypercall(H_IPOLL, h_ipoll);
=20
-    QLIST_FOREACH(ics, &xics->ics, list) {
-        object_property_set_bool(OBJECT(ics), true, "realized", &error);
-        if (error) {
-            error_propagate(errp, error);
-            return;
-        }
-    }
-
     for (i =3D 0; i < xics->nr_servers; i++) {
         object_property_set_bool(OBJECT(&xics->ss[i]), true, "realized",
                                  &error);
@@ -300,24 +279,12 @@ static void xics_spapr_realize(DeviceState *dev, Er=
ror **errp)
     }
 }
=20
-static void xics_spapr_initfn(Object *obj)
-{
-    XICSState *xics =3D XICS_SPAPR(obj);
-    ICSState *ics;
-
-    ics =3D ICS_SIMPLE(object_new(TYPE_ICS_SIMPLE));
-    object_property_add_child(obj, "ics", OBJECT(ics), NULL);
-    ics->xics =3D xics;
-    QLIST_INSERT_HEAD(&xics->ics, ics, list);
-}
-
 static void xics_spapr_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(oc);
     XICSStateClass *xsc =3D XICS_SPAPR_CLASS(oc);
=20
     dc->realize =3D xics_spapr_realize;
-    xsc->set_nr_irqs =3D xics_spapr_set_nr_irqs;
     xsc->set_nr_servers =3D xics_spapr_set_nr_servers;
 }
=20
@@ -327,7 +294,6 @@ static const TypeInfo xics_spapr_info =3D {
     .instance_size =3D sizeof(XICSState),
     .class_size =3D sizeof(XICSStateClass),
     .class_init    =3D xics_spapr_class_init,
-    .instance_init =3D xics_spapr_initfn,
 };
=20
 #define ICS_IRQ_FREE(ics, srcno)   \
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 3c79068075e4..398ce5a9cc1e 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -95,23 +95,42 @@
=20
 #define HTAB_SIZE(spapr)        (1ULL << ((spapr)->htab_shift))
=20
-static XICSState *try_create_xics(const char *type, int nr_servers,
-                                  int nr_irqs, Error **errp)
-{
-    Error *err =3D NULL;
-    DeviceState *dev;
+static XICSState *try_create_xics(const char *type, const char *type_ics=
,
+                                  int nr_servers, int nr_irqs, Error **e=
rrp)
+{
+    Error *err =3D NULL, *local_err =3D NULL;
+    XICSState *xics;
+    ICSState *ics =3D NULL;
+
+    xics =3D XICS_COMMON(object_new(type));
+    qdev_set_parent_bus(DEVICE(xics), sysbus_get_default());
+    object_property_set_int(OBJECT(xics), nr_servers, "nr_servers", &err=
);
+    object_property_set_bool(OBJECT(xics), true, "realized", &local_err)=
;
+    error_propagate(&err, local_err);
+    if (err) {
+        goto error;
+    }
=20
-    dev =3D DEVICE(object_new(type));
-    qdev_prop_set_uint32(dev, "nr_servers", nr_servers);
-    qdev_prop_set_uint32(dev, "nr_irqs", nr_irqs);
-    qdev_set_parent_bus(dev, sysbus_get_default());
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
+    ics =3D ICS_SIMPLE(object_new(type_ics));
+    object_property_add_child(OBJECT(xics), "ics", OBJECT(ics), NULL);
+    object_property_set_int(OBJECT(ics), nr_irqs, "nr-irqs", &err);
+    object_property_add_const_link(OBJECT(ics), "xics", OBJECT(xics), NU=
LL);
+    object_property_set_bool(OBJECT(ics), true, "realized", &local_err);
+    error_propagate(&err, local_err);
     if (err) {
-        error_propagate(errp, err);
-        object_unparent(OBJECT(dev));
-        return NULL;
+        goto error;
     }
-    return XICS_COMMON(dev);
+    QLIST_INSERT_HEAD(&xics->ics, ics, list);
+
+    return xics;
+
+error:
+    error_propagate(errp, err);
+    if (ics) {
+        object_unparent(OBJECT(ics));
+    }
+    object_unparent(OBJECT(xics));
+    return NULL;
 }
=20
 static XICSState *xics_system_init(MachineState *machine,
@@ -123,8 +142,8 @@ static XICSState *xics_system_init(MachineState *mach=
ine,
         Error *err =3D NULL;
=20
         if (machine_kernel_irqchip_allowed(machine)) {
-            xics =3D try_create_xics(TYPE_XICS_SPAPR_KVM, nr_servers, nr=
_irqs,
-                                   &err);
+            xics =3D try_create_xics(TYPE_XICS_SPAPR_KVM, TYPE_ICS_KVM,
+                                   nr_servers, nr_irqs, &err);
         }
         if (machine_kernel_irqchip_required(machine) && !xics) {
             error_reportf_err(err,
@@ -135,7 +154,8 @@ static XICSState *xics_system_init(MachineState *mach=
ine,
     }
=20
     if (!xics) {
-        xics =3D try_create_xics(TYPE_XICS_SPAPR, nr_servers, nr_irqs, e=
rrp);
+        xics =3D try_create_xics(TYPE_XICS_SPAPR, TYPE_ICS_SIMPLE, nr_se=
rvers,
+                               nr_irqs, errp);
     }
=20
     return xics;
diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 1aefd3d52257..a1d12d39c898 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -74,7 +74,6 @@ struct XICSStateClass {
     DeviceClass parent_class;
=20
     void (*cpu_setup)(XICSState *icp, PowerPCCPU *cpu);
-    void (*set_nr_irqs)(XICSState *icp, uint32_t nr_irqs, Error **errp);
     void (*set_nr_servers)(XICSState *icp, uint32_t nr_servers, Error **=
errp);
 };
=20
@@ -83,7 +82,6 @@ struct XICSState {
     DeviceState parent_obj;
     /*< public >*/
     uint32_t nr_servers;
-    uint32_t nr_irqs;
     ICPState *ss;
     QLIST_HEAD(, ICSState) ics;
 };
@@ -139,6 +137,7 @@ struct ICPState {
 struct ICSStateClass {
     DeviceClass parent_class;
=20
+    void (*realize)(DeviceState *dev, Error **errp);
     void (*pre_save)(ICSState *s);
     int (*post_load)(ICSState *s, int version_id);
     void (*reject)(ICSState *s, uint32_t irq);
--=20
2.7.4
