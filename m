Received: from eggs.gnu.org ([2001:4830:134:3::10]:48498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb80z-00008f-JF
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:25:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1fb80y-0001JA-AD
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:25:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51584)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1fb80y-0001HS-20
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 13:25:56 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w65HNgjI046712
	for <qemu-devel@nongnu.org>; Thu, 5 Jul 2018 13:25:55 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2k1pqxtfa1-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Jul 2018 13:25:54 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 5 Jul 2018 13:25:53 -0400
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  5 Jul 2018 13:25:33 -0400
In-Reply-To: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
References: <1530811543-6881-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1530811543-6881-6-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [RFC 05/15] s390-bios: Factor finding boot device out
 of virtio code path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Make a new routine find_boot_device to locate the boot device for all
cases. not just virtio.

In one case no boot device is specified and a suitable boot device can not
be auto detected. The error message for this case was specific to virtio
devices. We update this message to remove virtio specific wording.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c | 87 +++++++++++++++++++++++++++----------------------
 1 file changed, 48 insertions(+), 39 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 30f847f..25e6124 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -55,17 +55,18 @@ unsigned int get_loadparm_index(void)
  * NOTE: The global variable blk_schid is updated to contain the subchannel
  * information.
  */
-static bool find_dev(Schib *schib, int dev_no)
+static bool find_subch(int dev_no)
 {
+    Schib schib;
     int i, r;
 
     for (i = 0; i < 0x10000; i++) {
         blk_schid.sch_no = i;
-        r = stsch_err(blk_schid, schib);
+        r = stsch_err(blk_schid, &schib);
         if ((r == 3) || (r == -EIO)) {
             break;
         }
-        if (!schib->pmcw.dnv) {
+        if (!schib.pmcw.dnv) {
             continue;
         }
 
@@ -77,7 +78,7 @@ static bool find_dev(Schib *schib, int dev_no)
             continue;
         }
 
-        if ((dev_no < 0) || (schib->pmcw.dev == dev_no)) {
+        if ((dev_no < 0) || (schib.pmcw.dev == dev_no)) {
             return true;
         }
     }
@@ -133,56 +134,63 @@ static void boot_setup(void)
     have_iplb = store_iplb(&iplb);
 }
 
-static void virtio_setup(void)
+static void find_boot_device(void)
 {
-    Schib schib;
-    int ssid;
-    bool found = false;
-    uint16_t dev_no;
     VDev *vdev = virtio_get_device();
-    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
-
-    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
+    int ssid;
+    bool found;
 
-    if (have_iplb) {
-        switch (iplb.pbt) {
-        case S390_IPL_TYPE_CCW:
-            dev_no = iplb.ccw.devno;
-            debug_print_int("device no. ", dev_no);
-            blk_schid.ssid = iplb.ccw.ssid & 0x3;
-            debug_print_int("ssid ", blk_schid.ssid);
-            found = find_dev(&schib, dev_no);
-            break;
-        case S390_IPL_TYPE_QEMU_SCSI:
-            vdev->scsi_device_selected = true;
-            vdev->selected_scsi_device.channel = iplb.scsi.channel;
-            vdev->selected_scsi_device.target = iplb.scsi.target;
-            vdev->selected_scsi_device.lun = iplb.scsi.lun;
-            blk_schid.ssid = iplb.scsi.ssid & 0x3;
-            found = find_dev(&schib, iplb.scsi.devno);
-            break;
-        default:
-            panic("List-directed IPL not supported yet!\n");
-        }
-        menu_setup();
-    } else {
+    if (!have_iplb) {
         for (ssid = 0; ssid < 0x3; ssid++) {
             blk_schid.ssid = ssid;
-            found = find_dev(&schib, -1);
+            found = find_subch(-1);
             if (found) {
-                break;
+                return;
             }
         }
+        panic("Could not find a suitable boot device (none specified)\n");
     }
 
-    IPL_assert(found, "No virtio device found");
+    switch (iplb.pbt) {
+    case S390_IPL_TYPE_CCW:
+        debug_print_int("device no. ", iplb.ccw.devno);
+        blk_schid.ssid = iplb.ccw.ssid & 0x3;
+        debug_print_int("ssid ", blk_schid.ssid);
+        found = find_subch(iplb.ccw.devno);
+        break;
+    case S390_IPL_TYPE_QEMU_SCSI:
+        vdev->scsi_device_selected = true;
+        vdev->selected_scsi_device.channel = iplb.scsi.channel;
+        vdev->selected_scsi_device.target = iplb.scsi.target;
+        vdev->selected_scsi_device.lun = iplb.scsi.lun;
+        blk_schid.ssid = iplb.scsi.ssid & 0x3;
+        found = find_subch(iplb.scsi.devno);
+        break;
+    default:
+        panic("List-directed IPL not supported yet!\n");
+    }
+
+    if (!found) {
+        IPL_assert(found, "Boot device not found\n");
+    }
+}
+
+static void virtio_setup(void)
+{
+    VDev *vdev = virtio_get_device();
+    QemuIplParameters *early_qipl = (QemuIplParameters *)QIPL_ADDRESS;
+
+    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
+
+    if (have_iplb) {
+        menu_setup();
+    }
 
     if (virtio_get_device_type() == VIRTIO_ID_NET) {
         sclp_print("Network boot device detected\n");
         vdev->netboot_start_addr = qipl.netboot_start_addr;
     } else {
         virtio_blk_setup_device(blk_schid);
-
         IPL_assert(virtio_ipl_disk_is_valid(), "No valid IPL device detected");
     }
 }
@@ -192,8 +200,9 @@ int main(void)
     sclp_setup();
     cio_setup();
     boot_setup();
-    virtio_setup();
+    find_boot_device();
 
+    virtio_setup();
     zipl_load(); /* no return */
 
     panic("Failed to load OS from hard disk\n");
-- 
2.7.4
