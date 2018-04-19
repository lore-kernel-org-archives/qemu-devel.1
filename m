Received: from eggs.gnu.org ([2001:4830:134:3::10]:58925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98y1-00025K-F1
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:47:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f98xx-0001h5-Gp
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:47:13 -0400
Received: from 6.mo5.mail-out.ovh.net ([178.32.119.138]:40140)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f98xx-0001fq-3w
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 08:47:09 -0400
Received: from player792.ha.ovh.net (unknown [10.109.105.64])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id B48041A3CE6
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 14:47:07 +0200 (CEST)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Thu, 19 Apr 2018 14:43:31 +0200
Message-Id: <20180419124331.3915-36-clg@kaod.org>
In-Reply-To: <20180419124331.3915-1-clg@kaod.org>
References: <20180419124331.3915-1-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 35/35] ppc/pnv: add a PSI bridge model for
 POWER9 processor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The PSI bridge on POWER9 is very similar to POWER8. The BAR is still
set through XSCOM but the controls are now entirely done with MMIOs.
More interrupts are defined and the interrupt controller interface has
changed to XIVE. The POWER9 model is a first example of the usage of
the notify() handler of the XiveFabric interface, linking the PSI
XiveSource to its owning device model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
---
 hw/ppc/pnv.c               |  41 ++---
 hw/ppc/pnv_psi.c           | 399 +++++++++++++++++++++++++++++++++++++++=
+++---
 include/hw/ppc/pnv.h       |  14 +-
 include/hw/ppc/pnv_psi.h   |  50 +++++-
 include/hw/ppc/pnv_xscom.h |   2 +
 5 files changed, 458 insertions(+), 48 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 4dd84b83e04c..3ad6c4cd906d 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -806,19 +806,8 @@ static void pnv_chip_init(Object *obj)
     object_initialize(&chip->lpc, sizeof(chip->lpc), TYPE_PNV_LPC);
     object_property_add_child(obj, "lpc", OBJECT(&chip->lpc), NULL);
=20
-    object_initialize(&chip->psi, sizeof(chip->psi), TYPE_PNV_PSI);
-    object_property_add_child(obj, "psi", OBJECT(&chip->psi), NULL);
-    object_property_add_const_link(OBJECT(&chip->psi), "xics",
-                                   OBJECT(qdev_get_machine()), &error_ab=
ort);
-
     object_initialize(&chip->occ, sizeof(chip->occ), TYPE_PNV_OCC);
     object_property_add_child(obj, "occ", OBJECT(&chip->occ), NULL);
-    object_property_add_const_link(OBJECT(&chip->occ), "psi",
-                                   OBJECT(&chip->psi), &error_abort);
-
-    /* The LPC controller needs PSI to generate interrupts */
-    object_property_add_const_link(OBJECT(&chip->lpc), "psi",
-                                   OBJECT(&chip->psi), &error_abort);
 }
=20
 static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
@@ -921,7 +910,16 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
         i++;
     }
=20
+    /* Processor Service Interface (PSI) Host Bridge */
+    pnv_chip_psi_realize(chip, &error);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+
     /* Create LPC controller */
+    object_property_add_const_link(OBJECT(&chip->lpc), "psi",
+                                   OBJECT(chip->psi), &error_abort);
     object_property_set_bool(OBJECT(&chip->lpc), true, "realized",
                              &error_fatal);
     pnv_xscom_add_subregion(chip, PNV_XSCOM_LPC_BASE, &chip->lpc.xscom_r=
egs);
@@ -939,17 +937,9 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
         return;
     }
=20
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
     /* Create the simplified OCC model */
