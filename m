Received: from eggs.gnu.org ([2001:4830:134:3::10]:57965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvs0J-0001eQ-G6
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:35:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvrus-00079k-JC
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 18:29:23 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 31 Aug 2018 18:29:01 -0400
Message-Id: <20180831222907.16257-10-jsnow@redhat.com>
In-Reply-To: <20180831222907.16257-1-jsnow@redhat.com>
References: <20180831222907.16257-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/15] tests/test-blockjob: remove exit
 callback
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

We remove the exit callback and the completed boolean along with it.
We can simulate it just fine by waiting for the job to defer to the
main loop, and then giving it one final kick to get the main loop
portion to run.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 tests/test-blockjob.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index 8e8b680416..de4c1c20aa 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -160,15 +160,8 @@ typedef struct CancelJob {
     BlockBackend *blk;
     bool should_converge;
     bool should_complete;
-    bool completed;
 } CancelJob;
 
-static void cancel_job_exit(Job *job)
-{
-    CancelJob *s = container_of(job, CancelJob, common.job);
-    s->completed = true;
-}
-
 static void cancel_job_complete(Job *job, Error **errp)
 {
     CancelJob *s = container_of(job, CancelJob, common.job);
@@ -201,7 +194,6 @@ static const BlockJobDriver test_cancel_driver = {
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
         .run           = cancel_job_run,
-        .exit          = cancel_job_exit,
         .complete      = cancel_job_complete,
     },
 };
@@ -335,9 +327,11 @@ static void test_cancel_pending(void)
 
     job_complete(job, &error_abort);
     job_enter(job);
-    while (!s->completed) {
+    while (!job->deferred_to_main_loop) {
         aio_poll(qemu_get_aio_context(), true);
     }
+    assert(job->status == JOB_STATUS_READY);
+    aio_poll(qemu_get_aio_context(), true);
     assert(job->status == JOB_STATUS_PENDING);
 
     cancel_common(s);
@@ -359,9 +353,11 @@ static void test_cancel_concluded(void)
 
     job_complete(job, &error_abort);
     job_enter(job);
-    while (!s->completed) {
+    while (!job->deferred_to_main_loop) {
         aio_poll(qemu_get_aio_context(), true);
     }
+    assert(job->status == JOB_STATUS_READY);
+    aio_poll(qemu_get_aio_context(), true);
     assert(job->status == JOB_STATUS_PENDING);
 
     job_finalize(job, &error_abort);
-- 
2.14.4
