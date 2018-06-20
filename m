Received: from eggs.gnu.org ([2001:4830:134:3::10]:34766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVaI8-0004bp-4y
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:24:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fVaI1-0000OT-3B
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:24:44 -0400
Received: from 3.mo7.mail-out.ovh.net ([46.105.34.113]:51415)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fVaI0-0000Nq-Gd
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 06:24:36 -0400
Received: from player778.ha.ovh.net (unknown [10.109.108.86])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id DB84BB1928
	for <qemu-devel@nongnu.org>; Wed, 20 Jun 2018 12:24:34 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed, 20 Jun 2018 12:24:12 +0200
Message-Id: <20180620102413.5400-2-clg@kaod.org>
In-Reply-To: <20180620102413.5400-1-clg@kaod.org>
References: <20180620102413.5400-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/2] ppc/xics: rework the ICS classes
 inheritance tree
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

This moves the common ICS code of the realize and reset handlers of
the ICS_SIMPLE class under the ICS_BASE class. The vmstate is also
moved down one class.

The benefits are that the ICS_KVM class can directly inherit from
ICS_BASE class and not from the intermediate ICS_SIMPLE. It makes the
class hierarchy much cleaner and removes duplicated code. DeviceRealize
and DeviceReset handlers are introduce so that parent handlers are
called from the inheriting classes.

What is left in the top classes is the low level interface to access
the KVM XICS device in ICS_KVM and the XICS emulating handlers in
ICS_SIMPLE.

This should not break migration compatibility.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/xics.h |   4 +-
 hw/intc/xics.c        | 166 ++++++++++++++++++++++++++++----------------=
------
 hw/intc/xics_kvm.c    |  47 +++++++-------
 hw/ppc/spapr.c        |   2 +-
 4 files changed, 123 insertions(+), 96 deletions(-)

diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
index 6cebff47a7d4..adc5f437b118 100644
--- a/include/hw/ppc/xics.h
+++ b/include/hw/ppc/xics.h
@@ -114,7 +114,9 @@ struct PnvICPState {
 struct ICSStateClass {
     DeviceClass parent_class;
=20
-    void (*realize)(ICSState *s, Error **errp);
+    DeviceRealize parent_realize;
+    DeviceReset parent_reset;
+
     void (*pre_save)(ICSState *s);
     int (*post_load)(ICSState *s, int version_id);
     void (*reject)(ICSState *s, uint32_t irq);
diff --git a/hw/intc/xics.c b/hw/intc/xics.c
index e73e623e3b53..b351262d1db9 100644
--- a/hw/intc/xics.c
+++ b/hw/intc/xics.c
@@ -547,9 +547,61 @@ static void ics_simple_eoi(ICSState *ics, uint32_t n=
r)
     }
 }
=20
-static void ics_simple_reset(void *dev)
+static void ics_simple_reset(DeviceState *dev)
 {
-    ICSState *ics =3D ICS_SIMPLE(dev);
+    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
+
+    icsc->parent_reset(dev);
+}
+
+static void ics_simple_reset_handler(void *dev)
+{
+    ics_simple_reset(dev);
+}
+
+static void ics_simple_realize(DeviceState *dev, Error **errp)
+{
+    ICSState *ics =3D ICS_BASE(dev);
+    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
+    Error *local_err =3D NULL;
+
+    icsc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    ics->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_i=
rqs);
+
+    qemu_register_reset(ics_simple_reset_handler, ics);
+}
+
+static void ics_simple_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
+
+    device_class_set_parent_realize(dc, ics_simple_realize,
+                                    &isc->parent_realize);
+    device_class_set_parent_reset(dc, ics_simple_reset,
+                                  &isc->parent_reset);
+
+    isc->reject =3D ics_simple_reject;
+    isc->resend =3D ics_simple_resend;
+    isc->eoi =3D ics_simple_eoi;
+}
+
+static const TypeInfo ics_simple_info =3D {
+    .name =3D TYPE_ICS_SIMPLE,
+    .parent =3D TYPE_ICS_BASE,
+    .instance_size =3D sizeof(ICSState),
+    .class_init =3D ics_simple_class_init,
+    .class_size =3D sizeof(ICSStateClass),
+};
+
+static void ics_base_reset(DeviceState *dev)
+{
+    ICSState *ics =3D ICS_BASE(dev);
     int i;
     uint8_t flags[ics->nr_irqs];
=20
@@ -566,7 +618,35 @@ static void ics_simple_reset(void *dev)
     }
 }