+    object_property_add_const_link(OBJECT(&chip->occ), "psi",
+                                   OBJECT(chip->psi), &error_abort);
     object_property_set_bool(OBJECT(&chip->occ), true, "realized", &erro=
r);
     if (error) {
         error_propagate(errp, error);
@@ -983,8 +973,8 @@ static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
     int i;
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
-        if (ics_valid_irq(&pnv->chips[i]->psi.ics, irq)) {
-            return &pnv->chips[i]->psi.ics;
+        if (ics_valid_irq(&pnv->chips[i]->psi->ics, irq)) {
+            return &pnv->chips[i]->psi->ics;
         }
     }
     return NULL;
@@ -996,7 +986,7 @@ static void pnv_ics_resend(XICSFabric *xi)
     int i;
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
-        ics_resend(&pnv->chips[i]->psi.ics);
+        ics_resend(&pnv->chips[i]->psi->ics);
     }
 }
=20
@@ -1040,9 +1030,10 @@ static void pnv_pic_print_info(InterruptStatsProvi=
der *obj,
=20
     for (i =3D 0; i < pnv->num_chips; i++) {
         if (!pnv_is_power9(pnv)) {
-            ics_pic_print_info(&pnv->chips[i]->psi.ics, mon);
+            ics_pic_print_info(&pnv->chips[i]->psi->ics, mon);
         } else {
             pnv_xive_pic_print_info(pnv->chips[0]->xive, mon);
+            xive_source_pic_print_info(&pnv->chips[0]->psi->source, mon)=
;
         }
     }
 }
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5b969127c303..d233e64fd940 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -114,12 +114,14 @@
 #define PSIHB_BAR_MASK                  0x0003fffffff00000ull
 #define PSIHB_FSPBAR_MASK               0x0003ffff00000000ull
=20
+#define PSIHB_REG(addr) (((addr) >> 3) + PSIHB_XSCOM_BAR)
+
 static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
 {
     MemoryRegion *sysmem =3D get_system_memory();
     uint64_t old =3D psi->regs[PSIHB_XSCOM_BAR];
=20
-    psi->regs[PSIHB_XSCOM_BAR] =3D bar & (PSIHB_BAR_MASK | PSIHB_BAR_EN)=
;
+    psi->regs[PSIHB_XSCOM_BAR] =3D bar;
=20
     /* Update MR, always remove it first */
     if (old & PSIHB_BAR_EN) {
@@ -128,7 +130,7 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar=
)
=20
     /* Then add it back if needed */
     if (bar & PSIHB_BAR_EN) {
-        uint64_t addr =3D bar & PSIHB_BAR_MASK;
+        uint64_t addr =3D bar & ~PSIHB_BAR_EN;
         memory_region_add_subregion(sysmem, addr, &psi->regs_mr);
     }
 }
@@ -205,7 +207,12 @@ static const uint64_t stat_bits[] =3D {
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
     ICSState *ics =3D &psi->ics;
     uint32_t xivr_reg;
@@ -324,7 +331,7 @@ static uint64_t pnv_psi_reg_read(PnvPsi *psi, uint32_=
t offset, bool mmio)
         val =3D psi->regs[offset];
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "PSI: read at Ox%" PRIx32 "\n", offset)=
;
+        qemu_log_mask(LOG_UNIMP, "PSI: read at 0x%" PRIx32 "\n", offset)=
;
     }
     return val;
 }
@@ -383,7 +390,7 @@ static void pnv_psi_reg_write(PnvPsi *psi, uint32_t o=
ffset, uint64_t val,
         pnv_psi_set_irsn(psi, val);
         break;
     default:
-        qemu_log_mask(LOG_UNIMP, "PSI: write at Ox%" PRIx32 "\n", offset=
);
+        qemu_log_mask(LOG_UNIMP, "PSI: write at 0x%" PRIx32 "\n", offset=
);
     }
 }
