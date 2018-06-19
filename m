Received: from eggs.gnu.org ([2001:4830:134:3::10]:55586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fVJZ7-0004Um-QO
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:33:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <venu.busireddy@oracle.com>) id 1fVJZ2-0002gr-Tj
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:33:09 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <venu.busireddy@oracle.com>)
	id 1fVJZ2-0002gH-JT
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 12:33:04 -0400
From: Venu Busireddy <venu.busireddy@oracle.com>
Date: Tue, 19 Jun 2018 11:32:27 -0500
Message-Id: <20180619163228.13790-4-venu.busireddy@oracle.com>
In-Reply-To: <20180619163228.13790-1-venu.busireddy@oracle.com>
References: <20180619163228.13790-1-venu.busireddy@oracle.com>
Subject: [Qemu-devel] [PATCH 3/3] Add "Group Identifier" support to virtio
 devices.
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

Use the virtio PCI capability "VIRTIO_PCI_CAP_GROUP_ID_CFG" to store the
"Group Identifier" (UUID) specified via the command line option "uuid"
for the virtio device. The capability will be present in the virtio
device's configuration space iff the "uuid" option is specified.

Group Identifier is used to pair a virtio device with a passthrough
device.

Signed-off-by: Venu Busireddy <venu.busireddy@oracle.com>
---
 hw/virtio/virtio-pci.c                      | 15 +++++++++++++++
 hw/virtio/virtio-pci.h                      |  3 ++-
 include/standard-headers/linux/virtio_pci.h |  8 ++++++++
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 3a01fe90f0..9c2ef16773 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -36,6 +36,7 @@
 #include "qemu/range.h"
 #include "hw/virtio/virtio-bus.h"
 #include "qapi/visitor.h"
+#include "qemu/uuid.h"
 
 #define VIRTIO_PCI_REGION_SIZE(dev)     VIRTIO_PCI_CONFIG_OFF(msix_present(dev))
 
@@ -1638,6 +1639,10 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
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
@@ -1647,6 +1652,11 @@ static void virtio_pci_device_plugged(DeviceState *d, Error **errp)
 
         virtio_pci_modern_regions_init(proxy);
 
+        if (!qemu_uuid_is_null(&proxy->pci_dev.uuid)) {
+            memcpy(group.group_id, &proxy->pci_dev.uuid, sizeof(QemuUUID));
+            virtio_pci_modern_mem_region_map(proxy, &proxy->group, &group.cap);
+        }
+
         virtio_pci_modern_mem_region_map(proxy, &proxy->common, &cap);
         virtio_pci_modern_mem_region_map(proxy, &proxy->isr, &cap);
         virtio_pci_modern_mem_region_map(proxy, &proxy->device, &cap);
@@ -1763,6 +1773,10 @@ static void virtio_pci_realize(PCIDevice *pci_dev, Error **errp)
     proxy->device.size = 0x1000;
     proxy->device.type = VIRTIO_PCI_CAP_DEVICE_CFG;
 
+    proxy->group.offset = 0;
+    proxy->group.size = 0;
+    proxy->group.type = VIRTIO_PCI_CAP_GROUP_ID_CFG;
+
     proxy->notify.offset = 0x3000;
     proxy->notify.size = virtio_pci_queue_mem_mult(proxy) * VIRTIO_QUEUE_MAX;
     proxy->notify.type = VIRTIO_PCI_CAP_NOTIFY_CFG;
@@ -1898,6 +1912,7 @@ static Property virtio_pci_properties[] = {
                     VIRTIO_PCI_FLAG_INIT_LNKCTL_BIT, true),
     DEFINE_PROP_BIT("x-pcie-pm-init", VirtIOPCIProxy, flags,
                     VIRTIO_PCI_FLAG_INIT_PM_BIT, true),
+    DEFINE_PROP_UUID("uuid", PCIDevice, uuid, false),
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
diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
index 9262acd130..e5b6c6f3a6 100644
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
+	uint8_t group_id[16];
+};
+
 /* Macro versions of offsets for the Old Timers! */
 #define VIRTIO_PCI_CAP_VNDR		0
 #define VIRTIO_PCI_CAP_NEXT		1
