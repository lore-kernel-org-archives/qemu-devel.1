Received: from eggs.gnu.org ([209.51.188.92]:43650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpG-00028l-Sg
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpF-00025y-Pa
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:54 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:54 +1100
Message-Id: <20190310082703.1245-52-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 51/60] ppc/pnv: add a OCC model for POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The OCC on POWER9 is very similar to the one found on POWER8. Provide
the same routines with P9 values for the registers and IRQ number.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190307223548.20516-10-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c               | 13 +++++++
 hw/ppc/pnv_occ.c           | 72 ++++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv.h       |  1 +
 include/hw/ppc/pnv_occ.h   |  2 ++
 include/hw/ppc/pnv_xscom.h |  3 ++
 5 files changed, 91 insertions(+)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 6ae9ce6795..1559a73323 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -956,6 +956,11 @@ static void pnv_chip_power9_instance_init(Object *ob=
j)
                             TYPE_PNV9_LPC, &error_abort, NULL);
     object_property_add_const_link(OBJECT(&chip9->lpc), "psi",
                                    OBJECT(&chip9->psi), &error_abort);
+
+    object_initialize_child(obj, "occ",  &chip9->occ, sizeof(chip9->occ)=
,
+                            TYPE_PNV9_OCC, &error_abort, NULL);
+    object_property_add_const_link(OBJECT(&chip9->occ), "psi",
+                                   OBJECT(&chip9->psi), &error_abort);
 }
=20
 static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
@@ -1012,6 +1017,14 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
=20
     chip->dt_isa_nodename =3D g_strdup_printf("/lpcm-opb@%" PRIx64 "/lpc=
@0",
                                             (uint64_t) PNV9_LPCM_BASE(ch=
ip));
+
+    /* Create the simplified OCC model */
+    object_property_set_bool(OBJECT(&chip9->occ), true, "realized", &loc=
al_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV9_XSCOM_OCC_BASE, &chip9->occ.xscom=
_regs);
 }
=20
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index ea725647c9..fdd9296e1b 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -109,6 +109,77 @@ static const TypeInfo pnv_occ_power8_type_info =3D {
     .class_init    =3D pnv_occ_power8_class_init,
 };
=20
+#define P9_OCB_OCI_OCCMISC              0x6080
+#define P9_OCB_OCI_OCCMISC_CLEAR        0x6081
+#define P9_OCB_OCI_OCCMISC_OR           0x6082
+
+
+static uint64_t pnv_occ_power9_xscom_read(void *opaque, hwaddr addr,
+                                          unsigned size)
+{
+    PnvOCC *occ =3D PNV_OCC(opaque);
+    uint32_t offset =3D addr >> 3;
+    uint64_t val =3D 0;
+
+    switch (offset) {
+    case P9_OCB_OCI_OCCMISC:
+        val =3D occ->occmisc;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
+                      HWADDR_PRIx "\n", addr >> 3);
+    }
+    return val;
+}
+
+static void pnv_occ_power9_xscom_write(void *opaque, hwaddr addr,
+                                       uint64_t val, unsigned size)
+{
+    PnvOCC *occ =3D PNV_OCC(opaque);
+    uint32_t offset =3D addr >> 3;
+
+    switch (offset) {
+    case P9_OCB_OCI_OCCMISC_CLEAR:
+        pnv_occ_set_misc(occ, 0);
+        break;
+    case P9_OCB_OCI_OCCMISC_OR:
+        pnv_occ_set_misc(occ, occ->occmisc | val);
+        break;
+    case P9_OCB_OCI_OCCMISC:
+        pnv_occ_set_misc(occ, val);
+       break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
+                      HWADDR_PRIx "\n", addr >> 3);
+    }
+}
+
+static const MemoryRegionOps pnv_occ_power9_xscom_ops =3D {
+    .read =3D pnv_occ_power9_xscom_read,
+    .write =3D pnv_occ_power9_xscom_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_occ_power9_class_init(ObjectClass *klass, void *data)
+{
+    PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
+
+    poc->xscom_size =3D PNV9_XSCOM_OCC_SIZE;
+    poc->xscom_ops =3D &pnv_occ_power9_xscom_ops;
+    poc->psi_irq =3D PSIHB9_IRQ_OCC;
+}
+
+static const TypeInfo pnv_occ_power9_type_info =3D {
+    .name          =3D TYPE_PNV9_OCC,
+    .parent        =3D TYPE_PNV_OCC,
+    .instance_size =3D sizeof(PnvOCC),
+    .class_init    =3D pnv_occ_power9_class_init,
+};
+
 static void pnv_occ_realize(DeviceState *dev, Error **errp)
 {
     PnvOCC *occ =3D PNV_OCC(dev);
@@ -152,6 +223,7 @@ static void pnv_occ_register_types(void)
 {
     type_register_static(&pnv_occ_type_info);
     type_register_static(&pnv_occ_power8_type_info);
+    type_register_static(&pnv_occ_power9_type_info);
 }
=20
 type_init(pnv_occ_register_types);
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 1cd1ad622d..39888f9d52 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -88,6 +88,7 @@ typedef struct Pnv9Chip {
     PnvXive      xive;
     Pnv9Psi      psi;
     PnvLpcController lpc;
+    PnvOCC       occ;
 } Pnv9Chip;
=20
 typedef struct PnvChipClass {
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index dab5a05f8e..d22b65a71a 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -25,6 +25,8 @@
 #define PNV_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV_OCC)
 #define TYPE_PNV8_OCC TYPE_PNV_OCC "-POWER8"
 #define PNV8_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV8_OCC)
+#define TYPE_PNV9_OCC TYPE_PNV_OCC "-POWER9"
+#define PNV9_OCC(obj) OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV9_OCC)
=20
 typedef struct PnvOCC {
     DeviceState xd;
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 403a365ed2..3292459fbb 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -73,6 +73,9 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_OCC_BASE        0x0066000
 #define PNV_XSCOM_OCC_SIZE        0x6000
=20
+#define PNV9_XSCOM_OCC_BASE       PNV_XSCOM_OCC_BASE
+#define PNV9_XSCOM_OCC_SIZE       0x8000
+
 #define PNV9_XSCOM_PSIHB_BASE     0x5012900
 #define PNV9_XSCOM_PSIHB_SIZE     0x100
=20
--=20
2.20.1
