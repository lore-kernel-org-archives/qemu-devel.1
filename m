Received: from eggs.gnu.org ([2001:4830:134:3::10]:42688)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBz-0003NA-TW
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBw-0001My-Qu
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:57949
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBw-0001MT-KS
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:36 -0500
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0haqj007005
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:36 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm6120q-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:35 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:35 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:29 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-36-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 35/67] rbd: shift byte count as a 64-bit value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, kwolf@redhat.com, eblake@redhat.com

From: Paolo Bonzini <pbonzini@redhat.com>

Otherwise, reads of more than 2GB fail.  Until commit
7bbca9e290a9c7c217b5a24fc6094e91e54bd05d, reads of 2^41
bytes succeeded at least theoretically.

In fact, pdiscard ought to receive a 64-bit integer as the
count for the same reason.

Reported by Coverity.

Fixes: 7bbca9e290a9c7c217b5a24fc6094e91e54bd05d
Cc: qemu-stable@nongnu.org
Cc: kwolf@redhat.com
Cc: eblake@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
(cherry picked from commit e948f663e9334249c394b88926addcdd3f9e35cd)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/rbd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 0106fea..5cefdbb 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -737,7 +737,7 @@ static BlockAIOCB *qemu_rbd_aio_readv(BlockDriverState *bs,
                                       void *opaque)
 {
     return rbd_start_aio(bs, sector_num << BDRV_SECTOR_BITS, qiov,
-                         nb_sectors << BDRV_SECTOR_BITS, cb, opaque,
+                         (int64_t) nb_sectors << BDRV_SECTOR_BITS, cb, opaque,
                          RBD_AIO_READ);
 }
 
@@ -749,7 +749,7 @@ static BlockAIOCB *qemu_rbd_aio_writev(BlockDriverState *bs,
                                        void *opaque)
 {
     return rbd_start_aio(bs, sector_num << BDRV_SECTOR_BITS, qiov,
-                         nb_sectors << BDRV_SECTOR_BITS, cb, opaque,
+                         (int64_t) nb_sectors << BDRV_SECTOR_BITS, cb, opaque,
                          RBD_AIO_WRITE);
 }
 
-- 
1.9.1
