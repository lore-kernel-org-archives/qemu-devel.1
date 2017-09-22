Received: from eggs.gnu.org ([2001:4830:134:3::10]:51580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dvMv2-00089G-J3
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:18:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1dvMuz-0005XK-Cc
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:18:56 -0400
Received: from chuckie.co.uk ([82.165.15.123]:39373
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1dvMuz-0005W2-5h
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:18:53 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Fri, 22 Sep 2017 13:18:31 +0100
Message-Id: <1506082711-16004-1-git-send-email-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PATCH] pci: allow 32-bit PCI IO accesses to pass
 through the PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, mst@redhat.com, marcel@redhat.com

Whilst the underlying PCI bridge implementation supports 32-bit PCI IO
accesses, unfortunately they are truncated at the legacy 64K limit.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/pci/pci_bridge.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 17feae5..a47d257 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -379,7 +379,8 @@ void pci_bridge_initfn(PCIDevice *dev, const char *typename)
     sec_bus->address_space_mem = &br->address_space_mem;
     memory_region_init(&br->address_space_mem, OBJECT(br), "pci_bridge_pci", UINT64_MAX);
     sec_bus->address_space_io = &br->address_space_io;
-    memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io", 65536);
+    memory_region_init(&br->address_space_io, OBJECT(br), "pci_bridge_io",
+                       UINT32_MAX);
     br->windows = pci_bridge_region_init(br);
     QLIST_INIT(&sec_bus->child);
     QLIST_INSERT_HEAD(&parent->child, sec_bus, sibling);
-- 
1.7.10.4
