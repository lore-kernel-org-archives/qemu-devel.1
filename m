Received: from eggs.gnu.org ([2001:4830:134:3::10]:49079)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhVEG-00006V-GU
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:21:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dhVEE-0003oB-AO
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 02:21:28 -0400
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Date: Tue, 15 Aug 2017 09:19:20 +0300
Message-Id: <20170815061921.31596-2-el13635@mail.ntua.gr>
In-Reply-To: <20170815061921.31596-1-el13635@mail.ntua.gr>
References: <20170815061921.31596-1-el13635@mail.ntua.gr>
Subject: [Qemu-devel] [PATCH 1/2] block: use internal filter node in backup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: qemu-block <qemu-block@nongnu.org>, Alberto Garcia <berto@igalia.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>

block/backup.c currently uses before write notifiers on the targeted
node. We can create a filter node instead to intercept write requests
for the backup job on the BDS level, instead of the BlockBackend level.

Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
---
 block.c                    |  89 +++++++++++++++++--
 block/backup.c             | 207 ++++++++++++++++++++++++++++++++++++++++-----
 block/io.c                 |  10 +--
 block/mirror.c             |   4 +-
 blockdev.c                 |   2 +-
 include/block/block.h      |   8 +-
 tests/qemu-iotests/141.out |   2 +-
 7 files changed, 277 insertions(+), 45 deletions(-)

diff --git a/block.c b/block.c
index 2de1c29eb3..81bd51b670 100644
--- a/block.c
+++ b/block.c
@@ -2088,6 +2088,38 @@ static void bdrv_parent_cb_resize(BlockDriverState *bs)
 }
 
 /*
+ * Sets the file link of a BDS. A new reference is created; callers
+ * which don't need their own reference any more must call bdrv_unref().
+ */
+void bdrv_set_file(BlockDriverState *bs, BlockDriverState *file_bs,
+                   Error **errp)
+{
+    if (file_bs) {
+        bdrv_ref(file_bs);
+    }
+
+    if (bs->file) {
+        bdrv_unref_child(bs, bs->file);
+    }
+
+    if (!file_bs) {
+        bs->file = NULL;
+        goto out;
+    }
+
+    bs->file = bdrv_attach_child(bs, file_bs, "file", &child_file,
+                                 errp);
+    if (!bs->file) {
+        bdrv_unref(file_bs);
+    }
+
+    bdrv_refresh_filename(bs);
+
+out:
+    bdrv_refresh_limits(bs, NULL);
+}
+
+/*
  * Sets the backing file link of a BDS. A new reference is created; callers
  * which don't need their own reference any more must call bdrv_unref().
  */
@@ -2355,12 +2387,12 @@ static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
         goto out;
     }
 
-    /* bdrv_append() consumes a strong reference to bs_snapshot
+    /* bdrv_append_backing() consumes a strong reference to bs_snapshot
      * (i.e. it will call bdrv_unref() on it) even on error, so in
      * order to be able to return one, we have to increase
      * bs_snapshot's refcount here */
     bdrv_ref(bs_snapshot);
-    bdrv_append(bs_snapshot, bs, &local_err);
+    bdrv_append_backing(bs_snapshot, bs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         bs_snapshot = NULL;
@@ -3142,7 +3174,7 @@ static bool should_update_child(BdrvChild *c, BlockDriverState *to)
         return false;
     }
 
