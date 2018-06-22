Received: from eggs.gnu.org ([2001:4830:134:3::10]:45746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPu-0000gt-TP
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWJPp-0003Pd-TH
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 06:35:46 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 20:35:08 +1000
Message-Id: <20180622103528.28598-6-david@gibson.dropbear.id.au>
In-Reply-To: <20180622103528.28598-1-david@gibson.dropbear.id.au>
References: <20180622103528.28598-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/25] ppc/pnv: introduce Pnv8Chip and Pnv9Chip
 models
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

It introduces a base PnvChip class from which the specific processor
chip classes, Pnv8Chip and Pnv9Chip, inherit. Each of them needs to
define an init and a realize routine which will create the controllers
of the target processor. For the moment, the base PnvChip class
handles the XSCOM bus and the cores.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c         | 281 +++++++++++++++++++++++++++----------------
 include/hw/ppc/pnv.h |  24 +++-
 2 files changed, 202 insertions(+), 103 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index ac828d1331..a29ea996b4 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -531,12 +531,14 @@ static void pnv_reset(void)
=20
 static ISABus *pnv_chip_power8_isa_create(PnvChip *chip, Error **errp)
 {
-    return pnv_lpc_isa_create(&chip->lpc, true, errp);
+    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
+    return pnv_lpc_isa_create(&chip8->lpc, true, errp);
 }
=20
 static ISABus *pnv_chip_power8nvl_isa_create(PnvChip *chip, Error **errp=
)
 {
-    return pnv_lpc_isa_create(&chip->lpc, false, errp);
+    Pnv8Chip *chip8 =3D PNV8_CHIP(chip);
+    return pnv_lpc_isa_create(&chip8->lpc, false, errp);
 }
=20
 static ISABus *pnv_chip_power9_isa_create(PnvChip *chip, Error **errp)
@@ -725,6 +727,103 @@ static Object *pnv_chip_power9_intc_create(PnvChip =
*chip, Object *child,
  */
 #define POWER9_CORE_MASK   (0xffffffffffffffull)
=20
+static void pnv_chip_power8_instance_init(Object *obj)
+{
+    Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
+
+    object_initialize(&chip8->psi, sizeof(chip8->psi), TYPE_PNV_PSI);
+    object_property_add_child(obj, "psi", OBJECT(&chip8->psi), NULL);
+    object_property_add_const_link(OBJECT(&chip8->psi), "xics",
+                                   OBJECT(qdev_get_machine()), &error_ab=
ort);
+
+    object_initialize(&chip8->lpc, sizeof(chip8->lpc), TYPE_PNV_LPC);
+    object_property_add_child(obj, "lpc", OBJECT(&chip8->lpc), NULL);
+    object_property_add_const_link(OBJECT(&chip8->lpc), "psi",
+                                   OBJECT(&chip8->psi), &error_abort);
+
+    object_initialize(&chip8->occ, sizeof(chip8->occ), TYPE_PNV_OCC);
+    object_property_add_child(obj, "occ", OBJECT(&chip8->occ), NULL);
+    object_property_add_const_link(OBJECT(&chip8->occ), "psi",
+                                   OBJECT(&chip8->psi), &error_abort);
+}
+
+static void pnv_chip_icp_realize(Pnv8Chip *chip8, Error **errp)
+ {
+    PnvChip *chip =3D PNV_CHIP(chip8);
+    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
+    const char *typename =3D pnv_chip_core_typename(chip);
+    size_t typesize =3D object_type_get_instance_size(typename);
+    int i, j;
+    char *name;
+    XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
+
+    name =3D g_strdup_printf("icp-%x", chip->chip_id);
+    memory_region_init(&chip8->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZ=
E);
+    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip8->icp_mmio);
+    g_free(name);
+
+    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
+
+    /* Map the ICP registers for each thread */
+    for (i =3D 0; i < chip->nr_cores; i++) {
+        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
+        int core_hwid =3D CPU_CORE(pnv_core)->core_id;
+
+        for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
+            uint32_t pir =3D pcc->core_pir(chip, core_hwid) + j;
+            PnvICPState *icp =3D PNV_ICP(xics_icp_get(xi, pir));
+
+            memory_region_add_subregion(&chip8->icp_mmio, pir << 12,
+                                        &icp->mmio);
+        }
+    }
+}
+
+static void pnv_chip_power8_realize(DeviceState *dev, Error **errp)
+{
+    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
+    PnvChip *chip =3D PNV_CHIP(dev);
+    Pnv8Chip *chip8 =3D PNV8_CHIP(dev);
+    Error *local_err =3D NULL;
+
+    pcc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* Processor Service Interface (PSI) Host Bridge */
+    object_property_set_int(OBJECT(&chip8->psi), PNV_PSIHB_BASE(chip),
+                            "bar", &error_fatal);
+    object_property_set_bool(OBJECT(&chip8->psi), true, "realized", &loc=
al_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE, &chip8->psi.xsco=
m_regs);
+
+    /* Create LPC controller */
+    object_property_set_bool(OBJECT(&chip8->lpc), true, "realized",
+                             &error_fatal);
+    pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip8->lpc.xscom_=
regs);
+
+    /* Interrupt Management Area. This is the memory region holding
+     * all the Interrupt Control Presenter (ICP) registers */
+    pnv_chip_icp_realize(chip8, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    /* Create the simplified OCC model */
+    object_property_set_bool(OBJECT(&chip8->occ), true, "realized", &loc=
al_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip8->occ.xscom_=
regs);
+}
+
 static void pnv_chip_power8e_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -738,6 +837,9 @@ static void pnv_chip_power8e_class_init(ObjectClass *=
klass, void *data)
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8E";
+
+    device_class_set_parent_realize(dc, pnv_chip_power8_realize,
+                                    &k->parent_realize);
 }
