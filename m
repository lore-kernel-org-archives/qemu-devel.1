Received: from eggs.gnu.org ([2001:4830:134:3::10]:47537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWI-00061Z-Vq
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f5YWF-0005Nj-TH
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 11:15:46 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Mon,  9 Apr 2018 17:15:27 +0200
Message-Id: <20180409151533.2253-3-cohuck@redhat.com>
In-Reply-To: <20180409151533.2253-1-cohuck@redhat.com>
References: <20180409151533.2253-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL for-2.12 2/8] s390: Refactor IPL parameter block
 generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Richard Henderson <rth@twiddle.net>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>

From: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>

Splitting out the the CCW device extraction allows reuse.

Signed-off-by: Viktor Mihajlovski <mihajlov@linux.vnet.ibm.com>
Message-Id: <1522940844-12336-2-git-send-email-mihajlov@linux.vnet.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c | 81 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 51 insertions(+), 30 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index fdeaec3a58..58e33c5446 100644
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
2.14.3
