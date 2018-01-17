Received: from eggs.gnu.org ([2001:4830:134:3::10]:45883)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQR-0007x8-7Z
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ebdQO-0001Q2-0L
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 21:26:03 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed, 17 Jan 2018 13:25:22 +1100
Message-Id: <20180117022525.31767-20-david@gibson.dropbear.id.au>
In-Reply-To: <20180117022525.31767-1-david@gibson.dropbear.id.au>
References: <20180117022525.31767-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 19/22] ppc/pnv: fix XSCOM core addressing on
 POWER9
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, surajjs@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, joserz@linux.vnet.ibm.com, lvivier@redhat.com, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The XSCOM base address of the core chiplet was wrongly calculated. Use
the OPAL macros to fix that and do a couple of renames.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c               | 15 ++++++++-------
 hw/ppc/pnv_core.c          |  2 +-
 include/hw/ppc/pnv.h       |  1 -
 include/hw/ppc/pnv_xscom.h | 13 +++++++++++--
 tests/pnv-xscom-test.c     | 27 +++++++++++++++++----------
 5 files changed, 37 insertions(+), 21 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index f9591cd41d..80245f57f1 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -721,7 +721,6 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
     k->cores_mask =3D POWER8E_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->xscom_base =3D 0x003fc0000000000ull;
-    k->xscom_core_base =3D 0x10000000ull;
     dc->desc =3D "PowerNV Chip POWER8E";
 }
=20
@@ -735,7 +734,6 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
     k->cores_mask =3D POWER8_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->xscom_base =3D 0x003fc0000000000ull;
-    k->xscom_core_base =3D 0x10000000ull;
     dc->desc =3D "PowerNV Chip POWER8";
 }
=20
@@ -749,7 +747,6 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
     k->cores_mask =3D POWER8_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
     k->xscom_base =3D 0x003fc0000000000ull;
-    k->xscom_core_base =3D 0x10000000ull;
     dc->desc =3D "PowerNV Chip POWER8NVL";
 }
=20
@@ -763,7 +760,6 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
     k->cores_mask =3D POWER9_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p9;
     k->xscom_base =3D 0x00603fc00000000ull;
-    k->xscom_core_base =3D 0x0ull;
     dc->desc =3D "PowerNV Chip POWER9";
 }
