Received: from eggs.gnu.org ([2001:4830:134:3::10]:36283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6KtS-0003JB-VE
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:54:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f6KtR-00060t-Si
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 14:54:55 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 11 Apr 2018 20:54:17 +0200
Message-Id: <20180411185425.2461-6-mreitz@redhat.com>
In-Reply-To: <20180411185425.2461-1-mreitz@redhat.com>
References: <20180411185425.2461-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 05/13] block/mirror: Use source as a
 BdrvChild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

With this, the mirror_top_bs is no longer just a technically required
node in the BDS graph but actually represents the block job operation.

Also, drop MirrorBlockJob.source, as we can reach it through
mirror_top_bs->backing.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
---
 block/mirror.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 964ffbe682..40c7c55f07 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -43,7 +43,6 @@ typedef struct MirrorBlockJob {
     RateLimit limit;
     BlockBackend *target;
     BlockDriverState *mirror_top_bs;
-    BlockDriverState *source;
     BlockDriverState *base;
 
     /* The name of the graph node to replace */
@@ -301,7 +300,6 @@ static void coroutine_fn mirror_co_read(void *opaque)
 {
     MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
-    BlockBackend *source = s->common.blk;
     int nb_chunks;
     uint64_t ret;
     uint64_t max_bytes;
@@ -351,7 +349,8 @@ static void coroutine_fn mirror_co_read(void *opaque)
     s->bytes_in_flight += op->bytes;
     trace_mirror_one_iteration(s, op->offset, op->bytes);
 
-    ret = blk_co_preadv(source, op->offset, op->bytes, &op->qiov, 0);
+    ret = bdrv_co_preadv(s->mirror_top_bs->backing, op->offset, op->bytes,
+                         &op->qiov, 0);
     mirror_read_complete(op, ret);
 }
 
@@ -429,7 +428,7 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
 
 static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
 {
-    BlockDriverState *source = s->source;
+    BlockDriverState *source = s->mirror_top_bs->backing->bs;
     MirrorOp *pseudo_op;
     int64_t offset;
     uint64_t delay_ns = 0, ret = 0;
@@ -604,7 +603,7 @@ static void mirror_exit(BlockJob *job, void *opaque)
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
     MirrorExitData *data = opaque;
     AioContext *replace_aio_context = NULL;
-    BlockDriverState *src = s->source;
+    BlockDriverState *src = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     BlockDriverState *mirror_top_bs = s->mirror_top_bs;
     Error *local_err = NULL;
@@ -719,7 +718,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
 {
     int64_t offset;
     BlockDriverState *base = s->base;
-    BlockDriverState *bs = s->source;
+    BlockDriverState *bs = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     int ret;
     int64_t count;
@@ -801,7 +800,7 @@ static void coroutine_fn mirror_run(void *opaque)
 {
     MirrorBlockJob *s = opaque;
     MirrorExitData *data;
-    BlockDriverState *bs = s->source;
+    BlockDriverState *bs = s->mirror_top_bs->backing->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     bool need_drain = true;
     int64_t length;
@@ -1286,7 +1285,6 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     /* The block job now has a reference to this node */
     bdrv_unref(mirror_top_bs);
 
-    s->source = bs;
     s->mirror_top_bs = mirror_top_bs;
 
     /* No resize for the target either; while the mirror is still running, a
-- 
2.14.3
