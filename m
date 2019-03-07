Received: from eggs.gnu.org ([209.51.188.92]:33971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21cu-000774-OZ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1h21co-0002ey-Vp
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:28 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:37794
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1h21cn-0001yD-GY
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 17:36:25 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x27MIcAA120450
	for <qemu-devel@nongnu.org>; Thu, 7 Mar 2019 17:36:00 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r3a3ae09s-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 17:36:00 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <clg@kaod.org>;
	Thu, 7 Mar 2019 22:35:58 -0000
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu,  7 Mar 2019 23:35:34 +0100
In-Reply-To: <20190307223548.20516-1-clg@kaod.org>
References: <20190307223548.20516-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <20190307223548.20516-2-clg@kaod.org>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 01/15] ppc/pnv: add a PSI bridge class model
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

To ease the introduction of the PSI bridge model for POWER9, abstract
the POWER chip differences in a PnvPsi class model and introduce a
specific Pnv8Psi type for POWER8. POWER8 interface to the interrupt
controller is still XICS whereas POWER9 uses the new XIVE model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---

 Changes in v2 :

 - introduced a Pnv8Psi (XICS) model

 include/hw/ppc/pnv.h     |  2 +-
 include/hw/ppc/pnv_psi.h | 29 ++++++++++++++-
 hw/ppc/pnv.c             |  6 ++-
 hw/ppc/pnv_psi.c         | 79 ++++++++++++++++++++++++++++------------
 4 files changed, 87 insertions(+), 29 deletions(-)

diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index eb4bba25b3e9..3b5f9cd53184 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -71,7 +71,7 @@ typedef struct Pnv8Chip {
     MemoryRegion icp_mmio;
=20
     PnvLpcController lpc;
-    PnvPsi       psi;
+    Pnv8Psi      psi;
     PnvOCC       occ;
 } Pnv8Chip;
=20
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index 64ac73512e81..7087cbcb9ad7 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -39,7 +39,6 @@ typedef struct PnvPsi {
     uint64_t fsp_bar;
=20
     /* Interrupt generation */
-    ICSState ics;
     qemu_irq *qirqs;
=20
     /* Registers */
@@ -48,6 +47,32 @@ typedef struct PnvPsi {
     MemoryRegion xscom_regs;
 } PnvPsi;
=20
+#define TYPE_PNV8_PSI TYPE_PNV_PSI "-POWER8"
+#define PNV8_PSI(obj) \
+    OBJECT_CHECK(Pnv8Psi, (obj), TYPE_PNV8_PSI)
+
+typedef struct Pnv8Psi {
+    PnvPsi   parent;
+
+    ICSState ics;
+} Pnv8Psi;
+
+#define PNV_PSI_CLASS(klass) \
+     OBJECT_CLASS_CHECK(PnvPsiClass, (klass), TYPE_PNV_PSI)
+#define PNV_PSI_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(PnvPsiClass, (obj), TYPE_PNV_PSI)
+
+typedef struct PnvPsiClass {
+    SysBusDeviceClass parent_class;
+
+    int chip_type;
+    uint32_t xscom_pcba;
+    uint32_t xscom_size;
+    uint64_t bar_mask;
+
+    void (*irq_set)(PnvPsi *psi, int, bool state);
+} PnvPsiClass;
+
 /* The PSI and FSP interrupts are muxed on the same IRQ number */
 typedef enum PnvPsiIrq {
     PSIHB_IRQ_PSI, /* internal use only */
@@ -61,6 +86,6 @@ typedef enum PnvPsiIrq {
=20
 #define PSI_NUM_INTERRUPTS 6
=20
-extern void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool state);
+void pnv_psi_irq_set(PnvPsi *psi, int irq, bool state);
=20
 #endif /* _PPC_PNV_PSI_H */
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 7660eaa22cf9..5bb2332f167a 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -788,7 +788,7 @@ static void pnv_chip_power8_instance_init(Object *obj=
)
     Pnv8Chip *chip8 =3D PNV8_CHIP(obj);
=20
     object_initialize_child(obj, "psi",  &chip8->psi, sizeof(chip8->psi)=
,
-                            TYPE_PNV_PSI, &error_abort, NULL);
+                            TYPE_PNV8_PSI, &error_abort, NULL);
     object_property_add_const_link(OBJECT(&chip8->psi), "xics",
                                    OBJECT(qdev_get_machine()), &error_ab=
ort);
=20
@@ -840,6 +840,7 @@ static void pnv_chip_power8_realize(DeviceState *dev,=
 Error **errp)
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
     PnvChip *chip =3D PNV_CHIP(dev);
     Pnv8Chip *chip8 =3D PNV8_CHIP(dev);
+    Pnv8Psi *psi8 =3D &chip8->psi;
     Error *local_err =3D NULL;
=20
     pcc->parent_realize(dev, &local_err);
@@ -856,7 +857,8 @@ static void pnv_chip_power8_realize(DeviceState *dev,=
 Error **errp)
         error_propagate(errp, local_err);
         return;
     }
