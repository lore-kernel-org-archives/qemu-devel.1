Received: from eggs.gnu.org ([2001:4830:134:3::10]:53633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVyCY-00054C-DK
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:52:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVyCU-0007PD-74
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 06:52:02 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 11:51:21 +0100
Message-Id: <1500029487-14822-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
References: <1500029487-14822-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH v2 3/9] hw/arm/mps2: Add UARTs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair.francis@xilinx.com>

Add the UARTs to the MPS2 board models.

Unfortunately the details of the wiring of the interrupts through
various OR gates differ between AN511 and AN385 so this can't
be purely a data-driven difference.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/arm/mps2.c | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)

diff --git a/hw/arm/mps2.c b/hw/arm/mps2.c
index 3dad02d..180c5d2 100644
--- a/hw/arm/mps2.c
+++ b/hw/arm/mps2.c
@@ -27,9 +27,12 @@
 #include "qemu/error-report.h"
 #include "hw/arm/arm.h"
 #include "hw/arm/armv7m.h"
+#include "hw/or-irq.h"
 #include "hw/boards.h"
 #include "exec/address-spaces.h"
+#include "sysemu/sysemu.h"
 #include "hw/misc/unimp.h"
+#include "hw/char/cmsdk-apb-uart.h"
 
 typedef enum MPS2FPGAType {
     FPGA_AN385,
@@ -206,6 +209,89 @@ static void mps2_common_init(MachineState *machine)
     create_unimplemented_device("Ethernet", 0x40200000, 0x00100000);
     create_unimplemented_device("VGA", 0x41000000, 0x0200000);
 
+    switch (mmc->fpga_type) {
+    case FPGA_AN385:
+    {
+        /* The overflow IRQs for UARTs 0, 1 and 2 are ORed together.
+         * Overflow for UARTs 4 and 5 doesn't trigger any interrupt.
+         */
+        Object *orgate;
+        DeviceState *orgate_dev;
+        int i;
+
+        orgate = object_new(TYPE_OR_IRQ);
+        object_property_set_int(orgate, 6, "num-lines", &error_fatal);
+        object_property_set_bool(orgate, true, "realized", &error_fatal);
+        orgate_dev = DEVICE(orgate);
+        qdev_connect_gpio_out(orgate_dev, 0, qdev_get_gpio_in(armv7m, 12));
+
+        for (i = 0; i < 5; i++) {
+            hwaddr uartbase[] = {0x40004000, 0x40005000, 0x40006000,
+                                 0x40007000, 0x40009000};
+            Chardev *uartchr = i < MAX_SERIAL_PORTS ? serial_hds[i] : NULL;
+            /* RX irq number; TX irq is always one greater */
+            int uartirq[] = {0, 2, 4, 18, 20};
+            qemu_irq txovrint = NULL, rxovrint = NULL;
+
+            if (i < 3) {
+                txovrint = qdev_get_gpio_in(orgate_dev, i * 2);
+                rxovrint = qdev_get_gpio_in(orgate_dev, i * 2 + 1);
+            }
+
+            cmsdk_apb_uart_create(uartbase[i],
+                                  qdev_get_gpio_in(armv7m, uartirq[i] + 1),
+                                  qdev_get_gpio_in(armv7m, uartirq[i]),
+                                  txovrint, rxovrint,
+                                  NULL,
+                                  uartchr, SYSCLK_FRQ);
+        }
+        break;
+    }
+    case FPGA_AN511:
+    {
+        /* The overflow IRQs for all UARTs are ORed together.
+         * Tx and Rx IRQs for each UART are ORed together.
+         */
+        Object *orgate;
+        DeviceState *orgate_dev;
+        int i;
+
+        orgate = object_new(TYPE_OR_IRQ);
+        object_property_set_int(orgate, 10, "num-lines", &error_fatal);
+        object_property_set_bool(orgate, true, "realized", &error_fatal);
+        orgate_dev = DEVICE(orgate);
+        qdev_connect_gpio_out(orgate_dev, 0, qdev_get_gpio_in(armv7m, 12));
+
+        for (i = 0; i < 5; i++) {
+            /* system irq numbers for the combined tx/rx for each UART */
+            const int uart_txrx_irqno[] = {0, 2, 45, 46, 56};
+            hwaddr uartbase[] = {0x40004000, 0x40005000, 0x4002c000,
+                                 0x4002d000, 0x4002e000};
+            Chardev *uartchr = i < MAX_SERIAL_PORTS ? serial_hds[i] : NULL;
+            Object *txrx_orgate;
+            DeviceState *txrx_orgate_dev;
+
+            txrx_orgate = object_new(TYPE_OR_IRQ);
+            object_property_set_int(txrx_orgate, 2, "num-lines", &error_fatal);
+            object_property_set_bool(txrx_orgate, true, "realized",
+                                     &error_fatal);
+            txrx_orgate_dev = DEVICE(txrx_orgate);
+            qdev_connect_gpio_out(txrx_orgate_dev, 0,
+                                  qdev_get_gpio_in(armv7m, uart_txrx_irqno[i]));
+            cmsdk_apb_uart_create(uartbase[i],
+                                  qdev_get_gpio_in(txrx_orgate_dev, 0),
+                                  qdev_get_gpio_in(txrx_orgate_dev, 1),
+                                  qdev_get_gpio_in(orgate_dev, 0),
+                                  qdev_get_gpio_in(orgate_dev, 1),
+                                  NULL,
+                                  uartchr, SYSCLK_FRQ);
+        }
+        break;
+    }
+    default:
+        g_assert_not_reached();
+    }
+
     system_clock_scale = NANOSECONDS_PER_SECOND / SYSCLK_FRQ;
 
     armv7m_load_kernel(ARM_CPU(first_cpu), machine->kernel_filename,
-- 
2.7.4
