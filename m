Received: from eggs.gnu.org ([209.51.188.92]:45410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1glXOh-0003Gc-QR
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:05:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1glXOg-0005Qf-3o
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 06:05:43 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon, 21 Jan 2019 12:05:08 +0100
Message-Id: <20190121110508.2320-3-cohuck@redhat.com>
In-Reply-To: <20190121110508.2320-1-cohuck@redhat.com>
References: <20190121110508.2320-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/2] vfio-ccw: support async command
 subregion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>, Pierre Morel <pmorel@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, Cornelia Huck <cohuck@redhat.com>

A vfio-ccw device may provide an async command subregion for
issuing halt/clear subchannel requests. If it is present, use
it for sending halt/clear request to the device; if not, fall
back to emulation (as done today).

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/css.c              |  27 +++++++--
 hw/vfio/ccw.c               | 109 +++++++++++++++++++++++++++++++++++-
 include/hw/s390x/s390-ccw.h |   3 +
 3 files changed, 133 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/css.c b/hw/s390x/css.c
index f92b046cd3..32e6980496 100644
--- a/hw/s390x/css.c
+++ b/hw/s390x/css.c
@@ -22,6 +22,7 @@
 #include "trace.h"
 #include "hw/s390x/s390_flic.h"
 #include "hw/s390x/s390-virtio-ccw.h"
+#include "hw/s390x/s390-ccw.h"
 
 typedef struct CrwContainer {
     CRW crw;
@@ -1194,6 +1195,26 @@ static void sch_handle_start_func_virtual(SubchDev *sch)
 
 }
 
+static void sch_handle_halt_func_passthrough(SubchDev *sch)
+{
+    int ret;
+
+    ret = vfio_ccw_handle_halt(sch);
+    if (ret == -ENOSYS) {
+        sch_handle_halt_func(sch);
+    }
+}
+
+static void sch_handle_clear_func_passthrough(SubchDev *sch)
+{
+    int ret;
+
+    ret = vfio_ccw_handle_clear(sch);
+    if (ret == -ENOSYS) {
+        sch_handle_clear_func(sch);
+    }
+}
+
 static IOInstEnding sch_handle_start_func_passthrough(SubchDev *sch)
 {
 
@@ -1237,11 +1258,9 @@ IOInstEnding do_subchannel_work_passthrough(SubchDev *sch)
     SCSW *s = &sch->curr_status.scsw;
 
     if (s->ctrl & SCSW_FCTL_CLEAR_FUNC) {
-        /* TODO: Clear handling */
-        sch_handle_clear_func(sch);
+        sch_handle_clear_func_passthrough(sch);
     } else if (s->ctrl & SCSW_FCTL_HALT_FUNC) {
-        /* TODO: Halt handling */
-        sch_handle_halt_func(sch);
+        sch_handle_halt_func_passthrough(sch);
     } else if (s->ctrl & SCSW_FCTL_START_FUNC) {
         return sch_handle_start_func_passthrough(sch);
     }
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index 9246729a75..633dbbce36 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -2,9 +2,12 @@
  * vfio based subchannel assignment support
  *
  * Copyright 2017 IBM Corp.
+ * Copyright 2019 Red Hat, Inc.
+ *
  * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
  *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
  *            Pierre Morel <pmorel@linux.vnet.ibm.com>
+ *            Cornelia Huck <cohuck@redhat.com>
  *
  * This work is licensed under the terms of the GNU GPL, version 2 or (at
  * your option) any later version. See the COPYING file in the top-level
@@ -32,6 +35,9 @@ typedef struct VFIOCCWDevice {
     uint64_t io_region_size;
     uint64_t io_region_offset;
     struct ccw_io_region *io_region;
+    uint64_t async_cmd_region_size;
+    uint64_t async_cmd_region_offset;
+    struct ccw_cmd_region *async_cmd_region;
     EventNotifier io_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
@@ -114,6 +120,87 @@ again:
     }
 }
 
