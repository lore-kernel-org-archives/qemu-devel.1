Received: from eggs.gnu.org ([2001:4830:134:3::10]:47872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdhXE-0008H7-H3
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fdhXD-0001a3-Ha
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fdhXD-0001ZH-BE
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 15:45:51 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 12 Jul 2018 16:45:22 -0300
Message-Id: <20180712194522.31063-4-ehabkost@redhat.com>
In-Reply-To: <20180712194522.31063-1-ehabkost@redhat.com>
References: <20180712194522.31063-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 3/3] pci: Document ownership rules of
 pci_root_bus_new*()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>

The ownership rules of pci_root_bus_new*() aren't trivial: the
caller owns the new object if parent is NULL, otherwise ownership
is transferred to the parent.  Clarify that on comments.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/pci/pci.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 990d6fcbde..5d445c431c 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -396,15 +396,30 @@ typedef PCIINTxRoute (*pci_route_irq_fn)(void *opaque, int pin);
 
 bool pci_bus_is_express(PCIBus *bus);
 bool pci_bus_is_root(PCIBus *bus);
+
+/**
+ * pci_root_bus_new_inplace:
+ *
+* If @parent is not NULL the returned object will be owned by @parent,
+* otherwise it will be owned by the caller.
+*/
 void pci_root_bus_new_inplace(PCIBus *bus, size_t bus_size, DeviceState *parent,
                               const char *name,
                               MemoryRegion *address_space_mem,
                               MemoryRegion *address_space_io,
                               uint8_t devfn_min, const char *typename);
+
+/**
+ * pci_root_bus_new:
+ *
+* If @parent is not NULL the returned object will be owned by @parent,
+* otherwise it will be owned by the caller.
+*/
 PCIBus *pci_root_bus_new(DeviceState *parent, const char *name,
                          MemoryRegion *address_space_mem,
                          MemoryRegion *address_space_io,
                          uint8_t devfn_min, const char *typename);
+
 void pci_bus_irqs(PCIBus *bus, pci_set_irq_fn set_irq, pci_map_irq_fn map_irq,
                   void *irq_opaque, int nirq);
 int pci_bus_get_irq_level(PCIBus *bus, int irq_num);
-- 
2.18.0.rc1.1.g3f1ff2140
