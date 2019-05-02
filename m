Received: from eggs.gnu.org ([209.51.188.92]:38934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hME3N-00038S-Qa
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:55:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hME3M-0006BL-V6
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:55:21 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Thu,  2 May 2019 17:55:16 +0200
Message-Id: <20190502155516.12415-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH] s390/ipl: cast to SCSIDevice directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, "Jason J . Herne" <jjherne@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>

Coverity notes that the result of object_dynamic_cast() to
SCSIDevice is not checked in s390_gen_initial_iplp(); as
we know that we always have a SCSIDevice in that branch,
we can instead cast via SCSI_DEVICE directly.

Coverity: CID 1401098
Fixes: 44445d8668f4 ("s390 vfio-ccw: Add bootindex property and IPLB data")
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/ipl.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index d0cc06a05fd0..b93750c14eac 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -374,8 +374,7 @@ static bool s390_gen_initial_iplb(S390IPLState *ipl)
     if (ccw_dev) {
         switch (devtype) {
         case CCW_DEVTYPE_SCSI:
-            sd = (SCSIDevice *) object_dynamic_cast(OBJECT(dev_st),
-                                                           TYPE_SCSI_DEVICE);
+            sd = SCSI_DEVICE(dev_st);
             ipl->iplb.len = cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN);
             ipl->iplb.blk0_len =
                 cpu_to_be32(S390_IPLB_MIN_QEMU_SCSI_LEN - S390_IPLB_HEADER_LEN);
-- 
2.17.2
