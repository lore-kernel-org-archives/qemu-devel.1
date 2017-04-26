Received: from eggs.gnu.org ([2001:4830:134:3::10]:50676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7u-0003JF-JI
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1d3K7p-0002eO-L7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:61221)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1d3K7p-0002e2-9X
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 06:24:45 -0400
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Date: Wed, 26 Apr 2017 18:06:46 +0800
Message-Id: <1493201210-14357-17-git-send-email-yi.l.liu@linux.intel.com>
In-Reply-To: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
References: <1493201210-14357-1-git-send-email-yi.l.liu@linux.intel.com>
Subject: [Qemu-devel] [RFC PATCH 16/20] VFIO: Add notifier for propagating
 IOMMU TLB invalidate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, alex.williamson@redhat.com, peterx@redhat.com
Cc: kvm@vger.kernel.org, jasowang@redhat.com, iommu@lists.linux-foundation.org, kevin.tian@intel.com, ashok.raj@intel.com, jacob.jun.pan@intel.com, tianyu.lan@intel.com, yi.l.liu@intel.com, jean-philippe.brucker@arm.com, "Liu, Yi L" <yi.l.liu@linux.intel.com>

This patch adds the following items:
* add new notifier flag IOMMU_NOTIFIER_IOMMU_TLB_INV = 0x8
* add new IOCTL cmd VFIO_IOMMU_TLB_INVALIDATE attached on container->fd
* add vfio_iommu_tlb_invalidate_notify() to propagate IOMMU TLB invalidate
  to host

This new notifier is originated from the requirement of SVM virtualization
on VT-d. It is for invalidation of first-level and nested mappings from the
IOTLB and the paging-structure-caches. Since the existed MAP/UNMAP notifier
is designed for second-level related mappings, it is not suitable for the
new requirement. So it is necessary to introduce this new notifier to meet
the SVM virtualization requirement. Further detail would be included in the
patch below:

"intel_iommu: propagate Extended-IOTLB invalidate to host"

Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
---
 hw/vfio/pci.c               | 37 +++++++++++++++++++++++++++++++++++++
 include/exec/memory.h       |  2 ++
 linux-headers/linux/iommu.h |  5 +++++
 linux-headers/linux/vfio.h  |  8 ++++++++
 4 files changed, 52 insertions(+)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index a1e6942..afcefd6 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2619,6 +2619,33 @@ static void vfio_iommu_bind_pasid_tbl_notify(IOMMUNotifier *n, void *data)
     g_free(vfio_svm);
 }
 
+static void vfio_iommu_tlb_invalidate_notify(IOMMUNotifier *n,
+                                             void *data)
+{
+    VFIOGuestIOMMU *giommu = container_of(n, VFIOGuestIOMMU, n);
+    VFIOContainer *container = giommu->container;
+    IOMMUNotifierData *iommu_data = (IOMMUNotifierData *) data;
+    struct vfio_iommu_tlb_invalidate *vfio_tlb_inv;
+    int argsz;
+
+    argsz = sizeof(*vfio_tlb_inv) + iommu_data->payload_size;
+    vfio_tlb_inv = g_malloc0(argsz);
+    vfio_tlb_inv->argsz = argsz;
+    vfio_tlb_inv->length = iommu_data->payload_size;
+
+    memcpy(&vfio_tlb_inv->data, iommu_data->payload,
+              iommu_data->payload_size);
+
+    rcu_read_lock();
+    if (ioctl(container->fd, VFIO_IOMMU_TLB_INVALIDATE,
+              vfio_tlb_inv) != 0) {
+        error_report("vfio_iommu_tlb_invalidate_notify:"
+                     " failed, contanier: %p", container);
+    }
+    rcu_read_unlock();
+    g_free(vfio_tlb_inv);
+}
+
 static void vfio_realize(PCIDevice *pdev, Error **errp)
 {
     VFIOPCIDevice *vdev = DO_UPCAST(VFIOPCIDevice, pdev, pdev);
@@ -2865,6 +2892,7 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
     QTAILQ_FOREACH(subregion, &as->root->subregions, subregions_link) {
         if (memory_region_is_iommu(subregion)) {
             IOMMUNotifier n1;
+            IOMMUNotifier n2;
 
             /*
              FIXME: current iommu notifier is actually designed for
@@ -2882,6 +2910,15 @@ static void vfio_realize(PCIDevice *pdev, Error **errp)
                                    0,
                                    &n1);
 
+            iommu_notifier_init(&n2, vfio_iommu_tlb_invalidate_notify,
+                                IOMMU_NOTIFIER_IOMMU_TLB_INV,
+                                0,
+                                0);
+            vfio_register_notifier(group->container,
+                                   subregion,
+                                   0,
+                                   &n2);
+
             memory_region_notify_device_record(subregion,
                                                &vdev->host);
 
diff --git a/include/exec/memory.h b/include/exec/memory.h
index 3b8f487..af15351 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -83,6 +83,8 @@ typedef enum {
     IOMMU_NOTIFIER_MAP = 0x2,
     /* Notify PASID Table Binding */
     IOMMU_NOTIFIER_SVM_PASIDT_BIND = 0x4,
+    /* Notify IOMMU TLB Invalidation */
+    IOMMU_NOTIFIER_IOMMU_TLB_INV = 0x8,
 } IOMMUNotifierFlag;
 
 #define IOMMU_NOTIFIER_MAP_UNMAP (IOMMU_NOTIFIER_MAP | IOMMU_NOTIFIER_UNMAP)
diff --git a/linux-headers/linux/iommu.h b/linux-headers/linux/iommu.h
index 4519dcf..c2742ba 100644
--- a/linux-headers/linux/iommu.h
+++ b/linux-headers/linux/iommu.h
@@ -27,4 +27,9 @@ struct pasid_table_info {
 	__u8   opaque[];/* IOMMU-specific details */
 };
 
+struct tlb_invalidate_info {
+	__u32	model;
+	__u8	opaque[];
+};
+
 #endif /* __LINUX_IOMMU_H */
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 9848d63..6c71c4a 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -554,6 +554,14 @@ struct vfio_device_svm {
 
 #define VFIO_IOMMU_SVM_BIND_TASK	_IO(VFIO_TYPE, VFIO_BASE + 22)
 
+/* For IOMMU Invalidation Passdwon */
+struct vfio_iommu_tlb_invalidate {
+	__u32	argsz;
+	__u32	length;
+	__u8	data[];
+};
+
+#define VFIO_IOMMU_TLB_INVALIDATE	_IO(VFIO_TYPE, VFIO_BASE + 23)
 
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
-- 
1.9.1
