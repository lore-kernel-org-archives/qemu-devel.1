Received: from eggs.gnu.org ([2001:4830:134:3::10]:53345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZR-0002Jz-T1
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fLTZI-0007CN-Ak
	for qemu-devel@nongnu.org; Wed, 23 May 2018 09:12:49 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 23 May 2018 15:11:40 +0200
Message-Id: <20180523131155.12359-32-kwolf@redhat.com>
In-Reply-To: <20180523131155.12359-1-kwolf@redhat.com>
References: <20180523131155.12359-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 31/46] job: Switch transactions to JobTxn
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

This doesn't actually move any transaction code to Job yet, but it
renames the type for transactions from BlockJobTxn to JobTxn and makes
them contain Jobs rather than BlockJobs

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block_int.h    |  2 +-
 include/block/blockjob.h     | 11 ++++----
 include/block/blockjob_int.h |  2 +-
 include/qemu/job.h           |  3 +++
 block/backup.c               |  2 +-
 blockdev.c                   | 14 +++++------
 blockjob.c                   | 60 +++++++++++++++++++++++---------------------
 tests/test-blockjob-txn.c    |  8 +++---
 8 files changed, 54 insertions(+), 48 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index 76b589da57..6c0927bce3 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1029,7 +1029,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             BlockdevOnError on_target_error,
                             int creation_flags,
                             BlockCompletionFunc *cb, void *opaque,
-                            BlockJobTxn *txn, Error **errp);
+                            JobTxn *txn, Error **errp);
 
 void hmp_drive_add_node(Monitor *mon, const char *optstr);
 
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 85ce18a381..44df025bd0 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -33,7 +33,7 @@
 #define BLOCK_JOB_SLICE_TIME 100000000ULL /* ns */
 
 typedef struct BlockJobDriver BlockJobDriver;
-typedef struct BlockJobTxn BlockJobTxn;
+typedef struct JobTxn JobTxn;
 
 /**
  * BlockJob:
@@ -85,8 +85,7 @@ typedef struct BlockJob {
     /** BlockDriverStates that are involved in this block job */
     GSList *nodes;
 
-    BlockJobTxn *txn;
-    QLIST_ENTRY(BlockJob) txn_list;
+    JobTxn *txn;
 } BlockJob;
 
 /**
@@ -273,7 +272,7 @@ void block_job_iostatus_reset(BlockJob *job);
  * group.  Jobs wait for each other before completing.  Cancelling one job
  * cancels all jobs in the transaction.
  */
-BlockJobTxn *block_job_txn_new(void);
+JobTxn *block_job_txn_new(void);
 
 /**
  * block_job_txn_unref:
@@ -282,7 +281,7 @@ BlockJobTxn *block_job_txn_new(void);
  * or block_job_txn_new. If it's the last reference to the object, it will be
  * freed.
  */
-void block_job_txn_unref(BlockJobTxn *txn);
+void block_job_txn_unref(JobTxn *txn);
 
 /**
  * block_job_txn_add_job:
@@ -293,7 +292,7 @@ void block_job_txn_unref(BlockJobTxn *txn);
  * The caller must call either block_job_txn_unref() or block_job_completed()
  * to release the reference that is automatically grabbed here.
  */
-void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job);
+void block_job_txn_add_job(JobTxn *txn, BlockJob *job);
 
 /**
  * block_job_is_internal:
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index b8ca7bb0c9..ce66a9b51c 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -91,7 +91,7 @@ struct BlockJobDriver {
  * called from a wrapper that is specific to the job type.
  */
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
-                       BlockJobTxn *txn, BlockDriverState *bs, uint64_t perm,
+                       JobTxn *txn, BlockDriverState *bs, uint64_t perm,
                        uint64_t shared_perm, int64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp);
 
