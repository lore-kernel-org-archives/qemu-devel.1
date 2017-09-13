Received: from eggs.gnu.org ([2001:4830:134:3::10]:36905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCH8-0008W0-1T
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:20:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCH6-0005Nj-Jw
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:20:37 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:19:00 +0200
Message-Id: <20170913181910.29688-9-mreitz@redhat.com>
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 08/18] block/mirror: Use source as a BdrvChild
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

With this, the mirror_top_bs is no longer just a technically required
node in the BDS graph but actually represents the block job operation.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 2ece38094d..9df4157511 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -43,8 +43,8 @@ typedef struct MirrorBlockJob {
     RateLimit limit;
     BlockBackend *target;
     BlockDriverState *mirror_top_bs;
-    BlockDriverState *source;
     BlockDriverState *base;
+    BdrvChild *source;
 
     /* The name of the graph node to replace */
     char *replaces;
@@ -294,7 +294,6 @@ static void coroutine_fn mirror_co_read(void *opaque)
 {
     MirrorOp *op = opaque;
     MirrorBlockJob *s = op->s;
-    BlockBackend *source = s->common.blk;
     int nb_chunks;
     uint64_t ret;
     uint64_t max_bytes;
@@ -344,7 +343,7 @@ static void coroutine_fn mirror_co_read(void *opaque)
     s->bytes_in_flight += op->bytes;
     trace_mirror_one_iteration(s, op->offset, op->bytes);
 
-    ret = blk_co_preadv(source, op->offset, op->bytes, &op->qiov, 0);
+    ret = bdrv_co_preadv(s->source, op->offset, op->bytes, &op->qiov, 0);
     mirror_read_complete(op, ret);
 }
 
@@ -416,7 +415,7 @@ static unsigned mirror_perform(MirrorBlockJob *s, int64_t offset,
 
 static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
 {
-    BlockDriverState *source = s->source;
+    BlockDriverState *source = s->source->bs;
     MirrorOp *pseudo_op;
     int64_t offset;
     uint64_t delay_ns = 0, ret = 0;
@@ -597,7 +596,7 @@ static void mirror_exit(BlockJob *job, void *opaque)
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
     MirrorExitData *data = opaque;
     AioContext *replace_aio_context = NULL;
-    BlockDriverState *src = s->source;
+    BlockDriverState *src = s->source->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     BlockDriverState *mirror_top_bs = s->mirror_top_bs;
     Error *local_err = NULL;
@@ -712,7 +711,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
 {
     int64_t sector_num, end;
     BlockDriverState *base = s->base;
-    BlockDriverState *bs = s->source;
+    BlockDriverState *bs = s->source->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     int ret, n;
     int64_t count;
@@ -802,7 +801,7 @@ static void coroutine_fn mirror_run(void *opaque)
 {
     MirrorBlockJob *s = opaque;
     MirrorExitData *data;
-    BlockDriverState *bs = s->source;
+    BlockDriverState *bs = s->source->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     bool need_drain = true;
     int64_t length;
@@ -1284,7 +1283,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     /* The block job now has a reference to this node */
     bdrv_unref(mirror_top_bs);
 
-    s->source = bs;
+    s->source = mirror_top_bs->backing;
     s->mirror_top_bs = mirror_top_bs;
 
     /* No resize for the target either; while the mirror is still running, a
@@ -1330,6 +1329,9 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         s->should_complete = true;
     }
 
+    s->source = mirror_top_bs->backing;
+    s->mirror_top_bs = mirror_top_bs;
+
     s->dirty_bitmap = bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
     if (!s->dirty_bitmap) {
         goto fail;
-- 
2.13.5
