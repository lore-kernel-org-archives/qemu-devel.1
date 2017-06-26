Received: from eggs.gnu.org ([2001:4830:134:3::10]:45227)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPmG-0007Zw-2J
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:53:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPmB-0002l6-CE
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:53:48 -0400
Received: from mga14.intel.com ([192.55.52.115]:5921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPmB-0002kc-2N
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:53:43 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301684-24367-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [RFC 5/5] vifo: introduce new VFIO ioctl
 VFIO_DEVICE_PCI_GET_DIRTY_BITMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Mon, 26 Jun 2017 08:53:49 -0000
To: qemu-devel@nongnu.org
Cc: zhenyuw@linux.intel.com, zhi.a.wang@intel.com, joonas.lahtinen@linux.intel.com, kevin.tian@intel.com, xiao.zheng@intel.com, Yulei Zhang <yulei.zhang@intel.com>

New VFIO ioctl VFIO_DEVICE_PCI_GET_DIRTY_BITMAP is used to sync the
pci device dirty pages during the migration.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 hw/vfio/pci.c              | 32 ++++++++++++++++++++++++++++++++
 hw/vfio/pci.h              |  2 ++
 linux-headers/linux/vfio.h | 14 ++++++++++++++
 3 files changed, 48 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 833cd90..64c851f 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -32,6 +32,7 @@
 #include "pci.h"
 #include "trace.h"
 #include "qapi/error.h"
+#include "exec/ram_addr.h"
 
 #define MSIX_CAP_LENGTH 12
 
@@ -39,6 +40,7 @@ static void vfio_disable_interrupts(VFIOPCIDevice *vdev);
 static void vfio_mmap_set_enabled(VFIOPCIDevice *vdev, bool enabled);
 static VMStateDescription vfio_pci_vmstate;
 static void vfio_vm_change_state_handler(void *pv, int running, RunState state);
+static void vfio_log_sync(MemoryListener *listener, MemoryRegionSection *section);
 
 /*
  * Disabling BAR mmaping can be slow, but toggling it around INTx can
@@ -2869,6 +2871,11 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     vfio_setup_resetfn_quirk(vdev);
     qemu_add_vm_change_state_handler(vfio_vm_change_state_handler, vdev);
 
+    vdev->vfio_memory_listener = (MemoryListener) {
+	    .log_sync = vfio_log_sync,
+    };
+    memory_listener_register(&vdev->vfio_memory_listener, &address_space_memory);
+
     return;
 
 out_teardown:
@@ -2964,6 +2971,7 @@ static void vfio_vm_change_state_handler(void *pv, int running, RunState state)
     if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_STATUS_SET, vfio_status)) {
         error_report("vfio: Failed to %s device\n", running ? "start" : "stop");
     }
+    vdev->device_stop = running ? false : true;
     g_free(vfio_status);
 }
 
@@ -3079,6 +3087,30 @@ static int vfio_device_get(QEMUFile *f, void *pv, size_t size, VMStateField *fie
     return 0;
 }
 
+static void vfio_log_sync(MemoryListener *listener, MemoryRegionSection *section)
+{
+    VFIOPCIDevice *vdev = container_of(listener, struct VFIOPCIDevice, vfio_memory_listener);
+
+    if (vdev->device_stop) {
+        struct vfio_pci_get_dirty_bitmap *d;
+        ram_addr_t size = int128_get64(section->size);
+        unsigned long page_nr = size >> TARGET_PAGE_BITS;
+        unsigned long bitmap_size = (BITS_TO_LONGS(page_nr) + 1) * sizeof(unsigned long);
+        d = g_malloc0(sizeof(*d) + bitmap_size);
+        d->start_addr = section->offset_within_address_space;
+        d->page_nr = page_nr;
+
+        if (ioctl(vdev->vbasedev.fd, VFIO_DEVICE_PCI_GET_DIRTY_BITMAP, d)) {
+            error_report("vfio: Failed to fetch dirty pages for migration\n");
+            goto exit;
+        }
+        cpu_physical_memory_set_dirty_lebitmap((unsigned long*)&d->dirty_bitmap, d->start_addr, d->page_nr);
+
+exit:
+        g_free(d);
+    }
+}
+
 static void vfio_instance_init(Object *obj)
 {
     PCIDevice *pci_dev = PCI_DEVICE(obj);
diff --git a/hw/vfio/pci.h b/hw/vfio/pci.h
index bd98618..984391d 100644
--- a/hw/vfio/pci.h
+++ b/hw/vfio/pci.h
@@ -144,6 +144,8 @@ typedef struct VFIOPCIDevice {
     bool no_kvm_intx;
     bool no_kvm_msi;
     bool no_kvm_msix;
+    bool device_stop;
+    MemoryListener vfio_memory_listener;
 } VFIOPCIDevice;
 
 uint32_t vfio_pci_read_config(PCIDevice *pdev, uint32_t addr, int len);
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index fa17848..aa73ee1 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -502,6 +502,20 @@ struct vfio_pci_status_set{
 
 #define VFIO_DEVICE_PCI_STATUS_SET	_IO(VFIO_TYPE, VFIO_BASE + 14)
 
+/**
+ * VFIO_DEVICE_PCI_GET_DIRTY_BITMAP - _IOW(VFIO_TYPE, VFIO_BASE + 15,
+ *				    struct vfio_pci_get_dirty_bitmap)
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_pci_get_dirty_bitmap{
+	__u64	       start_addr;
+	__u64	       page_nr;
+	__u8           dirty_bitmap[];
+};
+
+#define VFIO_DEVICE_PCI_GET_DIRTY_BITMAP _IO(VFIO_TYPE, VFIO_BASE + 15)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.7.4
