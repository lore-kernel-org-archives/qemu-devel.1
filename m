Received: from eggs.gnu.org ([2001:4830:134:3::10]:43735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvL-0001Fo-3v
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBvG-0008NC-7P
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 10:00:15 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:38 +0100
Message-Id: <1487689130-30373-43-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 42/54] mirror: Use real permissions in
 mirror/active commit block job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

The mirror block job is mainly used for two different scenarios:
Mirroring to an otherwise unused, independent target node, or for active
commit where the target node is part of the backing chain of the source.

Similarly to the commit block job patch, we need to insert a new filter
node to keep the permissions correct during active commit.

Note that one change this implies is that job->blk points to
mirror_top_bs as its root now, and mirror_top_bs (rather than the actual
source node) contains the bs->job pointer. This requires qemu-img commit
to get the job by name now rather than just taking bs->job.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c             | 161 +++++++++++++++++++++++++++++++++++++--------
 qemu-img.c                 |   6 +-
 tests/qemu-iotests/141     |   2 +-
 tests/qemu-iotests/141.out |   4 +-
 4 files changed, 143 insertions(+), 30 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 767b7e7..252107d 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -38,7 +38,10 @@ typedef struct MirrorBlockJob {
     BlockJob common;
     RateLimit limit;
     BlockBackend *target;
+    BlockDriverState *mirror_top_bs;
+    BlockDriverState *source;
     BlockDriverState *base;
+
     /* The name of the graph node to replace */
     char *replaces;
     /* The BDS to replace */
@@ -325,7 +328,7 @@ static void mirror_do_zero_or_discard(MirrorBlockJob *s,
 
 static uint64_t coroutine_fn mirror_iteration(MirrorBlockJob *s)
 {
-    BlockDriverState *source = blk_bs(s->common.blk);
+    BlockDriverState *source = s->source;
     int64_t sector_num, first_chunk;
     uint64_t delay_ns = 0;
     /* At least the first dirty chunk is mirrored in one iteration. */
@@ -495,12 +498,14 @@ static void mirror_exit(BlockJob *job, void *opaque)
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
     MirrorExitData *data = opaque;
     AioContext *replace_aio_context = NULL;
-    BlockDriverState *src = blk_bs(s->common.blk);
+    BlockDriverState *src = s->source;
     BlockDriverState *target_bs = blk_bs(s->target);
+    BlockDriverState *mirror_top_bs = s->mirror_top_bs;
 
     /* Make sure that the source BDS doesn't go away before we called
      * block_job_completed(). */
     bdrv_ref(src);
+    bdrv_ref(mirror_top_bs);
 
     if (s->to_replace) {
         replace_aio_context = bdrv_get_aio_context(s->to_replace);
@@ -522,13 +527,6 @@ static void mirror_exit(BlockJob *job, void *opaque)
         bdrv_drained_begin(target_bs);
         bdrv_replace_in_backing_chain(to_replace, target_bs);
         bdrv_drained_end(target_bs);
-
-        /* We just changed the BDS the job BB refers to, so switch the BB back
-         * so the cleanup does the right thing. We don't need any permissions
-         * any more now. */
-        blk_remove_bs(job->blk);
-        blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
-        blk_insert_bs(job->blk, src, &error_abort);
     }
     if (s->to_replace) {
         bdrv_op_unblock_all(s->to_replace, s->replace_blocker);
@@ -541,9 +539,23 @@ static void mirror_exit(BlockJob *job, void *opaque)
     g_free(s->replaces);
     blk_unref(s->target);
     s->target = NULL;
+
+    /* Remove the mirror filter driver from the graph */
+    bdrv_replace_in_backing_chain(mirror_top_bs, backing_bs(mirror_top_bs));
+
+    /* We just changed the BDS the job BB refers to (with either or both of the
+     * bdrv_replace_in_backing_chain() calls), so switch the BB back so the
+     * cleanup does the right thing. We don't need any permissions any more
+     * now. */
+    blk_remove_bs(job->blk);
+    blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
+    blk_insert_bs(job->blk, mirror_top_bs, &error_abort);
+
     block_job_completed(&s->common, data->ret);
+
     g_free(data);
     bdrv_drained_end(src);
+    bdrv_unref(mirror_top_bs);
     bdrv_unref(src);
 }
 
@@ -563,7 +575,7 @@ static int coroutine_fn mirror_dirty_init(MirrorBlockJob *s)
 {
     int64_t sector_num, end;
     BlockDriverState *base = s->base;
-    BlockDriverState *bs = blk_bs(s->common.blk);
+    BlockDriverState *bs = s->source;
     BlockDriverState *target_bs = blk_bs(s->target);
     int ret, n;
 
@@ -642,7 +654,7 @@ static void coroutine_fn mirror_run(void *opaque)
 {
     MirrorBlockJob *s = opaque;
     MirrorExitData *data;
-    BlockDriverState *bs = blk_bs(s->common.blk);
+    BlockDriverState *bs = s->source;
     BlockDriverState *target_bs = blk_bs(s->target);
     bool need_drain = true;
     int64_t length;
@@ -876,7 +888,7 @@ static void mirror_complete(BlockJob *job, Error **errp)
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
     BlockDriverState *src, *target;
 
-    src = blk_bs(job->blk);
+    src = s->source;
     target = blk_bs(s->target);
 
     if (!s->synced) {
@@ -908,6 +920,10 @@ static void mirror_complete(BlockJob *job, Error **errp)
         replace_aio_context = bdrv_get_aio_context(s->to_replace);
         aio_context_acquire(replace_aio_context);
 
+        /* TODO Translate this into permission system. Current definition of
+         * GRAPH_MOD would require to request it for the parents; they might
+         * not even be BlockDriverStates, however, so a BdrvChild can't address
+         * them. May need redefinition of GRAPH_MOD. */
         error_setg(&s->replace_blocker,
                    "block device is in use by block-job-complete");
         bdrv_op_block_all(s->to_replace, s->replace_blocker);
@@ -978,6 +994,46 @@ static const BlockJobDriver commit_active_job_driver = {
     .drain                  = mirror_drain,
 };
 
+static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
+    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+{
+    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
+    uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
+{
+    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
+}
+
+static void bdrv_mirror_top_close(BlockDriverState *bs)
+{
+}
+
+static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
+                                       const BdrvChildRole *role,
+                                       uint64_t perm, uint64_t shared,
+                                       uint64_t *nperm, uint64_t *nshared)
+{
+    /* Must be able to forward guest writes to the real image */
+    *nperm = 0;
+    if (perm & BLK_PERM_WRITE) {
+        *nperm |= BLK_PERM_WRITE;
+    }
+
+    *nshared = BLK_PERM_ALL;
+}
+
+/* Dummy node that provides consistent read to its users without requiring it
+ * from its backing file and that allows writes on the backing file chain. */
+static BlockDriver bdrv_mirror_top = {
+    .format_name        = "mirror_top",
+    .bdrv_co_preadv     = bdrv_mirror_top_preadv,
+    .bdrv_co_pwritev    = bdrv_mirror_top_pwritev,
+    .bdrv_close         = bdrv_mirror_top_close,
+    .bdrv_child_perm    = bdrv_mirror_top_child_perm,
+};
+
 static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              int creation_flags, BlockDriverState *target,
                              const char *replaces, int64_t speed,
@@ -993,6 +1049,9 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              bool auto_complete)
 {
     MirrorBlockJob *s;
+    BlockDriverState *mirror_top_bs;
+    bool target_graph_mod;
+    bool target_is_backing;
     int ret;
 
     if (granularity == 0) {
@@ -1010,20 +1069,54 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         buf_size = DEFAULT_MIRROR_BUF_SIZE;
     }
 
-    /* FIXME Use real permissions */
-    s = block_job_create(job_id, driver, bs, 0, BLK_PERM_ALL, speed,
+    /* In the case of active commit, add dummy driver to provide consistent
+     * reads on the top, while disabling it in the intermediate nodes */
+    mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, NULL, BDRV_O_RDWR,
+                                         errp);
+    if (mirror_top_bs == NULL) {
+        return;
+    }
+    mirror_top_bs->total_sectors = bs->total_sectors;
+
+    /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
+     * it alive until block_job_create() even if bs has no parent. */
+    bdrv_ref(mirror_top_bs);
+    bdrv_drained_begin(bs);
+    bdrv_append(mirror_top_bs, bs);
+    bdrv_drained_end(bs);
+
+    /* Make sure that the source is not resized while the job is running */
+    s = block_job_create(job_id, driver, mirror_top_bs,
+                         BLK_PERM_CONSISTENT_READ,
+                         BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
+                         BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD, speed,
                          creation_flags, cb, opaque, errp);
+    bdrv_unref(mirror_top_bs);
     if (!s) {
-        return;
+        goto fail;
     }
-
-    /* FIXME Use real permissions */
-    s->target = blk_new(0, BLK_PERM_ALL);
+    s->source = bs;
+    s->mirror_top_bs = mirror_top_bs;
+
+    /* No resize for the target either; while the mirror is still running, a
+     * consistent read isn't necessarily possible. We could possibly allow
+     * writes and graph modifications, though it would likely defeat the
+     * purpose of a mirror, so leave them blocked for now.
+     *
+     * In the case of active commit, things look a bit different, though,
+     * because the target is an already populated backing file in active use.
+     * We can allow anything ecept resize there.*/
+    target_is_backing = bdrv_chain_contains(bs, target);
+    target_graph_mod = (backing_mode != MIRROR_LEAVE_BACKING_CHAIN);
+    s->target = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE |
+                        (target_graph_mod ? BLK_PERM_GRAPH_MOD : 0),
+                        BLK_PERM_WRITE_UNCHANGED |
+                        (target_is_backing ? BLK_PERM_CONSISTENT_READ |
+                                             BLK_PERM_WRITE |
+                                             BLK_PERM_GRAPH_MOD : 0));
     ret = blk_insert_bs(s->target, target, errp);
     if (ret < 0) {
-        blk_unref(s->target);
-        block_job_unref(&s->common);
-        return;
+        goto fail;
     }
 
     s->replaces = g_strdup(replaces);
@@ -1047,23 +1140,39 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    /* FIXME Use real permissions */
+    /* Required permissions are already taken with blk_new() */
     block_job_add_bdrv(&s->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
 
     /* In commit_active_start() all intermediate nodes disappear, so
      * any jobs in them must be blocked */
-    if (bdrv_chain_contains(bs, target)) {
+    if (target_is_backing) {
         BlockDriverState *iter;
         for (iter = backing_bs(bs); iter != target; iter = backing_bs(iter)) {
-            /* FIXME Use real permissions */
-            block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
-                               BLK_PERM_ALL, &error_abort);
+            /* XXX BLK_PERM_WRITE needs to be allowed so we don't block ourselves
+             * at s->base. The other options would be a second filter driver above
+             * s->base. */
+            ret = block_job_add_bdrv(&s->common, "intermediate node", iter, 0,
+                                     BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE,
+                                     errp);
+            if (ret < 0) {
+                goto fail;
+            }
         }
     }
 
     trace_mirror_start(bs, s, opaque);
     block_job_start(&s->common);
+    return;
+
+fail:
+    if (s) {
+        g_free(s->replaces);
+        blk_unref(s->target);
+        block_job_unref(&s->common);
+    }
+
+    bdrv_replace_in_backing_chain(mirror_top_bs, backing_bs(mirror_top_bs));
 }
 
 void mirror_start(const char *job_id, BlockDriverState *bs,
diff --git a/qemu-img.c b/qemu-img.c
index 8d9195e..e20830f 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -795,6 +795,8 @@ static void run_block_job(BlockJob *job, Error **errp)
 {
     AioContext *aio_context = blk_get_aio_context(job->blk);
 
+    /* FIXME In error cases, the job simply goes away and we access a dangling
+     * pointer below. */
     aio_context_acquire(aio_context);
     do {
         aio_poll(aio_context, true);
@@ -816,6 +818,7 @@ static int img_commit(int argc, char **argv)
     const char *filename, *fmt, *cache, *base;
     BlockBackend *blk;
     BlockDriverState *bs, *base_bs;
+    BlockJob *job;
     bool progress = false, quiet = false, drop = false;
     bool writethrough;
     Error *local_err = NULL;
@@ -951,7 +954,8 @@ static int img_commit(int argc, char **argv)
         bdrv_ref(bs);
     }
 
-    run_block_job(bs->job, &local_err);
+    job = block_job_get("commit");
+    run_block_job(job, &local_err);
     if (local_err) {
         goto unref_backing;
     }
diff --git a/tests/qemu-iotests/141 b/tests/qemu-iotests/141
index 3ba79f0..6d8f0a1 100755
--- a/tests/qemu-iotests/141
+++ b/tests/qemu-iotests/141
@@ -67,7 +67,7 @@ test_blockjob()
     _send_qemu_cmd $QEMU_HANDLE \
         "{'execute': 'x-blockdev-del',
           'arguments': {'node-name': 'drv0'}}" \
-        'error'
+        'error' | _filter_generated_node_ids
 
     _send_qemu_cmd $QEMU_HANDLE \
         "{'execute': 'block-job-cancel',
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 195ca1a..82e763b 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -20,7 +20,7 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
+{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is used as backing hd of 'NODE_NAME'"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
 {"return": {}}
@@ -30,7 +30,7 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
+{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is used as backing hd of 'NODE_NAME'"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
 {"return": {}}
-- 
1.8.3.1