-    pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE, &chip8->psi.xsco=
m_regs);
+    pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE,
+                            &PNV_PSI(psi8)->xscom_regs);
=20
     /* Create LPC controller */
     object_property_set_bool(OBJECT(&chip8->lpc), true, "realized",
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index e61861bfd3c6..067f733f1e4a 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -118,10 +118,11 @@
=20
 static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
 {
+    PnvPsiClass *ppc =3D PNV_PSI_GET_CLASS(psi);
     MemoryRegion *sysmem =3D get_system_memory();
     uint64_t old =3D psi->regs[PSIHB_XSCOM_BAR];
=20
-    psi->regs[PSIHB_XSCOM_BAR] =3D bar & (PSIHB_BAR_MASK | PSIHB_BAR_EN)=
;
+    psi->regs[PSIHB_XSCOM_BAR] =3D bar & (ppc->bar_mask | PSIHB_BAR_EN);
=20
     /* Update MR, always remove it first */
     if (old & PSIHB_BAR_EN) {
@@ -130,7 +131,7 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar=
)
=20
     /* Then add it back if needed */
     if (bar & PSIHB_BAR_EN) {
-        uint64_t addr =3D bar & PSIHB_BAR_MASK;
+        uint64_t addr =3D bar & ppc->bar_mask;
         memory_region_add_subregion(sysmem, addr, &psi->regs_mr);
     }
 }
@@ -154,7 +155,7 @@ static void pnv_psi_set_cr(PnvPsi *psi, uint64_t cr)
=20
 static void pnv_psi_set_irsn(PnvPsi *psi, uint64_t val)
 {
-    ICSState *ics =3D &psi->ics;
+    ICSState *ics =3D &PNV8_PSI(psi)->ics;
=20
     /* In this model we ignore the up/down enable bits for now
      * as SW doesn't use them (other than setting them at boot).
@@ -207,7 +208,12 @@ static const uint64_t stat_bits[] =3D {
     [PSIHB_IRQ_EXTERNAL]  =3D PSIHB_IRQ_STAT_EXT,
 };
=20
-void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool state)
+void pnv_psi_irq_set(PnvPsi *psi, int irq, bool state)
+{
+    PNV_PSI_GET_CLASS(psi)->irq_set(psi, irq, state);
+}
+
+static void pnv_psi_power8_irq_set(PnvPsi *psi, int irq, bool state)
 {
     uint32_t xivr_reg;
     uint32_t stat_reg;
@@ -262,7 +268,7 @@ void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool=
 state)
=20
 static void pnv_psi_set_xivr(PnvPsi *psi, uint32_t reg, uint64_t val)
 {
-    ICSState *ics =3D &psi->ics;
+    ICSState *ics =3D &PNV8_PSI(psi)->ics;
     uint16_t server;
     uint8_t prio;
     uint8_t src;
@@ -451,11 +457,11 @@ static void pnv_psi_reset(void *dev)
     psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
 }
=20
-static void pnv_psi_init(Object *obj)
+static void pnv_psi_power8_instance_init(Object *obj)
 {
-    PnvPsi *psi =3D PNV_PSI(obj);
+    Pnv8Psi *psi8 =3D PNV8_PSI(obj);
=20
-    object_initialize_child(obj, "ics-psi",  &psi->ics, sizeof(psi->ics)=
,
+    object_initialize_child(obj, "ics-psi",  &psi8->ics, sizeof(psi8->ic=
s),
                             TYPE_ICS_SIMPLE, &error_abort, NULL);
 }
=20
@@ -468,10 +474,10 @@ static const uint8_t irq_to_xivr[] =3D {
     PSIHB_XSCOM_XIVR_EXT,
 };
=20
-static void pnv_psi_realize(DeviceState *dev, Error **errp)
+static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
 {
     PnvPsi *psi =3D PNV_PSI(dev);
-    ICSState *ics =3D &psi->ics;
+    ICSState *ics =3D &PNV8_PSI(psi)->ics;
     Object *obj;
     Error *err =3D NULL;
     unsigned int i;
@@ -524,28 +530,28 @@ static void pnv_psi_realize(DeviceState *dev, Error=
 **errp)
     qemu_register_reset(pnv_psi_reset, dev);
 }
=20
+static const char compat_p8[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
+
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
 {
-    const char compat[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
+    PnvPsiClass *ppc =3D PNV_PSI_GET_CLASS(dev);
     char *name;
     int offset;
-    uint32_t lpc_pcba =3D PNV_XSCOM_PSIHB_BASE;
     uint32_t reg[] =3D {
-        cpu_to_be32(lpc_pcba),
-        cpu_to_be32(PNV_XSCOM_PSIHB_SIZE)
+        cpu_to_be32(ppc->xscom_pcba),
+        cpu_to_be32(ppc->xscom_size)
     };
=20
-    name =3D g_strdup_printf("psihb@%x", lpc_pcba);
+    name =3D g_strdup_printf("psihb@%x", ppc->xscom_pcba);
     offset =3D fdt_add_subnode(fdt, xscom_offset, name);
     _FDT(offset);
     g_free(name);
=20
-    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
-
-    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
-    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
-    _FDT((fdt_setprop(fdt, offset, "compatible", compat,
-                      sizeof(compat))));
+    _FDT(fdt_setprop(fdt, offset, "reg", reg, sizeof(reg)));
+    _FDT(fdt_setprop_cell(fdt, offset, "#address-cells", 2));
+    _FDT(fdt_setprop_cell(fdt, offset, "#size-cells", 1));
+    _FDT(fdt_setprop(fdt, offset, "compatible", compat_p8,
+                     sizeof(compat_p8)));
     return 0;
 }
=20
@@ -555,6 +561,29 @@ static Property pnv_psi_properties[] =3D {
     DEFINE_PROP_END_OF_LIST(),
 };
=20
+static void pnv_psi_power8_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
+
+    dc->desc    =3D "PowerNV PSI Controller POWER8";
+    dc->realize =3D pnv_psi_power8_realize;
+
+    ppc->chip_type =3D  PNV_CHIP_POWER8;
+    ppc->xscom_pcba =3D PNV_XSCOM_PSIHB_BASE;
+    ppc->xscom_size =3D PNV_XSCOM_PSIHB_SIZE;
+    ppc->bar_mask   =3D PSIHB_BAR_MASK;
+    ppc->irq_set    =3D pnv_psi_power8_irq_set;
+}
+
+static const TypeInfo pnv_psi_power8_info =3D {
+    .name          =3D TYPE_PNV8_PSI,
+    .parent        =3D TYPE_PNV_PSI,
+    .instance_size =3D sizeof(Pnv8Psi),
+    .instance_init =3D pnv_psi_power8_instance_init,
+    .class_init    =3D pnv_psi_power8_class_init,
+};
+
 static void pnv_psi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -562,7 +591,7 @@ static void pnv_psi_class_init(ObjectClass *klass, vo=
id *data)
=20
     xdc->dt_xscom =3D pnv_psi_dt_xscom;
=20
-    dc->realize =3D pnv_psi_realize;
+    dc->desc =3D "PowerNV PSI Controller";
     dc->props =3D pnv_psi_properties;
 }
=20
@@ -570,8 +599,9 @@ static const TypeInfo pnv_psi_info =3D {
     .name          =3D TYPE_PNV_PSI,
     .parent        =3D TYPE_SYS_BUS_DEVICE,
     .instance_size =3D sizeof(PnvPsi),
-    .instance_init =3D pnv_psi_init,
     .class_init    =3D pnv_psi_class_init,
+    .class_size    =3D sizeof(PnvPsiClass),
+    .abstract      =3D true,
     .interfaces    =3D (InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
@@ -581,6 +611,7 @@ static const TypeInfo pnv_psi_info =3D {
 static void pnv_psi_register_types(void)
 {
     type_register_static(&pnv_psi_info);
+    type_register_static(&pnv_psi_power8_info);
 }
=20
-type_init(pnv_psi_register_types)
+type_init(pnv_psi_register_types);
--=20
2.20.1
