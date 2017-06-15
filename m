Received: from eggs.gnu.org ([2001:4830:134:3::10]:46980)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dLOct-0003yu-89
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 02:51:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dLOcs-0002xk-6W
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 02:51:31 -0400
From: "sochin.jiang" <sochin.jiang@huawei.com>
Date: Thu, 15 Jun 2017 14:47:33 +0800
Message-ID: <1497509253-28941-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] fix: avoid an infinite loop or a dangling
 pointer problem in img_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jcody@redhat.com, kwolf@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, sochin.jiang@huawei.com, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

From: "sochin.jiang" <sochin.jiang@huawei.com>

img_commit could fall into an infinite loop calling run_block_job() if
its blockjob fails on any I/O error, fix this already known problem.

Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
---
 blockjob.c               |  4 ++--
 include/block/blockjob.h | 18 ++++++++++++++++++
 qemu-img.c               | 20 +++++++++++++-------
 3 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/blockjob.c b/blockjob.c
index a0d7e29..70a7818 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -139,7 +139,7 @@ static void block_job_resume(BlockJob *job)
     block_job_enter(job);
 }
 
-static void block_job_ref(BlockJob *job)
+void block_job_ref(BlockJob *job)
 {
     ++job->refcnt;
 }
@@ -148,7 +148,7 @@ static void block_job_attached_aio_context(AioContext *new_context,
                                            void *opaque);
 static void block_job_detach_aio_context(void *opaque);
 
-static void block_job_unref(BlockJob *job)
+void block_job_unref(BlockJob *job)
 {
     if (--job->refcnt == 0) {
         BlockDriverState *bs = blk_bs(job->blk);
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 09c7c69..67c0968 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -321,6 +321,24 @@ void block_job_iostatus_reset(BlockJob *job);
 BlockJobTxn *block_job_txn_new(void);
 
 /**
+ * block_job_ref:
+ *
+ * Add a reference to BlockJob refcnt, it will be decreased with
+ * block_job_unref, and then be freed if it comes to be the last
+ * reference.
+ */
+void block_job_ref(BlockJob *job);
+
+/**
+ * block_job_unref:
+ *
+ * Release a reference that was previously acquired with block_job_ref
+ * or block_job_create. If it's the last reference to the object, it will be
+ * freed.
+ */
+void block_job_unref(BlockJob *job);
+
+/**
  * block_job_txn_unref:
  *
  * Release a reference that was previously acquired with block_job_txn_add_job
diff --git a/qemu-img.c b/qemu-img.c
index 0ad698d..e70d515 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -887,22 +887,28 @@ static void common_block_job_cb(void *opaque, int ret)
 static void run_block_job(BlockJob *job, Error **errp)
 {
     AioContext *aio_context = blk_get_aio_context(job->blk);
+    int ret = 0;
 
-    /* FIXME In error cases, the job simply goes away and we access a dangling
-     * pointer below. */
     aio_context_acquire(aio_context);
+    block_job_ref(job);
     do {
         aio_poll(aio_context, true);
         qemu_progress_print(job->len ?
                             ((float)job->offset / job->len * 100.f) : 0.0f, 0);
-    } while (!job->ready);
+    } while (!job->ready && !job->completed);
 
-    block_job_complete_sync(job, errp);
+    if (!job->completed) {
+        ret = block_job_complete_sync(job, errp);
+    } else {
+        ret = job->ret;
+    }
+    block_job_unref(job);
     aio_context_release(aio_context);
 
-    /* A block job may finish instantaneously without publishing any progress,
-     * so just signal completion here */
-    qemu_progress_print(100.f, 0);
+    /* publish completion progress only when success */
+    if (!ret) {
+        qemu_progress_print(100.f, 0);
+    }
 }
 
 static int img_commit(int argc, char **argv)
-- 
1.8.3.1
