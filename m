Received: from eggs.gnu.org ([2001:4830:134:3::10]:56574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFgvG-0000q4-Mg
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1eFgvF-000091-Ft
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:10 -0500
Received: from chuckie.co.uk ([82.165.15.123]:59112
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1eFgvF-000061-9Z
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 08:43:09 -0500
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 17 Nov 2017 13:42:39 +0000
Message-Id: <1510926167-23326-8-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1510926167-23326-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 07/15] apb: return APBState from pci_apb_init()
 rather then PCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This is a first step towards removing pci_apb_init() completely.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci-host/apb.c         |    8 ++++----
 hw/sparc64/sun4u.c        |    6 ++++--
 include/hw/pci-host/apb.h |    6 +++---
 3 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index c7837ef..0c70999 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -612,9 +612,9 @@ static void apb_pci_bridge_realize(PCIDevice *dev, Error **errp)
     pci_bridge_update_mappings(PCI_BRIDGE(br));
 }
 
-PCIBus *pci_apb_init(hwaddr special_base,
-                     hwaddr mem_base,
-                     qemu_irq *ivec_irqs, PCIBus **busA, PCIBus **busB)
+APBState *pci_apb_init(hwaddr special_base,
+                       hwaddr mem_base,
+                       qemu_irq *ivec_irqs, PCIBus **busA, PCIBus **busB)
 {
     DeviceState *dev;
     SysBusDevice *s;
@@ -675,7 +675,7 @@ PCIBus *pci_apb_init(hwaddr special_base,
     qdev_init_nofail(&pci_dev->qdev);
     *busA = pci_bridge_get_sec_bus(br);
 
-    return phb->bus;
+    return d;
 }
 
 static void pci_pbm_reset(DeviceState *d)
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index b441f1e..a64ddc5 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -482,6 +482,7 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     Nvram *nvram;
     unsigned int i;
     uint64_t initrd_addr, initrd_size, kernel_addr, kernel_size, kernel_entry;
+    APBState *apb;
     PCIBus *pci_bus, *pci_busA, *pci_busB;
     PCIDevice *ebus, *pci_dev;
     SysBusDevice *s;
@@ -502,8 +503,9 @@ static void sun4uv_init(MemoryRegion *address_space_mem,
     prom_init(hwdef->prom_addr, bios_name);
 
     ivec_irqs = qemu_allocate_irqs(sparc64_cpu_set_ivec_irq, cpu, IVEC_MAX);
-    pci_bus = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, &pci_busA,
-                           &pci_busB);
+    apb = pci_apb_init(APB_SPECIAL_BASE, APB_MEM_BASE, ivec_irqs, &pci_busA,
+                       &pci_busB);
+    pci_bus = PCI_HOST_BRIDGE(apb)->bus;
 
     /* Only in-built Simba PBMs can exist on the root bus, slot 0 on busA is
        reserved (leaving no slots free after on-board devices) however slots
diff --git a/include/hw/pci-host/apb.h b/include/hw/pci-host/apb.h
index 35d7d5a..a4ef51a 100644
--- a/include/hw/pci-host/apb.h
+++ b/include/hw/pci-host/apb.h
@@ -89,7 +89,7 @@ typedef struct PBMPCIBridge {
 #define PBM_PCI_BRIDGE(obj) \
     OBJECT_CHECK(PBMPCIBridge, (obj), TYPE_PBM_PCI_BRIDGE)
 
-PCIBus *pci_apb_init(hwaddr special_base,
-                     hwaddr mem_base,
-                     qemu_irq *ivec_irqs, PCIBus **bus2, PCIBus **bus3);
+APBState *pci_apb_init(hwaddr special_base,
+                       hwaddr mem_base,
+                       qemu_irq *ivec_irqs, PCIBus **bus2, PCIBus **bus3);
 #endif
-- 
1.7.10.4
