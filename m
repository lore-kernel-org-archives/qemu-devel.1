Received: from eggs.gnu.org ([2001:4830:134:3::10]:50135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cfcsu-0007pt-V3
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 20:35:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tianyu.lan@intel.com>) id 1cfcst-0007sD-RP
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 20:35:24 -0500
Received: from mga09.intel.com ([134.134.136.24]:43564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tianyu.lan@intel.com>)
	id 1cfcst-0007s1-Il
	for qemu-devel@nongnu.org; Sun, 19 Feb 2017 20:35:23 -0500
From: Lan Tianyu <tianyu.lan@intel.com>
Date: Mon, 20 Feb 2017 09:28:07 +0800
Message-Id: <1487554087-15347-5-git-send-email-tianyu.lan@intel.com>
In-Reply-To: <1487554087-15347-1-git-send-email-tianyu.lan@intel.com>
References: <1487554087-15347-1-git-send-email-tianyu.lan@intel.com>
Subject: [Qemu-devel] [Resend RFC PATCH 4/4] VFIO: Read IOMMU fault info
 from kernel space when get fault event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lan Tianyu <tianyu.lan@intel.com>, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, jasowang@redhat.com, peterx@redhat.com, david@gibson.dropbear.id.au, alex.williamson@redhat.com, yi.l.liu@intel.com

This patch is to implement fault event handler with new vfio cmd to
get fault info and notify vIOMMU device model.

Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
---
 hw/vfio/common.c           | 51 ++++++++++++++++++++++++++++++++++++++++++++++
 linux-headers/linux/vfio.h | 22 ++++++++++++++++++++
 2 files changed, 73 insertions(+)

diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 628b424..4f76e26 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -297,6 +297,57 @@ static bool vfio_listener_skipped_section(MemoryRegionSection *section)
 
 static void vfio_iommu_fault(void *opaque)
 {
+    VFIOContainer *container = opaque;
+    struct vfio_iommu_type1_get_fault_info *info;
+    struct vfio_iommu_fault_info *fault_info;
+    MemoryRegion *mr = container->space->as->root;
+    int count = 0, i, ret;
+    IOMMUFaultInfo tmp;
+
+    if (!event_notifier_test_and_clear(&container->fault_notifier)) {
+        return;
+    }
+
+    info = g_malloc0(sizeof(*info));
+    if (!info) {
+        error_report("vfio: Fail to allocate memory");
+        return;
+    }
+
+    info->argsz = sizeof(*info);
+
+    ret = ioctl(container->fd, VFIO_IOMMU_GET_FAULT_INFO, info);
+    if (ret && ret != -ENOSPC) {
+        error_report("vfio: Can't get fault info");
+        goto err_exit;
+    }
+
+    count = info->count;
+    if (count <= 0) {
+        goto err_exit;
+    }
+
+    info = g_realloc(info, sizeof(*info) + count * sizeof(*fault_info));
+    info->argsz = sizeof(*info) + count * sizeof(*fault_info);
+    fault_info = info->fault_info;
+
+    ret = ioctl(container->fd, VFIO_IOMMU_GET_FAULT_INFO, info);
+    if (ret) {
+        error_report("vfio: Can't get fault info");
+        goto err_exit;
+    }
+
+    for (i = 0; i < info->count; i++) {
+        tmp.addr = fault_info[i].addr;
+        tmp.sid = fault_info[i].sid;
+        tmp.fault_reason = fault_info[i].fault_reason;
+        tmp.is_write = fault_info[i].is_write;
+
+        memory_region_iommu_fault_notify(mr, &tmp);
+    }
+
+err_exit:
+    g_free(info);
 }
 
 static int vfio_set_iommu_fault_notifier(struct VFIOContainer *container)
diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index ca890ee..8b172f5 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -550,6 +550,28 @@ struct vfio_iommu_type1_set_fault_eventfd {
 
 #define VFIO_IOMMU_SET_FAULT_EVENTFD	_IO(VFIO_TYPE, VFIO_BASE + 17)
 
+/*
+ * VFIO_IOMMU_GET_FAULT_INFO		_IO(VFIO_TYPE, VFIO_BASE + 18)
+ *
+ * Return IOMMU fault info to userspace.
+ */
+
+struct vfio_iommu_fault_info {
+	__u64	addr;
+	__u16   sid;
+	__u8    fault_reason;
+	__u8	is_write:1;
+};
+
+struct vfio_iommu_type1_get_fault_info {
+	__u32	argsz;
+	__u32   flags;
+	__u32	count;
+	struct vfio_iommu_fault_info fault_info[];
+};
+
+#define VFIO_IOMMU_GET_FAULT_INFO	_IO(VFIO_TYPE, VFIO_BASE + 18)
+
 /* -------- Additional API for SPAPR TCE (Server POWERPC) IOMMU -------- */
 
 /*
-- 
1.8.3.1
