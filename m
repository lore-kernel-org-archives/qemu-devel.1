Received: from eggs.gnu.org ([2001:4830:134:3::10]:50824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOe-0008Tz-62
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e4JOb-0007C2-82
	for qemu-devel@nongnu.org; Tue, 17 Oct 2017 00:22:28 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 17 Oct 2017 15:21:48 +1100
Message-Id: <20171017042152.29443-31-david@gibson.dropbear.id.au>
In-Reply-To: <20171017042152.29443-1-david@gibson.dropbear.id.au>
References: <20171017042152.29443-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 30/34] ppc: pnv: drop PnvChipClass::cpu_model
 field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: ehabkost@redhat.com, agraf@suse.de, imammedo@redhat.com, groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: Igor Mammedov <imammedo@redhat.com>

deduce core type directly from chip type instead of
maintaining type mapping in PnvChipClass::cpu_model.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c              | 25 +++++++++++++------------
 hw/ppc/pnv_core.c         |  5 -----
 include/hw/ppc/pnv.h      |  1 -
 include/hw/ppc/pnv_core.h |  1 -
 4 files changed, 13 insertions(+), 19 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1e78b685a3..80c7f62bbc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -55,6 +55,16 @@
 #define KERNEL_LOAD_ADDR        0x20000000
 #define INITRD_LOAD_ADDR        0x40000000
=20
+static const char *pnv_chip_core_typename(const PnvChip *o)
+{
+    const char *chip_type =3D object_class_get_name(object_get_class(OBJ=
ECT(o)));
+    int len =3D strlen(chip_type) - strlen(PNV_CHIP_TYPE_SUFFIX);
+    char *s =3D g_strdup_printf(PNV_CORE_TYPE_NAME("%.*s"), len, chip_ty=
pe);
+    const char *core_type =3D object_class_get_name(object_class_by_name=
(s));
+    g_free(s);
+    return core_type;
+}
+
 /*
  * On Power Systems E880 (POWER8), the max cpus (threads) should be :
  *     4 * 4 sockets * 12 cores * 8 threads =3D 1536
@@ -269,8 +279,7 @@ static int pnv_chip_lpc_offset(PnvChip *chip, void *f=
dt)
=20
 static void powernv_populate_chip(PnvChip *chip, void *fdt)
 {
-    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
-    char *typename =3D pnv_core_typename(pcc->cpu_model);
+    const char *typename =3D pnv_chip_core_typename(chip);
     size_t typesize =3D object_type_get_instance_size(typename);
     int i;
=20
@@ -300,7 +309,6 @@ static void powernv_populate_chip(PnvChip *chip, void=
 *fdt)
         powernv_populate_memory_node(fdt, chip->chip_id, chip->ram_start=
,
                                      chip->ram_size);
     }
-    g_free(typename);
 }
=20
 static void powernv_populate_rtc(ISADevice *d, void *fdt, int lpc_off)
@@ -712,7 +720,6 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
=20
-    k->cpu_model =3D "power8e_v2.1";
     k->chip_type =3D PNV_CHIP_POWER8E;
     k->chip_cfam_id =3D 0x221ef04980000000ull;  /* P8 Murano DD2.1 */
     k->cores_mask =3D POWER8E_CORE_MASK;
@@ -734,7 +741,6 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
=20
-    k->cpu_model =3D "power8_v2.0";
     k->chip_type =3D PNV_CHIP_POWER8;
     k->chip_cfam_id =3D 0x220ea04980000000ull; /* P8 Venice DD2.0 */
     k->cores_mask =3D POWER8_CORE_MASK;
@@ -756,7 +762,6 @@ static void pnv_chip_power8nvl_class_init(ObjectClass=
 *klass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
=20
-    k->cpu_model =3D "power8nvl_v1.0";
     k->chip_type =3D PNV_CHIP_POWER8NVL;
     k->chip_cfam_id =3D 0x120d304980000000ull;  /* P8 Naples DD1.0 */
     k->cores_mask =3D POWER8_CORE_MASK;
@@ -778,7 +783,6 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
     DeviceClass *dc =3D DEVICE_CLASS(klass);
     PnvChipClass *k =3D PNV_CHIP_CLASS(klass);
=20
-    k->cpu_model =3D "power9_v2.0";
     k->chip_type =3D PNV_CHIP_POWER9;
     k->chip_cfam_id =3D 0x100d104980000000ull; /* P9 Nimbus DD1.0 */
     k->cores_mask =3D POWER9_CORE_MASK;
@@ -853,7 +857,7 @@ static void pnv_chip_init(Object *obj)
 static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
 {
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
-    char *typename =3D pnv_core_typename(pcc->cpu_model);
+    const char *typename =3D pnv_chip_core_typename(chip);
     size_t typesize =3D object_type_get_instance_size(typename);
     int i, j;
     char *name;
@@ -878,8 +882,6 @@ static void pnv_chip_icp_realize(PnvChip *chip, Error=
 **errp)
             memory_region_add_subregion(&chip->icp_mmio, pir << 12, &icp=
->mmio);
         }
     }
-
-    g_free(typename);
 }
=20
 static void pnv_chip_realize(DeviceState *dev, Error **errp)
@@ -887,7 +889,7 @@ static void pnv_chip_realize(DeviceState *dev, Error =
**errp)
     PnvChip *chip =3D PNV_CHIP(dev);
     Error *error =3D NULL;
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
-    char *typename =3D pnv_core_typename(pcc->cpu_model);
+    const char *typename =3D pnv_chip_core_typename(chip);
     size_t typesize =3D object_type_get_instance_size(typename);
     int i, core_hwid;
=20
@@ -946,7 +948,6 @@ static void pnv_chip_realize(DeviceState *dev, Error =
**errp)
                                 &PNV_CORE(pnv_core)->xscom_regs);
         i++;
     }
-    g_free(typename);
=20
     /* Create LPC controller */
     object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index 350394fdb5..82ff440b33 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -246,9 +246,4 @@ static const TypeInfo pnv_core_infos[] =3D {
     DEFINE_PNV_CORE_TYPE("power9_v2.0"),
 };
=20
-char *pnv_core_typename(const char *model)
-{
-    return g_strdup_printf(PNV_CORE_TYPE_NAME("%s"), model);
-}
-
 DEFINE_TYPES(pnv_core_infos)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index f1bfa6c499..59524cd42b 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -69,7 +69,6 @@ typedef struct PnvChipClass {
     SysBusDeviceClass parent_class;
=20
     /*< public >*/
-    const char *cpu_model;
     PnvChipType  chip_type;
     uint64_t     chip_cfam_id;
     uint64_t     cores_mask;
diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
index a336a1f18a..e337af7a3a 100644
--- a/include/hw/ppc/pnv_core.h
+++ b/include/hw/ppc/pnv_core.h
@@ -46,6 +46,5 @@ typedef struct PnvCoreClass {
=20
 #define PNV_CORE_TYPE_SUFFIX "-" TYPE_PNV_CORE
 #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
-extern char *pnv_core_typename(const char *model);
=20
 #endif /* _PPC_PNV_CORE_H */
--=20
2.13.6
