Received: from eggs.gnu.org ([2001:4830:134:3::10]:41408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBfZu-0004xs-1a
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1dBfZq-0008QC-Vc
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:41480
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1dBfZq-0008Pm-Q4
	for qemu-devel@nongnu.org; Fri, 19 May 2017 06:56:10 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JAmwEM120880
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:56:10 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahr3j2u2n-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 06:56:09 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Fri, 19 May 2017 11:56:08 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Date: Fri, 19 May 2017 12:55:41 +0200
In-Reply-To: <20170519105600.11589-1-cornelia.huck@de.ibm.com>
References: <20170519105600.11589-1-cornelia.huck@de.ibm.com>
Message-Id: <20170519105600.11589-3-cornelia.huck@de.ibm.com>
Subject: [Qemu-devel] [PATCH 02/21] pc-bios/s390-ccw: Move SCSI block factor
 to outer read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, Eric Farman <farman@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>

From: Eric Farman <farman@linux.vnet.ibm.com>

Simple refactoring so that the blk_factor adjustment is
moved into virtio_scsi_read_many routine, in preparation
for another change.

Signed-off-by: Eric Farman <farman@linux.vnet.ibm.com>
Message-Id: <20170510155359.32727-3-farman@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 pc-bios/s390-ccw/virtio-scsi.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/pc-bios/s390-ccw/virtio-scsi.c b/pc-bios/s390-ccw/virtio-scsi.c
index 69b7a93b29..6d070e2f73 100644
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
2.13.0
