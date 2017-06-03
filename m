Received: from eggs.gnu.org ([2001:4830:134:3::10]:38273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dH1yy-00033M-SE
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 01:52:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sochin.jiang@huawei.com>) id 1dH1yx-0003mH-Oy
	for qemu-devel@nongnu.org; Sat, 03 Jun 2017 01:52:16 -0400
From: "sochin.jiang" <sochin.jiang@huawei.com>
Date: Sat, 3 Jun 2017 13:48:37 +0800
Message-ID: <1496468917-7489-1-git-send-email-sochin.jiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH] blockjob: cancel blockjobs before stopping all
 iothreads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kwolf@redhat.com, jcody@redhat.com, pbonzini@redhat.com, mreitz@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, sochin.jiang@huawei.com, eric.fangyi@huawei.com, subo7@huawei.com, xieyingtai@huawei.com, lina.lulina@huawei.com, zhangshuai13@huawei.com, lizhengui@huawei.com

From: "sochin.jiang" <sochin.jiang@huawei.com>

commit 88b062c and commit c9d1a56 introduce BDRV_POLL_WHILE,
checking bs->in_flight in the main thread and exit till
bs->in_flight reaches 0. This leaves a chance that
BDRV_POLL_WHILE will hang until iothread complete the
relative block job when bdrv_drain is called from outside
the I/O thread, say call 'iothread_stop_all' when shutting
down the vm. Cancelling blockjobs seems more reasonable before
iothread_stop_all is called when vm shutdown.

Signed-off-by: sochin.jiang <sochin.jiang@huawei.com>
---
 block.c                  | 9 ++++++++-
 blockjob.c               | 5 +++++
 include/block/block.h    | 1 +
 include/block/blockjob.h | 7 +++++++
 vl.c                     | 1 +
 5 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index fa1d06d..b564c29 100644
--- a/block.c
+++ b/block.c
@@ -3084,9 +3084,16 @@ static void bdrv_close(BlockDriverState *bs)
     bdrv_drained_end(bs);
 }
 
+void bdrv_cancel_all(void)
+{
+    if (!block_jobs_is_empty()) {
+        block_job_cancel_sync_all();
+    }
+}
+
 void bdrv_close_all(void)
 {
-    block_job_cancel_sync_all();
+    bdrv_cancel_all();
     nbd_export_close_all();
 
     /* Drop references from requests still in flight, such as canceled block
diff --git a/blockjob.c b/blockjob.c
index a0d7e29..c659994 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -539,6 +539,11 @@ void block_job_cancel_sync_all(void)
     }
 }
 
+bool block_jobs_is_empty(void)
+{
+    return QLIST_EMPTY(&block_jobs);
+}
+
 int block_job_complete_sync(BlockJob *job, Error **errp)
 {
     return block_job_finish_sync(job, &block_job_complete, errp);
diff --git a/include/block/block.h b/include/block/block.h
index 9b355e9..0ebbd50 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -376,6 +376,7 @@ int bdrv_inactivate_all(void);
 int bdrv_flush(BlockDriverState *bs);
 int coroutine_fn bdrv_co_flush(BlockDriverState *bs);
 int bdrv_flush_all(void);
+void bdrv_cancel_all(void);
 void bdrv_close_all(void);
 void bdrv_drain(BlockDriverState *bs);
 void coroutine_fn bdrv_co_drain(BlockDriverState *bs);
diff --git a/include/block/blockjob.h b/include/block/blockjob.h
index 09c7c69..d9ee58d 100644
--- a/include/block/blockjob.h
+++ b/include/block/blockjob.h
@@ -282,6 +282,13 @@ int block_job_cancel_sync(BlockJob *job);
 void block_job_cancel_sync_all(void);
 
 /**
+ * block_jobs_is_empty:
+ *
+ * Check whether block_jobs is empty.
+ */
+bool block_jobs_is_empty(void);
+
+/**
  * block_job_complete_sync:
  * @job: The job to be completed.
  * @errp: Error object which may be set by block_job_complete(); this is not
diff --git a/vl.c b/vl.c
index 80b86c0..cff6ec7 100644
--- a/vl.c
+++ b/vl.c
@@ -4751,6 +4751,7 @@ int main(int argc, char **argv, char **envp)
 
     main_loop();
     replay_disable_events();
+    bdrv_cancel_all();
     iothread_stop_all();
 
     bdrv_close_all();
-- 
1.8.3.1
