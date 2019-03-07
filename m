Received: from eggs.gnu.org ([209.51.188.92]:33962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21cu-00076X-84
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21co-0002dr-6g
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:28 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:46420)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21cn-00025C-6c
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:25 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27MIaUf103641
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 17:36:05 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2r39vpens7-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:36:04 -0500
Received: from localhost
	by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 7 Mar 2019 22:36:02 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Mar 2019 23:35:44 +0100
In-Reply-To: <20190307223548.20516-1-clg@kaod.org>
References: <20190307223548.20516-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190307223548.20516-12-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 11/15] ppc/pnv: POWER9 XSCOM quad support
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

The POWER9 processor does not support per-core frequency control. The
cores are arranged in groups of four, along with their respective L2
and L3 caches, into a structure known as a Quad. The frequency must be
managed at the Quad level.

Provide a basic Quad model to fake the settings done by the firmware
on the Non-Cacheable Unit (NCU). Each core pair (EX) needs a special
BAR setting for the TIMA area of XIVE because it resides on the same
address on all chips.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h       |  4 ++
 include/hw/ppc/pnv_core.h  | 10 +++++
 include/hw/ppc/pnv_xscom.h | 12 ++++--
 hw/ppc/pnv.c               | 38 ++++++++++++++++-
 hw/ppc/pnv_core.c          | 87 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 146 insertions(+), 5 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 39888f9d52c1..e5b00d373ed2 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -26,6 +26,7 @@
 #include "hw/ppc/pnv_psi.h"
 #include "hw/ppc/pnv_occ.h"
 #include "hw/ppc/pnv_xive.h"
+#include "hw/ppc/pnv_core.h"
=20
 #define TYPE_PNV_CHIP "pnv-chip"
 #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
@@ -89,6 +90,9 @@ typedef struct Pnv9Chip {
     Pnv9Psi      psi;
     PnvLpcController lpc;
     PnvOCC       occ;
+
+    uint32_t     nr_quads;
+    PnvQuad      *quads;
 } Pnv9Chip;
=20
 typedef struct PnvChipClass {
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index cbe9ad36f32c..50cdb2b35838 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -58,4 +58,14 @@ static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *c=
pu)
     return (PnvCPUState *)cpu->machine_data;
 }
=20
+#define TYPE_PNV_QUAD "powernv-cpu-quad"
+#define PNV_QUAD(obj) \
+    OBJECT_CHECK(PnvQuad, (obj), TYPE_PNV_QUAD)
+
+typedef struct PnvQuad {
+    DeviceState parent_obj;
+
+    uint32_t id;
+    MemoryRegion xscom_regs;
+} PnvQuad;
 #endif /* _PPC_PNV_CORE_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 3292459fbb78..68dfae0dfe41 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -60,10 +60,6 @@ typedef struct PnvXScomInterfaceClass {
     (PNV_XSCOM_EX_CORE_BASE | ((uint64_t)(core) << 24))
 #define PNV_XSCOM_EX_SIZE         0x100000
=20
-#define PNV_XSCOM_P9_EC_BASE(core) \
-    ((uint64_t)(((core) & 0x1F) + 0x20) << 24)
-#define PNV_XSCOM_P9_EC_SIZE      0x100000
-
 #define PNV_XSCOM_LPC_BASE        0xb0020
 #define PNV_XSCOM_LPC_SIZE        0x4
=20
@@ -73,6 +69,14 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_OCC_BASE        0x0066000
 #define PNV_XSCOM_OCC_SIZE        0x6000
=20
+#define PNV9_XSCOM_EC_BASE(core) \
+    ((uint64_t)(((core) & 0x1F) + 0x20) << 24)
+#define PNV9_XSCOM_EC_SIZE        0x100000
+
+#define PNV9_XSCOM_EQ_BASE(core) \
+    ((uint64_t)(((core) & 0x1C) + 0x40) << 22)
+#define PNV9_XSCOM_EQ_SIZE        0x100000
+
 #define PNV9_XSCOM_OCC_BASE       PNV_XSCOM_OCC_BASE
 #define PNV9_XSCOM_OCC_SIZE       0x8000
=20
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1559a733235b..e68d419203e8 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -963,6 +963,36 @@ static void pnv_chip_power9_instance_init(Object *ob=
j)
                                    OBJECT(&chip9->psi), &error_abort);
 }