=20
@@ -393,13 +400,13 @@ static void pnv_psi_reg_write(PnvPsi *psi, uint32_t=
 offset, uint64_t val,
  */
 static uint64_t pnv_psi_mmio_read(void *opaque, hwaddr addr, unsigned si=
ze)
 {
-    return pnv_psi_reg_read(opaque, (addr >> 3) + PSIHB_XSCOM_BAR, true)=
;
+    return pnv_psi_reg_read(opaque, PSIHB_REG(addr), true);
 }
=20
 static void pnv_psi_mmio_write(void *opaque, hwaddr addr,
                               uint64_t val, unsigned size)
 {
-    pnv_psi_reg_write(opaque, (addr >> 3) + PSIHB_XSCOM_BAR, val, true);
+    pnv_psi_reg_write(opaque, PSIHB_REG(addr), val, true);
 }
=20
 static const MemoryRegionOps psi_mmio_ops =3D {
@@ -458,7 +465,7 @@ static const uint8_t irq_to_xivr[] =3D {
     PSIHB_XSCOM_XIVR_EXT,
 };
=20
-static void pnv_psi_realize(DeviceState *dev, Error **errp)
+static void pnv_psi_power8_realize(DeviceState *dev, Error **errp)
 {
     PnvPsi *psi =3D PNV_PSI(dev);
     ICSState *ics =3D &psi->ics;
@@ -510,28 +517,34 @@ static void pnv_psi_realize(DeviceState *dev, Error=
 **errp)
     }
 }
=20
+static const char compat_p8[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
+static const char compat_p9[] =3D "ibm,power9-psihb-x\0ibm,psihb-x";
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
+    if (ppc->chip_type =3D=3D PNV_CHIP_POWER9) {
+        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p9,
+                         sizeof(compat_p9)));
+    } else {
+        _FDT(fdt_setprop(fdt, offset, "compatible", compat_p8,
+                         sizeof(compat_p8)));
+    }
     return 0;
 }
=20
@@ -541,6 +554,309 @@ static Property pnv_psi_properties[] =3D {
     DEFINE_PROP_END_OF_LIST(),
 };
