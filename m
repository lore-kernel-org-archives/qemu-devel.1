Received: from eggs.gnu.org ([2001:4830:134:3::10]:56899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGc6y-0000Yb-Nr
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 21:47:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1eGc6x-0008L5-V9
	for qemu-devel@nongnu.org; Sun, 19 Nov 2017 21:47:04 -0500
From: Jeff Cody <jcody@redhat.com>
Date: Sun, 19 Nov 2017 21:46:42 -0500
Message-Id: <2cd4d33dc68bb3c738e1c9aa39a0ddd4108c401e.1511145863.git.jcody@redhat.com>
In-Reply-To: <cover.1511145863.git.jcody@redhat.com>
References: <cover.1511145863.git.jcody@redhat.com>
In-Reply-To: <cover.1511145863.git.jcody@redhat.com>
References: <cover.1511145863.git.jcody@redhat.com>
Subject: [Qemu-devel] [PATCH 1/5] blockjob: do not allow coroutine double
 entry or entry-after-completion
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

This fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1508708

Also, in block_job_start(), set the relevant job flags (.busy, .paused)
before creating the coroutine, not just before executing it.

Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 blockjob.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 3a0c491..e181295 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -291,10 +291,10 @@ void block_job_start(BlockJob *job)
 {
     assert(job && !block_job_started(job) && job->paused &&
            job->driver && job->driver->start);
-    job->co = qemu_coroutine_create(block_job_co_entry, job);
     job->pause_count--;
     job->busy = true;
     job->paused = false;
+    job->co = qemu_coroutine_create(block_job_co_entry, job);
     bdrv_coroutine_enter(blk_bs(job->blk), job->co);
 }
 
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
-- 
2.9.5
