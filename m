Received: from eggs.gnu.org ([2001:4830:134:3::10]:52620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSU-00052j-9s
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSG-0004ox-N7
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:30 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37122)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1doqSG-0004oE-Ai
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 08:26:16 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1doqSF-0005Wx-Bk
	for qemu-devel@nongnu.org; Mon, 04 Sep 2017 13:26:15 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon,  4 Sep 2017 13:25:49 +0100
Message-Id: <1504527967-29248-19-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
References: <1504527967-29248-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 18/36] hw/arm: use defined type name instead of
 hard-coded string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/armv7m.c      |  4 ++--
 hw/arm/exynos4210.c  |  4 ++--
 hw/arm/highbank.c    | 11 +++++++----
 hw/arm/realview.c    |  6 ++++--
 hw/arm/vexpress.c    |  6 ++++--
 hw/arm/xilinx_zynq.c | 14 ++++++++------
 6 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index c8a11f2..d2477e8 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -146,7 +146,7 @@ static void armv7m_instance_init(Object *obj)
                              &error_abort);
     memory_region_init(&s->container, obj, "armv7m-container", UINT64_MAX);
 
-    object_initialize(&s->nvic, sizeof(s->nvic), "armv7m_nvic");
+    object_initialize(&s->nvic, sizeof(s->nvic), TYPE_NVIC);
     qdev_set_parent_bus(DEVICE(&s->nvic), sysbus_get_default());
     object_property_add_alias(obj, "num-irq",
                               OBJECT(&s->nvic), "num-irq", &error_abort);
@@ -293,7 +293,7 @@ DeviceState *armv7m_init(MemoryRegion *system_memory, int mem_size, int num_irq,
         cpu_model = "cortex-m3";
     }
 
-    armv7m = qdev_create(NULL, "armv7m");
+    armv7m = qdev_create(NULL, TYPE_ARMV7M);
     qdev_prop_set_uint32(armv7m, "num-irq", num_irq);
     qdev_prop_set_string(armv7m, "cpu-model", cpu_model);
     object_property_set_link(OBJECT(armv7m), OBJECT(get_system_memory()),
diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index f9e79f3..ee1438a 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -33,7 +33,7 @@
 #include "hw/arm/arm.h"
 #include "hw/loader.h"
 #include "hw/arm/exynos4210.h"
-#include "hw/sd/sd.h"
+#include "hw/sd/sdhci.h"
 #include "hw/usb/hcd-ehci.h"
 
 #define EXYNOS4210_CHIPID_ADDR         0x10000000
@@ -381,7 +381,7 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
         BlockBackend *blk;
         DriveInfo *di;
 
-        dev = qdev_create(NULL, "generic-sdhci");
+        dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
         qdev_prop_set_uint32(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITIES);
         qdev_init_nofail(dev);
 
diff --git a/hw/arm/highbank.c b/hw/arm/highbank.c
index 20e60f1..942d5a8 100644
--- a/hw/arm/highbank.c
+++ b/hw/arm/highbank.c
@@ -31,6 +31,9 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
+#include "hw/ide/ahci.h"
+#include "hw/cpu/a9mpcore.h"
+#include "hw/cpu/a15mpcore.h"
 
 #define SMP_BOOT_ADDR           0x100
 #define SMP_BOOT_REG            0x40
@@ -300,10 +303,10 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, 0xfff12000);
 
-        dev = qdev_create(NULL, "a9mpcore_priv");
+        dev = qdev_create(NULL, TYPE_A9MPCORE_PRIV);
         break;
     case CALXEDA_MIDWAY:
-        dev = qdev_create(NULL, "a15mpcore_priv");
+        dev = qdev_create(NULL, TYPE_A15MPCORE_PRIV);
         break;
     }
     qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
@@ -329,7 +332,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     sysbus_connect_irq(busdev, 0, pic[18]);
     pl011_create(0xfff36000, pic[20], serial_hds[0]);
 
-    dev = qdev_create(NULL, "highbank-regs");
+    dev = qdev_create(NULL, TYPE_HIGHBANK_REGISTERS);
     qdev_init_nofail(dev);
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0xfff3c000);
@@ -341,7 +344,7 @@ static void calxeda_init(MachineState *machine, enum cxmachines machine_id)
     sysbus_create_simple("pl031", 0xfff35000, pic[19]);
     sysbus_create_simple("pl022", 0xfff39000, pic[23]);
 
