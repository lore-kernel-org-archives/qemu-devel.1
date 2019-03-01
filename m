Received: from eggs.gnu.org ([209.51.188.92]:51480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gznOK-0006OU-DA
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:00:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gznO1-0003pz-Fk
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:00:01 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gznNu-0003bj-Ai
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 13:59:53 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x21IxjHY065873
	for <qemu-devel@nongnu.org>; Fri, 1 Mar 2019 13:59:49 -0500
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qy7uh77qg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 01 Mar 2019 13:59:47 -0500
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Fri, 1 Mar 2019 18:59:43 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Fri,  1 Mar 2019 13:59:21 -0500
In-Reply-To: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
References: <1551466776-29123-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1551466776-29123-2-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v3 01/16] s390 vfio-ccw: Add bootindex property
 and IPLB data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Add bootindex property and iplb data for vfio-ccw devices. This allows us to
forward boot information into the bios for vfio-ccw devices.

Refactor s390_get_ccw_device() to return device type. This prevents us from
having to use messy casting logic in several places.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.vnet.ibm.com>
---
 MAINTAINERS                 |  1 +
 hw/s390x/ipl.c              | 39 +++++++++++++++++++++++++++++++++------
 hw/s390x/s390-ccw.c         |  9 +++++++++
 hw/vfio/ccw.c               |  2 +-
 include/hw/s390x/s390-ccw.h |  1 +
 include/hw/s390x/vfio-ccw.h | 28 ++++++++++++++++++++++++++++
 6 files changed, 73 insertions(+), 7 deletions(-)
 create mode 100644 include/hw/s390x/vfio-ccw.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a76845..a780916 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1400,6 +1400,7 @@ S: Supported
 F: hw/vfio/ccw.c
 F: hw/s390x/s390-ccw.c
 F: include/hw/s390x/s390-ccw.h
+F: include/hw/s390x/vfio-ccw.h
 T: git https://github.com/cohuck/qemu.git s390-next
 L: qemu-s390x@nongnu.org
 
diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 896888b..df891bb 100644
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
@@ -305,16 +306,29 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     *timeout = cpu_to_be32(splash_time);
 }
 
-static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
+#define CCW_DEVTYPE_NONE    0x00
+#define CCW_DEVTYPE_VIRTIO  0x01
+#define CCW_DEVTYPE_SCSI    0x02
+#define CCW_DEVTYPE_VFIO    0x03
+
+static CcwDevice *s390_get_ccw_device(DeviceState *dev_st, int* devtype)
 {
     CcwDevice *ccw_dev = NULL;
 
+    *devtype = CCW_DEVTYPE_NONE;
+
     if (dev_st) {
         VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
             object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
                                 TYPE_VIRTIO_CCW_DEVICE);
+        VFIOCCWDevice *vfio_ccw_dev = (VFIOCCWDevice *)
+            object_dynamic_cast(OBJECT(dev_st), TYPE_VFIO_CCW);
         if (virtio_ccw_dev) {
             ccw_dev = CCW_DEVICE(virtio_ccw_dev);
+            *devtype = CCW_DEVTYPE_VIRTIO;
+        } else if (vfio_ccw_dev) {
+            ccw_dev = CCW_DEVICE(vfio_ccw_dev);
+            *devtype = CCW_DEVTYPE_VFIO;
         } else {
             SCSIDevice *sd = (SCSIDevice *)
                 object_dynamic_cast(OBJECT(dev_st),
@@ -327,6 +341,7 @@ static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
 
                 ccw_dev = (CcwDevice *)object_dynamic_cast(OBJECT(scsi_ccw),
                                                            TYPE_CCW_DEVICE);
+                *devtype = CCW_DEVTYPE_SCSI;
             }
         }
     }
@@ -337,10 +352,11 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
 {
     DeviceState *dev_st;
     CcwDevice *ccw_dev = NULL;
+    int devtype;
 
     dev_st = get_boot_device(0);
     if (dev_st) {
-        ccw_dev = s390_get_ccw_device(dev_st);
+        ccw_dev = s390_get_ccw_device(dev_st, &devtype);
     }
 
     /*
@@ -349,8 +365,10 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
     if (ccw_dev) {
         SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
                                                             TYPE_SCSI_DEVICE);
+        VirtIONet *vn;
 
-        if (sd) {
+        switch (devtype) {
+        case CCW_DEVTYPE_SCSI:
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
             ipl->iplb.blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
@@ -360,8 +378,15 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             ipl->iplb.scsi.channel = cpu_to_be16(sd->channel);
             ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
-        } else {
-            VirtIONet *vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
+            break;
+        case CCW_DEVTYPE_VFIO:
+            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
+            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
+            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
+            break;
+        case CCW_DEVTYPE_VIRTIO:
+            vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
                                                               TYPE_VIRTIO_NET);
 
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
@@ -374,6 +399,7 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             if (vn) {
                 ipl->netboot = true;
             }
+            break;
         }
 
         if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
@@ -518,6 +544,7 @@ IplParameterBlock *s390_ipl_get_iplb(void)
 void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
 {
     S390IPLState *ipl = get_ipl_device();
+    int devtype;
 
     if (reset_type == S390_RESET_EXTERNAL || reset_type == S390_RESET_REIPL) {
         /* use CPU 0 for full resets */
@@ -532,7 +559,7 @@ void s390_ipl_reset_request(CPUState *cs, enum s390_reset reset_type)
         !ipl->netboot &&
         ipl->iplb.pbt == S390_IPL_TYPE_CCW &&
         is_virtio_scsi_device(&ipl->iplb)) {
-        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0));
+        CcwDevice *ccw_dev = s390_get_ccw_device(get_boot_device(0), &devtype);
 
         if (ccw_dev &&
             cpu_to_be16(ccw_dev->sch->devno) == ipl->iplb.ccw.devno &&
diff --git a/hw/s390x/s390-ccw.c b/hw/s390x/s390-ccw.c
index cad91ee..f5f025d 100644
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
index 9246729..507d513 100644
--- a/hw/vfio/ccw.c
+++ b/hw/vfio/ccw.c
@@ -21,11 +21,11 @@
 #include "hw/vfio/vfio.h"
 #include "hw/vfio/vfio-common.h"
 #include "hw/s390x/s390-ccw.h"
+#include "hw/s390x/vfio-ccw.h"
 #include "hw/s390x/ccw-device.h"
 #include "exec/address-spaces.h"
 #include "qemu/error-report.h"
 
-#define TYPE_VFIO_CCW "vfio-ccw"
 typedef struct VFIOCCWDevice {
     S390CCWDevice cdev;
     VFIODevice vdev;
diff --git a/include/hw/s390x/s390-ccw.h b/include/hw/s390x/s390-ccw.h
index 7d15a1a..901d805 100644
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
index 0000000..2fceaa2
--- /dev/null
+++ b/include/hw/s390x/vfio-ccw.h
@@ -0,0 +1,28 @@
+/*
+ * vfio based subchannel assignment support
+ *
+ * Copyright 2017 IBM Corp.
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
2.7.4
