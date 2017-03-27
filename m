Received: from eggs.gnu.org ([2001:4830:134:3::10]:53600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1csMSP-00041d-Bb
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 00:40:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1csMSM-00031e-8C
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 00:40:41 -0400
Received: from ozlabs.ru ([107.173.13.209]:60768)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1csMSM-00031F-1v
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 00:40:38 -0400
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Mon, 27 Mar 2017 15:40:30 +1100
Message-Id: <20170327044030.31306-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] pci: Add missing drop of bus master AS
 reference
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

The recent introduction of a bus master container added
memory_region_add_subregion() into the PCI device registering path but
missed memory_region_del_subregion() in the unregistering path leaving
a reference to the root memory region of the new container.

This adds missing memory_region_del_subregion().

Fixes: 3716d5902d743 ("pci: introduce a bus master container")
Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 hw/pci/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index e6b08e1988..bd8043c460 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -869,6 +869,8 @@ static void do_pci_unregister_device(PCIDevice *pci_dev)
     pci_dev->bus->devices[pci_dev->devfn] = NULL;
     pci_config_free(pci_dev);
 
+    memory_region_del_subregion(&pci_dev->bus_master_container_region,
+                                &pci_dev->bus_master_enable_region);
     address_space_destroy(&pci_dev->bus_master_as);
 }
 
-- 
2.11.0
