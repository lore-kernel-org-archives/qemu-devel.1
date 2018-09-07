Received: from eggs.gnu.org ([2001:4830:134:3::10]:60798)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyOf0-00005U-1W
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fyOez-0005qW-5w
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36450 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fyOey-0005q6-Vb
	for qemu-devel@nongnu.org; Fri, 07 Sep 2018 17:51:25 -0400
Date: Fri, 7 Sep 2018 17:51:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180907215109.146867-5-mst@redhat.com>
References: <20180907215109.146867-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180907215109.146867-1-mst@redhat.com>
Subject: [Qemu-devel] [PULL 4/7] hw/pci: add PCI resource reserve capability
 to legacy PCI bridge
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Jing Liu <jing2.liu@linux.intel.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

From: Jing Liu <jing2.liu@linux.intel.com>

Add hint to firmware (e.g. SeaBIOS) to reserve addtional
BUS/IO/MEM/PREF resource for legacy pci-pci bridge. Add the
resource reserve capability deleting in pci_bridge_dev_exitfn.

Signed-off-by: Jing Liu <jing2.liu@linux.intel.com>
Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/pci-bridge/pci_bridge_dev.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_dev.c
index b2d861d216..97a8e8b6a4 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -46,6 +46,9 @@ struct PCIBridgeDev {
     uint32_t flags;
 
     OnOffAuto msi;
+
+    /* additional resources to reserve */
+    PCIResReserve res_reserve;
 };
 typedef struct PCIBridgeDev PCIBridgeDev;
 
@@ -95,6 +98,12 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
         error_free(local_err);
     }
 
+    err = pci_bridge_qemu_reserve_cap_init(dev, 0,
+                                         bridge_dev->res_reserve, errp);
+    if (err) {
+        goto cap_error;
+    }
+
     if (shpc_present(dev)) {
         /* TODO: spec recommends using 64 bit prefetcheable BAR.
          * Check whether that works well. */
@@ -103,6 +112,8 @@ static void pci_bridge_dev_realize(PCIDevice *dev, Error **errp)
     }
     return;
 
+cap_error:
+    msi_uninit(dev);
 msi_error:
     slotid_cap_cleanup(dev);
 slotid_error:
@@ -116,6 +127,8 @@ shpc_error:
 static void pci_bridge_dev_exitfn(PCIDevice *dev)
 {
     PCIBridgeDev *bridge_dev = PCI_BRIDGE_DEV(dev);
+
+    pci_del_capability(dev, PCI_CAP_ID_VNDR, sizeof(PCIBridgeQemuCap));
     if (msi_present(dev)) {
         msi_uninit(dev);
     }
@@ -162,6 +175,17 @@ static Property pci_bridge_dev_properties[] = {
                             ON_OFF_AUTO_AUTO),
     DEFINE_PROP_BIT(PCI_BRIDGE_DEV_PROP_SHPC, PCIBridgeDev, flags,
                     PCI_BRIDGE_DEV_F_SHPC_REQ, true),
+    DEFINE_PROP_UINT32("bus-reserve", PCIBridgeDev,
+                       res_reserve.bus, -1),
+    DEFINE_PROP_SIZE("io-reserve", PCIBridgeDev,
+                     res_reserve.io, -1),
+    DEFINE_PROP_SIZE("mem-reserve", PCIBridgeDev,
+                     res_reserve.mem_non_pref, -1),
+    DEFINE_PROP_SIZE("pref32-reserve", PCIBridgeDev,
+                     res_reserve.mem_pref_32, -1),
+    DEFINE_PROP_SIZE("pref64-reserve", PCIBridgeDev,
+                     res_reserve.mem_pref_64, -1),
+
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
MST
