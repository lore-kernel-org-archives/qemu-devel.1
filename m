Received: from eggs.gnu.org ([2001:4830:134:3::10]:50920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDF7-0003Ld-RL
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDF2-0006wW-62
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:49 -0400
Received: from mail.kernel.org ([198.145.29.136]:59162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=cU38=2Y=redhat.com=mst@kernel.org>)
	id 1coDF1-0006w6-Ta
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 14:01:44 -0400
Date: Wed, 15 Mar 2017 20:01:39 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1489600837-11541-6-git-send-email-mst@redhat.com>
References: <1489600837-11541-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1489600837-11541-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 5/7] pci: introduce a bus master container
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

From: Jason Wang <jasowang@redhat.com>

96a8821d2141 ("virtio: unbreak virtio-pci with IOMMU after caching ring
translations") tries to make IOMMU works with virtio memory region
cache, but it requires IOMMU to be created before any virtio
devices. This is sub optimal, fixing this by introduce a bus master
container to make sure address space can be initialized during device
registering, and then we can safely set alias and make
bus_master_enable_region as its subregion during bus master
initialization.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/pci/pci.h | 1 +
 hw/pci/pci.c         | 9 +++++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 9349acb..713ede0 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -284,6 +284,7 @@ struct PCIDevice {
     char name[64];
     PCIIORegion io_regions[PCI_NUM_REGIONS];
     AddressSpace bus_master_as;
+    MemoryRegion bus_master_container_region;
     MemoryRegion bus_master_enable_region;
 
     /* do not access the following fields */
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 273f1e4..ad46390 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -88,8 +88,8 @@ static void pci_init_bus_master(PCIDevice *pci_dev)
                              OBJECT(pci_dev), "bus master",
                              dma_as->root, 0, memory_region_size(dma_as->root));
     memory_region_set_enabled(&pci_dev->bus_master_enable_region, false);
-    address_space_init(&pci_dev->bus_master_as,
-                       &pci_dev->bus_master_enable_region, pci_dev->name);
+    memory_region_add_subregion(&pci_dev->bus_master_container_region, 0,
+                                &pci_dev->bus_master_enable_region);
 }
 
 static void pcibus_machine_done(Notifier *notifier, void *data)
@@ -995,6 +995,11 @@ static PCIDevice *do_pci_register_device(PCIDevice *pci_dev, PCIBus *bus,
     pci_dev->devfn = devfn;
     pci_dev->requester_id_cache = pci_req_id_cache_get(pci_dev);
 
+    memory_region_init(&pci_dev->bus_master_container_region, OBJECT(pci_dev),
+                       "bus master container", UINT64_MAX);
+    address_space_init(&pci_dev->bus_master_as,
+                       &pci_dev->bus_master_container_region, pci_dev->name);
+
     if (qdev_hotplug) {
         pci_init_bus_master(pci_dev);
     }
-- 
MST
