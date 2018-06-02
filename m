Received: from eggs.gnu.org ([2001:4830:134:3::10]:42897)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fP7J9-0001KP-6Q
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 10:15:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fP7J7-0007In-Dv
	for qemu-devel@nongnu.org; Sat, 02 Jun 2018 10:15:03 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Sat,  2 Jun 2018 15:14:46 +0100
Message-Id: <20180602141446.29982-3-stefanha@redhat.com>
In-Reply-To: <20180602141446.29982-1-stefanha@redhat.com>
References: <20180602141446.29982-1-stefanha@redhat.com>
Subject: [Qemu-devel] [RFC 2/2] arm: add ARMv6-M device container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, mail@steffen-goertz.de, jim@groklearning.com, qemu-arm@nongnu.org, jusual@mail.ru, joel@jms.id.au, Stefan Hajnoczi <stefanha@redhat.com>

Introduce armv6m_init() and the glue code needed to wire together an
ARMv6-M ARMCPU with memory and the NVIC.

The "microbit" board needs to use a Cortex M0 CPU instead of a Cortex
M3.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/arm/Makefile.objs            |   1 +
 hw/intc/Makefile.objs           |   2 +-
 hw/timer/Makefile.objs          |   2 +-
 include/hw/arm/arm.h            |  16 +++
 include/hw/arm/armv6m.h         |  49 ++++++++
 hw/arm/armv6m.c                 | 190 ++++++++++++++++++++++++++++++++
 hw/arm/nrf51_soc.c              |   5 +-
 default-configs/arm-softmmu.mak |   2 +
 8 files changed, 262 insertions(+), 5 deletions(-)
 create mode 100644 include/hw/arm/armv6m.h
 create mode 100644 hw/arm/armv6m.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index cecbe41086..5fb135791d 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -17,6 +17,7 @@ obj-$(CONFIG_VERSATILE) += vexpress.o versatilepb.o
 obj-$(CONFIG_ZYNQ) += xilinx_zynq.o
 
 obj-$(CONFIG_ARM_V7M) += armv7m.o
+obj-$(CONFIG_ARM_V6M) += armv6m.o
 obj-$(CONFIG_EXYNOS4) += exynos4210.o
 obj-$(CONFIG_PXA2XX) += pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
 obj-$(CONFIG_DIGIC) += digic.o
diff --git a/hw/intc/Makefile.objs b/hw/intc/Makefile.objs
index 0e9963f5ee..dbfb7195db 100644
--- a/hw/intc/Makefile.objs
+++ b/hw/intc/Makefile.objs
@@ -26,7 +26,7 @@ obj-$(CONFIG_APIC) += apic.o apic_common.o
 obj-$(CONFIG_ARM_GIC_KVM) += arm_gic_kvm.o
 obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_kvm.o
 obj-$(call land,$(CONFIG_ARM_GIC_KVM),$(TARGET_AARCH64)) += arm_gicv3_its_kvm.o
-obj-$(CONFIG_ARM_V7M) += armv7m_nvic.o
+obj-$(call lor,$(CONFIG_ARM_V7M),$(CONFIG_ARM_V6M)) += armv7m_nvic.o
 obj-$(CONFIG_EXYNOS4) += exynos4210_gic.o exynos4210_combiner.o
 obj-$(CONFIG_GRLIB) += grlib_irqmp.o
 obj-$(CONFIG_IOAPIC) += ioapic.o
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 8b27a4b7ef..03d98a7871 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -1,6 +1,6 @@
 common-obj-$(CONFIG_ARM_TIMER) += arm_timer.o
 common-obj-$(CONFIG_ARM_MPTIMER) += arm_mptimer.o
-common-obj-$(CONFIG_ARM_V7M) += armv7m_systick.o
+common-obj-$(call lor,$(CONFIG_ARM_V7M),$(CONFIG_ARM_V6M)) += armv7m_systick.o
 common-obj-$(CONFIG_A9_GTIMER) += a9gtimer.o
 common-obj-$(CONFIG_CADENCE) += cadence_ttc.o
 common-obj-$(CONFIG_DS1338) += ds1338.o
diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index 70fa2287e2..a0eaf52ae6 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -23,6 +23,22 @@ typedef enum {
     ARM_ENDIANNESS_BE32,
 } arm_endianness;
 
+/**
+ * armv6m_init:
+ * @system_memory: System memory region
+ * @mem_size: RAM size, in bytes
+ * @num_irq: number of interrupt pins
+ * @kernel_filename: path to kernel image
+ * @cpu_type: an ARMv6-M CPU implementation
+ *
+ * Initializes CPU and memory for an ARMv6-M based board.
+ *
+ * Returns: ARMV6M device containing CPU and NVIC.
+ */
+DeviceState *armv6m_init(MemoryRegion *system_memory, int mem_size,
+                         int num_irq, const char *kernel_filename,
+                         const char *cpu_type);
+
 /* armv7m.c */
 DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
                          const char *kernel_filename, const char *cpu_type);
