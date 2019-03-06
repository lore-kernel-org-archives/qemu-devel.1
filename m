Received: from eggs.gnu.org ([209.51.188.92]:55095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGo-0006D4-TQ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h1SGk-0001j4-Fo
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:21 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44536
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h1SGj-0001PD-Sl
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 03:51:18 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x268mWLe005150
	for <qemu-devel@nongnu.org>; Wed, 6 Mar 2019 03:50:59 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r29u1kv8f-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Mar 2019 03:50:59 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Wed, 6 Mar 2019 08:50:57 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Wed,  6 Mar 2019 09:50:26 +0100
In-Reply-To: <20190306085032.15744-1-clg@kaod.org>
References: <20190306085032.15744-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190306085032.15744-22-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 21/27] ppc/pnv: add a OCC model for POWER9
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

The OCC on POWER9 is very similar to the one found on POWER8. Provide
the same routines with P9 values for the registers and IRQ number.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h       |  1 +
 include/hw/ppc/pnv_occ.h   |  4 ++++
 include/hw/ppc/pnv_xscom.h |  3 +++
 hw/ppc/pnv.c               | 13 +++++++++++++
 hw/ppc/pnv_occ.c           | 40 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 61 insertions(+)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 2d68aabc212f..ad3bf0690ecf 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -86,6 +86,7 @@ typedef struct Pnv9Chip {
     PnvXive      xive;
     PnvPsi       psi;
     PnvLpcController lpc;
+    PnvOCC       occ;
 } Pnv9Chip;
=20
 typedef struct PnvChipClass {
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index ce2631e21f5e..8951eb7ea316 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -27,6 +27,10 @@
 #define PNV8_OCC(obj) \
     OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV8_OCC)
=20
+#define TYPE_PNV9_OCC TYPE_PNV_OCC "-POWER9"
+#define PNV9_OCC(obj) \
+    OBJECT_CHECK(PnvOCC, (obj), TYPE_PNV9_OCC)
+
 typedef struct PnvOCC {
     DeviceState xd;
=20
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 403a365ed274..3292459fbb78 100644
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
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 81ab53899dbc..a056064c8c11 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -968,6 +968,11 @@ static void pnv_chip_power9_instance_init(Object *ob=
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
@@ -1020,6 +1025,14 @@ static void pnv_chip_power9_realize(DeviceState *d=
ev, Error **errp)
     }
     memory_region_add_subregion(get_system_memory(), PNV9_LPCM_BASE(chip=
),
                                 &chip9->lpc.xscom_regs);
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
index a210f44926aa..59b0702bc716 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -31,6 +31,10 @@
 #define OCB_OCI_OCCMISC_AND     0x4021
 #define OCB_OCI_OCCMISC_OR      0x4022
=20
+#define P9_OCB_OCI_OCCMISC              0x6080
+#define P9_OCB_OCI_OCCMISC_CLEAR        0x6081
+#define P9_OCB_OCI_OCCMISC_OR           0x6082
+
 static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val)
 {
     bool irq_state;
@@ -42,6 +46,17 @@ static void pnv_occ_set_misc(PnvOCC *occ, uint64_t val=
)
     pnv_psi_irq_set(occ->psi, PSIHB_IRQ_OCC, irq_state);
 }
=20
+static void pnv_occ_p9_set_misc(PnvOCC *occ, uint64_t val)
+{
+    bool irq_state;
+
+    val &=3D 0xffff000000000000ull;
+
+    occ->occmisc =3D val;
+    irq_state =3D !!(val >> 63);
+    pnv_psi_irq_set(occ->psi, PSIHB9_IRQ_OCC, irq_state);
+}
+
 static uint64_t pnv_occ_xscom_read(void *opaque, hwaddr addr, unsigned s=
ize)
 {
     PnvOCC *occ =3D PNV_OCC(opaque);
@@ -50,6 +65,7 @@ static uint64_t pnv_occ_xscom_read(void *opaque, hwaddr=
 addr, unsigned size)
=20
     switch (offset) {
     case OCB_OCI_OCCMISC:
+    case P9_OCB_OCI_OCCMISC:
         val =3D occ->occmisc;
         break;
     default:
@@ -75,6 +91,15 @@ static void pnv_occ_xscom_write(void *opaque, hwaddr a=
ddr,
     case OCB_OCI_OCCMISC:
         pnv_occ_set_misc(occ, val);
         break;
+    case P9_OCB_OCI_OCCMISC_CLEAR:
+        pnv_occ_p9_set_misc(occ, 0);
+        break;
+    case P9_OCB_OCI_OCCMISC_OR:
+        pnv_occ_p9_set_misc(occ, occ->occmisc | val);
+        break;
+    case P9_OCB_OCI_OCCMISC:
+        pnv_occ_p9_set_misc(occ, val);
+       break;
     default:
         qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
                       HWADDR_PRIx "\n", addr >> 3);
@@ -115,6 +140,20 @@ static void pnv_occ_realize(DeviceState *dev, Error =
**errp)
                   occ, "xscom-occ", poc->xscom_size);
 }
=20
+static void pnv_occ_power9_class_init(ObjectClass *klass, void *data)
+{
+    PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
+
+    poc->xscom_size =3D PNV9_XSCOM_OCC_SIZE;
+}
+
+static const TypeInfo pnv_occ_power9_type_info =3D {
+    .name          =3D TYPE_PNV9_OCC,
+    .parent        =3D TYPE_PNV_OCC,
+    .instance_size =3D sizeof(PnvOCC),
+    .class_init    =3D pnv_occ_power9_class_init,
+};
+
 static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
 {
     PnvOCCClass *poc =3D PNV_OCC_CLASS(klass);
@@ -148,6 +187,7 @@ static void pnv_occ_register_types(void)
 {
     type_register_static(&pnv_occ_type_info);
     type_register_static(&pnv_occ_power8_type_info);
+    type_register_static(&pnv_occ_power9_type_info);
 }
=20
 type_init(pnv_occ_register_types)
--=20
2.20.1
