Received: from eggs.gnu.org ([2001:4830:134:3::10]:39148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gH9ZQ-00059y-6J
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:35:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gH9ZP-00048o-7p
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:35:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52104)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gH9ZO-0003rj-Uy
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:35:11 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gH9Yv-00005Y-Th
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 15:34:41 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 15:34:31 +0000
Message-Id: <20181029153432.23273-6-peter.maydell@linaro.org>
In-Reply-To: <20181029153432.23273-1-peter.maydell@linaro.org>
References: <20181029153432.23273-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 5/6] hw/arm/nrf51_soc: Connect UART to nRF51 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Julia Suvorova via Qemu-devel <qemu-devel@nongnu.org>

Wire up nRF51 UART in the corresponding SoC.

Signed-off-by: Julia Suvorova <jusual@mail.ru>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/arm/nrf51_soc.h |  3 +++
 hw/arm/microbit.c          |  2 ++
 hw/arm/nrf51_soc.c         | 20 ++++++++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/include/hw/arm/nrf51_soc.h b/include/hw/arm/nrf51_soc.h
index f4e092b554e..73fc92e9a8d 100644
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
diff --git a/hw/arm/microbit.c b/hw/arm/microbit.c
index e7d74116a50..a734e7f650e 100644
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
index 1a59ef45525..b89c1bdea08 100644
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
-- 
2.19.1
