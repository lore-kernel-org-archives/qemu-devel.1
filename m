Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25811C10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:36:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7202082E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 12:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7202082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35782 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEvPX-0003gD-55
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 08:36:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFr-0002Vy-S5
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hEvFq-0002bo-BE
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hEvFp-0002af-VV; Fri, 12 Apr 2019 08:26:02 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2CF3388AA1;
	Fri, 12 Apr 2019 12:26:01 +0000 (UTC)
Received: from thuth.com (ovpn-116-133.ams2.redhat.com [10.36.116.133])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE7735D9CC;
	Fri, 12 Apr 2019 12:25:58 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: cohuck@redhat.com,
	qemu-s390x@nongnu.org
Date: Fri, 12 Apr 2019 14:25:17 +0200
Message-Id: <20190412122523.24111-12-thuth@redhat.com>
In-Reply-To: <20190412122523.24111-1-thuth@redhat.com>
References: <20190412122523.24111-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.26]);
	Fri, 12 Apr 2019 12:26:01 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL SUBSYSTEM s390-ccw-bios 11/17] s390-bios: Factor
 finding boot device out of virtio code path
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
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190412122517.4kekjowmz6I8j7m6qtQ1EUPzVCxmaXOwSGNVt3uvoOU@z>

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
index d04ea8972a..d3a161c685 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -58,17 +58,18 @@ unsigned int get_loadparm_index(void)
  * NOTE: The global variable blk_schid is updated to contain the subchan=
nel
  * information.
  */
-static bool find_dev(Schib *schib, int dev_no)
+static bool find_subch(int dev_no)
 {
+    Schib schib;
     int i, r;
=20
     for (i =3D 0; i < 0x10000; i++) {
         blk_schid.sch_no =3D i;
-        r =3D stsch_err(blk_schid, schib);
+        r =3D stsch_err(blk_schid, &schib);
         if ((r =3D=3D 3) || (r =3D=3D -EIO)) {
             break;
         }
-        if (!schib->pmcw.dnv) {
+        if (!schib.pmcw.dnv) {
             continue;
         }
=20
@@ -80,7 +81,7 @@ static bool find_dev(Schib *schib, int dev_no)
             continue;
         }
=20
-        if ((dev_no < 0) || (schib->pmcw.dev =3D=3D dev_no)) {
+        if ((dev_no < 0) || (schib.pmcw.dev =3D=3D dev_no)) {
             return true;
         }
     }
@@ -136,56 +137,61 @@ static void boot_setup(void)
     have_iplb =3D store_iplb(&iplb);
 }
=20
-static void virtio_setup(void)
+static void find_boot_device(void)
 {
-    Schib schib;
-    int ssid;
-    bool found =3D false;
-    uint16_t dev_no;
     VDev *vdev =3D virtio_get_device();
-    QemuIplParameters *early_qipl =3D (QemuIplParameters *)QIPL_ADDRESS;
-
-    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
+    int ssid;
+    bool found;
=20
-    if (have_iplb) {
-        switch (iplb.pbt) {
-        case S390_IPL_TYPE_CCW:
-            dev_no =3D iplb.ccw.devno;
-            debug_print_int("device no. ", dev_no);
-            blk_schid.ssid =3D iplb.ccw.ssid & 0x3;
-            debug_print_int("ssid ", blk_schid.ssid);
-            found =3D find_dev(&schib, dev_no);
-            break;
-        case S390_IPL_TYPE_QEMU_SCSI:
-            vdev->scsi_device_selected =3D true;
-            vdev->selected_scsi_device.channel =3D iplb.scsi.channel;
-            vdev->selected_scsi_device.target =3D iplb.scsi.target;
-            vdev->selected_scsi_device.lun =3D iplb.scsi.lun;
-            blk_schid.ssid =3D iplb.scsi.ssid & 0x3;
-            found =3D find_dev(&schib, iplb.scsi.devno);
-            break;
-        default:
-            panic("List-directed IPL not supported yet!\n");
-        }
-        menu_setup();
-    } else {
+    if (!have_iplb) {
         for (ssid =3D 0; ssid < 0x3; ssid++) {
             blk_schid.ssid =3D ssid;
-            found =3D find_dev(&schib, -1);
+            found =3D find_subch(-1);
             if (found) {
-                break;
+                return;
             }
         }
+        panic("Could not find a suitable boot device (none specified)\n"=
);
+    }
+
+    switch (iplb.pbt) {
+    case S390_IPL_TYPE_CCW:
+        debug_print_int("device no. ", iplb.ccw.devno);
+        blk_schid.ssid =3D iplb.ccw.ssid & 0x3;
+        debug_print_int("ssid ", blk_schid.ssid);
+        found =3D find_subch(iplb.ccw.devno);
+        break;
+    case S390_IPL_TYPE_QEMU_SCSI:
+        vdev->scsi_device_selected =3D true;
+        vdev->selected_scsi_device.channel =3D iplb.scsi.channel;
+        vdev->selected_scsi_device.target =3D iplb.scsi.target;
+        vdev->selected_scsi_device.lun =3D iplb.scsi.lun;
+        blk_schid.ssid =3D iplb.scsi.ssid & 0x3;
+        found =3D find_subch(iplb.scsi.devno);
+        break;
+    default:
+        panic("List-directed IPL not supported yet!\n");
     }
=20
-    IPL_assert(found, "No virtio device found");
+    IPL_assert(found, "Boot device not found\n");
+}
+
+static void virtio_setup(void)
+{
+    VDev *vdev =3D virtio_get_device();
+    QemuIplParameters *early_qipl =3D (QemuIplParameters *)QIPL_ADDRESS;
+
+    memcpy(&qipl, early_qipl, sizeof(QemuIplParameters));
+
+    if (have_iplb) {
+        menu_setup();
+    }
=20
     if (virtio_get_device_type() =3D=3D VIRTIO_ID_NET) {
         sclp_print("Network boot device detected\n");
         vdev->netboot_start_addr =3D qipl.netboot_start_addr;
     } else {
         virtio_blk_setup_device(blk_schid);
-
         IPL_assert(virtio_ipl_disk_is_valid(), "No valid IPL device dete=
cted");
     }
 }
@@ -195,8 +201,9 @@ int main(void)
     sclp_setup();
     css_setup();
     boot_setup();
-    virtio_setup();
+    find_boot_device();
=20
+    virtio_setup();
     zipl_load(); /* no return */
=20
     panic("Failed to load OS from hard disk\n");
diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
index c591748aaf..24852d4c7d 100644
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -114,7 +114,7 @@ static testdef_t tests[] =3D {
     { "sparc", "SS-4", "", "MB86904" },
     { "sparc", "SS-600MP", "", "TMS390Z55" },
     { "sparc64", "sun4u", "", "UltraSPARC" },
-    { "s390x", "s390-ccw-virtio", "", "virtio device" },
+    { "s390x", "s390-ccw-virtio", "", "device" },
     { "m68k", "mcf5208evb", "", "TT", sizeof(kernel_mcf5208), kernel_mcf=
5208 },
     { "microblaze", "petalogix-s3adsp1800", "", "TT",
       sizeof(kernel_pls3adsp1800), kernel_pls3adsp1800 },
--=20
2.21.0


