Received: from eggs.gnu.org ([2001:4830:134:3::10]:41666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBfa9-0005E7-PM
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBfa6-000096-Ne
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:29 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53198
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dBfa6-00008c-I9
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:26 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JAmuBH087250
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:56:26 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahwramfa1-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:56:25 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 19 May 2017 11:56:24 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 19 May 2017 12:55:54 +0200
In-Reply-To: <20170519105600.11589-1-cornelia.huck@de.ibm.com>
References: <20170519105600.11589-1-cornelia.huck@de.ibm.com>
Message-Id: <20170519105600.11589-16-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 15/21] vfio/ccw: get io region info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

vfio-ccw provides an MMIO region for I/O operations. We fetch its
information via ioctls here, then we can use it performing I/O
instructions and retrieving I/O results later on.

Reviewed-by: Eric Auger <eric.auger@redhat.com>
Acked-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170517004813.58227-9-bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/vfio/ccw.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 7d2497cee6..7ddcfd7767 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -12,6 +12,7 @@
  */
 
 #include <linux/vfio.h>
+#include <linux/vfio_ccw.h>
 #include <sys/ioctl.h>
 
 #include "qemu/osdep.h"
@@ -26,6 +27,9 @@
 typedef struct VFIOCCWDevice {
     S390CCWDevice cdev;
     VFIODevice vdev;
+    uint64_t io_region_size;
+    uint64_t io_region_offset;
+    struct ccw_io_region *io_region;
 } VFIOCCWDevice;
 
 static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
@@ -50,6 +54,48 @@ static void vfio_ccw_reset(DeviceState *dev)
     ioctl(vcdev->vdev.fd, VFIO_DEVICE_RESET);
 }
 
+static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
+{
+    VFIODevice *vdev = &vcdev->vdev;
+    struct vfio_region_info *info;
+    int ret;
+
+    /* Sanity check device */
+    if (!(vdev->flags & VFIO_DEVICE_FLAGS_CCW)) {
+        error_setg(errp, "vfio: Um, this isn't a vfio-ccw device");
+        return;
+    }
+
+    if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
+        error_setg(errp, "vfio: Unexpected number of the I/O region %u",
+                   vdev->num_regions);
+        return;
+    }
+
+    ret = vfio_get_region_info(vdev, VFIO_CCW_CONFIG_REGION_INDEX, &info);
+    if (ret) {
+        error_setg_errno(errp, -ret, "vfio: Error getting config info");
+        return;
+    }
+
+    vcdev->io_region_size = info->size;
+    if (sizeof(*vcdev->io_region) != vcdev->io_region_size) {
+        error_setg(errp, "vfio: Unexpected size of the I/O region");
+        g_free(info);
+        return;
+    }
+
+    vcdev->io_region_offset = info->offset;
+    vcdev->io_region = g_malloc0(info->size);
+
+    g_free(info);
+}
+
+static void vfio_ccw_put_region(VFIOCCWDevice *vcdev)
+{
+    g_free(vcdev->io_region);
+}
+
 static void vfio_put_device(VFIOCCWDevice *vcdev)
 {
     g_free(vcdev->vdev.name);
@@ -122,8 +168,15 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_device_err;
     }
 
+    vfio_ccw_get_region(vcdev, &err);
+    if (err) {
+        goto out_region_err;
+    }
+
     return;
 
+out_region_err:
+    vfio_put_device(vcdev);
 out_device_err:
     vfio_put_group(group);
 out_group_err:
@@ -142,6 +195,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     VFIOGroup *group = vcdev->vdev.group;
 
+    vfio_ccw_put_region(vcdev);
     vfio_put_device(vcdev);
     vfio_put_group(group);
 
-- 
2.13.0
