Received: from eggs.gnu.org ([209.51.188.92]:39386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1ggdPm-0005IG-Q7
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:30:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1ggdPl-00050C-DW
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:30:34 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:36644)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1ggdPl-0004YH-1R
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 17:30:33 -0500
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Mon,  7 Jan 2019 17:29:44 -0500
Message-Id: <1546900184-27403-6-git-send-email-venu.busireddy@oracle.com>
In-Reply-To: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
References: <1546900184-27403-1-git-send-email-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH v3 5/5] pci: query command extension to check
 the bus master enabling status of the failover-primary device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: venu.busireddy@oracle.com, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

From: Si-Wei Liu <si-wei.liu@oracle.com>

Signed-off-by: Si-Wei Liu <si-wei.liu@oracle.com>
Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hmp.c          | 5 +++++
 hw/pci/pci.c   | 5 +++++
 qapi/misc.json | 5 ++++-
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/hmp.c b/hmp.c
index 7828f93..7a75c93 100644
--- a/hmp.c
+++ b/hmp.c
@@ -890,6 +890,11 @@ static void hmp_info_pci_device(Monitor *mon, const PciDeviceInfo *dev)
         }
     }
 
+    if (dev->has_failover_status) {
+        monitor_printf(mon, "      Failover primary, bus master %s.\n",
+                       dev->failover_status ? "enabled" : "disabled");
+    }
+
     monitor_printf(mon, "      id \"%s\"\n", dev->qdev_id);
 
     if (dev->has_pci_bridge) {
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 56b13b3..9da49fd 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1761,6 +1761,11 @@ static PciDeviceInfo *qmp_query_pci_device(PCIDevice *dev, PCIBus *bus,
             pci_get_word(dev->config + PCI_CB_SUBSYSTEM_VENDOR_ID);
     }
 
+    if (dev->failover_primary) {
+        info->has_failover_status = true;
+        info->failover_status = dev->bus_master_enable_region.enabled;
+    }
+
     return info;
 }
 
diff --git a/qapi/misc.json b/qapi/misc.json
index 6c1c5c0..05f003e 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -865,6 +865,9 @@
 #
 # @regions: a list of the PCI I/O regions associated with the device
 #
+# @failover_status: if 'failover-primary' property is 'true', true if PCI
+#                   bus master bit on the device is enabled
+#
 # Notes: the contents of @class_info.desc are not stable and should only be
 #        treated as informational.
 #
@@ -874,7 +877,7 @@
   'data': {'bus': 'int', 'slot': 'int', 'function': 'int',
            'class_info': 'PciDeviceClass', 'id': 'PciDeviceId',
            '*irq': 'int', 'qdev_id': 'str', '*pci_bridge': 'PciBridgeInfo',
-           'regions': ['PciMemoryRegion']} }
+           'regions': ['PciMemoryRegion'], '*failover_status': 'bool'} }
 
 ##
 # @PciInfo:
