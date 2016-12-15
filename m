Received: from eggs.gnu.org ([2001:4830:134:3::10]:43196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCG-0004PP-Gq
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKCC-0001Zv-Q6
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39052
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKCC-0001ZT-L1
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:52 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hcnK140038
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:52 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	by mx0a-001b2d01.pphosted.com with ESMTP id 27bdm28www-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:51 -0500
Received: from localhost
	by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:51 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:44:46 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1481762701-4587-53-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 52/67] block: Return -ENOTSUP rather than
 assert on unaligned discards
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>

From: Eric Blake <eblake@redhat.com>

Right now, the block layer rounds discard requests, so that
individual drivers are able to assert that discard requests
will never be unaligned.  But there are some ISCSI devices
that track and coalesce multiple unaligned requests, turning it
into an actual discard if the requests eventually cover an
entire page, which implies that it is better to always pass
discard requests as low down the stack as possible.

In isolation, this patch has no semantic effect, since the
block layer currently never passes an unaligned request through.
But the block layer already has code that silently ignores
drivers that return -ENOTSUP for a discard request that cannot
be honored (as well as drivers that return 0 even when nothing
was done).  But the next patch will update the block layer to
fragment discard requests, so that clients are guaranteed that
they are either dealing with an unaligned head or tail, or an
aligned core, making it similar to the block layer semantics of
write zero fragmentation.

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit 49228d1e95e1be879c57f5dbccb44405670e343d)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 block/iscsi.c    | 4 +++-
 block/qcow2.c    | 5 +++++
 block/sheepdog.c | 5 +++--
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index b2b4e5d..8bc5f7e 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1048,7 +1048,9 @@ coroutine_fn iscsi_co_pdiscard(BlockDriverState *bs, int64_t offset, int count)
     struct IscsiTask iTask;
     struct unmap_list list;
 
-    assert(is_byte_request_lun_aligned(offset, count, iscsilun));
+    if (!is_byte_request_lun_aligned(offset, count, iscsilun)) {
+        return -ENOTSUP;
+    }
 
     if (!iscsilun->lbp.lbpu) {
         /* UNMAP is not supported by the target */
diff --git a/block/qcow2.c b/block/qcow2.c
index 497df0f..3a80be0 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2486,6 +2486,11 @@ static coroutine_fn int qcow2_co_pdiscard(BlockDriverState *bs,
     int ret;
     BDRVQcow2State *s = bs->opaque;
 
+    if (!QEMU_IS_ALIGNED(offset | count, s->cluster_size)) {
+        assert(count < s->cluster_size);
+        return -ENOTSUP;
+    }
+
     qemu_co_mutex_lock(&s->lock);
     ret = qcow2_discard_clusters(bs, offset, count >> BDRV_SECTOR_BITS,
                                  QCOW2_DISCARD_REQUEST, false);
diff --git a/block/sheepdog.c b/block/sheepdog.c
index 66e1cb2..314b470 100644
--- a/block/sheepdog.c
+++ b/block/sheepdog.c
@@ -2820,8 +2820,9 @@ static coroutine_fn int sd_co_pdiscard(BlockDriverState *bs, int64_t offset,
     iov.iov_len = sizeof(zero);
     discard_iov.iov = &iov;
     discard_iov.niov = 1;
-    assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((count & (BDRV_SECTOR_SIZE - 1)) == 0);
+    if (!QEMU_IS_ALIGNED(offset | count, BDRV_SECTOR_SIZE)) {
+        return -ENOTSUP;
+    }
     acb = sd_aio_setup(bs, &discard_iov, offset >> BDRV_SECTOR_BITS,
                        count >> BDRV_SECTOR_BITS);
     acb->aiocb_type = AIOCB_DISCARD_OBJ;
-- 
1.9.1
