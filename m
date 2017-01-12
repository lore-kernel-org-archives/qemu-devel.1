Received: from eggs.gnu.org ([2001:4830:134:3::10]:36431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZlp-0000ZQ-7s
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:26:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cRZlm-0005XU-3W
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:26:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53372)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cRZll-0005XB-Qh
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 02:25:58 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	v0C7O4i9129476
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:25:56 -0500
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27wxnwn1s3-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 02:25:56 -0500
Received: from localhost
	by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Thu, 12 Jan 2017 00:25:56 -0700
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Date: Thu, 12 Jan 2017 08:25:11 +0100
In-Reply-To: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170112072513.98411-1-bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20170112072513.98411-11-bjsdjshi@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH RFC v2 10/12] s390x/css: introduce and realize
 ccw-request callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: bjsdjshi@linux.vnet.ibm.com, renxiaof@linux.vnet.ibm.com, cornelia.huck@de.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, wkywang@linux.vnet.ibm.com

From: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>

Introduce a new callback on subchannel to handle ccw-request.
Realize the callback in vfio-ccw device. Besides, resort to
the event notifier handler to handling the ccw-request results.
1. Pread the I/O results via MMIO region.
2. Update the scsw info to guest.
3. Inject an I/O interrupt to notify guest the I/O result.

Signed-off-by: Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
---
 hw/s390x/css.c         |  4 +--
 hw/s390x/s390-ccw.h    |  1 +
 hw/vfio/ccw.c          | 73 ++++++++++++++++++++++++++++++++++++++++++++++++++
 include/hw/s390x/css.h |  2 ++
 4 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 67fe468..c3a323e 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -238,7 +238,7 @@ uint16_t css_build_subchannel_id(SubchDev *sch)
     return css_do_build_subchannel_id(sch->cssid, sch->ssid);
 }
 
-static void css_inject_io_interrupt(SubchDev *sch)
+void css_inject_io_interrupt(SubchDev *sch)
 {
     uint8_t isc = (sch->curr_status.pmcw.flags & PMCW_FLAGS_MASK_ISC) >> 11;
 
@@ -644,7 +644,7 @@ static void copy_pmcw_to_guest(PMCW *dest, const PMCW *src)
     dest->chars = cpu_to_be32(src->chars);
 }
 
