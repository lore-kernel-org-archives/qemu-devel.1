Received: from eggs.gnu.org ([2001:4830:134:3::10]:37860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=879e7201e=Alistair.Francis@wdc.com>)
	id 1gXbCK-0000nz-TD
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:19:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=879e7201e=Alistair.Francis@wdc.com>)
	id 1gXbCH-00043C-6C
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 19:19:20 -0500
From: Alistair Francis <Alistair.Francis@wdc.com>
Date: Fri, 14 Dec 2018 00:19:12 +0000
Message-ID: <3753d59b3a0f07fb6a678ffacd3d913f5fcb774d.1544746653.git.alistair.francis@wdc.com>
References: <cover.1544746653.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1544746653.git.alistair.francis@wdc.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v1 5/5] sifive_uart: Implement interrupt
 pending register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "alistair23@gmail.com" <alistair23@gmail.com>

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
---
 hw/riscv/sifive_uart.c         | 24 +++++++++++++++++++-----
 include/hw/riscv/sifive_uart.h |  3 +++
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index b0c3798cf2..456a3d3697 100644
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
=20
+/* Returns the state of the IP (interrupt pending) register */
+static uint64_t uart_ip(SiFiveUARTState *s)
+{
+    uint64_t ret =3D 0;
+
+    uint64_t txcnt =3D SIFIVE_UART_GET_TXCNT(s->txctrl);
+    uint64_t rxcnt =3D SIFIVE_UART_GET_RXCNT(s->rxctrl);
+
+    if (txcnt !=3D 0) {
+        ret |=3D SIFIVE_UART_IP_TXWM;
+    }
+    if (s->rx_fifo_len > rxcnt) {
+        ret |=3D SIFIVE_UART_IP_RXWM;
+    }
+
+    return ret;
+}
+
 static void update_irq(SiFiveUARTState *s)
 {
     int cond =3D 0;
@@ -69,7 +83,7 @@ uart_read(void *opaque, hwaddr addr, unsigned int size)
     case SIFIVE_UART_IE:
         return s->ie;
     case SIFIVE_UART_IP:
-        return s->rx_fifo_len ? SIFIVE_UART_IP_RXWM : 0;
+        return uart_ip(s);
     case SIFIVE_UART_TXCTRL:
         return s->txctrl;
     case SIFIVE_UART_RXCTRL:
diff --git a/include/hw/riscv/sifive_uart.h b/include/hw/riscv/sifive_uart.=
h
index 504f18a60f..c8dc1c57fd 100644
--- a/include/hw/riscv/sifive_uart.h
+++ b/include/hw/riscv/sifive_uart.h
@@ -43,6 +43,9 @@ enum {
     SIFIVE_UART_IP_RXWM       =3D 2  /* Receive watermark interrupt pendin=
g */
 };
=20
+#define SIFIVE_UART_GET_TXCNT(txctrl)   ((txctrl >> 16) & 0x7)
+#define SIFIVE_UART_GET_RXCNT(rxctrl)   ((rxctrl >> 16) & 0x7)
+
 #define TYPE_SIFIVE_UART "riscv.sifive.uart"
=20
 #define SIFIVE_UART(obj) \
--=20
2.19.1
