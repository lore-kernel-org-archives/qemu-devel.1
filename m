Received: from eggs.gnu.org ([2001:4830:134:3::10]:57632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7jPo-0007R6-Le
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:13:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d7jPn-0003H0-Ou
	for qemu-devel@nongnu.org; Mon, 08 May 2017 10:13:32 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  8 May 2017 16:13:06 +0200
Message-Id: <20170508141310.8674-8-pbonzini@redhat.com>
In-Reply-To: <20170508141310.8674-1-pbonzini@redhat.com>
References: <20170508141310.8674-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/11] blockjob: introduce
 block_job_cancel_async, check iostatus invariants
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, jsnow@redhat.com, stefanha@redhat.com

The new functions helps respecting the invariant that the coroutine
is entered with false user_resume, zero pause count and no error
recorded in the iostatus.

Resetting the iostatus is now common to all of block_job_cancel_async,
block_job_user_resume and block_job_iostatus_reset, albeit with slight
differences:

- block_job_cancel_async resets the iostatus, and resumes the job if
there was an error, but the coroutine is not restarted immediately.
For example the caller may continue with a call to block_job_finish_sync.

- block_job_user_resume resets the iostatus.  It wants to resume the job
unconditionally, even if there was no error.

- block_job_iostatus_reset doesn't resume the job at all.  Maybe that's
a bug but it should be fixed separately.

block_job_iostatus_reset does the least common denominator, so add some
checking but otherwise leave it as the entry point for resetting the
iostatus.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 blockjob.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 7edf779adc..9a5204346f 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -304,6 +304,19 @@ static void block_job_completed_single(BlockJob *job)
     block_job_unref(job);
 }
 
+static void block_job_cancel_async(BlockJob *job)
+{
+    if (job->iostatus != BLOCK_DEVICE_IO_STATUS_OK) {
+        block_job_iostatus_reset(job);
+    }
+    if (job->user_paused) {
+        /* Do not call block_job_enter here, the caller will handle it.  */
+        job->user_paused = false;
+        job->pause_count--;
+    }
+    job->cancelled = true;
+}
+
 static void block_job_completed_txn_abort(BlockJob *job)
 {
     AioContext *ctx;
@@ -328,7 +341,7 @@ static void block_job_completed_txn_abort(BlockJob *job)
              * them; this job, however, may or may not be cancelled, depending
              * on the caller, so leave it. */
             if (other_job != job) {
-                other_job->cancelled = true;
+                block_job_cancel_async(other_job);
             }
             continue;
         }
@@ -411,8 +424,8 @@ bool block_job_user_paused(BlockJob *job)
 void block_job_user_resume(BlockJob *job)
 {
     if (job && job->user_paused && job->pause_count > 0) {
-        job->user_paused = false;
         block_job_iostatus_reset(job);
+        job->user_paused = false;
         block_job_resume(job);
     }
 }
@@ -420,8 +433,7 @@ void block_job_user_resume(BlockJob *job)
 void block_job_cancel(BlockJob *job)
 {
     if (block_job_started(job)) {
-        job->cancelled = true;
-        block_job_iostatus_reset(job);
+        block_job_cancel_async(job);
         block_job_enter(job);
     } else {
         block_job_completed(job, -ECANCELED);
@@ -765,6 +777,10 @@ void block_job_yield(BlockJob *job)
 
 void block_job_iostatus_reset(BlockJob *job)
 {
+    if (job->iostatus == BLOCK_DEVICE_IO_STATUS_OK) {
+        return;
+    }
+    assert(job->user_paused && job->pause_count > 0);
     job->iostatus = BLOCK_DEVICE_IO_STATUS_OK;
 }
 
-- 
2.12.2
