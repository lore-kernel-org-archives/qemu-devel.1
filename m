Received: from eggs.gnu.org ([2001:4830:134:3::10]:46853)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQCC-0005Q8-S5
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:49:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhang.zhanghailiang@huawei.com>) id 1cUQCB-0006hE-Km
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:49:00 -0500
From: zhanghailiang <zhang.zhanghailiang@huawei.com>
Date: Fri, 20 Jan 2017 11:47:59 +0800
Message-ID: <1484884080-28836-6-git-send-email-zhang.zhanghailiang@huawei.com>
In-Reply-To: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 5/6] replication: Implement block
 replication for shared disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, stefanha@redhat.com
Cc: qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, zhanghailiang <zhang.zhanghailiang@huawei.com>, Wen
	Congyang <wency@cn.fujitsu.com>

Just as the scenario of non-shared disk block replication,
we are going to implement block replication from many basic
blocks that are already in QEMU.
The architecture is:

         virtio-blk                     ||                               .----------
             /                          ||                               | Secondary
            /                           ||                               '----------
           /                            ||                                 virtio-blk
          /                             ||                                      |
          |                             ||                               replication(5)
          |                    NBD  -------->   NBD   (2)                       |
          |                  client     ||    server ---> hidden disk <-- active disk(4)
          |                     ^       ||                      |
          |              replication(1) ||                      |
          |                     |       ||                      |
          |   +-----------------'       ||                      |
         (3)  |drive-backup sync=none   ||                      |
--------. |   +-----------------+       ||                      |
Primary | |                     |       ||           backing    |
--------' |                     |       ||                      |
          V                     |                               |
       +-------------------------------------------+            |
       |               shared disk                 | <----------+
       +-------------------------------------------+

    1) Primary writes will read original data and forward it to Secondary
       QEMU.
    2) The hidden-disk is created automatically. It buffers the original content
       that is modified by the primary VM. It should also be an empty disk, and
       the driver supports bdrv_make_empty() and backing file.
    3) Primary write requests will be written to Shared disk.
    4) Secondary write requests will be buffered in the active disk and it
       will overwrite the existing sector content in the buffer.

Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 block/replication.c | 48 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 42 insertions(+), 6 deletions(-)

diff --git a/block/replication.c b/block/replication.c
index 70ec08c..a0b3e41 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -233,7 +233,7 @@ static coroutine_fn int replication_co_readv(BlockDriverState *bs,
                                              QEMUIOVector *qiov)
 {
     BDRVReplicationState *s = bs->opaque;
-    BdrvChild *child = s->secondary_disk;
+    BdrvChild *child = s->is_shared_disk ? s->primary_disk : s->secondary_disk;
     BlockJob *job = NULL;
     CowRequest req;
     int ret;
@@ -415,7 +415,12 @@ static void backup_job_completed(void *opaque, int ret)
         s->error = -EIO;
     }
 
-    backup_job_cleanup(bs);
+    if (s->mode == REPLICATION_MODE_PRIMARY) {
+        s->replication_state = BLOCK_REPLICATION_DONE;
+        s->error = 0;
+    } else {
+        backup_job_cleanup(bs);
+    }
 }
 
 static bool check_top_bs(BlockDriverState *top_bs, BlockDriverState *bs)
@@ -467,6 +472,19 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
 
     switch (s->mode) {
     case REPLICATION_MODE_PRIMARY:
+        if (s->is_shared_disk) {
+            job = backup_job_create(NULL, s->primary_disk->bs, bs, 0,
+                MIRROR_SYNC_MODE_NONE, NULL, false, BLOCKDEV_ON_ERROR_REPORT,
+                BLOCKDEV_ON_ERROR_REPORT, BLOCK_JOB_INTERNAL,
+                backup_job_completed, bs, NULL, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                backup_job_cleanup(bs);
+                aio_context_release(aio_context);
+                return;
+            }
+            block_job_start(job);
+        }
         break;
     case REPLICATION_MODE_SECONDARY:
         s->active_disk = bs->file;
@@ -485,7 +503,8 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         }
 
         s->secondary_disk = s->hidden_disk->bs->backing;
-        if (!s->secondary_disk->bs || !bdrv_has_blk(s->secondary_disk->bs)) {
+        if (!s->secondary_disk->bs ||
+            (!s->is_shared_disk && !bdrv_has_blk(s->secondary_disk->bs))) {
             error_setg(errp, "The secondary disk doesn't have block backend");
             aio_context_release(aio_context);
             return;
@@ -580,11 +599,24 @@ static void replication_do_checkpoint(ReplicationState *rs, Error **errp)
 
     switch (s->mode) {
     case REPLICATION_MODE_PRIMARY:
+        if (s->is_shared_disk) {
+            if (!s->primary_disk->bs->job) {
+                error_setg(errp, "Primary backup job was cancelled"
+                           " unexpectedly");
+                break;
+            }
+
+            backup_do_checkpoint(s->primary_disk->bs->job, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+            }
+        }
         break;
     case REPLICATION_MODE_SECONDARY:
         if (!s->is_shared_disk) {
             if (!s->secondary_disk->bs->job) {
-                error_setg(errp, "Backup job was cancelled unexpectedly");
+                error_setg(errp, "Secondary backup job was cancelled"
+                           " unexpectedly");
                 break;
             }
             backup_do_checkpoint(s->secondary_disk->bs->job, &local_err);
@@ -663,8 +695,12 @@ static void replication_stop(ReplicationState *rs, bool failover, Error **errp)
 
     switch (s->mode) {
     case REPLICATION_MODE_PRIMARY:
-        s->replication_state = BLOCK_REPLICATION_DONE;
-        s->error = 0;
+        if (s->is_shared_disk && s->primary_disk->bs->job) {
+            block_job_cancel(s->primary_disk->bs->job);
+        } else {
+            s->replication_state = BLOCK_REPLICATION_DONE;
+            s->error = 0;
+        }
         break;
     case REPLICATION_MODE_SECONDARY:
         /*
-- 
1.8.3.1
