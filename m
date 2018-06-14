Received: from eggs.gnu.org ([2001:4830:134:3::10]:54563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSoW-0007wz-SQ
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fTSoR-0000CY-0B
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:24 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:50519)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fTSoQ-0000BZ-Mt
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 10:01:18 -0400
Received: from player738.ha.ovh.net (unknown [10.109.120.28])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 18C36C5524
	for <qemu-devel@nongnu.org>; Thu, 14 Jun 2018 16:01:16 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 14 Jun 2018 16:00:42 +0200
Message-Id: <20180614140043.9231-6-clg@kaod.org>
In-Reply-To: <20180614140043.9231-1-clg@kaod.org>
References: <20180614140043.9231-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 5/6] ppc/pnv: introduce a new intc_create()
 operation to the chip model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

On Power9, the thread interrupt presenter has a different type and is
linked to the chip owning the cores.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 include/hw/ppc/pnv.h |  1 +
 hw/ppc/pnv.c         | 21 +++++++++++++++++++--
 hw/ppc/pnv_core.c    | 18 +++++++++---------
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 90759240a7b1..e934e84f555e 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -76,6 +76,7 @@ typedef struct PnvChipClass {
     hwaddr       xscom_base;
=20
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
+    Object *(*intc_create)(PnvChip *chip, Object *child, Error **errp);
 } PnvChipClass;
=20
 #define PNV_CHIP_TYPE_SUFFIX "-" TYPE_PNV_CHIP
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index b3b0dd44582f..7d99366daf90 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -641,6 +641,13 @@ static uint32_t pnv_chip_core_pir_p8(PnvChip *chip, =
uint32_t core_id)
     return (chip->chip_id << 7) | (core_id << 3);
 }
=20
+static Object *pnv_chip_power8_intc_create(PnvChip *chip, Object *child,
+                                           Error **errp)
+{
+    return icp_create(child, TYPE_PNV_ICP, XICS_FABRIC(qdev_get_machine(=
)),
+                      errp);
+}
+
 /*
  *    0:48  Reserved - Read as zeroes
  *   49:52  Node ID
@@ -656,6 +663,12 @@ static uint32_t pnv_chip_core_pir_p9(PnvChip *chip, =
uint32_t core_id)
     return (chip->chip_id << 8) | (core_id << 2);
 }
=20
+static Object *pnv_chip_power9_intc_create(PnvChip *chip, Object *child,
+                                           Error **errp)
+{
+    return NULL;
+}
+
 /* Allowed core identifiers on a POWER8 Processor Chip :
  *
  * <EX0 reserved>
@@ -691,6 +704,7 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
     k->chip_cfam_id =3D 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
     k->cores_mask =3D POWER8E_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
+    k->intc_create =3D pnv_chip_power8_intc_create;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8E";
 }
@@ -704,6 +718,7 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
     k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
     k->cores_mask =3D POWER8_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
+    k->intc_create =3D pnv_chip_power8_intc_create;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8";
 }
@@ -717,6 +732,7 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
     k->chip_cfam_id =3D 0x120d304980000000ull;  /* P8 Naples DD1.0 */
     k->cores_mask =3D POWER8_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p8;
+    k->intc_create =3D pnv_chip_power8_intc_create;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8NVL";
 }
@@ -730,6 +746,7 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
     k->chip_cfam_id =3D 0x220d104900008000ull; /* P9 Nimbus DD2.0 */
     k->cores_mask =3D POWER9_CORE_MASK;
     k->core_pir =3D pnv_chip_core_pir_p9;
+    k->intc_create =3D pnv_chip_power9_intc_create;
     k->xscom_base =3D 0x00603fc00000000ull;
     dc->desc =3D "PowerNV Chip POWER9";
 }
@@ -865,8 +882,8 @@ static void pnv_chip_core_realize(PnvChip *chip, Erro=
r **errp)
         object_property_set_int(OBJECT(pnv_core),
                                 pcc->core_pir(chip, core_hwid),
                                 "pir", &error_fatal);
-        object_property_add_const_link(OBJECT(pnv_core), "xics",
-                                       qdev_get_machine(), &error_fatal)=
;
+        object_property_add_const_link(OBJECT(pnv_core), "chip",
+                                       OBJECT(chip), &error_fatal);
         object_property_set_bool(OBJECT(pnv_core), true, "realized",
                                  &error_fatal);
         object_unref(OBJECT(pnv_core));
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 13ad7d9e0470..5805bcd10abf 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -121,11 +121,12 @@ static const MemoryRegionOps pnv_core_xscom_ops =3D=
 {
     .endianness =3D DEVICE_BIG_ENDIAN,
 };
=20
-static void pnv_core_realize_child(Object *child, XICSFabric *xi, Error =
**errp)
+static void pnv_core_realize_child(Object *child, PnvChip *chip, Error *=
*errp)
 {
     Error *local_err =3D NULL;
     CPUState *cs =3D CPU(child);
     PowerPCCPU *cpu =3D POWERPC_CPU(cs);
+    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
=20
     object_property_set_bool(child, true, "realized", &local_err);
     if (local_err) {
@@ -133,7 +134,7 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
         return;
     }
=20
-    cpu->intc =3D icp_create(child, TYPE_PNV_ICP, xi, &local_err);
+    cpu->intc =3D pcc->intc_create(chip, child, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
@@ -156,13 +157,12 @@ static void pnv_core_realize(DeviceState *dev, Erro=
r **errp)
     void *obj;
     int i, j;
     char name[32];
-    Object *xi;
+    Object *chip;
=20
-    xi =3D object_property_get_link(OBJECT(dev), "xics", &local_err);
-    if (!xi) {
-        error_setg(errp, "%s: required link 'xics' not found: %s",
-                   __func__, error_get_pretty(local_err));
-        return;
+    chip =3D object_property_get_link(OBJECT(dev), "chip", &local_err);
+    if (!chip) {
+        error_propagate(errp, local_err);
+        error_prepend(errp, "required link 'chip' not found: ");
     }
=20
     pc->threads =3D g_malloc0(size * cc->nr_threads);
@@ -184,7 +184,7 @@ static void pnv_core_realize(DeviceState *dev, Error =
**errp)
     for (j =3D 0; j < cc->nr_threads; j++) {
         obj =3D pc->threads + j * size;
=20
-        pnv_core_realize_child(obj, XICS_FABRIC(xi), &local_err);
+        pnv_core_realize_child(obj, PNV_CHIP(chip), &local_err);
         if (local_err) {
             goto err;
         }
--=20
2.13.6
