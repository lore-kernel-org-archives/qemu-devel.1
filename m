Received: from eggs.gnu.org ([2001:4830:134:3::10]:45395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fGZ8Z-0000aP-Du
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:08:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fGZ8W-0006eo-14
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:08:47 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49984)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fGZ8V-0006eV-P7
	for qemu-devel@nongnu.org; Wed, 09 May 2018 20:08:43 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4A04Lwi081643
	for <qemu-devel@nongnu.org>; Wed, 9 May 2018 20:08:40 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2hvac3sxr5-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 09 May 2018 20:08:40 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 10 May 2018 01:08:38 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 10 May 2018 02:07:11 +0200
In-Reply-To: <20180510000712.6472-1-pasic@linux.ibm.com>
References: <20180510000712.6472-1-pasic@linux.ibm.com>
Message-Id: <20180510000712.6472-2-pasic@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 1/2] vfio-ccw: add force unlimited prefetch
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>

There is at least one control program (guest) that although it does not
rely on the guarantees provided by ORB 1 word 9 bit (aka unlimited
prefetch, aka P bit) not being set, fails to tell this to the machine.

Usually this ain't a big deal, as the story is usually about performance
optimizations only. But vfio-ccw can not provide the guarantees required
if the bit is not set.

Since it is impossible to implement support for P bit not set (at
impossible least without transitioning to lower level protocols) in
vfio-ccw let's provide a manual override.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Suggested-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 hw/s390x/css.c |  3 +--
 hw/vfio/ccw.c  | 13 +++++++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 301bf1772f..32f1b2820d 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1196,8 +1196,7 @@ static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
      * Only support prefetch enable mode.
      * Only support 64bit addressing idal.
      */
-    if (!(orb->ctrl0 & ORB_CTRL0_MASK_PFCH) ||
-        !(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
+    if (!(orb->ctrl0 & ORB_CTRL0_MASK_C64)) {
         warn_report("vfio-ccw requires PFCH and C64 flags set");
         sch_gen_unit_exception(sch);
         css_inject_io_interrupt(sch);
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index e67392c5f9..32cf606a71 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -32,6 +32,8 @@ typedef struct VFIOCCWDevice {
     uint64_t io_region_offset;
     struct ccw_io_region *io_region;
     EventNotifier io_notifier;
+    /* force unlimited prefetch */
+    bool f_upfch;
 } VFIOCCWDevice;
 
 static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
@@ -52,8 +54,18 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
     S390CCWDevice *cdev = sch->driver_data;
     VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
     struct ccw_io_region *region = vcdev->io_region;
+    bool upfch = sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH;
     int ret;
 
+    if (!upfch && !vcdev->f_upfch) {
+        warn_report("vfio-ccw requires PFCH flag set");
+        sch_gen_unit_exception(sch);
+        css_inject_io_interrupt(sch);
+        return IOINST_CC_EXPECTED;
+    } else if (!upfch) {
+        sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
+    }
+
     QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
     QEMU_BUILD_BUG_ON(sizeof(region->scsw_area) != sizeof(SCSW));
     QEMU_BUILD_BUG_ON(sizeof(region->irb_area) != sizeof(IRB));
@@ -429,6 +441,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
 
 static Property vfio_ccw_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
+    DEFINE_PROP_BOOL("f-upfch", VFIOCCWDevice, f_upfch, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.16.3
