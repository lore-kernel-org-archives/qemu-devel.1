Received: from eggs.gnu.org ([2001:4830:134:3::10]:34370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sH-0003FD-R3
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sG-0008Ii-Mm
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:45 -0400
From: Damien Hedde <damien.hedde@greensocs.com>
Date: Fri, 27 Jul 2018 16:37:24 +0200
Message-Id: <172aa4f0544c31a22603c783a836aef3c29d564e.1532701430.git.damien.hedde@greensocs.com>
In-Reply-To: <cover.1532701430.git.damien.hedde@greensocs.com>
References: <cover.1532701430.git.damien.hedde@greensocs.com>
Subject: [Qemu-devel] [RFC PATCH 5/6] zynq_slcr: add uart clock gating and
 soft reset support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, pbonzini@redhat.com, peter.maydell@linaro.org, edgar.iglesias@xilinx.com, mark.burton@greensocs.com, saipava@xilinx.com, luc.michel@greensocs.com, alistair@alistair23.me, Damien Hedde <damien.hedde@greensocs.com>

Clock gating and reset of uart0 and uart1 is controlled by
UART_CLK_CTRL and UART_RST_CTRL.
Uart0 and uart1 links are kept in properties to allow taking action.

The CLKACT bit in UART_CLK_CTRL is used to driver the clock gating.

In order to implement the reset behavior, which can be hold: when
reset is asserted, device_reset is called on the uart and the clock
is also disabled until reset is deasserted.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/misc/zynq_slcr.c | 63 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/hw/misc/zynq_slcr.c b/hw/misc/zynq_slcr.c
index d6bdd027ef..55dd586066 100644
--- a/hw/misc/zynq_slcr.c
+++ b/hw/misc/zynq_slcr.c
@@ -168,6 +168,14 @@ enum {
 #define DDRIOB_LENGTH 14
 };
 
+enum {
+    UART_CLK_CTRL_CLKACT0 = 0x0001,
+    UART_CLK_CTRL_CLKACT1 = 0x0002,
+
+    UART_RST_CTRL_UART0_REF_RST = 0x04,
+    UART_RST_CTRL_UART1_REF_RST = 0x08,
+};
+
 #define ZYNQ_SLCR_MMIO_SIZE     0x1000
 #define ZYNQ_SLCR_NUM_REGS      (ZYNQ_SLCR_MMIO_SIZE / 4)
 
@@ -180,6 +188,9 @@ typedef struct ZynqSLCRState {
     MemoryRegion iomem;
 
     uint32_t regs[ZYNQ_SLCR_NUM_REGS];
+
+    DeviceState *uart0;
+    DeviceState *uart1;
 } ZynqSLCRState;
 
 static void zynq_slcr_reset(DeviceState *d)
@@ -355,6 +366,35 @@ static uint64_t zynq_slcr_read(void *opaque, hwaddr offset,
     return ret;
 }
 
+/*
+ * zynq_slcr_update_clock:
+ * Update a device clock state given its:
+ * + clock enable bit
+ * + reset asserted bit
+ * Since reset cannot be enabled and disabled, the clock is disabled when
+ * reset is asserted
+ */
+static void zynq_slcr_update_clock(DeviceState *dev, bool clken, bool rsten)
+{
+    if (dev) {
+        device_set_clock(dev, clken && !rsten);
+    }
+}
+
+/*
+ * zynq_slcr_update_reset:
+ * Update a device reset state given its:
+ * + reset asserted bit
+ * Also trigger a clock update
+ */
+static void zynq_slcr_update_reset(DeviceState *dev, bool clken, bool rsten)
+{
+    if (dev && rsten) {
+        device_reset(dev);
+    }
+    zynq_slcr_update_clock(dev, clken, rsten);
+}
+
 static void zynq_slcr_write(void *opaque, hwaddr offset,
                           uint64_t val, unsigned size)
 {
@@ -408,6 +448,22 @@ static void zynq_slcr_write(void *opaque, hwaddr offset,
             qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         }
         break;
+    case UART_CLK_CTRL:
+        zynq_slcr_update_clock(s->uart0,
+                s->regs[UART_CLK_CTRL] & UART_CLK_CTRL_CLKACT0,
+                s->regs[UART_RST_CTRL] & UART_RST_CTRL_UART0_REF_RST);
+        zynq_slcr_update_clock(s->uart1,
+                s->regs[UART_CLK_CTRL] & UART_CLK_CTRL_CLKACT1,
+                s->regs[UART_RST_CTRL] & UART_RST_CTRL_UART1_REF_RST);
+        break;
+    case UART_RST_CTRL:
+        zynq_slcr_update_reset(s->uart0,
+                s->regs[UART_CLK_CTRL] & UART_CLK_CTRL_CLKACT0,
+                s->regs[UART_RST_CTRL] & UART_RST_CTRL_UART0_REF_RST);
+        zynq_slcr_update_reset(s->uart1,
+                s->regs[UART_CLK_CTRL] & UART_CLK_CTRL_CLKACT1,
+                s->regs[UART_RST_CTRL] & UART_RST_CTRL_UART1_REF_RST);
+        break;
     }
 }
 
@@ -436,12 +492,19 @@ static const VMStateDescription vmstate_zynq_slcr = {
     }
 };
 
+static Property zynq_slcr_properties[] = {
+    DEFINE_PROP_LINK("uart0", ZynqSLCRState, uart0, TYPE_DEVICE, DeviceState *),
+    DEFINE_PROP_LINK("uart1", ZynqSLCRState, uart1, TYPE_DEVICE, DeviceState *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void zynq_slcr_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_zynq_slcr;
     dc->reset = zynq_slcr_reset;
+    dc->props = zynq_slcr_properties;
 }
 
 static const TypeInfo zynq_slcr_info = {
-- 
2.18.0
