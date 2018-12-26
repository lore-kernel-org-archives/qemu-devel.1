Received: from eggs.gnu.org ([208.118.235.92]:48202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrZ-0004YH-GO
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gcCrX-0007z9-9l
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:57 -0500
Received: from mail-qt1-x834.google.com ([2607:f8b0:4864:20::834]:46752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gcCrW-0007p7-VE
	for qemu-devel@nongnu.org; Wed, 26 Dec 2018 12:20:55 -0500
Received: by mail-qt1-x834.google.com with SMTP id y20so17814711qtm.13
	for <qemu-devel@nongnu.org>; Wed, 26 Dec 2018 09:20:34 -0800 (PST)
Date: Wed, 26 Dec 2018 09:20:02 -0800
Message-Id: <20181226172005.26990-12-palmer@sifive.com>
In-Reply-To: <20181226172005.26990-1-palmer@sifive.com>
References: <20181226172005.26990-1-palmer@sifive.com>
From: Palmer Dabbelt <palmer@sifive.com>
Subject: [Qemu-devel] [PULL 11/14] sifive_uart: Implement interrupt pending
 register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, Nathaniel Graff <nathaniel.graff@sifive.com>, Alistair Francis <alistair.francis@wdc.com>, Palmer Dabbelt <palmer@sifive.com>

From: Nathaniel Graff <nathaniel.graff@sifive.com>

The watermark bits are set in the interrupt pending register according
to the configuration of txcnt and rxcnt in the txctrl and rxctrl
registers.

Since the UART TX does not implement a FIFO, the txwm bit is set as long
as the TX watermark level is greater than zero.

Signed-off-by: Nathaniel Graff <nathaniel.graff@sifive.com>
Reviewed-by: Michael Clark <mjc@sifive.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
---
 hw/riscv/sifive_uart.c         | 24 +++++++++++++++++++-----
 include/hw/riscv/sifive_uart.h |  3 +++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index b0c3798cf274..456a3d3697c2 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -28,12 +28,26 @@
  * Not yet implemented:
  *
  * Transmit FIFO using "qemu/fifo8.h"
- * SIFIVE_UART_IE_TXWM interrupts
- * SIFIVE_UART_IE_RXWM interrupts must honor fifo watermark
- * Rx FIFO watermark interrupt trigger threshold
- * Tx FIFO watermark interrupt trigger threshold.
  */
 
+/* Returns the state of the IP (interrupt pending) register */
+static uint64_t uart_ip(SiFiveUARTState *s)
+{
+    uint64_t ret = 0;
+
+    uint64_t txcnt = SIFIVE_UART_GET_TXCNT(s->txctrl);
+    uint64_t rxcnt = SIFIVE_UART_GET_RXCNT(s->rxctrl);
+
+    if (txcnt != 0) {
+        ret |= SIFIVE_UART_IP_TXWM;
+    }
+    if (s->rx_fifo_len > rxcnt) {
+        ret |= SIFIVE_UART_IP_RXWM;
+    }
+
+    return ret;
+}
+
 static void update_irq(SiFiveUARTState *s)
 {
     int cond = 0;
@@ -69,7 +83,7 @@ uart_read(void *opaque, hwaddr addr, unsigned int size)
     case SIFIVE_UART_IE:
         return s->ie;
     case SIFIVE_UART_IP:
-        return s->rx_fifo_len ? SIFIVE_UART_IP_RXWM : 0;
+        return uart_ip(s);
     case SIFIVE_UART_TXCTRL:
         return s->txctrl;
     case SIFIVE_UART_RXCTRL:
diff --git a/include/hw/riscv/sifive_uart.h b/include/hw/riscv/sifive_uart.h
index 504f18a60f1b..c8dc1c57fd0b 100644
--- a/include/hw/riscv/sifive_uart.h
+++ b/include/hw/riscv/sifive_uart.h
@@ -43,6 +43,9 @@ enum {
     SIFIVE_UART_IP_RXWM       = 2  /* Receive watermark interrupt pending */
 };
 
+#define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
+#define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
+
 #define TYPE_SIFIVE_UART "riscv.sifive.uart"
 
 #define SIFIVE_UART(obj) \
-- 
2.18.1