=20
-static int ics_simple_dispatch_pre_save(void *opaque)
+static void ics_base_realize(DeviceState *dev, Error **errp)
+{
+    ICSState *ics =3D ICS_BASE(dev);
+    Object *obj;
+    Error *err =3D NULL;
+
+    obj =3D object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &err);
+    if (!obj) {
+        error_propagate(errp, err);
+        error_prepend(errp, "required link '" ICS_PROP_XICS "' not found=
: ");
+        return;
+    }
+    ics->xics =3D XICS_FABRIC(obj);
+
+    if (!ics->nr_irqs) {
+        error_setg(errp, "Number of interrupts needs to be greater 0");
+        return;
+    }
+    ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
+}
+
+static void ics_base_instance_init(Object *obj)
+{
+    ICSState *ics =3D ICS_BASE(obj);
+
+    ics->offset =3D XICS_IRQ_BASE;
+}
+
+static int ics_base_dispatch_pre_save(void *opaque)
 {
     ICSState *ics =3D opaque;
     ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
@@ -578,7 +658,7 @@ static int ics_simple_dispatch_pre_save(void *opaque)
     return 0;
 }
=20
-static int ics_simple_dispatch_post_load(void *opaque, int version_id)
+static int ics_base_dispatch_post_load(void *opaque, int version_id)
 {
     ICSState *ics =3D opaque;
     ICSStateClass *info =3D ICS_BASE_GET_CLASS(ics);
@@ -590,7 +670,7 @@ static int ics_simple_dispatch_post_load(void *opaque=
, int version_id)
     return 0;
 }
