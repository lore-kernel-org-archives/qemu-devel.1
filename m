Received: from eggs.gnu.org ([2001:4830:134:3::10]:43175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNOV-0002Xu-IR
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNOQ-0002vx-Re
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9513)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNOQ-0002vX-Iq
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:26 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7B545C04D938
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 21:59:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:45 -0300
Message-Id: <20170814215748.5158-11-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 10/13] pci: device-number & function properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>

The "addr" property on PCI devices has some magic for parsing it
as a single PCI device number (called "slot" internally), or a
"<slot>.<function>" string.  Add simple integer properties that
can represent the device address with no special parsing.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci/pci.c | 63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index ead9cbf..5753af3 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -41,6 +41,7 @@
 #include "hw/hotplug.h"
 #include "hw/boards.h"
 #include "qemu/cutils.h"
+#include "qapi-visit.h"
 
 //#define DEBUG_PCI
 #ifdef DEBUG_PCI
@@ -2504,6 +2505,55 @@ MemoryRegion *pci_address_space_io(PCIDevice *dev)
     return dev->bus->address_space_io;
 }
 
+static void pci_device_get_devnr(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    uint32_t devnr = PCI_SLOT(dev->devfn);
+
+    visit_type_uint32(v, "device-number", &devnr, errp);
+}
+
+static void pci_device_set_devnr(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    uint32_t devnr;
+    Error *local_err = NULL;
+
+    visit_type_uint32(v, "device-number", &devnr, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+
+    dev->devfn = PCI_DEVFN(devnr, PCI_FUNC(dev->devfn));
+}
+
+static void pci_device_get_function(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    uint32_t function = PCI_FUNC(dev->devfn);
+
+    visit_type_uint32(v, "function", &function, errp);
+}
+
+static void pci_device_set_function(Object *obj, Visitor *v, const char *name,
+                                void *opaque, Error **errp)
+{
+    PCIDevice *dev = PCI_DEVICE(obj);
+    uint32_t function;
+    Error *local_err = NULL;
+
+    visit_type_uint32(v, "function", &function, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        return;
+    }
+    dev->devfn = PCI_DEVFN(PCI_SLOT(dev->devfn), function);
+}
+
 static void pci_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *k = DEVICE_CLASS(klass);
@@ -2514,6 +2564,19 @@ static void pci_device_class_init(ObjectClass *klass, void *data)
     k->bus_type = TYPE_PCI_BUS;
     k->props = pci_props;
     pc->realize = pci_default_realize;
+
+    /* Internally, bits 3:8 of devfn are called "slots", but:
+     * - they can be confused with physical slot numbers;
+     * - TYPE_PCIE_SLOT objects already have a "slot" property.
+     * So we use the terminology used in the PCI specifiction:
+     * "device number".
+     */
+    object_class_property_add(klass, "device-number", "uint32",
+                              pci_device_get_devnr, pci_device_set_devnr,
+                              NULL, NULL, &error_abort);
+    object_class_property_add(klass, "function", "uint32",
+                              pci_device_get_function, pci_device_set_function,
+                              NULL, NULL, &error_abort);
 }
 
 AddressSpace *pci_device_iommu_address_space(PCIDevice *dev)
-- 
2.9.4
