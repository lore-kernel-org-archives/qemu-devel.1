Received: from eggs.gnu.org ([2001:4830:134:3::10]:40384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSN-0004qe-MQ
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1g6vSK-0002Kl-BC
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 06:29:39 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  1 Oct 2018 13:29:14 +0300
Message-Id: <20181001102928.20533-5-vsementsov@virtuozzo.com>
In-Reply-To: <20181001102928.20533-1-vsementsov@virtuozzo.com>
References: <20181001102928.20533-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 04/18] block/backup: move from HBitmap to
 BdrvDirtyBitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com, stefanha@redhat.com, jsnow@redhat.com, famz@redhat.com, jcody@redhat.com, mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

This is a necessary step to share copy-bitmap between backup job and
special filter driver in further commit.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 73 ++++++++++++++++++++++++++++----------------------
 1 file changed, 41 insertions(+), 32 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index fbe7ce19e1..45212d54c9 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -51,7 +51,7 @@ typedef struct BackupBlockJob {
     NotifierWithReturn before_write;
     QLIST_HEAD(, CowRequest) inflight_reqs;
 
-    HBitmap *copy_bitmap;
+    BdrvDirtyBitmap *copy_bitmap;
     bool use_copy_range;
     int64_t copy_range_size;
 
@@ -114,7 +114,8 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
     int read_flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
-    hbitmap_reset(job->copy_bitmap, start / job->cluster_size, 1);
+    assert(start % job->cluster_size == 0);
+    bdrv_reset_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
     nbytes = MIN(job->cluster_size, job->len - start);
     if (!*bounce_buffer) {
         *bounce_buffer = blk_blockalign(blk, job->cluster_size);
@@ -150,7 +151,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
 
     return nbytes;
 fail:
-    hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
+    bdrv_set_dirty_bitmap(job->copy_bitmap, start, job->cluster_size);
     return ret;
 
 }
@@ -170,16 +171,17 @@ static int coroutine_fn backup_cow_with_offload(BackupBlockJob *job,
     int write_flags = job->serialize_target_writes ? BDRV_REQ_SERIALISING : 0;
 
     assert(QEMU_IS_ALIGNED(job->copy_range_size, job->cluster_size));
+    assert(QEMU_IS_ALIGNED(start, job->cluster_size));
     nbytes = MIN(job->copy_range_size, end - start);
     nr_clusters = DIV_ROUND_UP(nbytes, job->cluster_size);
-    hbitmap_reset(job->copy_bitmap, start / job->cluster_size,
-                  nr_clusters);
+    bdrv_reset_dirty_bitmap(job->copy_bitmap, start,
+                            job->cluster_size * nr_clusters);
     ret = blk_co_copy_range(blk, start, job->target, start, nbytes,
                             read_flags, write_flags);
     if (ret < 0) {
         trace_backup_do_cow_copy_range_fail(job, start, ret);
-        hbitmap_set(job->copy_bitmap, start / job->cluster_size,
-                    nr_clusters);
+        bdrv_set_dirty_bitmap(job->copy_bitmap, start,
+                              job->cluster_size * nr_clusters);
         return ret;
     }
 
@@ -207,7 +209,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     cow_request_begin(&cow_request, job, start, end);
 
     while (start < end) {
-        if (!hbitmap_get(job->copy_bitmap, start / job->cluster_size)) {
+        if (!bdrv_get_dirty_locked(NULL, job->copy_bitmap, start)) {
             trace_backup_do_cow_skip(job, start);
             start += job->cluster_size;
             continue; /* already copied */
@@ -303,6 +305,11 @@ static void backup_clean(Job *job)
     assert(s->target);
     blk_unref(s->target);
     s->target = NULL;
+
+    if (s->copy_bitmap) {
+        bdrv_release_dirty_bitmap(blk_bs(s->common.blk), s->copy_bitmap);
+        s->copy_bitmap = NULL;
+    }
 }
 
 static void backup_attached_aio_context(BlockJob *job, AioContext *aio_context)
@@ -315,7 +322,6 @@ static void backup_attached_aio_context(BlockJob *job, AioContext *aio_context)
 void backup_do_checkpoint(BlockJob *job, Error **errp)
 {
     BackupBlockJob *backup_job = container_of(job, BackupBlockJob, common);
-    int64_t len;
 
     assert(block_job_driver(job) == &backup_job_driver);
 
@@ -325,8 +331,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
         return;
     }
 
-    len = DIV_ROUND_UP(backup_job->len, backup_job->cluster_size);
-    hbitmap_set(backup_job->copy_bitmap, 0, len);
+    bdrv_set_dirty_bitmap(backup_job->copy_bitmap, 0, backup_job->len);
 }
 
 static void backup_drain(BlockJob *job)
@@ -379,28 +384,30 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
 
 static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
 {
-    int ret;
+    int ret = 0;
     bool error_is_read;
-    int64_t cluster;
-    HBitmapIter hbi;
+    int64_t offset;
+    BdrvDirtyBitmapIter *dbi = bdrv_dirty_iter_new(job->copy_bitmap);
 
-    hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
-    while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
+    while ((offset = bdrv_dirty_iter_next(dbi)) != -1) {
         do {
             if (yield_and_check(job)) {
-                return 0;
+                goto out;
             }
-            ret = backup_do_cow(job, cluster * job->cluster_size,
+            ret = backup_do_cow(job, offset,
                                 job->cluster_size, &error_is_read, false);
             if (ret < 0 && backup_error_action(job, error_is_read, -ret) ==
                            BLOCK_ERROR_ACTION_REPORT)
             {
-                return ret;
+                goto out;
             }
         } while (ret < 0);
     }
 
-    return 0;
+out:
+    bdrv_dirty_iter_free(dbi);
+
+    return ret;
 }
 
 /* init copy_bitmap from sync_bitmap */
@@ -412,12 +419,9 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
     while (bdrv_dirty_bitmap_next_dirty_area(job->sync_bitmap,
                                              &offset, &bytes))
     {
-        uint64_t cluster = offset / job->cluster_size;
-        uint64_t last_cluster = (offset + bytes) / job->cluster_size;
+        bdrv_set_dirty_bitmap(job->copy_bitmap, offset, bytes);
 
-        hbitmap_set(job->copy_bitmap, cluster, last_cluster - cluster + 1);
-
-        offset = (last_cluster + 1) * job->cluster_size;
+        offset += bytes;
         if (offset >= job->len) {
             break;
         }
@@ -426,30 +430,29 @@ static void backup_incremental_init_copy_bitmap(BackupBlockJob *job)
 
     /* TODO job_progress_set_remaining() would make more sense */
     job_progress_update(&job->common.job,
-        job->len - hbitmap_count(job->copy_bitmap) * job->cluster_size);
+        job->len - bdrv_get_dirty_count(job->copy_bitmap));
 }
 
 static int coroutine_fn backup_run(Job *job, Error **errp)
 {
     BackupBlockJob *s = container_of(job, BackupBlockJob, common.job);
     BlockDriverState *bs = blk_bs(s->common.blk);
-    int64_t offset, nb_clusters;
+    int64_t offset;
     int ret = 0;
 
     QLIST_INIT(&s->inflight_reqs);
     qemu_co_rwlock_init(&s->flush_rwlock);
 
-    nb_clusters = DIV_ROUND_UP(s->len, s->cluster_size);
     job_progress_set_remaining(job, s->len);
 
-    s->copy_bitmap = hbitmap_alloc(nb_clusters, 0);
+    bdrv_disable_dirty_bitmap(s->copy_bitmap);
+
     if (s->sync_mode == MIRROR_SYNC_MODE_INCREMENTAL) {
         backup_incremental_init_copy_bitmap(s);
     } else {
-        hbitmap_set(s->copy_bitmap, 0, nb_clusters);
+        bdrv_set_dirty_bitmap(s->copy_bitmap, 0, s->len);
     }
 
-
     s->before_write.notify = backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &s->before_write);
 
@@ -530,7 +533,6 @@ static int coroutine_fn backup_run(Job *job, Error **errp)
     /* wait until pending backup_do_cow() calls have completed */
     qemu_co_rwlock_wrlock(&s->flush_rwlock);
     qemu_co_rwlock_unlock(&s->flush_rwlock);
-    hbitmap_free(s->copy_bitmap);
 
     return ret;
 }
@@ -681,6 +683,13 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     } else {
         job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
     }
+
+    job->copy_bitmap = bdrv_create_dirty_bitmap(bs, job->cluster_size,
+                                                NULL, errp);
+    if (!job->copy_bitmap) {
+        goto error;
+    }
+
     job->use_copy_range = true;
     job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
                                         blk_get_max_transfer(job->target));
-- 
2.18.0
