Received: from eggs.gnu.org ([2001:4830:134:3::10]:37181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCHV-0000LU-7D
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:21:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dsCHS-0005fV-W3
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:21:01 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Sep 2017 20:19:02 +0200
Message-Id: <20170913181910.29688-11-mreitz@redhat.com>
In-Reply-To: <20170913181910.29688-1-mreitz@redhat.com>
References: <20170913181910.29688-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH 10/18] block/mirror: Make source the file child
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

Regarding the source BDS, the mirror BDS is arguably a filter node.
Therefore, the source BDS should be its "file" child.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c             | 127 ++++++++++++++++++++++++++++++++++-----------
 block/qapi.c               |  25 ++++++---
 tests/qemu-iotests/141.out |   4 +-
 3 files changed, 119 insertions(+), 37 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 9df4157511..05410c94ca 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -77,8 +77,16 @@ typedef struct MirrorBlockJob {
     int target_cluster_size;
     int max_iov;
     bool initial_zeroing_ongoing;
+
+    /* Signals that we are no longer accessing source and target and the mirror
+     * BDS should thus relinquish all permissions */
+    bool exiting;
 } MirrorBlockJob;
 
+typedef struct MirrorBDSOpaque {
+    MirrorBlockJob *job;
+} MirrorBDSOpaque;
+
 struct MirrorOp {
     MirrorBlockJob *s;
     QEMUIOVector qiov;
@@ -595,12 +603,15 @@ static void mirror_exit(BlockJob *job, void *opaque)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
     MirrorExitData *data = opaque;
+    MirrorBDSOpaque *bs_opaque = s->mirror_top_bs->opaque;
     AioContext *replace_aio_context = NULL;
     BlockDriverState *src = s->source->bs;
     BlockDriverState *target_bs = blk_bs(s->target);
     BlockDriverState *mirror_top_bs = s->mirror_top_bs;
     Error *local_err = NULL;
 
+    s->exiting = true;
+
     bdrv_release_dirty_bitmap(src, s->dirty_bitmap);
 
     /* Make sure that the source BDS doesn't go away before we called
@@ -622,7 +633,7 @@ static void mirror_exit(BlockJob *job, void *opaque)
 
     /* We don't access the source any more. Dropping any WRITE/RESIZE is
      * required before it could become a backing file of target_bs. */
-    bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
+    bdrv_child_try_set_perm(mirror_top_bs->file, 0, BLK_PERM_ALL,
                             &error_abort);
     if (s->backing_mode == MIRROR_SOURCE_BACKING_CHAIN) {
         BlockDriverState *backing = s->is_none_mode ? src : s->base;
@@ -673,12 +684,11 @@ static void mirror_exit(BlockJob *job, void *opaque)
 
     /* Remove the mirror filter driver from the graph. Before this, get rid of
      * the blockers on the intermediate nodes so that the resulting state is
-     * valid. Also give up permissions on mirror_top_bs->backing, which might
+     * valid. Also give up permissions on mirror_top_bs->file, which might
      * block the removal. */
     block_job_remove_all_bdrv(job);
-    bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
-                            &error_abort);
-    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
+    bdrv_child_try_set_perm(mirror_top_bs->file, 0, BLK_PERM_ALL, &error_abort);
+    bdrv_replace_node(mirror_top_bs, mirror_top_bs->file->bs, &error_abort);
 
     /* We just changed the BDS the job BB refers to (with either or both of the
      * bdrv_replace_node() calls), so switch the BB back so the cleanup does
@@ -687,6 +697,7 @@ static void mirror_exit(BlockJob *job, void *opaque)
     blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
     blk_insert_bs(job->blk, mirror_top_bs, &error_abort);
 
+    bs_opaque->job = NULL;
     block_job_completed(&s->common, data->ret);
 
     g_free(data);
@@ -1102,7 +1113,7 @@ static void mirror_drain(BlockJob *job)
 {
     MirrorBlockJob *s = container_of(job, MirrorBlockJob, common);
 
-    /* Need to keep a reference in case blk_drain triggers execution
+    /* Need to keep a reference in case bdrv_drain triggers execution
      * of mirror_complete...
      */
     if (s->target) {
@@ -1135,44 +1146,88 @@ static const BlockJobDriver commit_active_job_driver = {
     .drain                  = mirror_drain,
 };
 
+static void source_child_inherit_fmt_options(int *child_flags,
+                                             QDict *child_options,
+                                             int parent_flags,
+                                             QDict *parent_options)
+{
+    child_backing.inherit_options(child_flags, child_options,
+                                  parent_flags, parent_options);
+}
+
+static char *source_child_get_parent_desc(BdrvChild *c)
+{
+    return child_backing.get_parent_desc(c);
+}
+
+static void source_child_cb_drained_begin(BdrvChild *c)
+{
+    BlockDriverState *bs = c->opaque;
+    MirrorBDSOpaque *s = bs->opaque;
+
+    if (s && s->job) {
+        block_job_drained_begin(&s->job->common);
+    }
+    bdrv_drained_begin(bs);
+}
+
+static void source_child_cb_drained_end(BdrvChild *c)
+{
+    BlockDriverState *bs = c->opaque;
+    MirrorBDSOpaque *s = bs->opaque;
+
+    if (s && s->job) {
+        block_job_drained_end(&s->job->common);
+    }
+    bdrv_drained_end(bs);
+}
+
+static BdrvChildRole source_child_role = {
+    .inherit_options    = source_child_inherit_fmt_options,
+    .get_parent_desc    = source_child_get_parent_desc,
+    .drained_begin      = source_child_cb_drained_begin,
+    .drained_end        = source_child_cb_drained_end,
+};
+
 static int coroutine_fn bdrv_mirror_top_preadv(BlockDriverState *bs,
     uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
-    return bdrv_co_preadv(bs->backing, offset, bytes, qiov, flags);
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
 }
 
 static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
     uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags)
 {
-    return bdrv_co_pwritev(bs->backing, offset, bytes, qiov, flags);
+    return bdrv_co_pwritev(bs->file, offset, bytes, qiov, flags);
 }
 
 static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
 {
-    return bdrv_co_flush(bs->backing->bs);
+    return bdrv_co_flush(bs->file->bs);
 }
 
 static int coroutine_fn bdrv_mirror_top_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags)
 {
-    return bdrv_co_pwrite_zeroes(bs->backing, offset, bytes, flags);
+    return bdrv_co_pwrite_zeroes(bs->file, offset, bytes, flags);
 }
 
 static int coroutine_fn bdrv_mirror_top_pdiscard(BlockDriverState *bs,
     int64_t offset, int bytes)
 {
-    return bdrv_co_pdiscard(bs->backing->bs, offset, bytes);
+    return bdrv_co_pdiscard(bs->file->bs, offset, bytes);
 }
 
 static void bdrv_mirror_top_refresh_filename(BlockDriverState *bs, QDict *opts)
 {
-    bdrv_refresh_filename(bs->backing->bs);
     pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
-            bs->backing->bs->filename);
+            bs->file->bs->filename);
 }
 
 static void bdrv_mirror_top_close(BlockDriverState *bs)
 {
+    bdrv_unref_child(bs, bs->file);
+    bs->file = NULL;
 }
 
 static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
