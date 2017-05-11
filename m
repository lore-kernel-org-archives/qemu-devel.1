Received: from eggs.gnu.org ([2001:4830:134:3::10]:36462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pA8-0001p7-Qc
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pA7-00073e-US
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:33:52 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:21 +0200
Message-Id: <1494513181-7900-19-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 18/58] block: Reuse bs as backing hd for
 drive-backup sync=none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

Opening the backing image for the second time is bad, especially here
when it is also in use as the active image as the source. The
drive-backup job itself doesn't read from target->backing for COW,
instead it gets data from the write notifier, so it's not a big problem.
However, exporting the target to NBD etc. won't work, because of the
likely stale metadata cache.

Use BDRV_O_NO_BACKING in this case and manually set up the backing
BdrvChild.

Cc: qemu-stable@nongnu.org
Signed-off-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 0b38c3d..0d3773b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3151,6 +3151,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     Error *local_err = NULL;
     int flags;
     int64_t size;
+    bool set_backing_hd = false;
 
     if (!backup->has_speed) {
         backup->speed = 0;
@@ -3201,6 +3202,8 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     }
     if (backup->sync == MIRROR_SYNC_MODE_NONE) {
         source = bs;
+        flags |= BDRV_O_NO_BACKING;
+        set_backing_hd = true;
     }
 
     size = bdrv_getlength(bs);
@@ -3227,7 +3230,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     }
 
     if (backup->format) {
-        options = qdict_new();
+        if (!options) {
+            options = qdict_new();
+        }
         qdict_put_str(options, "driver", backup->format);
     }
 
@@ -3238,6 +3243,14 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
 
     bdrv_set_aio_context(target_bs, aio_context);
 
+    if (set_backing_hd) {
+        bdrv_set_backing_hd(target_bs, source, &local_err);
+        if (local_err) {
+            bdrv_unref(target_bs);
+            goto out;
+        }
+    }
+
     if (backup->has_bitmap) {
         bmap = bdrv_find_dirty_bitmap(bs, backup->bitmap);
         if (!bmap) {
-- 
1.8.3.1
