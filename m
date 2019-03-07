Received: from eggs.gnu.org ([209.51.188.92]:34353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21dR-0007eZ-KK
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21dQ-0003WB-2K
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:05 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45404
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21dO-000237-MN
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:37:02 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27MJ5rJ172810
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 17:36:04 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r38ya92pg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:36:04 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 7 Mar 2019 22:36:02 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Mar 2019 23:35:41 +0100
In-Reply-To: <20190307223548.20516-1-clg@kaod.org>
References: <20190307223548.20516-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190307223548.20516-9-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/15] ppc/pnv: add a OCC model class
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

To ease the introduction of the OCC model for POWER9, provide a new
class attributes to define XSCOM operations per CPU family and a PSI
IRQ number.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---

 Changes in v2:

 - new attributes to define XSCOM operations per CPU family and a PSI
   IRQ number.

 include/hw/ppc/pnv_occ.h | 15 +++++++++++
 hw/ppc/pnv.c             |  2 +-
 hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++++++-------------
 3 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index 82f299dc76ff..dab5a05f8e99 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -23,6 +23,8 @@
=20
 #define TYPE_PNV_OCC "pnv-occ"
 #define PNV_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV_OCC)
+#define TYPE_PNV8_OCC TYPE_PNV_OCC "-POWER8"
+#define PNV8_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV8_OCC)
=20
 typedef struct PnvOCC {
     DeviceState xd;
@@ -35,4 +37,17 @@ typedef struct PnvOCC {
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
+    const MemoryRegionOps *xscom_ops;
+    int psi_irq;
+} PnvOCCClass;
+
 #endif /* _PPC_PNV_OCC_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 918fae057b5c..6ae9ce679505 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -790,7 +790,7 @@ static void pnv_chip_power8_instance_init(Object *obj=
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
index 04880f26d612..ea725647c988 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -34,15 +34,17 @@
 static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
 {
     bool irq_state;
+    PnvOCCClass *poc =3D PNV_OCC_GET_CLASS(occ);
=20
     val &=3D 0xffff000000000000ull;
=20
     occ->occmisc =3D val;
     irq_state =3D !!(val >> 63);
-    pnv_psi_irq_set(occ->psi, PSIHB_IRQ_OCC, irq_state);
+    pnv_psi_irq_set(occ->psi, poc->psi_irq, irq_state);
 }
=20
-static uint64_t pnv_occ_xscom_read(void *opaque, hwaddr addr, unsigned s=
ize)
+static uint64_t pnv_occ_power8_xscom_read(void *opaque, hwaddr addr,
+                                          unsigned size)
 {
     PnvOCC *occ =3D PNV_OCC(opaque);
     uint32_t offset =3D addr >> 3;
@@ -54,13 +56,13 @@ static uint64_t pnv_occ_xscom_read(void *opaque, hwad=
dr addr, unsigned size)
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
-                      HWADDR_PRIx "\n", addr);
+                      HWADDR_PRIx "\n", addr >> 3);
     }
     return val;
 }
=20
-static void pnv_occ_xscom_write(void *opaque, hwaddr addr,
-                                uint64_t val, unsigned size)
+static void pnv_occ_power8_xscom_write(void *opaque, hwaddr addr,
+                                       uint64_t val, unsigned size)
 {
     PnvOCC *occ =3D PNV_OCC(opaque);
     uint32_t offset =3D addr >> 3;
@@ -77,13 +79,13 @@ static void pnv_occ_xscom_write(void *opaque, hwaddr =
addr,
         break;
     default:
         qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
-                      HWADDR_PRIx "\n", addr);
+                      HWADDR_PRIx "\n", addr >> 3);
     }
 }
=20
-static const MemoryRegionOps pnv_occ_xscom_ops =3D {
-    .read =3D pnv_occ_xscom_read,
-    .write =3D pnv_occ_xscom_write,
+static const MemoryRegionOps pnv_occ_power8_xscom_ops =3D {
+    .read =3D pnv_occ_power8_xscom_read,
+    .write =3D pnv_occ_power8_xscom_write,
     .valid.min_access_size =3D 8,
     .valid.max_access_size =3D 8,
     .impl.min_access_size =3D 8,
@@ -91,27 +93,42 @@ static const MemoryRegionOps pnv_occ_xscom_ops =3D {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
+static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
+{
+    PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
+
+    poc->xscom_size =3D PNV_XSCOM_OCC_SIZE;
+    poc->xscom_ops =3D &pnv_occ_power8_xscom_ops;
+    poc->psi_irq =3D PSIHB_IRQ_OCC;
+}
+
+static const TypeInfo pnv_occ_power8_type_info =3D {
+    .name          =3D TYPE_PNV8_OCC,
+    .parent        =3D TYPE_PNV_OCC,
+    .instance_size =3D sizeof(PnvOCC),
+    .class_init    =3D pnv_occ_power8_class_init,
+};
=20
 static void pnv_occ_realize(DeviceState *dev, Error **errp)
 {
     PnvOCC *occ =3D PNV_OCC(dev);
+    PnvOCCClass *poc =3D PNV_OCC_GET_CLASS(occ);
     Object *obj;
-    Error *error =3D NULL;
+    Error *local_err =3D NULL;
=20
     occ->occmisc =3D 0;
=20
-    /* get PSI object from chip */
-    obj =3D object_property_get_link(OBJECT(dev), "psi", &error);
+    obj =3D object_property_get_link(OBJECT(dev), "psi", &local_err);
     if (!obj) {
-        error_setg(errp, "%s: required link 'psi' not found: %s",
-                   __func__, error_get_pretty(error));
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'psi' not found: ");
         return;
     }
     occ->psi =3D PNV_PSI(obj);
=20
     /* XScom region for OCC registers */
-    pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), &pnv_occ_xscom_=
ops,
-                  occ, "xscom-occ", PNV_XSCOM_OCC_SIZE);
+    pnv_xscom_region_init(&occ->xscom_regs, OBJECT(dev), poc->xscom_ops,
+                          occ, "xscom-occ", poc->xscom_size);
 }
=20
 static void pnv_occ_class_init(ObjectClass *klass, void *data)
@@ -119,6 +136,7 @@ static void pnv_occ_class_init(ObjectClass *klass, vo=
id *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
=20
     dc->realize =3D pnv_occ_realize;
+    dc->desc =3D "PowerNV OCC Controller";
 }
=20
 static const TypeInfo pnv_occ_type_info =3D {
@@ -126,11 +144,14 @@ static const TypeInfo pnv_occ_type_info =3D {
     .parent        =3D TYPE_DEVICE,
     .instance_size =3D sizeof(PnvOCC),
     .class_init    =3D pnv_occ_class_init,
+    .class_size    =3D sizeof(PnvOCCClass),
+    .abstract      =3D true,
 };
=20
 static void pnv_occ_register_types(void)
 {
     type_register_static(&pnv_occ_type_info);
+    type_register_static(&pnv_occ_power8_type_info);
 }
=20
-type_init(pnv_occ_register_types)
+type_init(pnv_occ_register_types);
--=20
2.20.1
