Received: from eggs.gnu.org ([209.51.188.92]:55279)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SH0-0006T3-Tj
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGy-0001xh-Fw
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:34 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGu-0001RH-I6
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:31 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mZHx001326
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:59 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r2a9vtek0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:59 -0500
Received: from localhost
	by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:57 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:25 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-21-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 20/27] ppc/pnv: add a OCC model class
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

It will ease the introduction of the OCC model for POWER9.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv_occ.h | 14 ++++++++++++++
 hw/ppc/pnv.c             |  2 +-
 hw/ppc/pnv_occ.c         | 23 ++++++++++++++++++++---
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index 82f299dc76ff..ce2631e21f5e 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -23,6 +23,9 @@
=20
 #define TYPE_PNV_OCC "pnv-occ"
 #define PNV_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV_OCC)
+#define TYPE_PNV8_OCC TYPE_PNV_OCC "-POWER8"
+#define PNV8_OCC(obj) \
+    OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV8_OCC)
=20
 typedef struct PnvOCC {
     DeviceState xd;
@@ -35,4 +38,15 @@ typedef struct PnvOCC {
     MemoryRegion xscom_regs;
 } PnvOCC;
=20
+#define PNV_OCC_CLASS(klass) \
+     OBJECT_CLASS_CHECK(PnvOCCClass, (klass), TYPE_PNV_OCC)
+#define PNV_OCC_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(PnvOCCClass, (obj), TYPE_PNV_OCC)
+
+typedef struct PnvOCCClass {
+    DeviceClass parent_class;
+
+    int xscom_size;
+} PnvOCCClass;
+
 #endif /* _PPC_PNV_OCC_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 895be470af67..81ab53899dbc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -808,7 +808,7 @@ static void pnv_chip_power8_instance_init(Object *obj=
)
                                    OBJECT(&chip8->psi), &error_abort);
=20
     object_initialize_child(obj, "occ",  &chip8->occ, sizeof(chip8->occ)=
,
-                            TYPE_PNV_OCC, &error_abort, NULL);
+                            TYPE_PNV8_OCC, &error_abort, NULL);
     object_property_add_const_link(OBJECT(&chip8->occ), "psi",
                                    OBJECT(&chip8->psi), &error_abort);
 }
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 04880f26d612..a210f44926aa 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -54,7 +54,7 @@ static uint64_t pnv_occ_xscom_read(void *opaque, hwaddr=
 addr, unsigned size)
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
-                      HWADDR_PRIx "\n", addr);
+                      HWADDR_PRIx "\n", addr >> 3);
     }
     return val;
 }
@@ -77,7 +77,7 @@ static void pnv_occ_xscom_write(void *opaque, hwaddr ad=
dr,
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
-                      HWADDR_PRIx "\n", addr);
+                      HWADDR_PRIx "\n", addr >> 3);
     }
 }
=20
@@ -95,6 +95,7 @@ static const MemoryRegionOps pnv_occ_xscom_ops =3D {
 static void pnv_occ_realize(DeviceState *dev, Error **errp)
 {
     PnvOCC *occ =3D PNV_OCC(dev);
+    PnvOCCClass *poc =3D PNV_OCC_GET_CLASS(occ);
     Object *obj;
     Error *error =3D NULL;
=20
@@ -111,9 +112,23 @@ static void pnv_occ_realize(DeviceState *dev, Error =
**errp)
=20
     /* XScom region for OCC registers */
     pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), &pnv_occ_xscom_=
ops,
-                  occ, "xscom-occ", PNV_XSCOM_OCC_SIZE);
+                  occ, "xscom-occ", poc->xscom_size);
 }
=20
+static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
+{
+    PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
+
+    poc->xscom_size =3D PNV_XSCOM_OCC_SIZE;
+}
+
+static const TypeInfo pnv_occ_power8_type_info =3D {
+    .name          =3D TYPE_PNV8_OCC,
+    .parent        =3D TYPE_PNV_OCC,
+    .instance_size =3D sizeof(PnvOCC),
+    .class_init    =3D pnv_occ_power8_class_init,
+};
+
 static void pnv_occ_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -124,6 +139,7 @@ static void pnv_occ_class_init(ObjectClass *klass, vo=
id *data)
 static const TypeInfo pnv_occ_type_info =3D {
     .name          =3D TYPE_PNV_OCC,
     .parent        =3D TYPE_DEVICE,
+    .abstract      =3D true,
     .instance_size =3D sizeof(PnvOCC),
     .class_init    =3D pnv_occ_class_init,
 };
@@ -131,6 +147,7 @@ static const TypeInfo pnv_occ_type_info =3D {
 static void pnv_occ_register_types(void)
 {
     type_register_static(&pnv_occ_type_info);
+    type_register_static(&pnv_occ_power8_type_info);
 }
=20
 type_init(pnv_occ_register_types)
--=20
2.20.1
