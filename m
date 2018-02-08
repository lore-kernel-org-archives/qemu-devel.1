Received: from eggs.gnu.org ([2001:4830:134:3::10]:54270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZQ-0006Lb-Fe
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ejrZN-0008QP-SN
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 14:09:20 -0500
Date: Thu, 8 Feb 2018 21:09:11 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1518116908-10852-15-git-send-email-mst@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518116908-10852-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 14/26] pci: removed the is_express field since a
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yoni Bettan <ybettan@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang <jasowang@redhat.com>, Paul Burton <paul.burton@mips.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Hannes Reinecke <hare@suse.com>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, qemu-block@nongnu.org, xen-devel@lists.xenproject.org

From: Yoni Bettan <ybettan@redhat.com>

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

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Yoni Bettan <ybettan@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/pcie_pci_bridge.txt           | 2 +-
 include/hw/pci/pci.h               | 3 ---
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
 14 files changed, 27 insertions(+), 20 deletions(-)

diff --git a/docs/pcie_pci_bridge.txt b/docs/pcie_pci_bridge.txt
index 5a4203f..ab35ebf 100644
--- a/docs/pcie_pci_bridge.txt
+++ b/docs/pcie_pci_bridge.txt
@@ -110,5 +110,5 @@ To enable device hot-plug into the bridge on Linux there're 3 ways:
 Implementation
 ==============
 The PCIE-PCI bridge is based on PCI-PCI bridge, but also accumulates PCI Express
-features as a PCI Express device (is_express=1).
+features as a PCI Express device.
 
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 15ced96..d8c18c7 100644
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
diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 51a58fe..85d2406 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1360,7 +1360,6 @@ static void nvme_class_init(ObjectClass *oc, void *data)
     pc->vendor_id = PCI_VENDOR_ID_INTEL;
     pc->device_id = 0x5845;
     pc->revision = 2;
-    pc->is_express = 1;
 
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
     dc->desc = "Non-Volatile Memory Express";
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 191398a..16a9417 100644
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
index e5ac797..04cf5a6 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -170,7 +170,6 @@ static void pcie_pci_bridge_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(klass);
 
-    k->is_express = 1;
     k->is_bridge = 1;
     k->vendor_id = PCI_VENDOR_ID_REDHAT;
     k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_BRIDGE;
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 9b6e4ce..45f9e8c 100644
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
index 4dd2e65..b202657 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -178,7 +178,6 @@ static void xio3130_downstream_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->is_express = 1;
     k->is_bridge = 1;
     k->config_write = xio3130_downstream_write_config;
     k->realize = xio3130_downstream_realize;
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index c5f02a6..556f471 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -149,7 +149,6 @@ static void xio3130_upstream_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
     PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
 
-    k->is_express = 1;
     k->is_bridge = 1;
     k->config_write = xio3130_upstream_write_config;
     k->realize = xio3130_upstream_realize;
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 53b561f..044e312 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -297,7 +297,6 @@ static void xilinx_pcie_root_class_init(ObjectClass *klass, void *data)
     k->device_id = 0x7021;
     k->revision = 0;
     k->class_id = PCI_CLASS_BRIDGE_HOST;
-    k->is_express = true;
     k->is_bridge = true;
     k->realize = xilinx_pcie_root_realize;
     k->exit = pci_bridge_exitfn;
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index fc25cde..ef43422 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2005,11 +2005,15 @@ static void pci_qdev_realize(DeviceState *qdev, Error **errp)
 {
     PCIDevice *pci_dev = (PCIDevice *)qdev;
     PCIDeviceClass *pc = PCI_DEVICE_GET_CLASS(pci_dev);
+    ObjectClass *klass = OBJECT_CLASS(pc);
     Error *local_err = NULL;
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
index 3e38e9e..ba1afa3 100644
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
index 228e82b..721beb5 100644
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
index 879510c..b33c5e8 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -3113,6 +3113,10 @@ static void vfio_instance_init(Object *obj)
     vdev->host.function = ~0U;
 
     vdev->nv_gpudirect_clique = 0xFF;
+
+    /* QEMU_PCI_CAP_EXPRESS initialization does not depend on QEMU command
+     * line, therefore, no need to wait to realize like other devices */
+    pci_dev->cap_present |= QEMU_PCI_CAP_EXPRESS;
 }
 
 static Property vfio_pci_dev_properties[] = {
@@ -3171,7 +3175,6 @@ static void vfio_pci_dev_class_init(ObjectClass *klass, void *data)
     pdc->exit = vfio_exitfn;
     pdc->config_read = vfio_pci_read_config;
     pdc->config_write = vfio_pci_write_config;
-    pdc->is_express = 1; /* We might be */
 }
 
 static const TypeInfo vfio_pci_dev_info = {
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index f662f30..9b7a960 100644
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
-- 
MST
