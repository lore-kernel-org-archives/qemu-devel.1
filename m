Received: from eggs.gnu.org ([2001:4830:134:3::10]:59123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3D8-000404-O8
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:38:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ga3D6-0007O4-CH
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:38:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48298)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ga3D6-0007MM-4T
	for qemu-devel@nongnu.org; Thu, 20 Dec 2018 13:38:16 -0500
Date: Thu, 20 Dec 2018 13:38:13 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181220183059.20726-10-mst@redhat.com>
References: <20181220183059.20726-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181220183059.20726-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL v3 09/44] hw/pci-bridge: Fix invalid free()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Matthias Weckbecker <matthias@weckbecker.name>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Matthias Weckbecker <matthias@weckbecker.name>

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
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
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
MST
