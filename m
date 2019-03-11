Received: from eggs.gnu.org ([209.51.188.92]:42215)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h3Mw6-0005vi-H8
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:33:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jjherne@linux.ibm.com>) id 1h3Mms-0007hB-4x
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:24:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:32896
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jjherne@linux.ibm.com>)
	id 1h3Mms-0007h6-0I
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 11:24:22 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x2BFOBKD025727
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:24:21 -0400
Received: from e16.ny.us.ibm.com (e16.ny.us.ibm.com [129.33.205.206])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2r5ra1pv0e-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 11:24:13 -0400
Received: from localhost
	by e16.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <jjherne@linux.ibm.com>;
	Mon, 11 Mar 2019 15:21:55 -0000
From: "Jason J. Herne" <jjherne@linux.ibm.com>
Date: Mon, 11 Mar 2019 11:21:31 -0400
In-Reply-To: <1552317693-21979-1-git-send-email-jjherne@linux.ibm.com>
References: <1552317693-21979-1-git-send-email-jjherne@linux.ibm.com>
Message-Id: <1552317693-21979-14-git-send-email-jjherne@linux.ibm.com>
Subject: [Qemu-devel] [PATCH v4 13/15] s390-bios: Use control unit type to
 determine boot method
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com, thuth@redhat.com, pasic@linux.ibm.com, alifm@linux.ibm.com, borntraeger@de.ibm.com

The boot method is different depending on which device type we are
booting from. Let's examine the control unit type to determine if we're
a virtio device. We'll eventually add a case to check for a real dasd device
here as well.

Since we have to call enable_subchannel() in main now, might as well
remove that call from virtio.c : run_ccw(). This requires adding some
additional enable_subchannel calls to not break calls to
virtio_is_supported().

Signed-off-by: Jason J. Herne <jjherne@linux.ibm.com>
---
 pc-bios/s390-ccw/main.c    | 16 ++++++++++++++--
 pc-bios/s390-ccw/netmain.c |  1 +
 pc-bios/s390-ccw/virtio.c  |  1 -
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index d3a161c..57a1013 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -76,6 +76,7 @@ static bool find_subch(int dev_no)
         /* Skip net devices since no IPLB is created and therefore no
          * network bootloader has been loaded
          */
+        enable_subchannel(blk_schid);
         if (virtio_is_supported(blk_schid) &&
             virtio_get_device_type() == VIRTIO_ID_NET && dev_no < 0) {
             continue;
@@ -198,13 +199,24 @@ static void virtio_setup(void)
 
 int main(void)
 {
+    uint16_t cutype;
+
     sclp_setup();
     css_setup();
     boot_setup();
     find_boot_device();
+    enable_subchannel(blk_schid);
 
-    virtio_setup();
-    zipl_load(); /* no return */
+    cutype = cu_type(blk_schid);
+    switch (cutype) {
+    case CU_TYPE_VIRTIO:
+        virtio_setup();
+        zipl_load(); /* no return */
+        break;
+    default:
+        print_int("Attempting to boot from unexpected device type", cutype);
+        panic("");
+    }
 
     panic("Failed to load OS from hard disk\n");
     return 0; /* make compiler happy */
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 5189c0f..f3542cb 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -476,6 +476,7 @@ static bool find_net_dev(Schib *schib, int dev_no)
         if (!schib->pmcw.dnv) {
             continue;
         }
+        enable_subchannel(net_schid);
         if (!virtio_is_supported(net_schid)) {
             continue;
         }
diff --git a/pc-bios/s390-ccw/virtio.c b/pc-bios/s390-ccw/virtio.c
index 4cd09eb..e660c7a 100644
--- a/pc-bios/s390-ccw/virtio.c
+++ b/pc-bios/s390-ccw/virtio.c
@@ -102,7 +102,6 @@ static int run_ccw(VDev *vdev, int cmd, void *ptr, int len, bool sli)
         ccw.flags |= CCW_FLAG_SLI;
     }
 
-    enable_subchannel(vdev->schid);
     return do_cio(vdev->schid, vdev->senseid.cu_type, ptr2u32(&ccw), CCW_FMT1);
 }
 
-- 
2.7.4
