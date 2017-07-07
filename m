Received: from eggs.gnu.org ([2001:4830:134:3::10]:45637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSdu-00012v-DW
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSdt-0000pH-7W
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:45:54 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 07:44:55 -0500
Message-Id: <20170707124459.10269-18-eblake@redhat.com>
In-Reply-To: <20170707124459.10269-1-eblake@redhat.com>
References: <20170707124459.10269-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 17/21] backup: Switch backup_do_cow() to
 byte-based
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Convert another internal
function (no semantic change).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>

---
v2-v5: no change
---
 block/backup.c | 62 ++++++++++++++++++++++++----------------------------------
 1 file changed, 26 insertions(+), 36 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 503fbec..f7e14db 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -91,7 +91,7 @@ static void cow_request_end(CowRequest *req)
 }

 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
-                                      int64_t sector_num, int nb_sectors,
+                                      int64_t offset, uint64_t bytes,
                                       bool *error_is_read,
                                       bool is_write_notifier)
 {
@@ -101,34 +101,28 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
     QEMUIOVector bounce_qiov;
     void *bounce_buffer = NULL;
     int ret = 0;
-    int64_t sectors_per_cluster = cluster_size_sectors(job);
-    int64_t start, end; /* clusters */
+    int64_t start, end; /* bytes */
     int n; /* bytes */

     qemu_co_rwlock_rdlock(&job->flush_rwlock);

-    start = sector_num / sectors_per_cluster;
-    end = DIV_ROUND_UP(sector_num + nb_sectors, sectors_per_cluster);
+    start = QEMU_ALIGN_DOWN(offset, job->cluster_size);
+    end = QEMU_ALIGN_UP(bytes + offset, job->cluster_size);

-    trace_backup_do_cow_enter(job, start * job->cluster_size,
-                              sector_num * BDRV_SECTOR_SIZE,
-                              nb_sectors * BDRV_SECTOR_SIZE);
+    trace_backup_do_cow_enter(job, start, offset, bytes);

-    wait_for_overlapping_requests(job, start * job->cluster_size,
-                                  end * job->cluster_size);
-    cow_request_begin(&cow_request, job, start * job->cluster_size,
-                      end * job->cluster_size);
+    wait_for_overlapping_requests(job, start, end);
+    cow_request_begin(&cow_request, job, start, end);

-    for (; start < end; start++) {
-        if (test_bit(start, job->done_bitmap)) {
-            trace_backup_do_cow_skip(job, start * job->cluster_size);
+    for (; start < end; start += job->cluster_size) {
+        if (test_bit(start / job->cluster_size, job->done_bitmap)) {
+            trace_backup_do_cow_skip(job, start);
             continue; /* already copied */
         }

-        trace_backup_do_cow_process(job, start * job->cluster_size);
+        trace_backup_do_cow_process(job, start);

-        n = MIN(job->cluster_size,
-                job->common.len - start * job->cluster_size);
+        n = MIN(job->cluster_size, job->common.len - start);

         if (!bounce_buffer) {
             bounce_buffer = blk_blockalign(blk, job->cluster_size);
@@ -137,11 +131,10 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         iov.iov_len = n;
         qemu_iovec_init_external(&bounce_qiov, &iov, 1);

-        ret = blk_co_preadv(blk, start * job->cluster_size,
-                            bounce_qiov.size, &bounce_qiov,
+        ret = blk_co_preadv(blk, start, bounce_qiov.size, &bounce_qiov,
                             is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0);
         if (ret < 0) {
-            trace_backup_do_cow_read_fail(job, start * job->cluster_size, ret);
+            trace_backup_do_cow_read_fail(job, start, ret);
             if (error_is_read) {
                 *error_is_read = true;
             }
@@ -149,22 +142,22 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
         }

         if (buffer_is_zero(iov.iov_base, iov.iov_len)) {
-            ret = blk_co_pwrite_zeroes(job->target, start * job->cluster_size,
+            ret = blk_co_pwrite_zeroes(job->target, start,
                                        bounce_qiov.size, BDRV_REQ_MAY_UNMAP);
         } else {
-            ret = blk_co_pwritev(job->target, start * job->cluster_size,
+            ret = blk_co_pwritev(job->target, start,
                                  bounce_qiov.size, &bounce_qiov,
                                  job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
         }
         if (ret < 0) {
-            trace_backup_do_cow_write_fail(job, start * job->cluster_size, ret);
+            trace_backup_do_cow_write_fail(job, start, ret);
             if (error_is_read) {
                 *error_is_read = false;
             }
             goto out;
         }

-        set_bit(start, job->done_bitmap);
+        set_bit(start / job->cluster_size, job->done_bitmap);

         /* Publish progress, guest I/O counts as progress too.  Note that the
          * offset field is an opaque progress value, it is not a disk offset.
@@ -180,8 +173,7 @@ out:

     cow_request_end(&cow_request);

-    trace_backup_do_cow_return(job, sector_num * BDRV_SECTOR_SIZE,
-                               nb_sectors * BDRV_SECTOR_SIZE, ret);
+    trace_backup_do_cow_return(job, offset, bytes, ret);

     qemu_co_rwlock_unlock(&job->flush_rwlock);

@@ -194,14 +186,12 @@ static int coroutine_fn backup_before_write_notify(
 {
     BackupBlockJob *job = container_of(notifier, BackupBlockJob, before_write);
     BdrvTrackedRequest *req = opaque;
-    int64_t sector_num = req->offset >> BDRV_SECTOR_BITS;
-    int nb_sectors = req->bytes >> BDRV_SECTOR_BITS;

     assert(req->bs == blk_bs(job->common.blk));
-    assert((req->offset & (BDRV_SECTOR_SIZE - 1)) == 0);
-    assert((req->bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
+    assert(QEMU_IS_ALIGNED(req->offset, BDRV_SECTOR_SIZE));
+    assert(QEMU_IS_ALIGNED(req->bytes, BDRV_SECTOR_SIZE));

-    return backup_do_cow(job, sector_num, nb_sectors, NULL, true);
+    return backup_do_cow(job, req->offset, req->bytes, NULL, true);
 }

 static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
@@ -406,8 +396,8 @@ static int coroutine_fn backup_run_incremental(BackupBlockJob *job)
                 if (yield_and_check(job)) {
                     goto out;
                 }
-                ret = backup_do_cow(job, cluster * sectors_per_cluster,
-                                    sectors_per_cluster, &error_is_read,
+                ret = backup_do_cow(job, cluster * job->cluster_size,
+                                    job->cluster_size, &error_is_read,
                                     false);
                 if ((ret < 0) &&
                     backup_error_action(job, error_is_read, -ret) ==
@@ -509,8 +499,8 @@ static void coroutine_fn backup_run(void *opaque)
             if (alloced < 0) {
                 ret = alloced;
             } else {
-                ret = backup_do_cow(job, start * sectors_per_cluster,
-                                    sectors_per_cluster, &error_is_read,
+                ret = backup_do_cow(job, start * job->cluster_size,
+                                    job->cluster_size, &error_is_read,
                                     false);
             }
             if (ret < 0) {
-- 
2.9.4
