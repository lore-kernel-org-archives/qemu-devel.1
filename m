Received: from eggs.gnu.org ([209.51.188.92]:42733)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to4-0000sI-9s
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h2to1-0001Fu-CE
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:27:40 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Sun, 10 Mar 2019 19:26:23 +1100
Message-Id: <20190310082703.1245-21-david@gibson.dropbear.id.au>
In-Reply-To: <20190310082703.1245-1-david@gibson.dropbear.id.au>
References: <20190310082703.1245-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 20/60] PPC: E500: Add FSL I2C controller and
 integrate RTC with it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, lvivier@redhat.com, Andrew Randrianasulu <randrianasulu@gmail.com>, Amit Singh Tomar <amit.tomar@freescale.com>, David Gibson <david@gibson.dropbear.id.au>

From: Andrew Randrianasulu <randrianasulu@gmail.com>

Original commit message:
This patch adds an emulation model for i2c controller found on most of th=
e FSL SoCs.
It also integrates the RTC (ds1338) that sits on the i2c Bus with e500 ma=
chine model.

Patch was originally written by Amit Singh Tomar <amit.tomar@freescale.co=
m>
see http://patchwork.ozlabs.org/patch/431475/
I only fixed it enough for application on top of current qemu master
20b084c4b1401b7f8fbc385649d48c67b6f43d44, and hopefully fixed checkpatch =
errors

Tested by booting Linux kernel 4.20.12. Now e500 machine doesn't need
network time protocol daemon because it will have working RTC
(before all timestamps on files were from 2016)

Signed-off-by: Amit Singh Tomar <amit.tomar@freescale.com>
Signed-off-by: Andrew Randrianasulu <randrianasulu@gmail.com>
Message-Id: <20190306102812.28972-1-randrianasulu@gmail.com>
[dwg: Add Kconfig stanza to define the new symbol]
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 default-configs/ppc-softmmu.mak |   2 +
 hw/i2c/Kconfig                  |   4 +
 hw/i2c/Makefile.objs            |   1 +
 hw/i2c/mpc_i2c.c                | 357 ++++++++++++++++++++++++++++++++
 hw/ppc/e500.c                   |  54 +++++
 5 files changed, 418 insertions(+)
 create mode 100644 hw/i2c/mpc_i2c.c

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
index 6ea36d4090..bf86128a0c 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,6 +1,8 @@
 # Default configuration for ppc-softmmu
=20
 # For embedded PPCs:
+CONFIG_MPC_I2C=3Dy
+CONFIG_DS1338=3Dy
 CONFIG_E500=3Dy
 CONFIG_PPC405=3Dy
 CONFIG_PPC440=3Dy
diff --git a/hw/i2c/Kconfig b/hw/i2c/Kconfig
index ef1caa6d89..820b24de5b 100644
--- a/hw/i2c/Kconfig
+++ b/hw/i2c/Kconfig
@@ -25,3 +25,7 @@ config BITBANG_I2C
 config IMX_I2C
     bool
     select I2C
+
+config MPC_I2C
+    bool
+    select I2C
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index 2a3c106551..5f76b6a990 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -9,5 +9,6 @@ common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_i2c.o
 common-obj-$(CONFIG_IMX_I2C) +=3D imx_i2c.o
 common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_i2c.o
 common-obj-$(CONFIG_NRF51_SOC) +=3D microbit_i2c.o
