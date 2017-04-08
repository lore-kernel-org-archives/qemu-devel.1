Received: from eggs.gnu.org ([2001:4830:134:3::10]:37999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <omar.rizwan@gmail.com>) id 1cwj9w-00060w-CF
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 01:43:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <omar.rizwan@gmail.com>) id 1cwj9t-0001ob-7y
	for qemu-devel@nongnu.org; Sat, 08 Apr 2017 01:43:40 -0400
From: Omar Rizwan <omar.rizwan@gmail.com>
Date: Fri,  7 Apr 2017 22:43:18 -0700
Message-Id: <20170408054318.19830-1-omar.rizwan@gmail.com>
Subject: [Qemu-devel] [PATCH] raspi: Add Raspberry Pi 1 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, Andrew.Baumann@microsoft.com, Omar Rizwan <omar.rizwan@gmail.com>

Signed-off-by: Omar Rizwan <omar.rizwan@gmail.com>
---
 hw/arm/Makefile.objs         |   2 +-
 hw/arm/bcm2835.c             | 119 +++++++++++++++++++++++++++++++++++++++++++
 hw/arm/bcm2835_peripherals.c |   1 +
 hw/arm/raspi.c               |  47 ++++++++++++++---
 include/hw/arm/bcm2835.h     |  31 +++++++++++
 5 files changed, 191 insertions(+), 9 deletions(-)
 create mode 100644 hw/arm/bcm2835.c
 create mode 100644 include/hw/arm/bcm2835.h

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 4c5c4ee..77ef47f 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -11,7 +11,7 @@ obj-y += armv7m.o exynos4210.o pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
 obj-$(CONFIG_DIGIC) += digic.o
 obj-y += omap1.o omap2.o strongarm.o
 obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
-obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
+obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2835.o bcm2836.o raspi.o
 obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
 obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp.o xlnx-ep108.o
 obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
diff --git a/hw/arm/bcm2835.c b/hw/arm/bcm2835.c
new file mode 100644
index 0000000..b19b86c
--- /dev/null
+++ b/hw/arm/bcm2835.c
@@ -0,0 +1,119 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * Upstreaming code cleanup [including bcm2835_*] (c) 2013 Jan Petrous
+ *
+ * Raspberry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
+ * Written by Andrew Baumann
+ *
+ * Rebase onto master (c) 2017 Omar Rizwan
+ *
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "hw/arm/bcm2835.h"
+#include "hw/arm/raspi_platform.h"
+#include "hw/sysbus.h"
+#include "exec/address-spaces.h"
+
+/* Peripheral base address seen by the CPU */
+#define BCM2835_PERI_BASE       0x20000000
+
+static void bcm2835_init(Object *obj)
+{
+    BCM2835State *s = BCM2835(obj);
+
+    object_initialize(&s->cpu, sizeof(s->cpu), "arm1176-" TYPE_ARM_CPU);
+    object_property_add_child(obj, "cpu", OBJECT(&s->cpu), &error_abort);
+
+    object_initialize(&s->peripherals, sizeof(s->peripherals),
+                      TYPE_BCM2835_PERIPHERALS);
+    object_property_add_child(obj, "peripherals", OBJECT(&s->peripherals),
+                              &error_abort);
+    object_property_add_alias(obj, "board-rev", OBJECT(&s->peripherals),
+                              "board-rev", &error_abort);
+    object_property_add_alias(obj, "vcram-size", OBJECT(&s->peripherals),
+                              "vcram-size", &error_abort);
+    qdev_set_parent_bus(DEVICE(&s->peripherals), sysbus_get_default());
+}
+
+static void bcm2835_realize(DeviceState *dev, Error **errp)
+{
+    BCM2835State *s = BCM2835(dev);
+    Object *obj;
+    Error *err = NULL;
+
+    /* common peripherals from bcm2835 */
+    obj = object_property_get_link(OBJECT(dev), "ram", &err);
+    if (obj == NULL) {
+        error_setg(errp, "%s: required ram link not found: %s",
+                   __func__, error_get_pretty(err));
+        return;
+    }
+
+    object_property_add_const_link(OBJECT(&s->peripherals), "ram", obj, &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_set_bool(OBJECT(&s->peripherals), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->peripherals),
+                              "sd-bus", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 0,
+                            BCM2835_PERI_BASE, 1);
+
+    sysbus_mmio_map_overlap(SYS_BUS_DEVICE(&s->peripherals), 1,
+                            0x40000000, 1);
+
+    object_property_set_bool(OBJECT(&s->cpu), true, "realized", &err);
+    if (err) {
+        error_report_err(err);
+        exit(1);
+    }
+
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 0,
+                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_IRQ));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->peripherals), 1,
+                       qdev_get_gpio_in(DEVICE(&s->cpu), ARM_CPU_FIQ));
+
+}
+
+static void bcm2835_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+
+    dc->realize = bcm2835_realize;
+
+    /*
+     * Reason: creates an ARM CPU, thus use after free(), see
+     * arm_cpu_class_init()
+     */
+    dc->cannot_destroy_with_object_finalize_yet = true;
+}
+
+static const TypeInfo bcm2835_type_info = {
+    .name = TYPE_BCM2835,
+    .parent = TYPE_SYS_BUS_DEVICE,
+    .instance_size = sizeof(BCM2835State),
+    .instance_init = bcm2835_init,
+    .class_init = bcm2835_class_init,
+};
+
+static void bcm2835_register_types(void)
+{
+    type_register_static(&bcm2835_type_info);
+}
+
+type_init(bcm2835_register_types)
diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 369ef1e..a6cd54a 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -34,6 +34,7 @@ static void bcm2835_peripherals_init(Object *obj)
     /* Internal memory region for peripheral bus addresses (not exported) */
     memory_region_init(&s->gpu_bus_mr, obj, "bcm2835-gpu", (uint64_t)1 << 32);
     object_property_add_child(obj, "gpu-bus", OBJECT(&s->gpu_bus_mr), NULL);
