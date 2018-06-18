Received: from eggs.gnu.org ([2001:4830:134:3::10]:52226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHd-00059E-G2
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHc-0006R0-CX
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:37 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:55 +0200
Message-Id: <20180618164504.24488-27-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 26/35] block/mirror: Use source as a BdrvChild
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

With this, the mirror_top_bs is no longer just a technically required
node in the BDS graph but actually represents the block job operation.

Also, drop MirrorBlockJob.source, as we can reach it through
mirror_top_bs->backing.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20180613181823.13618-6-mreitz@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 5df6515731..abf231c478 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -41,7 +41,6 @@ typedef struct MirrorBlockJob {
     BlockJob common;
     BlockBackend *target;
     BlockDriverState *mirror_top_bs;
-    BlockDriverState *source;
     BlockDriverState *base;
 
     /* The name of the graph node to replace */
@@ -299,7 +298,6 @@ static void coroutine_fn mirror_co_read(void *opaque)
 {
     MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
-    BlockBackend *source = s->common.blk;
     int nb_chunks;
     uint64_t ret;
     uint64_t max_bytes;
@@ -349,7 +347,8 @@ static void coroutine_fn mirror_co_read(void *opaque)
     s->bytes_in_flight += op->bytes;
     trace_mirror_one_iteration(s, op->offset, op->bytes);
 
-    ret = blk_co_preadv(source, op->offset, op->bytes, &op->qiov, 0);
+    ret = bdrv_co_preadv(s->mirror_top_bs->backing, op->offset, op->bytes,
+                         &op->qiov, 0);
     mirror_read_complete(op, ret);
 }
 
@@ -427,7 +426,7 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
 
 static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
 {
-    BlockDriverState *source = s->source;
+    BlockDriverState *source = s->mirror_top_bs->backing->bs;
     MirrorOp *pseudo_op;
     int64_t offset;
     uint64_t delay_ns = 0, ret = 0;
@@ -601,7 +600,7 @@ static void mirror_exit(Job *job, void *opaque)
     BlockJob *bjob = &s->common;
     MirrorExitData *data = opaque;
     AioContext *replace_aio_context = NULL;
-    BlockDriverState *src = s->source;
+    BlockDriverState *src = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     BlockDriverState *mirror_top_bs = s->mirror_top_bs;
     Error *local_err = NULL;
@@ -716,7 +715,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
 {
     int64_t offset;
     BlockDriverState *base = s->base;
-    BlockDriverState *bs = s->source;
+    BlockDriverState *bs = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     int ret;
     int64_t count;
@@ -798,7 +797,7 @@ static void coroutine_fn mirror_run(void *opaque)
 {
     MirrorBlockJob *s = opaque;
     MirrorExitData *data;
-    BlockDriverState *bs = s->source;
+    BlockDriverState *bs = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     bool need_drain = true;
     int64_t length;
@@ -1293,7 +1292,6 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     /* The block job now has a reference to this node */
     bdrv_unref(mirror_top_bs);
 
-    s->source = bs;
     s->mirror_top_bs = mirror_top_bs;
 
     /* No resize for the target either; while the mirror is still running, a
-- 
2.13.6
