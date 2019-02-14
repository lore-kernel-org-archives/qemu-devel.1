Received: from eggs.gnu.org ([209.51.188.92]:49891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGeR-00032s-UO
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 08:02:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guGUD-0006nG-8P
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:32 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55949)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guGU2-0006VK-Lk
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 07:51:22 -0500
Received: by mail-wm1-x344.google.com with SMTP id r17so6109277wmh.5
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 04:51:17 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 12:50:59 +0000
Message-Id: <20190214125107.22178-7-peter.maydell@linaro.org>
In-Reply-To: <20190214125107.22178-1-peter.maydell@linaro.org>
References: <20190214125107.22178-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 06/14] hw/char/pl011: Support all interrupt
 lines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

The PL011 UART has six interrupt lines:
 * RX (receive data)
 * TX (transmit data)
 * RT (receive timeout)
 * MS (modem status)
 * E (errors)
 * combined (logical OR of all the above)

So far we have only emulated the combined interrupt line;
add support for the others, so that boards that wire them
up to different interrupt controller inputs can do so.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/char/pl011.h |  2 +-
 hw/char/pl011.c         | 46 +++++++++++++++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/include/hw/char/pl011.h b/include/hw/char/pl011.h
index 1b52bfd5c90..dad3cf29121 100644
--- a/include/hw/char/pl011.h
+++ b/include/hw/char/pl011.h
@@ -45,7 +45,7 @@ typedef struct PL011State {
     int read_count;
     int read_trigger;
     CharBackend chr;
-    qemu_irq irq;
+    qemu_irq irq[6];
     const unsigned char *id;
 } PL011State;
 
diff --git a/hw/char/pl011.c b/hw/char/pl011.c
index 0c4711e4027..29f4e5eb224 100644
--- a/hw/char/pl011.c
+++ b/hw/char/pl011.c
@@ -7,6 +7,17 @@
  * This code is licensed under the GPL.
  */
 
+/*
+ * QEMU interface:
+ *  + sysbus MMIO region 0: device registers
+ *  + sysbus IRQ 0: UARTINTR (combined interrupt line)
+ *  + sysbus IRQ 1: UARTRXINTR (receive FIFO interrupt line)
+ *  + sysbus IRQ 2: UARTTXINTR (transmit FIFO interrupt line)
+ *  + sysbus IRQ 3: UARTRTINTR (receive timeout interrupt line)
+ *  + sysbus IRQ 4: UARTMSINTR (momem status interrupt line)
+ *  + sysbus IRQ 5: UARTEINTR (error interrupt line)
+ */
+
 #include "qemu/osdep.h"
 #include "hw/char/pl011.h"
 #include "hw/sysbus.h"
@@ -22,18 +33,46 @@
 #define PL011_FLAG_TXFF 0x20
 #define PL011_FLAG_RXFE 0x10
 
+/* Interrupt status bits in UARTRIS, UARTMIS, UARTIMSC */
+#define INT_OE (1 << 10)
+#define INT_BE (1 << 9)
+#define INT_PE (1 << 8)
+#define INT_FE (1 << 7)
+#define INT_RT (1 << 6)
+#define INT_TX (1 << 5)
+#define INT_RX (1 << 4)
+#define INT_DSR (1 << 3)
+#define INT_DCD (1 << 2)
+#define INT_CTS (1 << 1)
+#define INT_RI (1 << 0)
+#define INT_E (INT_OE | INT_BE | INT_PE | INT_FE)
+#define INT_MS (INT_RI | INT_DSR | INT_DCD | INT_CTS)
+
 static const unsigned char pl011_id_arm[8] =
   { 0x11, 0x10, 0x14, 0x00, 0x0d, 0xf0, 0x05, 0xb1 };
 static const unsigned char pl011_id_luminary[8] =
   { 0x11, 0x00, 0x18, 0x01, 0x0d, 0xf0, 0x05, 0xb1 };
 
+/* Which bits in the interrupt status matter for each outbound IRQ line ? */
+static const uint32_t irqmask[] = {
+    INT_E | INT_MS | INT_RT | INT_TX | INT_RX, /* combined IRQ */
+    INT_RX,
+    INT_TX,
+    INT_RT,
+    INT_MS,
+    INT_E,
+};
+
 static void pl011_update(PL011State *s)
 {
     uint32_t flags;
+    int i;
 
     flags = s->int_level & s->int_enabled;
     trace_pl011_irq_state(flags != 0);
-    qemu_set_irq(s->irq, flags != 0);
+    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
+        qemu_set_irq(s->irq[i], (flags & irqmask[i]) != 0);
+    }
 }
 
 static uint64_t pl011_read(void *opaque, hwaddr offset,
@@ -284,10 +323,13 @@ static void pl011_init(Object *obj)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
     PL011State *s = PL011(obj);
+    int i;
 
     memory_region_init_io(&s->iomem, OBJECT(s), &pl011_ops, s, "pl011", 0x1000);
     sysbus_init_mmio(sbd, &s->iomem);
-    sysbus_init_irq(sbd, &s->irq);
+    for (i = 0; i < ARRAY_SIZE(s->irq); i++) {
+        sysbus_init_irq(sbd, &s->irq[i]);
+    }
 
     s->read_trigger = 1;
     s->ifl = 0x12;
-- 
2.20.1
