Received: from eggs.gnu.org ([2001:4830:134:3::10]:43130)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNOJ-0002Mi-QJ
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dhNOH-0002rc-Mk
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dhNOH-0002r6-G8
	for qemu-devel@nongnu.org; Mon, 14 Aug 2017 17:59:17 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 62B1025C2A
	for <qemu-devel@nongnu.org>; Mon, 14 Aug 2017 21:59:16 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon, 14 Aug 2017 18:57:44 -0300
Message-Id: <20170814215748.5158-10-ehabkost@redhat.com>
In-Reply-To: <20170814215748.5158-1-ehabkost@redhat.com>
References: <20170814215748.5158-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC v4 09/13] pci: pci_bus_has_pcie_upstream_port()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Laine Stump <laine@redhat.com>

The new helper will be useful when enumerating free slots on PCI
buses.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/pci/pci.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 31b4d69..ead9cbf 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -2591,9 +2591,9 @@ void pci_bus_get_w64_range(PCIBus *bus, Range *range)
     pci_for_each_device_under_bus(bus, pci_dev_get_w64, range);
 }
 
-static bool pcie_has_upstream_port(PCIDevice *dev)
+static bool pci_bus_has_pcie_upstream_port(PCIBus *bus)
 {
-    PCIDevice *parent_dev = pci_bridge_get_device(dev->bus);
+    PCIDevice *parent_dev = pci_bridge_get_device(bus);
 
     /* Device associated with an upstream port.
      * As there are several types of these, it's easier to check the
@@ -2609,7 +2609,7 @@ static bool pcie_has_upstream_port(PCIDevice *dev)
 
 PCIDevice *pci_get_function_0(PCIDevice *pci_dev)
 {
-    if(pcie_has_upstream_port(pci_dev)) {
+    if(pci_bus_has_pcie_upstream_port(pci_dev->bus)) {
         /* With an upstream PCIe port, we only support 1 device at slot 0 */
         return pci_dev->bus->devices[0];
     } else {
-- 
2.9.4
