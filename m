Received: from eggs.gnu.org ([2001:4830:134:3::10]:41532)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1v8M-0001jY-0c
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1e1v8H-00047o-A4
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1e1v8H-00047P-1c
	for qemu-devel@nongnu.org; Tue, 10 Oct 2017 10:03:41 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Tue, 10 Oct 2017 16:03:29 +0200
Message-Id: <20171010140334.8231-2-kraxel@redhat.com>
In-Reply-To: <20171010140334.8231-1-kraxel@redhat.com>
References: <20171010140334.8231-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH 1/6] headers: update
 linux-headers/linux/vfio.h (intel-gvt kernel patches, v15)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 linux-headers/linux/vfio.h | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 4e7ab4c52a..ff30feb1eb 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -502,6 +502,68 @@ struct vfio_pci_hot_reset {
 
 #define VFIO_DEVICE_PCI_HOT_RESET	_IO(VFIO_TYPE, VFIO_BASE + 13)
 
+/**
+ * VFIO_DEVICE_QUERY_GFX_PLANE - _IOW(VFIO_TYPE, VFIO_BASE + 14,
+ *                                    struct vfio_device_query_gfx_plane)
+ *
+ * Set the drm_plane_type and flags, then retrieve the gfx plane info.
+ *
+ * flags supported:
+ * - VFIO_GFX_PLANE_TYPE_PROBE and VFIO_GFX_PLANE_TYPE_DMABUF are set
+ *   to ask if the mdev supports dma-buf. 0 on support, -EINVAL on no
+ *   support for dma-buf.
+ * - VFIO_GFX_PLANE_TYPE_PROBE and VFIO_GFX_PLANE_TYPE_REGION are set
+ *   to ask if the mdev supports region. 0 on support, -EINVAL on no
+ *   support for region.
+ * - VFIO_GFX_PLANE_TYPE_DMABUF or VFIO_GFX_PLANE_TYPE_REGION is set
+ *   with each call to query the plane info.
+ * - Others are invalid and return -EINVAL.
+ *
+ * Return: 0 on success, -ENODEV with all out fields zero on mdev
+ * device initialization, -errno on other failure.
+ */
+struct vfio_device_gfx_plane_info {
+	__u32 argsz;
+	__u32 flags;
+#define VFIO_GFX_PLANE_TYPE_PROBE (1 << 0)
+#define VFIO_GFX_PLANE_TYPE_DMABUF (1 << 1)
+#define VFIO_GFX_PLANE_TYPE_REGION (1 << 2)
+	/* in */
+	__u32 drm_plane_type;	/* type of plane: DRM_PLANE_TYPE_* */
+	/* out */
+	__u32 drm_format;	/* drm format of plane */
+	__u64 drm_format_mod;   /* tiled mode */
+	__u32 width;	/* width of plane */
+	__u32 height;	/* height of plane */
+	__u32 stride;	/* stride of plane */
+	__u32 size;	/* size of plane in bytes, align on page*/
+	__u32 x_pos;	/* horizontal position of cursor plane */
+	__u32 y_pos;	/* vertical position of cursor plane*/
+	union {
+		__u32 region_index;	/* region index */
+		__s32 dmabuf_id;	/* dma-buf fd */
+	};
+};
+
+#define VFIO_DEVICE_QUERY_GFX_PLANE _IO(VFIO_TYPE, VFIO_BASE + 14)
+
+/**
+ * VFIO_DEVICE_GET_GFX_DMABUF - _IOW(VFIO_TYPE, VFIO_BASE + 15,
+ *				    struct vfio_device_gfx_dmabuf_fd)
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+struct vfio_device_gfx_dmabuf_fd {
+	__u32 argsz;
+	__u32 flags;
+	/* in */
+	__u32 dmabuf_id;
+	/* out */
+	__s32 dmabuf_fd;
+};
+
+#define VFIO_DEVICE_GET_GFX_DMABUF _IO(VFIO_TYPE, VFIO_BASE + 15)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.9.3
