Received: from eggs.gnu.org ([2001:4830:134:3::10]:43833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dD7kk-0007TC-NL
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dD7kf-0002tS-Sn
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57959)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dD7kf-0002ro-Ic
	for qemu-devel@nongnu.org; Tue, 23 May 2017 07:13:21 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4NB4Hk3105841
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 07:13:20 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2amc2g4278-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 07:13:20 -0400
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 23 May 2017 12:13:17 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Tue, 23 May 2017 13:12:48 +0200
In-Reply-To: <20170523111306.25493-1-cornelia.huck@de.ibm.com>
References: <20170523111306.25493-1-cornelia.huck@de.ibm.com>
Message-Id: <20170523111306.25493-4-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PULL 03/21] pc-bios/s390-ccw: Break up virtio-scsi
 read into multiples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, stefanha@redhat.com
Cc: borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Eric Farman <farman@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Eric Farman <farman@linux.vnet.ibm.com>

A virtio-scsi request that goes through the host sd driver and exceeds
the maximum transfer size is automatically broken up for us.  But the
equivalent request going to the sg driver presumes that any length
requirements have already been honored.

Let's use the max_sectors field on the virtio-scsi controller device,
and break up all requests (both sd and sg) to avoid this problem.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Message-Id: <20170510155359.32727-4-farman@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 pc-bios/s390-ccw/s390-ccw.h    |  7 +++++++
 pc-bios/s390-ccw/virtio-scsi.c | 20 +++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 07d8cbcb20..2089274842 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -42,6 +42,13 @@ typedef unsigned long long __u64;
 #ifndef NULL
 #define NULL    0
 #endif
+#ifndef MIN
+#define MIN(a, b) (((a) < (b)) ? (a) : (b))
+#endif
+#ifndef MIN_NON_ZERO
+#define MIN_NON_ZERO(a, b) ((a) == 0 ? (b) : \
+                            ((b) == 0 ? (a) : (MIN(a, b))))
+#endif
 
 #include "cio.h"
 #include "iplb.h"
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 6d070e2f73..ff65e2ee30 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -202,6 +202,7 @@ static void virtio_scsi_locate_device(VDev *vdev)
     debug_print_int("config.scsi.max_channel", vdev->config.scsi.max_channel);
     debug_print_int("config.scsi.max_target ", vdev->config.scsi.max_target);
     debug_print_int("config.scsi.max_lun    ", vdev->config.scsi.max_lun);
+    debug_print_int("config.scsi.max_sectors", vdev->config.scsi.max_sectors);
 
     if (vdev->scsi_device_selected) {
         sdev->channel = vdev->selected_scsi_device.channel;
@@ -254,12 +255,21 @@ static void virtio_scsi_locate_device(VDev *vdev)
 int virtio_scsi_read_many(VDev *vdev,
                           ulong sector, void *load_addr, int sec_num)
 {
+    int sector_count;
     int f = vdev->blk_factor;
-    unsigned int data_size = sec_num * virtio_get_block_size() * f;
-
-    if (!scsi_read_10(vdev, sector * f, sec_num * f, load_addr, data_size)) {
-        virtio_scsi_verify_response(&resp, "virtio-scsi:read_many");
-    }
+    unsigned int data_size;
+
+    do {
+        sector_count = MIN_NON_ZERO(sec_num, vdev->config.scsi.max_sectors);
+        data_size = sector_count * virtio_get_block_size() * f;
+        if (!scsi_read_10(vdev, sector * f, sector_count * f, load_addr,
+                          data_size)) {
+            virtio_scsi_verify_response(&resp, "virtio-scsi:read_many");
+        }
+        load_addr += data_size;
+        sector += sector_count;
+        sec_num -= sector_count;
+    } while (sec_num > 0);
 
     return 0;
 }
-- 
2.13.0
