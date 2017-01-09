Received: from eggs.gnu.org ([2001:4830:134:3::10]:33308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFn-0006h5-JK
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cQaFm-0002yL-F5
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 08:44:51 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  9 Jan 2017 14:44:25 +0100
Message-Id: <1483969476-7172-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
References: <1483969476-7172-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 03/14] quorum: Remove s from quorum_aio_get()
 arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

There is no point in passing the value of bs->opaque in order to
overwrite it with itself.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/quorum.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index d122299..dfa9fd3 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -171,18 +171,17 @@ static bool quorum_64bits_compare(QuorumVoteValue *a, QuorumVoteValue *b)
     return a->l == b->l;
 }
 
-static QuorumAIOCB *quorum_aio_get(BDRVQuorumState *s,
-                                   BlockDriverState *bs,
+static QuorumAIOCB *quorum_aio_get(BlockDriverState *bs,
                                    QEMUIOVector *qiov,
                                    uint64_t sector_num,
                                    int nb_sectors,
                                    BlockCompletionFunc *cb,
                                    void *opaque)
 {
+    BDRVQuorumState *s = bs->opaque;
     QuorumAIOCB *acb = qemu_aio_get(&quorum_aiocb_info, bs, cb, opaque);
     int i;
 
-    acb->common.bs->opaque = s;
     acb->sector_num = sector_num;
     acb->nb_sectors = nb_sectors;
     acb->qiov = qiov;
@@ -691,7 +690,7 @@ static BlockAIOCB *quorum_aio_readv(BlockDriverState *bs,
                                     void *opaque)
 {
     BDRVQuorumState *s = bs->opaque;
-    QuorumAIOCB *acb = quorum_aio_get(s, bs, qiov, sector_num,
+    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, sector_num,
                                       nb_sectors, cb, opaque);
     acb->is_read = true;
     acb->children_read = 0;
@@ -711,7 +710,7 @@ static BlockAIOCB *quorum_aio_writev(BlockDriverState *bs,
                                      void *opaque)
 {
     BDRVQuorumState *s = bs->opaque;
-    QuorumAIOCB *acb = quorum_aio_get(s, bs, qiov, sector_num, nb_sectors,
+    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, sector_num, nb_sectors,
                                       cb, opaque);
     int i;
 
-- 
1.8.3.1
