Received: from eggs.gnu.org ([2001:4830:134:3::10]:38244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dl5BF-0004eg-Bt
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 23:21:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dl5BC-0000QF-7l
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 23:21:09 -0400
Received: from ozlabs.ru ([107.173.13.209]:41038)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1dl5BC-0000Pe-1i
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 23:21:06 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri, 25 Aug 2017 13:21:01 +1000
Message-Id: <20170825032101.42538-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] pci: Initialize pci_dev->name before use
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>

This moves pci_dev->name initialization earlier so
pci_dev->bus_master_as could get a name instead of empry string.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/pci/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 258fbe51e2..852babe812 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1000,6 +1000,7 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
 
     pci_dev->devfn = devfn;
     pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
+    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
 
     memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
                        "bus master container", UINT64_MAX);
@@ -1009,7 +1010,6 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     if (qdev_hotplug) {
         pci_init_bus_master(pci_dev);
     }
-    pstrcpy(pci_dev->name, sizeof(pci_dev->name), name);
     pci_dev->irq_state = 0;
     pci_config_alloc(pci_dev);
 
-- 
2.11.0
