Received: from eggs.gnu.org ([209.51.188.92]:38283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8f-0000aq-F8
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gqa8d-0007bD-Ov
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 04:02:01 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon,  4 Feb 2019 20:00:58 +1100
Message-Id: <20190204090124.26191-12-david@gibson.dropbear.id.au>
In-Reply-To: <20190204090124.26191-1-david@gibson.dropbear.id.au>
References: <20190204090124.26191-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 11/37] spapr/vio: remove the "irq" property"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, spopovyc@redhat.com, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

commit efe2add7cb7f ("spapr/vio: deprecate the "irq" property") was
merged in QEMU version 3.0. The "irq" property" can be removed for
QEMU version 4.0.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_vio.c   | 47 ++++++--------------------------------------
 qemu-deprecated.texi |  6 ------
 2 files changed, 6 insertions(+), 47 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 7e8a9ad093..414673d313 100644
--- a/hw/ppc/spapr_vio.c
+++ b/hw/ppc/spapr_vio.c
@@ -44,38 +44,6 @@
=20
 #define SPAPR_VIO_REG_BASE 0x71000000
=20
-static void spapr_vio_get_irq(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    Property *prop =3D opaque;
-    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
-
-    visit_type_uint32(v, name, ptr, errp);
-}
-
-static void spapr_vio_set_irq(Object *obj, Visitor *v, const char *name,
-                              void *opaque, Error **errp)
-{
-    Property *prop =3D opaque;
-    uint32_t *ptr =3D qdev_get_prop_ptr(DEVICE(obj), prop);
-
-    if (!qtest_enabled()) {
-        warn_report(TYPE_VIO_SPAPR_DEVICE " '%s' property is deprecated"=
, name);
-    }
-    visit_type_uint32(v, name, ptr, errp);
-}
-
-static const PropertyInfo spapr_vio_irq_propinfo =3D {
-    .name =3D "irq",
-    .get =3D spapr_vio_get_irq,
-    .set =3D spapr_vio_set_irq,
-};
-
-static Property spapr_vio_props[] =3D {
-    DEFINE_PROP("irq", VIOsPAPRDevice, irq, spapr_vio_irq_propinfo, uint=
32_t),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
 static char *spapr_vio_get_dev_name(DeviceState *qdev)
 {
     VIOsPAPRDevice *dev =3D VIO_SPAPR_DEVICE(qdev);
@@ -534,15 +502,13 @@ static void spapr_vio_busdev_realize(DeviceState *q=
dev, Error **errp)
         dev->qdev.id =3D id;
     }
=20
-    if (!dev->irq) {
-        dev->irq =3D spapr_vio_reg_to_irq(dev->reg);
+    dev->irq =3D spapr_vio_reg_to_irq(dev->reg);
=20
-        if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
-            dev->irq =3D spapr_irq_findone(spapr, &local_err);
-            if (local_err) {
-                error_propagate(errp, local_err);
-                return;
-            }
+    if (SPAPR_MACHINE_GET_CLASS(spapr)->legacy_irq_allocation) {
+        dev->irq =3D spapr_irq_findone(spapr, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            return;
         }
     }
=20
@@ -668,7 +634,6 @@ static void vio_spapr_device_class_init(ObjectClass *=
klass, void *data)
     k->realize =3D spapr_vio_busdev_realize;
     k->reset =3D spapr_vio_busdev_reset;
     k->bus_type =3D TYPE_SPAPR_VIO_BUS;
-    k->props =3D spapr_vio_props;
 }
=20
 static const TypeInfo spapr_vio_type_info =3D {
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index dfb278a377..9cc20b365c 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -160,9 +160,3 @@ Example of legacy encoding:
 The above, converted to the current supported format:
=20
 @code{json:@{"file.driver":"rbd", "file.pool":"rbd", "file.image":"name"=
@}}
-
-@subsection vio-spapr-device device options
-
-@subsubsection "irq": "" (since 3.0.0)
-
-The ``irq'' property is obsoleted.
--=20
2.20.1
