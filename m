Received: from eggs.gnu.org ([2001:4830:134:3::10]:56312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36J-0001JS-Dy
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dV36I-0005Mg-4r
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:47 -0400
Received: from chuckie.co.uk ([82.165.15.123]:35128
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dV36H-0005MG-Ti
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 17:53:46 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue, 11 Jul 2017 22:53:23 +0100
Message-Id: <1499810007-28613-5-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499810007-28613-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 4/8] apb: fix up PCI bus nomenclature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

Rather than referring to the PCI busses as bus2 and bus3, refer to them as
busA and busB as per the documentation. Also replace the long bus names with
the shorter pciA and pciB aliases (to make it easier to attach additional
devices to either from the command line).

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/apb.c  |   12 +++++-------
 hw/sparc64/sun4u.c |    8 ++++----
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index 326f5ef..622c341 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -656,7 +656,7 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
 
 PCIBus *pci_apb_init(hwaddr special_base,
                      hwaddr mem_base,
-                     qemu_irq *ivec_irqs, PCIBus **bus2, PCIBus **bus3,
+                     qemu_irq *ivec_irqs, PCIBus **busA, PCIBus **busB,
                      qemu_irq **pbm_irqs)
 {
     DeviceState *dev;
@@ -706,18 +706,16 @@ PCIBus *pci_apb_init(hwaddr special_base,
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 0), true,
                                    "pbm-bridge");
     br = PCI_BRIDGE(pci_dev);
-    pci_bridge_map_irq(br, "Advanced PCI Bus secondary bridge 1",
-                       pci_apb_map_irq);
+    pci_bridge_map_irq(br, "pciB", pci_apb_map_irq);
     qdev_init_nofail(&pci_dev->qdev);
-    *bus2 = pci_bridge_get_sec_bus(br);
+    *busB = pci_bridge_get_sec_bus(br);
 
     pci_dev = pci_create_multifunction(phb->bus, PCI_DEVFN(1, 1), true,
                                    "pbm-bridge");
     br = PCI_BRIDGE(pci_dev);
-    pci_bridge_map_irq(br, "Advanced PCI Bus secondary bridge 2",
-                       pci_apb_map_irq);
+    pci_bridge_map_irq(br, "pciA", pci_apb_map_irq);
     qdev_init_nofail(&pci_dev->qdev);
-    *bus3 = pci_bridge_get_sec_bus(br);
+    *busA = pci_bridge_get_sec_bus(br);
 
     return phb->bus;
 }
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index 4f96d97..5ddd30f 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -426,7 +426,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     Nvram *nvram;
     unsigned int i;
     uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_entry;
-    PCIBus *pci_bus, *pci_bus2, *pci_bus3;
+    PCIBus *pci_bus, *pci_busA, *pci_busB;
     PCIDevice *ebus;
     ISABus *isa_bus;
     SysBusDevice *s;
@@ -446,11 +446,11 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     prom_init(hwdef->prom_addr, bios_name);
 
     ivec_irqs = qemu_allocate_irqs(sparc64_cpu_set_ivec_irq, cpu, IVEC_MAX);
-    pci_bus = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, &pci_bus2,
-                           &pci_bus3, &pbm_irqs);
+    pci_bus = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, &pci_busA,
+                           &pci_busB, &pbm_irqs);
     pci_vga_init(pci_bus);
 
-    /* XXX Should be pci_bus3 */
+    /* XXX Should be pci_busA */
     ebus = pci_create_simple(pci_bus, -1, "ebus");
     isa_bus = pci_ebus_init(ebus, pbm_irqs);
 
-- 
1.7.10.4