-static void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
+void copy_scsw_to_guest(SCSW *dest, const SCSW *src)
 {
     dest->flags = cpu_to_be16(src->flags);
     dest->ctrl = cpu_to_be16(src->ctrl);
diff --git a/hw/s390x/s390-ccw.h b/hw/s390x/s390-ccw.h
index 1fa4a97..2d3a2b5 100644
--- a/hw/s390x/s390-ccw.h
+++ b/hw/s390x/s390-ccw.h
@@ -27,6 +27,7 @@ typedef struct S390CCWDevice {
     CcwDevice parent_obj;
     CssDevId hostid;
     char *mdevid;
+    int (*handle_request) (ORB *, SCSW *, void *);
 } S390CCWDevice;
 
 typedef struct S390CCWDeviceClass {
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c6bfce7..34c719a 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -47,6 +47,36 @@ struct VFIODeviceOps vfio_ccw_ops = {
     .vfio_compute_needs_reset = vfio_ccw_compute_needs_reset,
 };
 
+static int vfio_ccw_handle_request(ORB *orb, SCSW *scsw, void *data)
+{
+    S390CCWDevice *cdev = data;
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    struct ccw_io_region *region = vcdev->io_region;
+    int ret;
+
+    QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
+    QEMU_BUILD_BUG_ON(sizeof(region->scsw_area) != sizeof(SCSW));
+    QEMU_BUILD_BUG_ON(sizeof(region->irb_area) != sizeof(IRB));
+
+    memset(region, 0, sizeof(*region));
+
+    memcpy(region->orb_area, orb, sizeof(ORB));
+    memcpy(region->scsw_area, scsw, sizeof(SCSW));
+
+again:
+    ret = pwrite(vcdev->vdev.fd, region,
+                 vcdev->io_region_size, vcdev->io_region_offset);
+    if (ret != vcdev->io_region_size) {
+        if (errno == EAGAIN) {
+            goto again;
+        }
+        error_report("vfio-ccw: wirte I/O region failed with errno=%d",errno);
+        return -errno;
+    }
+
+    return region->ret_code;
+}
+
 static void vfio_ccw_reset(DeviceState *dev)
 {
     CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
@@ -59,10 +89,52 @@ static void vfio_ccw_reset(DeviceState *dev)
 static void vfio_ccw_io_notifier_handler(void *opaque)
 {
     VFIOCCWDevice *vcdev = opaque;
+    struct ccw_io_region *region = vcdev->io_region;
+    S390CCWDevice *cdev = S390_CCW_DEVICE(vcdev);
+    CcwDevice *ccw_dev = CCW_DEVICE(cdev);
+    SubchDev *sch = ccw_dev->sch;
+    SCSW *s = &sch->curr_status.scsw;
+    IRB irb;
 
     if (!event_notifier_test_and_clear(&vcdev->io_notifier)) {
         return;
     }
+
+    if (pread(vcdev->vdev.fd, region,
+              vcdev->io_region_size, vcdev->io_region_offset) == -1) {
+        switch (errno) {
+        case ENODEV:
+            /* Generate a deferred cc 3 condition. */
+            s->flags |= SCSW_FLAGS_MASK_CC;
+            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
+            s->ctrl |= (SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND);
+            goto read_err;
+        case EFAULT:
+            /* memory problem, generate channel data check */
+            s->ctrl &= ~SCSW_ACTL_START_PEND;
+            s->cstat = SCSW_CSTAT_DATA_CHECK;
+            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
+            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+            goto read_err;
+        default:
+            /* error, generate channel program check */
+            s->ctrl &= ~SCSW_ACTL_START_PEND;
+            s->cstat = SCSW_CSTAT_PROG_CHECK;
+            s->ctrl &= ~SCSW_CTRL_MASK_STCTL;
+            s->ctrl |= SCSW_STCTL_PRIMARY | SCSW_STCTL_SECONDARY |
+                    SCSW_STCTL_ALERT | SCSW_STCTL_STATUS_PEND;
+            goto read_err;
+        }
+    }
+
+    memcpy(&irb, region->irb_area, sizeof(IRB));
+
+    /* Update control block via irb. */
+    copy_scsw_to_guest(s, &irb.scsw);
+
+read_err:
+    css_inject_io_interrupt(sch);
 }
 
 static void vfio_ccw_register_io_notifier(VFIOCCWDevice *vcdev, Error **errp)
@@ -253,6 +325,7 @@ static void vfio_ccw_realize(DeviceState *dev, Error **errp)
     S390CCWDeviceClass *cdc = S390_CCW_DEVICE_GET_CLASS(cdev);
     char *path[4] = {NULL, NULL, NULL, NULL};
 
+    cdev->handle_request = vfio_ccw_handle_request;
     /* Call the class init function for subchannel. */
     if (cdc->realize) {
         cdc->realize(cdev, errp);
diff --git a/include/hw/s390x/css.h b/include/hw/s390x/css.h
index c92f624..2884439 100644
--- a/include/hw/s390x/css.h
+++ b/include/hw/s390x/css.h
@@ -134,6 +134,8 @@ void css_subch_assign(uint8_t cssid, uint8_t ssid, uint16_t schid,
 void css_sch_build_virtual_schib(SubchDev *sch, uint8_t chpid, uint8_t type);
 int css_sch_build_schib(SubchDev *sch, CssDevId *dev_id);
 uint16_t css_build_subchannel_id(SubchDev *sch);
+void copy_scsw_to_guest(SCSW *dest, const SCSW *src);
+void css_inject_io_interrupt(SubchDev *sch);
 void css_reset(void);
 void css_reset_sch(SubchDev *sch);
 void css_queue_crw(uint8_t rsc, uint8_t erc, int chain, uint16_t rsid);
-- 
2.8.4
