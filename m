Received: from eggs.gnu.org ([2001:4830:134:3::10]:60186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfL6-0000eR-6E
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fJfL0-0006VF-Bb
	for qemu-devel@nongnu.org; Fri, 18 May 2018 09:22:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 18 May 2018 15:21:12 +0200
Message-Id: <20180518132114.4070-39-kwolf@redhat.com>
In-Reply-To: <20180518132114.4070-1-kwolf@redhat.com>
References: <20180518132114.4070-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 38/40] blockjob: Remove BlockJob.driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jsnow@redhat.com, eblake@redhat.com, jcody@redhat.com, armbru@redhat.com, qemu-devel@nongnu.org

BlockJob.driver is redundant with Job.driver and only used in very few
places any more. Remove it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/blockjob.h |  3 ---
 blockjob.c               | 17 ++++++++++-------
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 3021d11126..32c00b7dc0 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -43,9 +43,6 @@ typedef struct BlockJob {
     /** Data belonging to the generic Job infrastructure */
     Job job;
 
-    /** The job type, including the job vtable.  */
-    const BlockJobDriver *driver;
-
     /** The block device on which the job is operating.  */
     BlockBackend *blk;
 
diff --git a/blockjob.c b/blockjob.c
index 5c8ff6f846..0306533a2e 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -103,10 +103,12 @@ static void block_job_attached_aio_context(AioContext *new_context,
                                            void *opaque)
 {
     BlockJob *job = opaque;
+    const JobDriver *drv = job->job.driver;
+    BlockJobDriver *bjdrv = container_of(drv, BlockJobDriver, job_driver);
 
     job->job.aio_context = new_context;
-    if (job->driver->attached_aio_context) {
-        job->driver->attached_aio_context(job, new_context);
+    if (bjdrv->attached_aio_context) {
+        bjdrv->attached_aio_context(job, new_context);
     }
 
     job_resume(&job->job);
@@ -115,10 +117,12 @@ static void block_job_attached_aio_context(AioContext *new_context,
 void block_job_drain(Job *job)
 {
     BlockJob *bjob = container_of(job, BlockJob, job);
+    const JobDriver *drv = job->driver;
+    BlockJobDriver *bjdrv = container_of(drv, BlockJobDriver, job_driver);
 
     blk_drain(bjob->blk);
-    if (bjob->driver->drain) {
-        bjob->driver->drain(bjob);
+    if (bjdrv->drain) {
+        bjdrv->drain(bjob);
     }
 }
 
@@ -201,7 +205,7 @@ bool block_job_is_internal(BlockJob *job)
 
 const BlockJobDriver *block_job_driver(BlockJob *job)
 {
-    return job->driver;
+    return container_of(job->job.driver, BlockJobDriver, job_driver);
 }
 
 /* Assumes the job_mutex is held */
@@ -386,8 +390,7 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     assert(job->job.driver->user_resume == &block_job_user_resume);
     assert(job->job.driver->drain == &block_job_drain);
 
-    job->driver        = driver;
-    job->blk           = blk;
+    job->blk = blk;
 
     job->finalize_cancelled_notifier.notify = block_job_event_cancelled;
     job->finalize_completed_notifier.notify = block_job_event_completed;
-- 
2.13.6