=20
+static void pnv_psi_power8_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
+
+    dc->realize =3D pnv_psi_power8_realize;
+
+    ppc->chip_type =3D  PNV_CHIP_POWER8;
+    ppc->xscom_pcba =3D PNV_XSCOM_PSIHB_BASE;
+    ppc->xscom_size =3D PNV_XSCOM_PSIHB_SIZE;
+    ppc->irq_set    =3D pnv_psi_power8_irq_set;
+}
+
+static const TypeInfo pnv_psi_power8_info =3D {
+    .name          =3D TYPE_PNV_PSI_POWER8,
+    .parent        =3D TYPE_PNV_PSI,
+    .class_init    =3D pnv_psi_power8_class_init,
+};
+
+/* Common registers */
+
+#define PSIHB9_CR                       0x20
+#define PSIHB9_SEMR                     0x28
+
+/* P9 registers */
+
+#define PSIHB9_INTERRUPT_CONTROL        0x58
+#define   PSIHB9_IRQ_METHOD             PPC_BIT(0)
+#define   PSIHB9_IRQ_RESET              PPC_BIT(1)
+#define PSIHB9_ESB_CI_BASE              0x60
+#define   PSIHB9_ESB_CI_VALID           1
+#define PSIHB9_ESB_NOTIF_ADDR           0x68
+#define   PSIHB9_ESB_NOTIF_VALID        1
+#define PSIHB9_IVT_OFFSET               0x70
+#define   PSIHB9_IVT_OFF_SHIFT          32
+
+#define PSIHB9_IRQ_LEVEL                0x78 /* assertion */
+#define   PSIHB9_IRQ_LEVEL_PSI          PPC_BIT(0)
+#define   PSIHB9_IRQ_LEVEL_OCC          PPC_BIT(1)
+#define   PSIHB9_IRQ_LEVEL_FSI          PPC_BIT(2)
+#define   PSIHB9_IRQ_LEVEL_LPCHC        PPC_BIT(3)
+#define   PSIHB9_IRQ_LEVEL_LOCAL_ERR    PPC_BIT(4)
+#define   PSIHB9_IRQ_LEVEL_GLOBAL_ERR   PPC_BIT(5)
+#define   PSIHB9_IRQ_LEVEL_TPM          PPC_BIT(6)
+#define   PSIHB9_IRQ_LEVEL_LPC_SIRQ1    PPC_BIT(7)
+#define   PSIHB9_IRQ_LEVEL_LPC_SIRQ2    PPC_BIT(8)
+#define   PSIHB9_IRQ_LEVEL_LPC_SIRQ3    PPC_BIT(9)
+#define   PSIHB9_IRQ_LEVEL_LPC_SIRQ4    PPC_BIT(10)
+#define   PSIHB9_IRQ_LEVEL_SBE_I2C      PPC_BIT(11)
+#define   PSIHB9_IRQ_LEVEL_DIO          PPC_BIT(12)
+#define   PSIHB9_IRQ_LEVEL_PSU          PPC_BIT(13)
+#define   PSIHB9_IRQ_LEVEL_I2C_C        PPC_BIT(14)
+#define   PSIHB9_IRQ_LEVEL_I2C_D        PPC_BIT(15)
+#define   PSIHB9_IRQ_LEVEL_I2C_E        PPC_BIT(16)
+#define   PSIHB9_IRQ_LEVEL_SBE          PPC_BIT(19)
+
+#define PSIHB9_IRQ_STAT                 0x80 /* P bit */
+#define   PSIHB9_IRQ_STAT_PSI           PPC_BIT(0)
+#define   PSIHB9_IRQ_STAT_OCC           PPC_BIT(1)
+#define   PSIHB9_IRQ_STAT_FSI           PPC_BIT(2)
+#define   PSIHB9_IRQ_STAT_LPCHC         PPC_BIT(3)
+#define   PSIHB9_IRQ_STAT_LOCAL_ERR     PPC_BIT(4)
+#define   PSIHB9_IRQ_STAT_GLOBAL_ERR    PPC_BIT(5)
+#define   PSIHB9_IRQ_STAT_TPM           PPC_BIT(6)
+#define   PSIHB9_IRQ_STAT_LPC_SIRQ1     PPC_BIT(7)
+#define   PSIHB9_IRQ_STAT_LPC_SIRQ2     PPC_BIT(8)
+#define   PSIHB9_IRQ_STAT_LPC_SIRQ3     PPC_BIT(9)
+#define   PSIHB9_IRQ_STAT_LPC_SIRQ4     PPC_BIT(10)
+#define   PSIHB9_IRQ_STAT_SBE_I2C       PPC_BIT(11)
+#define   PSIHB9_IRQ_STAT_DIO           PPC_BIT(12)
+#define   PSIHB9_IRQ_STAT_PSU           PPC_BIT(13)
+
+static void pnv_psi_notify(XiveFabric *xf, uint32_t lisn)
+{
+    PnvPsi *psi =3D PNV_PSI(xf);
+    uint64_t notif_port =3D
+        psi->regs[PSIHB_REG(PSIHB9_ESB_NOTIF_ADDR)];
+    bool valid =3D notif_port & PSIHB9_ESB_NOTIF_VALID;
+    uint64_t notify_addr =3D notif_port & ~PSIHB9_ESB_NOTIF_VALID;
+    uint32_t data =3D cpu_to_be32(lisn);
+
+    if (valid) {
+        cpu_physical_memory_write(notify_addr, &data, sizeof(data));
+    }
+}
+
+/*
+ * TODO : move to parent class
+ */
+static void pnv_psi_power9_reset(DeviceState *dev)
+{
+    PnvPsi *psi =3D PNV_PSI(dev);
+
+    memset(psi->regs, 0x0, sizeof(psi->regs));
+
+    psi->regs[PSIHB_XSCOM_BAR] =3D psi->bar | PSIHB_BAR_EN;
+}
+
+static uint64_t pnv_psi_p9_mmio_read(void *opaque, hwaddr addr, unsigned=
 size)
