Received: from eggs.gnu.org ([209.51.188.92]:41822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghDKn-0000Y2-7H
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:51:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pmorel@linux.ibm.com>) id 1ghDAs-0004C6-4Y
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:41:36 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42096
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pmorel@linux.ibm.com>)
	id 1ghDAq-0004B0-ED
	for qemu-devel@nongnu.org; Wed, 09 Jan 2019 07:41:32 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	x09CXoPG026555
	for <qemu-devel@nongnu.org>; Wed, 9 Jan 2019 07:41:30 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pwe91rdaf-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 Jan 2019 07:41:30 -0500
Received: from localhost
	by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pmorel@linux.ibm.com>;
	Wed, 9 Jan 2019 12:41:28 -0000
From: Pierre Morel <pmorel@linux.ibm.com>
Date: Wed,  9 Jan 2019 13:41:18 +0100
In-Reply-To: <1547037680-21458-1-git-send-email-pmorel@linux.ibm.com>
References: <1547037680-21458-1-git-send-email-pmorel@linux.ibm.com>
Message-Id: <1547037680-21458-2-git-send-email-pmorel@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v1 1/3] vfio: Linux header placeholder
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: walling@linux.ibm.com
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, rth@twiddle.net, david@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, pasic@linux.ibm.com, thuth@redhat.com

This is a place holder for VFIO.h as changed by the Linux patch
associated with this QEMU series.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
---
 linux-headers/linux/vfio.h | 65 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 62 insertions(+), 3 deletions(-)

diff --git a/linux-headers/linux/vfio.h b/linux-headers/linux/vfio.h
index ceb6453..54c4fcb 100644
--- a/linux-headers/linux/vfio.h
+++ b/linux-headers/linux/vfio.h
@@ -9,8 +9,8 @@
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
  */
-#ifndef VFIO_H
-#define VFIO_H
+#ifndef _UAPIVFIO_H
+#define _UAPIVFIO_H
 
 #include <linux/types.h>
 #include <linux/ioctl.h>
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
@@ -619,6 +669,15 @@ struct vfio_iommu_type1_info {
 	__u32	flags;
 #define VFIO_IOMMU_INFO_PGSIZES (1 << 0)	/* supported page sizes info */
 	__u64	iova_pgsizes;		/* Bitmap of supported page sizes */
+#define VFIO_IOMMU_INFO_CAPABILITIES (1 << 1)  /* support capabilities info */
+	__u64   cap_offset;     /* Offset within info struct of first cap */
+};
+
+#define VFIO_IOMMU_INFO_CAP_DMA 1
+struct vfio_iommu_cap_dma {
+	struct vfio_info_cap_header header;
+	__u64   dma_start;
+	__u64   dma_end;
 };
 
 #define VFIO_IOMMU_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
@@ -818,4 +877,4 @@ struct vfio_iommu_spapr_tce_remove {
 
 /* ***************************************************************** */
 
-#endif /* VFIO_H */
+#endif /* _UAPIVFIO_H */
-- 
2.7.4
