Received: from eggs.gnu.org ([2001:4830:134:3::10]:36541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQI0a-0004rM-WD
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dQI0a-00017x-4W
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 14:48:13 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed, 28 Jun 2017 19:47:24 +0100
Message-Id: <20170628184724.21378-7-stefanha@redhat.com>
In-Reply-To: <20170628184724.21378-1-stefanha@redhat.com>
References: <20170628184724.21378-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 6/6] virtio-pci: use ioeventfd even when KVM is
 disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Old kvm.ko versions only supported a tiny number of ioeventfds so
virtio-pci avoids ioeventfds when kvm_has_many_ioeventfds() returns 0.

Do not check kvm_has_many_ioeventfds() when KVM is disabled since it
always returns 0.  Since commit 8c56c1a592b5092d91da8d8943c17777d6462a6f
("memory: emulate ioeventfd") it has been possible to use ioeventfds in
qtest or TCG mode.

This patch makes -device virtio-blk-pci,iothread=iothread0 work even
when KVM is disabled.

I have tested that virtio-blk-pci works under TCG both with and without
iothread.

This patch fixes qemu-iotests 068, which was accidentally merged early
despite the dependency on ioeventfd.

Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Message-id: 20170615163813.7255-2-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/virtio/virtio-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 20d6a08..301920e 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1740,7 +1740,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
     bool pcie_port = pci_bus_is_express(pci_dev->bus) &&
                      !pci_bus_is_root(pci_dev->bus);
 
-    if (!kvm_has_many_ioeventfds()) {
+    if (kvm_enabled() && !kvm_has_many_ioeventfds()) {
         proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
     }
 
-- 
2.9.4
