Received: from eggs.gnu.org ([2001:4830:134:3::10]:46304)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrT-0001vN-KB
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yulei.zhang@intel.com>) id 1dPPrR-0004Qf-Ow
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:11 -0400
Received: from mga11.intel.com ([192.55.52.93]:44436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yulei.zhang@intel.com>)
	id 1dPPrR-0004PL-GG
	for qemu-devel@nongnu.org; Mon, 26 Jun 2017 04:59:09 -0400
From: Yulei Zhang <yulei.zhang@intel.com>
Message-Id: <1491301977-24481-8-git-send-email-yulei.zhang@intel.com>
In-Reply-To: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
References: <1491301977-24481-1-git-send-email-yulei.zhang@intel.com>
Subject: [Qemu-devel] [Intel-gfx][RFC 7/9] drm/i915/gvt: Introduce new VFIO
 ioctl for device status control
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

Add handling for new VFIO ioctl VFIO_DEVICE_PCI_STATUS_SET to control
the status of mdev device vGPU. vGPU will stop/start rendering according
to the command comes along with the ioctl.

Signed-off-by: Yulei Zhang <yulei.zhang@intel.com>
---
 drivers/gpu/drm/i915/gvt/kvmgt.c |  9 +++++++++
 drivers/gpu/drm/i915/gvt/vgpu.c  |  1 +
 include/uapi/linux/vfio.h        | 15 +++++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/i915/gvt/kvmgt.c b/drivers/gpu/drm/i915/gvt/kvmgt.c
index c44b319..ac327f7 100644
--- a/drivers/gpu/drm/i915/gvt/kvmgt.c
+++ b/drivers/gpu/drm/i915/gvt/kvmgt.c
@@ -1147,6 +1147,15 @@ static long intel_vgpu_ioctl(struct mdev_device *mdev, unsigned int cmd,
 	} else if (cmd == VFIO_DEVICE_RESET) {
 		intel_gvt_ops->vgpu_reset(vgpu);
 		return 0;
+	} else if (cmd == VFIO_DEVICE_PCI_STATUS_SET) {
+		struct vfio_pci_status_set status;
+		minsz = offsetofend(struct vfio_pci_status_set, flags);
+		if (copy_from_user(&status, (void __user *)arg, minsz))
+			return -EFAULT;
+		if (status.flags == VFIO_DEVICE_PCI_STOP)
+			intel_gvt_ops->vgpu_deactivate(vgpu);
+		else
+			intel_gvt_ops->vgpu_activate(vgpu);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/i915/gvt/vgpu.c b/drivers/gpu/drm/i915/gvt/vgpu.c
index 989f353..542bde9 100644
--- a/drivers/gpu/drm/i915/gvt/vgpu.c
+++ b/drivers/gpu/drm/i915/gvt/vgpu.c
@@ -205,6 +205,7 @@ void intel_gvt_activate_vgpu(struct intel_vgpu *vgpu)
 {
 	mutex_lock(&vgpu->gvt->lock);
 	vgpu->active = true;
+	intel_vgpu_start_schedule(vgpu);
 	mutex_unlock(&vgpu->gvt->lock);
 }
 
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 9ad9ce1..4bb057d 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -503,6 +503,21 @@ struct vfio_pci_hot_reset {
 
 #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
 
+/**
+ * VFIO_DEVICE_PCI_STATUS_SET - _IOW(VFIO_TYPE, VFIO_BASE + 14,
+ *				    struct vfio_pci_status_set)
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_pci_status_set{
+	__u32	argsz;
+	__u32	flags;
+#define VFIO_DEVICE_PCI_STOP  (1 << 0)
+#define VFIO_DEVICE_PCI_START (1 << 1)
+};
+
+#define VFIO_DEVICE_PCI_STATUS_SET	_IO(VFIO_TYPE, VFIO_BASE + 14)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.7.4
