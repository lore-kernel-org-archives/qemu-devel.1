Received: from eggs.gnu.org ([2001:4830:134:3::10]:39834)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePDv9-00055f-6k
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:46:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1ePDv8-0000Bn-6R
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 15:46:27 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 13 Dec 2017 15:46:11 -0500
Message-Id: <20171213204611.26276-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v2] blockjob: kick jobs on set-speed
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

If users set an unreasonably low speed (like one byte per second), the
calculated delay may exceed many hours. While we like to punish users
for asking for stupid things, we do also like to allow users to correct
their wicked ways.

When a user provides a new speed, kick the job to allow it to recalculate
its delay.

Signed-off-by: John Snow <jsnow@redhat.com>
---

RFC: Why is block_job_mutex shared between all jobs,
     instead of being per-job?

 blockjob.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 715c2c2680..6173e4728c 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -59,6 +59,7 @@ static void __attribute__((__constructor__)) block_job_init(void)
 
 static void block_job_event_cancelled(BlockJob *job);
 static void block_job_event_completed(BlockJob *job, const char *msg);
+static void block_job_enter_cond(BlockJob *job, bool(*fn)(BlockJob *job));
 
 /* Transactional group of block jobs */
 struct BlockJobTxn {
@@ -480,9 +481,16 @@ static void block_job_completed_txn_success(BlockJob *job)
     }
 }
 
+/* Assumes the block_job_mutex is held */
+static bool block_job_timer_pending(BlockJob *job)
+{
+    return timer_pending(&job->sleep_timer);
+}
+
 void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
 {
     Error *local_err = NULL;
+    int64_t old_speed = job->speed;
 
     if (!job->driver->set_speed) {
         error_setg(errp, QERR_UNSUPPORTED);
@@ -495,6 +503,12 @@ void block_job_set_speed(BlockJob *job, int64_t speed, Error **errp)
     }
 
     job->speed = speed;
+    if (speed <= old_speed) {
+        return;
+    }
+
+    /* kick only if a timer is pending */
+    block_job_enter_cond(job, block_job_timer_pending);
 }
 
 void block_job_complete(BlockJob *job, Error **errp)
@@ -821,7 +835,11 @@ void block_job_resume_all(void)
     }
 }
 
-void block_job_enter(BlockJob *job)
+/*
+ * Conditionally enter a block_job pending a call to fn() while
+ * under the block_job_lock critical section.
+ */
+static void block_job_enter_cond(BlockJob *job, bool(*fn)(BlockJob *job))
 {
     if (!block_job_started(job)) {
         return;
@@ -836,6 +854,11 @@ void block_job_enter(BlockJob *job)
         return;
     }
 
+    if (fn && !fn(job)) {
+        block_job_unlock();
+        return;
+    }
+
     assert(!job->deferred_to_main_loop);
     timer_del(&job->sleep_timer);
     job->busy = true;
@@ -843,6 +866,11 @@ void block_job_enter(BlockJob *job)
     aio_co_wake(job->co);
 }
 
+void block_job_enter(BlockJob *job)
+{
+    block_job_enter_cond(job, NULL);
+}
+
 bool block_job_is_cancelled(BlockJob *job)
 {
     return job->cancelled;
-- 
2.14.3
