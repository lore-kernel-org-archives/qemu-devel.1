Received: from eggs.gnu.org ([2001:4830:134:3::10]:33516)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fqEX2-0004ek-HG
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:25:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fqEWz-0007GT-BC
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:25:28 -0400
Received: from mga07.intel.com ([134.134.136.100]:21421)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1fqEWr-0007B3-VI
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 05:25:19 -0400
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Thu, 16 Aug 2018 17:28:15 +0800
Message-Id: <1534411696-6454-3-git-send-email-jing2.liu@linux.intel.com>
In-Reply-To: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
References: <1534411696-6454-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH v2 2/3] hw/pci: add teardown function for PCI
 resource reserve capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: anthony.xu@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com, lersek@redhat.com, pbonzini@redhat.com, Jing Liu <jing2.liu@linux.intel.com>

Clean up the PCI config space of resource reserve capability.

Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 hw/pci/pci_bridge.c         | 9 +++++++++
 include/hw/pci/pci_bridge.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/hw/pci/pci_bridge.c b/hw/pci/pci_bridge.c
index 15b055e..dbcee90 100644
--- a/hw/pci/pci_bridge.c
+++ b/hw/pci/pci_bridge.c
@@ -465,6 +465,15 @@ int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
     return 0;
 }
 
+void pci_bridge_qemu_reserve_cap_uninit(PCIDevice *dev)
+{
+    uint8_t pos = pci_find_capability(dev, PCI_CAP_ID_VNDR);
+
+    pci_del_capability(dev, PCI_CAP_ID_VNDR, sizeof(PCIBridgeQemuCap));
+    memset(dev->config + pos + PCI_CAP_FLAGS, 0,
+           sizeof(PCIBridgeQemuCap) - PCI_CAP_FLAGS);
+}
+
 static const TypeInfo pci_bridge_type_info = {
     .name = TYPE_PCI_BRIDGE,
     .parent = TYPE_PCI_DEVICE,
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 6186a32..b1e25ad 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -147,4 +147,5 @@ typedef struct PCIResReserve {
 int pci_bridge_qemu_reserve_cap_init(PCIDevice *dev, int cap_offset,
                                PCIResReserve res_reserve, Error **errp);
 
+void pci_bridge_qemu_reserve_cap_uninit(PCIDevice *dev);
 #endif /* QEMU_PCI_BRIDGE_H */
-- 
1.8.3.1
