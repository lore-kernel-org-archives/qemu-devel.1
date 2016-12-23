Received: from eggs.gnu.org ([2001:4830:134:3::10]:37047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKRnZ-0006lZ-Bg
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 10:30:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKRnY-0004cU-6L
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 10:30:21 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:29:04 +0300
Message-ID: <1482503344-6424-22-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 21/21] backup: refactor: remove backup_do_cow()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com, jcody@redhat.com

Call backup_copy_cluster directly from backup_worker_co. Move io buffer
allocation to backup_worker_co (and do not reallocate it for each
cluster).

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c     | 28 +++++++++-------------------
 block/trace-events |  6 ++----
 2 files changed, 11 insertions(+), 23 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index b79a481..4a3a874 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -222,8 +222,6 @@ static void release_pending_notifiers(BackupBlockJob *job)
     }
 }
 
-static void coroutine_fn backup_do_cow(BackupBlockJob *job, int64_t cluster);
-
 /* Size of a cluster in sectors, instead of bytes. */
 static inline int64_t cluster_size_sectors(BackupBlockJob *job)
 {
@@ -403,9 +401,14 @@ static inline int64_t backup_get_work(BackupBlockJob *job)
     return cluster;
 }
 
+static void coroutine_fn backup_copy_cluster(BackupBlockJob *job,
+                                            int64_t cluster,
+                                            void *bounce_buffer);
+
 static void coroutine_fn backup_worker_co(void *opaque)
 {
     BackupBlockJob *job = opaque;
+    void *io_buf = blk_blockalign(job->common.blk, job->cluster_size);
 
     job->running_workers++;
     job->nb_busy_workers++;
@@ -424,12 +427,13 @@ static void coroutine_fn backup_worker_co(void *opaque)
             trace_backup_worker_stop(qemu_coroutine_self(),
                                      job->nb_busy_workers, job->running_workers,
                                      job->waiting_for_workers);
+            qemu_vfree(io_buf);
             return;
         case BACKUP_WORKER_PAUSE:
             backup_worker_pause(job);
             break;
         default:
-            backup_do_cow(job, cluster);
+            backup_copy_cluster(job, cluster, io_buf);
         }
     }
 }
@@ -546,8 +550,7 @@ static void coroutine_fn backup_copy_cluster(BackupBlockJob *job,
     int64_t sectors_per_cluster = cluster_size_sectors(job);
     int64_t offset = cluster * job->cluster_size;
 
-    trace_backup_do_cow_process(job, cluster);
-
+    trace_backup_copy_cluster_enter(job, qemu_coroutine_self(), cluster);
     n = MIN(sectors_per_cluster,
             job->common.len / BDRV_SECTOR_SIZE -
             cluster * sectors_per_cluster);
@@ -579,20 +582,7 @@ static void coroutine_fn backup_copy_cluster(BackupBlockJob *job,
      */
     job->sectors_read += n;
     job->common.offset += n * BDRV_SECTOR_SIZE;
-}
-
-static void coroutine_fn backup_do_cow(BackupBlockJob *job, int64_t cluster)
-{
-    BlockBackend *blk = job->common.blk;
-    void *bounce_buffer;
-
-    trace_backup_do_cow_enter(job, qemu_coroutine_self(), cluster);
-
-    bounce_buffer = blk_blockalign(blk, job->cluster_size);
-    backup_copy_cluster(job, cluster, bounce_buffer);
-    qemu_vfree(bounce_buffer);
-
-    trace_backup_do_cow_return(job, qemu_coroutine_self(), cluster);
+    trace_backup_copy_cluster_success(job, qemu_coroutine_self(), cluster);
 }
 
 static int coroutine_fn backup_before_write_notify(
diff --git a/block/trace-events b/block/trace-events
index 54cde28..770b407 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -40,10 +40,8 @@ mirror_yield_buf_busy(void *s, int nb_chunks, int in_flight) "s %p requested chu
 mirror_break_buf_busy(void *s, int nb_chunks, int in_flight) "s %p requested chunks %d in_flight %d"
 
 # block/backup.c
-backup_do_cow_enter(void *job, void *self, int64_t cluster) "job %p self %p cluster %"PRId64
-backup_do_cow_return(void *job, void *self, int64_t cluster) "job %p self %p cluster %"PRId64
-backup_do_cow_skip(void *job, int64_t cluster) "job %p cluster %"PRId64
-backup_do_cow_process(void *job, int64_t cluster) "job %p cluster %"PRId64
+backup_copy_cluster_enter(void *job, void *self, int64_t cluster) "job %p self %p cluster %"PRId64
+backup_copy_cluster_success(void *job, void *self, int64_t cluster) "job %p self %p cluster %"PRId64
 backup_do_read_fail(void *job, void *self, int64_t offset, unsigned bytes, int ret) "job %p self %p offset %"PRId64" bytes %u ret %d"
 backup_do_write_fail(void *job, void *self, int64_t offset, unsigned bytes, int ret) "job %p self %p offset %"PRId64" bytes %u ret %d"
 backup_job_wait_workers_start(void) ""
-- 
1.8.3.1
