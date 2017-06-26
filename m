Received: from eggs.gnu.org ([2001:4830:134:3::10]:46359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrU-0001wJ-W5
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrU-0004Rz-1J
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:44436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPrT-0004PL-Ps
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:11 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301977-24481-9-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
References: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [Intel-gfx][RFC 8/9] drm/i915/gvt: Introduce new VFIO
 ioctl for mdev device dirty page sync
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Date: Mon, 26 Jun 2017 08:59:14 -0000
To: qemu-devel@nongnu.org
Cc: zhenyuw@linux.intel.com, zhi.a.wang@intel.com, joonas.lahtinen@linux.intel.com, kevin.tian@intel.com, xiao.zheng@intel.com, Yulei Zhang <yulei.zhang@intel.com>

Add new vfio ioctl VFIO_DEVICE_PCI_GET_DIRTY_BITMAP to fetch the dirty
page bitmap from mdev device driver for data sync during live migration.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c | 33 +++++++++++++++++++++++++++++++++
 include/uapi/linux/vfio.h        | 14 ++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index ac327f7..e9f11a9 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -919,6 +919,24 @@ static int intel_vgpu_set_irqs(struct intel_vgpu *vgpu, uint32_t flags,
 	return func(vgpu, index, start, count, flags, data);
 }
 
+static void intel_vgpu_update_dirty_bitmap(struct intel_vgpu *vgpu, u64 start_addr,
+                                           u64 page_nr, void *bitmap)
+{
+	u64 gfn = start_addr >> GTT_PAGE_SHIFT;
+	struct intel_vgpu_guest_page *p;
+	int i;
+
+	for (i = 0; i < page_nr; i++) {
+		hash_for_each_possible(vgpu->gtt.guest_page_hash_table,
+				       p, node, gfn) {
+			if (p->gfn == gfn)
+				set_bit(i, bitmap);
+		}
+		gfn++;
+	}
+
+}
+
 static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 			     unsigned long arg)
 {
@@ -1156,6 +1174,21 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 			intel_gvt_ops->vgpu_deactivate(vgpu);
 		else
 			intel_gvt_ops->vgpu_activate(vgpu);
+	} else if (cmd == VFIO_DEVICE_PCI_GET_DIRTY_BITMAP) {
+		struct vfio_pci_get_dirty_bitmap d;
+		unsigned long bitmap_sz;
+		unsigned *bitmap;
+		minsz = offsetofend(struct vfio_pci_get_dirty_bitmap, page_nr);
+		if (copy_from_user(&d, (void __user *)arg, minsz))
+			return -EFAULT;
+		bitmap_sz = (BITS_TO_LONGS(d.page_nr) + 1) * sizeof(unsigned long);
+		bitmap = vzalloc(bitmap_sz);
+		intel_vgpu_update_dirty_bitmap(vgpu, d.start_addr, d.page_nr, bitmap);
+		if (copy_to_user((void __user*)arg + minsz, bitmap, bitmap_sz)) {
+			vfree(bitmap);
+			return -EFAULT;
+		}
+		vfree(bitmap);
 	}
 
 	return 0;
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 4bb057d..544cf93 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -518,6 +518,20 @@ struct vfio_pci_status_set{
 
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
