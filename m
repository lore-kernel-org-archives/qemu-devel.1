Received: from eggs.gnu.org ([209.51.188.92]:50925)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgfk-0001KO-8S
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:04:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgfi-0006rU-Sh
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:04:36 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:14346
	helo=bsf01.didichuxing.com) by eggs.gnu.org with smtp (Exim 4.71)
	(envelope-from <liliangleo@didiglobal.com>) id 1hKgfh-0006px-Oh
	for qemu-devel@nongnu.org; Sun, 28 Apr 2019 06:04:34 -0400
Date: Sun, 28 Apr 2019 18:04:02 +0800
From: Liang Li <liliangleo@didiglobal.com>
Message-ID: <20190428100358.GA63626@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] [PATCH 2/2] qapi: add interface for setting backup cow
 buffer size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Wen Congyang <wencongyang2@huawei.com>, Xie Changlong <xiechanglong.d@gmail.com>, Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>

Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Wen Congyang <wencongyang2@huawei.com>
Cc: Xie Changlong <xiechanglong.d@gmail.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Eric Blake <eblake@redhat.com>
Cc: Fam Zheng <fam@euphon.net>
Signed-off-by: Liang Li <liliangleo@didiglobal.com>
---
 block/backup.c            | 3 ++-
 block/replication.c       | 2 +-
 blockdev.c                | 5 +++++
 include/block/block_int.h | 2 ++
 qapi/block-core.json      | 5 +++++
 5 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/block/backup.c b/block/backup.c
index d436f9e4ee..9a04003968 100644
--- a/block/backup.c
+++ b/block/backup.c
@@ -652,6 +652,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                   BlockDriverState *target, int64_t speed,
                   MirrorSyncMode sync_mode, BdrvDirtyBitmap *sync_bitmap,
                   bool compress,
+                  int buf_size,
                   BlockdevOnError on_source_error,
                   BlockdevOnError on_target_error,
                   int creation_flags,
@@ -748,7 +749,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
     job->sync_bitmap = sync_mode == MIRROR_SYNC_MODE_INCREMENTAL ?
                        sync_bitmap : NULL;
     job->compress = compress;
-    job->cow_buf_size = 0;
+    job->cow_buf_size = buf_size;
 
     /* Detect image-fleecing (and similar) schemes */
     job->serialize_target_writes = bdrv_chain_contains(target, bs);
diff --git a/block/replication.c b/block/replication.c
index 3d4dedddfc..5ec6911355 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -540,7 +540,7 @@ static void replication_start(ReplicationState *rs, ReplicationMode mode,
         bdrv_op_unblock(top_bs, BLOCK_OP_TYPE_DATAPLANE, s->blocker);
 
         job = backup_job_create(NULL, s->secondary_disk->bs, s->hidden_disk->bs,
-                                0, MIRROR_SYNC_MODE_NONE, NULL, false,
+                                0, MIRROR_SYNC_MODE_NONE, NULL, false, 0,
                                 BLOCKDEV_ON_ERROR_REPORT,
                                 BLOCKDEV_ON_ERROR_REPORT, JOB_INTERNAL,
                                 backup_job_completed, bs, NULL, &local_err);
diff --git a/blockdev.c b/blockdev.c
index 79fbac8450..15d96fe25c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3449,6 +3449,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
     if (!backup->has_compress) {
         backup->compress = false;
     }
+    if (!backup->has_buffer) {
+        backup->buffer = 0;
+    }
 
     bs = qmp_get_root_bs(backup->device, errp);
     if (!bs) {
@@ -3550,6 +3553,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
 
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, bmap, backup->compress,
+                            backup->buffer,
                             backup->on_source_error, backup->on_target_error,
                             job_flags, NULL, NULL, txn, &local_err);
     bdrv_unref(target_bs);
@@ -3660,6 +3664,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
     }
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
                             backup->sync, bmap, backup->compress,
+                            backup->buffer,
                             backup->on_source_error, backup->on_target_error,
                             job_flags, NULL, NULL, txn, &local_err);
     if (local_err != NULL) {
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 01e855a066..17c7f26b84 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -1137,6 +1137,7 @@ void mirror_start(const char *job_id, BlockDriverState *bs,
  * @speed: The maximum speed, in bytes per second, or 0 for unlimited.
  * @sync_mode: What parts of the disk image should be copied to the destination.
  * @sync_bitmap: The dirty bitmap if sync_mode is MIRROR_SYNC_MODE_INCREMENTAL.
+ * @buffer: Size of buffer used to save data for delayed writing.
  * @on_source_error: The action to take upon error reading from the source.
  * @on_target_error: The action to take upon error writing to the target.
  * @creation_flags: Flags that control the behavior of the Job lifetime.
@@ -1153,6 +1154,7 @@ BlockJob *backup_job_create(const char *job_id, BlockDriverState *bs,
                             MirrorSyncMode sync_mode,
                             BdrvDirtyBitmap *sync_bitmap,
                             bool compress,
+                            int buffer,
                             BlockdevOnError on_source_error,
                             BlockdevOnError on_target_error,
                             int creation_flags,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..726c04c02a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1377,6 +1377,7 @@
             '*format': 'str', 'sync': 'MirrorSyncMode',
             '*mode': 'NewImageMode', '*speed': 'int',
             '*bitmap': 'str', '*compress': 'bool',
+            '*buffer': 'int',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
@@ -1405,6 +1406,9 @@
 # @compress: true to compress data, if the target format supports it.
 #            (default: false) (since 2.8)
 #
+# @buffer: the maximum size of buffer used to save data for delayed writing.
+#            (default: 0) (since 4.1)
+#
 # @on-source-error: the action to take on an error on the source,
 #                   default 'report'.  'stop' and 'enospc' can only be used
 #                   if the block device supports io-status (see BlockInfo).
@@ -1436,6 +1440,7 @@
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
             'sync': 'MirrorSyncMode', '*speed': 'int',
             '*bitmap': 'str', '*compress': 'bool',
+            '*buffer': 'int',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
-- 
2.14.1
