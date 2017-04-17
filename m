Received: from eggs.gnu.org ([2001:4830:134:3::10]:54175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0EgE-0000KQ-6h
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1d0EgD-0005lX-B6
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1d0EgD-0005lQ-4d
	for qemu-devel@nongnu.org; Mon, 17 Apr 2017 17:59:29 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 17 Apr 2017 18:59:10 -0300
Message-Id: <20170417215916.12431-2-ehabkost@redhat.com>
In-Reply-To: <20170417215916.12431-1-ehabkost@redhat.com>
References: <20170417215916.12431-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 1/7] pci: Change pci_host_bus_register()
 parameter to PCIHostState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aik@ozlabs.ru, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

The function requires a PCI_HOST_BRIDGE object, so change the parameter
type to reflect that.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci/pci.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 259483b1c0..25118fb91d 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -312,11 +312,9 @@ static void pcibus_reset(BusState *qbus)
     }
 }
 
-static void pci_host_bus_register(DeviceState *host)
+static void pci_host_bus_register(PCIHostState *phb)
 {
-    PCIHostState *host_bridge = PCI_HOST_BRIDGE(host);
-
-    QLIST_INSERT_HEAD(&pci_host_bridges, host_bridge, next);
+    QLIST_INSERT_HEAD(&pci_host_bridges, phb, next);
 }
 
 PCIBus *pci_find_primary_bus(void)
@@ -377,7 +375,7 @@ static void pci_bus_init(PCIBus *bus, DeviceState *parent,
     /* host bridge */
     QLIST_INIT(&bus->child);
 
-    pci_host_bus_register(parent);
+    pci_host_bus_register(PCI_HOST_BRIDGE(host));
 }
 
 bool pci_bus_is_express(PCIBus *bus)
-- 
2.11.0.259.g40922b1
