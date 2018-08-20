Received: from eggs.gnu.org ([2001:4830:134:3::10]:42226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuK-0003m1-4D
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1frkuJ-0007UF-Cf
	for qemu-devel@nongnu.org; Mon, 20 Aug 2018 10:11:48 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Aug 2018 15:11:15 +0100
Message-Id: <20180820141116.9118-22-peter.maydell@linaro.org>
In-Reply-To: <20180820141116.9118-1-peter.maydell@linaro.org>
References: <20180820141116.9118-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 21/22] hw/arm/mps2-tz: Instantiate SPI
 controllers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The SPI controllers in the MPS2 AN505 board are PL022s.
We have a model of the PL022, so create these devices.

We don't currently model the LCD controller that sits behind
one of the PL022s; the others are intended to control devices
that sit on the FPGA's general purpose SPI connector or
"shield" expansion connectors.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/mps2-tz.c | 38 ++++++++++++++++++++++++++++++++------
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index d810e51a1b4..cedf605e20e 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -48,6 +48,7 @@
 #include "hw/misc/tz-msc.h"
 #include "hw/arm/iotkit.h"
 #include "hw/dma/pl080.h"
+#include "hw/ssi/pl022.h"
 #include "hw/devices.h"
 #include "net/net.h"
 #include "hw/core/split-irq.h"
@@ -73,7 +74,7 @@ typedef struct {
     MPS2FPGAIO fpgaio;
     TZPPC ppc[5];
     TZMPC ssram_mpc[3];
-    UnimplementedDeviceState spi[5];
+    PL022State spi[5];
     UnimplementedDeviceState i2c[4];
     UnimplementedDeviceState i2s_audio;
     UnimplementedDeviceState gpio[4];
@@ -324,6 +325,31 @@ static MemoryRegion *make_dma(MPS2TZMachineState *mms, void *opaque,
     return sysbus_mmio_get_region(s, 0);
 }
 
+static MemoryRegion *make_spi(MPS2TZMachineState *mms, void *opaque,
+                              const char *name, hwaddr size)
+{
+    /*
+     * The AN505 has five PL022 SPI controllers.
+     * One of these should have the LCD controller behind it; the others
+     * are connected only to the FPGA's "general purpose SPI connector"
+     * or "shield" expansion connectors.
+     * Note that if we do implement devices behind SPI, the chip select
+     * lines are set via the "MISC" register in the MPS2 FPGAIO device.
+     */
+    PL022State *spi = opaque;
+    int i = spi - &mms->spi[0];
+    DeviceState *iotkitdev = DEVICE(&mms->iotkit);
+    SysBusDevice *s;
+
+    sysbus_init_child_obj(OBJECT(mms), name, spi, sizeof(mms->spi[0]),
+                          TYPE_PL022);
+    object_property_set_bool(OBJECT(spi), true, "realized", &error_fatal);
+    s = SYS_BUS_DEVICE(spi);
+    sysbus_connect_irq(s, 0,
+                       qdev_get_gpio_in_named(iotkitdev, "EXP_IRQ", 51 + i));
+    return sysbus_mmio_get_region(s, 0);
+}
+
 static void mps2tz_common_init(MachineState *machine)
 {
     MPS2TZMachineState *mms = MPS2TZ_MACHINE(machine);
@@ -422,11 +448,11 @@ static void mps2tz_common_init(MachineState *machine)
         }, {
             .name = "apb_ppcexp1",
             .ports = {
-                { "spi0", make_unimp_dev, &mms->spi[0], 0x40205000, 0x1000 },
-                { "spi1", make_unimp_dev, &mms->spi[1], 0x40206000, 0x1000 },
-                { "spi2", make_unimp_dev, &mms->spi[2], 0x40209000, 0x1000 },
-                { "spi3", make_unimp_dev, &mms->spi[3], 0x4020a000, 0x1000 },
-                { "spi4", make_unimp_dev, &mms->spi[4], 0x4020b000, 0x1000 },
+                { "spi0", make_spi, &mms->spi[0], 0x40205000, 0x1000 },
+                { "spi1", make_spi, &mms->spi[1], 0x40206000, 0x1000 },
+                { "spi2", make_spi, &mms->spi[2], 0x40209000, 0x1000 },
+                { "spi3", make_spi, &mms->spi[3], 0x4020a000, 0x1000 },
+                { "spi4", make_spi, &mms->spi[4], 0x4020b000, 0x1000 },
                 { "uart0", make_uart, &mms->uart[0], 0x40200000, 0x1000 },
                 { "uart1", make_uart, &mms->uart[1], 0x40201000, 0x1000 },
                 { "uart2", make_uart, &mms->uart[2], 0x40202000, 0x1000 },
-- 
2.18.0