-    if (c->role == &child_backing) {
+    if (c->role == &child_backing || c->role == &child_file) {
         /* If @from is a backing file of @to, ignore the child to avoid
          * creating a loop. We only want to change the pointer of other
          * parents. */
@@ -3213,6 +3245,45 @@ out:
 }
 
 /*
+ * Add new bs node at the top of a BDS chain while the chain is
+ * live, while keeping required fields on the top layer.
+ *
+ * This will modify the BlockDriverState fields, and swap contents
+ * between bs_new and bs_top. Both bs_new and bs_top are modified.
+ *
+ * bs_new must not be attached to a BlockBackend.
+ *
+ * bdrv_append_file() takes ownership of a bs_new reference and unrefs it
+ * because that's what the callers commonly need. bs_new will be referenced by
+ * the old parents of bs_top after bdrv_append_file() returns. If the caller
+ * needs to keep a reference of its own, it must call bdrv_ref().
+ */
+void bdrv_append_file(BlockDriverState *bs_new, BlockDriverState *bs_top,
+                      Error **errp)
+{
+    Error *local_err = NULL;
+
+    bdrv_ref(bs_top);
+    bdrv_set_file(bs_new, bs_top, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        bdrv_set_file(bs_new, NULL, &error_abort);
+        goto out;
+    }
+    bdrv_replace_node(bs_top, bs_new, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        goto out;
+    }
+
+    /* bs_new is now referenced by its new parents, we don't need the
+     * additional reference any more. */
+out:
+    bdrv_unref(bs_top);
+    bdrv_unref(bs_new);
+}
+
+/*
  * Add new bs contents at the top of an image chain while the chain is
  * live, while keeping required fields on the top layer.
  *
@@ -3223,13 +3294,13 @@ out:
  *
  * This function does not create any image files.
  *
- * bdrv_append() takes ownership of a bs_new reference and unrefs it because
- * that's what the callers commonly need. bs_new will be referenced by the old
- * parents of bs_top after bdrv_append() returns. If the caller needs to keep a
- * reference of its own, it must call bdrv_ref().
+ * bdrv_append_backing() takes ownership of a bs_new reference and unrefs it
+ * because that's what the callers commonly need. bs_new will be referenced by
+ * the old parents of bs_top after bdrv_append_backing() returns. If the caller
+ * needs to keep a reference of its own, it must call bdrv_ref().
  */
-void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
-                 Error **errp)
+void bdrv_append_backing(BlockDriverState *bs_new, BlockDriverState *bs_top,
+                         Error **errp)
 {
     Error *local_err = NULL;
 
diff --git a/block/backup.c b/block/backup.c
index 504a089150..0828d522b6 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -43,7 +43,7 @@ typedef struct BackupBlockJob {
     unsigned long *done_bitmap;
     int64_t cluster_size;
     bool compress;
-    NotifierWithReturn before_write;
+    BlockDriverState *filter;
     QLIST_HEAD(, CowRequest) inflight_reqs;
 } BackupBlockJob;
 
@@ -174,20 +174,6 @@ out:
     return ret;
 }
 
-static int coroutine_fn backup_before_write_notify(
-        NotifierWithReturn *notifier,
-        void *opaque)
-{
-    BackupBlockJob *job = container_of(notifier, BackupBlockJob, before_write);
-    BdrvTrackedRequest *req = opaque;
-
-    assert(req->bs == blk_bs(job->common.blk));
-    assert(QEMU_IS_ALIGNED(req->offset, BDRV_SECTOR_SIZE));
-    assert(QEMU_IS_ALIGNED(req->bytes, BDRV_SECTOR_SIZE));
-
-    return backup_do_cow(job, req->offset, req->bytes, NULL, true);
-}
-
 static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common);
@@ -202,7 +188,8 @@ static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
 static void backup_cleanup_sync_bitmap(BackupBlockJob *job, int ret)
 {
     BdrvDirtyBitmap *bm;
-    BlockDriverState *bs = blk_bs(job->common.blk);
+    BlockDriverState *bs = child_bs(blk_bs(job->common.blk));
+    assert(bs);
 
     if (ret < 0 || block_job_is_cancelled(&job->common)) {
         /* Merge the successor back into the parent, delete nothing. */
@@ -234,9 +221,31 @@ static void backup_abort(BlockJob *job)
 static void backup_clean(BlockJob *job)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common);
+    BlockDriverState *bs = child_bs(s->filter),
+                     *filter = s->filter;
+
     assert(s->target);
     blk_unref(s->target);
     s->target = NULL;
+
+    /* make sure nothing goes away while removing filter */
+    bdrv_ref(filter);
+    bdrv_ref(bs);
+    bdrv_drained_begin(bs);
+
+    block_job_remove_all_bdrv(job);
+    bdrv_child_try_set_perm(filter->file, 0, BLK_PERM_ALL,
+                            &error_abort);
+    bdrv_replace_node(filter, bs, &error_abort);
+
+    blk_remove_bs(job->blk);
+    blk_set_perm(job->blk, 0, BLK_PERM_ALL, &error_abort);
+    blk_insert_bs(job->blk, filter, &error_abort);
+
+    bdrv_drained_end(bs);
+    bdrv_unref(filter);
+    bdrv_unref(bs);
+    s->filter = NULL;
 }
 
 static void backup_attached_aio_context(BlockJob *job, AioContext *aio_context)