diff --git a/include/qemu/job.h b/include/qemu/job.h
index 17e2ceca87..d4aa7fa981 100644
--- a/include/qemu/job.h
+++ b/include/qemu/job.h
@@ -132,6 +132,9 @@ typedef struct Job {
 
     /** Element of the list of jobs */
     QLIST_ENTRY(Job) job_list;
+
+    /** Element of the list of jobs in a job transaction */
+    QLIST_ENTRY(Job) txn_list;
 } Job;
 
 /**
diff --git a/block/backup.c b/block/backup.c
index ca7d990b21..6172f90c90 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -547,7 +547,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BlockdevOnError on_target_error,
                   int creation_flags,
                   BlockCompletionFunc *cb, void *opaque,
-                  BlockJobTxn *txn, Error **errp)
+                  JobTxn *txn, Error **errp)
 {
     int64_t len;
     BlockDriverInfo bdi;
diff --git a/blockdev.c b/blockdev.c
index 0967f6ab66..817c3848c0 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1446,7 +1446,7 @@ typedef struct BlkActionOps {
 struct BlkActionState {
     TransactionAction *action;
     const BlkActionOps *ops;
-    BlockJobTxn *block_job_txn;
+    JobTxn *block_job_txn;
     TransactionProperties *txn_props;
     QSIMPLEQ_ENTRY(BlkActionState) entry;
 };
@@ -1864,7 +1864,7 @@ typedef struct DriveBackupState {
     BlockJob *job;
 } DriveBackupState;
 
-static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
+static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
                             Error **errp);
 
 static void drive_backup_prepare(BlkActionState *common, Error **errp)
@@ -1954,7 +1954,7 @@ typedef struct BlockdevBackupState {
     BlockJob *job;
 } BlockdevBackupState;
 
-static BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
+static BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
                                     Error **errp);
 
 static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
@@ -2243,7 +2243,7 @@ void qmp_transaction(TransactionActionList *dev_list,
                      Error **errp)
 {
     TransactionActionList *dev_entry = dev_list;
-    BlockJobTxn *block_job_txn = NULL;
+    JobTxn *block_job_txn = NULL;
     BlkActionState *state, *next;
     Error *local_err = NULL;
 
@@ -2251,7 +2251,7 @@ void qmp_transaction(TransactionActionList *dev_list,
     QSIMPLEQ_INIT(&snap_bdrv_states);
 
     /* Does this transaction get canceled as a group on failure?
-     * If not, we don't really need to make a BlockJobTxn.
+     * If not, we don't really need to make a JobTxn.
      */
     props = get_transaction_properties(props);
     if (props->completion_mode != ACTION_COMPLETION_MODE_INDIVIDUAL) {
@@ -3264,7 +3264,7 @@ out:
     aio_context_release(aio_context);
 }
 
-static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
+static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
                                  Error **errp)
 {
     BlockDriverState *bs;
@@ -3434,7 +3434,7 @@ BlockDeviceInfoList *qmp_query_named_block_nodes(Error **errp)
     return bdrv_named_nodes_list(errp);
 }
 
