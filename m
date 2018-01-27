Received: from eggs.gnu.org ([2001:4830:134:3::10]:37228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs3-0000pK-8J
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1efFs1-0008M8-5J
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:05:31 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 26 Jan 2018 21:05:02 -0500
Message-Id: <20180127020515.27137-2-jsnow@redhat.com>
In-Reply-To: <20180127020515.27137-1-jsnow@redhat.com>
References: <20180127020515.27137-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v3 01/14] blockjobs: add manual property
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

This property will be used to opt-in to the new BlockJobs workflow
that allows a tighter, more explicit control over transitions from
one runstate to another.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/backup.c               | 20 ++++++++++----------
 block/commit.c               |  2 +-
 block/mirror.c               |  2 +-
 block/replication.c          |  5 +++--
 block/stream.c               |  2 +-
 blockdev.c                   |  4 ++--
 blockjob.c                   |  3 ++-
 include/block/block_int.h    |  6 +++---
 include/block/blockjob.h     |  5 +++++
 include/block/blockjob_int.h |  2 +-
 tests/test-bdrv-drain.c      |  4 ++--
 tests/test-blockjob-txn.c    |  2 +-
 tests/test-blockjob.c        |  4 ++--
 13 files changed, 34 insertions(+), 27 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index 4a16a37229..d729263708 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -545,15 +545,15 @@ static const BlockJobDriver backup_job_driver = {
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
+BlockJob *backup_job_create(const char *job_id, bool manual,
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
@@ -621,7 +621,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     }
 
     /* job->common.len is fixed, so we can't allow resize */
-    job = block_job_create(job_id, &backup_job_driver, bs,
+    job = block_job_create(job_id, &backup_job_driver, manual, bs,
                            BLK_PERM_CONSISTENT_READ,
                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
                            BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD,
diff --git a/block/commit.c b/block/commit.c
index bb6c904704..920fdabcc2 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -289,7 +289,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    s = block_job_create(job_id, &commit_job_driver, bs, 0, BLK_PERM_ALL,
+    s = block_job_create(job_id, &commit_job_driver, false, bs, 0, BLK_PERM_ALL,
                          speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
     if (!s) {
         return;
diff --git a/block/mirror.c b/block/mirror.c
index c9badc1203..8e8d3589f2 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1166,7 +1166,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     }
 
     /* Make sure that the source is not resized while the job is running */
-    s = block_job_create(job_id, driver, mirror_top_bs,
+    s = block_job_create(job_id, driver, false, mirror_top_bs,
                          BLK_PERM_CONSISTENT_READ,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                          BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD, speed,
diff --git a/block/replication.c b/block/replication.c
index b1ea3caa4b..3ab0a08cd7 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -563,8 +563,9 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
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
index 499cdacdb0..f31785965c 100644
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
index 8e977eef11..2c0773bba7 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3373,7 +3373,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
         }
     }
 
-    job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
+    job = backup_job_create(backup->job_id, false, bs, target_bs, backup->speed,
                             backup->sync, bmap, backup->compress,
                             backup->on_source_error, backup->on_target_error,
                             BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
@@ -3452,7 +3452,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
             goto out;
         }
     }
-    job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
+    job = backup_job_create(backup->job_id, false, bs, target_bs, backup->speed,
                             backup->sync, NULL, backup->compress,
                             backup->on_source_error, backup->on_target_error,
                             BLOCK_JOB_DEFAULT, NULL, NULL, txn, &local_err);
diff --git a/blockjob.c b/blockjob.c
index f5cea84e73..9850d70cb0 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -648,7 +648,7 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
  */
 
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
-                       BlockDriverState *bs, uint64_t perm,
+                       bool manual, BlockDriverState *bs, uint64_t perm,
                        uint64_t shared_perm, int64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp)
 {
@@ -703,6 +703,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
+    job->manual        = manual;
     aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
                    QEMU_CLOCK_REALTIME, SCALE_NS,
                    block_job_sleep_timer_cb, job);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 29cafa4236..08f5046c63 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -981,9 +981,9 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
  * Create a backup operation on @bs.  Clusters in @bs are written to @target
  * until the job is cancelled or manually completed.
  */
-BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
-                            BlockDriverState *target, int64_t speed,
-                            MirrorSyncMode sync_mode,
+BlockJob *backup_job_create(const char *job_id, bool manual,
+                            BlockDriverState *bs, BlockDriverState *target,
+                            int64_t speed, MirrorSyncMode sync_mode,
                             BdrvDirtyBitmap *sync_bitmap,
                             bool compress,
                             BlockdevOnError on_source_error,
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 00403d9482..b94d0c9fa6 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -141,6 +141,11 @@ typedef struct BlockJob {
      */
     QEMUTimer sleep_timer;
 
+    /* Set to true when management API has requested 2.12+ job lifetime
+     * management semantics.
+     */
+    bool manual;
+
     /** Non-NULL if this job is part of a transaction */
     BlockJobTxn *txn;
     QLIST_ENTRY(BlockJob) txn_list;
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index c9b23b0cc9..a24c3f90e5 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -132,7 +132,7 @@ struct BlockJobDriver {
  * called from a wrapper that is specific to the job type.
  */
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
-                       BlockDriverState *bs, uint64_t perm,
+                       bool manual, BlockDriverState *bs, uint64_t perm,
                        uint64_t shared_perm, int64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp);
 
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index d760e2b243..184c5663b8 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -541,8 +541,8 @@ static void test_blockjob_common(enum drain_type drain_type)
     blk_target = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk_target, target, &error_abort);
 
-    job = block_job_create("job0", &test_job_driver, src, 0, BLK_PERM_ALL, 0,
-                           0, NULL, NULL, &error_abort);
+    job = block_job_create("job0", &test_job_driver, false, src, 0,
+                           BLK_PERM_ALL, 0, 0, NULL, NULL, &error_abort);
     block_job_add_bdrv(job, "target", target, 0, BLK_PERM_ALL, &error_abort);
     block_job_start(job);
 
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 3591c9617f..2efaa554c0 100644
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
index 23bdf1a932..f08da8dca9 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -30,8 +30,8 @@ static BlockJob *do_test_id(BlockBackend *blk, const char *id,
     BlockJob *job;
     Error *errp = NULL;
 
-    job = block_job_create(id, &test_block_job_driver, blk_bs(blk),
-                           0, BLK_PERM_ALL, 0, BLOCK_JOB_DEFAULT, block_job_cb,
+    job = block_job_create(id, &test_block_job_driver, false, blk_bs(blk), 0,
+                           BLK_PERM_ALL, 0, BLOCK_JOB_DEFAULT, block_job_cb,
                            NULL, &errp);
     if (should_succeed) {
         g_assert_null(errp);
-- 
2.14.3