+common-obj-$(CONFIG_MPC_I2C) +=3D mpc_i2c.o
 obj-$(CONFIG_OMAP) +=3D omap_i2c.o
 obj-$(CONFIG_PPC4XX) +=3D ppc4xx_i2c.o
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
+ * it under the terms of the GNU General Public License, version 2 or la=
ter,
+ * as published by the Free Software Foundation.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
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
+    do { fprintf(stderr, "mpc_i2c[%s]: " fmt, __func__, ## __VA_ARGS__);=
 \
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
+    MPCI2CState *i2c =3D MPC_I2C(dev);
+
+    i2c->address =3D 0xFF;
+    i2c->adr =3D 0x00;
+    i2c->fdr =3D 0x00;
+    i2c->cr =3D  0x00;
+    i2c->sr =3D  0x81;
+    i2c->dr =3D  0x00;
+}
+
+static void mpc_i2c_irq(MPCI2CState *s)
+{
+    bool irq_active =3D false;
+
+    if (mpc_i2c_is_enabled(s) && mpc_i2c_irq_is_enabled(s)
+                              && mpc_i2c_irq_pending(s)) {
+        irq_active =3D true;
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
+    uint8_t adr =3D s->adr;
+    mpc_i2c_reset(DEVICE(s));
+    s->adr =3D adr;
+}
+
+static void  mpc_i2c_address_send(MPCI2CState *s)
+{
+    /* if returns non zero slave address is not right */
+    if (i2c_start_transfer(s->bus, s->dr >> 1, s->dr & (0x01))) {
+        s->sr |=3D CSR_RXAK;
+    } else {
+        s->address =3D s->dr;
+        s->sr &=3D ~CSR_RXAK;
+        s->sr |=3D  CSR_MCF; /* Set after Byte Transfer is completed */
+        s->sr |=3D  CSR_MIF; /* Set after Byte Transfer is completed */
+        mpc_i2c_irq(s);
+    }
+}
+
+static void  mpc_i2c_data_send(MPCI2CState *s)
+{
+    if (i2c_send(s->bus, s->dr)) {
+        /* End of transfer */
+        s->sr |=3D CSR_RXAK;
+        i2c_end_transfer(s->bus);
+    } else {
+        s->sr &=3D ~CSR_RXAK;
+        s->sr |=3D  CSR_MCF; /* Set after Byte Transfer is completed */
+        s->sr |=3D  CSR_MIF; /* Set after Byte Transfer is completed */
+        mpc_i2c_irq(s);
+    }
+}
+
+static void  mpc_i2c_data_recive(MPCI2CState *s)
+{
+    int ret;
+    /* get the next byte */
+    ret =3D i2c_recv(s->bus);
+    if (ret >=3D 0) {
+        s->sr |=3D CSR_MCF; /* Set after Byte Transfer is completed */
+        s->sr |=3D CSR_MIF; /* Set after Byte Transfer is completed */
+        mpc_i2c_irq(s);
+    } else {
+        DPRINTF("read failed for device");
+        ret =3D 0xff;
+    }
+    s->dr =3D ret;
+}
+
+static uint64_t mpc_i2c_read(void *opaque, hwaddr addr, unsigned size)
+{
+    MPCI2CState *s =3D opaque;
+    uint8_t value;
+
+    switch (addr) {
+    case MPC_I2C_ADR:
+        value =3D s->adr;
+        break;
+    case MPC_I2C_FDR:
+        value =3D s->fdr;
+        break;
+    case MPC_I2C_CR:
+        value =3D s->cr;
+        break;
+    case MPC_I2C_SR:
+        value =3D s->sr;
+        break;
+    case MPC_I2C_DR:
+        value =3D s->dr;
+        if (mpc_i2c_is_master(s)) { /* master mode */
+            if (mpc_i2c_direction_is_tx(s)) {
+                DPRINTF("MTX is set not in recv mode\n");
+            } else {
+                mpc_i2c_data_recive(s);
+            }
+        }
+        break;
+    default:
+        value =3D 0;
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
+    MPCI2CState *s =3D opaque;
+
+    DPRINTF("%s: addr " TARGET_FMT_plx " val %08" PRIx64 "\n", __func__,
+                                             addr, value);
+    switch (addr) {
+    case MPC_I2C_ADR:
+        s->adr =3D value & CADR_MASK;
+        break;
+    case MPC_I2C_FDR:
+        s->fdr =3D value & CFDR_MASK;
+        break;
+    case MPC_I2C_CR:
+        if (mpc_i2c_is_enabled(s) && ((value & CCR_MEN) =3D=3D 0)) {
+            mpc_i2c_soft_reset(s);
+            break;
+        }
+        /* normal write */
+        s->cr =3D value & CCR_MASK;
+        if (mpc_i2c_is_master(s)) { /* master mode */
+            /* set the bus to busy after master is set as per RM */
+            s->sr |=3D CSR_MBB;
+        } else {
+            /* bus is not busy anymore */
+            s->sr &=3D ~CSR_MBB;
+            /* Reset the address for fresh write/read cycle */
+        if (s->address !=3D CYCLE_RESET) {
+            i2c_end_transfer(s->bus);
+            s->address =3D CYCLE_RESET;
+            }
+        }
+        /* For restart end the onging transfer */
+        if (s->cr & CCR_RSTA) {
+            if (s->address !=3D CYCLE_RESET) {
+                s->address =3D CYCLE_RESET;
+                i2c_end_transfer(s->bus);
+                s->cr &=3D ~CCR_RSTA;
+            }
+        }
+        break;
+    case MPC_I2C_SR:
+        s->sr =3D value & CSR_MASK;
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
+        s->dr =3D value & CDR_MASK;
+        if (mpc_i2c_is_master(s)) { /* master mode */
+            if (s->address =3D=3D CYCLE_RESET) {
+                mpc_i2c_address_send(s);
+            } else {
+                mpc_i2c_data_send(s);
+            }
+        }
+        break;
+    case MPC_I2C_DFSRR:
+        s->dfssr =3D value;
+        break;
+    default:
+        DPRINTF("ERROR: Bad write addr 0x%x\n", (unsigned int)addr);
+        break;
+    }
+}
+
+static const MemoryRegionOps i2c_ops =3D {
+    .read =3D  mpc_i2c_read,
+    .write =3D  mpc_i2c_write,
+    .valid.max_access_size =3D 1,
+    .endianness =3D DEVICE_NATIVE_ENDIAN,
+};
+
+static const VMStateDescription mpc_i2c_vmstate =3D {
+    .name =3D TYPE_MPC_I2C,
+    .version_id =3D 1,
+    .minimum_version_id =3D 1,
+    .fields =3D (VMStateField[]) {
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
+    MPCI2CState  *i2c =3D MPC_I2C(dev);
+    sysbus_init_irq(SYS_BUS_DEVICE(dev), &i2c->irq);
+    memory_region_init_io(&i2c->iomem, OBJECT(i2c), &i2c_ops, i2c,
+                          "mpc-i2c", 0x14);
+    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &i2c->iomem);
+    i2c->bus =3D i2c_init_bus(DEVICE(dev), "i2c");
+}
+
+static void mpc_i2c_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc =3D DEVICE_CLASS(klass);
+
+    dc->vmsd  =3D &mpc_i2c_vmstate ;
+    dc->reset =3D mpc_i2c_reset;
+    dc->realize =3D mpc_i2c_realize;
+    dc->desc =3D "MPC I2C Controller";
+}
+
+static const TypeInfo mpc_i2c_type_info =3D {
+    .name          =3D TYPE_MPC_I2C,
+    .parent        =3D TYPE_SYS_BUS_DEVICE,
+    .instance_size =3D sizeof(MPCI2CState),
+    .class_init    =3D mpc_i2c_class_init,
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
=20
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
=20
 struct boot_info
 {
@@ -161,6 +165,39 @@ static void create_dt_mpc8xxx_gpio(void *fdt, const =
char *soc, const char *mpic)
     g_free(poweroff);
 }
=20
+static void dt_rtc_create(void *fdt, const char *i2c, const char *alias)
+{
+    int offset =3D RTC_REGS_OFFSET;
+
+    gchar *rtc =3D g_strdup_printf("%s/rtc@%"PRIx32, i2c, offset);
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
+    hwaddr mmio0 =3D MPC8544_I2C_REGS_OFFSET;
+    int irq0 =3D MPC8544_I2C_IRQ;
+
+    gchar *i2c =3D g_strdup_printf("%s/i2c@%"PRIx64, soc, mmio0);
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
@@ -464,6 +501,12 @@ static int ppce500_load_device_tree(PPCE500MachineSt=
ate *pms,
                          soc, mpic, "serial0", 0, true);
     }
=20
+    /* i2c */
+    dt_i2c_create(fdt, soc, mpic, "i2c");
+
+    dt_rtc_create(fdt, "i2c", "rtc");
+
+
     gutil =3D g_strdup_printf("%s/global-utilities@%llx", soc,
                             MPC8544_UTIL_OFFSET);
     qemu_fdt_add_subnode(fdt, gutil);
@@ -812,6 +855,7 @@ void ppce500_init(MachineState *machine)
     MemoryRegion *ccsr_addr_space;
     SysBusDevice *s;
     PPCE500CCSRState *ccsr;
+    I2CBus *i2c;
=20
     irqs =3D g_new0(IrqLines, smp_cpus);
     for (i =3D 0; i < smp_cpus; i++) {
@@ -887,6 +931,16 @@ void ppce500_init(MachineState *machine)
                        0, qdev_get_gpio_in(mpicdev, 42), 399193,
                        serial_hd(1), DEVICE_BIG_ENDIAN);
     }
+        /* I2C */
+    dev =3D qdev_create(NULL, "mpc-i2c");
+    s =3D SYS_BUS_DEVICE(dev);
+    qdev_init_nofail(dev);
+    sysbus_connect_irq(s, 0, qdev_get_gpio_in(mpicdev, MPC8544_I2C_IRQ))=
;
+    memory_region_add_subregion(ccsr_addr_space, MPC8544_I2C_REGS_OFFSET=
,
+                                sysbus_mmio_get_region(s, 0));
+    i2c =3D (I2CBus *)qdev_get_child_bus(dev, "i2c");
+    i2c_create_slave(i2c, "ds1338", RTC_REGS_OFFSET);
+
=20
     /* General Utility device */
     dev =3D qdev_create(NULL, "mpc8544-guts");
--=20
2.20.1
