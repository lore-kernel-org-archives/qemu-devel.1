Received: from eggs.gnu.org ([2001:4830:134:3::10]:49639)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d8TwW-00018T-67
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farman@linux.vnet.ibm.com>) id 1d8TwS-000306-62
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:35409)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farman@linux.vnet.ibm.com>)
	id 1d8TwR-0002zT-Sc
	for qemu-devel@nongnu.org; Wed, 10 May 2017 11:54:20 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4AFs4bH128120
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 11:54:18 -0400
Received: from e06smtp15.uk.ibm.com (e06smtp15.uk.ibm.com [195.75.94.111])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ac1y0525a-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 10 May 2017 11:54:17 -0400
Received: from localhost
	by e06smtp15.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farman@linux.vnet.ibm.com>;
	Wed, 10 May 2017 16:54:15 +0100
From: Eric Farman <farman@linux.vnet.ibm.com>
Date: Wed, 10 May 2017 17:53:53 +0200
In-Reply-To: <20170510155359.32727-1-farman@linux.vnet.ibm.com>
References: <20170510155359.32727-1-farman@linux.vnet.ibm.com>
Message-Id: <20170510155359.32727-3-farman@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v2 2/8] pc-bios/s390-ccw: Move SCSI block
 factor to outer read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Farman <farman@linux.vnet.ibm.com>

Simple refactoring so that the blk_factor adjustment is
moved into virtio_scsi_read_many routine, in preparation
for another change.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
---
 pc-bios/s390-ccw/virtio-scsi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 69b7a93..6d070e2 100644
--- a/pc-bios/s390-ccw/virtio-scsi.c
+++ b/pc-bios/s390-ccw/virtio-scsi.c
@@ -142,14 +142,13 @@ static bool scsi_report_luns(VDev *vdev, void *data, uint32_t data_size)
 }
 
 static bool scsi_read_10(VDev *vdev,
-                         ulong sector, int sectors, void *data)
+                         ulong sector, int sectors, void *data,
+                         unsigned int data_size)
 {
-    int f = vdev->blk_factor;
-    unsigned int data_size = sectors * virtio_get_block_size() * f;
     ScsiCdbRead10 cdb = {
         .command = 0x28,
-        .lba = sector * f,
-        .xfer_length = sectors * f,
+        .lba = sector,
+        .xfer_length = sectors,
     };
     VirtioCmd read_10[] = {
         { &req, sizeof(req), VRING_DESC_F_NEXT },
@@ -255,7 +254,10 @@ static void virtio_scsi_locate_device(VDev *vdev)
 int virtio_scsi_read_many(VDev *vdev,
                           ulong sector, void *load_addr, int sec_num)
 {
-    if (!scsi_read_10(vdev, sector, sec_num, load_addr)) {
+    int f = vdev->blk_factor;
+    unsigned int data_size = sec_num * virtio_get_block_size() * f;
+
+    if (!scsi_read_10(vdev, sector * f, sec_num * f, load_addr, data_size)) {
         virtio_scsi_verify_response(&resp, "virtio-scsi:read_many");
     }
 
-- 
2.10.2
