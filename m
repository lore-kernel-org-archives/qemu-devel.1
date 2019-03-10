Received: from eggs.gnu.org ([209.51.188.92]:43569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpE-00026h-W6
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2tpC-00022x-Vm
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:28:52 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:47 +1100
Message-Id: <20190310082703.1245-45-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 44/60] ppc/pnv: add a PSI bridge model for POWER9
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

The PSI bridge on POWER9 is very similar to POWER8. The BAR is still
set through XSCOM but the controls are now entirely done with MMIOs.
More interrupts are defined and the interrupt controller interface has
changed to XIVE. The POWER9 model is a first example of the usage of
the notify() handler of the XiveNotifier interface, linking the PSI
XiveSource to its owning device model.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Message-Id: <20190307223548.20516-3-clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/pnv.c               |  18 ++
 hw/ppc/pnv_psi.c           | 329 ++++++++++++++++++++++++++++++++++++-
 include/hw/ppc/pnv.h       |   6 +
 include/hw/ppc/pnv_psi.h   |  30 ++++
 include/hw/ppc/pnv_xscom.h |   3 +
 5 files changed, 384 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 5bb2332f16..1cc454cbbc 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -579,6 +579,7 @@ static void pnv_chip_power9_pic_print_info(PnvChip *c=
hip, Monitor *mon)
     Pnv9Chip *chip9 =3D PNV9_CHIP(chip);
=20
     pnv_xive_pic_print_info(&chip9->xive, mon);
+    pnv_psi_pic_print_info(&chip9->psi, mon);
 }
=20
 static void pnv_init(MachineState *machine)
@@ -950,6 +951,11 @@ static void pnv_chip_power9_instance_init(Object *ob=
j)
                             TYPE_PNV_XIVE, &error_abort, NULL);
     object_property_add_const_link(OBJECT(&chip9->xive), "chip", obj,
                                    &error_abort);
+
+    object_initialize_child(obj, "psi",  &chip9->psi, sizeof(chip9->psi)=
,
+                            TYPE_PNV9_PSI, &error_abort, NULL);
+    object_property_add_const_link(OBJECT(&chip9->psi), "chip", obj,
+                                   &error_abort);
 }
=20
 static void pnv_chip_power9_realize(DeviceState *dev, Error **errp)
@@ -957,6 +963,7 @@ static void pnv_chip_power9_realize(DeviceState *dev,=
 Error **errp)
     PnvChipClass *pcc =3D PNV_CHIP_GET_CLASS(dev);
     Pnv9Chip *chip9 =3D PNV9_CHIP(dev);
     PnvChip *chip =3D PNV_CHIP(dev);
+    Pnv9Psi *psi9 =3D &chip9->psi;
     Error *local_err =3D NULL;
=20
     pcc->parent_realize(dev, &local_err);
@@ -982,6 +989,17 @@ static void pnv_chip_power9_realize(DeviceState *dev=
, Error **errp)
     }
     pnv_xscom_add_subregion(chip, PNV9_XSCOM_XIVE_BASE,
                             &chip9->xive.xscom_regs);
+
+    /* Processor Service Interface (PSI) Host Bridge */
+    object_property_set_int(OBJECT(&chip9->psi), PNV9_PSIHB_BASE(chip),
+                            "bar", &error_fatal);
+    object_property_set_bool(OBJECT(&chip9->psi), true, "realized", &loc=
al_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV9_XSCOM_PSIHB_BASE,
+                            &PNV_PSI(psi9)->xscom_regs);
 }
=20
 static void pnv_chip_power9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 067f733f1e..5a923e4151 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -22,6 +22,7 @@
 #include "target/ppc/cpu.h"
 #include "qemu/log.h"
 #include "qapi/error.h"
+#include "monitor/monitor.h"
=20
 #include "exec/address-spaces.h"
=20
@@ -114,6 +115,9 @@
 #define PSIHB_BAR_MASK                  0x0003fffffff00000ull
 #define PSIHB_FSPBAR_MASK               0x0003ffff00000000ull
