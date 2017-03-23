Received: from eggs.gnu.org ([2001:4830:134:3::10]:53846)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i1-0005Pz-Cv
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cr6i0-0002RI-4c
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37358)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cr6hz-0002R9-Rv
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 13:39:36 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E1655624A9
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 17:39:35 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 23 Mar 2017 18:39:22 +0100
Message-Id: <20170323173928.14439-5-pbonzini@redhat.com>
In-Reply-To: <20170323173928.14439-1-pbonzini@redhat.com>
References: <20170323173928.14439-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 04/10] blockjob: introduce
 block_job_pause/resume_all
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jcody@redhat.com, jsnow@redhat.com

Remove use of block_job_pause/resume from outside blockjob.c, thus
making them static.  Again, one reason to do this is that
block_job_pause/resume will have different locking rules compared
to everything else that block.c and block/io.c use.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/io.c               |  18 +-------
 blockjob.c               | 114 ++++++++++++++++++++++++++++-------------------
 include/block/blockjob.h |  14 +++---
 3 files changed, 77 insertions(+), 69 deletions(-)

diff --git a/block/io.c b/block/io.c
index 2709a70..1cc9318 100644
--- a/block/io.c
+++ b/block/io.c
@@ -284,16 +284,9 @@ void bdrv_drain_all_begin(void)
     bool waited = true;
     BlockDriverState *bs;
     BdrvNextIterator it;
-    BlockJob *job = NULL;
     GSList *aio_ctxs = NULL, *ctx;
 
-    while ((job = block_job_next(job))) {
-        AioContext *aio_context = blk_get_aio_context(job->blk);
-
-        aio_context_acquire(aio_context);
-        block_job_pause(job);
-        aio_context_release(aio_context);
-    }
+    block_job_pause_all();
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
@@ -337,7 +330,6 @@ void bdrv_drain_all_end(void)
 {
     BlockDriverState *bs;
     BdrvNextIterator it;
-    BlockJob *job = NULL;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
@@ -348,13 +340,7 @@ void bdrv_drain_all_end(void)
         aio_context_release(aio_context);
     }
 
-    while ((job = block_job_next(job))) {
-        AioContext *aio_context = blk_get_aio_context(job->blk);
-
-        aio_context_acquire(aio_context);
-        block_job_resume(job);
-        aio_context_release(aio_context);
-    }
+    block_job_resume_all();
 }
 
 void bdrv_drain_all(void)
