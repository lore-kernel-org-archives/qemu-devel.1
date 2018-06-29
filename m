Received: from eggs.gnu.org ([2001:4830:134:3::10]:42612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fZ1jo-0001JB-LA
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 18:19:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fZ1jk-0007EJ-LN
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 18:19:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:40466)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fZ1jk-0007DT-DS
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 18:19:28 -0400
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Fri, 29 Jun 2018 17:19:04 -0500
Message-Id: <20180629221907.3662-2-venu.busireddy@oracle.com>
In-Reply-To: <20180629221907.3662-1-venu.busireddy@oracle.com>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH v3 1/3] Add "Group Identifier" support to
 virtio devices.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: venu.busireddy@oracle.com, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

Use the virtio PCI capability "VIRTIO_PCI_CAP_GROUP_ID_CFG" to
store the "Group Identifier" specified via the command line option
"failover-group-id" for the virtio device. The capability will be
present in the virtio device's configuration space iff the
"failover-group-id" option is specified.

Group Identifier is used to pair a virtio device with a passthrough
device.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hw/virtio/virtio-pci.c                      | 15 +++++++++++++++
 hw/virtio/virtio-pci.h                      |  3 ++-
 include/hw/pci/pci.h                        |  1 +
 include/hw/pci/pcie.h                       |  1 +
 include/standard-headers/linux/virtio_pci.h |  8 ++++++++
 5 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3a01fe90f0..cdf907e9c5 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1638,6 +1638,10 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
             .cap.cap_len = sizeof cfg,
             .cap.cfg_type = VIRTIO_PCI_CAP_PCI_CFG,
         };
+        struct virtio_pci_group_id_cap group = {
+            .cap.cap_len = sizeof group,
+            .cap.cfg_type = VIRTIO_PCI_CAP_GROUP_ID_CFG,
+        };
         struct virtio_pci_notify_cap notify_pio = {
             .cap.cap_len = sizeof notify,
             .notify_off_multiplier = cpu_to_le32(0x0),
@@ -1647,6 +1651,11 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
 
         virtio_pci_modern_regions_init(proxy);
 
+        if (proxy->pci_dev.failover_group_id != ULLONG_MAX) {
+            group.failover_group_id = proxy->pci_dev.failover_group_id;
+            virtio_pci_modern_mem_region_map(proxy, &proxy->group, &group.cap);
+        }
+
         virtio_pci_modern_mem_region_map(proxy, &proxy->common, &cap);
         virtio_pci_modern_mem_region_map(proxy, &proxy->isr, &cap);
         virtio_pci_modern_mem_region_map(proxy, &proxy->device, &cap);
@@ -1763,6 +1772,10 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
     proxy->device.size = 0x1000;
     proxy->device.type = VIRTIO_PCI_CAP_DEVICE_CFG;
 
+    proxy->group.offset = 0;
+    proxy->group.size = 0;
+    proxy->group.type = VIRTIO_PCI_CAP_GROUP_ID_CFG;
+
     proxy->notify.offset = 0x3000;
     proxy->notify.size = virtio_pci_queue_mem_mult(proxy) * VIRTIO_QUEUE_MAX;
     proxy->notify.type = VIRTIO_PCI_CAP_NOTIFY_CFG;
@@ -1898,6 +1911,8 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    DEFINE_PROP_UINT64(COMPAT_PROP_FAILOVER_GROUP_ID,
+                       PCIDevice, failover_group_id, ULLONG_MAX),
     DEFINE_PROP_END_OF_LIST(),
 };
 
diff --git a/hw/virtio/virtio-pci.h b/hw/virtio/virtio-pci.h
index 813082b0d7..e4592e90bf 100644
--- a/hw/virtio/virtio-pci.h
+++ b/hw/virtio/virtio-pci.h
@@ -164,10 +164,11 @@ struct VirtIOPCIProxy {
             VirtIOPCIRegion common;
             VirtIOPCIRegion isr;
             VirtIOPCIRegion device;
+            VirtIOPCIRegion group;
             VirtIOPCIRegion notify;
             VirtIOPCIRegion notify_pio;
         };
-        VirtIOPCIRegion regs[5];
+        VirtIOPCIRegion regs[6];
     };
     MemoryRegion modern_bar;
     MemoryRegion io_bar;
diff --git a/include/hw/pci/pci.h b/include/hw/pci/pci.h
index 990d6fcbde..b59c3e7e38 100644
--- a/include/hw/pci/pci.h
+++ b/include/hw/pci/pci.h
@@ -343,6 +343,7 @@ struct PCIDevice {
     bool has_rom;
     MemoryRegion rom;
     uint32_t rom_bar;
+    uint64_t failover_group_id;
 
     /* INTx routing notifier */
     PCIINTxRoutingNotifier intx_routing_notifier;
diff --git a/include/hw/pci/pcie.h b/include/hw/pci/pcie.h
index b71e369703..71cd143ee4 100644
--- a/include/hw/pci/pcie.h
+++ b/include/hw/pci/pcie.h
@@ -82,6 +82,7 @@ struct PCIExpressDevice {
 };
 
 #define COMPAT_PROP_PCP "power_controller_present"
+#define COMPAT_PROP_FAILOVER_GROUP_ID "failover-group-id"
 
 /* PCI express capability helper functions */
 int pcie_cap_init(PCIDevice *dev, uint8_t offset, uint8_t type,
diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
index 9262acd130..e46df63e52 100644
--- a/include/standard-headers/linux/virtio_pci.h
+++ b/include/standard-headers/linux/virtio_pci.h
@@ -113,6 +113,8 @@
 #define VIRTIO_PCI_CAP_DEVICE_CFG	4
 /* PCI configuration access */
 #define VIRTIO_PCI_CAP_PCI_CFG		5
+/* Group Identifier */
+#define VIRTIO_PCI_CAP_GROUP_ID_CFG	6
 
 /* This is the PCI capability header: */
 struct virtio_pci_cap {
@@ -163,6 +165,12 @@ struct virtio_pci_cfg_cap {
 	uint8_t pci_cfg_data[4]; /* Data for BAR access. */
 };
 
+/* Fields in VIRTIO_PCI_CAP_GROUP_ID_CFG: */
+struct virtio_pci_group_id_cap {
+	struct virtio_pci_cap cap;
+	uint64_t failover_group_id;
+};
+
 /* Macro versions of offsets for the Old Timers! */
 #define VIRTIO_PCI_CAP_VNDR		0
 #define VIRTIO_PCI_CAP_NEXT		1