=20
+static void pnv_chip_quad_realize(Pnv9Chip *chip9, Error **errp)
+{
+    PnvChip *chip =3D PNV_CHIP(chip9);
+    const char *typename =3D pnv_chip_core_typename(chip);
+    size_t typesize =3D object_type_get_instance_size(typename);
+    int i;
+
+    chip9->nr_quads =3D DIV_ROUND_UP(chip->nr_cores, 4);
+    chip9->quads =3D g_new0(PnvQuad, chip9->nr_quads);
+
+    for (i =3D 0; i < chip9->nr_quads; i++) {
+        char eq_name[32];
+        PnvQuad *eq =3D &chip9->quads[i];
+        PnvCore *pnv_core =3D PNV_CORE(chip->cores + (i * 4) * typesize)=
;
+        int core_id =3D CPU_CORE(pnv_core)->core_id;
+
+        object_initialize(eq, sizeof(*eq), TYPE_PNV_QUAD);
+        snprintf(eq_name, sizeof(eq_name), "eq[%d]", core_id);
+
+        object_property_add_child(OBJECT(chip), eq_name, OBJECT(eq),
+                                  &error_fatal);
+        object_property_set_int(OBJECT(eq), core_id, "id", &error_fatal)=
;
+        object_property_set_bool(OBJECT(eq), true, "realized", &error_fa=
tal);
+        object_unref(OBJECT(eq));
+
+        pnv_xscom_add_subregion(chip, PNV9_XSCOM_EQ_BASE(eq->id),
+                                &eq->xscom_regs);
+    }
+}
+
 static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
 {
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
@@ -977,6 +1007,12 @@ static void pnv_chip_power9_realize(DeviceState *de=
v, Error **errp)
         return;
     }
=20
+    pnv_chip_quad_realize(chip9, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
     /* XIVE interrupt controller (POWER9) */
     object_property_set_int(OBJECT(&chip9->xive), PNV9_XIVE_IC_BASE(chip=
),
                             "ic-bar", &error_fatal);
@@ -1135,7 +1171,7 @@ static void pnv_chip_core_realize(PnvChip *chip, Er=
ror **errp)
         if (!pnv_chip_is_power9(chip)) {
             xscom_core_base =3D PNV_XSCOM_EX_BASE(core_hwid);
         } else {
-            xscom_core_base =3D PNV_XSCOM_P9_EC_BASE(core_hwid);
+            xscom_core_base =3D PNV9_XSCOM_EC_BASE(core_hwid);
         }
=20
         pnv_xscom_add_subregion(chip, xscom_core_base,
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 171474e0805c..5feeed6bc463 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -327,3 +327,90 @@ static const TypeInfo pnv_core_infos[] =3D {
 };
=20
 DEFINE_TYPES(pnv_core_infos)
+
+/*
+ * POWER9 Quads
+ */
+
+#define P9X_EX_NCU_SPEC_BAR                     0x11010
+
+static uint64_t pnv_quad_xscom_read(void *opaque, hwaddr addr,
+                                    unsigned int width)
+{
+    uint32_t offset =3D addr >> 3;
+    uint64_t val =3D -1;
+
+    switch (offset) {
+    case P9X_EX_NCU_SPEC_BAR:
+    case P9X_EX_NCU_SPEC_BAR + 0x400: /* Second EX */
+        val =3D 0;
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
+                      offset);
+    }
+
+    return val;
+}
+
+static void pnv_quad_xscom_write(void *opaque, hwaddr addr, uint64_t val=
,
+                                 unsigned int width)
+{
+    uint32_t offset =3D addr >> 3;
+
+    switch (offset) {
+    case P9X_EX_NCU_SPEC_BAR:
+    case P9X_EX_NCU_SPEC_BAR + 0x400: /* Second EX */
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "%s: writing @0x%08x\n", __func__,
+                  offset);
+    }
+}
+
+static const MemoryRegionOps pnv_quad_xscom_ops =3D {
+    .read =3D pnv_quad_xscom_read,
+    .write =3D pnv_quad_xscom_write,
+    .valid.min_access_size =3D 8,
+    .valid.max_access_size =3D 8,
+    .impl.min_access_size =3D 8,
+    .impl.max_access_size =3D 8,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+};
+
+static void pnv_quad_realize(DeviceState *dev, Error **errp)
+{
+    PnvQuad *eq =3D PNV_QUAD(dev);
+    char name[32];
+
+    snprintf(name, sizeof(name), "xscom-quad.%d", eq->id);
+    pnv_xscom_region_init(&eq->xscom_regs, OBJECT(dev), &pnv_quad_xscom_=
ops,
+                          eq, name, PNV9_XSCOM_EQ_SIZE);
+}
+
+static Property pnv_quad_properties[] =3D {
+    DEFINE_PROP_UINT32("id", PnvQuad, id, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_quad_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(oc);
+
+    dc->realize =3D pnv_quad_realize;
+    dc->props =3D pnv_quad_properties;
+}
+
+static const TypeInfo pnv_quad_info =3D {
+    .name          =3D TYPE_PNV_QUAD,
+    .parent        =3D TYPE_DEVICE,
+    .instance_size =3D sizeof(PnvQuad),
+    .class_init    =3D pnv_quad_class_init,
+};
+
+static void pnv_core_register_types(void)
+{
+    type_register_static(&pnv_quad_info);
+}
+
+type_init(pnv_core_register_types)
--=20
2.20.1
