Received: from eggs.gnu.org ([2001:4830:134:3::10]:59052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmcy-0001A4-Ez
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1evmcw-0004SM-IY
	for qemu-devel@nongnu.org; Tue, 13 Mar 2018 12:18:16 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 13 Mar 2018 17:17:24 +0100
Message-Id: <20180313161803.1814-3-kwolf@redhat.com>
In-Reply-To: <20180313161803.1814-1-kwolf@redhat.com>
References: <20180313161803.1814-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 02/41] blockjobs: model single jobs as
 transactions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

model all independent jobs as single job transactions.

It's one less case we have to worry about when we add more states to the
transition machine. This way, we can just treat all job lifetimes exactly
the same. This helps tighten assertions of the STM graph and removes some
conditionals that would have been needed in the coming commits adding a
more explicit job lifetime management API.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h     |  1 -
 include/block/blockjob_int.h |  3 ++-
 block/backup.c               |  3 +--
 block/commit.c               |  2 +-
 block/mirror.c               |  2 +-
 block/stream.c               |  2 +-
 blockjob.c                   | 25 ++++++++++++++++---------
 tests/test-bdrv-drain.c      |  4 ++--
 tests/test-blockjob-txn.c    | 19 +++++++------------
 tests/test-blockjob.c        |  2 +-
 10 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 00403d9482..29cde3ffe3 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -141,7 +141,6 @@ typedef struct BlockJob {
      */
     QEMUTimer sleep_timer;
 
-    /** Non-NULL if this job is part of a transaction */
     BlockJobTxn *txn;
     QLIST_ENTRY(BlockJob) txn_list;
 } BlockJob;
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index c9b23b0cc9..becaae74c2 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -115,6 +115,7 @@ struct BlockJobDriver {
  * @job_id: The id of the newly-created job, or %NULL to have one
  * generated automatically.
  * @job_type: The class object for the newly-created job.
+ * @txn: The transaction this job belongs to, if any. %NULL otherwise.
  * @bs: The block
  * @perm, @shared_perm: Permissions to request for @bs
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
@@ -132,7 +133,7 @@ struct BlockJobDriver {
  * called from a wrapper that is specific to the job type.
  */
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
-                       BlockDriverState *bs, uint64_t perm,
+                       BlockJobTxn *txn, BlockDriverState *bs, uint64_t perm,
                        uint64_t shared_perm, int64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp);
 
diff --git a/block/backup.c b/block/backup.c
index 4a16a37229..7e254dabff 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -621,7 +621,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     }
 
     /* job->common.len is fixed, so we can't allow resize */
