Received: from eggs.gnu.org ([2001:4830:134:3::10]:57473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6q-0005xm-Jh
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP6p-0002cV-MP
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:19:40 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:33 +0100
Message-Id: <20171222151846.28110-23-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 22/35] blockjob: Pause job on draining any
 job BDS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Block jobs already paused themselves when their main BlockBackend
entered a drained section. This is not good enough: We also want to
pause a block job and may not submit new requests if, for example, the
mirror target node should be drained.

This implements .drained_begin/end callbacks in child_job in order to
consider all block nodes related to the job, and removes the
BlockBackend callbacks which are unnecessary now because the root of the
job main BlockBackend is always referenced with a child_job, too.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockjob.c | 22 +++++++++-------------
 1 file changed, 9 insertions(+), 13 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 6173e4728c..f5cea84e73 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -234,26 +234,23 @@ static char *child_job_get_parent_desc(BdrvChild *c)
                            job->id);
 }
 
-static const BdrvChildRole child_job = {
-    .get_parent_desc    = child_job_get_parent_desc,
-    .stay_at_node       = true,
-};
-
-static void block_job_drained_begin(void *opaque)
+static void child_job_drained_begin(BdrvChild *c)
 {
-    BlockJob *job = opaque;
+    BlockJob *job = c->opaque;
     block_job_pause(job);
 }
 
-static void block_job_drained_end(void *opaque)
+static void child_job_drained_end(BdrvChild *c)
 {
-    BlockJob *job = opaque;
+    BlockJob *job = c->opaque;
     block_job_resume(job);
 }
 
-static const BlockDevOps block_job_dev_ops = {
-    .drained_begin = block_job_drained_begin,
-    .drained_end = block_job_drained_end,
+static const BdrvChildRole child_job = {
+    .get_parent_desc    = child_job_get_parent_desc,
+    .drained_begin      = child_job_drained_begin,
+    .drained_end        = child_job_drained_end,
+    .stay_at_node       = true,
 };
 
 void block_job_remove_all_bdrv(BlockJob *job)
@@ -715,7 +712,6 @@ void *block_job_create(const char *job_id, const BlockJobDriver *driver,
     block_job_add_bdrv(job, "main node", bs, 0, BLK_PERM_ALL, &error_abort);
     bs->job = job;
 
-    blk_set_dev_ops(blk, &block_job_dev_ops, job);
     bdrv_op_unblock(bs, BLOCK_OP_TYPE_DATAPLANE, job->blocker);
 
     QLIST_INSERT_HEAD(&block_jobs, job, job_list);
-- 
2.13.6
