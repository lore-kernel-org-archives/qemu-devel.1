Received: from eggs.gnu.org ([2001:4830:134:3::10]:37099)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fuFMV-0000u8-62
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:07:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fuFLb-0005pO-QT
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 07:06:19 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 27 Aug 2018 12:05:44 +0100
Message-Id: <20180827110544.12256-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] 40p: fix PCI interrupt routing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hpoussin@reactos.org, david@gibson.dropbear.id.au, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

According to the PReP specification section 6.1.6 "System Interrupt
Assignments", all PCI interrupts are routed via IRQ 15.

With this patch applied it is now possible to boot the sandalfoot
zImage all the way through to a working userspace when using
OpenBIOS.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/prep.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 162b27a3b8..e82c1355d9 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -668,10 +668,11 @@ static void ibm_40p_init(MachineState *machine)
     dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"));
     qdev_connect_gpio_out(dev, 0,
                           cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
-    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
-    sysbus_connect_irq(pcihost, 1, qdev_get_gpio_in(dev, 13));
-    sysbus_connect_irq(pcihost, 2, qdev_get_gpio_in(dev, 15));
-    sysbus_connect_irq(pcihost, 3, qdev_get_gpio_in(dev, 13));
+    /* According to PReP specification section 6.1.6 "System Interrupt
+     * Assignments", all PCI interrupts are routed via IRQ 15 */
+    for (i = 0; i < PCI_NUM_PINS; i++) {
+        sysbus_connect_irq(pcihost, i, qdev_get_gpio_in(dev, 15));
+    }
     isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
 
     /* Memory controller */
-- 
2.11.0
