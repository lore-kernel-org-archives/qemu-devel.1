Received: from eggs.gnu.org ([2001:4830:134:3::10]:51646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fEABV-0002BY-7o
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:05:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fEABT-0008QJ-Q6
	for qemu-devel@nongnu.org; Thu, 03 May 2018 05:05:53 -0400
Sender: "joel.stan@gmail.com" <joel.stan@gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu,  3 May 2018 18:35:31 +0930
Message-Id: <20180503090532.3113-2-joel@jms.id.au>
In-Reply-To: <20180503090532.3113-1-joel@jms.id.au>
References: <20180503090532.3113-1-joel@jms.id.au>
Subject: [Qemu-devel] [PATCH 1/2] arm: Add Nordic Semiconductor nRF51 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, Andrew Jeffery <andrew@aj.id.au>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>

The nRF51 is a Cortex-M0 microcontroller with an on-board radio module,
plus other common ARM SoC peripherals.

 http://infocenter.nordicsemi.com/pdf/nRF51_RM_v3.0.pdf

This defines a basic model of the CPU and memory, with no peripherals
implemented at this stage.

Signed-off-by: Joel Stanley <joel@jms.id.au>
---
 default-configs/arm-softmmu.mak |   1 +
 hw/arm/Makefile.objs            |   1 +
 hw/arm/nrf51_soc.c              | 101 ++++++++++++++++++++++++++++++++
 include/hw/arm/nrf51_soc.h      |  31 ++++++++++
 4 files changed, 134 insertions(+)
 create mode 100644 hw/arm/nrf51_soc.c
 create mode 100644 include/hw/arm/nrf51_soc.h

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index dd29e741c221..543ea965dae0 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -99,6 +99,7 @@ CONFIG_STM32F2XX_SYSCFG=y
 CONFIG_STM32F2XX_ADC=y
 CONFIG_STM32F2XX_SPI=y
 CONFIG_STM32F205_SOC=y
+CONFIG_NRF51_SOC=y
 
 CONFIG_CMSDK_APB_TIMER=y
 CONFIG_CMSDK_APB_UART=y
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 2885e3e2340b..1d7211850454 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -35,3 +35,4 @@ obj-$(CONFIG_MPS2) += mps2-tz.o
 obj-$(CONFIG_MSF2) += msf2-soc.o msf2-som.o
 obj-$(CONFIG_IOTKIT) += iotkit.o
 obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
+obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
new file mode 100644
index 000000000000..a2e3d6f013f0
--- /dev/null
+++ b/hw/arm/nrf51_soc.c
@@ -0,0 +1,101 @@
+/*
+ * Nordic Semiconductor nRF51 SoC
+ *
+ * Copyright 2018 Joel Stanley <joel@jms.id.au>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qapi/error.h"
+#include "qemu-common.h"
+#include "hw/arm/arm.h"
+#include "hw/sysbus.h"
+#include "hw/boards.h"
+#include "hw/devices.h"
+#include "hw/misc/unimp.h"
+#include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
+#include "qemu/log.h"
+#include "cpu.h"
+
+#include "hw/arm/nrf51_soc.h"
+
+#define IOMEM_BASE      0x40000000
+#define IOMEM_SIZE      0x20000000
+
+#define FLASH_BASE      0x00000000
+#define FLASH_SIZE      (144 * 1024)
+
+#define SRAM_BASE       0x20000000
+#define SRAM_SIZE       (6 * 1024)
+
+static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
+{
+    NRF51State *s = NRF51_SOC(dev_soc);
+    DeviceState *nvic;
+    Error *err = NULL;
+
+    /* IO space */
+    create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
+
+    /* FICR */
+    create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
+
+    MemoryRegion *system_memory = get_system_memory();
+    MemoryRegion *sram = g_new(MemoryRegion, 1);
+    MemoryRegion *flash = g_new(MemoryRegion, 1);
+
+    memory_region_init_ram_nomigrate(flash, NULL, "nrf51.flash", FLASH_SIZE,
+            &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    vmstate_register_ram_global(flash);
+    memory_region_set_readonly(flash, true);
+
+    memory_region_add_subregion(system_memory, FLASH_BASE, flash);
+
+    memory_region_init_ram_nomigrate(sram, NULL, "nrf51.sram", SRAM_SIZE,
+            &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    vmstate_register_ram_global(sram);
+    memory_region_add_subregion(system_memory, SRAM_BASE, sram);
+
+    /* TODO: implement a cortex m0 and update this */
+    nvic = armv7m_init(get_system_memory(), FLASH_SIZE, 96,
+            s->kernel_filename, ARM_CPU_TYPE_NAME("cortex-m3"));
+}
+
+static Property nrf51_soc_properties[] = {
+    DEFINE_PROP_STRING("kernel-filename", NRF51State, kernel_filename),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void nrf51_soc_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->realize = nrf51_soc_realize;
+    dc->props = nrf51_soc_properties;
+}
+
+static const TypeInfo nrf51_soc_info = {
+    .name          = TYPE_NRF51_SOC,
+    .parent        = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(NRF51State),
+    .class_init    = nrf51_soc_class_init,
+};
+
+static void nrf51_soc_types(void)
+{
+    type_register_static(&nrf51_soc_info);
+}
+type_init(nrf51_soc_types)
+
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
new file mode 100644
index 000000000000..422224bf1b0a
--- /dev/null
+++ b/include/hw/arm/nrf51_soc.h
@@ -0,0 +1,31 @@
+/*
+ * Nordic Semiconductor nRF51  SoC
+ *
+ * Copyright 2018 Joel Stanley <joel@jms.id.au>
+ *
+ * This code is licensed under the GPL version 2 or later.  See
+ * the COPYING file in the top-level directory.
+ */
+
+#ifndef NRF51_SOC_H
+#define NRF51_SOC_H
+
+#include "qemu/osdep.h"
+#include "hw/sysbus.h"
+
+#define TYPE_NRF51_SOC "nrf51-soc"
+#define NRF51_SOC(obj) \
+    OBJECT_CHECK(NRF51State, (obj), TYPE_NRF51_SOC)
+
+typedef struct NRF51State {
+    /*< private >*/
+    SysBusDevice parent_obj;
+
+    /*< public >*/
+    char *kernel_filename;
+
+    MemoryRegion iomem;
+} NRF51State;
+
+#endif
+
-- 
2.17.0
