Received: from eggs.gnu.org ([2001:4830:134:3::10]:45899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1cpZXu-0005xt-QE
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 08:02:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1cpZXt-00046t-IF
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 08:02:50 -0400
Received: from mail-pg0-x243.google.com ([2607:f8b0:400e:c05::243]:34671)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sundeep.lkml@gmail.com>)
	id 1cpZXt-000467-Av
	for qemu-devel@nongnu.org; Sun, 19 Mar 2017 08:02:49 -0400
Received: by mail-pg0-x243.google.com with SMTP id b5so15914646pgg.1
	for <qemu-devel@nongnu.org>; Sun, 19 Mar 2017 05:02:49 -0700 (PDT)
From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Date: Sun, 19 Mar 2017 17:32:06 +0530
Message-Id: <1489924926-28368-3-git-send-email-sundeep.lkml@gmail.com>
In-Reply-To: <1489924926-28368-1-git-send-email-sundeep.lkml@gmail.com>
References: <1489924926-28368-1-git-send-email-sundeep.lkml@gmail.com>
Subject: [Qemu-devel] [Qemu-devel RFC 3/3] msf2: Add Emcraft's Smartfusion2
 SOM kit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, crosthwaite.peter@gmail.com, Subbaraya Sundeep <sundeep.lkml@gmail.com>

Emulated Emcraft's Smartfusion2 System On Module starter
kit.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
---
 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Makefile.objs            |   2 +-
 hw/arm/msf2_soc.c               | 122 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 124 insertions(+), 1 deletion(-)
 create mode 100644 hw/arm/msf2_soc.c

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index 1e3bd2b..379f7e1 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -121,3 +121,4 @@ CONFIG_ACPI=y
 CONFIG_SMBIOS=y
 CONFIG_ASPEED_SOC=y
 CONFIG_GPIO_KEY=y
+CONFIG_MSF2=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 4c5c4ee..cce2759 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,7 +1,7 @@
 obj-y += boot.o collie.o exynos4_boards.o gumstix.o highbank.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
 obj-y += integratorcp.o mainstone.o musicpal.o nseries.o
-obj-y += omap_sx1.o palm.o realview.o spitz.o stellaris.o
+obj-y += omap_sx1.o palm.o realview.o spitz.o stellaris.o msf2_soc.o
 obj-y += tosa.o versatilepb.o vexpress.o virt.o xilinx_zynq.o z2.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-y += netduino2.o
diff --git a/hw/arm/msf2_soc.c b/hw/arm/msf2_soc.c
new file mode 100644
index 0000000..53da55b
--- /dev/null
+++ b/hw/arm/msf2_soc.c
@@ -0,0 +1,122 @@
+/*
+ * Smartfusion2 SOM starter kit(from Emcraft) emulation.
+ *
+ * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "hw/arm/arm.h"
+#include "exec/address-spaces.h"
+#include "hw/sysbus.h"
+#include "hw/char/serial.h"
+#include "hw/boards.h"
+#include "sysemu/block-backend.h"
+
+#define MSF2_NUM_USARTS      1
+#define MSF2_NUM_TIMERS      2
+
+#define ENVM_BASE_ADDRESS    0x60000000
+#define ENVM_SIZE            (128 * 1024)
+
+#define DDR_BASE_ADDRESS     0xA0000000
+#define DDR_SIZE             (1024 * 1024 * 1024)
+
+#define SRAM_BASE_ADDRESS    0x20000000
+#define SRAM_SIZE            (64 * 1024)
+
+#define MSF2_TIMER_BASE      0x40004000
+#define MSF2_SYSREG_BASE     0x40038000
+
+static const uint32_t usart_addr[MSF2_NUM_USARTS] = { 0x40000000 };
+
+static const int timer_irq[MSF2_NUM_TIMERS] = {14, 15};
+static const int usart_irq[MSF2_NUM_USARTS] = {10};
+
+static void msf2_init(MachineState *machine)
+{
+    const char *kernel_filename = NULL;
+    DeviceState *dev, *nvic;
+    int i;
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *nvm = g_new(MemoryRegion, 1);
+    MemoryRegion *nvm_alias = g_new(MemoryRegion, 1);
+    MemoryRegion *sram = g_new(MemoryRegion, 1);
+    MemoryRegion *ddr = g_new(MemoryRegion, 1);
+    QemuOpts *machine_opts = qemu_get_machine_opts();
+
+    kernel_filename = qemu_opt_get(machine_opts, "kernel");
+
+    memory_region_init_ram(nvm, NULL, "MSF2.envm", ENVM_SIZE,
+                           &error_fatal);
+    memory_region_init_alias(nvm_alias, NULL, "STM32F205.flash.alias",
+                             nvm, 0, ENVM_SIZE);
+    vmstate_register_ram_global(nvm);
+
+    memory_region_set_readonly(nvm, true);
+    memory_region_set_readonly(nvm_alias, true);
+
+    memory_region_add_subregion(system_memory, ENVM_BASE_ADDRESS, nvm);
+    memory_region_add_subregion(system_memory, 0, nvm_alias);
+
+    memory_region_init_ram(ddr, NULL, "MSF2.ddr", DDR_SIZE,
+                           &error_fatal);
+    vmstate_register_ram_global(ddr);
+    memory_region_add_subregion(system_memory, DDR_BASE_ADDRESS, ddr);
+
+    memory_region_init_ram(sram, NULL, "MSF2.sram", SRAM_SIZE,
+                           &error_fatal);
+    vmstate_register_ram_global(sram);
+    memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
+
+    nvic = armv7m_init(system_memory, ENVM_SIZE, 96,
+                       kernel_filename, "cortex-m3");
+
+    for (i = 0; i < MSF2_NUM_USARTS; i++) {
+        if (serial_hds[i]) {
+            serial_mm_init(get_system_memory(), usart_addr[i], 2,
+                           qdev_get_gpio_in(nvic, usart_irq[i]),
+                           115200, serial_hds[i], DEVICE_NATIVE_ENDIAN);
+        }
+    }
+
+    dev = qdev_create(NULL, "msf2-timer");
+    qdev_prop_set_uint32(dev, "clock-frequency", 83 * 1000000);
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, MSF2_TIMER_BASE);
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0,
+                           qdev_get_gpio_in(nvic, timer_irq[0]));
+    sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1,
+                           qdev_get_gpio_in(nvic, timer_irq[1]));
+
+    dev = qdev_create(NULL, "msf2-sysreg");
+    qdev_init_nofail(dev);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, MSF2_SYSREG_BASE);
+}
+
+static void msf2_machine_init(MachineClass *mc)
+{
+    mc->desc = "Microsemi Smart Fusion2 Development Kit";
+    mc->init = msf2_init;
+}
+
+DEFINE_MACHINE("smartfusion2", msf2_machine_init)
-- 
2.5.0
