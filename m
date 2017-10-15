Received: from eggs.gnu.org ([2001:4830:134:3::10]:49161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWj-0002n8-VS
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWi-0006zI-Nl
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:45 -0400
Date: Sun, 15 Oct 2017 06:23:36 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-18-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 17/26] pci: Add INTERFACE_PCIE_DEVICE to all
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Dmitry Fleytman <dmitry@daynix.com>, Jason Wang <jasowang@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paul Burton <paul.burton@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>, Hannes Reinecke <hare@suse.com>, qemu-block@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, David Gibson <david@gibson.dropbear.id.au>

From: Eduardo Habkost <ehabkost@redhat.com>

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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
index 9aa3269..441e21e 100644
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
index 744f0f3..f1af279 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -710,6 +710,10 @@ static const TypeInfo e1000e_info = {
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
index da562fe..a4d827c 100644
--- a/hw/pci-bridge/pcie_pci_bridge.c
+++ b/hw/pci-bridge/pcie_pci_bridge.c
@@ -192,6 +192,7 @@ static const TypeInfo pcie_pci_bridge_info = {
         .class_init = pcie_pci_bridge_class_init,
         .interfaces = (InterfaceInfo[]) {
             { TYPE_HOTPLUG_HANDLER },
+            { INTERFACE_PCIE_DEVICE },
             { },
         }
 };
diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index 4d588cb..9b6e4ce 100644
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
index 5a882b0..1e09d2a 100644
--- a/hw/pci-bridge/xio3130_downstream.c
+++ b/hw/pci-bridge/xio3130_downstream.c
@@ -196,6 +196,10 @@ static const TypeInfo xio3130_downstream_info = {
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
index a052224..227997c 100644
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
index 4613dda..7659253 100644
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
index 0db68aa..535ee26 100644
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
MST