-    sysbus_create_simple("sysbus-ahci", 0xffe08000, pic[83]);
+    sysbus_create_simple(TYPE_SYSBUS_AHCI, 0xffe08000, pic[83]);
 
     if (nd_table[0].used) {
         qemu_check_nic_model(&nd_table[0], "xgmac");
diff --git a/hw/arm/realview.c b/hw/arm/realview.c
index 76ff557..2736156 100644
--- a/hw/arm/realview.c
+++ b/hw/arm/realview.c
@@ -24,6 +24,8 @@
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 #include "hw/char/pl011.h"
+#include "hw/cpu/a9mpcore.h"
+#include "hw/intc/realview_gic.h"
 
 #define SMP_BOOT_ADDR 0xe0000000
 #define SMP_BOOTREG_ADDR 0x10000030
@@ -172,7 +174,7 @@ static void realview_init(MachineState *machine,
     sysbus_mmio_map(SYS_BUS_DEVICE(sysctl), 0, 0x10000000);
 
     if (is_mpcore) {
-        dev = qdev_create(NULL, is_pb ? "a9mpcore_priv": "realview_mpcore");
+        dev = qdev_create(NULL, is_pb ? TYPE_A9MPCORE_PRIV : "realview_mpcore");
         qdev_prop_set_uint32(dev, "num-cpu", smp_cpus);
         qdev_init_nofail(dev);
         busdev = SYS_BUS_DEVICE(dev);
@@ -186,7 +188,7 @@ static void realview_init(MachineState *machine,
     } else {
         uint32_t gic_addr = is_pb ? 0x1e000000 : 0x10040000;
         /* For now just create the nIRQ GIC, and ignore the others.  */
-        dev = sysbus_create_simple("realview_gic", gic_addr, cpu_irq[0]);
+        dev = sysbus_create_simple(TYPE_REALVIEW_GIC, gic_addr, cpu_irq[0]);
     }
     for (n = 0; n < 64; n++) {
         pic[n] = qdev_get_gpio_in(dev, n);
diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
index 528c65d..571dd36 100644
--- a/hw/arm/vexpress.c
+++ b/hw/arm/vexpress.c
@@ -40,6 +40,8 @@
 #include "qemu/error-report.h"
 #include <libfdt.h>
 #include "hw/char/pl011.h"
+#include "hw/cpu/a9mpcore.h"
+#include "hw/cpu/a15mpcore.h"
 
 #define VEXPRESS_BOARD_ID 0x8e0
 #define VEXPRESS_FLASH_SIZE (64 * 1024 * 1024)
@@ -293,7 +295,7 @@ static void a9_daughterboard_init(const VexpressMachineState *vms,
     memory_region_add_subregion(sysmem, 0x60000000, ram);
 
     /* 0x1e000000 A9MPCore (SCU) private memory region */
-    init_cpus(cpu_model, "a9mpcore_priv", 0x1e000000, pic, vms->secure);
+    init_cpus(cpu_model, TYPE_A9MPCORE_PRIV, 0x1e000000, pic, vms->secure);
 
     /* Daughterboard peripherals : 0x10020000 .. 0x20000000 */
 
@@ -378,7 +380,7 @@ static void a15_daughterboard_init(const VexpressMachineState *vms,
     memory_region_add_subregion(sysmem, 0x80000000, ram);
 
     /* 0x2c000000 A15MPCore private memory region (GIC) */
-    init_cpus(cpu_model, "a15mpcore_priv", 0x2c000000, pic, vms->secure);
+    init_cpus(cpu_model, TYPE_A15MPCORE_PRIV, 0x2c000000, pic, vms->secure);
 
     /* A15 daughterboard peripherals: */
 
diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index 6b11a75..a750959 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -31,8 +31,10 @@
 #include "hw/misc/zynq-xadc.h"
 #include "hw/ssi/ssi.h"
 #include "qemu/error-report.h"
-#include "hw/sd/sd.h"
+#include "hw/sd/sdhci.h"
 #include "hw/char/cadence_uart.h"
+#include "hw/net/cadence_gem.h"
+#include "hw/cpu/a9mpcore.h"
 
 #define NUM_SPI_FLASHES 4
 #define NUM_QSPI_FLASHES 2
@@ -96,9 +98,9 @@ static void gem_init(NICInfo *nd, uint32_t base, qemu_irq irq)
     DeviceState *dev;
     SysBusDevice *s;
 
-    dev = qdev_create(NULL, "cadence_gem");
+    dev = qdev_create(NULL, TYPE_CADENCE_GEM);
     if (nd->used) {
-        qemu_check_nic_model(nd, "cadence_gem");
+        qemu_check_nic_model(nd, TYPE_CADENCE_GEM);
         qdev_set_nic_properties(dev, nd);
     }
     qdev_init_nofail(dev);
@@ -222,7 +224,7 @@ static void zynq_init(MachineState *machine)
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8000000);
 
-    dev = qdev_create(NULL, "a9mpcore_priv");
+    dev = qdev_create(NULL, TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", 1);
     qdev_init_nofail(dev);
     busdev = SYS_BUS_DEVICE(dev);
@@ -252,7 +254,7 @@ static void zynq_init(MachineState *machine)
     gem_init(&nd_table[0], 0xE000B000, pic[54-IRQ_OFFSET]);
     gem_init(&nd_table[1], 0xE000C000, pic[77-IRQ_OFFSET]);
 
-    dev = qdev_create(NULL, "generic-sdhci");
+    dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xE0100000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[56-IRQ_OFFSET]);
@@ -263,7 +265,7 @@ static void zynq_init(MachineState *machine)
     qdev_prop_set_drive(carddev, "drive", blk, &error_fatal);
     object_property_set_bool(OBJECT(carddev), true, "realized", &error_fatal);
 
-    dev = qdev_create(NULL, "generic-sdhci");
+    dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
     qdev_init_nofail(dev);
     sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xE0101000);
     sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[79-IRQ_OFFSET]);
-- 
2.7.4