-    job = block_job_create(job_id, &backup_job_driver, bs,
+    job = block_job_create(job_id, &backup_job_driver, txn, bs,
                            BLK_PERM_CONSISTENT_READ,
                            BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE |
                            BLK_PERM_WRITE_UNCHANGED | BLK_PERM_GRAPH_MOD,
@@ -677,7 +677,6 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     block_job_add_bdrv(&job->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
     job->common.len = len;
-    block_job_txn_add_job(txn, &job->common);
 
     return &job->common;
 
diff --git a/block/commit.c b/block/commit.c
index 1943c9c3e1..ab4fa3c3cf 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -289,7 +289,7 @@ void commit_start(const char *job_id, BlockDriverState *bs,
         return;
     }
 
-    s = block_job_create(job_id, &commit_job_driver, bs, 0, BLK_PERM_ALL,
+    s = block_job_create(job_id, &commit_job_driver, NULL, bs, 0, BLK_PERM_ALL,
                          speed, BLOCK_JOB_DEFAULT, NULL, NULL, errp);
     if (!s) {
         return;
diff --git a/block/mirror.c b/block/mirror.c
index f5bf620942..76fddb3838 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1166,7 +1166,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     }
 
     /* Make sure that the source is not resized while the job is running */
-    s = block_job_create(job_id, driver, mirror_top_bs,
+    s = block_job_create(job_id, driver, NULL, mirror_top_bs,
                          BLK_PERM_CONSISTENT_READ,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                          BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD, speed,
diff --git a/block/stream.c b/block/stream.c
index 499cdacdb0..f3b53f49e2 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -244,7 +244,7 @@ void stream_start(const char *job_id, BlockDriverState *bs,
     /* Prevent concurrent jobs trying to modify the graph structure here, we
      * already have our own plans. Also don't allow resize as the image size is
      * queried only at the job start and then cached. */
-    s = block_job_create(job_id, &stream_job_driver, bs,
+    s = block_job_create(job_id, &stream_job_driver, NULL, bs,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                          BLK_PERM_GRAPH_MOD,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
diff --git a/blockjob.c b/blockjob.c
index afd92db01f..ecc5fcbdf8 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -357,10 +357,8 @@ static void block_job_completed_single(BlockJob *job)
         }
     }
 
-    if (job->txn) {
-        QLIST_REMOVE(job, txn_list);
-        block_job_txn_unref(job->txn);
-    }
+    QLIST_REMOVE(job, txn_list);
+    block_job_txn_unref(job->txn);
     block_job_unref(job);
 }
 
@@ -647,7 +645,7 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
  */
 
 void *block_job_create(const char *job_id, const BlockJobDriver *driver,
-                       BlockDriverState *bs, uint64_t perm,
+                       BlockJobTxn *txn, BlockDriverState *bs, uint64_t perm,
                        uint64_t shared_perm, int64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp)
 {
@@ -729,6 +727,17 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
             return NULL;
         }
     }
+
+    /* Single jobs are modeled as single-job transactions for sake of
+     * consolidating the job management logic */
+    if (!txn) {
+        txn = block_job_txn_new();
+        block_job_txn_add_job(txn, job);
+        block_job_txn_unref(txn);
+    } else {
+        block_job_txn_add_job(txn, job);
+    }
+
     return job;
 }
 
@@ -752,13 +761,11 @@ void block_job_early_fail(BlockJob *job)
 
 void block_job_completed(BlockJob *job, int ret)
 {
+    assert(job && job->txn && !job->completed);
     assert(blk_bs(job->blk)->job == job);
-    assert(!job->completed);
     job->completed = true;
     job->ret = ret;
-    if (!job->txn) {
-        block_job_completed_single(job);
-    } else if (ret < 0 || block_job_is_cancelled(job)) {
+    if (ret < 0 || block_job_is_cancelled(job)) {
         block_job_completed_txn_abort(job);
     } else {
         block_job_completed_txn_success(job);
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index d760e2b243..a7eecf1c1e 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -541,8 +541,8 @@ static void test_blockjob_common(enum drain_type drain_type)
     blk_target = blk_new(BLK_PERM_ALL, BLK_PERM_ALL);
     blk_insert_bs(blk_target, target, &error_abort);
 
-    job = block_job_create("job0", &test_job_driver, src, 0, BLK_PERM_ALL, 0,
-                           0, NULL, NULL, &error_abort);
+    job = block_job_create("job0", &test_job_driver, NULL, src, 0, BLK_PERM_ALL,
+                           0, 0, NULL, NULL, &error_abort);
     block_job_add_bdrv(job, "target", target, 0, BLK_PERM_ALL, &error_abort);
     block_job_start(job);
 
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 3591c9617f..34f09ef8c1 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -87,7 +87,7 @@ static const BlockJobDriver test_block_job_driver = {
  */
 static BlockJob *test_block_job_start(unsigned int iterations,
                                       bool use_timer,
-                                      int rc, int *result)
+                                      int rc, int *result, BlockJobTxn *txn)
 {
     BlockDriverState *bs;
     TestBlockJob *s;
@@ -101,7 +101,7 @@ static BlockJob *test_block_job_start(unsigned int iterations,
     g_assert_nonnull(bs);
 
     snprintf(job_id, sizeof(job_id), "job%u", counter++);
-    s = block_job_create(job_id, &test_block_job_driver, bs,
+    s = block_job_create(job_id, &test_block_job_driver, txn, bs,
                          0, BLK_PERM_ALL, 0, BLOCK_JOB_DEFAULT,
                          test_block_job_cb, data, &error_abort);
     s->iterations = iterations;
@@ -120,8 +120,7 @@ static void test_single_job(int expected)
     int result = -EINPROGRESS;
 
     txn = block_job_txn_new();
-    job = test_block_job_start(1, true, expected, &result);
-    block_job_txn_add_job(txn, job);
+    job = test_block_job_start(1, true, expected, &result, txn);
     block_job_start(job);
 
     if (expected == -ECANCELED) {
@@ -160,10 +159,8 @@ static void test_pair_jobs(int expected1, int expected2)
     int result2 = -EINPROGRESS;
 
     txn = block_job_txn_new();
-    job1 = test_block_job_start(1, true, expected1, &result1);
-    block_job_txn_add_job(txn, job1);
-    job2 = test_block_job_start(2, true, expected2, &result2);
-    block_job_txn_add_job(txn, job2);
+    job1 = test_block_job_start(1, true, expected1, &result1, txn);
+    job2 = test_block_job_start(2, true, expected2, &result2, txn);
     block_job_start(job1);
     block_job_start(job2);
 
@@ -224,10 +221,8 @@ static void test_pair_jobs_fail_cancel_race(void)
     int result2 = -EINPROGRESS;
 
     txn = block_job_txn_new();
-    job1 = test_block_job_start(1, true, -ECANCELED, &result1);
-    block_job_txn_add_job(txn, job1);
-    job2 = test_block_job_start(2, false, 0, &result2);
-    block_job_txn_add_job(txn, job2);
+    job1 = test_block_job_start(1, true, -ECANCELED, &result1, txn);
+    job2 = test_block_job_start(2, false, 0, &result2, txn);
     block_job_start(job1);
     block_job_start(job2);
 
diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 23bdf1a932..599e28d732 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -30,7 +30,7 @@ static BlockJob *do_test_id(BlockBackend *blk, const char *id,
     BlockJob *job;
     Error *errp = NULL;
 
-    job = block_job_create(id, &test_block_job_driver, blk_bs(blk),
+    job = block_job_create(id, &test_block_job_driver, NULL, blk_bs(blk),
                            0, BLK_PERM_ALL, 0, BLOCK_JOB_DEFAULT, block_job_cb,
                            NULL, &errp);
     if (should_succeed) {
-- 
2.13.6
