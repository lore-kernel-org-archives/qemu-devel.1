Received: from eggs.gnu.org ([2001:4830:134:3::10]:54948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnGgU-0006Zy-7g
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cnGgP-00082N-AM
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:30:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32996)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cnGgP-000821-4a
	for qemu-devel@nongnu.org; Sun, 12 Mar 2017 23:30:05 -0400
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3E5B661BA8
	for <qemu-devel@nongnu.org>; Mon, 13 Mar 2017 03:30:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Mar 2017 11:29:57 +0800
Message-Id: <1489375798-19518-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] Revert "virtio: unbreak virtio-pci with
 IOMMU after caching ring translations"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, marcel@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com
Cc: Jason Wang <jasowang@redhat.com>

This reverts commit
96a8821d21411f10d77ea994af369c6e5c35a2cc. Following patch will come a
better solution which does not require a strict order between virtio
and IOMMU.

CC: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/virtio-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index b76f3f6..5ce42af 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1153,7 +1153,7 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
     VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
     PCIDevice *dev = &proxy->pci_dev;
 
-    return pci_device_iommu_address_space(dev);
+    return pci_get_address_space(dev);
 }
 
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
-- 
2.7.4
