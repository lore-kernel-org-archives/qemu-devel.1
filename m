Received: from eggs.gnu.org ([2001:4830:134:3::10]:51961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRvy-0005Ay-LN
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fGRvx-0001V2-Ij
	for qemu-devel@nongnu.org; Wed, 09 May 2018 12:27:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  9 May 2018 18:26:02 +0200
Message-Id: <20180509162637.15575-8-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-1-kwolf@redhat.com>
References: <20180509162637.15575-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 07/42] blockjob: Remove
 block_job_pause/resume_all()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

Commit 81193349 removed the only use of block_job_pause/resume_all(),
which was in bdrv_drain_all(). The functions are now unused and can be
removed.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob_int.h | 14 --------------
 blockjob.c                   | 27 ---------------------------
 2 files changed, 41 deletions(-)

diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 4d0439c51e..62ec964d09 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -174,20 +174,6 @@ void block_job_yield(BlockJob *job);
 int64_t block_job_ratelimit_get_delay(BlockJob *job, uint64_t n);
 
 /**
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
-/**
  * block_job_early_fail:
  * @bs: The block device.
  *
diff --git a/blockjob.c b/blockjob.c
index 985621e256..9943218a34 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -1010,19 +1010,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
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
@@ -1100,20 +1087,6 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
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
2.13.6