+    sysbus_init_mmio(SYS_BUS_DEVICE(s), &s->gpu_bus_mr);
 
     /* Internal memory region for request/response communication with
      * mailbox-addressable peripherals (not exported)
diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index 2b295f1..dca6077 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -2,9 +2,11 @@
  * Raspberry Pi emulation (c) 2012 Gregory Estrade
  * Upstreaming code cleanup [including bcm2835_*] (c) 2013 Jan Petrous
  *
- * Rasperry Pi 2 emulation Copyright (c) 2015, Microsoft
+ * Raspberry Pi 2 emulation Copyright (c) 2015, Microsoft
  * Written by Andrew Baumann
  *
+ * Raspberry Pi 1 rebase onto master (c) 2017, Omar Rizwan
+ *
  * This code is licensed under the GNU GPLv2 and later.
  */
 
@@ -12,6 +14,7 @@
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
+#include "hw/arm/bcm2835.h"
 #include "hw/arm/bcm2836.h"
 #include "qemu/error-report.h"
 #include "hw/boards.h"
@@ -27,6 +30,11 @@
 /* Table of Linux board IDs for different Pi versions */
 static const int raspi_boardid[] = {[1] = 0xc42, [2] = 0xc43};
 
+/* Table of board revisions:
+ * https://github.com/AndrewFromMelbourne/raspberry_pi_revision/blob/2764c19983fb7b1ef8cb21031e94c293703afa2e/README.md
+ */
+static const uint32_t raspi_boardrev[] = {[1] = 0x10, [2] = 0xa21041};
+
 typedef struct RasPiState {
     BCM2836State soc;
     MemoryRegion ram;
@@ -113,7 +121,8 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     arm_load_kernel(ARM_CPU(first_cpu), &binfo);
 }
 
