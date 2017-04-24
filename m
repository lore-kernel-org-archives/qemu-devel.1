Received: from eggs.gnu.org ([2001:4830:134:3::10]:56436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TID-0001ZP-Pg
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 22:00:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d2TI9-0003Q5-MX
	for qemu-devel@nongnu.org; Sun, 23 Apr 2017 21:59:57 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Mon, 24 Apr 2017 11:59:07 +1000
Message-Id: <20170424015927.8933-28-david@gibson.dropbear.id.au>
In-Reply-To: <20170424015927.8933-1-david@gibson.dropbear.id.au>
References: <20170424015927.8933-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 27/47] ppc/pnv: Add cut down PSI bridge model
 and hookup external interrupt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, David Gibson <david@gibson.dropbear.id.au>

From: C=C3=A9dric Le Goater <clg@kaod.org>

The Processor Service Interface (PSI) Controller is one of the engines
of the "Bridge" unit which connects the different interfaces to the
Power Processor.

This adds just enough of the PSI bridge to handle various on-chip and
the one external interrupt. The rest of PSI has to do with the link to
the IBM FSP service processor which we don't plan to emulate (not used
on OpenPower machines).

The ics_get() and ics_resend() handlers of the XICSFabric interface of
the PowerNV machine are now defined to handle the Interrupt Control
Source of PSI. The InterruptStatsProvider interface is also modified
to dump the new ICS.

Originally from Benjamin Herrenschmidt <benh@kernel.crashing.org>

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/Makefile.objs       |   2 +-
 hw/ppc/pnv.c               |  65 +++++-
 hw/ppc/pnv_psi.c           | 571 +++++++++++++++++++++++++++++++++++++++=
++++++
 include/hw/ppc/pnv.h       |  13 ++
 include/hw/ppc/pnv_psi.h   |  67 ++++++
 include/hw/ppc/pnv_xscom.h |   3 +
 6 files changed, 714 insertions(+), 7 deletions(-)
 create mode 100644 hw/ppc/pnv_psi.c
 create mode 100644 include/hw/ppc/pnv_psi.h

diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 0012934..dc19ee1 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -6,7 +6,7 @@ obj-$(CONFIG_PSERIES) +=3D spapr_hcall.o spapr_iommu.o sp=
apr_rtas.o
 obj-$(CONFIG_PSERIES) +=3D spapr_pci.o spapr_rtc.o spapr_drc.o spapr_rng=
.o
 obj-$(CONFIG_PSERIES) +=3D spapr_cpu_core.o spapr_ovec.o
 # IBM PowerNV
-obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o
+obj-$(CONFIG_POWERNV) +=3D pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_ps=
i.o
 ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
 obj-y +=3D spapr_pci_vfio.o
 endif
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 1fa90d6..a516acb 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -353,15 +353,22 @@ static void ppc_powernv_reset(void)
  * have a CPLD that will collect the SerIRQ and shoot them as a
  * single level interrupt to the P8 chip. So let's setup a hook
  * for doing just that.
- *
- * Note: The actual interrupt input isn't emulated yet, this will
- * come with the PSI bridge model.
  */
 static void pnv_lpc_isa_irq_handler_cpld(void *opaque, int n, int level)
 {
-    /* We don't yet emulate the PSI bridge which provides the external
-     * interrupt, so just drop interrupts on the floor
-     */
+    PnvMachineState *pnv =3D POWERNV_MACHINE(qdev_get_machine());
+    uint32_t old_state =3D pnv->cpld_irqstate;
+    PnvChip *chip =3D opaque;
+
+    if (level) {
+        pnv->cpld_irqstate |=3D 1u << n;
+    } else {
+        pnv->cpld_irqstate &=3D ~(1u << n);
+    }
+    if (pnv->cpld_irqstate !=3D old_state) {
+        pnv_psi_irq_set(&chip->psi, PSIHB_IRQ_EXTERNAL,
+                        pnv->cpld_irqstate !=3D 0);
+    }
 }
=20
 static void pnv_lpc_isa_irq_handler(void *opaque, int n, int level)
@@ -682,6 +689,11 @@ static void pnv_chip_init(Object *obj)
=20
     object_initialize(&chip->lpc, sizeof(chip->lpc), TYPE_PNV_LPC);
     object_property_add_child(obj, "lpc", OBJECT(&chip->lpc), NULL);
+
+    object_initialize(&chip->psi, sizeof(chip->psi), TYPE_PNV_PSI);
+    object_property_add_child(obj, "psi", OBJECT(&chip->psi), NULL);
+    object_property_add_const_link(OBJECT(&chip->psi), "xics",
+                                   OBJECT(qdev_get_machine()), &error_ab=
ort);
 }
=20
 static void pnv_chip_icp_realize(PnvChip *chip, Error **errp)
