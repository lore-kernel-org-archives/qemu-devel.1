Received: from eggs.gnu.org ([2001:4830:134:3::10]:56764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gIN5d-0000vF-0k
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gIN5b-00055d-MC
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 20:13:28 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri,  2 Nov 2018 01:13:01 +0100
Message-Id: <20181102001303.32640-6-f4bug@amsat.org>
In-Reply-To: <20181102001303.32640-1-f4bug@amsat.org>
References: <20181102001303.32640-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH for 3.2 v2 5/7] hw/arm/bcm2835: Add various
 unimplemented peripherals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Guenter Roeck <linux@roeck-us.net>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-arm@nongnu.org

Base addresses and sizes taken from the "BCM2835 ARM Peripherals"
datasheet from February 06 2012:
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/bcm2835_peripherals.c         | 26 ++++++++++++++++++++++++++
 include/hw/arm/bcm2835_peripherals.h | 10 ++++++++++
 include/hw/arm/raspi_platform.h      |  2 ++
 3 files changed, 38 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 6d742ffe37..108c058d17 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -21,6 +21,20 @@
 /* Capabilities for SD controller: no DMA, high-speed, default clocks etc. */
 #define BCM2835_SDHC_CAPAREG 0x52134b4
 
+static void create_unimp(BCM2835PeripheralState *ps,
+                         UnimplementedDeviceState *uds,
+                         const char *name, hwaddr ofs, hwaddr size)
+{
+    sysbus_init_child_obj(OBJECT(ps), name, uds,
+                          sizeof(UnimplementedDeviceState),
+                          TYPE_UNIMPLEMENTED_DEVICE);
+    qdev_prop_set_string(DEVICE(uds), "name", name);
+    qdev_prop_set_uint64(DEVICE(uds), "size", size);
+    object_property_set_bool(OBJECT(uds), true, "realized", &error_fatal);
+    memory_region_add_subregion(&ps->peri_mr, ofs,
+                                sysbus_mmio_get_region(SYS_BUS_DEVICE(uds), 0));
+}
+
 static void bcm2835_peripherals_init(Object *obj)
 {
     BCM2835PeripheralState *s = BCM2835_PERIPHERALS(obj);
@@ -334,6 +348,18 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         error_propagate(errp, err);
         return;
     }
+
+    create_unimp(s, &s->pm, "bcm2835-pm", PM_OFFSET, 0x1000);
+    create_unimp(s, &s->cprman, "bcm2835-cprman", CPRMAN_OFFSET, 0x1000);
+    create_unimp(s, &s->a2w, "bcm2835-a2w", 0x102000, 0x1000);
+    create_unimp(s, &s->i2s, "bcm2835-i2s", I2S_OFFSET, 0x100);
+    create_unimp(s, &s->smi, "bcm2835-smi", SMI_OFFSET, 0x100);
+    create_unimp(s, &s->spi0, "bcm2835-spi0", SPI0_OFFSET, 0x20);
+    create_unimp(s, &s->bscsl, "bcm2835-spis", BSC_SL_OFFSET, 0x100);
+    create_unimp(s, &s->i2c[0], "bcm2835-i2c0", BSC0_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[1], "bcm2835-i2c1", BSC1_OFFSET, 0x20);
+    create_unimp(s, &s->i2c[2], "bcm2835-i2c2", BSC2_OFFSET, 0x20);
+    create_unimp(s, &s->dwc2, "dwc-usb2", USB_OFFSET, 0x100);
 }
 
 static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index f5b193f670..6fb52d20a8 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -23,6 +23,7 @@
 #include "hw/sd/sdhci.h"
 #include "hw/sd/bcm2835_sdhost.h"
 #include "hw/gpio/bcm2835_gpio.h"
+#include "hw/misc/unimp.h"
 
 #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
 #define BCM2835_PERIPHERALS(obj) \
@@ -37,6 +38,9 @@ typedef struct BCM2835PeripheralState {
     MemoryRegion ram_alias[4];
     qemu_irq irq, fiq;
 
+    UnimplementedDeviceState pm;
+    UnimplementedDeviceState cprman;
+    UnimplementedDeviceState a2w;
     SysBusDevice *uart0;
     BCM2835AuxState aux;
     BCM2835FBState fb;
@@ -48,6 +52,12 @@ typedef struct BCM2835PeripheralState {
     SDHCIState sdhci;
     BCM2835SDHostState sdhost;
     BCM2835GpioState gpio;
+    UnimplementedDeviceState i2s;
+    UnimplementedDeviceState spi0;
+    UnimplementedDeviceState i2c[3];
+    UnimplementedDeviceState bscsl;
+    UnimplementedDeviceState smi;
+    UnimplementedDeviceState dwc2;
 } BCM2835PeripheralState;
 
 #endif /* BCM2835_PERIPHERALS_H */
diff --git a/include/hw/arm/raspi_platform.h b/include/hw/arm/raspi_platform.h
index 105876dc0b..ec14db236b 100644
--- a/include/hw/arm/raspi_platform.h
+++ b/include/hw/arm/raspi_platform.h
@@ -44,10 +44,12 @@
 #define I2S_OFFSET              0x203000
 #define SPI0_OFFSET             0x204000
 #define BSC0_OFFSET             0x205000 /* BSC0 I2C/TWI */
+#define BSC_SL_OFFSET           0x214000 /* SPI slave */
 #define AUX_OFFSET              0x215000 /* AUX: UART1/SPI1/SPI2 */
 #define EMMC_OFFSET             0x300000
 #define SMI_OFFSET              0x600000
 #define BSC1_OFFSET             0x804000 /* BSC1 I2C/TWI */
+#define BSC2_OFFSET             0x805000 /* BSC2 I2C/TWI */
 #define USB_OFFSET              0x980000 /* DTC_OTG USB controller */
 #define DMA15_OFFSET            0xE05000 /* DMA controller, channel 15 */
 
-- 
2.17.2
