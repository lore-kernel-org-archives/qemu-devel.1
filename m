Received: from eggs.gnu.org ([209.51.188.92]:58269)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJp-00034V-84
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeJn-0003Zp-N7
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:21:41 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 25 Apr 2019 15:21:16 +0200
Message-Id: <20190425132134.2839-2-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 01/19] s390 vfio-ccw: Add bootindex property and
 IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, "Jason J. Herne" <jjherne@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

From: "Jason J. Herne" <jjherne@linux.ibm.com>

Add bootindex property and iplb data for vfio-ccw devices. This allows us to
forward boot information into the bios for vfio-ccw devices.

Refactor s390_get_ccw_device() to return device type. This prevents us from
having to use messy casting logic in several places.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1554388475-18329-2-git-send-email-jjherne@linux.ibm.com>
[thuth: fixed "typedef struct VFIOCCWDevice" build failure with clang]
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 MAINTAINERS                 |  1 +
 hw/s390x/ipl.c              | 61 ++++++++++++++++++++++++++++---------
 hw/s390x/s390-ccw.c         |  9 ++++++
 hw/vfio/ccw.c               |  6 ++--
 include/hw/s390x/s390-ccw.h |  1 +
 include/hw/s390x/vfio-ccw.h | 28 +++++++++++++++++
 6 files changed, 88 insertions(+), 18 deletions(-)
 create mode 100644 include/hw/s390x/vfio-ccw.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 56139ac8ab05..f7976aa43d0a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1445,6 +1445,7 @@ S: Supported
 F: hw/vfio/ccw.c
 F: hw/s390x/s390-ccw.c
 F: include/hw/s390x/s390-ccw.h
+F: include/hw/s390x/vfio-ccw.h
 T: git https://github.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 51b272e190a9..d0cc06a05fd0 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -19,6 +19,7 @@
 #include "hw/loader.h"
 #include "hw/boards.h"
 #include "hw/s390x/virtio-ccw.h"
+#include "hw/s390x/vfio-ccw.h"
 #include "hw/s390x/css.h"
 #include "hw/s390x/ebcdic.h"
 #include "ipl.h"
@@ -303,16 +304,36 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     ipl->qipl.boot_menu_timeout = cpu_to_be32(splash_time);
 }
 
-static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
+#define CCW_DEVTYPE_NONE        0x00
+#define CCW_DEVTYPE_VIRTIO      0x01
+#define CCW_DEVTYPE_VIRTIO_NET  0x02
+#define CCW_DEVTYPE_SCSI        0x03
+#define CCW_DEVTYPE_VFIO        0x04
+
+static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int *devtype)
 {
     CcwDevice *ccw_dev = NULL;
+    int tmp_dt = CCW_DEVTYPE_NONE;
 
     if (dev_st) {
+        VirtIONet *virtio_net_dev = (VirtIONet *)
+            object_dynamic_cast(OBJECT(dev_st), TYPE_VIRTIO_NET);
         VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
             object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
                                 TYPE_VIRTIO_CCW_DEVICE);
+        VFIOCCWDevice *vfio_ccw_dev = (VFIOCCWDevice *)
+            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
+
         if (virtio_ccw_dev) {
             ccw_dev = CCW_DEVICE(virtio_ccw_dev);
+            if (virtio_net_dev) {
+                tmp_dt = CCW_DEVTYPE_VIRTIO_NET;
+            } else {
+                tmp_dt = CCW_DEVTYPE_VIRTIO;
+            }
+        } else if (vfio_ccw_dev) {
+            ccw_dev = CCW_DEVICE(vfio_ccw_dev);
+            tmp_dt = CCW_DEVTYPE_VFIO;
         } else {
             SCSIDevice *sd = (SCSIDevice *)
                 object_dynamic_cast(OBJECT(dev_st),
@@ -325,9 +346,13 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
 
                 ccw_dev = (CcwDevice *)object_dynamic_cast(OBJECT(scsi_ccw),
                                                            TYPE_CCW_DEVICE);
+                tmp_dt = CCW_DEVTYPE_SCSI;
             }
         }
     }
+    if (devtype) {
+        *devtype = tmp_dt;
+    }
     return ccw_dev;
 }
 
