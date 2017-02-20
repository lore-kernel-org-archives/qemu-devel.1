Received: from eggs.gnu.org ([2001:4830:134:3::10]:40164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfq0h-0006aC-UZ
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:36:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cfq0g-0003ON-N9
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 10:36:19 -0500
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Feb 2017 15:36:05 +0000
Message-Id: <1487604965-23220-12-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
References: <1487604965-23220-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 11/11] stm32f205: Rename 'nvic' local to
 'armv7m'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Alistair Francis <alistair23@gmail.com>, Michael Davidsaver <mdavidsaver@gmail.com>

The local variable 'nvic' in stm32f205_soc_realize() no longer
holds a direct pointer to the NVIC device; it is a pointer to
the ARMv7M container object. Rename it 'armv7m' accordingly.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/stm32f205_soc.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
index e6bd73a..6e1260d 100644
--- a/hw/arm/stm32f205_soc.c
+++ b/hw/arm/stm32f205_soc.c
@@ -85,7 +85,7 @@ static void stm32f205_soc_initfn(Object *obj)
 static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     STM32F205State *s = STM32F205_SOC(dev_soc);
-    DeviceState *dev, *nvic;
+    DeviceState *dev, *armv7m;
     SysBusDevice *busdev;
     Error *err = NULL;
     int i;
@@ -113,9 +113,9 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     vmstate_register_ram_global(sram);
     memory_region_add_subregion(system_memory, SRAM_BASE_ADDRESS, sram);
 
-    nvic = DEVICE(&s->armv7m);
-    qdev_prop_set_uint32(nvic, "num-irq", 96);
-    qdev_prop_set_string(nvic, "cpu-model", s->cpu_model);
+    armv7m = DEVICE(&s->armv7m);
+    qdev_prop_set_uint32(armv7m, "num-irq", 96);
+    qdev_prop_set_string(armv7m, "cpu-model", s->cpu_model);
     object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
                                      "memory", &error_abort);
     object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
@@ -133,7 +133,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     busdev = SYS_BUS_DEVICE(dev);
     sysbus_mmio_map(busdev, 0, 0x40013800);
-    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(nvic, 71));
+    sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, 71));
 
     /* Attach UART (uses USART registers) and USART controllers */
     for (i = 0; i < STM_NUM_USARTS; i++) {
@@ -147,7 +147,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
         }
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, usart_addr[i]);
-        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(nvic, usart_irq[i]));
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, usart_irq[i]));
     }
 
     /* Timer 2 to 5 */
@@ -161,7 +161,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
         }
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, timer_addr[i]);
-        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(nvic, timer_irq[i]));
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, timer_irq[i]));
     }
 
     /* ADC 1 to 3 */
@@ -173,7 +173,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
         return;
     }
     qdev_connect_gpio_out(DEVICE(s->adc_irqs), 0,
-                          qdev_get_gpio_in(nvic, ADC_IRQ));
+                          qdev_get_gpio_in(armv7m, ADC_IRQ));
 
     for (i = 0; i < STM_NUM_ADCS; i++) {
         dev = DEVICE(&(s->adc[i]));
@@ -198,7 +198,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
         }
         busdev = SYS_BUS_DEVICE(dev);
         sysbus_mmio_map(busdev, 0, spi_addr[i]);
-        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(nvic, spi_irq[i]));
+        sysbus_connect_irq(busdev, 0, qdev_get_gpio_in(armv7m, spi_irq[i]));
     }
 }
 
-- 
2.7.4
