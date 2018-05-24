Received: from eggs.gnu.org ([2001:4830:134:3::10]:59828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLuVs-00074z-OL
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:59:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pasic@linux.ibm.com>) id 1fLuVn-0006fL-Oa
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:58:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41442
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pasic@linux.ibm.com>) id 1fLuVn-0006er-J3
	for qemu-devel@nongnu.org; Thu, 24 May 2018 13:58:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w4OHruEv126863
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 13:58:50 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2j60t9m67g-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 May 2018 13:58:50 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <pasic@linux.ibm.com>;
	Thu, 24 May 2018 18:58:49 +0100
From: Halil Pasic <pasic@linux.ibm.com>
Date: Thu, 24 May 2018 19:58:27 +0200
In-Reply-To: <20180524175828.3143-1-pasic@linux.ibm.com>
References: <20180524175828.3143-1-pasic@linux.ibm.com>
Message-Id: <20180524175828.3143-2-pasic@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/2] vfio-ccw: add force unlimited prefetch
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

There is at least one guest (OS) such that although it does not rely on
the guarantees provided by ORB 1 word 9 bit (aka unlimited prefetch, aka
P bit) not being set, it fails to tell this to the machine.

Usually this ain't a big deal, as the original purpose of the P bit is to
allow for performance optimizations. vfio-ccw however can not provide the
guarantees required if the bit is not set.

It is not possible to implement support for the P bit not set without
transitioning to lower level protocols for vfio-ccw.  So let's give the
user the opportunity to force setting the P bit, if the user knows this
is safe.  For self modifying channel programs forcing the P bit is not
safe.  If the P bit is forced for a self modifying channel program things
are expected to break in strange ways.

Let's also avoid warning multiple about P bit not set in the ORB in case
P bit is not told to be forced, and designate the affected vfio-ccw
device.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Suggested-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Acked-by: Jason J. Herne <jjherne@linux.ibm.com>
Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
---

@Jason:
I have kept the tags this time without consulting you because
all that changed is the logging. Scream if that's not OK with you.

v2->v3:
* tweak commit message (Connie)
* designate subsystem (vfio-ccw) and devno in the log messages (Connie)
* turn WARN_ONCE macro into inline function

---
 hw/s390x/css.c |  3 +--
 hw/vfio/ccw.c  | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index 56c3fa8c89..39ae5bbf7e 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -1204,8 +1204,7 @@ static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
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
index e67392c5f9..ebf471a310 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -32,8 +32,30 @@ typedef struct VFIOCCWDevice {
     uint64_t io_region_offset;
     struct ccw_io_region *io_region;
     EventNotifier io_notifier;
+    bool force_orb_pfch;
+    bool warned_orb_pfch;
 } VFIOCCWDevice;
 
+static inline void warn_once(bool *warned, const char *fmt, ...)
+{
+    va_list ap;
+
+    if (!warned || *warned) {
+        return;
+    }
+    *warned = true;
+    va_start(ap, fmt);
+    warn_vreport(fmt, ap);
+    va_end(ap);
+}
+
+static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchDev *sch,
+                                  const char *msg)
+{
+    warn_once(&vcdev->warned_orb_pfch, "vfio-ccw (devno %x.%x.%04x): %s",
+              sch->cssid, sch->ssid, sch->devno, msg);
+}
+
 static void vfio_ccw_compute_needs_reset(VFIODevice *vdev)
 {
     vdev->needs_reset = false;
@@ -54,6 +76,18 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
     struct ccw_io_region *region = vcdev->io_region;
     int ret;
 
+    if (!(sch->orb.ctrl0 & ORB_CTRL0_MASK_PFCH)) {
+        if (!(vcdev->force_orb_pfch)) {
+            warn_once_pfch(vcdev, sch, "requires PFCH flag set");
+            sch_gen_unit_exception(sch);
+            css_inject_io_interrupt(sch);
+            return IOINST_CC_EXPECTED;
+        } else {
+            sch->orb.ctrl0 |= ORB_CTRL0_MASK_PFCH;
+            warn_once_pfch(vcdev, sch, "PFCH flag forced");
+        }
+    }
+
     QEMU_BUILD_BUG_ON(sizeof(region->orb_area) != sizeof(ORB));
     QEMU_BUILD_BUG_ON(sizeof(region->scsw_area) != sizeof(SCSW));
     QEMU_BUILD_BUG_ON(sizeof(region->irb_area) != sizeof(IRB));
@@ -429,6 +463,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
 
 static Property vfio_ccw_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
+    DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.16.3
