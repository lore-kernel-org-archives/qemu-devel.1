Received: from eggs.gnu.org ([2001:4830:134:3::10]:36706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1eP2Ns-0004v6-J0
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 03:27:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ben@skyportsystems.com>) id 1eP2Np-0004Jh-ES
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 03:27:20 -0500
Received: from mail-pg0-x242.google.com ([2607:f8b0:400e:c05::242]:37284)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ben@skyportsystems.com>)
	id 1eP2Np-0004IC-78
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 03:27:17 -0500
Received: by mail-pg0-x242.google.com with SMTP id y6so966384pgp.4
	for <qemu-devel@nongnu.org>; Wed, 13 Dec 2017 00:27:16 -0800 (PST)
From: ben@skyportsystems.com
Date: Wed, 13 Dec 2017 00:26:44 -0800
Message-Id: <20171213082644.83113-1-ben@skyportsystems.com>
Subject: [Qemu-devel] [PATCH] virtio-pci: Add subsystem-vendor-id property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, qemu-devel@nongnu.org
Cc: yan@daynix.com, lprosek@redhat.com, eswierk@skyportsystems.com, Ben Warren <ben@skyportsystems.com>

From: Ben Warren <ben@skyportsystems.com>

Now that virtio-win guest drivers provided by non-Redhat vendors need to
use a different Subsystem Vendor ID value, a way is needed to set this
parameter on the host.  This works with all of the PCI-based devices,
such as NetKVM, viostor, vioscsi, vioserial and balloon.

Signed-off-by: Ben Warren <ben@skyportsystems.com>
---
 hw/virtio/virtio-pci.c | 5 +++++
 hw/virtio/virtio-pci.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index e92837c..b5c86e3 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1757,6 +1757,9 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
     if (proxy->disable_legacy == ON_OFF_AUTO_AUTO) {
         proxy->disable_legacy = pcie_port ? ON_OFF_AUTO_ON : ON_OFF_AUTO_OFF;
     }
+    /* Set the PCI Subsystem Vendor ID */
+    k->parent_class.subsystem_vendor_id = proxy->subsystem_vendor_id;
+    pci_set_word(pci_dev->config + PCI_SUBSYSTEM_VENDOR_ID, proxy->subsystem_vendor_id);
 
     if (!virtio_pci_modern(proxy) && !virtio_pci_legacy(proxy)) {
         error_setg(errp, "device cannot work as neither modern nor legacy mode"
@@ -1876,6 +1879,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    DEFINE_PROP_UINT16("subsystem-vendor-id", VirtIOPCIProxy,
+                       subsystem_vendor_id, PCI_VENDOR_ID_REDHAT_QUMRANET),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 12d3a90..8a897ea 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -186,6 +186,7 @@ struct VirtIOPCIProxy {
     VirtIOIRQFD *vector_irqfd;
     int nvqs_with_notifiers;
     VirtioBusState bus;
+    uint16_t subsystem_vendor_id;
 };
 
 static inline bool virtio_pci_modern(VirtIOPCIProxy *proxy)
-- 
2.7.4