+{
+    PnvPsi *psi =3D PNV_PSI(opaque);
+    uint32_t reg =3D PSIHB_REG(addr);
+    uint64_t val =3D -1;
+
+    switch (addr) {
+    case PSIHB9_CR:
+    case PSIHB9_SEMR:
+        /* FSP stuff */
+    case PSIHB9_INTERRUPT_CONTROL:
+    case PSIHB9_ESB_CI_BASE:
+    case PSIHB9_ESB_NOTIF_ADDR:
+    case PSIHB9_IVT_OFFSET:
+        val =3D psi->regs[reg];
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "PSI: read at 0x%" PRIx64 "\n", a=
ddr);
+    }
+
+    return val;
+}
+
+static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
+                                  uint64_t val, unsigned size)
+{
+    PnvPsi *psi =3D PNV_PSI(opaque);
+    uint32_t reg =3D PSIHB_REG(addr);
+
+    switch (addr) {
+    case PSIHB9_CR:
+    case PSIHB9_SEMR:
+        /* FSP stuff */
+        break;
+    case PSIHB9_INTERRUPT_CONTROL:
+        if (val & PSIHB9_IRQ_RESET) {
+            device_reset(DEVICE(&psi->source));
+        }
+        psi->regs[reg] =3D val;
+        break;
+
+    case PSIHB9_ESB_CI_BASE:
+        /* TODO: map ESB region now ? */
+        psi->regs[reg] =3D val;
+        break;
+
+    case PSIHB9_ESB_NOTIF_ADDR:
+        psi->regs[reg] =3D val;
+        break;
+    case PSIHB9_IVT_OFFSET:
+        psi->source.offset =3D (val >> PSIHB9_IVT_OFF_SHIFT);
+        psi->regs[reg] =3D val;
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "PSI: write at 0x%" PRIx64 "\n", =
addr);
+    }
+}
+
+static const MemoryRegionOps pnv_psi_p9_mmio_ops =3D {
+    .read =3D pnv_psi_p9_mmio_read,
+    .write =3D pnv_psi_p9_mmio_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+};
+
+static uint64_t pnv_psi_p9_xscom_read(void *opaque, hwaddr addr, unsigne=
d size)
+{
+    /* No read are expected */
+    qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom read at 0x%" PRIx64 "\n",=
 addr);
