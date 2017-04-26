Received: from eggs.gnu.org ([2001:4830:134:3::10]:38041)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3ODg-0003Ox-6O
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:47:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d3ODa-0002Oo-Eq
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:47:04 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47395)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d3ODa-0002Nx-6b
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 10:46:58 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3QEi2Ad086130
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:46:57 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2a2wj306pj-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 26 Apr 2017 10:46:56 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 26 Apr 2017 15:46:53 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 26 Apr 2017 16:46:44 +0200
In-Reply-To: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
References: <20170426144645.12476-1-farman@linux.vnet.ibm.com>
Message-Id: <20170426144645.12476-5-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v1 4/5] pc-bios/s390-ccw: Break up
 virtio-scsi read into multiples
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Eric Farman <farman@linux.vnet.ibm.com>

A virtio-scsi request that goes through the host sd driver and
exceeds the maximum transfer size is automatically broken up
for us. But the equivalent request going to the sg driver
presumes that any length requirements have already been honored.
Let's use the max_sectors field from the device and break up
all virtio-scsi requests (both sd and sg) to avoid problem from
the host drivers.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/s390-ccw.h    |  4 ++++
 pc-bios/s390-ccw/virtio-scsi.c | 19 ++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index ded67bc..e1f3751 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -42,6 +42,10 @@ typedef unsigned long long __u64;
 #ifndef NULL
 #define NULL    0
 #endif
+#ifndef MIN
+#define MIN(a, b) (((a) < (b)) ? (a) : (b));
+#endif
+
 
 #include "cio.h"
 #include "iplb.h"
diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 6d070e2..90a8cc8 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -254,12 +254,21 @@ static void virtio_scsi_locate_device(VDev *vdev)
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
+        sector_count = MIN(sec_num, vdev->config.scsi.max_sectors);
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
2.10.2
