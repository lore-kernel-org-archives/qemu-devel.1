Received: from eggs.gnu.org ([209.51.188.92]:43812)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hC3SO-0007PM-Tm
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1hC3SN-0004W6-EV
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:35:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1hC3SN-0004TM-3O
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 10:35:07 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x34EQZnM005552
	for <qemu-devel@nongnu.org>; Thu, 4 Apr 2019 10:35:05 -0400
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2rnk2m2w8h-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 04 Apr 2019 10:35:04 -0400
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Thu, 4 Apr 2019 15:35:03 +0100
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Thu,  4 Apr 2019 10:34:30 -0400
In-Reply-To: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
References: <1554388475-18329-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1554388475-18329-12-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v6 11/16] s390-bios: Factor finding boot device
 out of virtio code path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

Make a new routine find_boot_device to locate the boot device for all
cases, not just virtio.

The error message for the case where no boot device has been specified
and a suitable boot device cannot be auto detected was specific to
virtio devices. We update this message to remove virtio specific wording.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 pc-bios/s390-ccw/main.c  | 85 ++++++++++++++++++++++++++----------------------
 tests/boot-serial-test.c |  2 +-
 2 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index d04ea89..d3a161c 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -58,17 +58,18 @@ unsigned int get_loadparm_index(void)
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
 
@@ -80,7 +81,7 @@ static bool find_dev(Schib *schib, int dev_no)
             continue;
         }
 
-        if ((dev_no < 0) || (schib->pmcw.dev == dev_no)) {
+        if ((dev_no < 0) || (schib.pmcw.dev == dev_no)) {
             return true;
         }
     }
@@ -136,56 +137,61 @@ static void boot_setup(void)
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
+    }
+
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
     }
 
-    IPL_assert(found, "No virtio device found");
+    IPL_assert(found, "Boot device not found\n");
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
@@ -195,8 +201,9 @@ int main(void)
     sclp_setup();
     css_setup();
     boot_setup();
-    virtio_setup();
+    find_boot_device();
 
+    virtio_setup();
     zipl_load(); /* no return */
 
     panic("Failed to load OS from hard disk\n");
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index c591748..24852d4 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -114,7 +114,7 @@ static testdef_t tests[] = {
     { "sparc", "SS-4", "", "MB86904" },
     { "sparc", "SS-600MP", "", "TMS390Z55" },
     { "sparc64", "sun4u", "", "UltraSPARC" },
-    { "s390x", "s390-ccw-virtio", "", "virtio device" },
+    { "s390x", "s390-ccw-virtio", "", "device" },
     { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf5208 },
     { "microblaze", "petalogix-s3adsp1800", "", "TT",
       sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
-- 
2.7.4
