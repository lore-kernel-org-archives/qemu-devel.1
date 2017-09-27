Received: from eggs.gnu.org ([2001:4830:134:3::10]:47717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxISw-00073n-VB
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxISt-0007Xd-UJ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:57:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44972)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dxISt-0007XC-OS
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:57:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 16:56:35 -0300
Message-Id: <20170927195635.16014-6-ehabkost@redhat.com>
In-Reply-To: <20170927195635.16014-1-ehabkost@redhat.com>
References: <20170927195635.16014-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] pci: Validate interfaces on
 base_class_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, Alistair Francis <alistair23@gmail.com>, Laine Stump <laine@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Make sure we don't forget to add the Conventional PCI or PCI
Express interface names on PCI device classes in the future.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* s/legacy/conventional/
  * Suggested-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/pci/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1b08e18205..5ed3c8dca4 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2547,6 +2547,17 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
     pc->realize = pci_default_realize;
 }
 
+static void pci_device_class_base_init(ObjectClass *klass, void *data)
+{
+    if (!object_class_is_abstract(klass)) {
+        ObjectClass *conventional =
+            object_class_dynamic_cast(klass, INTERFACE_CONVENTIONAL_PCI_DEVICE);
+        ObjectClass *pcie =
+            object_class_dynamic_cast(klass, INTERFACE_PCIE_DEVICE);
+        assert(conventional || pcie);
+    }
+}
+
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 {
     PCIBus *bus = PCI_BUS(dev->bus);
@@ -2671,6 +2682,7 @@ static const TypeInfo pci_device_type_info = {
     .abstract = true,
     .class_size = sizeof(PCIDeviceClass),
     .class_init = pci_device_class_init,
+    .class_base_init = pci_device_class_base_init,
 };
 
 static void pci_register_types(void)
-- 
2.13.5
