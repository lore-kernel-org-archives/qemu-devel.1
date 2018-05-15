Received: from eggs.gnu.org ([2001:4830:134:3::10]:39104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4f-0006xq-PI
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4b-0001i6-Nu
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:13 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:24 +0200
Message-Id: <20180515154033.19899-29-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 28/37] block/quorum: Support
 BDRV_REQ_WRITE_UNCHANGED
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

From: Max Reitz <mreitz@redhat.com>

We just need to forward it to quorum's children (except in case of a
rewrite because of corruption), but for that we first have to support
flags in child requests at all.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20180421132929.21610-6-mreitz@redhat.com
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/quorum.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/block/quorum.c b/block/quorum.c
index a5051da56e..e448d7e384 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -115,6 +115,7 @@ struct QuorumAIOCB {
     /* Request metadata */
     uint64_t offset;
     uint64_t bytes;
+    int flags;
 
     QEMUIOVector *qiov;         /* calling IOV */
 
@@ -157,7 +158,8 @@ static bool quorum_64bits_compare(QuorumVoteValue *a, QuorumVoteValue *b)
 static QuorumAIOCB *quorum_aio_get(BlockDriverState *bs,
                                    QEMUIOVector *qiov,
                                    uint64_t offset,
-                                   uint64_t bytes)
+                                   uint64_t bytes,
+                                   int flags)
 {
     BDRVQuorumState *s = bs->opaque;
     QuorumAIOCB *acb = g_new(QuorumAIOCB, 1);
@@ -168,6 +170,7 @@ static QuorumAIOCB *quorum_aio_get(BlockDriverState *bs,
         .bs                 = bs,
         .offset             = offset,
         .bytes              = bytes,
+        .flags              = flags,
         .qiov               = qiov,
         .votes.compare      = quorum_sha256_compare,
         .votes.vote_list    = QLIST_HEAD_INITIALIZER(acb.votes.vote_list),
@@ -271,9 +274,11 @@ static void quorum_rewrite_entry(void *opaque)
     BDRVQuorumState *s = acb->bs->opaque;
 
     /* Ignore any errors, it's just a correction attempt for already
-     * corrupted data. */
+     * corrupted data.
+     * Mask out BDRV_REQ_WRITE_UNCHANGED because this overwrites the
+     * area with different data from the other children. */
     bdrv_co_pwritev(s->children[co->idx], acb->offset, acb->bytes,
-                    acb->qiov, 0);
+                    acb->qiov, acb->flags & ~BDRV_REQ_WRITE_UNCHANGED);
 
     /* Wake up the caller after the last rewrite */
     acb->rewrite_count--;
@@ -673,7 +678,7 @@ static int quorum_co_preadv(BlockDriverState *bs, uint64_t offset,
                             uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
     BDRVQuorumState *s = bs->opaque;
-    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, offset, bytes);
+    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, offset, bytes, flags);
     int ret;
 
     acb->is_read = true;
@@ -699,7 +704,7 @@ static void write_quorum_entry(void *opaque)
 
     sacb->bs = s->children[i]->bs;
     sacb->ret = bdrv_co_pwritev(s->children[i], acb->offset, acb->bytes,
-                                acb->qiov, 0);
+                                acb->qiov, acb->flags);
     if (sacb->ret == 0) {
         acb->success_count++;
     } else {
@@ -719,7 +724,7 @@ static int quorum_co_pwritev(BlockDriverState *bs, uint64_t offset,
                              uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
     BDRVQuorumState *s = bs->opaque;
-    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, offset, bytes);
+    QuorumAIOCB *acb = quorum_aio_get(bs, qiov, offset, bytes, flags);
     int i, ret;
 
     for (i = 0; i < s->num_children; i++) {
@@ -961,6 +966,8 @@ static int quorum_open(BlockDriverState *bs, QDict *options, int flags,
     }
     s->next_child_index = s->num_children;
 
+    bs->supported_write_flags = BDRV_REQ_WRITE_UNCHANGED;
+
     g_free(opened);
     goto exit;
 
-- 
2.13.6
