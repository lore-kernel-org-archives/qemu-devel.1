Received: from eggs.gnu.org ([2001:4830:134:3::10]:33426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTNw2-0000KP-4n
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dTNw1-0008SO-AI
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:44:18 -0400
Received: from chuckie.co.uk ([82.165.15.123]:54686
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dTNw1-0008QT-3J
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 03:44:17 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri,  7 Jul 2017 08:44:01 +0100
Message-Id: <1499413442-5053-3-git-send-email-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <1499413442-5053-1-git-send-email-mark.cave-ayland@ilande.co.uk>
References: <1499413442-5053-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH 2/3] pci: add dev_reserved_mask property to
 PCIBus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, armbru@redhat.com, marcel@redhat.com

This is just a simple bitmask indicating whether or not each PCI slot on the
bus is reserved. Ensure that it is initialised to zero so that all bus slots
are available by default.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci/pci.c             |    1 +
 include/hw/pci/pci_bus.h |    1 +
 2 files changed, 2 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 04e6edb..239161e 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -371,6 +371,7 @@ static void pci_bus_init(PCIBus *bus, DeviceState *parent,
 {
     assert(PCI_FUNC(devfn_min) == 0);
     bus->devfn_min = devfn_min;
+    bus->dev_reserved_mask = 0x0;
     bus->address_space_mem = address_space_mem;
     bus->address_space_io = address_space_io;
 
diff --git a/include/hw/pci/pci_bus.h b/include/hw/pci/pci_bus.h
index 5484a9b..a0cf655 100644
--- a/include/hw/pci/pci_bus.h
+++ b/include/hw/pci/pci_bus.h
@@ -23,6 +23,7 @@ struct PCIBus {
     PCIIOMMUFunc iommu_fn;
     void *iommu_opaque;
     uint8_t devfn_min;
+    uint32_t dev_reserved_mask;
     pci_set_irq_fn set_irq;
     pci_map_irq_fn map_irq;
     pci_route_irq_fn route_intx_to_irq;
-- 
1.7.10.4
