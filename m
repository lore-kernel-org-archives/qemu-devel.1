Received: from eggs.gnu.org ([2001:4830:134:3::10]:44423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6g-0001o4-Aq
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6f-0004As-7w
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:54 -0500
Received: from mail.kernel.org ([198.145.29.136]:51352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <SRS0=SaHx=2L=redhat.com=mst@kernel.org>)
	id 1cjK6f-00048H-1y
	for qemu-devel@nongnu.org; Thu, 02 Mar 2017 01:20:53 -0500
Date: Thu, 2 Mar 2017 08:20:49 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1488435591-17882-13-git-send-email-mst@redhat.com>
References: <1488435591-17882-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1488435591-17882-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 12/15] virtio: unbreak virtio-pci with IOMMU
 after caching ring translations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

From: Jason Wang <jasowang@redhat.com>

Commit c611c76417f5 ("virtio: add MemoryListener to cache ring
translations") registers a memory listener to dma_as. This may not
work when IOMMU is enabled: dma_as(bus_master_as) were initialized in
pcibus_machine_done() after virtio_realize(). This will cause a
segfault. Fixing this by using pci_device_iommu_address_space()
instead to make sure address space were initialized at this time.

With this fix, IOMMU device were required to be initialized before any
virtio-pci devices.

Fixes: c611c76417f5 ("virtio: add MemoryListener to cache ring translations")
Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5ce42af..b76f3f6 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1153,7 +1153,7 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
     PCIDevice *dev = &proxy->pci_dev;
 
-    return pci_get_address_space(dev);
+    return pci_device_iommu_address_space(dev);
 }
 
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
-- 
MST
