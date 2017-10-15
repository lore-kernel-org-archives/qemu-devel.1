Received: from eggs.gnu.org ([2001:4830:134:3::10]:49300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZX0-000321-2L
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1e3ZWw-00078n-Vc
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:24:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50740)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1e3ZWw-00077L-Om
	for qemu-devel@nongnu.org; Sat, 14 Oct 2017 23:23:58 -0400
Date: Sun, 15 Oct 2017 06:23:54 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1508036858-13479-21-git-send-email-mst@redhat.com>
References: <1508036858-13479-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1508036858-13479-1-git-send-email-mst@redhat.com>
Subject: [Qemu-devel] [PULL 20/26] pci: Validate interfaces on
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Marcel Apfelbaum <marcel@redhat.com>

From: Eduardo Habkost <ehabkost@redhat.com>

Make sure we don't forget to add the Conventional PCI or PCI
Express interface names on PCI device classes in the future.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Revieed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 1b08e18..5ed3c8d 100644
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
MST
