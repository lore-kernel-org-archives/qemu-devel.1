Received: from eggs.gnu.org ([2001:4830:134:3::10]:59964)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2eX-00023W-3e
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eR2eW-0003TC-3b
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 16:08:49 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Mon, 18 Dec 2017 16:08:15 -0500
Message-Id: <20171218210819.31576-7-jcody@redhat.com>
In-Reply-To: <20171218210819.31576-1-jcody@redhat.com>
References: <20171218210819.31576-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL 06/10] blockjob: kick jobs on set-speed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

If users set an unreasonably low speed (like one byte per second), the
calculated delay may exceed many hours. While we like to punish users
for asking for stupid things, we do also like to allow users to correct
their wicked ways.

When a user provides a new speed, kick the job to allow it to recalculate
its delay.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20171213204611.26276-1-jsnow@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 blockjob.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 715c2c2..6173e47 100644
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
2.9.5
