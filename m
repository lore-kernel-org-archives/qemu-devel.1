Received: from eggs.gnu.org ([2001:4830:134:3::10]:60600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gX5Ep-0003Uy-M1
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:11:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1gX5Eh-0007B2-DR
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:11:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57322)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1gX5Ef-00077M-CU
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 09:11:39 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBCE9j7V128618
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 09:11:34 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2pb2upbajc-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 09:11:33 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Wed, 12 Dec 2018 14:11:33 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Wed, 12 Dec 2018 09:11:08 -0500
In-Reply-To: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
References: <1544623878-11248-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1544623878-11248-6-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH 05/15] s390-bios: Factor finding boot device
 out of virtio code path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, pasic@linux.ibm.com, bjsdjshi@linux.ibm.com, borntraeger@de.ibm.com

Make a new routine find_boot_device to locate the boot device for all
cases. not just virtio.

In one case no boot device is specified and a suitable boot device can not
be auto detected. The error message for this case was specific to virtio
devices. We update this message to remove virtio specific wording.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c  | 87 ++++++++++++++++++++++++++----------------------
 tests/boot-serial-test.c |  2 +-
 2 files changed, 49 insertions(+), 40 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index 7e3f65e..2457752 100644
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
     css_setup();
     boot_setup();
-    virtio_setup();
+    find_boot_device();
 
+    virtio_setup();
     zipl_load(); /* no return */
 
     panic("Failed to load OS from hard disk\n");
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index 8ec6aed..064f5de 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -112,7 +112,7 @@ static testdef_t tests[] = {
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
