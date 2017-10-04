Received: from eggs.gnu.org ([2001:4830:134:3::10]:60736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzYrF-0005mY-06
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1dzYrD-0000KC-2j
	for qemu-devel@nongnu.org; Tue, 03 Oct 2017 21:52:21 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  3 Oct 2017 21:52:02 -0400
Message-Id: <20171004015205.20724-2-jsnow@redhat.com>
In-Reply-To: <20171004015205.20724-1-jsnow@redhat.com>
References: <20171004015205.20724-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/4] blockjob: add persistent property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

Add a persistent (manually reap) property to block jobs that forces
them to linger in the block job list (visible to QMP queries) until
the user explicitly dismisses them via QMP.

The reap command itself is implemented in the next commit, and the
feature is exposed to drive-backup and blockdev-backup in the subsequent
commit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c               | 20 +++++++++----------
 block/commit.c               |  2 +-
 block/mirror.c               |  2 +-
 block/replication.c          |  5 +++--
 block/stream.c               |  2 +-
 blockdev.c                   |  8 ++++----
 blockjob.c                   | 46 ++++++++++++++++++++++++++++++++++++++++++--
 include/block/block_int.h    |  8 +++++---
 include/block/blockjob.h     | 21 ++++++++++++++++++++
 include/block/blockjob_int.h |  2 +-
 qapi/block-core.json         |  7 ++++---
 tests/test-blockjob-txn.c    |  2 +-
 tests/test-blockjob.c        |  2 +-
 13 files changed, 97 insertions(+), 30 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 517c300..93ac194 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -532,15 +532,15 @@ static const BlockJobDriver backup_job_driver = {
     .drain                  = backup_drain,
 };
 
-BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
-                  BlockDriverState *target, int64_t speed,
-                  MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap,
-                  bool compress,
-                  BlockdevOnError on_source_error,
-                  BlockdevOnError on_target_error,
-                  int creation_flags,
-                  BlockCompletionFunc *cb, void *opaque,
-                  BlockJobTxn *txn, Error **errp)
+BlockJob *backup_job_create(const char *job_id, bool persistent,
+                            BlockDriverState *bs, BlockDriverState *target,
+                            int64_t speed, MirrorSyncMode sync_mode,
+                            BdrvDirtyBitmap *sync_bitmap, bool compress,
+                            BlockdevOnError on_source_error,
+                            BlockdevOnError on_target_error,
+                            int creation_flags,
+                            BlockCompletionFunc *cb, void *opaque,
+                            BlockJobTxn *txn, Error **errp)
 {
     int64_t len;
     BlockDriverInfo bdi;
@@ -608,7 +608,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     }
 
     /* job->common.len is fixed, so we can't allow resize */
