Received: from eggs.gnu.org ([2001:4830:134:3::10]:49833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fnVhd-0003Ek-Fy
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:09:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1fnVhY-0006iV-Qu
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:09:09 -0400
Received: from smtp20.mail.ru ([94.100.179.251]:39456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1fnVhY-0006gu-IM
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 17:09:04 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Thu,  9 Aug 2018 00:07:48 +0300
Message-Id: <20180808210750.3915-3-jusual@mail.ru>
In-Reply-To: <20180808210750.3915-1-jusual@mail.ru>
References: <20180808210750.3915-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v2 2/4] hw/arm/nrf51_soc: Connect UART to nRF51
 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

Wire up nRF51 UART in the corresponding SoC using in-place init/realize.

Based-on: <20180803052137.10602-1-joel@jms.id.au>

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 hw/arm/nrf51_soc.c         | 20 ++++++++++++++++++++
 include/hw/arm/nrf51_soc.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 9f9649c780..8b5602f363 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -38,9 +38,12 @@
 #define NRF51822_FLASH_SIZE     (256 * 1024)
 #define NRF51822_SRAM_SIZE      (16 * 1024)
 
+#define BASE_TO_IRQ(base) ((base >> 12) & 0x1F)
+
 static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     NRF51State *s = NRF51_SOC(dev_soc);
+    MemoryRegion *mr = NULL;
     Error *err = NULL;
 
     if (!s->board_memory) {
@@ -70,6 +73,19 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     memory_region_add_subregion(&s->container, SRAM_BASE, &s->sram);
 
+    /* UART */
+    qdev_prop_set_chr(DEVICE(&s->uart), "chardev", serial_hd(0));
+    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
+    memory_region_add_subregion_overlap(&s->container, UART_BASE, mr, 0);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0,
+                       qdev_get_gpio_in(DEVICE(&s->cpu),
+                                        BASE_TO_IRQ(UART_BASE)));
+
     create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
     create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
     create_unimplemented_device("nrf51_soc.private", 0xF0000000, 0x10000000);
@@ -86,6 +102,10 @@ static void nrf51_soc_init(Object *obj)
     qdev_set_parent_bus(DEVICE(&s->cpu), sysbus_get_default());
     qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type", ARM_CPU_TYPE_NAME("cortex-m0"));
     qdev_prop_set_uint32(DEVICE(&s->cpu), "num-irq", 32);
+
+    object_initialize(&s->uart, sizeof(s->uart), TYPE_NRF51_UART);
+    object_property_add_child(obj, "uart", OBJECT(&s->uart), &error_abort);
+    qdev_set_parent_bus(DEVICE(&s->uart), sysbus_get_default());
 }
 
 static Property nrf51_soc_properties[] = {
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index e380ec26b8..46a1c1a66c 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -13,6 +13,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/arm/armv7m.h"
+#include "hw/char/nrf51_uart.h"
 
 #define TYPE_NRF51_SOC "nrf51-soc"
 #define NRF51_SOC(obj) \
@@ -25,6 +26,8 @@ typedef struct NRF51State {
     /*< public >*/
     ARMv7MState cpu;
 
+    NRF51UARTState uart;
+
     MemoryRegion iomem;
     MemoryRegion sram;
     MemoryRegion flash;
-- 
2.17.1
