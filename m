Received: from eggs.gnu.org ([2001:4830:134:3::10]:41386)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faPiZ-0004XL-50
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:08:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1faPiV-0006TK-51
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 14:07:59 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  3 Jul 2018 21:07:51 +0300
Message-Id: <20180703180751.243496-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180703180751.243496-1-vsementsov@virtuozzo.com>
References: <20180703180751.243496-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 2/2] block/backup: fix fleecing scheme: use
 serialized writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, eblake@redhat.com, jsnow@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Fleecing scheme works as follows: we want a kind of temporary snapshot
of active drive A. We create temporary image B, with B->backing = A.
Then we start backup(sync=none) from A to B. From this point, B reads
as point-in-time snapshot of A (A continues to be active drive,
accepting guest IO).

This scheme needs some additional synchronization between reads from B
and backup COW operations, otherwise, the following situation is
theoretically possible:

(assume B is qcow2, client is NBD client, reading from B)

1. client starts reading and take qcow2 mutex in qcow2_co_preadv, and
   goes up to l2 table loading (assume cache miss)

2) guest write => backup COW => qcow2 write =>
   try to take qcow2 mutex => waiting

3. l2 table loaded, we see that cluster is UNALLOCATED, go to
   "case QCOW2_CLUSTER_UNALLOCATED" and unlock mutex before
   bdrv_co_preadv(bs->backing, ...)

4) aha, mutex unlocked, backup COW continues, and we finally finish
   guest write and change cluster in our active disk A

5. actually, do bdrv_co_preadv(bs->backing, ...) and read
   _new updated_ data.

To avoid this, let's make all COW writes serializing, to not intersect
with reads from B.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 81895ddbe2..ab46a7d43d 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -47,6 +47,8 @@ typedef struct BackupBlockJob {
     HBitmap *copy_bitmap;
     bool use_copy_range;
     int64_t copy_range_size;
+
+    bool fleecing;
 } BackupBlockJob;
 
 static const BlockJobDriver backup_job_driver;
@@ -102,6 +104,7 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
     QEMUIOVector qiov;
     BlockBackend *blk = job->common.blk;
     int nbytes;
+    int sflags = job->fleecing ? BDRV_REQ_SERIALISING : 0;
 
     hbitmap_reset(job->copy_bitmap, start / job->cluster_size, 1);
     nbytes = MIN(job->cluster_size, job->len - start);
@@ -124,11 +127,12 @@ static int coroutine_fn backup_cow_with_bounce_buffer(BackupBlockJob *job,
 
     if (qemu_iovec_is_zero(&qiov)) {
         ret = blk_co_pwrite_zeroes(job->target, start,
-                                   qiov.size, BDRV_REQ_MAY_UNMAP);
+                                   qiov.size, sflags | BDRV_REQ_MAY_UNMAP);
     } else {
         ret = blk_co_pwritev(job->target, start,
                              qiov.size, &qiov,
-                             job->compress ? BDRV_REQ_WRITE_COMPRESSED : 0);
+                             job->compress ? BDRV_REQ_WRITE_COMPRESSED :
+                                             sflags);
     }
     if (ret < 0) {
         trace_backup_do_cow_write_fail(job, start, ret);
@@ -614,6 +618,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     BlockDriverInfo bdi;
     BackupBlockJob *job = NULL;
     int ret;
+    bool fleecing;
 
     assert(bs);
     assert(target);
@@ -668,6 +673,15 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
         return NULL;
     }
 
+    /* Detect image fleecing */
+    fleecing = sync_mode == MIRROR_SYNC_MODE_NONE && target->backing->bs == bs;
+    if (fleecing) {
+        if (compress) {
+            error_setg(errp, "Image fleecing doesn't support compressed mode.");
+            return NULL;
+        }
+    }
+
     len = bdrv_getlength(bs);
     if (len < 0) {
         error_setg_errno(errp, -len, "unable to get length for '%s'",
@@ -700,6 +714,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->sync_bitmap = sync_mode == MIRROR_SYNC_MODE_INCREMENTAL ?
                        sync_bitmap : NULL;
     job->compress = compress;
+    job->fleecing = fleecing;
 
     /* If there is no backing file on the target, we cannot rely on COW if our
      * backup cluster size is smaller than the target cluster size. Even for
@@ -727,7 +742,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     } else {
         job->cluster_size = MAX(BACKUP_CLUSTER_SIZE_DEFAULT, bdi.cluster_size);
     }
-    job->use_copy_range = true;
+    job->use_copy_range = !fleecing;
     job->copy_range_size = MIN_NON_ZERO(blk_get_max_transfer(job->common.blk),
                                         blk_get_max_transfer(job->target));
     job->copy_range_size = MAX(job->cluster_size,
-- 
2.11.1
