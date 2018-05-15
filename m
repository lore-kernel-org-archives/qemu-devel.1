Received: from eggs.gnu.org ([2001:4830:134:3::10]:38751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4R-0006gV-B5
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:41:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fIc4Q-0001Sz-7G
	for qemu-devel@nongnu.org; Tue, 15 May 2018 11:40:59 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 15 May 2018 17:40:12 +0200
Message-Id: <20180515154033.19899-17-kwolf@redhat.com>
In-Reply-To: <20180515154033.19899-1-kwolf@redhat.com>
References: <20180515154033.19899-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 16/37] blockjob: Add block_job_driver()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

The backup block job directly accesses the driver field in BlockJob. Add
a wrapper for getting it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
---
 include/block/blockjob.h | 7 +++++++
 block/backup.c           | 8 +++++---
 blockjob.c               | 5 +++++
 3 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 82f52f4b14..0f56f723de 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -452,4 +452,11 @@ void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job);
  */
 bool block_job_is_internal(BlockJob *job);
 
+/**
+ * block_job_driver:
+ *
+ * Returns the driver associated with a block job.
+ */
+const BlockJobDriver *block_job_driver(BlockJob *job);
+
 #endif
diff --git a/block/backup.c b/block/backup.c
index cfdb6ecdf5..e14d99560d 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -47,6 +47,8 @@ typedef struct BackupBlockJob {
     HBitmap *copy_bitmap;
 } BackupBlockJob;
 
+static const BlockJobDriver backup_job_driver;
+
 /* See if in-flight requests overlap and wait for them to complete */
 static void coroutine_fn wait_for_overlapping_requests(BackupBlockJob *job,
                                                        int64_t start,
@@ -241,7 +243,7 @@ void backup_do_checkpoint(BlockJob *job, Error **errp)
     BackupBlockJob *backup_job = container_of(job, BackupBlockJob, common);
     int64_t len;
 
-    assert(job->driver->job_type == BLOCK_JOB_TYPE_BACKUP);
+    assert(block_job_driver(job) == &backup_job_driver);
 
     if (backup_job->sync_mode != MIRROR_SYNC_MODE_NONE) {
         error_setg(errp, "The backup job only supports block checkpoint in"
@@ -259,7 +261,7 @@ void backup_wait_for_overlapping_requests(BlockJob *job, int64_t offset,
     BackupBlockJob *backup_job = container_of(job, BackupBlockJob, common);
     int64_t start, end;
 
-    assert(job->driver->job_type == BLOCK_JOB_TYPE_BACKUP);
+    assert(block_job_driver(job) == &backup_job_driver);
 
     start = QEMU_ALIGN_DOWN(offset, backup_job->cluster_size);
     end = QEMU_ALIGN_UP(offset + bytes, backup_job->cluster_size);
@@ -272,7 +274,7 @@ void backup_cow_request_begin(CowRequest *req, BlockJob *job,
     BackupBlockJob *backup_job = container_of(job, BackupBlockJob, common);
     int64_t start, end;
 
-    assert(job->driver->job_type == BLOCK_JOB_TYPE_BACKUP);
+    assert(block_job_driver(job) == &backup_job_driver);
 
     start = QEMU_ALIGN_DOWN(offset, backup_job->cluster_size);
     end = QEMU_ALIGN_UP(offset + bytes, backup_job->cluster_size);
diff --git a/blockjob.c b/blockjob.c
index 04416f11cd..36c5fdeb2f 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -359,6 +359,11 @@ static bool block_job_started(BlockJob *job)
     return job->co;
 }
 
+const BlockJobDriver *block_job_driver(BlockJob *job)
+{
+    return job->driver;
+}
+
 /**
  * All jobs must allow a pause point before entering their job proper. This
  * ensures that jobs can be paused prior to being started, then resumed later.
-- 
2.13.6