=20
 static void pnv_chip_power8_class_init(ObjectClass *klass, void *data)
@@ -753,6 +855,9 @@ static void pnv_chip_power8_class_init(ObjectClass *k=
lass, void *data)
     k->isa_create =3D pnv_chip_power8_isa_create;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8";
+
+    device_class_set_parent_realize(dc, pnv_chip_power8_realize,
+                                    &k->parent_realize);
 }
=20
 static void pnv_chip_power8nvl_class_init(ObjectClass *klass, void *data=
)
@@ -768,6 +873,25 @@ static void pnv_chip_power8nvl_class_init(ObjectClas=
s *klass, void *data)
     k->isa_create =3D pnv_chip_power8nvl_isa_create;
     k->xscom_base =3D 0x003fc0000000000ull;
     dc->desc =3D "PowerNV Chip POWER8NVL";
+
+    device_class_set_parent_realize(dc, pnv_chip_power8_realize,
+                                    &k->parent_realize);
+}
+
+static void pnv_chip_power9_instance_init(Object *obj)
+{
+}
+
+static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
+{
+    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
+    Error *local_err =3D NULL;
+
+    pcc->parent_realize(dev, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
 }
=20
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
@@ -783,6 +907,9 @@ static void pnv_chip_power9_class_init(ObjectClass *k=
lass, void *data)
     k->isa_create =3D pnv_chip_power9_isa_create;
     k->xscom_base =3D 0x00603fc00000000ull;
     dc->desc =3D "PowerNV Chip POWER9";
+
+    device_class_set_parent_realize(dc, pnv_chip_power9_realize,
+                                    &k->parent_realize);
 }
=20
 static void pnv_chip_core_sanitize(PnvChip *chip, Error **errp)
@@ -815,59 +942,9 @@ static void pnv_chip_core_sanitize(PnvChip *chip, Er=
ror **errp)
     }
 }
=20
-static void pnv_chip_init(Object *obj)
+static void pnv_chip_instance_init(Object *obj)
 {
-    PnvChip *chip =3D PNV_CHIP(obj);
-    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
-
-    chip->xscom_base =3D pcc->xscom_base;
-
-    object_initialize(&chip->lpc, sizeof(chip->lpc), TYPE_PNV_LPC);
-    object_property_add_child(obj, "lpc", OBJECT(&chip->lpc), NULL);
-
-    object_initialize(&chip->psi, sizeof(chip->psi), TYPE_PNV_PSI);
-    object_property_add_child(obj, "psi", OBJECT(&chip->psi), NULL);
-    object_property_add_const_link(OBJECT(&chip->psi), "xics",
-                                   OBJECT(qdev_get_machine()), &error_ab=
ort);
-
-    object_initialize(&chip->occ, sizeof(chip->occ), TYPE_PNV_OCC);
-    object_property_add_child(obj, "occ", OBJECT(&chip->occ), NULL);
-    object_property_add_const_link(OBJECT(&chip->occ), "psi",
-                                   OBJECT(&chip->psi), &error_abort);
-
-    /* The LPC controller needs PSI to generate interrupts */
-    object_property_add_const_link(OBJECT(&chip->lpc), "psi",
-                                   OBJECT(&chip->psi), &error_abort);
-}
-
-static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
-{
-    PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(chip);
-    const char *typename =3D pnv_chip_core_typename(chip);
-    size_t typesize =3D object_type_get_instance_size(typename);
-    int i, j;
-    char *name;
-    XICSFabric *xi =3D XICS_FABRIC(qdev_get_machine());
-
-    name =3D g_strdup_printf("icp-%x", chip->chip_id);
-    memory_region_init(&chip->icp_mmio, OBJECT(chip), name, PNV_ICP_SIZE=
);
-    sysbus_init_mmio(SYS_BUS_DEVICE(chip), &chip->icp_mmio);
-    g_free(name);
-
-    sysbus_mmio_map(SYS_BUS_DEVICE(chip), 1, PNV_ICP_BASE(chip));
-
-    /* Map the ICP registers for each thread */
-    for (i =3D 0; i < chip->nr_cores; i++) {
-        PnvCore *pnv_core =3D PNV_CORE(chip->cores + i * typesize);
-        int core_hwid =3D CPU_CORE(pnv_core)->core_id;
-
-        for (j =3D 0; j < CPU_CORE(pnv_core)->nr_threads; j++) {
-            uint32_t pir =3D pcc->core_pir(chip, core_hwid) + j;
-            PnvICPState *icp =3D PNV_ICP(xics_icp_get(xi, pir));
-
-            memory_region_add_subregion(&chip->icp_mmio, pir << 12, &icp=
->mmio);
-        }
-    }
+    PNV_CHIP(obj)->xscom_base =3D PNV_CHIP_GET_CLASS(obj)->xscom_base;
 }
