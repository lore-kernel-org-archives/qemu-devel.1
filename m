Received: from eggs.gnu.org ([2001:4830:134:3::10]:39103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egrFm-0004cR-D9
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:12:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1egrFj-00084X-Q9
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:12:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1egrFj-000844-I5
	for qemu-devel@nongnu.org; Wed, 31 Jan 2018 07:12:35 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Wed, 31 Jan 2018 13:12:13 +0100
Message-Id: <20180131121217.13557-2-kraxel@redhat.com>
In-Reply-To: <20180131121217.13557-1-kraxel@redhat.com>
References: <20180131121217.13557-1-kraxel@redhat.com>
Subject: [Qemu-devel] [RfC PATCH v2 1/5] headers: update
 linux-headers/linux/vfio.h (intel-gvt kernel patches, v17)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, Tina Zhang <tina.zhang@intel.com>, intel-gvt-dev@lists.freedesktop.org, Kirti Wankhede <kwankhede@nvidia.com>, Gerd Hoffmann <kraxel@redhat.com>

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 linux-headers/linux/vfio.h | 64 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index 4312e961ff..c433d6542b 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -503,6 +503,70 @@ struct vfio_pci_hot_reset {
 
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
+ * Note:
+ * 1. Plane could be disabled by guest. In that case, success will be
+ *    returned with zero-initialized drm_format, size, width and height
+ *    fields.
+ * 2. x_hot/y_hot is set to 0xFFFFFFFF if no hotspot information available
+ *
+ * Return: 0 on success, -errno on other failure.
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
+	__u32 x_hot;    /* horizontal position of cursor hotspot */
+	__u32 y_hot;    /* vertical position of cursor hotspot */
+	union {
+		__u32 region_index;	/* region index */
+		__u32 dmabuf_id;	/* dma-buf id */
+	};
+};
+
+#define VFIO_DEVICE_QUERY_GFX_PLANE _IO(VFIO_TYPE, VFIO_BASE + 14)
+
+/**
+ * VFIO_DEVICE_GET_GFX_DMABUF - _IOW(VFIO_TYPE, VFIO_BASE + 15, __u32)
+ *
+ * Retrieve a dmabuf fd of an exposed guest framebuffer referenced by
+ * dmabuf_id which is returned from VFIO_DEVICE_QUERY_GFX_PLANE as a token
+ * of the exposed guest framebuffer.
+ *
+ * Return: 0 on success, -errno on failure.
+ */
+
+#define VFIO_DEVICE_GET_GFX_DMABUF _IO(VFIO_TYPE, VFIO_BASE + 15)
+
 /* -------- API for Type1 VFIO IOMMU -------- */
 
 /**
-- 
2.9.3
