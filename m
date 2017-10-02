Received: from eggs.gnu.org ([2001:4830:134:3::10]:52150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz1sX-0001Yd-V9
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dz1sW-00032K-L1
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:29 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:15308 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dz1sW-00031Z-8l
	for qemu-devel@nongnu.org; Mon, 02 Oct 2017 10:39:28 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon,  2 Oct 2017 17:39:16 +0300
Message-Id: <20171002143919.207741-3-vsementsov@virtuozzo.com>
In-Reply-To: <20171002143919.207741-1-vsementsov@virtuozzo.com>
References: <20171002143919.207741-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/5] backup: move from done_bitmap to
 copy_bitmap
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: jsnow@redhat.com, famz@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com
List-ID: <qemu-devel.nongnu.org>

Use HBitmap copy_bitmap instead of done_bitmap. This is needed to
improve incremental backup in following patches and to unify backup
loop for full/incremental modes in future patches.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/backup.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 06ddbfd03d..08efec639f 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -40,11 +40,12 @@ typedef struct BackupBlockJob {
     BlockdevOnError on_target_error;
     CoRwlock flush_rwlock;
     uint64_t bytes_read;
-    unsigned long *done_bitmap;
     int64_t cluster_size;
     bool compress;
     NotifierWithReturn before_write;
     QLIST_HEAD(, CowRequest) inflight_reqs;
+
+    HBitmap *copy_bitmap;
 } BackupBlockJob;
 
 /* See if in-flight requests overlap and wait for them to complete */
@@ -109,10 +110,11 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     cow_request_begin(&cow_request, job, start, end);
 
     for (; start < end; start += job->cluster_size) {
-        if (test_bit(start / job->cluster_size, job->done_bitmap)) {
+        if (!hbitmap_get(job->copy_bitmap, start / job->cluster_size)) {
             trace_backup_do_cow_skip(job, start);
             continue; /* already copied */
         }
+        hbitmap_reset(job->copy_bitmap, start / job->cluster_size, 1);
 
         trace_backup_do_cow_process(job, start);
 
@@ -132,6 +134,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
             if (error_is_read) {
                 *error_is_read = true;
             }
+            hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
             goto out;
         }
 
@@ -148,11 +151,10 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
             if (error_is_read) {
                 *error_is_read = false;
             }
+            hbitmap_set(job->copy_bitmap, start / job->cluster_size, 1);
             goto out;
         }
 
-        set_bit(start / job->cluster_size, job->done_bitmap);
-
         /* Publish progress, guest I/O counts as progress too.  Note that the
          * offset field is an opaque progress value, it is not a disk offset.
          */
@@ -260,7 +262,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
     }
 
     len = DIV_ROUND_UP(backup_job->common.len, backup_job->cluster_size);
-    bitmap_zero(backup_job->done_bitmap, len);
+    hbitmap_set(backup_job->copy_bitmap, 0, len);
 }
 
 void backup_wait_for_overlapping_requests(BlockJob *job, int64_t offset,
@@ -425,14 +427,15 @@ static void coroutine_fn backup_run(void *opaque)
     BackupBlockJob *job = opaque;
     BackupCompleteData *data;
     BlockDriverState *bs = blk_bs(job->common.blk);
-    int64_t offset;
+    int64_t offset, nb_clusters;
     int ret = 0;
 
     QLIST_INIT(&job->inflight_reqs);
     qemu_co_rwlock_init(&job->flush_rwlock);
 
-    job->done_bitmap = bitmap_new(DIV_ROUND_UP(job->common.len,
-                                               job->cluster_size));
+    nb_clusters = DIV_ROUND_UP(job->common.len, job->cluster_size);
+    job->copy_bitmap = hbitmap_alloc(nb_clusters, 0);
+    hbitmap_set(job->copy_bitmap, 0, nb_clusters);
 
     job->before_write.notify = backup_before_write_notify;
     bdrv_add_before_write_notifier(bs, &job->before_write);
@@ -512,7 +515,7 @@ static void coroutine_fn backup_run(void *opaque)
     /* wait until pending backup_do_cow() calls have completed */
     qemu_co_rwlock_wrlock(&job->flush_rwlock);
     qemu_co_rwlock_unlock(&job->flush_rwlock);
-    g_free(job->done_bitmap);
+    hbitmap_free(job->copy_bitmap);
 
     data = g_malloc(sizeof(*data));
     data->ret = ret;
-- 
2.11.1
