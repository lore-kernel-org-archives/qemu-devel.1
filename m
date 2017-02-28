Received: from eggs.gnu.org ([2001:4830:134:3::10]:45473)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioX0-0006Qs-I0
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioWz-00081I-JN
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:58 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:32 +0100
Message-Id: <1488314205-16264-34-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 33/46] blockjob: Factor out
 block_job_remove_all_bdrv()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

In some cases, we want to remove op blockers on intermediate nodes
before the whole block job transaction has completed (because they block
restoring the final graph state during completion). Provide a function
for this.

The whole block job lifecycle is a bit messed up and it's hard to
actually do all things in the right order, but I'll leave simplifying
this for another day.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 blockjob.c               | 20 +++++++++++++-------
 include/block/blockjob.h |  9 +++++++++
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index 4216cde..69126af 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -128,6 +128,18 @@ static void block_job_detach_aio_context(void *opaque)
     block_job_unref(job);
 }
 
+void block_job_remove_all_bdrv(BlockJob *job)
+{
+    GSList *l;
+    for (l = job->nodes; l; l = l->next) {
+        BdrvChild *c = l->data;
+        bdrv_op_unblock_all(c->bs, job->blocker);
+        bdrv_root_unref_child(c);
+    }
+    g_slist_free(job->nodes);
+    job->nodes = NULL;
+}
+
 int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
                        uint64_t perm, uint64_t shared_perm, Error **errp)
 {
@@ -258,15 +270,9 @@ void block_job_ref(BlockJob *job)
 void block_job_unref(BlockJob *job)
 {
     if (--job->refcnt == 0) {
-        GSList *l;
         BlockDriverState *bs = blk_bs(job->blk);
         bs->job = NULL;
-        for (l = job->nodes; l; l = l->next) {
-            BdrvChild *c = l->data;
-            bdrv_op_unblock_all(c->bs, job->blocker);
-            bdrv_root_unref_child(c);
-        }
-        g_slist_free(job->nodes);
+        block_job_remove_all_bdrv(job);
         blk_remove_aio_context_notifier(job->blk,
                                         block_job_attached_aio_context,
                                         block_job_detach_aio_context, job);
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 9d65ef8..9e906f7 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -181,6 +181,15 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
                        uint64_t perm, uint64_t shared_perm, Error **errp);
 
 /**
+ * block_job_remove_all_bdrv:
+ * @job: The block job
+ *
+ * Remove all BlockDriverStates from the list of nodes that are involved in the
+ * job. This removes the blockers added with block_job_add_bdrv().
+ */
+void block_job_remove_all_bdrv(BlockJob *job);
+
+/**
  * block_job_set_speed:
  * @job: The job to set the speed for.
  * @speed: The new value
-- 
1.8.3.1