@@ -421,6 +430,18 @@ out:
     return ret;
 }
 
+static void backup_top_enable(BackupBlockJob *job)
+{
+    BlockDriverState *bs = job->filter;
+    bs->opaque = job;
+}
+
+static void backup_top_disable(BackupBlockJob *job)
+{
+    BlockDriverState *bs = job->filter;
+    bs->opaque = NULL;
+}
+
 static void coroutine_fn backup_run(void *opaque)
 {
     BackupBlockJob *job = opaque;
@@ -435,13 +456,12 @@ static void coroutine_fn backup_run(void *opaque)
     job->done_bitmap = bitmap_new(DIV_ROUND_UP(job->common.len,
                                                job->cluster_size));
 
-    job->before_write.notify = backup_before_write_notify;
-    bdrv_add_before_write_notifier(bs, &job->before_write);
+    backup_top_enable(job);
 
     if (job->sync_mode == MIRROR_SYNC_MODE_NONE) {
         while (!block_job_is_cancelled(&job->common)) {
-            /* Yield until the job is cancelled.  We just let our before_write
-             * notify callback service CoW requests. */
+            /* Yield until the job is cancelled.  We just let our backup_top
+             * filter service CoW requests. */
             block_job_yield(&job->common);
         }
     } else if (job->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
@@ -507,8 +527,7 @@ static void coroutine_fn backup_run(void *opaque)
             }
         }
     }
-
-    notifier_with_return_remove(&job->before_write);
+    backup_top_disable(job);
 
     /* wait until pending backup_do_cow() calls have completed */
     qemu_co_rwlock_wrlock(&job->flush_rwlock);
@@ -532,6 +551,124 @@ static const BlockJobDriver backup_job_driver = {
     .drain                  = backup_drain,
 };
 
+static int coroutine_fn backup_top_co_preadv(BlockDriverState *bs,
+                                             uint64_t offset,
+                                             uint64_t bytes,
+                                             QEMUIOVector *qiov, int flags)
+{
+    return bdrv_co_preadv(bs->file, offset, bytes, qiov, flags);
+}
+
+static int coroutine_fn backup_top_co_pwritev(BlockDriverState *bs,
+                                              uint64_t offset,
+                                              uint64_t bytes,
+                                              QEMUIOVector *qiov, int flags)
+{
+    int ret = 0;
+    BackupBlockJob *job = bs->opaque;
+    if (job) {
+        assert(bs == blk_bs(job->common.blk));
+        assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
+        ret = backup_do_cow(job, offset, bytes, NULL, true);
+    }
+
+    return ret < 0 ? ret : bdrv_co_pwritev(bs->file, offset, bytes,
+                                           qiov, flags);
+}
+
+static int coroutine_fn backup_top_co_pwrite_zeroes(BlockDriverState *bs,
+                                                    int64_t offset,
+                                                    int bytes,
+                                                    BdrvRequestFlags flags)
+{
+    int ret = 0;
+    BackupBlockJob *job = bs->opaque;
+    if (job) {
+        assert(bs == blk_bs(job->common.blk));
+        assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
+        ret = backup_do_cow(job, offset, bytes, NULL, true);
+    }
+
+    return ret < 0 ? ret : bdrv_co_pwrite_zeroes(bs->file, offset, bytes,
+                                                 flags);
+}
+
+static int coroutine_fn backup_top_co_pdiscard(BlockDriverState *bs,
+                                               int64_t offset, int bytes)
+{
+    int ret = 0;
+    BackupBlockJob *job = bs->opaque;
+    if (job) {
+        assert(bs == blk_bs(job->common.blk));
+        assert(QEMU_IS_ALIGNED(offset, BDRV_SECTOR_SIZE));
+        assert(QEMU_IS_ALIGNED(bytes, BDRV_SECTOR_SIZE));
+        ret = backup_do_cow(job, offset, bytes, NULL, true);
+    }
+
+    return ret < 0 ? ret : bdrv_co_pdiscard(bs->file->bs, offset, bytes);
+}
+
+static int backup_top_co_flush(BlockDriverState *bs)
+{
+    return bdrv_co_flush(bs->file->bs);
+}
+
+static int backup_top_open(BlockDriverState *bs, QDict *options,
+                           int flags, Error **errp)
+{
+    return 0;
+}
+
+static void backup_top_close(BlockDriverState *bs)
+{
+}
+
+static int64_t backup_top_getlength(BlockDriverState *bs)
+{
+    return bs->file ? bdrv_getlength(bs->file->bs) : 0;
+}
+
+static bool backup_recurse_is_first_non_filter(BlockDriverState *bs,
+                                               BlockDriverState *candidate)
+{
+    return bdrv_recurse_is_first_non_filter(bs->file->bs, candidate);
+}
+
+static int64_t coroutine_fn backup_co_get_block_status(BlockDriverState *bs,
+                                                       int64_t sector_num,
+                                                       int nb_sectors,
+                                                       int *pnum,
+                                                       BlockDriverState **file)
+{
+    assert(bs->file && bs->file->bs);
+    *pnum = nb_sectors;
+    *file = bs->file->bs;
+    return BDRV_BLOCK_RAW | BDRV_BLOCK_OFFSET_VALID |
+           (sector_num << BDRV_SECTOR_BITS);
+}
+static BlockDriver backup_top = {
+    .format_name                        =   "backup-top",
+    .instance_size                      =   sizeof(BackupBlockJob *),
+
+    .bdrv_open                          =   backup_top_open,
+    .bdrv_close                         =   backup_top_close,
+
+    .bdrv_co_flush                      =   backup_top_co_flush,
+    .bdrv_co_preadv                     =   backup_top_co_preadv,
+    .bdrv_co_pwritev                    =   backup_top_co_pwritev,
+    .bdrv_co_pwrite_zeroes              =   backup_top_co_pwrite_zeroes,
+    .bdrv_co_pdiscard                   =   backup_top_co_pdiscard,
+
+    .bdrv_getlength                     =   backup_top_getlength,
+    .bdrv_child_perm                    =   bdrv_filter_default_perms,
+    .bdrv_recurse_is_first_non_filter   =   backup_recurse_is_first_non_filter,
+    .bdrv_co_get_block_status           =   backup_co_get_block_status,
+
+    .is_filter                          =   true,
+};
+
 BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, int64_t speed,
                   MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap,
