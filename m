Received: from eggs.gnu.org ([2001:4830:134:3::10]:59252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4gc-0002yb-4L
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cg4ga-00087g-F6
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41808)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cg4ga-000874-7S
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 02:16:32 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 687C581241
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 07:16:32 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 21 Feb 2017 08:16:20 +0100
Message-Id: <1487661385-7720-7-git-send-email-kraxel@redhat.com>
In-Reply-To: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
References: <1487661385-7720-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 06/11] xhci: add qemu xhci controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Turn existing TYPE_XHCI into an abstract base class.
Create two child classes, TYPE_NEC_XHCI (same name as old xhci
controller) and TYPE_QEMU_XHCI (using an ID from our namespace).

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Message-id: 1486382139-30630-3-git-send-email-kraxel@redhat.com
---
 docs/specs/pci-ids.txt |  1 +
 hw/usb/hcd-xhci.c      | 40 ++++++++++++++++++++++++++++++++++++----
 include/hw/pci/pci.h   |  1 +
 3 files changed, 38 insertions(+), 4 deletions(-)

diff --git a/docs/specs/pci-ids.txt b/docs/specs/pci-ids.txt
index 16fdb0c..95adee0 100644
--- a/docs/specs/pci-ids.txt
+++ b/docs/specs/pci-ids.txt
@@ -61,6 +61,7 @@ PCI devices (other than virtio):
 1b36:0009  PCI Expander Bridge (-device pxb)
 1b36:000a  PCI-PCI bridge (multiseat)
 1b36:000b  PCIe Expander Bridge (-device pxb-pcie)
+1b36:000d  PCI xhci usb host adapter
 
 All these devices are documented in docs/specs.
 
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index cfb5f74..c534b43 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -489,7 +489,9 @@ struct XHCIState {
     XHCIRing cmd_ring;
 };
 
-#define TYPE_XHCI "nec-usb-xhci"
+#define TYPE_XHCI "base-xhci"
+#define TYPE_NEC_XHCI "nec-usb-xhci"
+#define TYPE_QEMU_XHCI "qemu-xhci"
 
 #define XHCI(obj) \
     OBJECT_CHECK(XHCIState, (obj), TYPE_XHCI)
@@ -3881,10 +3883,7 @@ static void xhci_class_init(ObjectClass *klass, void *data)
     set_bit(DEVICE_CATEGORY_USB, dc->categories);
     k->realize      = usb_xhci_realize;
     k->exit         = usb_xhci_exit;
-    k->vendor_id    = PCI_VENDOR_ID_NEC;
-    k->device_id    = PCI_DEVICE_ID_NEC_UPD720200;
     k->class_id     = PCI_CLASS_SERIAL_USB;
-    k->revision     = 0x03;
     k->is_express   = 1;
 }
 
@@ -3893,11 +3892,44 @@ static const TypeInfo xhci_info = {
     .parent        = TYPE_PCI_DEVICE,
     .instance_size = sizeof(XHCIState),
     .class_init    = xhci_class_init,
+    .abstract      = true,
+};
+
+static void nec_xhci_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->vendor_id    = PCI_VENDOR_ID_NEC;
+    k->device_id    = PCI_DEVICE_ID_NEC_UPD720200;
+    k->revision     = 0x03;
+}
+
+static const TypeInfo nec_xhci_info = {
+    .name          = TYPE_NEC_XHCI,
+    .parent        = TYPE_XHCI,
+    .class_init    = nec_xhci_class_init,
+};
+
+static void qemu_xhci_class_init(ObjectClass *klass, void *data)
+{
+    PCIDeviceClass *k = PCI_DEVICE_CLASS(klass);
+
+    k->vendor_id    = PCI_VENDOR_ID_REDHAT;
+    k->device_id    = PCI_DEVICE_ID_REDHAT_XHCI;
+    k->revision     = 0x01;
+}
+
+static const TypeInfo qemu_xhci_info = {
+    .name          = TYPE_QEMU_XHCI,
+    .parent        = TYPE_XHCI,
+    .class_init    = qemu_xhci_class_init,
 };
 
 static void xhci_register_types(void)
 {
     type_register_static(&xhci_info);
+    type_register_static(&nec_xhci_info);
+    type_register_static(&qemu_xhci_info);
 }
 
 type_init(xhci_register_types)
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index cbc1fdf..05ef14b 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -97,6 +97,7 @@
 #define PCI_DEVICE_ID_REDHAT_BRIDGE_SEAT 0x000a
 #define PCI_DEVICE_ID_REDHAT_PXB_PCIE    0x000b
 #define PCI_DEVICE_ID_REDHAT_PCIE_RP     0x000c
+#define PCI_DEVICE_ID_REDHAT_XHCI        0x000d
 #define PCI_DEVICE_ID_REDHAT_QXL         0x0100
 
 #define FMT_PCIBUS                      PRIx64
-- 
1.8.3.1