-BlockJob *do_blockdev_backup(BlockdevBackup *backup, BlockJobTxn *txn,
+BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
                              Error **errp)
 {
     BlockDriverState *bs;
diff --git a/blockjob.c b/blockjob.c
index 1ed3e9c88d..bd35c4fa7a 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -37,13 +37,13 @@
 #include "qemu/timer.h"
 
 /* Transactional group of block jobs */
-struct BlockJobTxn {
+struct JobTxn {
 
     /* Is this txn being cancelled? */
     bool aborting;
 
     /* List of jobs */
-    QLIST_HEAD(, BlockJob) jobs;
+    QLIST_HEAD(, Job) jobs;
 
     /* Reference count */
     int refcnt;
@@ -94,27 +94,27 @@ BlockJob *block_job_get(const char *id)
     }
 }
 
-BlockJobTxn *block_job_txn_new(void)
+JobTxn *block_job_txn_new(void)
 {
-    BlockJobTxn *txn = g_new0(BlockJobTxn, 1);
+    JobTxn *txn = g_new0(JobTxn, 1);
     QLIST_INIT(&txn->jobs);
     txn->refcnt = 1;
     return txn;
 }
 
-static void block_job_txn_ref(BlockJobTxn *txn)
+static void block_job_txn_ref(JobTxn *txn)
 {
     txn->refcnt++;
 }
 
-void block_job_txn_unref(BlockJobTxn *txn)
+void block_job_txn_unref(JobTxn *txn)
 {
     if (txn && --txn->refcnt == 0) {
         g_free(txn);
     }
 }
 
-void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
+void block_job_txn_add_job(JobTxn *txn, BlockJob *job)
 {
     if (!txn) {
         return;
@@ -123,14 +123,14 @@ void block_job_txn_add_job(BlockJobTxn *txn, BlockJob *job)
     assert(!job->txn);
     job->txn = txn;
 
-    QLIST_INSERT_HEAD(&txn->jobs, job, txn_list);
+    QLIST_INSERT_HEAD(&txn->jobs, &job->job, txn_list);
     block_job_txn_ref(txn);
 }
 
 void block_job_txn_del_job(BlockJob *job)
 {
     if (job->txn) {
-        QLIST_REMOVE(job, txn_list);
+        QLIST_REMOVE(&job->job, txn_list);
         block_job_txn_unref(job->txn);
         job->txn = NULL;
     }
@@ -285,18 +285,22 @@ static void job_cancel_async(Job *job, bool force)
     job->force_cancel |= force;
 }
 
-static int block_job_txn_apply(BlockJobTxn *txn, int fn(BlockJob *), bool lock)
+static int block_job_txn_apply(JobTxn *txn, int fn(BlockJob *), bool lock)
 {
     AioContext *ctx;
-    BlockJob *job, *next;
+    Job *job, *next;
+    BlockJob *bjob;
     int rc = 0;
 
     QLIST_FOREACH_SAFE(job, &txn->jobs, txn_list, next) {
+        assert(is_block_job(job));
+        bjob = container_of(job, BlockJob, job);
+
         if (lock) {
-            ctx = blk_get_aio_context(job->blk);
+            ctx = job->aio_context;
             aio_context_acquire(ctx);
         }
-        rc = fn(job);
+        rc = fn(bjob);
         if (lock) {
             aio_context_release(ctx);
         }
@@ -310,8 +314,8 @@ static int block_job_txn_apply(BlockJobTxn *txn, int fn(BlockJob *), bool lock)
 static void block_job_completed_txn_abort(BlockJob *job)
 {
     AioContext *ctx;
-    BlockJobTxn *txn = job->txn;
-    BlockJob *other_job;
+    JobTxn *txn = job->txn;
+    Job *other_job;
 
     if (txn->aborting) {
         /*
@@ -324,7 +328,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
 
     /* We are the first failed job. Cancel other jobs. */
     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
-        ctx = blk_get_aio_context(other_job->blk);
+        ctx = other_job->aio_context;
         aio_context_acquire(ctx);
     }
 
@@ -332,18 +336,18 @@ static void block_job_completed_txn_abort(BlockJob *job)
      * them; this job, however, may or may not be cancelled, depending
      * on the caller, so leave it. */
     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
-        if (other_job != job) {
-            job_cancel_async(&other_job->job, false);
+        if (other_job != &job->job) {
+            job_cancel_async(other_job, false);
         }
     }
     while (!QLIST_EMPTY(&txn->jobs)) {
         other_job = QLIST_FIRST(&txn->jobs);
-        ctx = blk_get_aio_context(other_job->blk);
-        if (!job_is_completed(&other_job->job)) {
-            assert(job_is_cancelled(&other_job->job));
-            job_finish_sync(&other_job->job, NULL, NULL);
+        ctx = other_job->aio_context;
+        if (!job_is_completed(other_job)) {
+            assert(job_is_cancelled(other_job));
+            job_finish_sync(other_job, NULL, NULL);
         }
-        job_finalize_single(&other_job->job);
+        job_finalize_single(other_job);
         aio_context_release(ctx);
     }
 
@@ -385,8 +389,8 @@ static int block_job_transition_to_pending(BlockJob *job)
 
 static void block_job_completed_txn_success(BlockJob *job)
 {
-    BlockJobTxn *txn = job->txn;
-    BlockJob *other_job;
+    JobTxn *txn = job->txn;
+    Job *other_job;
 
     job_state_transition(&job->job, JOB_STATUS_WAITING);
 
@@ -395,10 +399,10 @@ static void block_job_completed_txn_success(BlockJob *job)
      * txn.
      */
     QLIST_FOREACH(other_job, &txn->jobs, txn_list) {
-        if (!job_is_completed(&other_job->job)) {
+        if (!job_is_completed(other_job)) {
             return;
         }
-        assert(other_job->job.ret == 0);
+        assert(other_job->ret == 0);
     }
 
     block_job_txn_apply(txn, block_job_transition_to_pending, false);
@@ -628,7 +632,7 @@ static void block_job_event_pending(Notifier *n, void *opaque)
  */
 
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
-                       BlockJobTxn *txn, BlockDriverState *bs, uint64_t perm,
+                       JobTxn *txn, BlockDriverState *bs, uint64_t perm,
                        uint64_t shared_perm, int64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp)
 {
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 1572f8d96f..ec5d592b68 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -93,7 +93,7 @@ static const BlockJobDriver test_block_job_driver = {
  */
 static BlockJob *test_block_job_start(unsigned int iterations,
                                       bool use_timer,
-                                      int rc, int *result, BlockJobTxn *txn)
+                                      int rc, int *result, JobTxn *txn)
 {
     BlockDriverState *bs;
     TestBlockJob *s;
@@ -122,7 +122,7 @@ static BlockJob *test_block_job_start(unsigned int iterations,
 static void test_single_job(int expected)
 {
     BlockJob *job;
-    BlockJobTxn *txn;
+    JobTxn *txn;
     int result = -EINPROGRESS;
 
     txn = block_job_txn_new();
@@ -160,7 +160,7 @@ static void test_pair_jobs(int expected1, int expected2)
 {
     BlockJob *job1;
     BlockJob *job2;
-    BlockJobTxn *txn;
+    JobTxn *txn;
     int result1 = -EINPROGRESS;
     int result2 = -EINPROGRESS;
 
@@ -222,7 +222,7 @@ static void test_pair_jobs_fail_cancel_race(void)
 {
     BlockJob *job1;
     BlockJob *job2;
-    BlockJobTxn *txn;
+    JobTxn *txn;
     int result1 = -EINPROGRESS;
     int result2 = -EINPROGRESS;
 
-- 
2.13.6
