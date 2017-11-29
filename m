Received: from eggs.gnu.org ([2001:4830:134:3::10]:41449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3iC-0005WG-1S
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:51:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3iB-00063D-8o
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:51:44 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 22:49:50 +0800
Message-Id: <20171129144956.11409-4-famz@redhat.com>
In-Reply-To: <20171129144956.11409-1-famz@redhat.com>
References: <20171129144956.11409-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 3/9] blockjob: Implement AioContext drain
 ops
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
 blockjob.c | 47 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 30 insertions(+), 17 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index ff9a614531..86d060c89c 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -148,6 +148,23 @@ static void block_job_attached_aio_context(AioContext *new_context,
                                            void *opaque);
 static void block_job_detach_aio_context(void *opaque);
 
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
 void block_job_unref(BlockJob *job)
 {
     if (--job->refcnt == 0) {
@@ -157,6 +174,10 @@ void block_job_unref(BlockJob *job)
         blk_remove_aio_context_notifier(job->blk,
                                         block_job_attached_aio_context,
                                         block_job_detach_aio_context, job);
+        aio_context_del_drain_ops(blk_get_aio_context(job->blk),
+                                  block_job_drained_begin,
+                                  block_job_drained_end,
+                                  job);
         blk_unref(job->blk);
         error_free(job->blocker);
         g_free(job->id);
@@ -170,6 +191,9 @@ static void block_job_attached_aio_context(AioContext *new_context,
 {
     BlockJob *job = opaque;
 
+    aio_context_add_drain_ops(blk_get_aio_context(job->blk),
+                              block_job_drained_begin, block_job_drained_end,
+                              job);
     if (job->driver->attached_aio_context) {
         job->driver->attached_aio_context(job, new_context);
     }
@@ -192,6 +216,9 @@ static void block_job_detach_aio_context(void *opaque)
 {
     BlockJob *job = opaque;
 
+    aio_context_del_drain_ops(blk_get_aio_context(job->blk),
+                              block_job_drained_begin, block_job_drained_end,
+                              job);
     /* In case the job terminates during aio_poll()... */
     block_job_ref(job);
 
@@ -217,23 +244,6 @@ static const BdrvChildRole child_job = {
     .stay_at_node       = true,
 };
 
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
 void block_job_remove_all_bdrv(BlockJob *job)
 {
     GSList *l;
@@ -671,6 +681,9 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     bs->job = job;
 
     blk_set_dev_ops(blk, &block_job_dev_ops, job);
+    aio_context_add_drain_ops(blk_get_aio_context(blk),
+                              block_job_drained_begin, block_job_drained_end,
+                              job);
     bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
 
     QLIST_INSERT_HEAD(&block_jobs, job, job_list);
-- 
2.14.3
