Received: from eggs.gnu.org ([2001:4830:134:3::10]:53876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmth2-0004fa-A4
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fmtgz-0001Fr-QZ
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 00:34:00 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  7 Aug 2018 00:33:37 -0400
Message-Id: <20180807043349.27196-10-jsnow@redhat.com>
In-Reply-To: <20180807043349.27196-1-jsnow@redhat.com>
References: <20180807043349.27196-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 09/21] tests/test-blockjob: utilize job_exit
 shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, jtc@redhat.com, Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

Change the manual deferment to test_block_job_complete into the implicit
callback to job_exit.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/test-blockjob.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/tests/test-blockjob.c b/tests/test-blockjob.c
index e408d52351..20563bde4f 100644
--- a/tests/test-blockjob.c
+++ b/tests/test-blockjob.c
@@ -163,11 +163,10 @@ typedef struct CancelJob {
     bool completed;
 } CancelJob;
 
-static void cancel_job_completed(Job *job, void *opaque)
+static void cancel_job_exit(Job *job)
 {
-    CancelJob *s = opaque;
+    CancelJob *s = container_of(job, CancelJob, common.job);
     s->completed = true;
-    job_completed(job, 0);
 }
 
 static void cancel_job_complete(Job *job, Error **errp)
@@ -182,7 +181,7 @@ static void coroutine_fn cancel_job_start(void *opaque)
 
     while (!s->should_complete) {
         if (job_is_cancelled(&s->common.job)) {
-            goto defer;
+            return;
         }
 
         if (!job_is_ready(&s->common.job) && s->should_converge) {
@@ -191,9 +190,6 @@ static void coroutine_fn cancel_job_start(void *opaque)
 
         job_sleep_ns(&s->common.job, 100000);
     }
-
- defer:
-    job_defer_to_main_loop(&s->common.job, cancel_job_completed, s);
 }
 
 static const BlockJobDriver test_cancel_driver = {
@@ -203,6 +199,7 @@ static const BlockJobDriver test_cancel_driver = {
         .user_resume   = block_job_user_resume,
         .drain         = block_job_drain,
         .start         = cancel_job_start,
+        .exit          = cancel_job_exit,
         .complete      = cancel_job_complete,
     },
 };
-- 
2.14.4
