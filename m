Received: from eggs.gnu.org ([2001:4830:134:3::10]:46795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eHAe0-0006ui-Vi
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:39:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eHAdw-0001pk-2w
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 10:39:29 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Tue, 21 Nov 2017 10:38:50 -0500
Message-Id: <dd0e99997299b76eeeefa11ce7113a81fe56b704.1511278397.git.jcody@redhat.com>
In-Reply-To: <cover.1511278397.git.jcody@redhat.com>
References: <cover.1511278397.git.jcody@redhat.com>
In-Reply-To: <cover.1511278397.git.jcody@redhat.com>
References: <cover.1511278397.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH v3 for-2.11 1/4] blockjob: do not allow
 coroutine double entry or entry-after-completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, famz@redhat.com, pbonzini@redhat.com, kwolf@redhat.com

When block_job_sleep_ns() is called, the co-routine is scheduled for
future execution.  If we allow the job to be re-entered prior to the
scheduled time, we present a race condition in which a coroutine can be
entered recursively, or even entered after the coroutine is deleted.

The job->busy flag is used by blockjobs when a coroutine is busy
executing. The function 'block_job_enter()' obeys the busy flag,
and will not enter a coroutine if set.  If we sleep a job, we need to
leave the busy flag set, so that subsequent calls to block_job_enter()
are prevented.

This changes the prior behavior of block_job_cancel() being able to
immediately wake up and cancel a job; in practice, this should not be an
issue, as the coroutine sleep times are generally very small, and the
cancel will occur the next time the coroutine wakes up.

This fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1508708

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 blockjob.c                   | 7 +++++--
 include/block/blockjob_int.h | 3 ++-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 3a0c491..ff9a614 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -797,11 +797,14 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns)
         return;
     }
 
-    job->busy = false;
+    /* We need to leave job->busy set here, because when we have
+     * put a coroutine to 'sleep', we have scheduled it to run in
+     * the future.  We cannot enter that same coroutine again before
+     * it wakes and runs, otherwise we risk double-entry or entry after
+     * completion. */
     if (!block_job_should_pause(job)) {
         co_aio_sleep_ns(blk_get_aio_context(job->blk), type, ns);
     }
-    job->busy = true;
 
     block_job_pause_point(job);
 }
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index f13ad05..43f3be2 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -143,7 +143,8 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
  * @ns: How many nanoseconds to stop for.
  *
  * Put the job to sleep (assuming that it wasn't canceled) for @ns
- * nanoseconds.  Canceling the job will interrupt the wait immediately.
+ * nanoseconds.  Canceling the job will not interrupt the wait, so the
+ * cancel will not process until the coroutine wakes up.
  */
 void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns);
 
-- 
2.9.5
