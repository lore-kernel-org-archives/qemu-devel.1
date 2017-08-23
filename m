Received: from eggs.gnu.org ([2001:4830:134:3::10]:59588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkdvx-0005rz-9g
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 18:15:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkdvs-0002MH-Cj
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 18:15:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkdvs-0002Jf-66
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 18:15:28 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 325858763A
	for <qemu-devel@nongnu.org>; Wed, 23 Aug 2017 22:15:27 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 23 Aug 2017 19:14:45 -0300
Message-Id: <20170823221445.15243-6-ehabkost@redhat.com>
In-Reply-To: <20170823221445.15243-1-ehabkost@redhat.com>
References: <20170823221445.15243-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 5/5] pci: Validate interfaces on base_class_init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Laine Stump <laine@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

Make sure we don't forget to add the legacy-PCI or PCIe interface
names on PCI device classes in the future.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index baa3429..7ac5cc6 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2525,6 +2525,17 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
     pc->realize = pci_default_realize;
 }
 
+static void pci_device_class_base_init(ObjectClass *klass, void *data)
+{
+    if (!object_class_is_abstract(klass)) {
+        ObjectClass *legacy =
+            object_class_dynamic_cast(klass, INTERFACE_LEGACY_PCI_DEVICE);
+        ObjectClass *pcie =
+            object_class_dynamic_cast(klass, INTERFACE_PCIE_DEVICE);
+        assert(legacy || pcie);
+    }
+}
+
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
 {
     PCIBus *bus = PCI_BUS(dev->bus);
@@ -2649,6 +2660,7 @@ static const TypeInfo pci_device_type_info = {
     .abstract = true,
     .class_size = sizeof(PCIDeviceClass),
     .class_init = pci_device_class_init,
+    .class_base_init = pci_device_class_base_init,
 };
 
 static void pci_register_types(void)
-- 
2.9.4
