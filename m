Received: from eggs.gnu.org ([209.51.188.92]:51658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h0crj-0001NY-Nk
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 20:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <randrianasulu@gmail.com>) id 1h0crh-0008QW-P2
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 20:58:03 -0500
From: Andrew Randrianasulu <randrianasulu@gmail.com>
Date: Mon,  4 Mar 2019 04:54:01 +0300
Message-Id: <20190304015401.14280-1-randrianasulu@gmail.com>
Subject: [Qemu-devel] [PATCH v2] Re-applying Freescale PPC E500 i2c/RTC patch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, qemu-devel@nongnu.org
Cc: Amit Singh Tomar <amit.tomar@freescale.com>, Andrew Randrianasulu <randrianasulu@gmail.com>

From: Amit Singh Tomar <amit.tomar@freescale.com>

Original commit message:
This patch adds an emulation model for i2c controller found on most of the FSL SoCs.
It also integrates the RTC (ds1338) that sits on the i2c Bus with e500 machine model.

Patch was originally written by Amit Singh Tomar <amit.tomar@freescale.com>
see http://patchwork.ozlabs.org/patch/431475/
I only fixed it enough for application on top of current qemu master
20b084c4b1401b7f8fbc385649d48c67b6f43d44, and hopefully fixed checkpatch errors

Tested by booting Linux kernel 4.20.12. Now e500 machine doesn't need 
network time protocol daemon because it will have working RTC 
(before all timestamps on files were from 2016)

---

v1->v2: Expanded and fixed commit message


Signed-off-by: Andrew Randrianasulu <randrianasulu@gmail.com>
---
 default-configs/ppc-softmmu.mak |   2 +
 hw/i2c/Makefile.objs            |   1 +
 hw/i2c/mpc_i2c.c                | 357 ++++++++++++++++++++++++++++++++++++++++
 hw/ppc/e500.c                   |  54 ++++++
 4 files changed, 414 insertions(+)
 create mode 100644 hw/i2c/mpc_i2c.c

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 52acb7cf39..a560971f0c 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -8,6 +8,8 @@ include usb.mak
 CONFIG_PPC4XX=y
 CONFIG_M48T59=y
 CONFIG_SERIAL=y
+CONFIG_MPC_I2C=y
+CONFIG_DS1338=y
 CONFIG_I8257=y
 CONFIG_OPENPIC=y
 CONFIG_PPCE500_PCI=y
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index 9205cbee16..3eb584254f 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -9,5 +9,6 @@ common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
 common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_i2c.o
 common-obj-$(CONFIG_NRF51_SOC) += microbit_i2c.o
