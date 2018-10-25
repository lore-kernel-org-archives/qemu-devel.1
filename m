Received: from eggs.gnu.org ([2001:4830:134:3::10]:57521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gFTsC-0000dG-93
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:51:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jusual@mail.ru>) id 1gFTs9-0001fw-7W
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:51:40 -0400
Received: from smtp36.i.mail.ru ([94.100.177.96]:51270)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jusual@mail.ru>) id 1gFTs2-00013U-Ql
	for qemu-devel@nongnu.org; Wed, 24 Oct 2018 20:51:33 -0400
From: Julia Suvorova <jusual@mail.ru>
Date: Thu, 25 Oct 2018 03:50:51 +0300
Message-Id: <20181025005052.27661-3-jusual@mail.ru>
In-Reply-To: <20181025005052.27661-1-jusual@mail.ru>
References: <20181025005052.27661-1-jusual@mail.ru>
Subject: [Qemu-devel] [PATCH v3 2/3] hw/arm/nrf51_soc: Connect UART to nRF51
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Joel Stanley <joel@jms.id.au>, Jim Mussared <jim@groklearning.com>, =?UTF-8?q?Steffen=20G=C3=B6rtz?= <mail@steffen-goertz.de>, Thomas Huth <thuth@redhat.com>, Julia Suvorova <jusual@mail.ru>

Wire up nRF51 UART in the corresponding SoC.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
---
 hw/arm/microbit.c          |  2 ++
 hw/arm/nrf51_soc.c         | 20 ++++++++++++++++++++
 include/hw/arm/nrf51_soc.h |  3 +++
 3 files changed, 25 insertions(+)

diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index e7d74116a5..a734e7f650 100644
--- a/hw/arm/microbit.c
+++ b/hw/arm/microbit.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/boards.h"
 #include "hw/arm/arm.h"
+#include "sysemu/sysemu.h"
 #include "exec/address-spaces.h"
 
 #include "hw/arm/nrf51_soc.h"
@@ -35,6 +36,7 @@ static void microbit_init(MachineState *machine)
 
     sysbus_init_child_obj(OBJECT(machine), "nrf51", soc, sizeof(s->nrf51),
                           TYPE_NRF51_SOC);
+    qdev_prop_set_chr(DEVICE(&s->nrf51), "serial0", serial_hd(0));
     object_property_set_link(soc, OBJECT(system_memory), "memory",
                              &error_fatal);
     object_property_set_bool(soc, true, "realized", &error_fatal);
diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 1a59ef4552..b89c1bdea0 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -43,9 +43,12 @@
 #define NRF51822_FLASH_SIZE     (256 * 1024)
 #define NRF51822_SRAM_SIZE      (16 * 1024)
 
+#define BASE_TO_IRQ(base) ((base >> 12) & 0x1F)
+
 static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
 {
     NRF51State *s = NRF51_SOC(dev_soc);
+    MemoryRegion *mr;
     Error *err = NULL;
 
     if (!s->board_memory) {
@@ -82,6 +85,18 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     memory_region_add_subregion(&s->container, SRAM_BASE, &s->sram);
 
+    /* UART */
+    object_property_set_bool(OBJECT(&s->uart), true, "realized", &err);
+    if (err) {
+        error_propagate(errp, err);
+        return;
+    }
+    mr = sysbus_mmio_get_region(SYS_BUS_DEVICE(&s->uart), 0);
+    memory_region_add_subregion_overlap(&s->container, UART_BASE, mr, 0);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&s->uart), 0,
+                       qdev_get_gpio_in(DEVICE(&s->cpu),
+                       BASE_TO_IRQ(UART_BASE)));
+
     create_unimplemented_device("nrf51_soc.io", IOMEM_BASE, IOMEM_SIZE);
     create_unimplemented_device("nrf51_soc.ficr", FICR_BASE, FICR_SIZE);
     create_unimplemented_device("nrf51_soc.private",
@@ -99,6 +114,11 @@ static void nrf51_soc_init(Object *obj)
     qdev_prop_set_string(DEVICE(&s->cpu), "cpu-type",
                          ARM_CPU_TYPE_NAME("cortex-m0"));
     qdev_prop_set_uint32(DEVICE(&s->cpu), "num-irq", 32);
+
+    sysbus_init_child_obj(obj, "uart", &s->uart, sizeof(s->uart),
+                           TYPE_NRF51_UART);
+    object_property_add_alias(obj, "serial0", OBJECT(&s->uart), "chardev",
+                              &error_abort);
 }
 
 static Property nrf51_soc_properties[] = {
diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index f4e092b554..73fc92e9a8 100644
--- a/include/hw/arm/nrf51_soc.h
+++ b/include/hw/arm/nrf51_soc.h
@@ -12,6 +12,7 @@
 
 #include "hw/sysbus.h"
 #include "hw/arm/armv7m.h"
+#include "hw/char/nrf51_uart.h"
 
 #define TYPE_NRF51_SOC "nrf51-soc"
 #define NRF51_SOC(obj) \
@@ -24,6 +25,8 @@ typedef struct NRF51State {
     /*< public >*/
     ARMv7MState cpu;
 
+    NRF51UARTState uart;
+
     MemoryRegion iomem;
     MemoryRegion sram;
     MemoryRegion flash;
-- 
2.17.1
