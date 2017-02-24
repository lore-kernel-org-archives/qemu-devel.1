Received: from eggs.gnu.org ([2001:4830:134:3::10]:50442)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1chIuz-0003Pj-E1
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:40:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1chIuy-0001DM-EY
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:40:29 -0500
From: Clement Deschamps <clement.deschamps@antfield.fr>
Date: Fri, 24 Feb 2017 17:40:21 +0100
Message-Id: <20170224164021.9066-5-clement.deschamps@antfield.fr>
In-Reply-To: <20170224164021.9066-1-clement.deschamps@antfield.fr>
References: <20170224164021.9066-1-clement.deschamps@antfield.fr>
Subject: [Qemu-devel] [PATCH v3 4/4] bcm2835: add sdhost and gpio controllers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Clement Deschamps <clement.deschamps@antfield.fr>, qemu-arm@nongnu.org, peter.maydell@linaro.org, andrew.baumann@microsoft.com

This adds the bcm2835_sdhost and bcm2835_gpio to the BCM2835 platform.

For supporting the SD controller selection (alternate function of GPIOs
48-53), the bcm2835_gpio now exposes an sdbus.
It also has a link to both the sdbus of sdhci and sdhost controllers,
and the card is reparented from one bus to another when the alternate
function of GPIOs 48-53 is modified.

Signed-off-by: Clement Deschamps <clement.deschamps@antfield.fr>
---
 hw/arm/bcm2835_peripherals.c         | 43 ++++++++++++++++++++++++++++++++++--
 include/hw/arm/bcm2835_peripherals.h |  4 ++++
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 2e641a3989..33398b04db 100644
--- a/hw/arm/bcm2835_peripherals.c
+++ b/hw/arm/bcm2835_peripherals.c
@@ -91,6 +91,11 @@ static void bcm2835_peripherals_init(Object *obj)
     object_property_add_child(obj, "sdhci", OBJECT(&s->sdhci), NULL);
     qdev_set_parent_bus(DEVICE(&s->sdhci), sysbus_get_default());
 
+    /* SDHOST */
+    object_initialize(&s->sdhost, sizeof(s->sdhost), TYPE_BCM2835_SDHOST);
+    object_property_add_child(obj, "sdhost", OBJECT(&s->sdhost), NULL);
+    qdev_set_parent_bus(DEVICE(&s->sdhost), sysbus_get_default());
+
     /* DMA Channels */
     object_initialize(&s->dma, sizeof(s->dma), TYPE_BCM2835_DMA);
     object_property_add_child(obj, "dma", OBJECT(&s->dma), NULL);
@@ -98,6 +103,16 @@ static void bcm2835_peripherals_init(Object *obj)
 
     object_property_add_const_link(OBJECT(&s->dma), "dma-mr",
                                    OBJECT(&s->gpu_bus_mr), &error_abort);
+
+    /* GPIO */
+    object_initialize(&s->gpio, sizeof(s->gpio), TYPE_BCM2835_GPIO);
+    object_property_add_child(obj, "gpio", OBJECT(&s->gpio), NULL);
+    qdev_set_parent_bus(DEVICE(&s->gpio), sysbus_get_default());
+
+    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhci",
+                                   OBJECT(&s->sdhci.sdbus), &error_abort);
+    object_property_add_const_link(OBJECT(&s->gpio), "sdbus-sdhost",
+                                   OBJECT(&s->sdhost.sdbus), &error_abort);
 }
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -252,13 +267,20 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
     sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhci), 0,
         qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
                                INTERRUPT_ARASANSDIO));
-    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->sdhci), "sd-bus",
-                              &err);
+
+    /* SDHOST */
+    object_property_set_bool(OBJECT(&s->sdhost), true, "realized", &err);
     if (err) {
         error_propagate(errp, err);
         return;
     }
 
+    memory_region_add_subregion(&s->peri_mr, MMCI0_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sdhost), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhost), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_SDIO));
+
     /* DMA Channels */
     object_property_set_bool(OBJECT(&s->dma), true, "realized", &err);
     if (err) {
@@ -277,6 +299,23 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
                                                   BCM2835_IC_GPU_IRQ,
                                                   INTERRUPT_DMA0 + n));
     }
+
+    /* GPIO */
+    object_property_set_bool(OBJECT(&s->gpio), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, GPIO_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->gpio), 0));
+
+    object_property_add_alias(OBJECT(s), "sd-bus", OBJECT(&s->gpio), "sd-bus",
+                              &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
 }
 
 static void bcm2835_peripherals_class_init(ObjectClass *oc, void *data)
diff --git a/include/hw/arm/bcm2835_peripherals.h b/include/hw/arm/bcm2835_peripherals.h
index e12ae3721a..4c87859e31 100644
--- a/include/hw/arm/bcm2835_peripherals.h
+++ b/include/hw/arm/bcm2835_peripherals.h
@@ -21,6 +21,8 @@
 #include "hw/misc/bcm2835_property.h"
 #include "hw/misc/bcm2835_mbox.h"
 #include "hw/sd/sdhci.h"
+#include "hw/sd/bcm2835_sdhost.h"
+#include "hw/gpio/bcm2835_gpio.h"
 
 #define TYPE_BCM2835_PERIPHERALS "bcm2835-peripherals"
 #define BCM2835_PERIPHERALS(obj) \
@@ -43,6 +45,8 @@ typedef struct BCM2835PeripheralState {
     BCM2835PropertyState property;
     BCM2835MboxState mboxes;
     SDHCIState sdhci;
+    BCM2835SDHostState sdhost;
+    BCM2835GpioState gpio;
 } BCM2835PeripheralState;
 
 #endif /* BCM2835_PERIPHERALS_H */
-- 
2.11.1