-    job = block_job_create(job_id, &backup_job_driver, bs,
+    job = block_job_create(job_id, &backup_job_driver, persistent, bs,
                            BLK_PERM_CONSISTENT_READ,
                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
                            BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD,
diff --git a/block/commit.c b/block/commit.c
index 8f0e835..308a5fd 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -304,7 +304,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    s = block_job_create(job_id, &commit_job_driver, bs, 0, BLK_PERM_ALL,
+    s = block_job_create(job_id, &commit_job_driver, false, bs, 0, BLK_PERM_ALL,
                          speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
     if (!s) {
         return;
diff --git a/block/mirror.c b/block/mirror.c
index 6f5cb9f..013e73a 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1180,7 +1180,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     }
 
     /* Make sure that the source is not resized while the job is running */
-    s = block_job_create(job_id, driver, mirror_top_bs,
+    s = block_job_create(job_id, driver, false, mirror_top_bs,
                          BLK_PERM_CONSISTENT_READ,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                          BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD, speed,
diff --git a/block/replication.c b/block/replication.c
index 3a4e682..6c59f00 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -539,8 +539,9 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         bdrv_op_block_all(top_bs, s->blocker);
         bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
 
-        job = backup_job_create(NULL, s->secondary_disk->bs, s->hidden_disk->bs,
-                                0, MIRROR_SYNC_MODE_NONE, NULL, false,
+        job = backup_job_create(NULL, false, s->secondary_disk->bs,
+                                s->hidden_disk->bs, 0, MIRROR_SYNC_MODE_NONE,
+                                NULL, false,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, BLOCK_JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_err);
diff --git a/block/stream.c b/block/stream.c
index e6f7234..c644f34 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -244,7 +244,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     /* Prevent concurrent jobs trying to modify the graph structure here, we
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached. */
-    s = block_job_create(job_id, &stream_job_driver, bs,
+    s = block_job_create(job_id, &stream_job_driver, false, bs,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                          BLK_PERM_GRAPH_MOD,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
diff --git a/blockdev.c b/blockdev.c
index 56a6b24..eeb4986 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3290,8 +3290,8 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         }
     }
 
-    job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
-                            backup->sync, bmap, backup->compress,
+    job = backup_job_create(backup->job_id, false, bs, target_bs,
+                            backup->speed, backup->sync, bmap, backup->compress,
                             backup->on_source_error, backup->on_target_error,
                             BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
     bdrv_unref(target_bs);
@@ -3369,8 +3369,8 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
             goto out;
         }
     }
-    job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
-                            backup->sync, NULL, backup->compress,
+    job = backup_job_create(backup->job_id, false, bs, target_bs,
+                            backup->speed, backup->sync, NULL, backup->compress,
                             backup->on_source_error, backup->on_target_error,
                             BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
     if (local_err != NULL) {
diff --git a/blockjob.c b/blockjob.c
index 3a0c491..1efac45 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -336,6 +336,8 @@ static void block_job_completed_single(BlockJob *job)
         QLIST_REMOVE(job, txn_list);
         block_job_txn_unref(job->txn);
     }
+
+    job->finished = true;
     block_job_unref(job);
 }
 
@@ -352,6 +354,13 @@ static void block_job_cancel_async(BlockJob *job)
     job->cancelled = true;
 }
 
+static void block_job_do_reap(BlockJob *job)
+{
+    assert(job && job->persistent == true);
+    job->persistent = false;
+    block_job_unref(job);
+}
+
 static int block_job_finish_sync(BlockJob *job,
                                  void (*finish)(BlockJob *, Error **errp),
                                  Error **errp)
@@ -381,6 +390,9 @@ static int block_job_finish_sync(BlockJob *job,
         aio_poll(qemu_get_aio_context(), true);
     }
     ret = (job->cancelled && job->ret == 0) ? -ECANCELED : job->ret;
+    if (job->persistent) {
+        block_job_do_reap(job);
+    }
     block_job_unref(job);
     return ret;
 }
@@ -483,6 +495,26 @@ void block_job_complete(BlockJob *job, Error **errp)
     job->driver->complete(job, errp);
 }
 
+void block_job_reap(BlockJob **jobptr, Error **errp)
+{
+    BlockJob *job = *jobptr;
+    /* similarly to _complete, this is QMP-interface only. */
+    assert(job->id);
+    if (!job->persistent) {
+        error_setg(errp, "The active block job '%s' was not started with "
+                   "\'manual-reap\': true, and so cannot be reaped as it will "
+                   "clean up after itself automatically", job->id);
+        return;
+    } else if (!job->finished) {
+        error_setg(errp, "The active block job '%s' has not yet terminated, "
+                   "and cannot be reaped yet", job->id);
+        return;
+    }
+
+    block_job_do_reap(job);
+    *jobptr = NULL;
+}
+
 void block_job_user_pause(BlockJob *job)
 {
     job->user_paused = true;
@@ -505,7 +537,9 @@ void block_job_user_resume(BlockJob *job)
 
 void block_job_cancel(BlockJob *job)
 {
-    if (block_job_started(job)) {
+    if (job->finished) {
+        return;
+    } else if (block_job_started(job)) {
         block_job_cancel_async(job);
         block_job_enter(job);
     } else {
@@ -562,6 +596,7 @@ BlockJobInfo *block_job_query(BlockJob *job, Error **errp)
     info->speed     = job->speed;
     info->io_status = job->iostatus;
     info->ready     = job->ready;
+    info->finished  = job->finished;
     return info;
 }
 
@@ -609,7 +644,7 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
  */
 
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
-                       BlockDriverState *bs, uint64_t perm,
+                       bool persistent, BlockDriverState *bs, uint64_t perm,
                        uint64_t shared_perm, int64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp)
 {
@@ -664,6 +699,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
+    job->persistent   = persistent;
 
     error_setg(&job->blocker, "block device is in use by block job: %s",
                BlockJobType_str(driver->job_type));
@@ -689,6 +725,12 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
             return NULL;
         }
     }
+
+    /* Hang on to an extra reference on behalf of the QMP monitor */
+    if (job->persistent) {
+        block_job_ref(job);
+    }
+
     return job;
 }
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 99abe2c..a576357 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -944,6 +944,8 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
  * backup_job_create:
  * @job_id: The id of the newly-created job, or %NULL to use the
  * device name of @bs.
+ * @persistent: Whether or not this job, when completed, will need to be
+ *               manually reaped via block-job-reap or not.
  * @bs: Block device to operate on.
  * @target: Block device to write to.
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
@@ -960,9 +962,9 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
  * Create a backup operation on @bs.  Clusters in @bs are written to @target
  * until the job is cancelled or manually completed.
  */
-BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
-                            BlockDriverState *target, int64_t speed,
-                            MirrorSyncMode sync_mode,
+BlockJob *backup_job_create(const char *job_id, bool persistent,
+                            BlockDriverState *bs, BlockDriverState *target,
+                            int64_t speed, MirrorSyncMode sync_mode,
                             BdrvDirtyBitmap *sync_bitmap,
                             bool compress,
                             BlockdevOnError on_source_error,
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 67c0968..cd1b41b 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -135,6 +135,15 @@ typedef struct BlockJob {
      */
     int ret;
 
+    /* True if this job must remain present post-completion until
+     * it can be queried and removed via block-job-reap. */
+    bool persistent;
+
+    /* True if and only if persistent is true and the job has finished
+     * calling either abort or commit (if applicable) and can be reaped
+     * via interactive user command. */
+    bool finished;
+
     /** Non-NULL if this job is part of a transaction */
     BlockJobTxn *txn;
     QLIST_ENTRY(BlockJob) txn_list;
@@ -227,6 +236,18 @@ void block_job_cancel(BlockJob *job);
 void block_job_complete(BlockJob *job, Error **errp);
 
 /**
+ * block_job_reap:
+ * @job: The job to be reaped.
+ * @errp: Error object.
+ *
+ * For completed or canceled jobs, remove the job object
+ * from the block_job_query list and perform final cleanup.
+ *
+ * Note that at this stage, the job cannot be rolled back.
+ */
+void block_job_reap(BlockJob **job, Error **errp);
+
+/**
  * block_job_query:
  * @job: The job to get information about.
  *
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index f13ad05..c19275c 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -132,7 +132,7 @@ struct BlockJobDriver {
  * called from a wrapper that is specific to the job type.
  */
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
-                       BlockDriverState *bs, uint64_t perm,
+                       bool persistent, BlockDriverState *bs, uint64_t perm,
                        uint64_t shared_perm, int64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp);
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 750bb0c..a4f5e10 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -984,9 +984,10 @@
 # Since: 1.1
 ##
 { 'struct': 'BlockJobInfo',
-  'data': {'type': 'str', 'device': 'str', 'len': 'int',
-           'offset': 'int', 'busy': 'bool', 'paused': 'bool', 'speed': 'int',
-           'io-status': 'BlockDeviceIoStatus', 'ready': 'bool'} }
+  'data': {'type': 'str', 'device': 'str', 'len': 'int', 'offset': 'int',
+           'busy': 'bool', 'paused': 'bool', 'speed': 'int',
+           'io-status': 'BlockDeviceIoStatus', 'ready': 'bool',
+           'finished': 'bool'} }
 
 ##
 # @query-block-jobs:
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index c77343f..5ab0e22 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -101,7 +101,7 @@ static BlockJob *test_block_job_start(unsigned int iterations,
     g_assert_nonnull(bs);
 
     snprintf(job_id, sizeof(job_id), "job%u", counter++);
-    s = block_job_create(job_id, &test_block_job_driver, bs,
+    s = block_job_create(job_id, &test_block_job_driver, false, bs,
                          0, BLK_PERM_ALL, 0, BLOCK_JOB_DEFAULT,
                          test_block_job_cb, data, &error_abort);
     s->iterations = iterations;
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 23bdf1a..9fc2785 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -30,7 +30,7 @@ static BlockJob *do_test_id(BlockBackend *blk, const char *id,
     BlockJob *job;
     Error *errp = NULL;
 
-    job = block_job_create(id, &test_block_job_driver, blk_bs(blk),
+    job = block_job_create(id, &test_block_job_driver, false, blk_bs(blk),
                            0, BLK_PERM_ALL, 0, BLOCK_JOB_DEFAULT, block_job_cb,
                            NULL, &errp);
     if (should_succeed) {
-- 
2.9.5
