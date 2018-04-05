Received: from eggs.gnu.org ([2001:4830:134:3::10]:56409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1f46UE-0001R6-LM
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mihajlov@de.ibm.com>) id 1f46U8-0007we-IO
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:38 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57794
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mihajlov@de.ibm.com>) id 1f46U8-0007vl-Cl
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 11:07:32 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w35F3JdT144709
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 11:07:31 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2h5nuu9b8m-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 11:07:31 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mihajlov@de.ibm.com>;
	Thu, 5 Apr 2018 16:07:28 +0100
From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Date: Thu,  5 Apr 2018 17:07:22 +0200
In-Reply-To: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
References: <1522940844-12336-1-git-send-email-mihajlov@linux.vnet.ibm.com>
Message-Id: <1522940844-12336-2-git-send-email-mihajlov@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 1/3] s390: Refactor IPL parameter block
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: cohuck@redhat.com, borntraeger@de.ibm.com, agraf@suse.de, rth@twiddle.net, david@redhat.com, thuth@redhat.com, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org

Splitting out the the CCW device extraction allows reuse.

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
---
 hw/s390x/ipl.c | 81 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index fdeaec3..58e33c5 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -279,44 +279,52 @@ static void s390_ipl_set_boot_menu(S390IPLState *ipl)
     *timeout = cpu_to_be32(splash_time);
 }
 
+static CcwDevice *s390_get_ccw_device(DeviceState *dev_st)
+{
+    CcwDevice *ccw_dev = NULL;
+
+    if (dev_st) {
+        VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
+            object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
+                                TYPE_VIRTIO_CCW_DEVICE);
+        if (virtio_ccw_dev) {
+            ccw_dev = CCW_DEVICE(virtio_ccw_dev);
+        } else {
+            SCSIDevice *sd = (SCSIDevice *)
+                object_dynamic_cast(OBJECT(dev_st),
+                                    TYPE_SCSI_DEVICE);
+            if (sd) {
+                SCSIBus *bus = scsi_bus_from_device(sd);
+                VirtIOSCSI *vdev = container_of(bus, VirtIOSCSI, bus);
+                VirtIOSCSICcw *scsi_ccw = container_of(vdev, VirtIOSCSICcw,
+                                                       vdev);
+
+                ccw_dev = (CcwDevice *)object_dynamic_cast(OBJECT(scsi_ccw),
+                                                           TYPE_CCW_DEVICE);
+            }
+        }
+    }
+    return ccw_dev;
+}
+
 static bool s390_gen_initial_iplb(S390IPLState *ipl)
 {
     DeviceState *dev_st;
+    CcwDevice *ccw_dev = NULL;
 
     dev_st = get_boot_device(0);
     if (dev_st) {
-        VirtioCcwDevice *virtio_ccw_dev = (VirtioCcwDevice *)
-            object_dynamic_cast(OBJECT(qdev_get_parent_bus(dev_st)->parent),
-                TYPE_VIRTIO_CCW_DEVICE);
+        ccw_dev = s390_get_ccw_device(dev_st);
+    }
+
+    /*
+     * Currently allow IPL only from CCW devices.
+     */
+    if (ccw_dev) {
         SCSIDevice *sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
                                                             TYPE_SCSI_DEVICE);
-        VirtIONet *vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
-                                                          TYPE_VIRTIO_NET);
-
-        if (vn) {
-            ipl->netboot = true;
-        }
-        if (virtio_ccw_dev) {
-            CcwDevice *ccw_dev = CCW_DEVICE(virtio_ccw_dev);
-
-            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
-            ipl->iplb.blk0_len =
-                cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
-            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
-            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
-            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
-        } else if (sd) {
-            SCSIBus *bus = scsi_bus_from_device(sd);
-            VirtIOSCSI *vdev = container_of(bus, VirtIOSCSI, bus);
-            VirtIOSCSICcw *scsi_ccw = container_of(vdev, VirtIOSCSICcw, vdev);
-            CcwDevice *ccw_dev;
-
-            ccw_dev = (CcwDevice *)object_dynamic_cast(OBJECT(scsi_ccw),
-                                                       TYPE_CCW_DEVICE);
-            if (!ccw_dev) {       /* It might be a PCI device instead */
-                return false;
-            }
 
+        if (sd) {
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
             ipl->iplb.blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
@@ -327,12 +335,25 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
             ipl->iplb.scsi.devno = cpu_to_be16(ccw_dev->sch->devno);
             ipl->iplb.scsi.ssid = ccw_dev->sch->ssid & 3;
         } else {
-            return false; /* unknown device */
+            VirtIONet *vn = (VirtIONet *) object_dynamic_cast(OBJECT(dev_st),
+                                                              TYPE_VIRTIO_NET);
+
+            ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_CCW_LEN);
+            ipl->iplb.blk0_len =
+                cpu_to_be32(S390_IPLB_MIN_CCW_LEN - S390_IPLB_HEADER_LEN);
+            ipl->iplb.pbt = S390_IPL_TYPE_CCW;
+            ipl->iplb.ccw.devno = cpu_to_be16(ccw_dev->sch->devno);
+            ipl->iplb.ccw.ssid = ccw_dev->sch->ssid & 3;
+
+            if (vn) {
+                ipl->netboot = true;
+            }
         }
 
         if (!s390_ipl_set_loadparm(ipl->iplb.loadparm)) {
             ipl->iplb.flags |= DIAG308_FLAGS_LP_VALID;
         }
+
         return true;
     }
 
-- 
1.9.1