=20
+#define PSIHB9_BAR_MASK                 0x00fffffffff00000ull
+#define PSIHB9_FSPBAR_MASK              0x00ffffff00000000ull
+
 #define PSIHB_REG(addr) (((addr) >> 3) + PSIHB_XSCOM_BAR)
=20
 static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
@@ -531,6 +535,7 @@ static void pnv_psi_power8_realize(DeviceState *dev, =
Error **errp)
 }
=20
 static const char compat_p8[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
+static const char compat_p9[] =3D "ibm,power9-psihb-x\0ibm,psihb-x";
=20
 static int pnv_psi_dt_xscom(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
 {
@@ -550,8 +555,13 @@ static int pnv_psi_dt_xscom(PnvXScomInterface *dev, =
void *fdt, int xscom_offset)
     _FDT(fdt_setprop(fdt, offset, "reg", reg, sizeof(reg)));
     _FDT(fdt_setprop_cell(fdt, offset, "#address-cells", 2));
     _FDT(fdt_setprop_cell(fdt, offset, "#size-cells", 1));
-    _FDT(fdt_setprop(fdt, offset, "compatible", compat_p8,
-                     sizeof(compat_p8)));
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
@@ -584,6 +594,308 @@ static const TypeInfo pnv_psi_power8_info =3D {
     .class_init    =3D pnv_psi_power8_class_init,
 };
=20
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
+static void pnv_psi_notify(XiveNotifier *xf, uint32_t srcno)
+{
+    PnvPsi *psi =3D PNV_PSI(xf);
+    uint64_t notif_port =3D psi->regs[PSIHB_REG(PSIHB9_ESB_NOTIF_ADDR)];
+    bool valid =3D notif_port & PSIHB9_ESB_NOTIF_VALID;
+    uint64_t notify_addr =3D notif_port & ~PSIHB9_ESB_NOTIF_VALID;
+
+    uint32_t offset =3D
+        (psi->regs[PSIHB_REG(PSIHB9_IVT_OFFSET)] >> PSIHB9_IVT_OFF_SHIFT=
);
+    uint64_t lisn =3D cpu_to_be64(offset + srcno);
+
+    if (valid) {
+        cpu_physical_memory_write(notify_addr, &lisn, sizeof(lisn));
+    }
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
+    Pnv9Psi *psi9 =3D PNV9_PSI(psi);
+    uint32_t reg =3D PSIHB_REG(addr);
+    MemoryRegion *sysmem =3D get_system_memory();
+
+    switch (addr) {
+    case PSIHB9_CR:
+    case PSIHB9_SEMR:
+        /* FSP stuff */
+        break;
+    case PSIHB9_INTERRUPT_CONTROL:
+        if (val & PSIHB9_IRQ_RESET) {
+            device_reset(DEVICE(&psi9->source));
+        }
+        psi->regs[reg] =3D val;
+        break;
+
+    case PSIHB9_ESB_CI_BASE:
+        if (!(val & PSIHB9_ESB_CI_VALID)) {
+            if (psi->regs[reg] & PSIHB9_ESB_CI_VALID) {
+                memory_region_del_subregion(sysmem, &psi9->source.esb_mm=
io);
+            }
+        } else {
+            if (!(psi->regs[reg] & PSIHB9_ESB_CI_VALID)) {
+                memory_region_add_subregion(sysmem,
+                                        val & ~PSIHB9_ESB_CI_VALID,
+                                        &psi9->source.esb_mmio);
+            }
+        }
+        psi->regs[reg] =3D val;
+        break;
+
+    case PSIHB9_ESB_NOTIF_ADDR:
+        psi->regs[reg] =3D val;
+        break;
+    case PSIHB9_IVT_OFFSET:
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
+    /* Update LSI levels */
+    if (state) {
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] |=3D PPC_BIT(irq);
+    } else {
+        psi->regs[PSIHB_REG(PSIHB9_IRQ_LEVEL)] &=3D ~PPC_BIT(irq);
+    }
+
+    qemu_set_irq(psi->qirqs[irq], state);
+}
+
+static void pnv_psi_power9_reset(void *dev)
+{
+    Pnv9Psi *psi =3D PNV9_PSI(dev);
+
+    pnv_psi_reset(dev);
+
+    if (memory_region_is_mapped(&psi->source.esb_mmio)) {
+        memory_region_del_subregion(get_system_memory(), &psi->source.es=
b_mmio);
+    }
+}
+
+static void pnv_psi_power9_instance_init(Object *obj)
+{
+    Pnv9Psi *psi =3D PNV9_PSI(obj);
+
+    object_initialize_child(obj, "source", &psi->source, sizeof(psi->sou=
rce),
+                            TYPE_XIVE_SOURCE, &error_abort, NULL);
+}
+
+static void pnv_psi_power9_realize(DeviceState *dev, Error **errp)
+{
+    PnvPsi *psi =3D PNV_PSI(dev);
+    XiveSource *xsrc =3D &PNV9_PSI(psi)->source;
+    Error *local_err =3D NULL;
+    int i;
+
+    /* This is the only device with 4k ESB pages */
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
+
+    for (i =3D 0; i < xsrc->nr_irqs; i++) {
+        xive_source_irq_set_lsi(xsrc, i);
+    }
+
+    psi->qirqs =3D qemu_allocate_irqs(xive_source_set_irq, xsrc, xsrc->n=
r_irqs);
+
+    /* XSCOM region for PSI registers */
+    pnv_xscom_region_init(&psi->xscom_regs, OBJECT(dev), &pnv_psi_p9_xsc=
om_ops,
+                psi, "xscom-psi", PNV9_XSCOM_PSIHB_SIZE);
+
+    /* MMIO region for PSI registers */
+    memory_region_init_io(&psi->regs_mr, OBJECT(dev), &pnv_psi_p9_mmio_o=
ps, psi,
+                          "psihb", PNV9_PSIHB_SIZE);
+
+    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
+
+    qemu_register_reset(pnv_psi_power9_reset, dev);
+}
+
+static void pnv_psi_power9_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvPsiClass *ppc =3D PNV_PSI_CLASS(klass);
+    XiveNotifierClass *xfc =3D XIVE_NOTIFIER_CLASS(klass);
+
+    dc->desc    =3D "PowerNV PSI Controller POWER9";
+    dc->realize =3D pnv_psi_power9_realize;
+
+    ppc->chip_type  =3D PNV_CHIP_POWER9;
+    ppc->xscom_pcba =3D PNV9_XSCOM_PSIHB_BASE;
+    ppc->xscom_size =3D PNV9_XSCOM_PSIHB_SIZE;
+    ppc->bar_mask   =3D PSIHB9_BAR_MASK;
+    ppc->irq_set    =3D pnv_psi_power9_irq_set;
+
+    xfc->notify      =3D pnv_psi_notify;
+}
+
+static const TypeInfo pnv_psi_power9_info =3D {
+    .name          =3D TYPE_PNV9_PSI,
+    .parent        =3D TYPE_PNV_PSI,
+    .instance_size =3D sizeof(Pnv9Psi),
+    .instance_init =3D pnv_psi_power9_instance_init,
+    .class_init    =3D pnv_psi_power9_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+            { TYPE_XIVE_NOTIFIER },
+            { },
+    },
+};
+
 static void pnv_psi_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc =3D DEVICE_CLASS(klass);
@@ -612,6 +924,19 @@ static void pnv_psi_register_types(void)
 {
     type_register_static(&pnv_psi_info);
     type_register_static(&pnv_psi_power8_info);
+    type_register_static(&pnv_psi_power9_info);
 }
=20
 type_init(pnv_psi_register_types);
+
+void pnv_psi_pic_print_info(Pnv9Psi *psi9, Monitor *mon)
+{
+    PnvPsi *psi =3D PNV_PSI(psi9);
+
+    uint32_t offset =3D
+        (psi->regs[PSIHB_REG(PSIHB9_IVT_OFFSET)] >> PSIHB9_IVT_OFF_SHIFT=
);
+
+    monitor_printf(mon, "PSIHB Source %08x .. %08x\n",
+                  offset, offset + psi9->source.nr_irqs - 1);
+    xive_source_pic_print_info(&psi9->source, offset, mon);
+}
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 3b5f9cd531..8d80cb34ee 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -84,6 +84,7 @@ typedef struct Pnv9Chip {
=20
     /*< public >*/
     PnvXive      xive;
+    Pnv9Psi      psi;
 } Pnv9Chip;
=20
 typedef struct PnvChipClass {
@@ -231,11 +232,16 @@ void pnv_bmc_powerdown(IPMIBmc *bmc);
 #define PNV9_XIVE_PC_SIZE            0x0000001000000000ull
 #define PNV9_XIVE_PC_BASE(chip)      PNV9_CHIP_BASE(chip, 0x000601800000=
0000ull)
=20
+#define PNV9_PSIHB_SIZE              0x0000000000100000ull
+#define PNV9_PSIHB_BASE(chip)        PNV9_CHIP_BASE(chip, 0x000603020300=
0000ull)
+
 #define PNV9_XIVE_IC_SIZE            0x0000000000080000ull
 #define PNV9_XIVE_IC_BASE(chip)      PNV9_CHIP_BASE(chip, 0x000603020310=