+    return -1;
+}
+
+static void pnv_psi_p9_xscom_write(void *opaque, hwaddr addr,
+                                uint64_t val, unsigned size)
+{
+    PnvPsi *psi =3D PNV_PSI(opaque);
+
+    /* XSCOM is only used to set the PSIHB MMIO region */
+    switch (addr >> 3) {
+    case PSIHB_XSCOM_BAR:
+        pnv_psi_set_bar(psi, val);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "PSI: xscom write at 0x%" PRIx64 =
"\n",
+                      addr);
+    }
+}
+
+static const MemoryRegionOps pnv_psi_p9_xscom_ops =3D {
+    .read =3D pnv_psi_p9_xscom_read,
+    .write =3D pnv_psi_p9_xscom_write,
+    .endianness =3D DEVICE_BIG_ENDIAN,
+    .valid =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    },
+    .impl =3D {
+        .min_access_size =3D 8,
+        .max_access_size =3D 8,
+    }
+};
+
+static void pnv_psi_power9_irq_set(PnvPsi *psi, int irq, bool state)
+{
+    uint32_t irq_method =3D psi->regs[PSIHB_REG(PSIHB9_INTERRUPT_CONTROL=
)];
+
+    if (irq > PSIHB9_NUM_IRQS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PSI: Unsupported irq %d\n", irq)=
;
+        return;
+    }
+
+    if (irq_method & PSIHB9_IRQ_METHOD) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PSI: LSI IRQ method no supported=
\n");
+        return;
+    }
+
+    if (state) {
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] |=3D PPC_BIT(irq);
+    } else {
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] &=3D ~PPC_BIT(irq);
+    }
+
+    qemu_set_irq(xive_source_qirq(&psi->source, irq), state);
+}
+
+static void pnv_psi_power9_init(Object *obj)
+{
+    PnvPsi *psi =3D PNV_PSI(obj);
+
+    object_initialize(&psi->source, sizeof(psi->source), TYPE_XIVE_SOURC=
E);
+    object_property_add_child(obj, "source", OBJECT(&psi->source), NULL)=
;
+}
+
+static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
+{
+    PnvPsi *psi =3D PNV_PSI(dev);
+    XiveSource *xsrc =3D &psi->source;
+    Error *local_err =3D NULL;
+    int i;
+
+    object_property_set_int(OBJECT(xsrc), psi->bar, "bar", &error_fatal)=
;
+    object_property_set_int(OBJECT(xsrc), XIVE_ESB_4K, "shift",
+                            &error_fatal);
+    object_property_set_int(OBJECT(xsrc), PSIHB9_NUM_IRQS, "nr-irqs",
+                            &error_fatal);
+    object_property_add_const_link(OBJECT(xsrc), "xive", OBJECT(psi),
+                                   &error_fatal);
+    object_property_set_bool(OBJECT(xsrc), true, "realized", &local_err)=
;
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    qdev_set_parent_bus(DEVICE(xsrc), sysbus_get_default());
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        xive_source_irq_set(xsrc, i, true);
+    }
+
+    /* XSCOM region for PSI registers */
+    pnv_xscom_region_init(&psi->xscom_regs, OBJECT(dev), &pnv_psi_p9_xsc=
om_ops,
+                psi, "xscom-psi", PNV_XSCOM_P9_PSIHB_SIZE);
+
+    /* Initialize MMIO region */
+    memory_region_init_io(&psi->regs_mr, OBJECT(dev), &pnv_psi_p9_mmio_o=
ps, psi,
+                          "psihb", PNV_PSIHB9_SIZE);
+
+    /* Default BAR for MMIO region */
+    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
+}
+
+static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
+    XiveFabricClass *xfc =3D XIVE_FABRIC_CLASS(klass);
+
+    dc->realize =3D pnv_psi_power9_realize;
+    dc->reset   =3D pnv_psi_power9_reset;
+
+    ppc->chip_type  =3D PNV_CHIP_POWER9;
+    ppc->xscom_pcba =3D PNV_XSCOM_P9_PSIHB_BASE;
+    ppc->xscom_size =3D PNV_XSCOM_P9_PSIHB_SIZE;
+    ppc->irq_set    =3D pnv_psi_power9_irq_set;
+
+    xfc->notify      =3D pnv_psi_notify;
+}
+
+static const TypeInfo pnv_psi_power9_info =3D {
+    .name          =3D TYPE_PNV_PSI_POWER9,
+    .parent        =3D TYPE_PNV_PSI,
+    .instance_init =3D pnv_psi_power9_init,
+    .class_init    =3D pnv_psi_power9_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+            { TYPE_XIVE_FABRIC },
+            { },
+    },
+};
+
 static void pnv_psi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -548,7 +864,7 @@ static void pnv_psi_class_init(ObjectClass *klass, vo=
id *data)
=20
     xdc->dt_xscom =3D pnv_psi_dt_xscom;
=20
-    dc->realize =3D pnv_psi_realize;
+    dc->desc =3D "PowerNV PSI Controller";
     dc->props =3D pnv_psi_properties;
 }
