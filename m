Received: from eggs.gnu.org ([2001:4830:134:3::10]:57659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiQx-00082q-VK
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:20:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1coiQt-0000rk-I3
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:20:07 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39215
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1coiQt-0000rc-CR
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 23:20:03 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2H3JDcS005969
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:20:02 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0b-001b2d01.pphosted.com with ESMTP id 297wd0h3eq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 16 Mar 2017 23:20:02 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 16 Mar 2017 21:20:00 -0600
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Fri, 17 Mar 2017 04:19:24 +0100
In-Reply-To: <20170317031928.40189-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031928.40189-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170317031928.40189-8-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH v4 07/11] vfio/ccw: get io region info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

vfio-ccw provides an MMIO region for I/O operations. We fetch its
information via ioctls here, then we can use it performing I/O
instructions and retrieving I/O results later on.

Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 hw/vfio/ccw.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index d5ff02f..1df2512 100644
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
@@ -50,6 +54,46 @@ static void vfio_ccw_reset(DeviceState *dev)
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
+        error_setg(errp, "vfio: Error getting config info: %d", ret);
+        return;
+    }
+
+    vcdev->io_region_size = info->size;
+    if (sizeof(*vcdev->io_region) != vcdev->io_region_size) {
+        error_setg(errp, "vfio: Unexpected size of the I/O region");
+        return;
+    }
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
@@ -144,8 +188,15 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
         goto out_device_err;
     }
 
+    vfio_ccw_get_region(vcdev, errp);
+    if (*errp) {
+        goto out_region_err;
+    }
+
     return;
 
+out_region_err:
+    vfio_put_device(vcdev);
 out_device_err:
     vfio_ccw_put_group(group, path);
 out_group_err:
@@ -166,6 +217,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
         cdc->unrealize(cdev, errp);
     }
 
+    vfio_ccw_put_region(vcdev);
     vfio_put_device(vcdev);
     vfio_put_group(group);
 }
-- 
2.8.4