-static void raspi2_init(MachineState *machine)
+static void raspi_machine_init(MachineState *machine, int version,
+                               const char *soc_type)
 {
     RasPiState *s = g_new0(RasPiState, 1);
     uint32_t vcram_size;
@@ -122,7 +131,7 @@ static void raspi2_init(MachineState *machine)
     BusState *bus;
     DeviceState *carddev;
 
-    object_initialize(&s->soc, sizeof(s->soc), TYPE_BCM2836);
+    object_initialize(&s->soc, sizeof(s->soc), soc_type);
     object_property_add_child(OBJECT(machine), "soc", OBJECT(&s->soc),
                               &error_abort);
 
@@ -135,10 +144,12 @@ static void raspi2_init(MachineState *machine)
     /* Setup the SOC */
     object_property_add_const_link(OBJECT(&s->soc), "ram", OBJECT(&s->ram),
                                    &error_abort);
-    object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
-                            &error_abort);
-    object_property_set_int(OBJECT(&s->soc), 0xa21041, "board-rev",
-                            &error_abort);
+    if (version == 2) {
+        object_property_set_int(OBJECT(&s->soc), smp_cpus, "enabled-cpus",
+                                &error_abort);
+    }
+    object_property_set_int(OBJECT(&s->soc), raspi_boardrev[version],
+                            "board-rev", &error_abort);
     object_property_set_bool(OBJECT(&s->soc), true, "realized", &error_abort);
 
     /* Create and plug in the SD cards */
@@ -155,9 +166,29 @@ static void raspi2_init(MachineState *machine)
 
     vcram_size = object_property_get_int(OBJECT(&s->soc), "vcram-size",
                                          &error_abort);
-    setup_boot(machine, 2, machine->ram_size - vcram_size);
+    setup_boot(machine, version, machine->ram_size - vcram_size);
+}
+
+static void raspi1_init(MachineState *machine)
+{
+    raspi_machine_init(machine, 1, TYPE_BCM2835);
 }
+static void raspi1_machine_init(MachineClass *mc)
+{
+    mc->desc = "Raspberry Pi";
+    mc->init = raspi1_init;
+    mc->block_default_type = IF_SD;
+    mc->no_parallel = 1;
+    mc->no_floppy = 1;
+    mc->no_cdrom = 1;
+    mc->default_ram_size = 512 * 1024 * 1024;
+};
+DEFINE_MACHINE("raspi", raspi1_machine_init)
 
+static void raspi2_init(MachineState *machine)
+{
+    raspi_machine_init(machine, 2, TYPE_BCM2836);
+}
 static void raspi2_machine_init(MachineClass *mc)
 {
     mc->desc = "Raspberry Pi 2";
diff --git a/include/hw/arm/bcm2835.h b/include/hw/arm/bcm2835.h
new file mode 100644
index 0000000..c93c4ef
--- /dev/null
+++ b/include/hw/arm/bcm2835.h
@@ -0,0 +1,31 @@
+/*
+ * Raspberry Pi emulation (c) 2012 Gregory Estrade
+ * Upstreaming code cleanup [including bcm2835_*] (c) 2013 Jan Petrous
+ *
+ * Raspberry Pi 2 emulation and refactoring Copyright (c) 2015, Microsoft
+ * Written by Andrew Baumann
+ *
+ * Rebase onto master (c) 2017 Omar Rizwan
+ *
+ * This code is licensed under the GNU GPLv2 and later.
+ */
+
+#ifndef BCM2835_H
+#define BCM2835_H
+
+#include "hw/arm/arm.h"
+#include "hw/arm/bcm2835_peripherals.h"
+
+#define TYPE_BCM2835 "bcm2835"
+#define BCM2835(obj) OBJECT_CHECK(BCM2835State, (obj), TYPE_BCM2835)
+
+typedef struct BCM2835State {
+    /*< private >*/
+    DeviceState parent_obj;
+    /*< public >*/
+
+    ARMCPU cpu;
+    BCM2835PeripheralState peripherals;
+} BCM2835State;
+
+#endif /* BCM2835_H */
-- 
2.10.1 (Apple Git-78)
