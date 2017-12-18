Received: from eggs.gnu.org ([208.118.235.92]:41563)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eQxFk-0004dN-T1
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:22:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ybettan@redhat.com>) id 1eQxFf-0005Zh-CT
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 10:22:52 -0500
From: Yoni Bettan <ybettan@redhat.com>
Date: Mon, 18 Dec 2017 17:21:40 +0200
Message-Id: <20171218152140.17985-1-ybettan@redhat.com>
Subject: [Qemu-devel] [PATCH V5] pci: removed the is_express field since a
 uniform interface was inserted
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Yoni Bettan <ybettan@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Paul Burton <paul.burton@mips.com>, Hannes Reinecke <hare@suse.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:nvme" <qemu-block@nongnu.org>, "open list:X86" <xen-devel@lists.xenproject.org>

according to Eduardo Habkost's commit fd3b02c889 all PCIEs now implement
INTERFACE_PCIE_DEVICE so we don't need is_express field anymore.

Devices that implements only INTERFACE_PCIE_DEVICE (is_express == 1)
or
devices that implements only INTERFACE_CONVENTIONAL_PCI_DEVICE (is_express == 0)
where not affected by the change.

The only devices that were affected are those that are hybrid and also
had (is_express == 1) - therefor only:
  - hw/vfio/pci.c
  - hw/usb/hcd-xhci.c
  - hw/xen/xen_pt.c

For those 3 I made sure that QEMU_PCI_CAP_EXPRESS is on in instance_init()

Signed-off-by: Yoni Bettan <ybettan@redhat.com>
---
 docs/pcie_pci_bridge.txt           | 2 +-
 hw/block/nvme.c                    | 1 -
 hw/net/e1000e.c                    | 1 -
 hw/pci-bridge/pcie_pci_bridge.c    | 1 -
 hw/pci-bridge/pcie_root_port.c     | 1 -
 hw/pci-bridge/xio3130_downstream.c | 1 -
 hw/pci-bridge/xio3130_upstream.c   | 1 -
 hw/pci-host/xilinx-pcie.c          | 1 -
 hw/pci/pci.c                       | 8 ++++++--
 hw/scsi/megasas.c                  | 4 ----
 hw/usb/hcd-xhci.c                  | 9 ++++++++-
 hw/vfio/pci.c                      | 5 ++++-
 hw/xen/xen_pt.c                    | 9 ++++++++-
 include/hw/pci/pci.h               | 3 ---
 14 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/docs/pcie_pci_bridge.txt b/docs/pcie_pci_bridge.txt
index 5a4203f97c..ab35ebf3ca 100644
--- a/docs/pcie_pci_bridge.txt
+++ b/docs/pcie_pci_bridge.txt
@@ -110,5 +110,5 @@ To enable device hot-plug into the bridge on Linux there're 3 ways:
 Implementation
 ==============
 The PCIE-PCI bridge is based on PCI-PCI bridge, but also accumulates PCI Express
-features as a PCI Express device (is_express=1).
+features as a PCI Express device.
 
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 441e21ed1f..9325bc0911 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1087,7 +1087,6 @@ static void nvme_class_init(ObjectClass *oc, void *data)
     pc->vendor_id = PCI_VENDOR_ID_INTEL;
     pc->device_id = 0x5845;
     pc->revision = 2;
-    pc->is_express = 1;
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->desc = "Non-Volatile Memory Express";
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index f1af279e8d..c360f0d8c9 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -675,7 +675,6 @@ static void e1000e_class_init(ObjectClass *class, void *data)
     c->revision = 0;
     c->romfile = "efi-e1000e.rom";
     c->class_id = PCI_CLASS_NETWORK_ETHERNET;
-    c->is_express = 1;
 
     dc->desc = "Intel 82574L GbE Controller";
     dc->reset = e1000e_qdev_reset;
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index a4d827c99d..b7d9ebbec2 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -169,7 +169,6 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
-    k->is_express = 1;
     k->is_bridge = 1;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE;
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 9b6e4ce512..45f9e8cd4a 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -145,7 +145,6 @@ static void rp_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->is_express = 1;
     k->is_bridge = 1;
     k->config_write = rp_write_config;
     k->realize = rp_realize;
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index 1e09d2afb7..613a0d6bb7 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -177,7 +177,6 @@ static void xio3130_downstream_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->is_express = 1;
     k->is_bridge = 1;
     k->config_write = xio3130_downstream_write_config;
     k->realize = xio3130_downstream_realize;
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index 227997ce46..d4645bddee 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -148,7 +148,6 @@ static void xio3130_upstream_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->is_express = 1;
     k->is_bridge = 1;
     k->config_write = xio3130_upstream_write_config;
     k->realize = xio3130_upstream_realize;
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 7659253090..a4ca3ba30f 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -298,7 +298,6 @@ static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
     k->device_id = 0x7021;
     k->revision = 0;
     k->class_id = PCI_CLASS_BRIDGE_HOST;
