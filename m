Received: from eggs.gnu.org ([2001:4830:134:3::10]:48778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gAQZu-0002JU-U0
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:19:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gAQZs-0004Sz-Td
	for qemu-devel@nongnu.org; Wed, 10 Oct 2018 22:19:54 -0400
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Thu, 11 Oct 2018 04:19:30 +0200
Message-Id: <20181011021931.4249-12-edgar.iglesias@gmail.com>
In-Reply-To: <20181011021931.4249-1-edgar.iglesias@gmail.com>
References: <20181011021931.4249-1-edgar.iglesias@gmail.com>
Subject: [Qemu-devel] [PATCH v2 11/12] hw/arm: versal: Add a model of Xilinx
 Versal SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add a model of Xilinx Versal SoC.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 default-configs/aarch64-softmmu.mak |   1 +
 hw/arm/Makefile.objs                |   1 +
 hw/arm/xlnx-versal.c                | 324 ++++++++++++++++++++++++++++
 include/hw/arm/xlnx-versal.h        | 122 +++++++++++
 4 files changed, 448 insertions(+)
 create mode 100644 hw/arm/xlnx-versal.c
 create mode 100644 include/hw/arm/xlnx-versal.h

diff --git a/default-configs/aarch64-softmmu.mak b/default-configs/aarch64-softmmu.mak
index 6f790f061a..4ea9add003 100644
--- a/default-configs/aarch64-softmmu.mak
+++ b/default-configs/aarch64-softmmu.mak
@@ -8,4 +8,5 @@ CONFIG_DDC=y
 CONFIG_DPCD=y
 CONFIG_XLNX_ZYNQMP=y
 CONFIG_XLNX_ZYNQMP_ARM=y
+CONFIG_XLNX_VERSAL=y
 CONFIG_ARM_SMMUV3=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 5f88062c66..ec21d9bc1f 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -26,6 +26,7 @@ obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
 obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
 obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
+obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o
 obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
 obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
 obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
new file mode 100644
index 0000000000..f2145fd6a1
--- /dev/null
+++ b/hw/arm/xlnx-versal.c
@@ -0,0 +1,324 @@
+/*
+ * Xilinx Versal SoC model.
+ *
+ * Copyright (c) 2018 Xilinx Inc.
+ * Written by Edgar E. Iglesias
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or
+ * (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "hw/sysbus.h"
+#include "net/net.h"
+#include "sysemu/sysemu.h"
+#include "sysemu/kvm.h"
+#include "hw/arm/arm.h"
+#include "kvm_arm.h"
+#include "hw/misc/unimp.h"
+#include "hw/intc/arm_gicv3_common.h"
+#include "hw/arm/xlnx-versal.h"
+
+#define XLNX_VERSAL_ACPU_TYPE ARM_CPU_TYPE_NAME("cortex-a72")
+#define GEM_REVISION        0x40070106
+
+static void versal_create_apu_cpus(Versal *s, Error **errp)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->fpd.apu.cpu); i++) {
+        Object *obj;
+        char *name;
+
+        obj = object_new(XLNX_VERSAL_ACPU_TYPE);
+        if (!obj) {
+            /* Secondary CPUs start in PSCI powered-down state */
+            error_setg(errp, "Unable to create apu.cpu[%d] of type %s",
+                       i, XLNX_VERSAL_ACPU_TYPE);
+            return;
+        }
+
+        name = g_strdup_printf("apu-cpu[%d]", i);
+        object_property_add_child(OBJECT(s), name, obj, &error_fatal);
+        g_free(name);
+
+        object_property_set_int(obj, s->cfg.psci_conduit,
+                                "psci-conduit", &error_abort);
+        if (i) {
+            object_property_set_bool(obj, true,
+                                     "start-powered-off", &error_abort);
+        }
+
+        object_property_set_int(obj, ARRAY_SIZE(s->fpd.apu.cpu),
+                                "core-count", &error_abort);
+        object_property_set_link(obj, OBJECT(&s->fpd.apu.mr), "memory",
+                                 &error_abort);
+        object_property_set_bool(obj, true, "realized", &error_fatal);
+        s->fpd.apu.cpu[i] = ARM_CPU(obj);
+    }
+}
+
+static void versal_create_apu_gic(Versal *s, qemu_irq *pic, Error **errp)
+{
+    static const uint64_t addrs[] = {
+        MM_GIC_APU_DIST_MAIN,
+        MM_GIC_APU_REDIST_0
+    };
+    SysBusDevice *gicbusdev;
+    DeviceState *gicdev;
+    int nr_apu_cpus = ARRAY_SIZE(s->fpd.apu.cpu);
+    int i;
+
+    sysbus_init_child_obj(OBJECT(s), "apu-gic",
+                          &s->fpd.apu.gic, sizeof(s->fpd.apu.gic),
+                          gicv3_class_name());
+    gicbusdev = SYS_BUS_DEVICE(&s->fpd.apu.gic);
+    gicdev = DEVICE(&s->fpd.apu.gic);
+    qdev_prop_set_uint32(gicdev, "revision", 3);
+    qdev_prop_set_uint32(gicdev, "num-cpu", 2);
+    qdev_prop_set_uint32(gicdev, "num-irq", XLNX_VERSAL_NR_IRQS + 32);
+    qdev_prop_set_uint32(gicdev, "len-redist-region-count", 1);
+    qdev_prop_set_uint32(gicdev, "redist-region-count[0]", 2);
+    if (!kvm_irqchip_in_kernel()) {
+        qdev_prop_set_bit(gicdev, "has-security-extensions", true);
+    }
+
+    object_property_set_bool(OBJECT(&s->fpd.apu.gic), true, "realized", errp);
+
+    for (i = 0; i < ARRAY_SIZE(addrs); i++) {
+        MemoryRegion *mr;
+
+        mr = sysbus_mmio_get_region(gicbusdev, i);
+        memory_region_add_subregion(&s->fpd.apu.mr, addrs[i], mr);
+    }
+
+    for (i = 0; i < nr_apu_cpus; i++) {
+        DeviceState *cpudev = DEVICE(s->fpd.apu.cpu[i]);
+        int ppibase = XLNX_VERSAL_NR_IRQS + i * GIC_INTERNAL + GIC_NR_SGIS;
+        qemu_irq maint_irq;
+        int ti;
+        /* Mapping from the output timer irq lines from the CPU to the
+         * GIC PPI inputs.
+         */
+        const int timer_irq[] = {
+            [GTIMER_PHYS] = VERSAL_TIMER_NS_EL1_IRQ,
+            [GTIMER_VIRT] = VERSAL_TIMER_VIRT_IRQ,
+            [GTIMER_HYP]  = VERSAL_TIMER_NS_EL2_IRQ,
+            [GTIMER_SEC]  = VERSAL_TIMER_S_EL1_IRQ,
+        };
+
+        for (ti = 0; ti < ARRAY_SIZE(timer_irq); ti++) {
+            qdev_connect_gpio_out(cpudev, ti,
+                                  qdev_get_gpio_in(gicdev,
+                                                   ppibase + timer_irq[ti]));
+        }
+        maint_irq = qdev_get_gpio_in(gicdev,
+                                        ppibase + VERSAL_GIC_MAINT_IRQ);
+        qdev_connect_gpio_out_named(cpudev, "gicv3-maintenance-interrupt",
+                                    0, maint_irq);
+        sysbus_connect_irq(gicbusdev, i, qdev_get_gpio_in(cpudev, ARM_CPU_IRQ));
+        sysbus_connect_irq(gicbusdev, i + nr_apu_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_FIQ));
+        sysbus_connect_irq(gicbusdev, i + 2 * nr_apu_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VIRQ));
+        sysbus_connect_irq(gicbusdev, i + 3 * nr_apu_cpus,
+                           qdev_get_gpio_in(cpudev, ARM_CPU_VFIQ));
+    }
+
+    for (i = 0; i < XLNX_VERSAL_NR_IRQS; i++) {
+        pic[i] = qdev_get_gpio_in(gicdev, i);
+    }
+}
+
+static void versal_create_uarts(Versal *s, qemu_irq *pic)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.uart); i++) {
+        static const int irqs[] = { VERSAL_UART0_IRQ_0, VERSAL_UART1_IRQ_0};
+        static const uint64_t addrs[] = { MM_UART0, MM_UART1 };
+        char *name = g_strdup_printf("uart%d", i);
+        DeviceState *dev;
+        MemoryRegion *mr;
+
+        dev = qdev_create(NULL, "pl011");
+        s->lpd.iou.uart[i] = SYS_BUS_DEVICE(dev);
+        qdev_prop_set_chr(dev, "chardev", serial_hd(i));
+        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
+        qdev_init_nofail(dev);
+
+        mr = sysbus_mmio_get_region(s->lpd.iou.uart[i], 0);
+        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
+
+        sysbus_connect_irq(s->lpd.iou.uart[i], 0, pic[irqs[i]]);
+        g_free(name);
+    }
+}
+
+static void versal_create_gems(Versal *s, qemu_irq *pic)
+{
+    int i;
+
+    for (i = 0; i < ARRAY_SIZE(s->lpd.iou.gem); i++) {
+        static const int irqs[] = { VERSAL_GEM0_IRQ_0, VERSAL_GEM1_IRQ_0};
+        static const uint64_t addrs[] = { MM_GEM0, MM_GEM1 };
+        char *name = g_strdup_printf("gem%d", i);
+        NICInfo *nd = &nd_table[i];
+        DeviceState *dev;
+        MemoryRegion *mr;
+
+        dev = qdev_create(NULL, "cadence_gem");
+        s->lpd.iou.gem[i] = SYS_BUS_DEVICE(dev);
+        object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
+        if (nd->used) {
+            qemu_check_nic_model(nd, "cadence_gem");
+            qdev_set_nic_properties(dev, nd);
+        }
+        object_property_set_int(OBJECT(s->lpd.iou.gem[i]),
+                                2, "num-priority-queues",
+                                &error_abort);
+        object_property_set_link(OBJECT(s->lpd.iou.gem[i]),
+                                 OBJECT(&s->mr_ps), "dma",
+                                 &error_abort);
+        qdev_init_nofail(dev);
+
+        mr = sysbus_mmio_get_region(s->lpd.iou.gem[i], 0);
+        memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
+
+        sysbus_connect_irq(s->lpd.iou.gem[i], 0, pic[irqs[i]]);
+        g_free(name);
+    }
+}
+
+/* This takes the board allocated linear DDR memory and creates aliases
+ * for each split DDR range/aperture on the Versal address map.
+ */
+static void versal_map_ddr(Versal *s)
+{
+    uint64_t size = memory_region_size(s->cfg.mr_ddr);
+    /* Describes the various split DDR access regions.  */
+    static const struct {
+        uint64_t base;
+        uint64_t size;
+    } addr_ranges[] = {
+        { MM_TOP_DDR, MM_TOP_DDR_SIZE },
+        { MM_TOP_DDR_2, MM_TOP_DDR_2_SIZE },
+        { MM_TOP_DDR_3, MM_TOP_DDR_3_SIZE },
+        { MM_TOP_DDR_4, MM_TOP_DDR_4_SIZE }
+    };
+    uint64_t offset = 0;
+    int i;
+
+    assert(ARRAY_SIZE(addr_ranges) == ARRAY_SIZE(s->noc.mr_ddr_ranges));
+    for (i = 0; i < ARRAY_SIZE(addr_ranges) && size; i++) {
+        char *name;
+        uint64_t mapsize;
+
+        mapsize = size < addr_ranges[i].size ? size : addr_ranges[i].size;
+        name = g_strdup_printf("noc-ddr-range%d", i);
+        /* Create the MR alias.  */
+        memory_region_init_alias(&s->noc.mr_ddr_ranges[i], OBJECT(s),
+                                 name, s->cfg.mr_ddr,
+                                 offset, mapsize);
+
+        /* Map it onto the NoC MR.  */
+        memory_region_add_subregion(&s->mr_ps, addr_ranges[i].base,
+                                    &s->noc.mr_ddr_ranges[i]);
+        offset += mapsize;
+        size -= mapsize;
+        g_free(name);
+    }
+}
+
+static void versal_unimp_area(Versal *s, const char *name,
+                                MemoryRegion *mr,
+                                hwaddr base, hwaddr size)
+{
+    DeviceState *dev = qdev_create(NULL, TYPE_UNIMPLEMENTED_DEVICE);
+    MemoryRegion *mr_dev;
+
+    qdev_prop_set_string(dev, "name", name);
+    qdev_prop_set_uint64(dev, "size", size);
+    object_property_add_child(OBJECT(s), name, OBJECT(dev), &error_fatal);
+    qdev_init_nofail(dev);
+
+    mr_dev = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
+    memory_region_add_subregion(mr, base, mr_dev);
+}
+
+static void versal_unimp(Versal *s)
+{
+    versal_unimp_area(s, "psm", &s->mr_ps,
+                        MM_PSM_START, MM_PSM_END - MM_PSM_START);
+    versal_unimp_area(s, "crl", &s->mr_ps,
+                        MM_CRL, MM_CRL_SIZE);
+    versal_unimp_area(s, "crf", &s->mr_ps,
+                        MM_FPD_CRF, MM_FPD_CRF_SIZE);
+    versal_unimp_area(s, "iou-scntr", &s->mr_ps,
+                        MM_IOU_SCNTR, MM_IOU_SCNTR_SIZE);
+    versal_unimp_area(s, "iou-scntr-seucre", &s->mr_ps,
+                        MM_IOU_SCNTRS, MM_IOU_SCNTRS_SIZE);
+}
+
+static void versal_realize(DeviceState *dev, Error **errp)
+{
+    Versal *s = XLNX_VERSAL(dev);
+    qemu_irq pic[XLNX_VERSAL_NR_IRQS];
+
+    versal_create_apu_cpus(s, errp);
+    versal_create_apu_gic(s, pic, errp);
+    versal_create_uarts(s, pic);
+    versal_create_gems(s, pic);
+    versal_map_ddr(s);
+    versal_unimp(s);
+
+    /* Create the On Chip Memory (OCM).  */
+    memory_region_init_ram(&s->lpd.mr_ocm, OBJECT(s), "ocm",
+                           MM_OCM_SIZE, &error_fatal);
+
+    memory_region_add_subregion_overlap(&s->mr_ps, MM_OCM, &s->lpd.mr_ocm, 0);
+    memory_region_add_subregion_overlap(&s->fpd.apu.mr, 0, &s->mr_ps, 0);
+}
+
+static void versal_init(Object *obj)
+{
+    Versal *s = XLNX_VERSAL(obj);
+
+    memory_region_init(&s->fpd.apu.mr, obj, "mr-apu", UINT64_MAX);
+    memory_region_init(&s->mr_ps, obj, "mr-ps-switch", UINT64_MAX);
+}
+
+static Property versal_properties[] = {
+    DEFINE_PROP_LINK("ddr", Versal, cfg.mr_ddr, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_UINT32("psci-conduit", Versal, cfg.psci_conduit, 0),
+    DEFINE_PROP_END_OF_LIST()
+};
+
+static void versal_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = versal_realize;
+    dc->props = versal_properties;
+    /* No VMSD since we haven't got any top-level SoC state to save.  */
+}
+
+static const TypeInfo versal_info = {
+    .name = TYPE_XLNX_VERSAL,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(Versal),
+    .instance_init = versal_init,
+    .class_init = versal_class_init,
+};
+
+static void versal_register_types(void)
+{
+    type_register_static(&versal_info);
+}
+
+type_init(versal_register_types);
diff --git a/include/hw/arm/xlnx-versal.h b/include/hw/arm/xlnx-versal.h
new file mode 100644
index 0000000000..9da621e4b6
--- /dev/null
+++ b/include/hw/arm/xlnx-versal.h
@@ -0,0 +1,122 @@
+/*
+ * Model of the Xilinx Versal
+ *
+ * Copyright (c) 2018 Xilinx Inc.
+ * Written by Edgar E. Iglesias
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 or
+ * (at your option) any later version.
+ */
+
+#ifndef XLNX_VERSAL_H
+#define XLNX_VERSAL_H
+
+#include "hw/sysbus.h"
+#include "hw/arm/arm.h"
+#include "hw/intc/arm_gicv3.h"
+
+#define TYPE_XLNX_VERSAL "xlnx-versal"
+#define XLNX_VERSAL(obj) OBJECT_CHECK(Versal, (obj), TYPE_XLNX_VERSAL)
+
+#define XLNX_VERSAL_NR_ACPUS   2
+#define XLNX_VERSAL_NR_UARTS   2
+#define XLNX_VERSAL_NR_GEMS    2
+#define XLNX_VERSAL_NR_IRQS    256
+
+typedef struct Versal {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    struct {
+        struct {
+            MemoryRegion mr;
+            ARMCPU *cpu[XLNX_VERSAL_NR_ACPUS];
+            GICv3State gic;
+        } apu;
+    } fpd;
+
+    MemoryRegion mr_ps;
+
+    struct {
+        /* 4 ranges to access DDR.  */
+        MemoryRegion mr_ddr_ranges[4];
+    } noc;
+
+    struct {
+        MemoryRegion mr_ocm;
+
+        struct {
+            SysBusDevice *uart[XLNX_VERSAL_NR_UARTS];
+            SysBusDevice *gem[XLNX_VERSAL_NR_GEMS];
+        } iou;
+    } lpd;
+
+    struct {
+        MemoryRegion *mr_ddr;
+        uint32_t psci_conduit;
+    } cfg;
+} Versal;
+
+/* Memory-map and IRQ definitions. Copied a subset from
+ * auto-generated files.  */
+
+#define VERSAL_GIC_MAINT_IRQ        9
+#define VERSAL_TIMER_VIRT_IRQ       11
+#define VERSAL_TIMER_S_EL1_IRQ      13
+#define VERSAL_TIMER_NS_EL1_IRQ     14
+#define VERSAL_TIMER_NS_EL2_IRQ     10
+
+#define VERSAL_UART0_IRQ_0         18
+#define VERSAL_UART1_IRQ_0         19
+#define VERSAL_GEM0_IRQ_0          56
+#define VERSAL_GEM0_WAKE_IRQ_0     57
+#define VERSAL_GEM1_IRQ_0          58
+#define VERSAL_GEM1_WAKE_IRQ_0     59
+
+/* Architecturally eserved IRQs suitable for virtualization.  */
+#define VERSAL_RSVD_HIGH_IRQ_FIRST 160
+#define VERSAL_RSVD_HIGH_IRQ_LAST  255
+
+#define MM_TOP_RSVD                 0xa0000000U
+#define MM_TOP_RSVD_SIZE            0x4000000
+#define MM_GIC_APU_DIST_MAIN        0xf9000000U
+#define MM_GIC_APU_DIST_MAIN_SIZE   0x10000
+#define MM_GIC_APU_REDIST_0         0xf9080000U
+#define MM_GIC_APU_REDIST_0_SIZE    0x80000
+
+#define MM_UART0                    0xff000000U
+#define MM_UART0_SIZE               0x10000
+#define MM_UART1                    0xff010000U
+#define MM_UART1_SIZE               0x10000
+
+#define MM_GEM0                     0xff0c0000U
+#define MM_GEM0_SIZE                0x10000
+#define MM_GEM1                     0xff0d0000U
+#define MM_GEM1_SIZE                0x10000
+
+#define MM_OCM                      0xfffc0000U
+#define MM_OCM_SIZE                 0x40000
+
+#define MM_TOP_DDR                  0x0
+#define MM_TOP_DDR_SIZE             0x80000000U
+#define MM_TOP_DDR_2                0x800000000ULL
+#define MM_TOP_DDR_2_SIZE           0x800000000ULL
+#define MM_TOP_DDR_3                0xc000000000ULL
+#define MM_TOP_DDR_3_SIZE           0x4000000000ULL
+#define MM_TOP_DDR_4                0x10000000000ULL
+#define MM_TOP_DDR_4_SIZE           0xb780000000ULL
+
+#define MM_PSM_START                0xffc80000U
+#define MM_PSM_END                  0xffcf0000U
+
+#define MM_CRL                      0xff5e0000U
+#define MM_CRL_SIZE                 0x300000
+#define MM_IOU_SCNTR                0xff130000U
+#define MM_IOU_SCNTR_SIZE           0x10000
+#define MM_IOU_SCNTRS               0xff140000U
+#define MM_IOU_SCNTRS_SIZE          0x10000
+#define MM_FPD_CRF                  0xfd1a0000U
+#define MM_FPD_CRF_SIZE             0x140000
+#endif
-- 
2.17.1
