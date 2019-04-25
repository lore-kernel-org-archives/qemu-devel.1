Received: from eggs.gnu.org ([209.51.188.92]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKB-0003U0-LP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKA-0003oU-Dp
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:03 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu, 25 Apr 2019 15:21:26 +0200
Message-Id: <20190425132134.2839-12-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 11/19] s390-bios: Factor finding boot device out
 of virtio code path
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

Make a new routine find_boot_device to locate the boot device for all
cases, not just virtio.

The error message for the case where no boot device has been specified
and a suitable boot device cannot be auto detected was specific to
virtio devices. We update this message to remove virtio specific wording.

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
Reviewed-by: Farhan Ali <alifm@linux.ibm.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Message-Id: <1554388475-18329-12-git-send-email-jjherne@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c  | 85 ++++++++++++++++++++++------------------
 tests/boot-serial-test.c |  2 +-
 2 files changed, 47 insertions(+), 40 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index d04ea8972a0c..d3a161c68546 100644
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
index c591748aaf00..24852d4c7d0b 100644
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
2.17.2
