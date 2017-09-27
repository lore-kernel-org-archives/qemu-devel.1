Received: from eggs.gnu.org ([2001:4830:134:3::10]:47540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxISU-0006e2-Mx
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxIST-0007Lc-Hl
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:57:26 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 16:56:33 -0300
Message-Id: <20170927195635.16014-4-ehabkost@redhat.com>
In-Reply-To: <20170927195635.16014-1-ehabkost@redhat.com>
References: <20170927195635.16014-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 3/5] pci: Add INTERFACE_PCIE_DEVICE to all
 PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, Alistair Francis <alistair23@gmail.com>, Laine Stump <laine@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Paul Burton <paul.burton@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org

Change all devices that set is_express=1 to implement
INTERFACE_PCIE_DEVICE.

Cc: Keith Busch <keith.busch@intel.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Dmitry Fleytman <dmitry@daynix.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: qemu-block@nongnu.org
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* base-xhci is marked as hybrid, now (in another patch)
* Included pcie-pci-bridge
---
 hw/block/nvme.c                    | 4 ++++
 hw/net/e1000e.c                    | 4 ++++
 hw/pci-bridge/pcie_pci_bridge.c    | 1 +
 hw/pci-bridge/pcie_root_port.c     | 4 ++++
 hw/pci-bridge/xio3130_downstream.c | 4 ++++
 hw/pci-bridge/xio3130_upstream.c   | 4 ++++
 hw/pci-host/xilinx-pcie.c          | 4 ++++
 hw/scsi/megasas.c                  | 6 ++++++
 8 files changed, 31 insertions(+)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 9aa32692a3..441e21ed1f 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -1110,6 +1110,10 @@ static const TypeInfo nvme_info = {
     .instance_size = sizeof(NvmeCtrl),
     .class_init    = nvme_class_init,
     .instance_init = nvme_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
 };
 
 static void nvme_register_types(void)
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 6c42b4478c..81f7934a59 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -708,6 +708,10 @@ static const TypeInfo e1000e_info = {
     .instance_size = sizeof(E1000EState),
     .class_init = e1000e_class_init,
     .instance_init = e1000e_instance_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
 };
 
 static void e1000e_register_types(void)
diff --git a/hw/pci-bridge/pcie_pci_bridge.c b/hw/pci-bridge/pcie_pci_bridge.c
index 9aa5cc3e45..88db143633 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -180,6 +180,7 @@ static const TypeInfo pcie_pci_bridge_info = {
         .class_init = pcie_pci_bridge_class_init,
         .interfaces = (InterfaceInfo[]) {
             { TYPE_HOTPLUG_HANDLER },
+            { INTERFACE_PCIE_DEVICE },
             { },
         }
 };
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 4d588cb22e..9b6e4ce512 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -161,6 +161,10 @@ static const TypeInfo rp_info = {
     .class_init    = rp_class_init,
     .abstract      = true,
     .class_size = sizeof(PCIERootPortClass),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
 };
 
 static void rp_register_types(void)
diff --git a/hw/pci-bridge/xio3130_downstream.c b/hw/pci-bridge/xio3130_downstream.c
index e706f36cb7..7d2f7629c1 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -195,6 +195,10 @@ static const TypeInfo xio3130_downstream_info = {
     .name          = "xio3130-downstream",
     .parent        = TYPE_PCIE_SLOT,
     .class_init    = xio3130_downstream_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
 };
 
 static void xio3130_downstream_register_types(void)
diff --git a/hw/pci-bridge/xio3130_upstream.c b/hw/pci-bridge/xio3130_upstream.c
index a052224bbf..227997ce46 100644
--- a/hw/pci-bridge/xio3130_upstream.c
+++ b/hw/pci-bridge/xio3130_upstream.c
@@ -166,6 +166,10 @@ static const TypeInfo xio3130_upstream_info = {
     .name          = "x3130-upstream",
     .parent        = TYPE_PCIE_PORT,
     .class_init    = xio3130_upstream_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
 };
 
 static void xio3130_upstream_register_types(void)
diff --git a/hw/pci-host/xilinx-pcie.c b/hw/pci-host/xilinx-pcie.c
index 4613dda1d2..7659253090 100644
--- a/hw/pci-host/xilinx-pcie.c
+++ b/hw/pci-host/xilinx-pcie.c
@@ -317,6 +317,10 @@ static const TypeInfo xilinx_pcie_root_info = {
     .parent = TYPE_PCI_BRIDGE,
     .instance_size = sizeof(XilinxPCIERoot),
     .class_init = xilinx_pcie_root_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_PCIE_DEVICE },
+        { }
+    },
 };
 
 static void xilinx_pcie_register(void)
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 0db68aacee..535ee267c3 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2451,6 +2451,7 @@ typedef struct MegasasInfo {
     int osts;
     const VMStateDescription *vmsd;
     Property *props;
+    InterfaceInfo *interfaces;
 } MegasasInfo;
 
 static struct MegasasInfo megasas_devices[] = {
@@ -2480,6 +2481,10 @@ static struct MegasasInfo megasas_devices[] = {
         .is_express = true,
         .vmsd = &vmstate_megasas_gen2,
         .props = megasas_properties_gen2,
+        .interfaces = (InterfaceInfo[]) {
+            { INTERFACE_PCIE_DEVICE },
+            { }
+        },
     }
 };
 
@@ -2531,6 +2536,7 @@ static void megasas_register_types(void)
         type_info.parent = TYPE_MEGASAS_BASE;
         type_info.class_data = (void *)info;
         type_info.class_init = megasas_class_init;
+        type_info.interfaces = info->interfaces;
 
         type_register(&type_info);
     }
-- 
2.13.5