=20
 static void pnv_chip_core_realize(PnvChip *chip, Error **errp)
@@ -951,37 +1028,6 @@ static void pnv_chip_realize(DeviceState *dev, Erro=
r **errp)
         error_propagate(errp, error);
         return;
     }
-
-    /* Create LPC controller */
-    object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
-                             &error_fatal);
-    pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip->lpc.xscom_r=
egs);
-
-    /* Interrupt Management Area. This is the memory region holding
-     * all the Interrupt Control Presenter (ICP) registers */
-    pnv_chip_icp_realize(chip, &error);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-
-    /* Processor Service Interface (PSI) Host Bridge */
-    object_property_set_int(OBJECT(&chip->psi), PNV_PSIHB_BASE(chip),
-                            "bar", &error_fatal);
-    object_property_set_bool(OBJECT(&chip->psi), true, "realized", &erro=
r);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-    pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE, &chip->psi.xscom=
_regs);
-
-    /* Create the simplified OCC model */
-    object_property_set_bool(OBJECT(&chip->occ), true, "realized", &erro=
r);
-    if (error) {
-        error_propagate(errp, error);
-        return;
-    }
-    pnv_xscom_add_subregion(chip, PNV_XSCOM_OCC_BASE, &chip->occ.xscom_r=
egs);
 }
=20
 static Property pnv_chip_properties[] =3D {
@@ -1009,8 +1055,10 @@ static ICSState *pnv_ics_get(XICSFabric *xi, int i=
rq)
     int i;
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
-        if (ics_valid_irq(&pnv->chips[i]->psi.ics, irq)) {
-            return &pnv->chips[i]->psi.ics;
+        Pnv8Chip *chip8 =3D PNV8_CHIP(pnv->chips[i]);
+
+        if (ics_valid_irq(&chip8->psi.ics, irq)) {
+            return &chip8->psi.ics;
         }
     }
     return NULL;
@@ -1022,7 +1070,8 @@ static void pnv_ics_resend(XICSFabric *xi)
     int i;
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
-        ics_resend(&pnv->chips[i]->psi.ics);
+        Pnv8Chip *chip8 =3D PNV8_CHIP(pnv->chips[i]);
+        ics_resend(&chip8->psi.ics);
     }
 }
=20
@@ -1063,7 +1112,8 @@ static void pnv_pic_print_info(InterruptStatsProvid=
er *obj,
     }
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
-        ics_pic_print_info(&pnv->chips[i]->psi.ics, mon);
+        Pnv8Chip *chip8 =3D PNV8_CHIP(pnv->chips[i]);
+        ics_pic_print_info(&chip8->psi.ics, mon);
     }
 }
=20
@@ -1098,7 +1148,7 @@ static void pnv_set_num_chips(Object *obj, Visitor =
*v, const char *name,
     pnv->num_chips =3D num_chips;
 }
=20
-static void pnv_machine_initfn(Object *obj)
+static void pnv_machine_instance_init(Object *obj)
 {
     PnvMachineState *pnv =3D PNV_MACHINE(obj);
     pnv->num_chips =3D 1;
@@ -1138,11 +1188,18 @@ static void pnv_machine_class_init(ObjectClass *o=
c, void *data)
     pnv_machine_class_props_init(oc);
 }