@@ -794,6 +806,16 @@ static void pnv_chip_realize(DeviceState *dev, Error=
 **errp)
         error_propagate(errp, error);
         return;
     }
+
+    /* Processor Service Interface (PSI) Host Bridge */
+    object_property_set_int(OBJECT(&chip->psi), PNV_PSIHB_BASE(chip),
+                            "bar", &error_fatal);
+    object_property_set_bool(OBJECT(&chip->psi), true, "realized", &erro=
r);
+    if (error) {
+        error_propagate(errp, error);
+        return;
+    }
+    pnv_xscom_add_subregion(chip, PNV_XSCOM_PSIHB_BASE, &chip->psi.xscom=
_regs);
 }
=20
 static Property pnv_chip_properties[] =3D {
@@ -824,6 +846,29 @@ static const TypeInfo pnv_chip_info =3D {
     .abstract      =3D true,
 };
=20
+static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    int i;
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        if (ics_valid_irq(&pnv->chips[i]->psi.ics, irq)) {
+            return &pnv->chips[i]->psi.ics;
+        }
+    }
+    return NULL;
+}
+
+static void pnv_ics_resend(XICSFabric *xi)
+{
+    PnvMachineState *pnv =3D POWERNV_MACHINE(xi);
+    int i;
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        ics_resend(&pnv->chips[i]->psi.ics);
+    }
+}
+
 static PowerPCCPU *ppc_get_vcpu_by_pir(int pir)
 {
     CPUState *cs;
@@ -850,6 +895,8 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pir)
 static void pnv_pic_print_info(InterruptStatsProvider *obj,
                                Monitor *mon)
 {
+    PnvMachineState *pnv =3D POWERNV_MACHINE(obj);
+    int i;
     CPUState *cs;
=20
     CPU_FOREACH(cs) {
@@ -857,6 +904,10 @@ static void pnv_pic_print_info(InterruptStatsProvide=
r *obj,
=20
         icp_pic_print_info(ICP(cpu->intc), mon);
     }
+
+    for (i =3D 0; i < pnv->num_chips; i++) {
+        ics_pic_print_info(&pnv->chips[i]->psi.ics, mon);
+    }
 }
=20
 static void pnv_get_num_chips(Object *obj, Visitor *v, const char *name,
@@ -922,6 +973,8 @@ static void powernv_machine_class_init(ObjectClass *o=
c, void *data)
     mc->default_boot_order =3D NULL;
     mc->default_ram_size =3D 1 * G_BYTE;
     xic->icp_get =3D pnv_icp_get;
+    xic->ics_get =3D pnv_ics_get;
+    xic->ics_resend =3D pnv_ics_resend;
     ispc->print_info =3D pnv_pic_print_info;
=20
     powernv_machine_class_props_init(oc);
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
new file mode 100644
index 0000000..2bf5bfe
--- /dev/null
+++ b/hw/ppc/pnv_psi.c
@@ -0,0 +1,571 @@
+/*
+ * QEMU PowerPC PowerNV Processor Service Interface (PSI) model
+ *
+ * Copyright (c) 2015-2017, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/hw.h"
+#include "target/ppc/cpu.h"
+#include "qemu/log.h"
+#include "qapi/error.h"
+
+#include "exec/address-spaces.h"
+
+#include "hw/ppc/fdt.h"
+#include "hw/ppc/pnv.h"
+#include "hw/ppc/pnv_xscom.h"
+#include "hw/ppc/pnv_psi.h"
+
+#include <libfdt.h>
+
+#define PSIHB_XSCOM_FIR_RW      0x00
+#define PSIHB_XSCOM_FIR_AND     0x01
+#define PSIHB_XSCOM_FIR_OR      0x02
+#define PSIHB_XSCOM_FIRMASK_RW  0x03
+#define PSIHB_XSCOM_FIRMASK_AND 0x04
+#define PSIHB_XSCOM_FIRMASK_OR  0x05
+#define PSIHB_XSCOM_FIRACT0     0x06
+#define PSIHB_XSCOM_FIRACT1     0x07
+
+/* Host Bridge Base Address Register */
+#define PSIHB_XSCOM_BAR         0x0a
+#define   PSIHB_BAR_EN                  0x0000000000000001ull
+
+/* FSP Base Address Register */
+#define PSIHB_XSCOM_FSPBAR      0x0b
+
+/* PSI Host Bridge Control/Status Register */
+#define PSIHB_XSCOM_CR          0x0e
+#define   PSIHB_CR_FSP_CMD_ENABLE       0x8000000000000000ull
+#define   PSIHB_CR_FSP_MMIO_ENABLE      0x4000000000000000ull
+#define   PSIHB_CR_FSP_IRQ_ENABLE       0x1000000000000000ull
+#define   PSIHB_CR_FSP_ERR_RSP_ENABLE   0x0800000000000000ull
+#define   PSIHB_CR_PSI_LINK_ENABLE      0x0400000000000000ull
+#define   PSIHB_CR_FSP_RESET            0x0200000000000000ull
+#define   PSIHB_CR_PSIHB_RESET          0x0100000000000000ull
+#define   PSIHB_CR_PSI_IRQ              0x0000800000000000ull
+#define   PSIHB_CR_FSP_IRQ              0x0000400000000000ull
+#define   PSIHB_CR_FSP_LINK_ACTIVE      0x0000200000000000ull
+#define   PSIHB_CR_IRQ_CMD_EXPECT       0x0000010000000000ull
+          /* and more ... */
+
+/* PSIHB Status / Error Mask Register */
+#define PSIHB_XSCOM_SEMR        0x0f
+
+/* XIVR, to signal interrupts to the CEC firmware. more XIVR below. */
+#define PSIHB_XSCOM_XIVR_FSP    0x10
+#define   PSIHB_XIVR_SERVER_SH          40
+#define   PSIHB_XIVR_SERVER_MSK         (0xffffull << PSIHB_XIVR_SERVER_=
SH)
+#define   PSIHB_XIVR_PRIO_SH            32
+#define   PSIHB_XIVR_PRIO_MSK           (0xffull << PSIHB_XIVR_PRIO_SH)
+#define   PSIHB_XIVR_SRC_SH             29
+#define   PSIHB_XIVR_SRC_MSK            (0x7ull << PSIHB_XIVR_SRC_SH)
+#define   PSIHB_XIVR_PENDING            0x01000000ull
+
+/* PSI Host Bridge Set Control/ Status Register */
+#define PSIHB_XSCOM_SCR         0x12
+
+/* PSI Host Bridge Clear Control/ Status Register */
+#define PSIHB_XSCOM_CCR         0x13
+
+/* DMA Upper Address Register */
+#define PSIHB_XSCOM_DMA_UPADD   0x14
+
+/* Interrupt Status */
+#define PSIHB_XSCOM_IRQ_STAT    0x15
+#define   PSIHB_IRQ_STAT_OCC            0x0000001000000000ull
+#define   PSIHB_IRQ_STAT_FSI            0x0000000800000000ull
+#define   PSIHB_IRQ_STAT_LPCI2C         0x0000000400000000ull
+#define   PSIHB_IRQ_STAT_LOCERR         0x0000000200000000ull
+#define   PSIHB_IRQ_STAT_EXT            0x0000000100000000ull
+
+/* remaining XIVR */
+#define PSIHB_XSCOM_XIVR_OCC    0x16
+#define PSIHB_XSCOM_XIVR_FSI    0x17
+#define PSIHB_XSCOM_XIVR_LPCI2C 0x18
+#define PSIHB_XSCOM_XIVR_LOCERR 0x19
+#define PSIHB_XSCOM_XIVR_EXT    0x1a
+
+/* Interrupt Requester Source Compare Register */
+#define PSIHB_XSCOM_IRSN        0x1b
+#define   PSIHB_IRSN_COMP_SH            45
+#define   PSIHB_IRSN_COMP_MSK           (0x7ffffull << PSIHB_IRSN_COMP_S=
H)
+#define   PSIHB_IRSN_IRQ_MUX            0x0000000800000000ull
+#define   PSIHB_IRSN_IRQ_RESET          0x0000000400000000ull
+#define   PSIHB_IRSN_DOWNSTREAM_EN      0x0000000200000000ull
+#define   PSIHB_IRSN_UPSTREAM_EN        0x0000000100000000ull
+#define   PSIHB_IRSN_COMPMASK_SH        13
+#define   PSIHB_IRSN_COMPMASK_MSK       (0x7ffffull << PSIHB_IRSN_COMPMA=
SK_SH)
+
+#define PSIHB_BAR_MASK                  0x0003fffffff00000ull
+#define PSIHB_FSPBAR_MASK               0x0003ffff00000000ull
+
+static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
+{
+    MemoryRegion *sysmem =3D get_system_memory();
+    uint64_t old =3D psi->regs[PSIHB_XSCOM_BAR];
+
+    psi->regs[PSIHB_XSCOM_BAR] =3D bar & (PSIHB_BAR_MASK | PSIHB_BAR_EN)=
;
+
+    /* Update MR, always remove it first */
+    if (old & PSIHB_BAR_EN) {
+        memory_region_del_subregion(sysmem, &psi->regs_mr);
+    }
+
+    /* Then add it back if needed */
+    if (bar & PSIHB_BAR_EN) {
+        uint64_t addr =3D bar & PSIHB_BAR_MASK;
+        memory_region_add_subregion(sysmem, addr, &psi->regs_mr);
+    }
+}
+
+static void pnv_psi_update_fsp_mr(PnvPsi *psi)
+{
+    /* TODO: Update FSP MR if/when we support FSP BAR */
+}
+
+static void pnv_psi_set_cr(PnvPsi *psi, uint64_t cr)
+{
+    uint64_t old =3D psi->regs[PSIHB_XSCOM_CR];
+
+    psi->regs[PSIHB_XSCOM_CR] =3D cr;
+
+    /* Check some bit changes */
+    if ((old ^ psi->regs[PSIHB_XSCOM_CR]) & PSIHB_CR_FSP_MMIO_ENABLE) {
+        pnv_psi_update_fsp_mr(psi);
+    }
+}
+
+static void pnv_psi_set_irsn(PnvPsi *psi, uint64_t val)
+{
+    ICSState *ics =3D &psi->ics;
+
+    /* In this model we ignore the up/down enable bits for now
+     * as SW doesn't use them (other than setting them at boot).
+     * We ignore IRQ_MUX, its meaning isn't clear and we don't use
+     * it and finally we ignore reset (XXX fix that ?)
+     */
+    psi->regs[PSIHB_XSCOM_IRSN] =3D val & (PSIHB_IRSN_COMP_MSK |
+                                         PSIHB_IRSN_IRQ_MUX |
+                                         PSIHB_IRSN_IRQ_RESET |
+                                         PSIHB_IRSN_DOWNSTREAM_EN |
+                                         PSIHB_IRSN_UPSTREAM_EN);
+
+    /* We ignore the compare mask as well, our ICS emulation is too
+     * simplistic to make any use if it, and we extract the offset
+     * from the compare value
+     */
+    ics->offset =3D (val & PSIHB_IRSN_COMP_MSK) >> PSIHB_IRSN_COMP_SH;
+}
+
+/*
+ * FSP and PSI interrupts are muxed under the same number.
+ */
+static const uint32_t xivr_regs[] =3D {
+    [PSIHB_IRQ_PSI]       =3D PSIHB_XSCOM_XIVR_FSP,
+    [PSIHB_IRQ_FSP]       =3D PSIHB_XSCOM_XIVR_FSP,
+    [PSIHB_IRQ_OCC]       =3D PSIHB_XSCOM_XIVR_OCC,
+    [PSIHB_IRQ_FSI]       =3D PSIHB_XSCOM_XIVR_FSI,
+    [PSIHB_IRQ_LPC_I2C]   =3D PSIHB_XSCOM_XIVR_LPCI2C,
+    [PSIHB_IRQ_LOCAL_ERR] =3D PSIHB_XSCOM_XIVR_LOCERR,
+    [PSIHB_IRQ_EXTERNAL]  =3D PSIHB_XSCOM_XIVR_EXT,
+};
+
+static const uint32_t stat_regs[] =3D {
+    [PSIHB_IRQ_PSI]       =3D PSIHB_XSCOM_CR,
+    [PSIHB_IRQ_FSP]       =3D PSIHB_XSCOM_CR,
+    [PSIHB_IRQ_OCC]       =3D PSIHB_XSCOM_IRQ_STAT,
+    [PSIHB_IRQ_FSI]       =3D PSIHB_XSCOM_IRQ_STAT,
+    [PSIHB_IRQ_LPC_I2C]   =3D PSIHB_XSCOM_IRQ_STAT,
+    [PSIHB_IRQ_LOCAL_ERR] =3D PSIHB_XSCOM_IRQ_STAT,
+    [PSIHB_IRQ_EXTERNAL]  =3D PSIHB_XSCOM_IRQ_STAT,
+};
+
+static const uint64_t stat_bits[] =3D {
+    [PSIHB_IRQ_PSI]       =3D PSIHB_CR_PSI_IRQ,
+    [PSIHB_IRQ_FSP]       =3D PSIHB_CR_FSP_IRQ,
+    [PSIHB_IRQ_OCC]       =3D PSIHB_IRQ_STAT_OCC,
+    [PSIHB_IRQ_FSI]       =3D PSIHB_IRQ_STAT_FSI,
+    [PSIHB_IRQ_LPC_I2C]   =3D PSIHB_IRQ_STAT_LPCI2C,
+    [PSIHB_IRQ_LOCAL_ERR] =3D PSIHB_IRQ_STAT_LOCERR,
+    [PSIHB_IRQ_EXTERNAL]  =3D PSIHB_IRQ_STAT_EXT,
+};
+
+void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool state)
+{
+    ICSState *ics =3D &psi->ics;
+    uint32_t xivr_reg;
+    uint32_t stat_reg;
+    uint32_t src;
+    bool masked;
+
+    if (irq > PSIHB_IRQ_EXTERNAL) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PSI: Unsupported irq %d\n", irq)=
;
+        return;
+    }
+
+    xivr_reg =3D xivr_regs[irq];
+    stat_reg =3D stat_regs[irq];
+
+    src =3D (psi->regs[xivr_reg] & PSIHB_XIVR_SRC_MSK) >> PSIHB_XIVR_SRC=
_SH;
+    if (state) {
+        psi->regs[stat_reg] |=3D stat_bits[irq];
+        /* TODO: optimization, check mask here. That means
+         * re-evaluating when unmasking
+         */
+        qemu_irq_raise(ics->qirqs[src]);
+    } else {
+        psi->regs[stat_reg] &=3D ~stat_bits[irq];
+
+        /* FSP and PSI are muxed so don't lower if either is still set *=
/
+        if (stat_reg !=3D PSIHB_XSCOM_CR ||
+            !(psi->regs[stat_reg] & (PSIHB_CR_PSI_IRQ | PSIHB_CR_FSP_IRQ=
))) {
+            qemu_irq_lower(ics->qirqs[src]);
+        } else {
+            state =3D true;
+        }
+    }
+
+    /* Note about the emulation of the pending bit: This isn't
+     * entirely correct. The pending bit should be cleared when the
+     * EOI has been received. However, we don't have callbacks on EOI
+     * (especially not under KVM) so no way to emulate that properly,
+     * so instead we just set that bit as the logical "output" of the
+     * XIVR (ie pending & !masked)
+     *
+     * CLG: We could define a new ICS object with a custom eoi()
+     * handler to clear the pending bit. But I am not sure this would
+     * be useful for the software anyhow.
+     */
+    masked =3D (psi->regs[xivr_reg] & PSIHB_XIVR_PRIO_MSK) =3D=3D PSIHB_=
XIVR_PRIO_MSK;
+    if (state && !masked) {
+        psi->regs[xivr_reg] |=3D PSIHB_XIVR_PENDING;
+    } else {
+        psi->regs[xivr_reg] &=3D ~PSIHB_XIVR_PENDING;
+    }
+}
+
+static void pnv_psi_set_xivr(PnvPsi *psi, uint32_t reg, uint64_t val)
+{
+    ICSState *ics =3D &psi->ics;
+    uint16_t server;
+    uint8_t prio;
+    uint8_t src;
+
+    psi->regs[reg] =3D (psi->regs[reg] & PSIHB_XIVR_PENDING) |
+            (val & (PSIHB_XIVR_SERVER_MSK |
+                    PSIHB_XIVR_PRIO_MSK |
+                    PSIHB_XIVR_SRC_MSK));
+    val =3D psi->regs[reg];
+    server =3D (val & PSIHB_XIVR_SERVER_MSK) >> PSIHB_XIVR_SERVER_SH;
+    prio =3D (val & PSIHB_XIVR_PRIO_MSK) >> PSIHB_XIVR_PRIO_SH;
+    src =3D (val & PSIHB_XIVR_SRC_MSK) >> PSIHB_XIVR_SRC_SH;
+
+    if (src >=3D PSI_NUM_INTERRUPTS) {
+        qemu_log_mask(LOG_GUEST_ERROR, "PSI: Unsupported irq %d\n", src)=
;
+        return;
+    }
+
+    /* Remove pending bit if the IRQ is masked */
+    if ((psi->regs[reg] & PSIHB_XIVR_PRIO_MSK) =3D=3D PSIHB_XIVR_PRIO_MS=
K) {
+        psi->regs[reg] &=3D ~PSIHB_XIVR_PENDING;
+    }
+
+    /* The low order 2 bits are the link pointer (Type II interrupts).
+     * Shift back to get a valid IRQ server.
+     */
+    server >>=3D 2;
+
+    /* Now because of source remapping, weird things can happen
+     * if you change the source number dynamically, our simple ICS
+     * doesn't deal with remapping. So we just poke a different
+     * ICS entry based on what source number was written. This will
+     * do for now but a more accurate implementation would instead
+     * use a fixed server/prio and a remapper of the generated irq.
+     */
+    ics_simple_write_xive(ics, src, server, prio, prio);
+}
+
+static uint64_t pnv_psi_reg_read(PnvPsi *psi, uint32_t offset, bool mmio=
)
+{
+    uint64_t val =3D 0xffffffffffffffffull;
+
+    switch (offset) {
+    case PSIHB_XSCOM_FIR_RW:
+    case PSIHB_XSCOM_FIRACT0:
+    case PSIHB_XSCOM_FIRACT1:
+    case PSIHB_XSCOM_BAR:
+    case PSIHB_XSCOM_FSPBAR:
+    case PSIHB_XSCOM_CR:
+    case PSIHB_XSCOM_XIVR_FSP:
+    case PSIHB_XSCOM_XIVR_OCC:
+    case PSIHB_XSCOM_XIVR_FSI:
+    case PSIHB_XSCOM_XIVR_LPCI2C:
+    case PSIHB_XSCOM_XIVR_LOCERR:
+    case PSIHB_XSCOM_XIVR_EXT:
+    case PSIHB_XSCOM_IRQ_STAT:
+    case PSIHB_XSCOM_SEMR:
+    case PSIHB_XSCOM_DMA_UPADD:
+    case PSIHB_XSCOM_IRSN:
+        val =3D psi->regs[offset];
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "PSI: read at Ox%" PRIx32 "\n", offset)=
;
+    }
+    return val;
+}
+
+static void pnv_psi_reg_write(PnvPsi *psi, uint32_t offset, uint64_t val=
,
+                              bool mmio)
+{
+    switch (offset) {
+    case PSIHB_XSCOM_FIR_RW:
+    case PSIHB_XSCOM_FIRACT0:
+    case PSIHB_XSCOM_FIRACT1:
+    case PSIHB_XSCOM_SEMR:
+    case PSIHB_XSCOM_DMA_UPADD:
+        psi->regs[offset] =3D val;
+        break;
+    case PSIHB_XSCOM_FIR_OR:
+        psi->regs[PSIHB_XSCOM_FIR_RW] |=3D val;
+        break;
+    case PSIHB_XSCOM_FIR_AND:
+        psi->regs[PSIHB_XSCOM_FIR_RW] &=3D val;
+        break;
+    case PSIHB_XSCOM_BAR:
+        /* Only XSCOM can write this one */
+        if (!mmio) {
+            pnv_psi_set_bar(psi, val);
+        } else {
+            qemu_log_mask(LOG_GUEST_ERROR, "PSI: invalid write of BAR\n"=
);
+        }
+        break;
+    case PSIHB_XSCOM_FSPBAR:
+        psi->regs[PSIHB_XSCOM_FSPBAR] =3D val & PSIHB_FSPBAR_MASK;
+        pnv_psi_update_fsp_mr(psi);
+        break;
+    case PSIHB_XSCOM_CR:
+        pnv_psi_set_cr(psi, val);
+        break;
+    case PSIHB_XSCOM_SCR:
+        pnv_psi_set_cr(psi, psi->regs[PSIHB_XSCOM_CR] | val);
+        break;
+    case PSIHB_XSCOM_CCR:
+        pnv_psi_set_cr(psi, psi->regs[PSIHB_XSCOM_CR] & ~val);
+        break;
+    case PSIHB_XSCOM_XIVR_FSP:
+    case PSIHB_XSCOM_XIVR_OCC:
+    case PSIHB_XSCOM_XIVR_FSI:
+    case PSIHB_XSCOM_XIVR_LPCI2C:
+    case PSIHB_XSCOM_XIVR_LOCERR:
+    case PSIHB_XSCOM_XIVR_EXT:
+        pnv_psi_set_xivr(psi, offset, val);
+        break;
+    case PSIHB_XSCOM_IRQ_STAT:
+        /* Read only */
+        qemu_log_mask(LOG_GUEST_ERROR, "PSI: invalid write of IRQ_STAT\n=
");
+        break;
+    case PSIHB_XSCOM_IRSN:
+        pnv_psi_set_irsn(psi, val);
+        break;
+    default:
+        qemu_log_mask(LOG_UNIMP, "PSI: write at Ox%" PRIx32 "\n", offset=
);
+    }
+}
+
+/*
+ * The values of the registers when accessed through the MMIO region
+ * follow the relation : xscom =3D (mmio + 0x50) >> 3
+ */
+static uint64_t pnv_psi_mmio_read(void *opaque, hwaddr addr, unsigned si=
ze)
+{
+    return pnv_psi_reg_read(opaque, (addr >> 3) + PSIHB_XSCOM_BAR, true)=
;
+}
+
+static void pnv_psi_mmio_write(void *opaque, hwaddr addr,
+                              uint64_t val, unsigned size)
+{
+    pnv_psi_reg_write(opaque, (addr >> 3) + PSIHB_XSCOM_BAR, val, true);
+}
+
+static const MemoryRegionOps psi_mmio_ops =3D {
+    .read =3D pnv_psi_mmio_read,
+    .write =3D pnv_psi_mmio_write,
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
+static uint64_t pnv_psi_xscom_read(void *opaque, hwaddr addr, unsigned s=
ize)
+{
+    return pnv_psi_reg_read(opaque, addr >> 3, false);
+}
+
+static void pnv_psi_xscom_write(void *opaque, hwaddr addr,
+                                uint64_t val, unsigned size)
+{
+    pnv_psi_reg_write(opaque, addr >> 3, val, false);
+}
+
+static const MemoryRegionOps pnv_psi_xscom_ops =3D {
+    .read =3D pnv_psi_xscom_read,
+    .write =3D pnv_psi_xscom_write,
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
+static void pnv_psi_init(Object *obj)
+{
+    PnvPsi *psi =3D PNV_PSI(obj);
+
+    object_initialize(&psi->ics, sizeof(psi->ics), TYPE_ICS_SIMPLE);
+    object_property_add_child(obj, "ics-psi", OBJECT(&psi->ics), NULL);
+}
+
+static const uint8_t irq_to_xivr[] =3D {
+    PSIHB_XSCOM_XIVR_FSP,
+    PSIHB_XSCOM_XIVR_OCC,
+    PSIHB_XSCOM_XIVR_FSI,
+    PSIHB_XSCOM_XIVR_LPCI2C,
+    PSIHB_XSCOM_XIVR_LOCERR,
+    PSIHB_XSCOM_XIVR_EXT,
+};
+
+static void pnv_psi_realize(DeviceState *dev, Error **errp)
+{
+    PnvPsi *psi =3D PNV_PSI(dev);
+    ICSState *ics =3D &psi->ics;
+    Object *obj;
+    Error *err =3D NULL;
+    unsigned int i;
+
+    obj =3D object_property_get_link(OBJECT(dev), "xics", &err);
+    if (!obj) {
+        error_setg(errp, "%s: required link 'xics' not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
+    }
+
+    /* Create PSI interrupt control source */
+    object_property_add_const_link(OBJECT(ics), "xics", obj,  &error_abo=
rt);
+    object_property_set_int(OBJECT(ics), PSI_NUM_INTERRUPTS, "nr-irqs", =
&err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    object_property_set_bool(OBJECT(ics), true, "realized",  &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    for (i =3D 0; i < ics->nr_irqs; i++) {
+        ics_set_irq_type(ics, i, true);
+    }
+
+    /* XSCOM region for PSI registers */
+    pnv_xscom_region_init(&psi->xscom_regs, OBJECT(dev), &pnv_psi_xscom_=
ops,
+                psi, "xscom-psi", PNV_XSCOM_PSIHB_SIZE);
+
+    /* Initialize MMIO region */
+    memory_region_init_io(&psi->regs_mr, OBJECT(dev), &psi_mmio_ops, psi=
,
+                          "psihb", PNV_PSIHB_SIZE);
+
+    /* Default BAR for MMIO region */
+    pnv_psi_set_bar(psi, psi->bar | PSIHB_BAR_EN);
+
+    /* Default sources in XIVR */
+    for (i =3D 0; i < PSI_NUM_INTERRUPTS; i++) {
+        uint8_t xivr =3D irq_to_xivr[i];
+        psi->regs[xivr] =3D PSIHB_XIVR_PRIO_MSK |
+            ((uint64_t) i << PSIHB_XIVR_SRC_SH);
+    }
+}
+
+static int pnv_psi_populate(PnvXScomInterface *dev, void *fdt, int xscom=
_offset)
+{
+    const char compat[] =3D "ibm,power8-psihb-x\0ibm,psihb-x";
+    char *name;
+    int offset;
+    uint32_t lpc_pcba =3D PNV_XSCOM_PSIHB_BASE;
+    uint32_t reg[] =3D {
+        cpu_to_be32(lpc_pcba),
+        cpu_to_be32(PNV_XSCOM_PSIHB_SIZE)
+    };
+
+    name =3D g_strdup_printf("psihb@%x", lpc_pcba);
+    offset =3D fdt_add_subnode(fdt, xscom_offset, name);
+    _FDT(offset);
+    g_free(name);
+
+    _FDT((fdt_setprop(fdt, offset, "reg", reg, sizeof(reg))));
+
+    _FDT((fdt_setprop_cell(fdt, offset, "#address-cells", 2)));
+    _FDT((fdt_setprop_cell(fdt, offset, "#size-cells", 1)));
+    _FDT((fdt_setprop(fdt, offset, "compatible", compat,
+                      sizeof(compat))));
+    return 0;
+}
+
+static Property pnv_psi_properties[] =3D {
+    DEFINE_PROP_UINT64("bar", PnvPsi, bar, 0),
+    DEFINE_PROP_UINT64("fsp-bar", PnvPsi, fsp_bar, 0),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pnv_psi_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+    PnvXScomInterfaceClass *xdc =3D PNV_XSCOM_INTERFACE_CLASS(klass);
+
+    xdc->populate =3D pnv_psi_populate;
+
+    dc->realize =3D pnv_psi_realize;
+    dc->props =3D pnv_psi_properties;
+}
+
+static const TypeInfo pnv_psi_info =3D {
+    .name          =3D TYPE_PNV_PSI,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(PnvPsi),
+    .instance_init =3D pnv_psi_init,
+    .class_init    =3D pnv_psi_class_init,
+    .interfaces    =3D (InterfaceInfo[]) {
+        { TYPE_PNV_XSCOM_INTERFACE },
+        { }
+    }
+};
+
+static void pnv_psi_register_types(void)
+{
+    type_register_static(&pnv_psi_info);
+}
+
+type_init(pnv_psi_register_types)
diff --git a/include/hw/ppc/pnv.h b/include/hw/ppc/pnv.h
index 96231c1..a3ed2ee 100644
--- a/include/hw/ppc/pnv.h
+++ b/include/hw/ppc/pnv.h
@@ -22,6 +22,7 @@
 #include "hw/boards.h"
 #include "hw/sysbus.h"
 #include "hw/ppc/pnv_lpc.h"
+#include "hw/ppc/pnv_psi.h"
=20
 #define TYPE_PNV_CHIP "powernv-chip"
 #define PNV_CHIP(obj) OBJECT_CHECK(PnvChip, (obj), TYPE_PNV_CHIP)
@@ -57,6 +58,7 @@ typedef struct PnvChip {
     MemoryRegion icp_mmio;
=20
     PnvLpcController lpc;
+    PnvPsi       psi;
 } PnvChip;
=20
 typedef struct PnvChipClass {
@@ -125,6 +127,7 @@ typedef struct PnvMachineState {
     PnvChip      **chips;
=20
     ISABus       *isa_bus;
+    uint32_t     cpld_irqstate;
 } PnvMachineState;
=20
 #define PNV_FDT_ADDR          0x01000000
@@ -155,4 +158,14 @@ typedef struct PnvMachineState {
 #define PNV_ICP_BASE(chip)                                              =
\
     (0x0003ffff80000000ull + (uint64_t) PNV_CHIP_INDEX(chip) * PNV_ICP_S=
IZE)
=20
+
+#define PNV_PSIHB_SIZE       0x0000000000100000ull
+#define PNV_PSIHB_BASE(chip) \
+    (0x0003fffe80000000ull + (uint64_t)PNV_CHIP_INDEX(chip) * PNV_PSIHB_=
SIZE)
+
+#define PNV_PSIHB_FSP_SIZE   0x0000000100000000ull
+#define PNV_PSIHB_FSP_BASE(chip) \
+    (0x0003ffe000000000ull + (uint64_t)PNV_CHIP_INDEX(chip) * \
+     PNV_PSIHB_FSP_SIZE)
+
 #endif /* _PPC_PNV_H */
diff --git a/include/hw/ppc/pnv_psi.h b/include/hw/ppc/pnv_psi.h
new file mode 100644
index 0000000..11d83e4
--- /dev/null
+++ b/include/hw/ppc/pnv_psi.h
@@ -0,0 +1,67 @@
+/*
+ * QEMU PowerPC PowerNV Processor Service Interface (PSI) model
+ *
+ * Copyright (c) 2015-2017, IBM Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
+ */
+#ifndef _PPC_PNV_PSI_H
+#define _PPC_PNV_PSI_H
+
+#include "hw/sysbus.h"
+#include "hw/ppc/xics.h"
+
+#define TYPE_PNV_PSI "pnv-psi"
+#define PNV_PSI(obj) \
+     OBJECT_CHECK(PnvPsi, (obj), TYPE_PNV_PSI)
+
+#define PSIHB_XSCOM_MAX         0x20
+
+typedef struct XICSState XICSState;
+
+typedef struct PnvPsi {
+    SysBusDevice parent;
+
+    MemoryRegion regs_mr;
+    uint64_t bar;
+
+    /* FSP region not supported */
+    /* MemoryRegion fsp_mr; */
+    uint64_t fsp_bar;
+
+    /* Interrupt generation */
+    ICSState ics;
+
+    /* Registers */
+    uint64_t regs[PSIHB_XSCOM_MAX];
+
+    MemoryRegion xscom_regs;
+} PnvPsi;
+
+/* The PSI and FSP interrupts are muxed on the same IRQ number */
+typedef enum PnvPsiIrq {
+    PSIHB_IRQ_PSI, /* internal use only */
+    PSIHB_IRQ_FSP, /* internal use only */
+    PSIHB_IRQ_OCC,
+    PSIHB_IRQ_FSI,
+    PSIHB_IRQ_LPC_I2C,
+    PSIHB_IRQ_LOCAL_ERR,
+    PSIHB_IRQ_EXTERNAL,
+} PnvPsiIrq;
+
+#define PSI_NUM_INTERRUPTS 6
+
+extern void pnv_psi_irq_set(PnvPsi *psi, PnvPsiIrq irq, bool state);
+
+#endif /* _PPC_PNV_PSI_H */
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 0faa184..15f7fdb 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -60,6 +60,9 @@ typedef struct PnvXScomInterfaceClass {
 #define PNV_XSCOM_LPC_BASE        0xb0020
 #define PNV_XSCOM_LPC_SIZE        0x4
=20
+#define PNV_XSCOM_PSIHB_BASE      0x2010900
+#define PNV_XSCOM_PSIHB_SIZE      0x20
+
 extern void pnv_xscom_realize(PnvChip *chip, Error **errp);
 extern int pnv_xscom_populate(PnvChip *chip, void *fdt, int offset);
=20
--=20
2.9.3