+int vfio_ccw_handle_clear(SubchDev *sch)
+{
+    S390CCWDevice *cdev = sch->driver_data;
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    struct ccw_cmd_region *region = vcdev->async_cmd_region;
+    int ret;
+
+    if (!vcdev->async_cmd_region) {
+        /* Async command region not available, fall back to emulation */
+        return -ENOSYS;
+    }
+
+    memset(region, 0, sizeof(*region));
+    region->command = VFIO_CCW_ASYNC_CMD_CSCH;
+
+again:
+    ret = pwrite(vcdev->vdev.fd, region,
+                 vcdev->async_cmd_region_size, vcdev->async_cmd_region_offset);
+    if (ret != vcdev->async_cmd_region_size) {
+        if (errno == EAGAIN) {
+            goto again;
+        }
+        error_report("vfio-ccw: write cmd region failed with errno=%d", errno);
+        ret = -errno;
+    } else {
+        ret = region->ret_code;
+    }
+    switch (ret) {
+    case 0:
+    case -ENODEV:
+    case -EACCES:
+        return 0;
+    case -EFAULT:
+    default:
+        sch_gen_unit_exception(sch);
+        css_inject_io_interrupt(sch);
+        return 0;
+    }
+}
+
+int vfio_ccw_handle_halt(SubchDev *sch)
+{
+    S390CCWDevice *cdev = sch->driver_data;
+    VFIOCCWDevice *vcdev = DO_UPCAST(VFIOCCWDevice, cdev, cdev);
+    struct ccw_cmd_region *region = vcdev->async_cmd_region;
+    int ret;
+
+    if (!vcdev->async_cmd_region) {
+        /* Async command region not available, fall back to emulation */
+        return -ENOSYS;
+    }
+
+    memset(region, 0, sizeof(*region));
+    region->command = VFIO_CCW_ASYNC_CMD_HSCH;
+
+again:
+    ret = pwrite(vcdev->vdev.fd, region,
+                 vcdev->async_cmd_region_size, vcdev->async_cmd_region_offset);
+    if (ret != vcdev->async_cmd_region_size) {
+        if (errno == EAGAIN) {
+            goto again;
+        }
+        error_report("vfio-ccw: write cmd region failed with errno=%d", errno);
+        ret = -errno;
+    } else {
+        ret = region->ret_code;
+    }
+    switch (ret) {
+    case 0:
+    case -EBUSY:
+    case -ENODEV:
+    case -EACCES:
+        return 0;
+    case -EFAULT:
+    default:
+        sch_gen_unit_exception(sch);
+        css_inject_io_interrupt(sch);
+        return 0;
+    }
+}
+
 static void vfio_ccw_reset(DeviceState *dev)
 {
     CcwDevice *ccw_dev = DO_UPCAST(CcwDevice, parent_obj, dev);
@@ -285,9 +372,13 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
         return;
     }
 
+    /*
+     * We always expect at least the I/O region to be present. We also
+     * may have a variable number of regions governed by capabilities.
+     */
     if (vdev->num_regions < VFIO_CCW_CONFIG_REGION_INDEX + 1) {
-        error_setg(errp, "vfio: Unexpected number of the I/O region %u",
-                   vdev->num_regions);
+        error_setg(errp, "vfio: too few regions (%u), expected at least %u",
+                   vdev->num_regions, VFIO_CCW_CONFIG_REGION_INDEX + 1);
         return;
     }
 
@@ -307,6 +398,20 @@ static void vfio_ccw_get_region(VFIOCCWDevice *vcdev, Error **errp)
     vcdev->io_region_offset = info->offset;
     vcdev->io_region = g_malloc0(info->size);
 
+    /* check for the optional async command region */
+    ret = vfio_get_dev_region_info(vdev, VFIO_REGION_TYPE_CCW,
+                                   VFIO_REGION_SUBTYPE_CCW_ASYNC_CMD, &info);
+    if (!ret) {
+        vcdev->async_cmd_region_size = info->size;
+        if (sizeof(*vcdev->async_cmd_region) != vcdev->async_cmd_region_size) {
+            error_setg(errp, "vfio: Unexpected size of the async cmd region");
+            g_free(info);
+            return;
+        }
+        vcdev->async_cmd_region_offset = info->offset;
+        vcdev->async_cmd_region = g_malloc0(info->size);
+    }
+
     g_free(info);
 }
 
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 7d15a1a5d4..38d54a7a69 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -36,4 +36,7 @@ typedef struct S390CCWDeviceClass {
     IOInstEnding (*handle_request) (SubchDev *sch);
 } S390CCWDeviceClass;
 
+int vfio_ccw_handle_clear(SubchDev *sch);
+int vfio_ccw_handle_halt(SubchDev *sch);
+
 #endif
-- 
2.17.2
