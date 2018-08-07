Received: from eggs.gnu.org ([2001:4830:134:3::10]:49032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fmvz8-0002HV-D0
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:00:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1fmvz5-0000EI-64
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:00:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:27906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1fmvz4-0000Di-S4
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 03:00:47 -0400
From: Jing Liu <jing2.liu@linux.intel.com>
Date: Tue,  7 Aug 2018 15:04:09 +0800
Message-Id: <1533625449-14989-1-git-send-email-jing2.liu@linux.intel.com>
Subject: [Qemu-devel] [PATCH] hw/pci: add pci capability to pci-pci bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jing2.liu@linux.intel.com, anthony.xu@intel.com, mst@redhat.com, marcel.apfelbaum@gmail.com, lersek@redhat.com, pbonzini@redhat.com

Add hint to firmware (e.g. SeaBIOS) to reserve addtional
IO/MEM/PREF spaces for legacy pci-pci bridge, to enable
some pci devices hotplugging whose IO/MEM/PREF spaces
requests are larger than the ones in pci-pci bridge set
by firmware.

Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
---
 hw/pci-bridge/pci_bridge_dev.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index b2d861d..8e9afbd 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -46,6 +46,12 @@ struct PCIBridgeDev {
     uint32_t flags;
 
     OnOffAuto msi;
+
+    /* additional resources to reserve on firmware init */
+    uint64_t io_reserve;
+    uint64_t mem_reserve;
+    uint64_t pref32_reserve;
+    uint64_t pref64_reserve;
 };
 typedef struct PCIBridgeDev PCIBridgeDev;
 
@@ -95,6 +101,13 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
         error_free(local_err);
     }
 
+    err = pci_bridge_qemu_reserve_cap_init(dev, 0, 0,
+          bridge_dev->io_reserve, bridge_dev->mem_reserve,
+          bridge_dev->pref32_reserve, bridge_dev->pref64_reserve, errp);
+    if (err) {
+        goto cap_error;
+    }
+
     if (shpc_present(dev)) {
         /* TODO: spec recommends using 64 bit prefetcheable BAR.
          * Check whether that works well. */
@@ -103,6 +116,8 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
     }
     return;
 
+cap_error:
+    msi_uninit(dev);
 msi_error:
     slotid_cap_cleanup(dev);
 slotid_error:
@@ -162,6 +177,11 @@ static Property pci_bridge_dev_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
                     PCI_BRIDGE_DEV_F_SHPC_REQ, true),
+    DEFINE_PROP_SIZE("io-reserve", PCIBridgeDev, io_reserve, -1),
+    DEFINE_PROP_SIZE("mem-reserve", PCIBridgeDev, mem_reserve, -1),
+    DEFINE_PROP_SIZE("pref32-reserve", PCIBridgeDev, pref32_reserve, -1),
+    DEFINE_PROP_SIZE("pref64-reserve", PCIBridgeDev, pref64_reserve, -1),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
1.8.3.1
