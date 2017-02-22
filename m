Received: from eggs.gnu.org ([2001:4830:134:3::10]:52245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1cgV1W-00020G-1q
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:23:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clement.deschamps@antfield.fr>) id 1cgV1V-0006Px-1W
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 06:23:54 -0500
From: Clement Deschamps <clement.deschamps@antfield.fr>
Date: Wed, 22 Feb 2017 12:23:38 +0100
Message-Id: <20170222112338.25492-4-clement.deschamps@antfield.fr>
In-Reply-To: <20170222112338.25492-1-clement.deschamps@antfield.fr>
References: <20170222112338.25492-1-clement.deschamps@antfield.fr>
Subject: [Qemu-devel] [PATCH v2 3/3] bcm2835: add sdhost and gpio controllers
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

The bcm2835_gpio has a link to both the sdhci and sdhost controllers for
supporting the alternate function of GPIOs 48-53 (SD controller selection)

Signed-off-by: Clement Deschamps <clement.deschamps@antfield.fr>
---
 hw/arm/bcm2835_peripherals.c         | 44 ++++++++++++++++++++++++++++++++++++
 include/hw/arm/bcm2835_peripherals.h |  4 ++++
 2 files changed, 48 insertions(+)

diff --git a/hw/arm/bcm2835_peripherals.c b/hw/arm/bcm2835_peripherals.c
index 2e641a3989..adc419dfcf 100644
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
+    object_property_add_const_link(OBJECT(&s->gpio), "sdhci",
+                                   OBJECT(&s->sdhci), &error_abort);
+    object_property_add_const_link(OBJECT(&s->gpio), "sdhost",
+                                   OBJECT(&s->sdhost), &error_abort);
 }
 
 static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
@@ -259,6 +274,25 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
         return;
     }
 
+    /* SDHOST */
+    object_property_set_bool(OBJECT(&s->sdhost), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
+    memory_region_add_subregion(&s->peri_mr, MMCI0_OFFSET,
+                sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->sdhost), 0));
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->sdhost), 0,
+        qdev_get_gpio_in_named(DEVICE(&s->ic), BCM2835_IC_GPU_IRQ,
+                               INTERRUPT_SDIO));
+    object_property_add_alias(OBJECT(s), "sd-bus-2", OBJECT(&s->sdhost),
+                              "sd-bus", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+
     /* DMA Channels */
     object_property_set_bool(OBJECT(&s->dma), true, "realized", &err);
     if (err) {
@@ -277,6 +311,16 @@ static void bcm2835_peripherals_realize(DeviceState *dev, Error **errp)
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
