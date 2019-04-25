Return-Path: <SRS0=VSQP=S3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06CA8C43218
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:36:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3594206BF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2019 13:36:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3594206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57318 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJeXo-0006Xo-TQ
	for qemu-devel@archiver.kernel.org; Thu, 25 Apr 2019 09:36:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKB-0003U0-LP
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hJeKA-0003oU-Dp
	for qemu-devel@nongnu.org; Thu, 25 Apr 2019 09:22:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:3015)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>)
	id 1hJeKA-0003nd-5r; Thu, 25 Apr 2019 09:22:02 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6AA9A3158797;
	Thu, 25 Apr 2019 13:22:01 +0000 (UTC)
Received: from localhost (dhcp-192-187.str.redhat.com [10.33.192.187])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D3AF11796F;
	Thu, 25 Apr 2019 13:22:00 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Apr 2019 15:21:26 +0200
Message-Id: <20190425132134.2839-12-cohuck@redhat.com>
In-Reply-To: <20190425132134.2839-1-cohuck@redhat.com>
References: <20190425132134.2839-1-cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Thu, 25 Apr 2019 13:22:01 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 11/19] s390-bios: Factor finding boot device out
 of virtio code path
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Jason J. Herne" <jjherne@linux.ibm.com>, qemu-s390x@nongnu.org,
	qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190425132126.PQ_T8g9fFj2UFT87KI8tJQuG6EXXV1rNeNPkJfm4J28@z>

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


