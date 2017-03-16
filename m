Received: from eggs.gnu.org ([2001:4830:134:3::10]:46580)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJYS-0002zT-R5
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:46:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coJYR-0004W2-QK
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 20:46:12 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 Mar 2017 20:46:03 -0400
Message-Id: <20170316004603.20609-4-jsnow@redhat.com>
In-Reply-To: <20170316004603.20609-1-jsnow@redhat.com>
References: <20170316004603.20609-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC patch 3/3] blockjob: add devops to blockjob
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
Cc: kwolf@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>

This lets us hook into drained_begin and drained_end requests from the
backend level, which is particularly useful for making sure that all
jobs associated with a particular node (whether the source or the target)
receive a drain request.

Suggested-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: John Snow <jsnow@redhat.com>

--

RFC topics:

- BlkDevOps is traditionally only for Qdev devices, and a BlockJob is not
  currently a 'device'... Do we want to loosen this restriction, find another
  way to deliver callbacks to BlockJobs attached to BlkBackends, or do something
  crazy like make a BlockJob device object?

  struct JobDevice {
    DeviceState parent_obj;
    BlockJob *job;
  } ...??

- Not so sure about leaving the initial job refcount at 1, since we are giving
  away a handle to this job as dev_opaque. By incrementing it to 2, however,
  it's not clear whose responsibility it is to decrement it again.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockjob.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 6d08ce5..0542677 100644
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
@@ -219,8 +231,20 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     job->paused        = true;
     job->pause_count   = 1;
     job->refcnt        = 1;
+    /* RFC: job is now stored both in bs->job and blk->dev_opaque,
+     * but we cannot expect the backend to know how to put down the ref
+     * so it'd be up to this code here to increment it anyway, making it
+     * a bit of a useless exercise. It would be up to us to ensure that
+     * we destruct the blkbackend before putting down our last reference. */
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