@@ -1180,6 +1235,14 @@ static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
 {
+    MirrorBDSOpaque *s = bs->opaque;
+
+    if (s->job && s->job->exiting) {
+        *nperm = 0;
+        *nshared = BLK_PERM_ALL;
+        return;
+    }
+
     /* Must be able to forward guest writes to the real image */
     *nperm = 0;
     if (perm & BLK_PERM_WRITE) {
@@ -1190,7 +1253,7 @@ static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
 }
 
 /* Dummy node that provides consistent read to its users without requiring it
- * from its backing file and that allows writes on the backing file chain. */
+ * from its source file and that allows writes on the source file. */
 static BlockDriver bdrv_mirror_top = {
     .format_name                = "mirror_top",
     .bdrv_co_preadv             = bdrv_mirror_top_preadv,
@@ -1198,7 +1261,7 @@ static BlockDriver bdrv_mirror_top = {
     .bdrv_co_pwrite_zeroes      = bdrv_mirror_top_pwrite_zeroes,
     .bdrv_co_pdiscard           = bdrv_mirror_top_pdiscard,
     .bdrv_co_flush              = bdrv_mirror_top_flush,
-    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_backing,
+    .bdrv_co_get_block_status   = bdrv_co_get_block_status_from_file,
     .bdrv_refresh_filename      = bdrv_mirror_top_refresh_filename,
     .bdrv_close                 = bdrv_mirror_top_close,
     .bdrv_child_perm            = bdrv_mirror_top_child_perm,
@@ -1221,6 +1284,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                              Error **errp)
 {
     MirrorBlockJob *s;
+    MirrorBDSOpaque *bs_opaque;
     BlockDriverState *mirror_top_bs;
     bool target_graph_mod;
     bool target_is_backing;
@@ -1244,9 +1308,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         buf_size = DEFAULT_MIRROR_BUF_SIZE;
     }
 
-    /* In the case of active commit, add dummy driver to provide consistent
-     * reads on the top, while disabling it in the intermediate nodes, and make
-     * the backing chain writable. */
+    /* Create mirror BDS */
     mirror_top_bs = bdrv_new_open_driver(&bdrv_mirror_top, filter_node_name,
                                          BDRV_O_RDWR, errp);
     if (mirror_top_bs == NULL) {
@@ -1256,14 +1318,19 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         mirror_top_bs->implicit = true;
     }
     mirror_top_bs->total_sectors = bs->total_sectors;
+    bs_opaque = g_new0(MirrorBDSOpaque, 1);
+    mirror_top_bs->opaque = bs_opaque;
     bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
 
-    /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
-     * it alive until block_job_create() succeeds even if bs has no parent. */
-    bdrv_ref(mirror_top_bs);
-    bdrv_drained_begin(bs);
-    bdrv_append(mirror_top_bs, bs, &local_err);
-    bdrv_drained_end(bs);
+    /* Create reference for bdrv_attach_child() */
+    bdrv_ref(bs);
+    mirror_top_bs->file = bdrv_attach_child(mirror_top_bs, bs, "file",
+                                            &source_child_role, &local_err);
+    if (!local_err) {
+        bdrv_drained_begin(bs);
+        bdrv_replace_node(bs, mirror_top_bs, &local_err);
+        bdrv_drained_end(bs);
+    }
 
     if (local_err) {
         bdrv_unref(mirror_top_bs);
@@ -1280,6 +1347,8 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     if (!s) {
         goto fail;
     }
+    bs_opaque->job = s;
+
     /* The block job now has a reference to this node */
     bdrv_unref(mirror_top_bs);
 
@@ -1329,7 +1398,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
         s->should_complete = true;
     }
 
-    s->source = mirror_top_bs->backing;
+    s->source = mirror_top_bs->file;
     s->mirror_top_bs = mirror_top_bs;
 
     s->dirty_bitmap = bdrv_create_dirty_bitmap(bs, granularity, NULL, errp);
@@ -1373,12 +1442,12 @@ fail:
 
         g_free(s->replaces);
         blk_unref(s->target);
-        block_job_early_fail(&s->common);
+        bs_opaque->job = NULL;
+        block_job_unref(&s->common);
     }
 
-    bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
-                            &error_abort);
-    bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
+    bdrv_child_try_set_perm(mirror_top_bs->file, 0, BLK_PERM_ALL, &error_abort);
+    bdrv_replace_node(mirror_top_bs, mirror_top_bs->file->bs, &error_abort);
 
     bdrv_unref(mirror_top_bs);
 }
