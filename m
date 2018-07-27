Received: from eggs.gnu.org ([2001:4830:134:3::10]:34364)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sH-0003FA-Lk
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1fj3sG-0008Iw-PO
	for qemu-devel@nongnu.org; Fri, 27 Jul 2018 10:37:45 -0400
From: Damien Hedde <damien.hedde@greensocs.com>
Date: Fri, 27 Jul 2018 16:37:25 +0200
Message-Id: <f7f6b76036ffcb6ef7f844f815f7d433374157f7.1532701430.git.damien.hedde@greensocs.com>
In-Reply-To: <cover.1532701430.git.damien.hedde@greensocs.com>
References: <cover.1532701430.git.damien.hedde@greensocs.com>
Subject: [Qemu-devel] [RFC PATCH 6/6] xilinx_zynq: add uart clock gating
 support
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

Add the link between the clock controller _slcr_ and the two
uarts _uart0_ and _uart1_ so that the controller can do the gating.

Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
---
 hw/arm/xilinx_zynq.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/hw/arm/xilinx_zynq.c b/hw/arm/xilinx_zynq.c
index f1496d2927..2ca2dc32cf 100644
--- a/hw/arm/xilinx_zynq.c
+++ b/hw/arm/xilinx_zynq.c
@@ -166,7 +166,7 @@ static void zynq_init(MachineState *machine)
     MemoryRegion *address_space_mem = get_system_memory();
     MemoryRegion *ext_ram = g_new(MemoryRegion, 1);
     MemoryRegion *ocm_ram = g_new(MemoryRegion, 1);
-    DeviceState *dev;
+    DeviceState *dev, *slcr;
     SysBusDevice *busdev;
     qemu_irq pic[64];
     int n;
@@ -212,9 +212,11 @@ static void zynq_init(MachineState *machine)
                           1, 0x0066, 0x0022, 0x0000, 0x0000, 0x0555, 0x2aa,
                               0);
 
-    dev = qdev_create(NULL, "xilinx,zynq_slcr");
-    qdev_init_nofail(dev);
-    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, 0xF8000000);
+    /*
+     * Create slcr, initialization is completed below
+     * because we have some properties to set
+     */
+    slcr = qdev_create(NULL, "xilinx,zynq_slcr");
 
     dev = qdev_create(NULL, TYPE_A9MPCORE_PRIV);
     qdev_prop_set_uint32(dev, "num-cpu", 1);
@@ -235,8 +237,10 @@ static void zynq_init(MachineState *machine)
     sysbus_create_simple("xlnx,ps7-usb", 0xE0002000, pic[53-IRQ_OFFSET]);
     sysbus_create_simple("xlnx,ps7-usb", 0xE0003000, pic[76-IRQ_OFFSET]);
 
-    cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
-    cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
+    dev = cadence_uart_create(0xE0000000, pic[59 - IRQ_OFFSET], serial_hd(0));
+    object_property_set_link(OBJECT(slcr), OBJECT(dev), "uart0", &error_abort);
+    dev = cadence_uart_create(0xE0001000, pic[82 - IRQ_OFFSET], serial_hd(1));
+    object_property_set_link(OBJECT(slcr), OBJECT(dev), "uart1", &error_abort);
 
     sysbus_create_varargs("cadence_ttc", 0xF8001000,
             pic[42-IRQ_OFFSET], pic[43-IRQ_OFFSET], pic[44-IRQ_OFFSET], NULL);
@@ -246,6 +250,10 @@ static void zynq_init(MachineState *machine)
     gem_init(&nd_table[0], 0xE000B000, pic[54-IRQ_OFFSET]);
     gem_init(&nd_table[1], 0xE000C000, pic[77-IRQ_OFFSET]);
 
+    /* Complete the slcr initialization */
+    qdev_init_nofail(slcr);
+    sysbus_mmio_map(SYS_BUS_DEVICE(slcr), 0, 0xF8000000);
+
     for (n = 0; n < 2; n++) {
         int hci_irq = n ? 79 : 56;
         hwaddr hci_addr = n ? 0xE0101000 : 0xE0100000;
-- 
2.18.0