+common-obj-$(CONFIG_MPC_I2C) += mpc_i2c.o
 obj-$(CONFIG_OMAP) += omap_i2c.o
 obj-$(CONFIG_PPC4XX) += ppc4xx_i2c.o
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
new file mode 100644
index 0000000000..693ca7ef6b
--- /dev/null
+++ b/hw/i2c/mpc_i2c.c
@@ -0,0 +1,357 @@
+/*
+ * Copyright (C) 2014 Freescale Semiconductor, Inc. All rights reserved.
+ *
+ * Author: Amit Tomar, <Amit.Tomar@freescale.com>
+ *
+ * Description:
+ * This file is derived from IMX I2C controller,
+ * by Jean-Christophe DUBOIS .
+ *
+ * Thanks to Scott Wood and Alexander Graf for their kind help on this.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License, version 2 or later,
+ * as published by the Free Software Foundation.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/i2c/i2c.h"
+#include "qemu/log.h"
+#include "hw/sysbus.h"
+
+/* #define DEBUG_I2C */
+
+#ifdef DEBUG_I2C
+#define DPRINTF(fmt, ...)              \
+    do { fprintf(stderr, "mpc_i2c[%s]: " fmt, __func__, ## __VA_ARGS__); \
+    } while (0)
+#else
+#define DPRINTF(fmt, ...) do {} while (0)
+#endif
+
+#define TYPE_MPC_I2C "mpc-i2c"
+#define MPC_I2C(obj) \
+    OBJECT_CHECK(MPCI2CState, (obj), TYPE_MPC_I2C)
+
+#define MPC_I2C_ADR   0x00
+#define MPC_I2C_FDR   0x04
+#define MPC_I2C_CR    0x08
+#define MPC_I2C_SR    0x0c
+#define MPC_I2C_DR    0x10
+#define MPC_I2C_DFSRR 0x14
+
+#define CCR_MEN  (1 << 7)
+#define CCR_MIEN (1 << 6)
+#define CCR_MSTA (1 << 5)
+#define CCR_MTX  (1 << 4)
+#define CCR_TXAK (1 << 3)
+#define CCR_RSTA (1 << 2)
+#define CCR_BCST (1 << 0)
+
+#define CSR_MCF  (1 << 7)
+#define CSR_MAAS (1 << 6)
+#define CSR_MBB  (1 << 5)
+#define CSR_MAL  (1 << 4)
+#define CSR_SRW  (1 << 2)
+#define CSR_MIF  (1 << 1)
+#define CSR_RXAK (1 << 0)
+
+#define CADR_MASK 0xFE
+#define CFDR_MASK 0x3F
+#define CCR_MASK  0xFC
+#define CSR_MASK  0xED
+#define CDR_MASK  0xFF
+
+#define CYCLE_RESET 0xFF
+
+typedef struct MPCI2CState {
+    SysBusDevice parent_obj;
+
+    I2CBus *bus;
+    qemu_irq irq;
+    MemoryRegion iomem;
+
+    uint8_t address;
+    uint8_t adr;
+    uint8_t fdr;
+    uint8_t cr;
+    uint8_t sr;
+    uint8_t dr;
+    uint8_t dfssr;
+} MPCI2CState;
+
+static bool mpc_i2c_is_enabled(MPCI2CState *s)
+{
+    return s->cr & CCR_MEN;
+}
+
+static bool mpc_i2c_is_master(MPCI2CState *s)
+{
+    return s->cr & CCR_MSTA;
+}
+
+static bool mpc_i2c_direction_is_tx(MPCI2CState *s)
+{
+    return s->cr & CCR_MTX;
+}
+
+static bool mpc_i2c_irq_pending(MPCI2CState *s)
+{
+    return s->sr & CSR_MIF;
+}
+
+static bool mpc_i2c_irq_is_enabled(MPCI2CState *s)
+{
+    return s->cr & CCR_MIEN;
+}
+
+static void mpc_i2c_reset(DeviceState *dev)
+{
+    MPCI2CState *i2c = MPC_I2C(dev);
+
+    i2c->address = 0xFF;
+    i2c->adr = 0x00;
+    i2c->fdr = 0x00;
+    i2c->cr =  0x00;
+    i2c->sr =  0x81;
+    i2c->dr =  0x00;
+}
+
+static void mpc_i2c_irq(MPCI2CState *s)
+{
+    bool irq_active = false;
+
+    if (mpc_i2c_is_enabled(s) && mpc_i2c_irq_is_enabled(s)
+                              && mpc_i2c_irq_pending(s)) {
+        irq_active = true;
+    }
+
+    if (irq_active) {
+        qemu_irq_raise(s->irq);
+    } else {
+        qemu_irq_lower(s->irq);
+    }
+}
+
+static void mpc_i2c_soft_reset(MPCI2CState *s)
+{
+    /* This is a soft reset. ADR is preserved during soft resets */
+    uint8_t adr = s->adr;
+    mpc_i2c_reset(DEVICE(s));
+    s->adr = adr;
+}
+
+static void  mpc_i2c_address_send(MPCI2CState *s)
+{
+    /* if returns non zero slave address is not right */
+    if (i2c_start_transfer(s->bus, s->dr >> 1, s->dr & (0x01))) {
+        s->sr |= CSR_RXAK;
+    } else {
+        s->address = s->dr;
+        s->sr &= ~CSR_RXAK;
+        s->sr |=  CSR_MCF; /* Set after Byte Transfer is completed */
+        s->sr |=  CSR_MIF; /* Set after Byte Transfer is completed */
+        mpc_i2c_irq(s);
+    }
+}
+
+static void  mpc_i2c_data_send(MPCI2CState *s)
+{
+    if (i2c_send(s->bus, s->dr)) {
+        /* End of transfer */
+        s->sr |= CSR_RXAK;
+        i2c_end_transfer(s->bus);
+    } else {
+        s->sr &= ~CSR_RXAK;
+        s->sr |=  CSR_MCF; /* Set after Byte Transfer is completed */
+        s->sr |=  CSR_MIF; /* Set after Byte Transfer is completed */
+        mpc_i2c_irq(s);
+    }
+}
+
+static void  mpc_i2c_data_recive(MPCI2CState *s)
+{
+    int ret;
+    /* get the next byte */
+    ret = i2c_recv(s->bus);
+    if (ret >= 0) {
+        s->sr |= CSR_MCF; /* Set after Byte Transfer is completed */
+        s->sr |= CSR_MIF; /* Set after Byte Transfer is completed */
+        mpc_i2c_irq(s);
+    } else {
+        DPRINTF("read failed for device");
+        ret = 0xff;
+    }
+    s->dr = ret;
+}
+
+static uint64_t mpc_i2c_read(void *opaque, hwaddr addr, unsigned size)
+{
+    MPCI2CState *s = opaque;
+    uint8_t value;
+
+    switch (addr) {
+    case MPC_I2C_ADR:
+        value = s->adr;
+        break;
+    case MPC_I2C_FDR:
+        value = s->fdr;
+        break;
+    case MPC_I2C_CR:
+        value = s->cr;
+        break;
+    case MPC_I2C_SR:
+        value = s->sr;
+        break;
+    case MPC_I2C_DR:
+        value = s->dr;
+        if (mpc_i2c_is_master(s)) { /* master mode */
+            if (mpc_i2c_direction_is_tx(s)) {
+                DPRINTF("MTX is set not in recv mode\n");
+            } else {
+                mpc_i2c_data_recive(s);
+            }
+        }
+        break;
+    default:
+        value = 0;
+        DPRINTF("ERROR: Bad read addr 0x%x\n", (unsigned int)addr);
+        break;
+    }
+
+    DPRINTF("%s: addr " TARGET_FMT_plx " %02" PRIx32 "\n", __func__,
+                                         addr, value);
+    return (uint64_t)value;
+}
+
+static void mpc_i2c_write(void *opaque, hwaddr addr,
+                            uint64_t value, unsigned size)
+{
+    MPCI2CState *s = opaque;
+
+    DPRINTF("%s: addr " TARGET_FMT_plx " val %08" PRIx64 "\n", __func__,
+                                             addr, value);
+    switch (addr) {
+    case MPC_I2C_ADR:
+        s->adr = value & CADR_MASK;
+        break;
+    case MPC_I2C_FDR:
+        s->fdr = value & CFDR_MASK;
+        break;
+    case MPC_I2C_CR:
+        if (mpc_i2c_is_enabled(s) && ((value & CCR_MEN) == 0)) {
+            mpc_i2c_soft_reset(s);
+            break;
+        }
+        /* normal write */
+        s->cr = value & CCR_MASK;
+        if (mpc_i2c_is_master(s)) { /* master mode */
+            /* set the bus to busy after master is set as per RM */
+            s->sr |= CSR_MBB;
+        } else {
+            /* bus is not busy anymore */
+            s->sr &= ~CSR_MBB;
+            /* Reset the address for fresh write/read cycle */
+        if (s->address != CYCLE_RESET) {
+            i2c_end_transfer(s->bus);
+            s->address = CYCLE_RESET;
+            }
+        }
+        /* For restart end the onging transfer */
+        if (s->cr & CCR_RSTA) {
+            if (s->address != CYCLE_RESET) {
+                s->address = CYCLE_RESET;
+                i2c_end_transfer(s->bus);
+                s->cr &= ~CCR_RSTA;
+            }
+        }
+        break;
+    case MPC_I2C_SR:
+        s->sr = value & CSR_MASK;
+        /* Lower the interrupt */
+        if (!(s->sr & CSR_MIF) || !(s->sr & CSR_MAL)) {
+            mpc_i2c_irq(s);
+        }
+        break;
+    case MPC_I2C_DR:
+        /* if the device is not enabled, nothing to do */
+        if (!mpc_i2c_is_enabled(s)) {
+            break;
+        }
+        s->dr = value & CDR_MASK;
+        if (mpc_i2c_is_master(s)) { /* master mode */
+            if (s->address == CYCLE_RESET) {
+                mpc_i2c_address_send(s);
+            } else {
+                mpc_i2c_data_send(s);
+            }
+        }
+        break;
+    case MPC_I2C_DFSRR:
+        s->dfssr = value;
+        break;
+    default:
+        DPRINTF("ERROR: Bad write addr 0x%x\n", (unsigned int)addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps i2c_ops = {
+    .read =  mpc_i2c_read,
+    .write =  mpc_i2c_write,
+    .valid.max_access_size = 1,
+    .endianness = DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription mpc_i2c_vmstate = {
+    .name = TYPE_MPC_I2C,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT8(address, MPCI2CState),
+        VMSTATE_UINT8(adr, MPCI2CState),
+        VMSTATE_UINT8(fdr, MPCI2CState),
+        VMSTATE_UINT8(cr, MPCI2CState),
+        VMSTATE_UINT8(sr, MPCI2CState),
+        VMSTATE_UINT8(dr, MPCI2CState),
+        VMSTATE_UINT8(dfssr, MPCI2CState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void mpc_i2c_realize(DeviceState *dev, Error **errp)
+{
+    MPCI2CState  *i2c = MPC_I2C(dev);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &i2c->irq);
+    memory_region_init_io(&i2c->iomem, OBJECT(i2c), &i2c_ops, i2c,
+                          "mpc-i2c", 0x14);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &i2c->iomem);
+    i2c->bus = i2c_init_bus(DEVICE(dev), "i2c");
+}
+
+static void mpc_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd  = &mpc_i2c_vmstate ;
+    dc->reset = mpc_i2c_reset;
+    dc->realize = mpc_i2c_realize;
+    dc->desc = "MPC I2C Controller";
+}
+
+static const TypeInfo mpc_i2c_type_info = {
+    .name          = TYPE_MPC_I2C,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(MPCI2CState),
+    .class_init    = mpc_i2c_class_init,
+};
+
+static void mpc_i2c_register_types(void)
+{
+    type_register_static(&mpc_i2c_type_info);
+}
+
+type_init(mpc_i2c_register_types)
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 7553f674c9..beb2efd694 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -42,6 +42,7 @@
 #include "qemu/error-report.h"
 #include "hw/platform-bus.h"
 #include "hw/net/fsl_etsec/etsec.h"
+#include "hw/i2c/i2c.h"
 
 #define EPAPR_MAGIC                (0x45504150)
 #define BINARY_DEVICE_TREE_FILE    "mpc8544ds.dtb"
@@ -63,7 +64,10 @@
 #define MPC8544_PCI_REGS_SIZE      0x1000ULL
 #define MPC8544_UTIL_OFFSET        0xe0000ULL
 #define MPC8XXX_GPIO_OFFSET        0x000FF000ULL
+#define MPC8544_I2C_REGS_OFFSET    0x3000ULL
 #define MPC8XXX_GPIO_IRQ           47
+#define MPC8544_I2C_IRQ            43
+#define RTC_REGS_OFFSET            0x68
 
 struct boot_info
 {
@@ -161,6 +165,39 @@ static void create_dt_mpc8xxx_gpio(void *fdt, const char *soc, const char *mpic)
     g_free(poweroff);
 }
 
+static void dt_rtc_create(void *fdt, const char *i2c, const char *alias)
+{
+    int offset = RTC_REGS_OFFSET;
+
+    gchar *rtc = g_strdup_printf("%s/rtc@%"PRIx32, i2c, offset);
+    qemu_fdt_add_subnode(fdt, rtc);
+    qemu_fdt_setprop_string(fdt, rtc, "compatible", "pericom,pt7c4338");
+    qemu_fdt_setprop_cells(fdt, rtc, "reg", offset);
+    qemu_fdt_setprop_string(fdt, "/aliases", alias, rtc);
+
+    g_free(rtc);
+}
+
+static void dt_i2c_create(void *fdt, const char *soc, const char *mpic,
+                             const char *alias)
+{
+    hwaddr mmio0 = MPC8544_I2C_REGS_OFFSET;
+    int irq0 = MPC8544_I2C_IRQ;
+
+    gchar *i2c = g_strdup_printf("%s/i2c@%"PRIx64, soc, mmio0);
+    qemu_fdt_add_subnode(fdt, i2c);
+    qemu_fdt_setprop_string(fdt, i2c, "device_type", "i2c");
+    qemu_fdt_setprop_string(fdt, i2c, "compatible", "fsl-i2c");
+    qemu_fdt_setprop_cells(fdt, i2c, "reg", mmio0, 0x14);
+    qemu_fdt_setprop_cells(fdt, i2c, "cell-index", 0);
+    qemu_fdt_setprop_cells(fdt, i2c, "interrupts", irq0, 0x2);
+    qemu_fdt_setprop_phandle(fdt, i2c, "interrupt-parent", mpic);
+    qemu_fdt_setprop_string(fdt, "/aliases", alias, i2c);
+
+    g_free(i2c);
+}
+
+
 typedef struct PlatformDevtreeData {
     void *fdt;
     const char *mpic;
@@ -464,6 +501,12 @@ static int ppce500_load_device_tree(PPCE500MachineState *pms,
                          soc, mpic, "serial0", 0, true);
     }
 
+    /* i2c */
+    dt_i2c_create(fdt, soc, mpic, "i2c");
+
+    dt_rtc_create(fdt, "i2c", "rtc");
+
+
     gutil = g_strdup_printf("%s/global-utilities@%llx", soc,
                             MPC8544_UTIL_OFFSET);
     qemu_fdt_add_subnode(fdt, gutil);
@@ -812,6 +855,7 @@ void ppce500_init(MachineState *machine)
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
     PPCE500CCSRState *ccsr;
+    I2CBus *i2c;
 
     irqs = g_new0(IrqLines, smp_cpus);
     for (i = 0; i < smp_cpus; i++) {
@@ -887,6 +931,16 @@ void ppce500_init(MachineState *machine)
                        0, qdev_get_gpio_in(mpicdev, 42), 399193,
                        serial_hd(1), DEVICE_BIG_ENDIAN);
     }
+        /* I2C */
+    dev = qdev_create(NULL, "mpc-i2c");
+    s = SYS_BUS_DEVICE(dev);
+    qdev_init_nofail(dev);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8544_I2C_IRQ));
+    memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET,
+                                sysbus_mmio_get_region(s, 0));
+    i2c = (I2CBus *)qdev_get_child_bus(dev, "i2c");
+    i2c_create_slave(i2c, "ds1338", RTC_REGS_OFFSET);
+
 
     /* General Utility device */
     dev = qdev_create(NULL, "mpc8544-guts");
-- 
2.14.4
