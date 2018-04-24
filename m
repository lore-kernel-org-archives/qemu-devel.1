Received: from eggs.gnu.org ([2001:4830:134:3::10]:43765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fAthV-0006ZL-Bk
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:53:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fAthR-0000aZ-Id
	for qemu-devel@nongnu.org; Tue, 24 Apr 2018 04:53:25 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 24 Apr 2018 09:52:40 +0100
Message-Id: <20180424085240.5798-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH] blockjob: drop block_job_pause/resume_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Jeff Cody <jcody@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

Commit 8119334918e86f45877cfc139192d54f2449a239 ("block: Don't
block_job_pause_all() in bdrv_drain_all()") removed the only callers of
block_job_pause/resume_all().

Pausing and resuming now happens in child_job_drained_begin/end() so
it's no longer necessary to globally pause/resume jobs.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 include/block/blockjob_int.h | 14 --------------
 blockjob.c                   | 27 ---------------------------
 2 files changed, 41 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 642adce68b..d5a515de9b 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -168,20 +168,6 @@ void block_job_sleep_ns(BlockJob *job, int64_t ns);
  */
 void block_job_yield(BlockJob *job);
 
-/**
- * block_job_pause_all:
- *
- * Asynchronously pause all jobs.
- */
-void block_job_pause_all(void);
-
-/**
- * block_job_resume_all:
- *
- * Resume all block jobs.  Must be paired with a preceding block_job_pause_all.
- */
-void block_job_resume_all(void);
-
 /**
  * block_job_early_fail:
  * @bs: The block device.
diff --git a/blockjob.c b/blockjob.c
index 27f957e571..dfffad921a 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -988,19 +988,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     return job;
 }
 
-void block_job_pause_all(void)
-{
-    BlockJob *job = NULL;
-    while ((job = block_job_next(job))) {
-        AioContext *aio_context = blk_get_aio_context(job->blk);
-
-        aio_context_acquire(aio_context);
-        block_job_ref(job);
-        block_job_pause(job);
-        aio_context_release(aio_context);
-    }
-}
-
 void block_job_early_fail(BlockJob *job)
 {
     assert(job->status == BLOCK_JOB_STATUS_CREATED);
@@ -1078,20 +1065,6 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
     }
 }
 
-void block_job_resume_all(void)
-{
-    BlockJob *job, *next;
-
-    QLIST_FOREACH_SAFE(job, &block_jobs, job_list, next) {
-        AioContext *aio_context = blk_get_aio_context(job->blk);
-
-        aio_context_acquire(aio_context);
-        block_job_resume(job);
-        block_job_unref(job);
-        aio_context_release(aio_context);
-    }
-}
-
 /*
  * Conditionally enter a block_job pending a call to fn() while
  * under the block_job_lock critical section.
-- 
2.14.3