diff --git a/block/qapi.c b/block/qapi.c
index 7fa2437923..ee792d0cbc 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -147,9 +147,13 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
 
         /* Skip automatically inserted nodes that the user isn't aware of for
          * query-block (blk != NULL), but not for query-named-block-nodes */
-        while (blk && bs0->drv && bs0->implicit) {
-            bs0 = backing_bs(bs0);
-            assert(bs0);
+        while (blk && bs0 && bs0->drv && bs0->implicit) {
+            if (bs0->backing) {
+                bs0 = backing_bs(bs0);
+            } else {
+                assert(bs0->file);
+                bs0 = bs0->file->bs;
+            }
         }
     }
 
@@ -337,7 +341,12 @@ static void bdrv_query_info(BlockBackend *blk, BlockInfo **p_info,
 
     /* Skip automatically inserted nodes that the user isn't aware of */
     while (bs && bs->drv && bs->implicit) {
-        bs = backing_bs(bs);
+        if (bs->backing) {
+            bs = backing_bs(bs);
+        } else {
+            assert(bs->file);
+            bs = bs->file->bs;
+        }
     }
 
     info->device = g_strdup(blk_name(blk));
@@ -466,8 +475,12 @@ static BlockStats *bdrv_query_bds_stats(BlockDriverState *bs,
      * a BlockBackend-level command. Stay at the exact node for a node-level
      * command. */
     while (blk_level && bs->drv && bs->implicit) {
-        bs = backing_bs(bs);
-        assert(bs);
+        if (bs->backing) {
+            bs = backing_bs(bs);
+        } else {
+            assert(bs->file);
+            bs = bs->file->bs;
+        }
     }
 
     if (bdrv_get_node_name(bs)[0]) {
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 82e763b68d..8c4dd6d531 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -20,7 +20,7 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is used as backing hd of 'NODE_NAME'"}}
+{"error": {"class": "GenericError", "desc": "Block device drv0 is in use"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "mirror"}}
 {"return": {}}
@@ -30,7 +30,7 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node is used as backing hd of 'NODE_NAME'"}}
+{"error": {"class": "GenericError", "desc": "Block device drv0 is in use"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_COMPLETED", "data": {"device": "job0", "len": 0, "offset": 0, "speed": 0, "type": "commit"}}
 {"return": {}}
-- 
2.13.5
