Received: from eggs.gnu.org ([2001:4830:134:3::10]:50241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <matthias@weckbecker.name>) id 1gX3MJ-0004ed-Oo
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:11:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <matthias@weckbecker.name>) id 1gX3MD-0002c8-Ma
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:11:23 -0500
Received: from weckbecker.name ([87.118.122.104]:64101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <matthias@weckbecker.name>)
	id 1gX3MA-0002Xt-Fi
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 07:11:15 -0500
From: Matthias Weckbecker <matthias@weckbecker.name>
Date: Wed, 12 Dec 2018 13:10:18 +0100
Message-Id: <20181212121018.7716-1-matthias@weckbecker.name>
Subject: [Qemu-devel] [PATCH v2] hw/pci-bridge: Fix invalid free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Matthias Weckbecker <matthias@weckbecker.name>

When loadvm'ing a *running* snapshot qemu crashes due to an invalid
free. It's fortunately caught early by glibc heap memory corruption
protection and qemu gets killed with SIGABRT.

Steps to reproduce:

1) Create VM (e.g w/ virsh define)
2) Start the VM and take a snapshot while it's running and having a
   PCI bridge attached
3) Destroy the VM and revert the running snapshot.

This commit fixes the issue.

Signed-off-by: Matthias Weckbecker <matthias@weckbecker.name>
---
 hw/pci/pci_bridge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index ee9dff2d3a..b9143ac88b 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -241,9 +241,9 @@ void pci_bridge_update_mappings(PCIBridge *br)
      * while another accesses an unaffected region. */
     memory_region_transaction_begin();
     pci_bridge_region_del(br, br->windows);
+    pci_bridge_region_cleanup(br, w);
     br->windows = pci_bridge_region_init(br);
     memory_region_transaction_commit();
-    pci_bridge_region_cleanup(br, w);
 }
 
 /* default write_config function for PCI-to-PCI bridge */
-- 
2.16.3
