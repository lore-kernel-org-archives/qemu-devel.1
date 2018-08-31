Received: from eggs.gnu.org ([2001:4830:134:3::10]:57965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvs0E-0001eQ-5x
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvrus-00079z-Lr
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:29:23 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 31 Aug 2018 18:29:00 -0400
Message-Id: <20180831222907.16257-9-jsnow@redhat.com>
In-Reply-To: <20180831222907.16257-1-jsnow@redhat.com>
References: <20180831222907.16257-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 08/15] tests/blockjob: replace Blockjob with
 Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jtc@redhat.com, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Jeff Cody <jcody@redhat.com>, John Snow <jsnow@redhat.com>

These tests don't actually test blockjobs anymore, they test
generic Job lifetimes. Change the types accordingly.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/test-blockjob.c | 98 ++++++++++++++++++++++++++-------------------------
 1 file changed, 50 insertions(+), 48 deletions(-)

diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index ad4a65bc78..8e8b680416 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -206,18 +206,20 @@ static const BlockJobDriver test_cancel_driver = {
     },
 };
 
-static CancelJob *create_common(BlockJob **pjob)
+static CancelJob *create_common(Job **pjob)
 {
     BlockBackend *blk;
-    BlockJob *job;
+    Job *job;
+    BlockJob *bjob;
     CancelJob *s;
 
     blk = create_blk(NULL);
-    job = mk_job(blk, "Steve", &test_cancel_driver, true,
-                 JOB_MANUAL_FINALIZE | JOB_MANUAL_DISMISS);
-    job_ref(&job->job);
-    assert(job->job.status == JOB_STATUS_CREATED);
-    s = container_of(job, CancelJob, common);
+    bjob = mk_job(blk, "Steve", &test_cancel_driver, true,
+                  JOB_MANUAL_FINALIZE | JOB_MANUAL_DISMISS);
+    job = &bjob->job;
+    job_ref(job);
+    assert(job->status == JOB_STATUS_CREATED);
+    s = container_of(bjob, CancelJob, common);
     s->blk = blk;
 
     *pjob = job;
@@ -242,7 +244,7 @@ static void cancel_common(CancelJob *s)
 
 static void test_cancel_created(void)
 {
-    BlockJob *job;
+    Job *job;
     CancelJob *s;
 
     s = create_common(&job);
@@ -251,119 +253,119 @@ static void test_cancel_created(void)
 
 static void test_cancel_running(void)
 {
-    BlockJob *job;
+    Job *job;
     CancelJob *s;
 
     s = create_common(&job);
 
-    job_start(&job->job);
-    assert(job->job.status == JOB_STATUS_RUNNING);
+    job_start(job);
+    assert(job->status == JOB_STATUS_RUNNING);
 
     cancel_common(s);
 }
 
 static void test_cancel_paused(void)
 {
-    BlockJob *job;
+    Job *job;
     CancelJob *s;
 
     s = create_common(&job);
 
-    job_start(&job->job);
-    assert(job->job.status == JOB_STATUS_RUNNING);
+    job_start(job);
+    assert(job->status == JOB_STATUS_RUNNING);
 
-    job_user_pause(&job->job, &error_abort);
-    job_enter(&job->job);
-    assert(job->job.status == JOB_STATUS_PAUSED);
+    job_user_pause(job, &error_abort);
+    job_enter(job);
+    assert(job->status == JOB_STATUS_PAUSED);
 
     cancel_common(s);
 }
 
 static void test_cancel_ready(void)
 {
-    BlockJob *job;
+    Job *job;
     CancelJob *s;
 
     s = create_common(&job);
 
-    job_start(&job->job);
-    assert(job->job.status == JOB_STATUS_RUNNING);
+    job_start(job);
+    assert(job->status == JOB_STATUS_RUNNING);
 
     s->should_converge = true;
-    job_enter(&job->job);
-    assert(job->job.status == JOB_STATUS_READY);
+    job_enter(job);
+    assert(job->status == JOB_STATUS_READY);
 
     cancel_common(s);
 }
 
 static void test_cancel_standby(void)
 {
-    BlockJob *job;
+    Job *job;
     CancelJob *s;
 
     s = create_common(&job);
 
-    job_start(&job->job);
-    assert(job->job.status == JOB_STATUS_RUNNING);
+    job_start(job);
+    assert(job->status == JOB_STATUS_RUNNING);
 
     s->should_converge = true;
-    job_enter(&job->job);
-    assert(job->job.status == JOB_STATUS_READY);
+    job_enter(job);
+    assert(job->status == JOB_STATUS_READY);
 
-    job_user_pause(&job->job, &error_abort);
-    job_enter(&job->job);
-    assert(job->job.status == JOB_STATUS_STANDBY);
+    job_user_pause(job, &error_abort);
+    job_enter(job);
+    assert(job->status == JOB_STATUS_STANDBY);
 
     cancel_common(s);
 }
 
 static void test_cancel_pending(void)
 {
-    BlockJob *job;
+    Job *job;
     CancelJob *s;
 
     s = create_common(&job);
 
-    job_start(&job->job);
-    assert(job->job.status == JOB_STATUS_RUNNING);
+    job_start(job);
+    assert(job->status == JOB_STATUS_RUNNING);
 
     s->should_converge = true;
-    job_enter(&job->job);
-    assert(job->job.status == JOB_STATUS_READY);
+    job_enter(job);
+    assert(job->status == JOB_STATUS_READY);
 
-    job_complete(&job->job, &error_abort);
-    job_enter(&job->job);
+    job_complete(job, &error_abort);
+    job_enter(job);
     while (!s->completed) {
         aio_poll(qemu_get_aio_context(), true);
     }
-    assert(job->job.status == JOB_STATUS_PENDING);
+    assert(job->status == JOB_STATUS_PENDING);
 
     cancel_common(s);
 }
 
 static void test_cancel_concluded(void)
 {
-    BlockJob *job;
+    Job *job;
     CancelJob *s;
 
     s = create_common(&job);
 
-    job_start(&job->job);
-    assert(job->job.status == JOB_STATUS_RUNNING);
+    job_start(job);
+    assert(job->status == JOB_STATUS_RUNNING);
 
     s->should_converge = true;
-    job_enter(&job->job);
-    assert(job->job.status == JOB_STATUS_READY);
+    job_enter(job);
+    assert(job->status == JOB_STATUS_READY);
 
-    job_complete(&job->job, &error_abort);
-    job_enter(&job->job);
+    job_complete(job, &error_abort);
+    job_enter(job);
     while (!s->completed) {
         aio_poll(qemu_get_aio_context(), true);
     }
-    assert(job->job.status == JOB_STATUS_PENDING);
+    assert(job->status == JOB_STATUS_PENDING);
 
-    job_finalize(&job->job, &error_abort);
-    assert(job->job.status == JOB_STATUS_CONCLUDED);
+    job_finalize(job, &error_abort);
+    assert(job->status == JOB_STATUS_CONCLUDED);
 
     cancel_common(s);
 }
-- 
2.14.4
