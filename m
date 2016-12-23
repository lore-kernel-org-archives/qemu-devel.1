Received: from eggs.gnu.org ([2001:4830:134:3::10]:53864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKSjb-00085Z-6s
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cKSja-0005nF-D3
	for qemu-devel@nongnu.org; Fri, 23 Dec 2016 11:30:19 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Dec 2016 17:29:00 +0300
Message-ID: <1482503344-6424-18-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
References: <1482503344-6424-1-git-send-email-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH 17/21] backup: make all reads not serializing
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

To simplify things make all reads not serializing, not only from
notifiers. This is needed because after the following patch, there would
not be strong division between reads from notifiers or not - they all
would be called from one place.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/backup.c | 20 ++++++++------------
 1 file changed, 8 insertions(+), 12 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 442e6da..c2f7665 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -134,14 +134,13 @@ static bool coroutine_fn yield_and_check(BackupBlockJob *job)
 
 static int coroutine_fn backup_do_read(BackupBlockJob *job,
                                        int64_t offset, unsigned int bytes,
-                                       QEMUIOVector *qiov,
-                                       bool is_write_notifier)
+                                       QEMUIOVector *qiov)
 {
     int ret;
-    BdrvRequestFlags flags = is_write_notifier ? BDRV_REQ_NO_SERIALISING : 0;
 
 retry:
-    ret = blk_co_preadv(job->common.blk, offset, bytes, qiov, flags);
+    ret = blk_co_preadv(job->common.blk, offset, bytes, qiov,
+                        BDRV_REQ_NO_SERIALISING);
     if (ret < 0) {
         trace_backup_do_read_fail(job, offset, bytes, ret);
 
@@ -190,7 +189,6 @@ retry:
 
 static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
                                             int64_t cluster,
-                                            bool is_write_notifier,
                                             void *bounce_buffer)
 {
     int n;
@@ -210,8 +208,7 @@ static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
     iov.iov_len = n * BDRV_SECTOR_SIZE;
     qemu_iovec_init_external(&bounce_qiov, &iov, 1);
 
-    ret = backup_do_read(job, offset, bounce_qiov.size, &bounce_qiov,
-                         is_write_notifier);
+    ret = backup_do_read(job, offset, bounce_qiov.size, &bounce_qiov);
     if (ret < 0) {
         return ret;
     }
@@ -231,8 +228,7 @@ static int coroutine_fn backup_copy_cluster(BackupBlockJob *job,
 }
 
 static int coroutine_fn backup_do_cow(BackupBlockJob *job,
-                                      int64_t sector_num, int nb_sectors,
-                                      bool is_write_notifier)
+                                      int64_t sector_num, int nb_sectors)
 {
     BlockBackend *blk = job->common.blk;
     CowRequest cow_request;
@@ -262,7 +258,7 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
             bounce_buffer = blk_blockalign(blk, job->cluster_size);
         }
 
-        ret = backup_copy_cluster(job, start, is_write_notifier, bounce_buffer);
+        ret = backup_copy_cluster(job, start, bounce_buffer);
         if (ret < 0) {
             hbitmap_set(job->copy_bitmap, start, 1);
             goto out;
@@ -296,7 +292,7 @@ static int coroutine_fn backup_before_write_notify(
     assert((req->offset & (BDRV_SECTOR_SIZE - 1)) == 0);
     assert((req->bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
 
-    return backup_do_cow(job, sector_num, nb_sectors, true);
+    return backup_do_cow(job, sector_num, nb_sectors);
 }
 
 static void backup_set_speed(BlockJob *job, int64_t speed, Error **errp)
@@ -544,7 +540,7 @@ static int coroutine_fn backup_loop(BackupBlockJob *job)
         }
 
         ret = backup_do_cow(job, cluster * sectors_per_cluster,
-                            sectors_per_cluster, false);
+                            sectors_per_cluster);
         if (ret < 0) {
             return ret;
         }
-- 
1.8.3.1
