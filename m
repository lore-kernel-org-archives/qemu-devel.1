Received: from eggs.gnu.org ([2001:4830:134:3::10]:44848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPlD-0006rZ-6c
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:52:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPl8-000204-GN
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:52:43 -0400
Received: from mga07.intel.com ([134.134.136.100]:15530)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPl8-0001zQ-7v
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:52:38 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301617-24179-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [RFC 1/5] vfio: introduce a new VFIO region for
 migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Mon, 26 Jun 2017 08:52:44 -0000
To: qemu-devel@nongnu.org
Cc: zhenyuw@linux.intel.com, zhi.a.wang@intel.com, joonas.lahtinen@linux.intel.com, kevin.tian@intel.com, xiao.zheng@intel.com, Yulei Zhang <yulei.zhang@intel.com>

New VFIO region VFIO_PCI_DEVICE_STATE_REGION_INDEX is added to fetch
and restore the pci device status during the live migration.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 hw/vfio/pci.c              | 17 +++++++++++++++++
 hw/vfio/pci.h              |  1 +
 linux-headers/linux/vfio.h |  5 ++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 03a3d01..bf2e0ff 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2360,6 +2360,23 @@ static void vfio_populate_device(VFIOPCIDevice *vdev, Error **errp)
         QLIST_INIT(&vdev->bars[i].quirks);
     }
 
+    /* device state region setup */
+    if (vbasedev->flags & VFIO_DEVICE_FLAGS_MIGRATABLE) {
+        char *name = g_strdup_printf("%s BAR %d", vbasedev->name, VFIO_PCI_DEVICE_STATE_REGION_INDEX);
+
+        ret = vfio_region_setup(OBJECT(vdev), vbasedev,
+                                &vdev->device_state.region, VFIO_PCI_DEVICE_STATE_REGION_INDEX, name);
+        g_free(name);
+
+        if (ret) {
+            error_setg_errno(errp, -ret, "failed to get region %d info",
+                             VFIO_PCI_DEVICE_STATE_REGION_INDEX);
+            return;
+        }
+
+        QLIST_INIT(&vdev->device_state.quirks);
+    }
+
     ret = vfio_get_region_info(vbasedev,
                                VFIO_PCI_CONFIG_REGION_INDEX, &reg_info);
     if (ret) {
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a8366bb..bd98618 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -115,6 +115,7 @@ typedef struct VFIOPCIDevice {
     int interrupt; /* Current interrupt type */
     VFIOBAR bars[PCI_NUM_REGIONS - 1]; /* No ROM */
     VFIOVGA *vga; /* 0xa0000, 0x3b0, 0x3c0 */
+    VFIOBAR device_state;
     void *igd_opregion;
     PCIHostDeviceAddress host;
     EventNotifier err_notifier;
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 531cb2e..c87d05c 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -198,6 +198,8 @@ struct vfio_device_info {
 #define VFIO_DEVICE_FLAGS_PCI	(1 << 1)	/* vfio-pci device */
 #define VFIO_DEVICE_FLAGS_PLATFORM (1 << 2)	/* vfio-platform device */
 #define VFIO_DEVICE_FLAGS_AMBA  (1 << 3)	/* vfio-amba device */
+#define VFIO_DEVICE_FLAGS_CCW   (1 << 4)        /* vfio-ccw device */
+#define VFIO_DEVICE_FLAGS_MIGRATABLE (1 << 5)	/* Device supports migrate */
 	__u32	num_regions;	/* Max region index + 1 */
 	__u32	num_irqs;	/* Max IRQ index + 1 */
 };
@@ -433,7 +435,8 @@ enum {
 	 * between described ranges are unimplemented.
 	 */
 	VFIO_PCI_VGA_REGION_INDEX,
-	VFIO_PCI_NUM_REGIONS = 9 /* Fixed user ABI, region indexes >=9 use */
+	VFIO_PCI_DEVICE_STATE_REGION_INDEX,
+	VFIO_PCI_NUM_REGIONS = 10 /* Fixed user ABI, region indexes >=9 use */
 				 /* device specific cap to define content. */
 };
 
-- 
2.7.4
