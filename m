Received: from eggs.gnu.org ([2001:4830:134:3::10]:45630)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSdt-00012E-W5
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:45:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dTSds-0000p0-Q4
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:45:54 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri,  7 Jul 2017 07:44:54 -0500
Message-Id: <20170707124459.10269-17-eblake@redhat.com>
In-Reply-To: <20170707124459.10269-1-eblake@redhat.com>
References: <20170707124459.10269-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 16/21] backup: Switch block_backup.h to
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
Cc: kwolf@redhat.com, jcody@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>

We are gradually converting to byte-based interfaces, as they are
easier to reason about than sector-based.  Continue by converting
the public interface to backup jobs (no semantic change), including
a change to CowRequest to track by bytes instead of cluster indices.

Note that this does not change the difference between the public
interface (starting point, and size of the subsequent range) and
the internal interface (starting and end points).

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Reviewed-by: Xie Changlong <xiechanglong@cmss.chinamobile.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>

---
v5: keep start/end naming internally [Kevin], R-b kept
v3-v4: no change
v2: change a couple more parameter names
---
 include/block/block_backup.h | 11 +++++------
 block/backup.c               | 31 +++++++++++++++----------------
 block/replication.c          | 12 ++++++++----
 3 files changed, 28 insertions(+), 26 deletions(-)

diff --git a/include/block/block_backup.h b/include/block/block_backup.h
index 8a75947..994a3bd 100644
--- a/include/block/block_backup.h
+++ b/include/block/block_backup.h
@@ -21,17 +21,16 @@
 #include "block/block_int.h"

 typedef struct CowRequest {
-    int64_t start;
-    int64_t end;
+    int64_t start_byte;
+    int64_t end_byte;
     QLIST_ENTRY(CowRequest) list;
     CoQueue wait_queue; /* coroutines blocked on this request */
 } CowRequest;

-void backup_wait_for_overlapping_requests(BlockJob *job, int64_t sector_num,
-                                          int nb_sectors);
+void backup_wait_for_overlapping_requests(BlockJob *job, int64_t offset,
+                                          uint64_t bytes);
 void backup_cow_request_begin(CowRequest *req, BlockJob *job,
-                              int64_t sector_num,
-                              int nb_sectors);
+                              int64_t offset, uint64_t bytes);
 void backup_cow_request_end(CowRequest *req);

 void backup_do_checkpoint(BlockJob *job, Error **errp);
diff --git a/block/backup.c b/block/backup.c
index 4e64710..503fbec 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -64,7 +64,7 @@ static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
     do {
         retry = false;
         QLIST_FOREACH(req, &job->inflight_reqs, list) {
-            if (end > req->start && start < req->end) {
+            if (end > req->start_byte && start < req->end_byte) {
                 qemu_co_queue_wait(&req->wait_queue, NULL);
                 retry = true;
                 break;
@@ -75,10 +75,10 @@ static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,

 /* Keep track of an in-flight request */
 static void cow_request_begin(CowRequest *req, BackupBlockJob *job,
-                                     int64_t start, int64_t end)
+                              int64_t start, int64_t end)
 {
-    req->start = start;
-    req->end = end;
+    req->start_byte = start;
+    req->end_byte = end;
     qemu_co_queue_init(&req->wait_queue);
     QLIST_INSERT_HEAD(&job->inflight_reqs, req, list);
 }
@@ -114,8 +114,10 @@ static int coroutine_fn backup_do_cow(BackupBlockJob *job,
                               sector_num * BDRV_SECTOR_SIZE,
                               nb_sectors * BDRV_SECTOR_SIZE);

-    wait_for_overlapping_requests(job, start, end);
-    cow_request_begin(&cow_request, job, start, end);
+    wait_for_overlapping_requests(job, start * job->cluster_size,
+                                  end * job->cluster_size);
+    cow_request_begin(&cow_request, job, start * job->cluster_size,
+                      end * job->cluster_size);

     for (; start < end; start++) {
         if (test_bit(start, job->done_bitmap)) {
@@ -277,32 +279,29 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
     bitmap_zero(backup_job->done_bitmap, len);
 }

-void backup_wait_for_overlapping_requests(BlockJob *job, int64_t sector_num,
-                                          int nb_sectors)
+void backup_wait_for_overlapping_requests(BlockJob *job, int64_t offset,
+                                          uint64_t bytes)
 {
     BackupBlockJob *backup_job = container_of(job, BackupBlockJob, common);
-    int64_t sectors_per_cluster = cluster_size_sectors(backup_job);
     int64_t start, end;

     assert(job->driver->job_type == BLOCK_JOB_TYPE_BACKUP);

-    start = sector_num / sectors_per_cluster;
-    end = DIV_ROUND_UP(sector_num + nb_sectors, sectors_per_cluster);
+    start = QEMU_ALIGN_DOWN(offset, backup_job->cluster_size);
+    end = QEMU_ALIGN_UP(offset + bytes, backup_job->cluster_size);
     wait_for_overlapping_requests(backup_job, start, end);
 }

 void backup_cow_request_begin(CowRequest *req, BlockJob *job,
-                              int64_t sector_num,
-                              int nb_sectors)
+                              int64_t offset, uint64_t bytes)
 {
     BackupBlockJob *backup_job = container_of(job, BackupBlockJob, common);
-    int64_t sectors_per_cluster = cluster_size_sectors(backup_job);
     int64_t start, end;

     assert(job->driver->job_type == BLOCK_JOB_TYPE_BACKUP);

-    start = sector_num / sectors_per_cluster;
-    end = DIV_ROUND_UP(sector_num + nb_sectors, sectors_per_cluster);
+    start = QEMU_ALIGN_DOWN(offset, backup_job->cluster_size);
+    end = QEMU_ALIGN_UP(offset + bytes, backup_job->cluster_size);
     cow_request_begin(req, backup_job, start, end);
 }

diff --git a/block/replication.c b/block/replication.c
index 3885f04..8f3aba7 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -234,10 +234,14 @@ static coroutine_fn int replication_co_readv(BlockDriverState *bs,
     }

     if (job) {
-        backup_wait_for_overlapping_requests(child->bs->job, sector_num,
-                                             remaining_sectors);
-        backup_cow_request_begin(&req, child->bs->job, sector_num,
-                                 remaining_sectors);
+        uint64_t remaining_bytes = remaining_sectors * BDRV_SECTOR_SIZE;
+
+        backup_wait_for_overlapping_requests(child->bs->job,
+                                             sector_num * BDRV_SECTOR_SIZE,
+                                             remaining_bytes);
+        backup_cow_request_begin(&req, child->bs->job,
+                                 sector_num * BDRV_SECTOR_SIZE,
+                                 remaining_bytes);
         ret = bdrv_co_readv(bs->file, sector_num, remaining_sectors,
                             qiov);
         backup_cow_request_end(&req);
-- 
2.9.4
