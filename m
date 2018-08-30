Received: from eggs.gnu.org ([2001:4830:134:3::10]:51631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvUIc-0004tt-8Z
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 17:16:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fvUIa-0003Kj-2K
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 17:16:18 -0400
From: John Snow <jsnow@redhat.com>
Date: Thu, 30 Aug 2018 17:16:04 -0400
Message-Id: <20180830211605.13683-2-jsnow@redhat.com>
In-Reply-To: <20180830211605.13683-1-jsnow@redhat.com>
References: <20180830211605.13683-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] blockdev-backup: add bitmap argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

It is only an oversight that we don't allow incremental backup with
blockdev-backup. Add the bitmap argument which enables this.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c           | 16 +++++++++++++++-
 qapi/block-core.json |  7 ++++++-
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 72f5347df5..b9f19afacc 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3491,6 +3491,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
     BlockDriverState *bs;
     BlockDriverState *target_bs;
     Error *local_err = NULL;
+    BdrvDirtyBitmap *bmap = NULL;
     AioContext *aio_context;
     BlockJob *job = NULL;
     int job_flags = JOB_DEFAULT;
@@ -3541,6 +3542,19 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
             goto out;
         }
     }
+    if (backup->has_bitmap) {
+        bmap = bdrv_find_dirty_bitmap(bs, backup->bitmap);
+        if (!bmap) {
+            error_setg(errp, "Bitmap '%s' could not be found", backup->bitmap);
+            goto out;
+        }
+        if (bdrv_dirty_bitmap_qmp_locked(bmap)) {
+            error_setg(errp,
+                       "Bitmap '%s' is currently locked and cannot be used for "
+                       "backup", backup->bitmap);
+            goto out;
+        }
+    }
     if (!backup->auto_finalize) {
         job_flags |= JOB_MANUAL_FINALIZE;
     }
@@ -3548,7 +3562,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
         job_flags |= JOB_MANUAL_DISMISS;
     }
     job = backup_job_create(backup->job_id, bs, target_bs, backup->speed,
-                            backup->sync, NULL, backup->compress,
+                            backup->sync, bmap, backup->compress,
                             backup->on_source_error, backup->on_target_error,
                             job_flags, NULL, NULL, txn, &local_err);
     if (local_err != NULL) {
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4c7a37afdc..d3ea281039 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1315,6 +1315,10 @@
 # @speed: the maximum speed, in bytes per second. The default is 0,
 #         for unlimited.
 #
+# @bitmap: the name of dirty bitmap if sync is "incremental".
+#          Must be present if sync is "incremental", must NOT be present
+#          otherwise. (Since 3.1)
+#
 # @compress: true to compress data, if the target format supports it.
 #            (default: false) (since 2.8)
 #
@@ -1346,7 +1350,8 @@
 ##
 { 'struct': 'BlockdevBackup',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
-            'sync': 'MirrorSyncMode', '*speed': 'int', '*compress': 'bool',
+            'sync': 'MirrorSyncMode', '*speed': 'int',
+            '*bitmap': 'str', '*compress': 'bool',
             '*on-source-error': 'BlockdevOnError',
             '*on-target-error': 'BlockdevOnError',
             '*auto-finalize': 'bool', '*auto-dismiss': 'bool' } }
-- 
2.14.4
