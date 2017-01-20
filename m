Received: from eggs.gnu.org ([2001:4830:134:3::10]:47299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQFN-00081s-1l
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:52:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQFM-0000me-35
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:52:17 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Fri, 20 Jan 2017 11:47:58 +0800
Message-ID: <1484884080-28836-5-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 4/6] replication: fix code logic with the
 new shared_disk option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>

Some code logic only be needed in non-shared disk, here
we adjust these codes to prepare for shared disk scenario.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
---
 block/replication.c | 47 ++++++++++++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 3a44728..70ec08c 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -531,21 +531,28 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
             aio_context_release(aio_context);
             return;
         }
-        bdrv_op_block_all(top_bs, s->blocker);
-        bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
 
-        job = backup_job_create(NULL, s->secondary_disk->bs, s->hidden_disk->bs,
-                                0, MIRROR_SYNC_MODE_NONE, NULL, false,
+        /*
+         * Only in the case of non-shared disk,
+         * the backup job is in the secondary side
+         */
+        if (!s->is_shared_disk) {
+            bdrv_op_block_all(top_bs, s->blocker);
+            bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
+            job = backup_job_create(NULL, s->secondary_disk->bs,
+                                s->hidden_disk->bs, 0,
+                                MIRROR_SYNC_MODE_NONE, NULL, false,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, BLOCK_JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            backup_job_cleanup(bs);
-            aio_context_release(aio_context);
-            return;
+            if (local_err) {
+                error_propagate(errp, local_err);
+                backup_job_cleanup(bs);
+                aio_context_release(aio_context);
+                return;
+            }
+            block_job_start(job);
         }
-        block_job_start(job);
 
         secondary_do_checkpoint(s, errp);
         break;
@@ -575,14 +582,16 @@ static void replication_do_checkpoint(ReplicationState *rs, Error **errp)
     case REPLICATION_MODE_PRIMARY:
         break;
     case REPLICATION_MODE_SECONDARY:
-        if (!s->secondary_disk->bs->job) {
-            error_setg(errp, "Backup job was cancelled unexpectedly");
-            break;
-        }
-        backup_do_checkpoint(s->secondary_disk->bs->job, &local_err);
-        if (local_err) {
-            error_propagate(errp, local_err);
-            break;
+        if (!s->is_shared_disk) {
+            if (!s->secondary_disk->bs->job) {
+                error_setg(errp, "Backup job was cancelled unexpectedly");
+                break;
+            }
+            backup_do_checkpoint(s->secondary_disk->bs->job, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                break;
+            }
         }
         secondary_do_checkpoint(s, errp);
         break;
@@ -663,7 +672,7 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
          * before the BDS is closed, because we will access hidden
          * disk, secondary disk in backup_job_completed().
          */
-        if (s->secondary_disk->bs->job) {
+        if (!s->is_shared_disk && s->secondary_disk->bs->job) {
             block_job_cancel_sync(s->secondary_disk->bs->job);
         }
 
-- 
1.8.3.1