-    k->is_express = true;
     k->is_bridge = true;
     k->init = xilinx_pcie_root_init;
     k->exit = pci_bridge_exitfn;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index b2d139bd9a..dc6faa46b9 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2014,12 +2014,16 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
 {
     PCIDevice *pci_dev = (PCIDevice *)qdev;
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
+    ObjectClass *klass = OBJECT_CLASS(pc);
     Error *local_err = NULL;
     PCIBus *bus;
     bool is_default_rom;
 
-    /* initialize cap_present for pci_is_express() and pci_config_size() */
-    if (pc->is_express) {
+    /* initialize cap_present for pci_is_express() and pci_config_size(),
+     * Note that hybrid PCIs are not set automatically and need to manage
+     * QEMU_PCI_CAP_EXPRESS manually */
+    if (object_class_dynamic_cast(klass, INTERFACE_PCIE_DEVICE) &&
+       !object_class_dynamic_cast(klass, INTERFACE_CONVENTIONAL_PCI_DEVICE)) {
         pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
     }
 
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index d5eae6239a..ee51feda59 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2447,7 +2447,6 @@ typedef struct MegasasInfo {
     uint16_t subsystem_id;
     int ioport_bar;
     int mmio_bar;
-    bool is_express;
     int osts;
     const VMStateDescription *vmsd;
     Property *props;
@@ -2465,7 +2464,6 @@ static struct MegasasInfo megasas_devices[] = {
         .ioport_bar = 2,
         .mmio_bar = 0,
         .osts = MFI_1078_RM | 1,
-        .is_express = false,
         .vmsd = &vmstate_megasas_gen1,
         .props = megasas_properties_gen1,
         .interfaces = (InterfaceInfo[]) {
@@ -2482,7 +2480,6 @@ static struct MegasasInfo megasas_devices[] = {
         .ioport_bar = 0,
         .mmio_bar = 1,
         .osts = MFI_GEN2_RM,
-        .is_express = true,
         .vmsd = &vmstate_megasas_gen2,
         .props = megasas_properties_gen2,
         .interfaces = (InterfaceInfo[]) {
@@ -2506,7 +2503,6 @@ static void megasas_class_init(ObjectClass *oc, void *data)
     pc->subsystem_vendor_id = PCI_VENDOR_ID_LSI_LOGIC;
     pc->subsystem_id = info->subsystem_id;
     pc->class_id = PCI_CLASS_STORAGE_RAID;
-    pc->is_express = info->is_express;
     e->mmio_bar = info->mmio_bar;
     e->ioport_bar = info->ioport_bar;
     e->osts = info->osts;
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index af3a9d88de..50a409f0f5 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3649,6 +3649,13 @@ static Property xhci_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void xhci_instance_init(Object *obj)
+{
+    /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices */
+    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
+}
+
 static void xhci_class_init(ObjectClass *klass, void *data)
 {
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
@@ -3661,7 +3668,6 @@ static void xhci_class_init(ObjectClass *klass, void *data)
     k->realize      = usb_xhci_realize;
     k->exit         = usb_xhci_exit;
     k->class_id     = PCI_CLASS_SERIAL_USB;
-    k->is_express   = 1;
 }
 
 static const TypeInfo xhci_info = {
@@ -3669,6 +3675,7 @@ static const TypeInfo xhci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
+    .instance_init = xhci_instance_init,
     .abstract      = true,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_PCIE_DEVICE },
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index c977ee327f..195732a000 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2972,6 +2972,10 @@ static void vfio_instance_init(Object *obj)
     vdev->host.function = ~0U;
 
     vdev->nv_gpudirect_clique = 0xFF;
+
+    /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices */
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
 static Property vfio_pci_dev_properties[] = {
@@ -3026,7 +3030,6 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
     pdc->exit = vfio_exitfn;
     pdc->config_read = vfio_pci_read_config;
     pdc->config_write = vfio_pci_write_config;
-    pdc->is_express = 1; /* We might be */
 }
 
 static const TypeInfo vfio_pci_dev_info = {
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index d57c6d3485..6ce9bfe7fb 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -937,6 +937,13 @@ static Property xen_pci_passthrough_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static void xen_pci_passthrough_instance_init(Object *obj)
+{
+    /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices */
+    PCI_DEVICE(obj)->cap_present |= QEMU_PCI_CAP_EXPRESS;
+}
+
 static void xen_pci_passthrough_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -946,7 +953,6 @@ static void xen_pci_passthrough_class_init(ObjectClass *klass, void *data)
     k->exit = xen_pt_unregister_device;
     k->config_read = xen_pt_pci_read_config;
     k->config_write = xen_pt_pci_write_config;
-    k->is_express = 1; /* We might be */
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->desc = "Assign an host PCI device with Xen";
     dc->props = xen_pci_passthrough_properties;
@@ -965,6 +971,7 @@ static const TypeInfo xen_pci_passthrough_info = {
     .instance_size = sizeof(XenPCIPassthroughState),
     .instance_finalize = xen_pci_passthrough_finalize,
     .class_init = xen_pci_passthrough_class_init,
+    .instance_init = xen_pci_passthrough_instance_init,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { INTERFACE_PCIE_DEVICE },
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 8d02a0a383..a27be85111 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -236,9 +236,6 @@ typedef struct PCIDeviceClass {
      */
     int is_bridge;
 
-    /* pcie stuff */
-    int is_express;   /* is this device pci express? */
-
     /* rom bar */
     const char *romfile;
 } PCIDeviceClass;
-- 
2.14.3