=20
-#define DEFINE_PNV_CHIP_TYPE(type, class_initfn) \
-    {                                            \
-        .name          =3D type,                   \
-        .class_init    =3D class_initfn,           \
-        .parent        =3D TYPE_PNV_CHIP,          \
+#define DEFINE_PNV8_CHIP_TYPE(type, class_initfn) \
+    {                                             \
+        .name          =3D type,                    \
+        .class_init    =3D class_initfn,            \
+        .parent        =3D TYPE_PNV8_CHIP,          \
+    }
+
+#define DEFINE_PNV9_CHIP_TYPE(type, class_initfn) \
+    {                                             \
+        .name          =3D type,                    \
+        .class_init    =3D class_initfn,            \
+        .parent        =3D TYPE_PNV9_CHIP,          \
     }
=20
 static const TypeInfo types[] =3D {
@@ -1150,7 +1207,7 @@ static const TypeInfo types[] =3D {
         .name          =3D TYPE_PNV_MACHINE,
         .parent        =3D TYPE_MACHINE,
         .instance_size =3D sizeof(PnvMachineState),
-        .instance_init =3D pnv_machine_initfn,
+        .instance_init =3D pnv_machine_instance_init,
         .class_init    =3D pnv_machine_class_init,
         .interfaces =3D (InterfaceInfo[]) {
             { TYPE_XICS_FABRIC },
@@ -1162,16 +1219,36 @@ static const TypeInfo types[] =3D {
         .name          =3D TYPE_PNV_CHIP,
         .parent        =3D TYPE_SYS_BUS_DEVICE,
         .class_init    =3D pnv_chip_class_init,
-        .instance_init =3D pnv_chip_init,
+        .instance_init =3D pnv_chip_instance_init,
         .instance_size =3D sizeof(PnvChip),
         .class_size    =3D sizeof(PnvChipClass),
         .abstract      =3D true,
     },
-    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER9, pnv_chip_power9_class_ini=
t),
-    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_ini=
t),
-    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class_i=
nit),
-    DEFINE_PNV_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
-                         pnv_chip_power8nvl_class_init),
+
+    /*
+     * P9 chip and variants
+     */
+    {
+        .name          =3D TYPE_PNV9_CHIP,
+        .parent        =3D TYPE_PNV_CHIP,
+        .instance_init =3D pnv_chip_power9_instance_init,
+        .instance_size =3D sizeof(Pnv9Chip),
+    },
+    DEFINE_PNV9_CHIP_TYPE(TYPE_PNV_CHIP_POWER9, pnv_chip_power9_class_in=
it),
+
+    /*
+     * P8 chip and variants
+     */
+    {
+        .name          =3D TYPE_PNV8_CHIP,
+        .parent        =3D TYPE_PNV_CHIP,
+        .instance_init =3D pnv_chip_power8_instance_init,
+        .instance_size =3D sizeof(Pnv8Chip),
+    },
+    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8, pnv_chip_power8_class_in=
it),
+    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8E, pnv_chip_power8e_class_=
init),
+    DEFINE_PNV8_CHIP_TYPE(TYPE_PNV_CHIP_POWER8NVL,
+                          pnv_chip_power8nvl_class_init),
 };
=20
 DEFINE_TYPES(types)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 563279f3e0..86d5f54e54 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -57,12 +57,32 @@ typedef struct PnvChip {
     MemoryRegion xscom_mmio;
     MemoryRegion xscom;
     AddressSpace xscom_as;
+} PnvChip;
+
+#define TYPE_PNV8_CHIP "pnv8-chip"
+#define PNV8_CHIP(obj) OBJECT_CHECK(Pnv8Chip, (obj), TYPE_PNV8_CHIP)
+
+typedef struct Pnv8Chip {
+    /*< private >*/
+    PnvChip      parent_obj;
+
+    /*< public >*/
     MemoryRegion icp_mmio;
=20
     PnvLpcController lpc;
     PnvPsi       psi;
     PnvOCC       occ;
-} PnvChip;
+} Pnv8Chip;
+
+#define TYPE_PNV9_CHIP "pnv9-chip"
+#define PNV9_CHIP(obj) OBJECT_CHECK(Pnv9Chip, (obj), TYPE_PNV9_CHIP)
+
+typedef struct Pnv9Chip {
+    /*< private >*/
+    PnvChip      parent_obj;
+
+    /*< public >*/
+} Pnv9Chip;
=20
 typedef struct PnvChipClass {
     /*< private >*/
@@ -75,6 +95,8 @@ typedef struct PnvChipClass {
=20
     hwaddr       xscom_base;
=20
+    DeviceRealize parent_realize;
+
     uint32_t (*core_pir)(PnvChip *chip, uint32_t core_id);
     Object *(*intc_create)(PnvChip *chip, Object *child, Error **errp);
     ISABus *(*isa_create)(PnvChip *chip, Error **errp);
--=20
2.17.1