=20
-static const VMStateDescription vmstate_ics_simple_irq =3D {
+static const VMStateDescription vmstate_ics_base_irq =3D {
     .name =3D "ics/irq",
     .version_id =3D 2,
     .minimum_version_id =3D 1,
@@ -604,95 +684,36 @@ static const VMStateDescription vmstate_ics_simple_=
irq =3D {
     },
 };
=20
-static const VMStateDescription vmstate_ics_simple =3D {
+static const VMStateDescription vmstate_ics_base =3D {
     .name =3D "ics",
     .version_id =3D 1,
     .minimum_version_id =3D 1,
-    .pre_save =3D ics_simple_dispatch_pre_save,
-    .post_load =3D ics_simple_dispatch_post_load,
+    .pre_save =3D ics_base_dispatch_pre_save,
+    .post_load =3D ics_base_dispatch_post_load,
     .fields =3D (VMStateField[]) {
         /* Sanity check */
         VMSTATE_UINT32_EQUAL(nr_irqs, ICSState, NULL),
=20
         VMSTATE_STRUCT_VARRAY_POINTER_UINT32(irqs, ICSState, nr_irqs,
-                                             vmstate_ics_simple_irq,
+                                             vmstate_ics_base_irq,
                                              ICSIRQState),
         VMSTATE_END_OF_LIST()
     },
 };
=20
-static void ics_simple_initfn(Object *obj)
-{
-    ICSState *ics =3D ICS_SIMPLE(obj);
-
-    ics->offset =3D XICS_IRQ_BASE;
-}
-
-static void ics_simple_realize(ICSState *ics, Error **errp)
-{
-    if (!ics->nr_irqs) {
-        error_setg(errp, "Number of interrupts needs to be greater 0");
-        return;
-    }
-    ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
-    ics->qirqs =3D qemu_allocate_irqs(ics_simple_set_irq, ics, ics->nr_i=
rqs);
-
-    qemu_register_reset(ics_simple_reset, ics);
-}
-
-static Property ics_simple_properties[] =3D {
+static Property ics_base_properties[] =3D {
     DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
-static void ics_simple_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc =3D DEVICE_CLASS(klass);
-    ICSStateClass *isc =3D ICS_BASE_CLASS(klass);
-
-    isc->realize =3D ics_simple_realize;
-    dc->props =3D ics_simple_properties;
-    dc->vmsd =3D &vmstate_ics_simple;
-    isc->reject =3D ics_simple_reject;
-    isc->resend =3D ics_simple_resend;
-    isc->eoi =3D ics_simple_eoi;
-}
-
-static const TypeInfo ics_simple_info =3D {
-    .name =3D TYPE_ICS_SIMPLE,
-    .parent =3D TYPE_ICS_BASE,
-    .instance_size =3D sizeof(ICSState),
-    .class_init =3D ics_simple_class_init,
-    .class_size =3D sizeof(ICSStateClass),
-    .instance_init =3D ics_simple_initfn,
-};
-
-static void ics_base_realize(DeviceState *dev, Error **errp)
-{
-    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
-    ICSState *ics =3D ICS_BASE(dev);
-    Object *obj;
-    Error *err =3D NULL;
-
-    obj =3D object_property_get_link(OBJECT(dev), ICS_PROP_XICS, &err);
-    if (!obj) {
-        error_propagate(errp, err);
-        error_prepend(errp, "required link '" ICS_PROP_XICS "' not found=
: ");
-        return;
-    }
-    ics->xics =3D XICS_FABRIC(obj);
-
-
-    if (icsc->realize) {
-        icsc->realize(ics, errp);
-    }
-}
-
 static void ics_base_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->realize =3D ics_base_realize;
+    dc->reset =3D ics_base_reset;
+    dc->props =3D ics_base_properties;
+    dc->vmsd =3D &vmstate_ics_base;
 }
=20
 static const TypeInfo ics_base_info =3D {
@@ -700,6 +721,7 @@ static const TypeInfo ics_base_info =3D {
     .parent =3D TYPE_DEVICE,
     .abstract =3D true,
     .instance_size =3D sizeof(ICSState),
+    .instance_init =3D ics_base_instance_init,
     .class_init =3D ics_base_class_init,
     .class_size =3D sizeof(ICSStateClass),
 };
diff --git a/hw/intc/xics_kvm.c b/hw/intc/xics_kvm.c
index 8dba2f84e71e..57d0ebbfaa8a 100644
--- a/hw/intc/xics_kvm.c
+++ b/hw/intc/xics_kvm.c
@@ -304,44 +304,47 @@ static void ics_kvm_set_irq(void *opaque, int srcno=
, int val)
     }
 }
=20
-static void ics_kvm_reset(void *dev)
+static void ics_kvm_reset(DeviceState *dev)
 {
-    ICSState *ics =3D ICS_SIMPLE(dev);
-    int i;
-    uint8_t flags[ics->nr_irqs];
-
-    for (i =3D 0; i < ics->nr_irqs; i++) {
-        flags[i] =3D ics->irqs[i].flags;
-    }
+    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(dev);
=20
-    memset(ics->irqs, 0, sizeof(ICSIRQState) * ics->nr_irqs);
+    icsc->parent_reset(dev);
=20
-    for (i =3D 0; i < ics->nr_irqs; i++) {
-        ics->irqs[i].priority =3D 0xff;
-        ics->irqs[i].saved_priority =3D 0xff;
-        ics->irqs[i].flags =3D flags[i];
-    }
+    ics_set_kvm_state(ICS_KVM(dev), 1);
+}
=20
-    ics_set_kvm_state(ics, 1);
+static void ics_kvm_reset_handler(void *dev)
+{
+    ics_kvm_reset(dev);
 }
=20
-static void ics_kvm_realize(ICSState *ics, Error **errp)
+static void ics_kvm_realize(DeviceState *dev, Error **errp)
 {
-    if (!ics->nr_irqs) {
-        error_setg(errp, "Number of interrupts needs to be greater 0");
+    ICSState *ics =3D ICS_BASE(dev);
+    ICSStateClass *icsc =3D ICS_BASE_GET_CLASS(ics);
+    Error *local_err =3D NULL;
+
+    icsc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         return;
     }
-    ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
+
     ics->qirqs =3D qemu_allocate_irqs(ics_kvm_set_irq, ics, ics->nr_irqs=
);
=20
-    qemu_register_reset(ics_kvm_reset, ics);
+    qemu_register_reset(ics_kvm_reset_handler, ics);
 }
=20
 static void ics_kvm_class_init(ObjectClass *klass, void *data)
 {
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
     ICSStateClass *icsc =3D ICS_BASE_CLASS(klass);
=20
-    icsc->realize =3D ics_kvm_realize;
+    device_class_set_parent_realize(dc, ics_kvm_realize,
+                                    &icsc->parent_realize);
+    device_class_set_parent_reset(dc, ics_kvm_reset,
+                                  &icsc->parent_reset);
+
     icsc->pre_save =3D ics_get_kvm_state;
     icsc->post_load =3D ics_set_kvm_state;
     icsc->synchronize_state =3D ics_synchronize_state;
@@ -349,7 +352,7 @@ static void ics_kvm_class_init(ObjectClass *klass, vo=
id *data)
=20
 static const TypeInfo ics_kvm_info =3D {
     .name =3D TYPE_ICS_KVM,
-    .parent =3D TYPE_ICS_SIMPLE,
+    .parent =3D TYPE_ICS_BASE,
     .instance_size =3D sizeof(ICSState),
     .class_init =3D ics_kvm_class_init,
 };
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 78186500e917..468539100327 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -136,7 +136,7 @@ static ICSState *spapr_ics_create(sPAPRMachineState *=
spapr,
         goto error;
     }
=20
-    return ICS_SIMPLE(obj);
+    return ICS_BASE(obj);
=20
 error:
     error_propagate(errp, local_err);
--=20
2.13.6