=20
@@ -887,6 +883,7 @@ static void pnv_chip_realize(DeviceState *dev, Error =
**errp)
              && (i < chip->nr_cores); core_hwid++) {
         char core_name[32];
         void *pnv_core =3D chip->cores + i * typesize;
+        uint64_t xscom_core_base;
=20
         if (!(chip->cores_mask & (1ull << core_hwid))) {
             continue;
@@ -910,9 +907,13 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
         object_unref(OBJECT(pnv_core));
=20
         /* Each core has an XSCOM MMIO region */
-        pnv_xscom_add_subregion(chip,
-                                PNV_XSCOM_EX_CORE_BASE(pcc->xscom_core_b=
ase,
-                                                       core_hwid),
+        if (!pnv_chip_is_power9(chip)) {
+            xscom_core_base =3D PNV_XSCOM_EX_BASE(core_hwid);
+        } else {
+            xscom_core_base =3D PNV_XSCOM_P9_EC_BASE(core_hwid);
+        }
+
+        pnv_xscom_add_subregion(chip, xscom_core_base,
                                 &PNV_CORE(pnv_core)->xscom_regs);
         i++;
     }
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 7e8a76df44..cbb64ad9e7 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -192,7 +192,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
=20
     snprintf(name, sizeof(name), "xscom-core.%d", cc->core_id);
     pnv_xscom_region_init(&pc->xscom_regs, OBJECT(dev), &pnv_core_xscom_=
ops,
-                          pc, name, PNV_XSCOM_EX_CORE_SIZE);
+                          pc, name, PNV_XSCOM_EX_SIZE);
     return;
=20
 err:
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index f023f1ec99..90759240a7 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -74,7 +74,6 @@ typedef struct PnvChipClass {
     uint64_t     cores_mask;
=20
     hwaddr       xscom_base;
-    hwaddr       xscom_core_base;
=20
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
 } PnvChipClass;
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 7252e219e2..fb1bd5df09 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -21,6 +21,8 @@
=20
 #include "qom/object.h"
=20
+typedef struct PnvChip PnvChip;
+
 typedef struct PnvXScomInterface {
     Object parent;
 } PnvXScomInterface;
@@ -54,8 +56,15 @@ typedef struct PnvXScomInterfaceClass {
  *   PCB SLAVE   0x110Fxxxx
  */
=20
-#define PNV_XSCOM_EX_CORE_BASE(base, i) ((base) | ((uint64_t)(i) << 24))
-#define PNV_XSCOM_EX_CORE_SIZE    0x100000
+#define PNV_XSCOM_EX_CORE_BASE    0x10000000ull
+
+#define PNV_XSCOM_EX_BASE(core) \
+    (PNV_XSCOM_EX_CORE_BASE | ((uint64_t)(core) << 24))
+#define PNV_XSCOM_EX_SIZE         0x100000
+
+#define PNV_XSCOM_P9_EC_BASE(core) \
+    ((uint64_t)(((core) & 0x1F) + 0x20) << 24)
+#define PNV_XSCOM_P9_EC_SIZE      0x100000
=20
 #define PNV_XSCOM_LPC_BASE        0xb0020
 #define PNV_XSCOM_LPC_SIZE        0x4
diff --git a/tests/pnv-xscom-test.c b/tests/pnv-xscom-test.c
index 9d545c4718..efb7c838b5 100644
--- a/tests/pnv-xscom-test.c
+++ b/tests/pnv-xscom-test.c
@@ -21,7 +21,6 @@ typedef struct PnvChip {
     PnvChipType chip_type;
     const char *cpu_model;
     uint64_t    xscom_base;
-    uint64_t    xscom_core_base;
     uint64_t    cfam_id;
     uint32_t    first_core;
 } PnvChip;
@@ -31,14 +30,12 @@ static const PnvChip pnv_chips[] =3D {
         .chip_type  =3D PNV_CHIP_POWER8,
         .cpu_model  =3D "POWER8",
         .xscom_base =3D 0x0003fc0000000000ull,
-        .xscom_core_base =3D 0x10000000ull,
         .cfam_id    =3D 0x220ea04980000000ull,
         .first_core =3D 0x1,
     }, {
         .chip_type  =3D PNV_CHIP_POWER8NVL,
         .cpu_model  =3D "POWER8NVL",
         .xscom_base =3D 0x0003fc0000000000ull,
-        .xscom_core_base =3D 0x10000000ull,
         .cfam_id    =3D 0x120d304980000000ull,
         .first_core =3D 0x1,
     },
@@ -47,7 +44,6 @@ static const PnvChip pnv_chips[] =3D {
         .chip_type  =3D PNV_CHIP_POWER9,
         .cpu_model  =3D "POWER9",
         .xscom_base =3D 0x000603fc00000000ull,
-        .xscom_core_base =3D 0x0ull,
         .cfam_id    =3D 0x220d104900008000ull,
         .first_core =3D 0x0,
     },
@@ -89,16 +85,27 @@ static void test_cfam_id(const void *data)
     qtest_quit(global_qtest);
 }
=20
-#define PNV_XSCOM_EX_CORE_BASE(chip, i)                 \
-    ((chip)->xscom_core_base | (((uint64_t)i) << 24))
+
+#define PNV_XSCOM_EX_CORE_BASE    0x10000000ull
+#define PNV_XSCOM_EX_BASE(core) \
+    (PNV_XSCOM_EX_CORE_BASE | ((uint64_t)(core) << 24))
+#define PNV_XSCOM_P9_EC_BASE(core) \
+    ((uint64_t)(((core) & 0x1F) + 0x20) << 24)
+
 #define PNV_XSCOM_EX_DTS_RESULT0     0x50000
=20
 static void test_xscom_core(const PnvChip *chip)
 {
-    uint32_t first_core_dts0 =3D
-        PNV_XSCOM_EX_CORE_BASE(chip, chip->first_core) |
-        PNV_XSCOM_EX_DTS_RESULT0;
-    uint64_t dts0 =3D pnv_xscom_read(chip, first_core_dts0);
+    uint32_t first_core_dts0 =3D PNV_XSCOM_EX_DTS_RESULT0;
+    uint64_t dts0;
+
+    if (chip->chip_type !=3D PNV_CHIP_POWER9) {
+        first_core_dts0 |=3D PNV_XSCOM_EX_BASE(chip->first_core);
+    } else {
+        first_core_dts0 |=3D PNV_XSCOM_P9_EC_BASE(chip->first_core);
+    }
+
+    dts0 =3D pnv_xscom_read(chip, first_core_dts0);
=20
     g_assert_cmphex(dts0, =3D=3D, 0x26f024f023f0000ull);
 }
--=20
2.14.3