0000ull)
=20
 #define PNV9_XIVE_TM_SIZE            0x0000000000040000ull
 #define PNV9_XIVE_TM_BASE(chip)      PNV9_CHIP_BASE(chip, 0x000603020318=
0000ull)
=20
+#define PNV9_PSIHB_ESB_SIZE          0x0000000000010000ull
+#define PNV9_PSIHB_ESB_BASE(chip)    PNV9_CHIP_BASE(chip, 0x00060302031c=
0000ull)
=20
 #endif /* _PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
index 7087cbcb9a..2c1b27e865 100644
--- a/include/hw/ppc/pnv_psi.h
+++ b/include/hw/ppc/pnv_psi.h
@@ -21,6 +21,7 @@
=20
 #include "hw/sysbus.h"
 #include "hw/ppc/xics.h"
+#include "hw/ppc/xive.h"
=20
 #define TYPE_PNV_PSI "pnv-psi"
 #define PNV_PSI(obj) \
@@ -57,6 +58,16 @@ typedef struct Pnv8Psi {
     ICSState ics;
 } Pnv8Psi;
=20
+#define TYPE_PNV9_PSI TYPE_PNV_PSI "-POWER9"
+#define PNV9_PSI(obj) \
+    OBJECT_CHECK(Pnv9Psi, (obj), TYPE_PNV9_PSI)
+
+typedef struct Pnv9Psi {
+    PnvPsi   parent;
+
+    XiveSource source;
+} Pnv9Psi;
+
 #define PNV_PSI_CLASS(klass) \
      OBJECT_CLASS_CHECK(PnvPsiClass, (klass), TYPE_PNV_PSI)
 #define PNV_PSI_GET_CLASS(obj) \
@@ -88,4 +99,23 @@ typedef enum PnvPsiIrq {
=20
 void pnv_psi_irq_set(PnvPsi *psi, int irq, bool state);
=20
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
+void pnv_psi_pic_print_info(Pnv9Psi *psi, Monitor *mon);
+
 #endif /* _PPC_PNV_PSI_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 6623ec54a7..403a365ed2 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -73,6 +73,9 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_OCC_BASE        0x0066000
 #define PNV_XSCOM_OCC_SIZE        0x6000
=20
+#define PNV9_XSCOM_PSIHB_BASE     0x5012900
+#define PNV9_XSCOM_PSIHB_SIZE     0x100
+
 #define PNV9_XSCOM_XIVE_BASE      0x5013000
 #define PNV9_XSCOM_XIVE_SIZE      0x300
=20
--=20
2.20.1
