Received: from eggs.gnu.org ([2001:4830:134:3::10]:34262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoR-0004ZL-Ol
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoQ-0001VT-HO
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53454)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0qoQ-0001Uc-7t
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:30 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2058C81244
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 14:42:29 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-118-57.ams2.redhat.com
	[10.36.118.57] (may be forged))
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v3JEgK5G001048
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 10:42:28 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Apr 2017 16:42:15 +0200
Message-Id: <20170419144219.20371-8-pbonzini@redhat.com>
In-Reply-To: <20170419144219.20371-1-pbonzini@redhat.com>
References: <20170419144219.20371-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: rewritten

 blockjob.c | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 5906266..1756153 100644
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
2.9.3
