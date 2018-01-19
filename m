Received: from eggs.gnu.org ([2001:4830:134:3::10]:46598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdl3-0001zK-Ig
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ecdl2-00066l-KK
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 15:59:29 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 19 Jan 2018 15:58:46 -0500
Message-Id: <20180119205847.7141-13-jsnow@redhat.com>
In-Reply-To: <20180119205847.7141-1-jsnow@redhat.com>
References: <20180119205847.7141-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2 12/13] blockjob: privatize block_job_sleep_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

There's not currently any external caller of it.

Except in tests, but we'll fix that here too.

Replace usages in test cases with block_job_relax, which functions
similarly enough to be used as a drop-in replacement.

Very technically block_job_sleep_ns(job, 0) behaves differently
from block_job_relax(job, 0) in that relax may resolve to a no-op,
but this makes no difference in the test in which it is used.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c                   | 11 ++++++++++-
 include/block/blockjob_int.h | 11 -----------
 tests/test-bdrv-drain.c      |  2 +-
 tests/test-blockjob-txn.c    |  2 +-
 4 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index b5a0cda412..40167d6896 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -876,7 +876,16 @@ bool block_job_is_cancelled(BlockJob *job)
     return job->cancelled;
 }
 
-int block_job_sleep_ns(BlockJob *job, int64_t ns)
+/**
+ * block_job_sleep_ns:
+ * @job: The job that calls the function.
+ * @ns: How many nanoseconds to stop for.
+ *
+ * Put the job to sleep (assuming that it wasn't canceled) for @ns
+ * %QEMU_CLOCK_REALTIME nanoseconds.  Canceling the job will immediately
+ * interrupt the wait.
+ */
+static int block_job_sleep_ns(BlockJob *job, int64_t ns)
 {
     assert(job->busy);
 
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 1ceb47e1e6..c4891a5a9b 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -138,17 +138,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
                        uint64_t shared_perm, int64_t speed, int flags,
                        BlockCompletionFunc *cb, void *opaque, Error **errp);
 
-/**
- * block_job_sleep_ns:
- * @job: The job that calls the function.
- * @ns: How many nanoseconds to stop for.
- *
- * Put the job to sleep (assuming that it wasn't canceled) for @ns
- * %QEMU_CLOCK_REALTIME nanoseconds.  Canceling the job will immediately
- * interrupt the wait.
- */
-int block_job_sleep_ns(BlockJob *job, int64_t ns);
-
 /**
  * block_job_yield:
  * @job: The job that calls the function.
diff --git a/tests/test-bdrv-drain.c b/tests/test-bdrv-drain.c
index d760e2b243..5d47541b4c 100644
--- a/tests/test-bdrv-drain.c
+++ b/tests/test-bdrv-drain.c
@@ -506,7 +506,7 @@ static void coroutine_fn test_job_start(void *opaque)
     TestBlockJob *s = opaque;
 
     while (!s->should_complete) {
-        block_job_sleep_ns(&s->common, 100000);
+        block_job_relax(&s->common, 100000);
     }
 
     block_job_defer_to_main_loop(&s->common, test_job_completed, NULL);
diff --git a/tests/test-blockjob-txn.c b/tests/test-blockjob-txn.c
index 3591c9617f..edcf0de6bd 100644
--- a/tests/test-blockjob-txn.c
+++ b/tests/test-blockjob-txn.c
@@ -44,7 +44,7 @@ static void coroutine_fn test_block_job_run(void *opaque)
 
     while (s->iterations--) {
         if (s->use_timer) {
-            block_job_sleep_ns(job, 0);
+            block_job_relax(job, 0);
         } else {
             block_job_yield(job);
         }
-- 
2.14.3
