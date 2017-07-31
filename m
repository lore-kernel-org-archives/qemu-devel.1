Received: from eggs.gnu.org ([2001:4830:134:3::10]:48620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dc49Z-0005tq-Rh
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dc49W-0007QG-NH
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:26:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:5627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dc49W-0007NV-F1
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:26:06 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1494316727-15518-2-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1494316727-15518-1-git-send-email-yulei.zhang@intel.com>
References: <1494316727-15518-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [RFC V2 1/4] vfio: introduce a new VFIO sub region for
 mdev device migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Mon, 31 Jul 2017 06:26:11 -0000
To: qemu-devel@nongnu.org
Cc: kevin.tian@intel.com, joonas.lahtinen@linux.intel.com, zhenyuw@linux.intel.com, xiao.zheng@intel.com, zhi.a.wang@intel.com, alex.williamson@redhat.com, Yulei Zhang <yulei.zhang@intel.com>

New VFIO sub region VFIO_REGION_SUBTYPE_INTEL_IGD_DEVICE_STATE is added
to fetch and restore the status of mdev device vGPU during the live migration.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 hw/vfio/pci.c              | 13 ++++++++++++-
 hw/vfio/pci.h              |  1 +
 linux-headers/linux/vfio.h |  7 ++++---
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 03a3d01..21a5cef 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -37,6 +37,7 @@
 
 static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
+static VMStateDescription vfio_pci_vmstate;
 
 /*
  * Disabling BAR mmaping can be slow, but toggling it around INTx can
@@ -2792,6 +2793,16 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
         vfio_vga_quirk_setup(vdev);
     }
 
+    struct vfio_region_info *device_state;
+    /* device state region setup */
+    if (!vfio_get_dev_region_info(&vdev->vbasedev,
+                VFIO_REGION_TYPE_PCI_VENDOR_TYPE | PCI_VENDOR_ID_INTEL,
+                VFIO_REGION_SUBTYPE_INTEL_IGD_DEVICE_STATE, &device_state)) {
+	memcpy(&vdev->device_state, device_state, sizeof(struct vfio_region_info));
+	g_free(device_state);
+        vfio_pci_vmstate.unmigratable = 0;
+    }
+
     for (i = 0; i < PCI_ROM_SLOT; i++) {
         vfio_bar_quirk_setup(vdev, i);
     }
@@ -2973,7 +2984,7 @@ static Property vfio_pci_dev_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
-static const VMStateDescription vfio_pci_vmstate = {
+static VMStateDescription vfio_pci_vmstate = {
     .name = "vfio-pci",
     .unmigratable = 1,
 };
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index a8366bb..6a1d26e 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -116,6 +116,7 @@ typedef struct VFIOPCIDevice {
     VFIOBAR bars[PCI_NUM_REGIONS - 1]; /* No ROM */
     VFIOVGA *vga; /* 0xa0000, 0x3b0, 0x3c0 */
     void *igd_opregion;
+    struct vfio_region_info device_state;
     PCIHostDeviceAddress host;
     EventNotifier err_notifier;
     EventNotifier req_notifier;
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 531cb2e..e2c53bf 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -294,9 +294,10 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_TYPE_PCI_VENDOR_MASK	(0xffff)
 
 /* 8086 Vendor sub-types */
-#define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION	(1)
-#define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
-#define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
+#define VFIO_REGION_SUBTYPE_INTEL_IGD_OPREGION		(1)
+#define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG		(2)
+#define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG		(3)
+#define VFIO_REGION_SUBTYPE_INTEL_IGD_DEVICE_STATE	(4)
 
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
-- 
2.7.4
