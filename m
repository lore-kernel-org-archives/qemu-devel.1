Received: from eggs.gnu.org ([2001:4830:134:3::10]:37981)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cRHru-0008PB-7f
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cRHrt-00017s-9m
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:19:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1cRHrt-00017L-4S
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 07:19:05 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A13C61B86
	for <qemu-devel@nongnu.org>; Wed, 11 Jan 2017 12:19:05 +0000 (UTC)
From: Marcel Apfelbaum <marcel@redhat.com>
Date: Wed, 11 Jan 2017 14:18:56 +0200
Message-Id: <1484137136-8021-4-git-send-email-marcel@redhat.com>
In-Reply-To: <1484137136-8021-1-git-send-email-marcel@redhat.com>
References: <1484137136-8021-1-git-send-email-marcel@redhat.com>
Subject: [Qemu-devel] [PATCH V2 3/3] hw/pcie: Introduce Generic PCI Express
 Root Port
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com, marcel@redhat.com

The Generic Root Port behaves the same as the
Intel's IOH device with id 3420, without having
Intel specific attributes.

The device has two purposes:
 (1) Can be used on both X86 and ARM machines.
 (2) It will allow us to tweak the behaviour
    (e.g add vendor-specific PCI capabilities)
     - something that obviously cannot be done
       on a known device.

Signed-off-by: Marcel Apfelbaum <marcel@redhat.com>
---
 hw/pci-bridge/pcie_root_port.c | 34 ++++++++++++++++++++++++++++++++++
 include/hw/pci/pci.h           |  1 +
 2 files changed, 35 insertions(+)

diff --git a/hw/pci-bridge/pcie_root_port.c b/hw/pci-bridge/pcie_root_port.c
index e84ae14..32c6201 100644
--- a/hw/pci-bridge/pcie_root_port.c
+++ b/hw/pci-bridge/pcie_root_port.c
@@ -21,6 +21,9 @@
 #define PCIE_ROOT_PORT_MSI_SUPPORTED_FLAGS      PCI_MSI_FLAGS_MASKBIT
 #define PCIE_ROOT_PORT_AER_OFFSET               0x100
 
+#define TYPE_PCIE_ROOT_PORT_DEV                 "pcie-root-port"
+
+
 /*
  * If two MSI vector are allocated, Advanced Error Interrupt Message Number
  * is 1. otherwise 0.
@@ -186,9 +189,40 @@ static const TypeInfo rp_info = {
     .class_size = sizeof(PCIERootPortClass),
 };
 
+static const VMStateDescription vmstate_rp_dev = {
+    .name = "pcie-root-port",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = pcie_cap_slot_post_load,
+    .fields = (VMStateField[]) {
+        VMSTATE_PCIE_DEVICE(parent_obj.parent_obj.parent_obj, PCIESlot),
+        VMSTATE_STRUCT(parent_obj.parent_obj.parent_obj.exp.aer_log,
+                       PCIESlot, 0, vmstate_pcie_aer_log, PCIEAERLog),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+static void rp_dev_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->vendor_id = PCI_VENDOR_ID_REDHAT;
+    k->device_id = PCI_DEVICE_ID_REDHAT_PCIE_RP;
+    dc->desc = "PCI Express Root Port";
+    dc->vmsd = &vmstate_rp_dev;
+}
+
+static const TypeInfo rp_dev_info = {
+    .name          = TYPE_PCIE_ROOT_PORT_DEV,
+    .parent        = TYPE_PCIE_ROOT_PORT,
+    .class_init    = rp_dev_class_init,
+};
+
 static void rp_register_types(void)
 {
     type_register_static(&rp_info);
+    type_register_static(&rp_dev_info);
 }
 
 type_init(rp_register_types)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 772692f..cbc1fdf 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -96,6 +96,7 @@
 #define PCI_DEVICE_ID_REDHAT_PXB         0x0009
 #define PCI_DEVICE_ID_REDHAT_BRIDGE_SEAT 0x000a
 #define PCI_DEVICE_ID_REDHAT_PXB_PCIE    0x000b
+#define PCI_DEVICE_ID_REDHAT_PCIE_RP     0x000c
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
2.5.5
