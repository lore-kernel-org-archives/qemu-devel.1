Received: from eggs.gnu.org ([2001:4830:134:3::10]:51663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fzT5C-000695-K4
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 16:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fzT59-000374-Ji
	for qemu-devel@nongnu.org; Mon, 10 Sep 2018 16:46:54 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 10 Sep 2018 21:46:31 +0100
Message-Id: <20180910204631.24106-3-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180910204631.24106-1-mark.cave-ayland@ilande.co.uk>
References: <20180910204631.24106-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH v3 2/2] 40p: add fixed IRQ routing for LSI SCSI
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hpoussin@reactos.org, david@gibson.dropbear.id.au, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org

Whilst the PReP specification describes how all PCI IRQs are routed via IRQ
15 on the interrupt controller, the real 40p machine has a routing quirk in
that the LSI SCSI device is routed directly to IRQ 13.

Enable the external IRQ for the LSI SCSI device by wiring up the IRQ with
qdev to the relevant interrupt controller gpio.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ppc/prep.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 615865e46c..94fc36b7ef 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -621,7 +621,7 @@ static void ibm_40p_init(MachineState *machine)
     CPUPPCState *env = NULL;
     uint16_t cmos_checksum;
     PowerPCCPU *cpu;
-    DeviceState *dev;
+    DeviceState *dev, *i82378_dev;
     SysBusDevice *pcihost, *s;
     Nvram *m48t59 = NULL;
     PCIBus *pci_bus;
@@ -666,11 +666,11 @@ static void ibm_40p_init(MachineState *machine)
     }
 
     /* PCI -> ISA bridge */
-    dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"));
-    qdev_connect_gpio_out(dev, 0,
+    i82378_dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(11, 0), "i82378"));
+    qdev_connect_gpio_out(i82378_dev, 0,
                           cpu->env.irq_inputs[PPC6xx_INPUT_INT]);
-    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(dev, 15));
-    isa_bus = ISA_BUS(qdev_get_child_bus(dev, "isa.0"));
+    sysbus_connect_irq(pcihost, 0, qdev_get_gpio_in(i82378_dev, 15));
+    isa_bus = ISA_BUS(qdev_get_child_bus(i82378_dev, "isa.0"));
 
     /* Memory controller */
     dev = DEVICE(isa_create(isa_bus, "rs6000-mc"));
@@ -703,6 +703,7 @@ static void ibm_40p_init(MachineState *machine)
         dev = DEVICE(pci_create_simple(pci_bus, PCI_DEVFN(1, 0),
                                        "lsi53c810"));
         lsi53c8xx_handle_legacy_cmdline(dev);
+        qdev_connect_gpio_out(dev, 0, qdev_get_gpio_in(i82378_dev, 13));
 
         /* XXX: s3-trio at PCI_DEVFN(2, 0) */
         pci_vga_init(pci_bus);
-- 
2.11.0
