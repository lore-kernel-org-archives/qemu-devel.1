Received: from eggs.gnu.org ([2001:4830:134:3::10]:56449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d88Gf-0008AL-Ul
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:45:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sundeep.lkml@gmail.com>) id 1d88Gd-0005Ju-Pu
	for qemu-devel@nongnu.org; Tue, 09 May 2017 12:45:45 -0400
From: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Date: Tue,  9 May 2017 22:14:46 +0530
Message-Id: <1494348286-10253-6-git-send-email-sundeep.lkml@gmail.com>
In-Reply-To: <1494348286-10253-1-git-send-email-sundeep.lkml@gmail.com>
References: <1494348286-10253-1-git-send-email-sundeep.lkml@gmail.com>
Subject: [Qemu-devel] [Qemu-devel PATCH 5/5] msf2: Add Emcraft's
 Smartfusion2 SOM kit.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, crosthwaite.peter@gmail.com, alistair23@gmail.com, Subbaraya Sundeep <sundeep.lkml@gmail.com>

Emulated Emcraft's Smartfusion2 System On Module starter
kit.

Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
---
 hw/arm/Makefile.objs |  1 +
 hw/arm/msf2-som.c    | 67 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)
 create mode 100644 hw/arm/msf2-som.c

diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index ae5e4a3..b626a43 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -5,6 +5,7 @@ obj-y += omap_sx1.o palm.o realview.o spitz.o stellaris.o msf2-soc.o
 obj-y += tosa.o versatilepb.o vexpress.o virt.o xilinx_zynq.o z2.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-y += netduino2.o
+obj-y += msf2-som.o
 obj-y += sysbus-fdt.o
 
 obj-y += armv7m.o exynos4210.o pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
diff --git a/hw/arm/msf2-som.c b/hw/arm/msf2-som.c
new file mode 100644
index 0000000..bc44169
--- /dev/null
+++ b/hw/arm/msf2-som.c
@@ -0,0 +1,67 @@
+/*
+ * SmartFusion2 SOM starter kit(from Emcraft) emulation.
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
+#include "hw/boards.h"
+#include "hw/arm/msf2-soc.h"
+#include "hw/arm/arm.h"
+
+static void msf2_init(MachineState *machine)
+{
+    DeviceState *dev;
+    DeviceState *spi_flash;
+    MSF2State *soc;
+    DriveInfo *dinfo = drive_get_next(IF_MTD);
+    qemu_irq cs_line;
+    SSIBus *spi_bus;
+
+    dev = qdev_create(NULL, TYPE_MSF2_SOC);
+    object_property_set_bool(OBJECT(dev), true, "realized", &error_fatal);
+
+    soc = MSF2_SOC(dev);
+
+    /* Attach SPI flash to SPI0 controller */
+    spi_bus = (SSIBus *)qdev_get_child_bus(dev, "spi0");
+    spi_flash = ssi_create_slave_no_init(spi_bus, "s25sl12801");
+    qdev_prop_set_uint8(spi_flash, "spansion-cr2nv", 1);
+    if (dinfo) {
+        qdev_prop_set_drive(spi_flash, "drive", blk_by_legacy_dinfo(dinfo),
+                                    &error_fatal);
+    }
+    qdev_init_nofail(spi_flash);
+    cs_line = qdev_get_gpio_in_named(spi_flash, SSI_GPIO_CS, 0);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&soc->spi[0]), 1, cs_line);
+
+    armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
+                       ENVM_SIZE);
+}
+
+static void msf2_machine_init(MachineClass *mc)
+{
+    mc->desc = "SmartFusion2 SOM kit from Emcraft";
+    mc->init = msf2_init;
+}
+
+DEFINE_MACHINE("smartfusion2-som", msf2_machine_init)
-- 
2.5.0