diff --git a/include/hw/arm/armv6m.h b/include/hw/arm/armv6m.h
new file mode 100644
index 0000000000..46258171a7
--- /dev/null
+++ b/include/hw/arm/armv6m.h
@@ -0,0 +1,49 @@
+/*
+ * ARMV6M CPU object
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * Based on include/hw/arm/armv7m.h (written by Peter Maydell
+ * <peter.maydell@linaro.org>),
+ * Copyright (c) 2017 Linaro Ltd.
+ *
+ * This code is licensed under the GPL version 2 or later.
+ */
+
+#ifndef HW_ARM_ARMV6M_H
+#define HW_ARM_ARMV6M_H
+
+#include "hw/sysbus.h"
+#include "hw/intc/armv7m_nvic.h"
+
+#define TYPE_ARMV6M "armv6m"
+#define ARMV6M(obj) OBJECT_CHECK(ARMv6MState, (obj), TYPE_ARMV6M)
+
+/* ARMV6M container object.
+ * + Unnamed GPIO input lines: external IRQ lines for the NVIC
+ * + Named GPIO output SYSRESETREQ: signalled for guest AIRCR.SYSRESETREQ
+ * + Property "cpu-type": CPU type to instantiate
+ * + Property "num-irq": number of external IRQ lines
+ * + Property "memory": MemoryRegion defining the physical address space
+ *   that CPU accesses see. (The NVIC and other CPU-internal devices will be
+ *   automatically layered on top of this view.)
+ */
+typedef struct {
+    /*< private >*/
+    SysBusDevice parent_obj;
+    /*< public >*/
+    NVICState nvic;
+    ARMCPU *cpu;
+
+    /* MemoryRegion we pass to the CPU, with our devices layered on
+     * top of the ones the board provides in board_memory.
+     */
+    MemoryRegion container;
+
+    /* Properties */
+    char *cpu_type;
+    /* MemoryRegion the board provides to us (with its devices, RAM, etc) */
+    MemoryRegion *board_memory;
+} ARMv6MState;
+
+#endif
diff --git a/hw/arm/armv6m.c b/hw/arm/armv6m.c
new file mode 100644
index 0000000000..feb0f8aa44
--- /dev/null
+++ b/hw/arm/armv6m.c
@@ -0,0 +1,190 @@
+/*
+ * ARMV6M System emulation.
+ *
+ * Copyright (C) 2018 Red Hat, Inc.
+ *
+ * Based on hw/arm/armv7m.c (written by Paul Brook),
+ * Copyright (c) 2006-2007 CodeSourcery.
+ *
+ * This code is licensed under the GPL.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/arm/armv6m.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "cpu.h"
+#include "hw/sysbus.h"
+#include "hw/arm/arm.h"
+#include "hw/loader.h"
+#include "elf.h"
+#include "sysemu/qtest.h"
+#include "qemu/error-report.h"
+#include "exec/address-spaces.h"
+
+static void armv6m_instance_init(Object *obj)
+{
+    ARMv6MState *s = ARMV6M(obj);
+
+    /* Can't init the cpu here, we don't yet know which model to use */
+
+    memory_region_init(&s->container, obj, "armv6m-container", UINT64_MAX);
+
+    object_initialize(&s->nvic, sizeof(s->nvic), TYPE_NVIC);
+    qdev_set_parent_bus(DEVICE(&s->nvic), sysbus_get_default());
+    object_property_add_alias(obj, "num-irq",
+                              OBJECT(&s->nvic), "num-irq", &error_abort);
+}
+
+static void armv6m_realize(DeviceState *dev, Error **errp)
+{
+    ARMv6MState *s = ARMV6M(dev);
+    SysBusDevice *sbd;
+    Error *err = NULL;
+
+    if (!s->board_memory) {
+        error_setg(errp, "memory property was not set");
+        return;
+    }
+
+    memory_region_add_subregion_overlap(&s->container, 0, s->board_memory, -1);
+
+    s->cpu = ARM_CPU(object_new(s->cpu_type));
+
+    object_property_set_link(OBJECT(s->cpu), OBJECT(&s->container), "memory",
+                             &error_abort);
+    object_property_set_bool(OBJECT(s->cpu), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* Note that we must realize the NVIC after the CPU */
+    object_property_set_bool(OBJECT(&s->nvic), true, "realized", &err);
+    if (err != NULL) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    /* Alias the NVIC's input and output GPIOs as our own so the board
+     * code can wire them up. (We do this in realize because the
+     * NVIC doesn't create the input GPIO array until realize.)
+     */
+    qdev_pass_gpios(DEVICE(&s->nvic), dev, NULL);
+    qdev_pass_gpios(DEVICE(&s->nvic), dev, "SYSRESETREQ");
+
+    /* Wire the NVIC up to the CPU */
+    sbd = SYS_BUS_DEVICE(&s->nvic);
+    sysbus_connect_irq(sbd, 0,
+                       qdev_get_gpio_in(DEVICE(s->cpu), ARM_CPU_IRQ));
+    s->cpu->env.nvic = &s->nvic;
+
+    memory_region_add_subregion(&s->container, 0xe000e000,
+                                sysbus_mmio_get_region(sbd, 0));
+}
+
+static Property armv6m_properties[] = {
+    DEFINE_PROP_STRING("cpu-type", ARMv6MState, cpu_type),
+    DEFINE_PROP_LINK("memory", ARMv6MState, board_memory, TYPE_MEMORY_REGION,
+                     MemoryRegion *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void armv6m_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = armv6m_realize;
+    dc->props = armv6m_properties;
+}
+
+static const TypeInfo armv6m_info = {
+    .name = TYPE_ARMV6M,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(ARMv6MState),
+    .instance_init = armv6m_instance_init,
+    .class_init = armv6m_class_init,
+};
+
+static void armv6m_reset(void *opaque)
+{
+    ARMCPU *cpu = opaque;
+
+    cpu_reset(CPU(cpu));
+}
+
+static void armv6m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
+{
+    int image_size;
+    uint64_t entry;
+    uint64_t lowaddr;
+    int big_endian;
+    AddressSpace *as;
+    CPUState *cs = CPU(cpu);
+
+#ifdef TARGET_WORDS_BIGENDIAN
+    big_endian = 1;
+#else
+    big_endian = 0;
+#endif
+
+    if (!kernel_filename && !qtest_enabled()) {
+        error_report("Guest image must be specified (using -kernel)");
+        exit(1);
+    }
+
+    as = cpu_get_address_space(cs, ARMASIdx_NS);
+
+    if (kernel_filename) {
+        image_size = load_elf_as(kernel_filename, NULL, NULL, &entry, &lowaddr,
+                                 NULL, big_endian, EM_ARM, 1, 0, as);
+        if (image_size < 0) {
+            entry = 0;
+            image_size = load_targphys_hex_as(kernel_filename, &entry, as);
+        }
+        if (image_size < 0) {
+            image_size = load_image_targphys_as(kernel_filename, 0,
+                                                mem_size, as);
+            lowaddr = 0;
+        }
+        if (image_size < 0) {
+            error_report("Could not load kernel '%s'", kernel_filename);
+            exit(1);
+        }
+    }
+
+    /* CPU objects (unlike devices) are not automatically reset on system
+     * reset, so we must always register a handler to do so. Unlike
+     * A-profile CPUs, we don't need to do anything special in the
+     * handler to arrange that it starts correctly.
+     * This is arguably the wrong place to do this, but it matches the
+     * way A-profile does it. Note that this means that every M profile
+     * board must call this function!
+     */
+    qemu_register_reset(armv6m_reset, cpu);
+}
+
+DeviceState *armv6m_init(MemoryRegion *system_memory, int mem_size,
+                         int num_irq, const char *kernel_filename,
+                         const char *cpu_type)
+{
+    DeviceState *armv6m;
+
+    armv6m = qdev_create(NULL, TYPE_ARMV6M);
+    qdev_prop_set_uint32(armv6m, "num-irq", num_irq);
+    qdev_prop_set_string(armv6m, "cpu-type", cpu_type);
+    object_property_set_link(OBJECT(armv6m), OBJECT(system_memory),
+                             "memory", &error_abort);
+    /* This will exit with an error if the user passed us a bad cpu_type */
+    qdev_init_nofail(armv6m);
+
+    armv6m_load_kernel(ARM_CPU(first_cpu), kernel_filename, mem_size);
+    return armv6m;
+}
+
+static void armv6m_register_types(void)
+{
+    type_register_static(&armv6m_info);
+}
+
+type_init(armv6m_register_types)
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 00de550910..a9e012dd2b 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -74,9 +74,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     vmstate_register_ram_global(sram);
     memory_region_add_subregion(system_memory, SRAM_BASE, sram);
 
-    /* TODO: implement a cortex m0 and update this */
-    s->nvic = armv7m_init(get_system_memory(), FLASH_SIZE, 96,
-               s->kernel_filename, ARM_CPU_TYPE_NAME("cortex-m3"));
+    s->nvic = armv6m_init(get_system_memory(), FLASH_SIZE, 96,
+               s->kernel_filename, ARM_CPU_TYPE_NAME("cortex-m0"));
 
     s->uart = nrf51_uart_create(UART_BASE, qdev_get_gpio_in(s->nvic, 2),
                                 serial_hd(0));
diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 543ea965da..50921e5e70 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -99,6 +99,8 @@ CONFIG_STM32F2XX_SYSCFG=y
 CONFIG_STM32F2XX_ADC=y
 CONFIG_STM32F2XX_SPI=y
 CONFIG_STM32F205_SOC=y
+
+CONFIG_ARM_V6M=y
 CONFIG_NRF51_SOC=y
 
 CONFIG_CMSDK_APB_TIMER=y
-- 
2.17.0
