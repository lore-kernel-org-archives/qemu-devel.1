Received: from eggs.gnu.org ([2001:4830:134:3::10]:49036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e87V5-0006uC-44
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:28:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e87V3-0003Ac-O1
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:28:51 -0400
From: Gabriel Costa <gabriel291075@gmail.com>
Date: Fri, 27 Oct 2017 08:24:15 -0400
Message-Id: <1509107055-21978-6-git-send-email-costa@advantech.ca>
In-Reply-To: <1509107055-21978-1-git-send-email-costa@advantech.ca>
References: <1509107055-21978-1-git-send-email-costa@advantech.ca>
Subject: [Qemu-devel]  [PATCH v7 5/5] arm: kinetis_mk64fn1m0 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, f4bug@amsat.org, Gabriel Augusto Costa <gabriel291075@gmail.com>

This Patch include mk64fn1m0.c that describe the kinetis k64 machine and
some peripherals.
Also, include changes in Makefile.objs and arm-softmmu.mak to compile
this machine.

Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
---
 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Makefile.objs            |   1 +
 hw/arm/mk64fn1m0.c              | 136 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 138 insertions(+)
 create mode 100644 hw/arm/mk64fn1m0.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 5059d13..a835d4f 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -130,3 +130,4 @@ CONFIG_SMBIOS=y
 CONFIG_ASPEED_SOC=y
 CONFIG_GPIO_KEY=y
 CONFIG_MSF2=y
+CONFIG_KINETIS_K64=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 2794e08..874a38a 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -20,3 +20,4 @@ obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o sabrelite.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o
 obj-$(CONFIG_MPS2) += mps2.o
 obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
+obj-$(CONFIG_KINETIS_K64) += mk64fn1m0.o
diff --git a/hw/arm/mk64fn1m0.c b/hw/arm/mk64fn1m0.c
new file mode 100644
index 0000000..618791c
--- /dev/null
+++ b/hw/arm/mk64fn1m0.c
@@ -0,0 +1,136 @@
+/*
+ * Kinetis K64 MK64FN1M0 microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "hw/sysbus.h"
+#include "hw/ssi/ssi.h"
+#include "hw/arm/arm.h"
+#include "hw/devices.h"
+#include "qemu/timer.h"
+#include "hw/i2c/i2c.h"
+#include "net/net.h"
+#include "hw/boards.h"
+#include "qemu/log.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "hw/char/pl011.h"
+#include "hw/misc/unimp.h"
+#include "cpu.h"
+#include "hw/char/kinetis_k64_uart.h"
+#include "hw/misc/kinetis_k64_system.h"
+#include "hw/misc/kinetis_k64_mcg.h"
+#include "hw/misc/kinetis_k64_pmux.h"
+
+#define FLASH_SIZE              (1024 * 1024)
+#define FLASH_BASE_ADDRESS      (0x00000000)
+#define SRAM_SIZE               (192 * 1024)
+#define SRAM_BASE_ADDRESS       (0x20000000)
+
+#define NUM_IRQ_LINES 85
+
+/* System controller.  */
+
+static void do_sys_reset(void *opaque, int n, int level)
+{
+    if (level) {
+        qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
+    }
+}
+
+/* Interruptions at pag.77 of K64P144M120F5RM.pdf */
+
+static void mk64fn1m0_init_mach(MachineState *ms, const char *kernel_filename)
+{
+    DeviceState *nvic;
+
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *sram = g_new(MemoryRegion, 1);
+    MemoryRegion *flash = g_new(MemoryRegion, 1);
+
+    memory_region_init_ram(flash, NULL, "k64.flash", FLASH_SIZE, &error_fatal);
+    memory_region_set_readonly(flash, true);
+    memory_region_add_subregion(system_memory, FLASH_BASE_ADDRESS, flash);
+    memory_region_init_ram(sram, NULL, "k64.sram", SRAM_SIZE, &error_fatal);
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
+    nvic = armv7m_init(system_memory, FLASH_SIZE, NUM_IRQ_LINES,
+            ms->kernel_filename, ms->cpu_type);
+    qdev_connect_gpio_out_named(nvic, "SYSRESETREQ", 0,
+            qemu_allocate_irq(&do_sys_reset, NULL, 0));
+
+    sysbus_create_simple(TYPE_KINETIS_K64_SIM, 0x40048000, NULL);
+    sysbus_create_simple(TYPE_KINETIS_K64_MCG, 0x40064000, NULL);
+    sysbus_create_simple(TYPE_KINETIS_K64_PMUX, 0x40049000,
+            qdev_get_gpio_in(nvic, 59));
+    sysbus_create_simple(TYPE_KINETIS_K64_PMUX, 0x4004A000,
+            qdev_get_gpio_in(nvic, 60));
+    sysbus_create_simple(TYPE_KINETIS_K64_PMUX, 0x4004B000,
+            qdev_get_gpio_in(nvic, 61));
+    sysbus_create_simple(TYPE_KINETIS_K64_PMUX, 0x4004C000,
+            qdev_get_gpio_in(nvic, 62));
+    sysbus_create_simple(TYPE_KINETIS_K64_PMUX, 0x4004D000,
+            qdev_get_gpio_in(nvic, 63));
+    create_unimplemented_device("kinetis_k64_spi0",  0x4002C000, 0x1000);
+    create_unimplemented_device("kinetis_k64_spi1",  0x4002D000, 0x1000);
+    create_unimplemented_device("kinetis_k64_adc0",  0x4003B000, 0x1000);
+    create_unimplemented_device("kinetis_k64_dac",   0x4002F000, 0x1000);
+    create_unimplemented_device("kinetis_k64_i2c0",  0x40066000, 0x1000);
+    create_unimplemented_device("kinetis_k64_i2c1",  0x40067000, 0x1000);
+    kinetis_k64_uart_create(0x4006A000, qdev_get_gpio_in(nvic, 31),
+            serial_hds[0]);
+    create_unimplemented_device("kinetis_k64_uart1", 0x4006B000, 0x1000);
+    create_unimplemented_device("kinetis_k64_uart2", 0x4006C000, 0x1000);
+    create_unimplemented_device("kinetis_k64_uart3", 0x4006D000, 0x1000);
+    create_unimplemented_device("kinetis_k64_spi2",  0x400AC000, 0x1000);
+    create_unimplemented_device("kinetis_k64_adc1",  0x400BB000, 0x1000);
+    create_unimplemented_device("kinetis_k64_i2c2",  0x400E6000, 0x1000);
+    create_unimplemented_device("kinetis_k64_uart4", 0x400EA000, 0x1000);
+    create_unimplemented_device("kinetis_k64_uart5", 0x400EB000, 0x1000);
+    create_unimplemented_device("peripheral_brdg_0", 0x40000000, 0x1000);
+    create_unimplemented_device("Crossbar_Switch",   0x40004000, 0x1000);
+    create_unimplemented_device("DMA_Controller",    0x40008000, 0x1000);
+    create_unimplemented_device("DMA_Controller_t",  0x40009000, 0x1000);
+    create_unimplemented_device("FlexBus",           0x4000C000, 0x1000);
+    create_unimplemented_device("MPU",               0x4000D000, 0x1000);
+    create_unimplemented_device("Flash_mem_ctrl",    0x4001F000, 0x1000);
+    create_unimplemented_device("Flash_mem",         0x40020000, 0x1000);
+    create_unimplemented_device("DMA_ch_multiplx",   0x40021000, 0x1000);
+}
+
+static void mk64fn1m0_init(MachineState *machine)
+{
+    const char *kernel_filename = machine->kernel_filename;
+    mk64fn1m0_init_mach(machine, kernel_filename);
+}
+
+static void mk64fn1m0_class_init(ObjectClass *oc, void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+
+    mc->desc = "Kinetis K64 MCU (Cortex-M4)";
+    mc->init = mk64fn1m0_init;
+    mc->ignore_memory_transaction_failures = true;
+    mc->default_cpu_type = ARM_CPU_TYPE_NAME("cortex-m4");
+    mc->max_cpus = 1;
+}
+
+static const TypeInfo mk64_type = {
+    .name = MACHINE_TYPE_NAME("mk64fn1m0"),
+    .parent = TYPE_MACHINE,
+    .class_init = mk64fn1m0_class_init,
+};
+
+static void mk64fn1m0_machine_init(void)
+{
+    type_register_static(&mk64_type);
+}
+
+type_init(mk64fn1m0_machine_init)
-- 
2.1.4
