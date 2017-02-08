Received: from eggs.gnu.org ([2001:4830:134:3::10]:57259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbLY6-0000cM-8t
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:16:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbLY5-0006cg-1J
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 01:16:14 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Wed,  8 Feb 2017 17:16:02 +1100
Message-Id: <20170208061602.17666-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [RFC] virtio-pci: Allow PCIe virtio devices on root bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcel@redhat.com, abologna@redhat.com
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, mst@redhat.com, thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, David Gibson <david@gibson.dropbear.id.au>

Marcel,

Your original patch adding PCIe support to virtio-pci.c has the
limitation noted below that PCIe won't be enabled if the device is on
the root bus (rather than under a root or downstream port).  As
reasoned below, I think removing the check is correct, even for x86
(though it would rarely be useful there).  But I could well have
missed something.  Let me know if so...



Virtio devices can appear as either vanilla PCI or PCI-Express devices
depending on the bus they're connected to.  At the moment it will only
appear as vanilla PCI if connected to the root bus of a PCIe host bridge.

Presumably this is to reflect the fact that PCIe devices usually need to
be connected to a root (or further downstream) port rather than directly
on the root bus.  However, due to the odd requirements of the PAPR spec on the 'pseries'
machine type, it's normal for PCIe devices to appear on the root bus
without root ports.

Further, even on x86, there's no inherent reason we couldn't present a
virtio device as an "integrated device" (typically used for things built
into the PCI chipset), and those devices *do* typically appear on the root
bus.

pcie_endpoint_cap_init() already automatically adjusts to advertise as
an integrated device rather than a "normal" PCIe endpoint when attached to
a root bus.  So we can remove the check for root bus within virtio and
allow (at the user's discretion) a PCIe virtio bus to be attached to a
root bus.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/virtio/virtio-pci.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 5ce42af..caea44c 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1737,8 +1737,7 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
 {
     VirtIOPCIProxy *proxy = VIRTIO_PCI(pci_dev);
     VirtioPCIClass *k = VIRTIO_PCI_GET_CLASS(pci_dev);
-    bool pcie_port = pci_bus_is_express(pci_dev->bus) &&
-                     !pci_bus_is_root(pci_dev->bus);
+    bool pcie_port = pci_bus_is_express(pci_dev->bus);
 
     if (!kvm_has_many_ioeventfds()) {
         proxy->flags &= ~VIRTIO_PCI_FLAG_USE_IOEVENTFD;
-- 
2.9.3