=20
@@ -558,6 +874,8 @@ static const TypeInfo pnv_psi_info =3D {
     .instance_size =3D sizeof(PnvPsi),
     .instance_init =3D pnv_psi_init,
     .class_init    =3D pnv_psi_class_init,
+    .class_size    =3D sizeof(PnvPsiClass),
+    .abstract      =3D true,
     .interfaces    =3D (InterfaceInfo[]) {
         { TYPE_PNV_XSCOM_INTERFACE },
         { }
@@ -567,6 +885,47 @@ static const TypeInfo pnv_psi_info =3D {
 static void pnv_psi_register_types(void)
 {
     type_register_static(&pnv_psi_info);
+    type_register_static(&pnv_psi_power8_info);
+    type_register_static(&pnv_psi_power9_info);
 }
=20
 type_init(pnv_psi_register_types)
+
+void pnv_chip_psi_realize(PnvChip *chip, Error **errp)
+{
+    Object *obj;
+    Error *local_err =3D NULL;
+
+    /* Processor Service Interface (PSI) Host Bridge */
+    if (pnv_chip_is_power9(chip)) {
+        obj =3D object_new(TYPE_PNV_PSI_POWER9);
+        object_property_set_int(obj, PNV_PSIHB9_BASE(chip), "bar",
+                                &error_fatal);
+    } else {
+        obj =3D object_new(TYPE_PNV_PSI_POWER8);
+        object_property_set_int(obj, PNV_PSIHB_BASE(chip), "bar", &error=
_fatal);
+        object_property_add_const_link(obj, "xics", qdev_get_machine(),
+                                       &error_abort);
+    }
+    qdev_set_parent_bus(DEVICE(obj), sysbus_get_default());
+
+    object_property_add_child(OBJECT(chip), "psi", obj, &error_abort);
+    object_property_set_bool(obj, true, "realized", &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    chip->psi =3D PNV_PSI(obj);
+
+    if (pnv_chip_is_power9(chip)) {
+        pnv_xscom_add_subregion(chip, PNV_XSCOM_P9_PSIHB_BASE,
+                                &chip->psi->xscom_regs);
+        memory_region_add_subregion(get_system_memory(),
+                                    PNV_PSIHB9_ESB_BASE(chip),
+                                    &chip->psi->source.esb_mmio);
+    } else {
+        pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE,
+                                &chip->psi->xscom_regs);
+    }
+}
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index f66fe53c38bb..c53ad244ba7d 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -61,7 +61,7 @@ typedef struct PnvChip {
     MemoryRegion icp_mmio;
=20
     PnvLpcController lpc;
-    PnvPsi       psi;
+    PnvPsi       *psi;
     PnvOCC       occ;
=20
     PnvXive      *xive;
@@ -205,6 +205,10 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
 #define PNV_XIVE_PC_BASE(chip)      (0x0006018000000000ull      \
     + (uint64_t)PNV_CHIP_INDEX(chip) * PNV_XIVE_PC_SIZE)
=20
+#define PNV_PSIHB9_SIZE              0x0000000000100000ull
+#define PNV_PSIHB9_BASE(chip)       (0x0006030203000000ull       \
+    + (uint64_t)PNV_CHIP_INDEX(chip) * PNV_PSIHB_SIZE)
+
 #define PNV_XIVE_IC_SIZE             0x0000000000080000ull
 #define PNV_XIVE_IC_BASE(chip)      (0x0006030203100000ull \
      + (uint64_t)PNV_CHIP_INDEX(chip) * PNV_XIVE_IC_SIZE)
@@ -212,6 +216,14 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
 #define PNV_XIVE_TM_SIZE             0x0000000000040000ull
 #define PNV_XIVE_TM_BASE(chip)       0x0006030203180000ull
=20
+#define PNV_PSIHB9_ESB_SIZE          0x0000000000010000ull
+#define PNV_PSIHB9_ESB_BASE(chip)   (0x00060302031c0000ull      \
+     + (uint64_t)PNV_CHIP_INDEX(chip) *  PNV_PSIHB9_ESB_SIZE)
+
 Object *pnv_icp_create(PnvMachineState *spapr, Object *cpu, Error **errp=
);
=20
+/*
+ * POWER9 MMIO base addresses
+ */
+
 #endif /* _PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index f6af5eae1fa8..82d60bc6578f 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -21,10 +21,35 @@
=20
 #include "hw/sysbus.h"
 #include "hw/ppc/xics.h"
