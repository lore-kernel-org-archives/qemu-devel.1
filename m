Received: from eggs.gnu.org ([2001:4830:134:3::10]:49098)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWc-0002fF-Og
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWb-0006ug-NS
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZWb-0006sz-Di
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:37 -0400
Date: Sun, 15 Oct 2017 06:23:29 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-17-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 16/26] pci: Add interface names to hybrid PCI
 devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

The following devices support both PCI Express and Conventional
PCI, by including special code to handle the QEMU_PCI_CAP_EXPRESS
flag and/or conditional pcie_endpoint_cap_init() calls:

* vfio-pci (is_express=1, but legacy PCI handled by
  vfio_populate_device())
* vmxnet3 (is_express=0, but PCIe handled by vmxnet3_realize())
* pvscsi (is_express=0, but PCIe handled by pvscsi_realize())
* virtio-pci (is_express=0, but PCIe handled by
  virtio_pci_dc_realize(), and additional legacy PCI code at
  virtio_pci_realize())
* base-xhci (is_express=1, but pcie_endpoint_cap_init() call
  is conditional on pci_bus_is_express(dev->bus)
  * Note that xhci does not clear QEMU_PCI_CAP_EXPRESS like the
    other hybrid devices

Cc: Dmitry Fleytman <dmitry@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/net/vmxnet3.c       | 5 +++++
 hw/scsi/vmw_pvscsi.c   | 2 ++
 hw/usb/hcd-xhci.c      | 5 +++++
 hw/vfio/pci.c          | 5 +++++
 hw/virtio/virtio-pci.c | 5 +++++
 5 files changed, 22 insertions(+)

diff --git a/hw/net/vmxnet3.c b/hw/net/vmxnet3.c
index b43b58b..8c4bae5 100644
--- a/hw/net/vmxnet3.c
+++ b/hw/net/vmxnet3.c
@@ -2653,6 +2653,11 @@ static const TypeInfo vmxnet3_info = {
     .instance_size = sizeof(VMXNET3State),
     .class_init    = vmxnet3_class_init,
     .instance_init = vmxnet3_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
 };
 
 static void vmxnet3_register_types(void)
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index d807915..d564e5c 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -1302,6 +1302,8 @@ static const TypeInfo pvscsi_info = {
     .class_init    = pvscsi_class_init,
     .interfaces = (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
     }
 };
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index d75c085..af3a9d8 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3670,6 +3670,11 @@ static const TypeInfo xhci_info = {
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
     .abstract      = true,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
 };
 
 static void qemu_xhci_class_init(ObjectClass *klass, void *data)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 9e86db7..c977ee3 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3036,6 +3036,11 @@ static const TypeInfo vfio_pci_dev_info = {
     .class_init = vfio_pci_dev_class_init,
     .instance_init = vfio_instance_init,
     .instance_finalize = vfio_instance_finalize,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
 };
 
 static void register_vfio_pci_dev_type(void)
diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index f825a68..6c60aa0 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1904,6 +1904,11 @@ static const TypeInfo virtio_pci_info = {
     .class_init    = virtio_pci_class_init,
     .class_size    = sizeof(VirtioPCIClass),
     .abstract      = true,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    },
 };
 
 /* virtio-blk-pci */
-- 
MST
