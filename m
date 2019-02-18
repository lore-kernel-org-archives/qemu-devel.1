Received: from eggs.gnu.org ([209.51.188.92]:34848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvhng-00062G-SC
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1gvhne-0006ce-9g
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:32 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:27818)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1gvhna-0006XS-2O
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 07:13:27 -0500
Message-Id: <e9f29b1aa44e719d15bfb658e2c03a9715c8b9c0.1550491301.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1550491301.git.balaton@eik.bme.hu>
References: <cover.1550491301.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Mon, 18 Feb 2019 13:01:41 +0100
Subject: [Qemu-devel] [PATCH v2 1/3] hw/pci-host/bonito.c: Add PCI mem
 region mapped at the correct address
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Markovic <amarkovic@wavecomp.com>, Huacai Chen <zltjiangshi@gmail.com>, philmd@redhat.com

Stop using system memory as PCI memory otherwise devices such as VGA
that have regions mapped to PCI memory clash with RAM. Use a separate
memory region for PCI memory and map it to the correct address in
system memory which allows PCI mem regions to show at the correct
address where clients expect them.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
v2: add mem region to BonitoState instead of allocating it

 hw/pci-host/bonito.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 9f33582706..dde4437595 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -217,6 +217,7 @@ struct BonitoState {
     PCIHostState parent_obj;
     qemu_irq *pic;
     PCIBonitoState *pci_dev;
+    MemoryRegion pci_mem;
 };
 
 #define TYPE_BONITO_PCI_HOST_BRIDGE "Bonito-pcihost"
@@ -598,11 +599,15 @@ static const VMStateDescription vmstate_bonito = {
 static void bonito_pcihost_realize(DeviceState *dev, Error **errp)
 {
     PCIHostState *phb = PCI_HOST_BRIDGE(dev);
+    BonitoState *bs = BONITO_PCI_HOST_BRIDGE(dev);
 
+    memory_region_init(&bs->pci_mem, OBJECT(dev), "pci.mem", BONITO_PCILO_SIZE);
     phb->bus = pci_register_root_bus(DEVICE(dev), "pci",
                                      pci_bonito_set_irq, pci_bonito_map_irq,
-                                     dev, get_system_memory(), get_system_io(),
+                                     dev, &bs->pci_mem, get_system_io(),
                                      0x28, 32, TYPE_PCI_BUS);
+    memory_region_add_subregion(get_system_memory(), BONITO_PCILO_BASE,
+                                &bs->pci_mem);
 }
 
 static void bonito_realize(PCIDevice *dev, Error **errp)
-- 
2.13.7
