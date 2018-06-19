Received: from eggs.gnu.org ([2001:4830:134:3::10]:41791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNT-00077Y-33
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fVFNN-0001lz-48
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 08:04:51 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 19 Jun 2018 14:04:24 +0200
Message-Id: <20180619120434.25062-3-cohuck@redhat.com>
In-Reply-To: <20180619120434.25062-1-cohuck@redhat.com>
References: <20180619120434.25062-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 02/12] vfio-ccw: add force unlimited prefetch
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Halil Pasic <pasic@linux.ibm.com>

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
Message-Id: <20180524175828.3143-2-pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
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
index 76e4e8c652..351b305e1a 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -33,8 +33,30 @@ typedef struct VFIOCCWDevice {
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
@@ -55,6 +77,18 @@ static IOInstEnding vfio_ccw_handle_request(SubchDev *sch)
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
@@ -430,6 +464,7 @@ static void vfio_ccw_unrealize(DeviceState *dev, Error **errp)
 
 static Property vfio_ccw_properties[] = {
     DEFINE_PROP_STRING("sysfsdev", VFIOCCWDevice, vdev.sysfsdev),
+    DEFINE_PROP_BOOL("force-orb-pfch", VFIOCCWDevice, force_orb_pfch, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.14.4
