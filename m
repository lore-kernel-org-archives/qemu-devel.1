Received: from eggs.gnu.org ([2001:4830:134:3::10]:56313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36J-0001JT-Dz
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36G-0005Li-Cl
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:47 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35117
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV36G-0005L7-5H
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:44 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 22:53:20 +0100
Message-Id: <1499810007-28613-2-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 1/8] sun4u: pass PCIDevice into pci_ebus_init()
 instead of PCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

In order to wire up the ebus PCI address spaces differently then we need
access to the underlying PCIDevice.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/sparc64/sun4u.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 69f565d..7738856 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -224,13 +224,11 @@ static void isa_irq_handler(void *opaque, int n, int level)
 
 /* EBUS (Eight bit bus) bridge */
 static ISABus *
-pci_ebus_init(PCIBus *bus, int devfn, qemu_irq *irqs)
+pci_ebus_init(PCIDevice *pci_dev, qemu_irq *irqs)
 {
     qemu_irq *isa_irq;
-    PCIDevice *pci_dev;
     ISABus *isa_bus;
 
-    pci_dev = pci_create_simple(bus, devfn, "ebus");
     isa_bus = ISA_BUS(qdev_get_child_bus(DEVICE(pci_dev), "isa.0"));
     isa_irq = qemu_allocate_irqs(isa_irq_handler, irqs, 16);
     isa_bus_irqs(isa_bus, isa_irq);
@@ -429,6 +427,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     unsigned int i;
     uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_entry;
     PCIBus *pci_bus, *pci_bus2, *pci_bus3;
+    PCIDevice *ebus;
     ISABus *isa_bus;
     SysBusDevice *s;
     qemu_irq *ivec_irqs, *pbm_irqs;
@@ -452,7 +451,8 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     pci_vga_init(pci_bus);
 
     // XXX Should be pci_bus3
-    isa_bus = pci_ebus_init(pci_bus, -1, pbm_irqs);
+    ebus = pci_create_simple(pci_bus, -1, "ebus");
+    isa_bus = pci_ebus_init(ebus, pbm_irqs);
 
     i = 0;
     if (hwdef->console_serial_base) {
-- 
1.7.10.4
