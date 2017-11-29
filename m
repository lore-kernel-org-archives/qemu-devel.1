Received: from eggs.gnu.org ([2001:4830:134:3::10]:41737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3im-0006Wt-Ge
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:52:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3il-0006Ym-HP
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:52:20 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 22:49:56 +0800
Message-Id: <20171129144956.11409-10-famz@redhat.com>
In-Reply-To: <20171129144956.11409-1-famz@redhat.com>
References: <20171129144956.11409-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 9/9] blockjob: Drop unused functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 blockjob.c                   | 24 ------------------------
 include/block/blockjob_int.h | 14 --------------
 2 files changed, 38 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 809111bf24..bfeb7c4ace 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -699,18 +699,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     return job;
 }
 
-void block_job_pause_all(void)
-{
-    BlockJob *job = NULL;
-    while ((job = block_job_next(job))) {
-        AioContext *aio_context = blk_get_aio_context(job->blk);
-
-        aio_context_acquire(aio_context);
-        block_job_pause(job);
-        aio_context_release(aio_context);
-    }
-}
-
 void block_job_early_fail(BlockJob *job)
 {
     block_job_unref(job);
@@ -764,18 +752,6 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
     }
 }
 
-void block_job_resume_all(void)
-{
-    BlockJob *job = NULL;
-    while ((job = block_job_next(job))) {
-        AioContext *aio_context = blk_get_aio_context(job->blk);
-
-        aio_context_acquire(aio_context);
-        block_job_resume(job);
-        aio_context_release(aio_context);
-    }
-}
-
 void block_job_enter(BlockJob *job)
 {
     if (!block_job_started(job)) {
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index 43f3be2965..4b43367608 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -156,20 +156,6 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns);
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
-- 
2.14.3
