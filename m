Received: from eggs.gnu.org ([2001:4830:134:3::10]:48619)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dc49Z-0005tp-Rc
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:26:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dc49X-0007Qg-65
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:26:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:5627)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dc49W-0007NV-Tt
	for qemu-devel@nongnu.org; Mon, 31 Jul 2017 02:26:07 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1494316727-15518-3-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1494316727-15518-1-git-send-email-yulei.zhang@intel.com>
References: <1494316727-15518-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [RFC V2 2/4] vfio: Add vm status change callback to
 stop/restart the mdev device
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

VM status change handler is added to change the vfio pci device
status during the migration, write the demanded device status
to the DEVICE STATUS subregion to stop the device on the source side
before fetch its status and start the deivce on the target side
after restore its status.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 hw/vfio/pci.c                 | 19 +++++++++++++++++++
 include/hw/vfio/vfio-common.h |  1 +
 linux-headers/linux/vfio.h    |  3 +++
 3 files changed, 23 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 21a5cef..753da80 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -38,6 +38,7 @@
 static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static VMStateDescription vfio_pci_vmstate;
+static void vfio_vm_change_state_handler(void *pv, int running, RunState state);
 
 /*
  * Disabling BAR mmaping can be slow, but toggling it around INTx can
@@ -2858,6 +2859,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_register_err_notifier(vdev);
     vfio_register_req_notifier(vdev);
     vfio_setup_resetfn_quirk(vdev);
+    qemu_add_vm_change_state_handler(vfio_vm_change_state_handler, vdev);
 
     return;
 
@@ -2940,6 +2942,23 @@ post_reset:
     vfio_pci_post_reset(vdev);
 }
 
+static void vfio_vm_change_state_handler(void *pv, int running, RunState state)
+{
+    VFIOPCIDevice *vdev = pv;
+    VFIODevice *vbasedev = &vdev->vbasedev;
+    uint8_t dev_state;
+    uint8_t sz = 1;
+
+    dev_state = running ? VFIO_DEVICE_START : VFIO_DEVICE_STOP;
+
+    if (pwrite(vdev->vbasedev.fd, &dev_state, sz, vdev->device_state.offset) != sz) {
+        error_report("vfio: Failed to %s device\n", running ? "start" : "stop");
+        return;
+    }
+
+    vbasedev->device_state = dev_state;
+}
+
 static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
index c582de1..c4bab97 100644
--- a/include/hw/vfio/vfio-common.h
+++ b/include/hw/vfio/vfio-common.h
@@ -123,6 +123,7 @@ typedef struct VFIODevice {
     unsigned int num_irqs;
     unsigned int num_regions;
     unsigned int flags;
+    bool device_state;
 } VFIODevice;
 
 struct VFIODeviceOps {
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index e2c53bf..ae1b953 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -299,6 +299,9 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG		(3)
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_DEVICE_STATE	(4)
 
+#define VFIO_DEVICE_START	0
+#define VFIO_DEVICE_STOP	1
+
 /**
  * VFIO_DEVICE_GET_IRQ_INFO - _IOWR(VFIO_TYPE, VFIO_BASE + 9,
  *				    struct vfio_irq_info)
-- 
2.7.4