diff --git a/blockjob.c b/blockjob.c
index 1c63d15..caca718 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -55,36 +55,6 @@ struct BlockJobTxn {
 
 static QLIST_HEAD(, BlockJob) block_jobs = QLIST_HEAD_INITIALIZER(block_jobs);
 
-static char *child_job_get_parent_desc(BdrvChild *c)
-{
-    BlockJob *job = c->opaque;
-    return g_strdup_printf("%s job '%s'",
-                           BlockJobType_lookup[job->driver->job_type],
-                           job->id);
-}
-
-static const BdrvChildRole child_job = {
-    .get_parent_desc    = child_job_get_parent_desc,
-    .stay_at_node       = true,
-};
-
-static void block_job_drained_begin(void *opaque)
-{
-    BlockJob *job = opaque;
-    block_job_pause(job);
-}
-
-static void block_job_drained_end(void *opaque)
-{
-    BlockJob *job = opaque;
-    block_job_resume(job);
-}
-
-static const BlockDevOps block_job_dev_ops = {
-    .drained_begin = block_job_drained_begin,
-    .drained_end = block_job_drained_end,
-};
-
 BlockJob *block_job_next(BlockJob *job)
 {
     if (!job) {
@@ -106,6 +76,21 @@ BlockJob *block_job_get(const char *id)
     return NULL;
 }
 
+static void block_job_pause(BlockJob *job)
+{
+    job->pause_count++;
+}
+
+static void block_job_resume(BlockJob *job)
+{
+    assert(job->pause_count > 0);
+    job->pause_count--;
+    if (job->pause_count) {
+        return;
+    }
+    block_job_enter(job);
+}
+
 static void block_job_ref(BlockJob *job)
 {
     ++job->refcnt;
@@ -171,6 +156,36 @@ static void block_job_detach_aio_context(void *opaque)
     block_job_unref(job);
 }
 
+static char *child_job_get_parent_desc(BdrvChild *c)
+{
+    BlockJob *job = c->opaque;
+    return g_strdup_printf("%s job '%s'",
+                           BlockJobType_lookup[job->driver->job_type],
+                           job->id);
+}
+
+static const BdrvChildRole child_job = {
+    .get_parent_desc    = child_job_get_parent_desc,
+    .stay_at_node       = true,
+};
+
+static void block_job_drained_begin(void *opaque)
+{
+    BlockJob *job = opaque;
+    block_job_pause(job);
+}
+
+static void block_job_drained_end(void *opaque)
+{
+    BlockJob *job = opaque;
+    block_job_resume(job);
+}
+
+static const BlockDevOps block_job_dev_ops = {
+    .drained_begin = block_job_drained_begin,
+    .drained_end = block_job_drained_end,
+};
+
 void block_job_remove_all_bdrv(BlockJob *job)
 {
     GSList *l;
@@ -471,11 +486,6 @@ void block_job_complete(BlockJob *job, Error **errp)
     job->driver->complete(job, errp);
 }
 
-void block_job_pause(BlockJob *job)
-{
-    job->pause_count++;
-}
-
 void block_job_user_pause(BlockJob *job)
 {
     job->user_paused = true;
@@ -520,16 +530,6 @@ void coroutine_fn block_job_pause_point(BlockJob *job)
     }
 }
 
-void block_job_resume(BlockJob *job)
-{
-    assert(job->pause_count > 0);
-    job->pause_count--;
-    if (job->pause_count) {
-        return;
-    }
-    block_job_enter(job);
-}
-
 void block_job_user_resume(BlockJob *job)
 {
     if (job && job->user_paused && job->pause_count > 0) {
@@ -723,6 +723,30 @@ static void block_job_event_completed(BlockJob *job, const char *msg)
                                         &error_abort);
 }
 
+void block_job_pause_all(void)
+{
+    BlockJob *job = NULL;
+    while ((job = block_job_next(job))) {
+        AioContext *aio_context = blk_get_aio_context(job->blk);
+
+        aio_context_acquire(aio_context);
+        block_job_pause(job);
+        aio_context_release(aio_context);
+    }
+}
+
+void block_job_resume_all(void)
+{
+    BlockJob *job = NULL;
+    while ((job = block_job_next(job))) {
+        AioContext *aio_context = blk_get_aio_context(job->blk);
+
+        aio_context_acquire(aio_context);
+        block_job_resume(job);
+        aio_context_release(aio_context);
+    }
+}
+
 void block_job_event_ready(BlockJob *job)
 {
     job->ready = true;
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 9e906f7..aac87cd 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -235,12 +235,11 @@ void block_job_complete(BlockJob *job, Error **errp);
 BlockJobInfo *block_job_query(BlockJob *job, Error **errp);
 
 /**
- * block_job_pause:
- * @job: The job to be paused.
+ * block_job_pause_all:
  *
- * Asynchronously pause the specified job.
+ * Asynchronously pause all jobs.
  */
-void block_job_pause(BlockJob *job);
+void block_job_pause_all(void);
 
 /**
  * block_job_user_pause:
@@ -260,12 +259,11 @@ void block_job_user_pause(BlockJob *job);
 bool block_job_user_paused(BlockJob *job);
 
 /**
- * block_job_resume:
- * @job: The job to be resumed.
+ * block_job_resume_all:
  *
- * Resume the specified job.  Must be paired with a preceding block_job_pause.
+ * Resume all block jobs.  Must be paired with a preceding block_job_pause_all.
  */
-void block_job_resume(BlockJob *job);
+void block_job_resume_all(void);
 
 /**
  * block_job_user_resume:
-- 
2.9.3
