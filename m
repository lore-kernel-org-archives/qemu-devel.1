Received: from eggs.gnu.org ([209.51.188.92]:34590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghtAQ-0000mq-Pt
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:31:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1ghtAJ-0003Yk-HK
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:31:51 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1ghtAD-000354-0Z
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 04:31:41 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 11 Jan 2019 10:31:12 +0100
Message-Id: <20190111093116.17188-2-kraxel@redhat.com>
In-Reply-To: <20190111093116.17188-1-kraxel@redhat.com>
References: <20190111093116.17188-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] vfio: update kernel headers.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>, intel-gvt-dev@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>

Temporary, for testing convinience.

Once qemu master is synced with the linux 5.0-rc1 headers
this is not needed any more.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 linux-headers/linux/vfio.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index ceb6453394..51662a7209 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -303,6 +303,56 @@ struct vfio_region_info_cap_type {
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_HOST_CFG	(2)
 #define VFIO_REGION_SUBTYPE_INTEL_IGD_LPC_CFG	(3)
 
+#define VFIO_REGION_TYPE_GFX                    (1)
+#define VFIO_REGION_SUBTYPE_GFX_EDID            (1)
+
+/**
+ * struct vfio_region_gfx_edid - EDID region layout.
+ *
+ * Set display link state and EDID blob.
+ *
+ * The EDID blob has monitor information such as brand, name, serial
+ * number, physical size, supported video modes and more.
+ *
+ * This special region allows userspace (typically qemu) set a virtual
+ * EDID for the virtual monitor, which allows a flexible display
+ * configuration.
+ *
+ * For the edid blob spec look here:
+ *    https://en.wikipedia.org/wiki/Extended_Display_Identification_Data
+ *
+ * On linux systems you can find the EDID blob in sysfs:
+ *    /sys/class/drm/${card}/${connector}/edid
+ *
+ * You can use the edid-decode ulility (comes with xorg-x11-utils) to
+ * decode the EDID blob.
+ *
+ * @edid_offset: location of the edid blob, relative to the
+ *               start of the region (readonly).
+ * @edid_max_size: max size of the edid blob (readonly).
+ * @edid_size: actual edid size (read/write).
+ * @link_state: display link state (read/write).
+ * VFIO_DEVICE_GFX_LINK_STATE_UP: Monitor is turned on.
+ * VFIO_DEVICE_GFX_LINK_STATE_DOWN: Monitor is turned off.
+ * @max_xres: max display width (0 == no limitation, readonly).
+ * @max_yres: max display height (0 == no limitation, readonly).
+ *
+ * EDID update protocol:
+ *   (1) set link-state to down.
+ *   (2) update edid blob and size.
+ *   (3) set link-state to up.
+ */
+struct vfio_region_gfx_edid {
+	__u32 edid_offset;
+	__u32 edid_max_size;
+	__u32 edid_size;
+	__u32 max_xres;
+	__u32 max_yres;
+	__u32 link_state;
+#define VFIO_DEVICE_GFX_LINK_STATE_UP    1
+#define VFIO_DEVICE_GFX_LINK_STATE_DOWN  2
+};
+
 /*
  * The MSIX mappable capability informs that MSIX data of a BAR can be mmapped
  * which allows direct access to non-MSIX registers which happened to be within
-- 
2.9.3
