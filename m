Received: from eggs.gnu.org ([2001:4830:134:3::10]:55449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8Q-0005yC-VG
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1epN8N-00062g-NX
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 18:52:14 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 23 Feb 2018 18:51:42 -0500
Message-Id: <20180223235142.21501-22-jsnow@redhat.com>
In-Reply-To: <20180223235142.21501-1-jsnow@redhat.com>
References: <20180223235142.21501-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC v4 21/21] blockjobs: add manual_mgmt option to
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

This allows us to easily force the option for all jobs belonging
to a transaction to ensure consistency with how all those jobs
will be handled.

This is purely a convenience.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c                |  7 ++++++-
 blockjob.c                | 10 +++++++---
 include/block/blockjob.h  |  5 ++++-
 qapi/transaction.json     |  3 ++-
 tests/test-blockjob-txn.c |  6 +++---
 5 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 2eddb0e726..34181c41c2 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2225,6 +2225,11 @@ static TransactionProperties *get_transaction_properties(
         props->completion_mode = ACTION_COMPLETION_MODE_INDIVIDUAL;
     }
 
+    if (!props->has_manual_mgmt) {
+        props->has_manual_mgmt = true;
+        props->manual_mgmt = false;
+    }
+
     return props;
 }
 
@@ -2250,7 +2255,7 @@ void qmp_transaction(TransactionActionList *dev_list,
      */
     props = get_transaction_properties(props);
     if (props->completion_mode != ACTION_COMPLETION_MODE_INDIVIDUAL) {
-        block_job_txn = block_job_txn_new();
+        block_job_txn = block_job_txn_new(props->manual_mgmt);
     }
 
     /* drain all i/o before any operations */
diff --git a/blockjob.c b/blockjob.c
index f9e8a64261..eaaa2aea65 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -136,6 +136,9 @@ struct BlockJobTxn {
 
     /* Reference count */
     int refcnt;
+
+    /* Participating jobs must use manual completion */
+    bool manual;
 };
 
 static QLIST_HEAD(, BlockJob) block_jobs = QLIST_HEAD_INITIALIZER(block_jobs);
@@ -176,11 +179,12 @@ BlockJob *block_job_get(const char *id)
     return NULL;
 }
 
-BlockJobTxn *block_job_txn_new(void)
+BlockJobTxn *block_job_txn_new(bool manual_mgmt)
 {
     BlockJobTxn *txn = g_new0(BlockJobTxn, 1);
     QLIST_INIT(&txn->jobs);
     txn->refcnt = 1;
+    txn->manual = manual_mgmt;
     return txn;
 }
 
@@ -944,7 +948,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
-    job->manual        = (flags & BLOCK_JOB_MANUAL);
+    job->manual        = (flags & BLOCK_JOB_MANUAL) || (txn && txn->manual);
     job->status        = BLOCK_JOB_STATUS_CREATED;
     block_job_state_transition(job, BLOCK_JOB_STATUS_CREATED);
     aio_timer_init(qemu_get_aio_context(), &job->sleep_timer,
@@ -978,7 +982,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     /* Single jobs are modeled as single-job transactions for sake of
      * consolidating the job management logic */
     if (!txn) {
-        txn = block_job_txn_new();
+        txn = block_job_txn_new(false);
         block_job_txn_add_job(txn, job);
         block_job_txn_unref(txn);
     } else {
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index e09064c342..f3d026f13d 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -371,8 +371,11 @@ void block_job_iostatus_reset(BlockJob *job);
  * All jobs in the transaction either complete successfully or fail/cancel as a
  * group.  Jobs wait for each other before completing.  Cancelling one job
  * cancels all jobs in the transaction.
+ *
+ * @manual_mgmt: whether or not jobs that belong to this transaction will be
+ *               forced to use 2.12+ job management semantics
  */
-BlockJobTxn *block_job_txn_new(void);
+BlockJobTxn *block_job_txn_new(bool manual_mgmt);
 
 /**
  * block_job_ref:
diff --git a/qapi/transaction.json b/qapi/transaction.json
index bd312792da..9611758cb6 100644
--- a/qapi/transaction.json
+++ b/qapi/transaction.json
@@ -79,7 +79,8 @@
 ##
 { 'struct': 'TransactionProperties',
   'data': {
-       '*completion-mode': 'ActionCompletionMode'
+       '*completion-mode': 'ActionCompletionMode',
+       '*manual-mgmt': 'bool'
   }
 }
 
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 34f09ef8c1..2d84f9a41e 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -119,7 +119,7 @@ static void test_single_job(int expected)
     BlockJobTxn *txn;
     int result = -EINPROGRESS;
 
-    txn = block_job_txn_new();
+    txn = block_job_txn_new(false);
     job = test_block_job_start(1, true, expected, &result, txn);
     block_job_start(job);
 
@@ -158,7 +158,7 @@ static void test_pair_jobs(int expected1, int expected2)
     int result1 = -EINPROGRESS;
     int result2 = -EINPROGRESS;
 
-    txn = block_job_txn_new();
+    txn = block_job_txn_new(false);
     job1 = test_block_job_start(1, true, expected1, &result1, txn);
     job2 = test_block_job_start(2, true, expected2, &result2, txn);
     block_job_start(job1);
@@ -220,7 +220,7 @@ static void test_pair_jobs_fail_cancel_race(void)
     int result1 = -EINPROGRESS;
     int result2 = -EINPROGRESS;
 
-    txn = block_job_txn_new();
+    txn = block_job_txn_new(false);
     job1 = test_block_job_start(1, true, -ECANCELED, &result1, txn);
     job2 = test_block_job_start(2, false, 0, &result2, txn);
     block_job_start(job1);
-- 
2.14.3
