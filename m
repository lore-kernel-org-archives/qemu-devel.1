Received: from eggs.gnu.org ([209.51.188.92]:36876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ghB8M-0003gE-Qd
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1ghB8M-0002OS-2F
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:30:50 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1ghB8L-0002II-Nj
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 05:30:49 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09ASm52108403
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 05:30:41 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pwahr454v-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 05:30:40 -0500
Received: from localhost
	by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 9 Jan 2019 10:30:38 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  9 Jan 2019 11:30:28 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190109103028.24723-1-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] spapr/vio: remove the "irq" property"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Thomas Huth <thuth@redhat.com>, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

commit efe2add7cb7f ("spapr/vio: deprecate the "irq" property") was
merged in QEMU version 3.0. The "irq" property" can be removed for
QEMU version 4.0, 2 version later.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 The machine uselessly allocates an IRQ number for the sPAPR NVRAM.
 This is harmless but still a little ugly.

 hw/ppc/spapr_vio.c | 47 ++++++----------------------------------------
 1 file changed, 6 insertions(+), 41 deletions(-)

diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
index 7e8a9ad09337..414673d31341 100644
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
--=20
2.20.1