@@ -545,6 +682,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     int64_t len;
     BlockDriverInfo bdi;
     BackupBlockJob *job = NULL;
+    BlockDriverState *filter = NULL;
     int ret;
 
     assert(bs);
@@ -606,17 +744,33 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                          bdrv_get_device_name(bs));
         goto error;
     }
+    /* Setup before write filter */
+    filter =
+        bdrv_new_open_driver(&backup_top,
+                             NULL, bdrv_get_flags(bs), NULL, &error_abort);
+    filter->implicit = true;
+    filter->total_sectors = bs->total_sectors;
+    bdrv_set_aio_context(filter, bdrv_get_aio_context(bs));
+
+    /* Insert before write notifier in the BDS chain */
+    bdrv_ref(filter);
+    bdrv_drained_begin(bs);
+    bdrv_append_file(filter, bs, &error_abort);
+    bdrv_drained_end(bs);
 
     /* job->common.len is fixed, so we can't allow resize */
-    job = block_job_create(job_id, &backup_job_driver, bs,
+    job = block_job_create(job_id, &backup_job_driver, filter,
                            BLK_PERM_CONSISTENT_READ,
                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
                            BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD,
                            speed, creation_flags, cb, opaque, errp);
+    bdrv_unref(filter);
     if (!job) {
         goto error;
     }
 
+    job->filter = filter;
+
     /* The target must match the source in size, so no resize here either */
     job->target = blk_new(BLK_PERM_WRITE,
                           BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
@@ -675,6 +829,13 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     if (job) {
         backup_clean(&job->common);
         block_job_early_fail(&job->common);
+    } else {
+        /* don't leak filter if job creation failed */
+        if (filter) {
+            bdrv_child_try_set_perm(filter->file, 0, BLK_PERM_ALL,
+                                    &error_abort);
+            bdrv_replace_node(filter, bs, &error_abort);
+        }
     }
 
     return NULL;
diff --git a/block/io.c b/block/io.c
index 26003814eb..56aa67105a 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1332,7 +1332,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     BlockDriverState *bs = child->bs;
     BlockDriver *drv = bs->drv;
     bool waited;
-    int ret;
+    int ret = 0;
 
     int64_t start_sector = offset >> BDRV_SECTOR_BITS;
     int64_t end_sector = DIV_ROUND_UP(offset + bytes, BDRV_SECTOR_SIZE);
@@ -1359,9 +1359,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
     assert(child->perm & BLK_PERM_WRITE);
     assert(end_sector <= bs->total_sectors || child->perm & BLK_PERM_RESIZE);
 
-    ret = notifier_with_return_list_notify(&bs->before_write_notifiers, req);
-
-    if (!ret && bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
+    if (bs->detect_zeroes != BLOCKDEV_DETECT_ZEROES_OPTIONS_OFF &&
         !(flags & BDRV_REQ_ZERO_WRITE) && drv->bdrv_co_pwrite_zeroes &&
         qemu_iovec_is_zero(qiov)) {
         flags |= BDRV_REQ_ZERO_WRITE;
@@ -1370,9 +1368,7 @@ static int coroutine_fn bdrv_aligned_pwritev(BdrvChild *child,
         }
     }
 
-    if (ret < 0) {
-        /* Do nothing, write notifier decided to fail this request */
-    } else if (flags & BDRV_REQ_ZERO_WRITE) {
+    if (flags & BDRV_REQ_ZERO_WRITE) {
         bdrv_debug_event(bs, BLKDBG_PWRITEV_ZERO);
         ret = bdrv_co_do_pwrite_zeroes(bs, offset, bytes, flags);
     } else if (flags & BDRV_REQ_WRITE_COMPRESSED) {
diff --git a/block/mirror.c b/block/mirror.c
index e1a160e6ea..af7771e93a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1174,11 +1174,11 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     mirror_top_bs->total_sectors = bs->total_sectors;
     bdrv_set_aio_context(mirror_top_bs, bdrv_get_aio_context(bs));
 
-    /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
+    /* bdrv_append_backing() takes ownership of the mirror_top_bs reference, need to keep
      * it alive until block_job_create() succeeds even if bs has no parent. */
     bdrv_ref(mirror_top_bs);
     bdrv_drained_begin(bs);
-    bdrv_append(mirror_top_bs, bs, &local_err);
+    bdrv_append_backing(mirror_top_bs, bs, &local_err);
     bdrv_drained_end(bs);
 
     if (local_err) {
diff --git a/blockdev.c b/blockdev.c
index 5c11c245b0..8e2fc6e64c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1788,7 +1788,7 @@ static void external_snapshot_prepare(BlkActionState *common,
      * can fail, so we need to do it in .prepare; undoing it for abort is
      * always possible. */
     bdrv_ref(state->new_bs);
-    bdrv_append(state->new_bs, state->old_bs, &local_err);
+    bdrv_append_backing(state->new_bs, state->old_bs, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
diff --git a/include/block/block.h b/include/block/block.h
index d1f03cb48b..744b50e734 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -244,8 +244,10 @@ int bdrv_create(BlockDriver *drv, const char* filename,
                 QemuOpts *opts, Error **errp);
 int bdrv_create_file(const char *filename, QemuOpts *opts, Error **errp);
 BlockDriverState *bdrv_new(void);
-void bdrv_append(BlockDriverState *bs_new, BlockDriverState *bs_top,
-                 Error **errp);
+void bdrv_append_file(BlockDriverState *bs_new, BlockDriverState *bs_top,
+                      Error **errp);
+void bdrv_append_backing(BlockDriverState *bs_new, BlockDriverState *bs_top,
+                         Error **errp);
 void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
                        Error **errp);
 
@@ -256,6 +258,8 @@ BdrvChild *bdrv_open_child(const char *filename,
                            BlockDriverState* parent,
                            const BdrvChildRole *child_role,
                            bool allow_none, Error **errp);
+void bdrv_set_file(BlockDriverState *bs, BlockDriverState *file_bs,
+                   Error **errp);
 void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd,
                          Error **errp);
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index 82e763b68d..cc653c317a 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -9,7 +9,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/m.
 {"return": {}}
 Formatting 'TEST_DIR/o.IMGFMT', fmt=IMGFMT size=1048576 backing_file=TEST_DIR/t.IMGFMT backing_fmt=IMGFMT
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "Node drv0 is in use"}}
+{"error": {"class": "GenericError", "desc": "Block device drv0 is in use"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "BLOCK_JOB_CANCELLED", "data": {"device": "job0", "len": 1048576, "offset": 0, "speed": 0, "type": "backup"}}
 {"return": {}}
-- 
2.11.0
