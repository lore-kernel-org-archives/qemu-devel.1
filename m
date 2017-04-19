Received: from eggs.gnu.org ([2001:4830:134:3::10]:34181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoP-0004Xp-Ka
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1d0qoN-0001Ss-Bp
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52276)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1d0qoN-0001Sc-37
	for qemu-devel@nongnu.org; Wed, 19 Apr 2017 10:42:27 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 090EE804EB
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 14:42:26 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-118-57.ams2.redhat.com
	[10.36.118.57] (may be forged))
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id v3JEgK5D001048
	for <qemu-devel@nongnu.org>; Wed, 19 Apr 2017 10:42:25 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Apr 2017 16:42:12 +0200
Message-Id: <20170419144219.20371-5-pbonzini@redhat.com>
In-Reply-To: <20170419144219.20371-1-pbonzini@redhat.com>
References: <20170419144219.20371-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 04/11] blockjob: introduce
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

Remove use of block_job_pause/resume from outside blockjob.c, thus
making them static.  The new functions are used by the block layer,
so place them in blockjob_int.h.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
        v1->v2: place the functions in blockjob_int.h [John]

 block/io.c                   |  18 +------
 blockjob.c                   | 114 ++++++++++++++++++++++++++-----------------
 include/block/blockjob.h     |  16 ------
 include/block/blockjob_int.h |  14 ++++++
 4 files changed, 85 insertions(+), 77 deletions(-)

diff --git a/block/io.c b/block/io.c
index a7142e0..f462835 100644
--- a/block/io.c
+++ b/block/io.c
@@ -26,6 +26,7 @@
 #include "trace.h"
 #include "sysemu/block-backend.h"
 #include "block/blockjob.h"
+#include "block/blockjob_int.h"
 #include "block/block_int.h"
 #include "qemu/cutils.h"
 #include "qapi/error.h"
@@ -301,16 +301,9 @@ void bdrv_drain_all_begin(void)
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
@@ -354,7 +347,6 @@ void bdrv_drain_all_end(void)
 {
     BlockDriverState *bs;
     BdrvNextIterator it;
-    BlockJob *job = NULL;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *aio_context = bdrv_get_aio_context(bs);
@@ -365,13 +357,7 @@ void bdrv_drain_all_end(void)
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
index 5a722c3..85ad610 100644
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
index 9e906f7..09c7c69 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -235,14 +235,6 @@ void block_job_complete(BlockJob *job, Error **errp);
 BlockJobInfo *block_job_query(BlockJob *job, Error **errp);
 
 /**
- * block_job_pause:
- * @job: The job to be paused.
- *
- * Asynchronously pause the specified job.
- */
-void block_job_pause(BlockJob *job);
-
-/**
  * block_job_user_pause:
  * @job: The job to be paused.
  *
@@ -260,14 +252,6 @@ void block_job_user_pause(BlockJob *job);
 bool block_job_user_paused(BlockJob *job);
 
 /**
- * block_job_resume:
- * @job: The job to be resumed.
- *
- * Resume the specified job.  Must be paired with a preceding block_job_pause.
- */
-void block_job_resume(BlockJob *job);
-
-/**
  * block_job_user_resume:
  * @job: The job to be resumed.
  *
diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.h
index e129190..cbf984b 100644
--- a/include/block/blockjob_int.h
+++ b/include/block/blockjob_int.h
@@ -156,6 +156,20 @@ void block_job_sleep_ns(BlockJob *job, QEMUClockType type, int64_t ns);
 void block_job_yield(BlockJob *job);
 
 /**
+ * block_job_pause_all:
+ *
+ * Asynchronously pause all jobs.
+ */
+void block_job_pause_all(void);
+
+/**
+ * block_job_resume_all:
+ *
+ * Resume all block jobs.  Must be paired with a preceding block_job_pause_all.
+ */
+void block_job_resume_all(void);
+
+/**
  * block_job_early_fail:
  * @bs: The block device.
  *
-- 
2.9.3
