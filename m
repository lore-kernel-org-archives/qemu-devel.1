Received: from eggs.gnu.org ([2001:4830:134:3::10]:59027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKTET-00010D-MG
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 12:02:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKTES-0005bM-Hw
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 12:02:13 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:28:49 +0300
Message-ID: <1482503344-6424-7-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 06/21] backup: rewrite top mode cluster skipping
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

TOP backup mode skips not allocated clusters. This patch mark skipped
clusters in copy_bitmap to prevent their writing in write notifier
(however, they may be written before skipping, but that is not
critical).

Also, update job->common.offset appropriately, to come eventually to
job->common.len.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 135 ++++++++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 104 insertions(+), 31 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 938b7df..e2b944a 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -53,6 +53,11 @@ static inline int64_t cluster_size_sectors(BackupBlockJob *job)
   return job->cluster_size / BDRV_SECTOR_SIZE;
 }
 
+static inline int64_t max_query_sectors(BackupBlockJob *job)
+{
+    return (INT_MAX & ~(job->cluster_size - 1)) >> BDRV_SECTOR_BITS;
+}
+
 /* See if in-flight requests overlap and wait for them to complete */
 static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
                                                        int64_t start,
@@ -374,6 +379,101 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
     return false;
 }
 
+static void backup_skip_clusters(BackupBlockJob *job,
+                                 int64_t start, int64_t end)
+{
+    CowRequest cow_request;
+
+    wait_for_overlapping_requests(job, start, end);
+    cow_request_begin(&cow_request, job, start, end);
+
+    if (end * job->cluster_size > job->common.len) {
+        int64_t n;
+        end--;
+        n = job->common.len - end * job->cluster_size;
+        assert(n > 0);
+
+        if (hbitmap_get(job->copy_bitmap, end)) {
+            hbitmap_reset(job->copy_bitmap, end, 1);
+            job->common.offset += n;
+        }
+    }
+
+    for ( ; start < end; start++) {
+        if (!hbitmap_get(job->copy_bitmap, start)) {
+            continue;
+        }
+
+        hbitmap_reset(job->copy_bitmap, start, 1);
+        job->common.offset += job->cluster_size;
+    }
+
+    cow_request_end(&cow_request);
+}
+
+static int backup_skip_unallocated_clusters(BackupBlockJob *job,
+                                            BlockDriverState *base,
+                                            int64_t start, int *n)
+{
+    int ret;
+    int64_t sectors_per_cluster = cluster_size_sectors(job);
+    BlockDriverState *bs = blk_bs(job->common.blk);
+    int64_t sector_end = job->common.len >> BDRV_SECTOR_BITS;
+    int64_t sector = start * sectors_per_cluster;
+    int max_sectors = MIN(max_query_sectors(job), sector_end - sector);
+    int n_sectors = 0;
+
+    ret = bdrv_is_allocated_above(bs, base, sector, max_sectors, &n_sectors);
+    if (ret < 0) {
+        return ret;
+    }
+
+    if (sector + n_sectors == sector_end || ret == 1) {
+        *n = DIV_ROUND_UP(n_sectors, sectors_per_cluster);
+    } else if (n_sectors < sectors_per_cluster) {
+        *n = 1;
+        ret = 1;
+    } else {
+        *n = n_sectors / sectors_per_cluster;
+    }
+
+    if (ret == 0) {
+        backup_skip_clusters(job, start, start + *n);
+    }
+
+    return 0;
+}
+
+static void backup_skip_loop(BackupBlockJob *job, BlockDriverState *base)
+{
+    HBitmapIter hbi;
+    int64_t cluster;
+    int64_t end = DIV_ROUND_UP(job->common.len, job->cluster_size);
+
+    hbitmap_iter_init(&hbi, job->copy_bitmap, 0);
+    while ((cluster = hbitmap_iter_next(&hbi)) != -1) {
+        int n, ret;
+
+        if (yield_and_check(job)) {
+            return;
+        }
+
+        ret = backup_skip_unallocated_clusters(job, base, cluster, &n);
+        if (ret < 0) {
+            n = 1;
+        }
+
+        cluster += n;
+        if (cluster >= end) {
+            return;
+        }
+
+        if (n > 1) {
+            hbitmap_iter_init(&hbi, job->copy_bitmap, cluster);
+        }
+    }
+}
+
 static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
 {
     int ret;
@@ -465,6 +565,10 @@ static void coroutine_fn backup_run(void *opaque)
         ret = backup_run_incremental(job);
     } else {
         hbitmap_set(job->copy_bitmap, 0, end);
+        if (job->sync_mode == MIRROR_SYNC_MODE_TOP) {
+            backup_skip_loop(job, backing_bs(blk_bs(job->common.blk)));
+        }
+
         /* Both FULL and TOP SYNC_MODE's require copying.. */
         for (; start < end; start++) {
             bool error_is_read;
@@ -472,37 +576,6 @@ static void coroutine_fn backup_run(void *opaque)
                 break;
             }
 
-            if (job->sync_mode == MIRROR_SYNC_MODE_TOP) {
-                int i, n;
-                int alloced = 0;
-
-                /* Check to see if these blocks are already in the
-                 * backing file. */
-
-                for (i = 0; i < sectors_per_cluster;) {
-                    /* bdrv_is_allocated() only returns true/false based
-                     * on the first set of sectors it comes across that
-                     * are are all in the same state.
-                     * For that reason we must verify each sector in the
-                     * backup cluster length.  We end up copying more than
-                     * needed but at some point that is always the case. */
-                    alloced =
-                        bdrv_is_allocated(bs,
-                                start * sectors_per_cluster + i,
-                                sectors_per_cluster - i, &n);
-                    i += n;
-
-                    if (alloced == 1 || n == 0) {
-                        break;
-                    }
-                }
-
-                /* If the above loop never found any sectors that are in
-                 * the topmost image, skip this backup. */
-                if (alloced == 0) {
-                    continue;
-                }
-            }
             /* FULL sync mode we copy the whole drive. */
             ret = backup_do_cow(job, start * sectors_per_cluster,
                                 sectors_per_cluster, &error_is_read, false);
-- 
1.8.3.1
