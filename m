Received: from eggs.gnu.org ([2001:4830:134:3::10]:40200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5dAp-0003lS-N6
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:41:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gabriel291075@gmail.com>) id 1e5dAm-00047D-K0
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:41:39 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:44853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <gabriel291075@gmail.com>)
	id 1e5dAm-00045t-FX
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:41:36 -0400
Received: by mail-qt0-x241.google.com with SMTP id 8so19829626qtv.1
	for <qemu-devel@nongnu.org>; Fri, 20 Oct 2017 12:41:34 -0700 (PDT)
From: Gabriel Augusto Costa <gabriel291075@gmail.com>
Date: Fri, 20 Oct 2017 11:37:18 -0400
Message-Id: <1508513838-15530-1-git-send-email-gabriel291075@gmail.com>
Subject: [Qemu-devel] [PATCH v3 01/11] kinetis_k64_uart.h has been added
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

I made a new arm machine with some peripherals. The machine is mk64fn1m0, a
cortex-m4 microcontroller from NXP Kinetis family. The machine can run a
simple arm binary file using UART0 in polling mode.
I have prepared a series of patchs to include this machine:
PATCH v3 n/11: It adds the machine and peripherals devices;
PATCH v4 n/2: It changes the Make files to compile this machine.

Signed-off-by: Gabriel Augusto Costa <gabriel291075@gmail.com>
---
 include/hw/char/kinetis_k64_uart.h | 85 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)
 create mode 100644 include/hw/char/kinetis_k64_uart.h

diff --git a/include/hw/char/kinetis_k64_uart.h b/include/hw/char/kinetis_k64_uart.h
new file mode 100644
index 0000000..7ee29aa
--- /dev/null
+++ b/include/hw/char/kinetis_k64_uart.h
@@ -0,0 +1,85 @@
+/*
+ * Kinetis K64 peripheral microcontroller emulation.
+ *
+ * Copyright (c) 2017 Advantech Wireless
+ * Written by Gabriel Costa <gabriel291075@gmail.com>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2 or
+ *  (at your option) any later version.
+ */
+
+/* Kinetis K64 series UART controller.  */
+
+#ifndef KINETIS_UART_H
+#define KINETIS_UART_H
+
+#include "hw/sysbus.h"
+#include "chardev/char-fe.h"
+#include "chardev/char-mux.h"
+#include "hw/hw.h"
+
+#define TYPE_KINETIS_K64_UART "kinetis_k64_uart"
+#define KINETIS_K64_UART(obj) \
+    OBJECT_CHECK(kinetis_k64_uart_state, (obj), TYPE_KINETIS_K64_UART)
+
+typedef struct {
+    SysBusDevice parent_obj;
+
+    MemoryRegion iomem;
+
+    uint8_t BDH;    /**< UART Baud Rate Registers: High, offset: 0x0 */
+    uint8_t BDL;    /**< UART Baud Rate Registers: Low, offset: 0x1 */
+    uint8_t C1;     /**< UART Control Register 1, offset: 0x2 */
+    uint8_t C2;     /**< UART Control Register 2, offset: 0x3 */
+    uint8_t S1;     /**< UART Status Register 1, offset: 0x4 */
+    uint8_t S2;     /**< UART Status Register 2, offset: 0x5 */
+    uint8_t C3;     /**< UART Control Register 3, offset: 0x6 */
+    uint8_t D;      /**< UART Data Register, offset: 0x7 */
+    uint8_t MA1;    /**< UART Match Address Registers 1, offset: 0x8 */
+    uint8_t MA2;    /**< UART Match Address Registers 2, offset: 0x9 */
+    uint8_t C4;     /**< UART Control Register 4, offset: 0xA */
+    uint8_t C5;     /**< UART Control Register 5, offset: 0xB */
+    uint8_t ED;     /**< UART Extended Data Register, offset: 0xC */
+    uint8_t MODEM;  /**< UART Modem Register, offset: 0xD */
+    uint8_t IR;     /**< UART Infrared Register, offset: 0xE */
+    uint8_t PFIFO;  /**< UART FIFO Parameters, offset: 0x10 */
+    uint8_t CFIFO;  /**< UART FIFO Control Register, offset: 0x11 */
+    uint8_t SFIFO;  /**< UART FIFO Status Register, offset: 0x12 */
+    uint8_t TWFIFO; /**< UART FIFO Transmit Watermark, offset: 0x13 */
+    uint8_t TCFIFO; /**< UART FIFO Transmit Count, offset: 0x14 */
+    uint8_t RWFIFO; /**< UART FIFO Receive Watermark, offset: 0x15 */
+    uint8_t RCFIFO; /**< UART FIFO Receive Count, offset: 0x16 */
+    uint8_t C7816;  /**< UART 7816 Control Register, offset: 0x18 */
+    uint8_t IE7816; /**< UART 7816 Interrupt Enable Register, offset: 0x19 */
+    uint8_t IS7816; /**< UART 7816 Interrupt Status Register, offset: 0x1A */
+    union {               /* offset: 0x1B */
+        uint8_t WP7816T0; /**< UART 7816 Wait Parameter Register, offset: 0x1B*/
+        uint8_t WP7816T1; /**< UART 7816 Wait Parameter Register, offset: 0x1B*/
+    };
+    uint8_t WN7816; /**< UART 7816 Wait N Register, offset: 0x1C */
+    uint8_t WF7816; /**< UART 7816 Wait FD Register, offset: 0x1D */
+    uint8_t ET7816; /**< UART 7816 Error Threshold Register, offset: 0x1E */
+    uint8_t TL7816; /**< UART 7816 Transmit Length Register, offset: 0x1F */
+
+    qemu_irq irq;
+    CharBackend chr;
+} kinetis_k64_uart_state;
+
+static inline DeviceState *kinetis_k64_uart_create(hwaddr addr, qemu_irq irq,
+        Chardev *chr)
+{
+    DeviceState *dev;
+    SysBusDevice *s;
+
+    dev = qdev_create(NULL, TYPE_KINETIS_K64_UART);
+    qdev_prop_set_chr(dev, "chardev", chr);
+    qdev_init_nofail(dev);
+    s = SYS_BUS_DEVICE(dev);
+    sysbus_mmio_map(s, 0, addr);
+    sysbus_connect_irq(s, 0, irq);
+
+    return dev;
+}
+
+#endif
-- 
2.1.4
