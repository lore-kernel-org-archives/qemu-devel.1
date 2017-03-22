Received: from eggs.gnu.org ([2001:4830:134:3::10]:47007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqk6K-0005sj-LB
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:31:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcody@redhat.com>) id 1cqk6J-0003ao-Mt
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:31:12 -0400
From: Jeff Cody <jcody@redhat.com>
Date: Wed, 22 Mar 2017 13:31:02 -0400
Message-Id: <20170322173102.18180-5-jcody@redhat.com>
In-Reply-To: <20170322173102.18180-1-jcody@redhat.com>
References: <20170322173102.18180-1-jcody@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 4/4] blockjob: add devops to blockjob
 backends
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, jcody@redhat.com, qemu-devel@nongnu.org

From: John Snow <jsnow@redhat.com>

This lets us hook into drained_begin and drained_end requests from the
backend level, which is particularly useful for making sure that all
jobs associated with a particular node (whether the source or the target)
receive a drain request.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Message-id: 20170316212351.13797-4-jsnow@redhat.com
Signed-off-by: Jeff Cody <jcody@redhat.com>
---
 blockjob.c | 29 ++++++++++++++++++++++++-----
 1 file changed, 24 insertions(+), 5 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 0e9ed03..9b619f385 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -68,6 +68,23 @@ static const BdrvChildRole child_job = {
     .stay_at_node       = true,
 };
 
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
 BlockJob *block_job_next(BlockJob *job)
 {
     if (!job) {
@@ -205,11 +222,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     }
 
     job = g_malloc0(driver->instance_size);
-    error_setg(&job->blocker, "block device is in use by block job: %s",
-               BlockJobType_lookup[driver->job_type]);
-    block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abort);
-    bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
-
     job->driver        = driver;
     job->id            = g_strdup(job_id);
     job->blk           = blk;
@@ -219,8 +231,15 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
+
+    error_setg(&job->blocker, "block device is in use by block job: %s",
+               BlockJobType_lookup[driver->job_type]);
+    block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abort);
     bs->job = job;
 
+    blk_set_dev_ops(blk, &block_job_dev_ops, job);
+    bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
+
     QLIST_INSERT_HEAD(&block_jobs, job, job_list);
 
     blk_add_aio_context_notifier(blk, block_job_attached_aio_context,
-- 
2.9.3