@@ -335,20 +360,22 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
 {
     DeviceState *dev_st;
     CcwDevice *ccw_dev = NULL;
+    SCSIDevice *sd;
+    int devtype;
 
     dev_st = get_boot_device(0);
     if (dev_st) {
-        ccw_dev = s390_get_ccw_device(dev_st);
+        ccw_dev = s390_get_ccw_device(dev_st, &devtype);
     }
 
     /*
      * Currently allow IPL only from CCW devices.
      */
     if (ccw_dev) {
-        SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
-                                                            TYPE_SCSI_DEVICE);
-
-        if (sd) {
+        switch (devtype) {
+        case CCW_DEVTYPE_SCSI:
+            sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
+                                                           TYPE_SCSI_DEVICE);
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
             ipl->iplb.blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
@@ -358,20 +385,24 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
             ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
-        } else {
-            VirtIONet *vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
-                                                              TYPE_VIRTIO_NET);
-
+            break;
+        case CCW_DEVTYPE_VFIO:
+            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
+            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
+            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
+            break;
+        case CCW_DEVTYPE_VIRTIO_NET:
+            ipl->netboot = true;
+            /* Fall through to CCW_DEVTYPE_VIRTIO case */
+        case CCW_DEVTYPE_VIRTIO:
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
             ipl->iplb.blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
             ipl->iplb.pbt = S390_IPL_TYPE_CCW;
             ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
-
-            if (vn) {
-                ipl->netboot = true;
-            }
+            break;
         }
 
         if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
@@ -530,7 +561,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
         !ipl->netboot &&
         ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
         is_virtio_scsi_device(&ipl->iplb)) {
-        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0));
+        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0), NULL);
 
         if (ccw_dev &&
             cpu_to_be16(ccw_dev->sch->devno) == ipl->iplb.ccw.devno &&
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index cad91ee62679..f5f025d1b6ca 100644
--- a/hw/s390x/s390-ccw.c
+++ b/hw/s390x/s390-ccw.c
@@ -124,6 +124,14 @@ static void s390_ccw_unrealize(S390CCWDevice *cdev, Error **errp)
     g_free(cdev->mdevid);
 }
 
+static void s390_ccw_instance_init(Object *obj)
+{
+    S390CCWDevice *dev = S390_CCW_DEVICE(obj);
+
+    device_add_bootindex_property(obj, &dev->bootindex, "bootindex",
+                                  "/disk@0,0", DEVICE(obj), NULL);
+}
+
 static void s390_ccw_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -137,6 +145,7 @@ static void s390_ccw_class_init(ObjectClass *klass, void *data)
 static const TypeInfo s390_ccw_info = {
     .name          = TYPE_S390_CCW,
     .parent        = TYPE_CCW_DEVICE,
+    .instance_init = s390_ccw_instance_init,
     .instance_size = sizeof(S390CCWDevice),
     .class_size    = sizeof(S390CCWDeviceClass),
     .class_init    = s390_ccw_class_init,
diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
index c44d13cc5081..31dd3a2a87b6 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -21,12 +21,12 @@
 #include "hw/vfio/vfio.h"
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/s390-ccw.h"
+#include "hw/s390x/vfio-ccw.h"
 #include "hw/s390x/ccw-device.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 
-#define TYPE_VFIO_CCW "vfio-ccw"
-typedef struct VFIOCCWDevice {
+struct VFIOCCWDevice {
     S390CCWDevice cdev;
     VFIODevice vdev;
     uint64_t io_region_size;
@@ -35,7 +35,7 @@ typedef struct VFIOCCWDevice {
     EventNotifier io_notifier;
     bool force_orb_pfch;
     bool warned_orb_pfch;
-} VFIOCCWDevice;
+};
 
 static inline void warn_once_pfch(VFIOCCWDevice *vcdev, SubchDev *sch,
                                   const char *msg)
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 7d15a1a5d41d..901d805d79a3 100644
--- a/include/hw/s390x/s390-ccw.h
+++ b/include/hw/s390x/s390-ccw.h
@@ -27,6 +27,7 @@ typedef struct S390CCWDevice {
     CcwDevice parent_obj;
     CssDevId hostid;
     char *mdevid;
+    int32_t bootindex;
 } S390CCWDevice;
 
 typedef struct S390CCWDeviceClass {
diff --git a/include/hw/s390x/vfio-ccw.h b/include/hw/s390x/vfio-ccw.h
new file mode 100644
index 000000000000..ee5250d0d788
--- /dev/null
+++ b/include/hw/s390x/vfio-ccw.h
@@ -0,0 +1,28 @@
+/*
+ * vfio based subchannel assignment support
+ *
+ * Copyright 2017, 2019 IBM Corp.
+ * Author(s): Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
+ *            Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>
+ *            Pierre Morel <pmorel@linux.vnet.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#ifndef HW_VFIO_CCW_H
+#define HW_VFIO_CCW_H
+
+#include "hw/vfio/vfio-common.h"
+#include "hw/s390x/s390-ccw.h"
+#include "hw/s390x/ccw-device.h"
+
+#define TYPE_VFIO_CCW "vfio-ccw"
+#define VFIO_CCW(obj) \
+        OBJECT_CHECK(VFIOCCWDevice, (obj), TYPE_VFIO_CCW)
+
+#define TYPE_VFIO_CCW "vfio-ccw"
+typedef struct VFIOCCWDevice VFIOCCWDevice;
+
+#endif
-- 
2.17.2