+#include "hw/ppc/xive.h"
=20
 #define TYPE_PNV_PSI "pnv-psi"
 #define PNV_PSI(obj) \
      OBJECT_CHECK(PnvPsi, (obj), TYPE_PNV_PSI)
+#define PNV_PSI_CLASS(klass) \
+     OBJECT_CLASS_CHECK(PnvPsiClass, (klass), TYPE_PNV_PSI)
+#define PNV_PSI_GET_CLASS(obj) \
+     OBJECT_GET_CLASS(PnvPsiClass, (obj), TYPE_PNV_PSI)
+
+typedef struct PnvPsi PnvPsi;
+typedef struct PnvChip PnvChip;
+typedef struct PnvPsiClass {
+    SysBusDeviceClass parent_class;
+
+    int chip_type;
+    uint32_t xscom_pcba;
+    uint32_t xscom_size;
+
+    void (*irq_set)(PnvPsi *psi, int, bool state);
+} PnvPsiClass;
+
+#define TYPE_PNV_PSI_POWER8 TYPE_PNV_PSI "-POWER8"
+#define PNV_PSI_POWER8(obj) \
+    OBJECT_CHECK(PnvPsi, (obj), TYPE_PNV_PSI_POWER8)
+
+#define TYPE_PNV_PSI_POWER9 TYPE_PNV_PSI "-POWER9"
+#define PNV_PSI_POWER9(obj) \
+    OBJECT_CHECK(PnvPsi, (obj), TYPE_PNV_PSI_POWER9)
=20
 #define PSIHB_XSCOM_MAX         0x20
=20
@@ -38,9 +63,12 @@ typedef struct PnvPsi {
     /* MemoryRegion fsp_mr; */
     uint64_t fsp_bar;
=20
-    /* Interrupt generation */
+    /* P8 Interrupt generation */
     ICSState ics;
=20
+    /* P9 Interrupt generation */
+    XiveSource source;
+
     /* Registers */
     uint64_t regs[PSIHB_XSCOM_MAX];
=20
@@ -60,6 +88,24 @@ typedef enum PnvPsiIrq {
=20
 #define PSI_NUM_INTERRUPTS 6
=20
-extern void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool state);
+/* P9 PSI Interrupts */
+#define PSIHB9_IRQ_PSI          0
+#define PSIHB9_IRQ_OCC          1
+#define PSIHB9_IRQ_FSI          2
+#define PSIHB9_IRQ_LPCHC        3
+#define PSIHB9_IRQ_LOCAL_ERR    4
+#define PSIHB9_IRQ_GLOBAL_ERR   5
+#define PSIHB9_IRQ_TPM          6
+#define PSIHB9_IRQ_LPC_SIRQ0    7
+#define PSIHB9_IRQ_LPC_SIRQ1    8
+#define PSIHB9_IRQ_LPC_SIRQ2    9
+#define PSIHB9_IRQ_LPC_SIRQ3    10
+#define PSIHB9_IRQ_SBE_I2C      11
+#define PSIHB9_IRQ_DIO          12
+#define PSIHB9_IRQ_PSU          13
+#define PSIHB9_NUM_IRQS         14
+
+void pnv_psi_irq_set(PnvPsi *psi, int irq, bool state);
+void pnv_chip_psi_realize(PnvChip *chip, Error **errp);
=20
 #endif /* _PPC_PNV_PSI_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index f4b1649ffffa..60a963e2de29 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -69,6 +69,8 @@ typedef struct PnvXScomInterfaceClass {
=20
 #define PNV_XSCOM_PSIHB_BASE      0x2010900
 #define PNV_XSCOM_PSIHB_SIZE      0x20
+#define PNV_XSCOM_P9_PSIHB_BASE   0x5012900
+#define PNV_XSCOM_P9_PSIHB_SIZE   0x100
=20
 #define PNV_XSCOM_OCC_BASE        0x0066000
 #define PNV_XSCOM_OCC_SIZE        0x6000
--=20
2.13.6
