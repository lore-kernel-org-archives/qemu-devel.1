Received: from eggs.gnu.org ([2001:4830:134:3::10]:60864)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5anx-0004et-VZ
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d5anx-0000uW-3z
	for qemu-devel@nongnu.org; Tue, 02 May 2017 12:37:37 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  3 May 2017 00:35:53 +0800
Message-Id: <20170502163558.7611-19-famz@redhat.com>
In-Reply-To: <20170502163558.7611-1-famz@redhat.com>
References: <20170502163558.7611-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v17 18/23] block: Reuse bs as backing hd for
 drive-backup sync=none
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, famz@redhat.com, Max Reitz <mreitz@redhat.com>, eblake@redhat.com

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
---
 blockdev.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 4d8cded..654a880 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3155,6 +3155,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     Error *local_err = NULL;
     int flags;
     int64_t size;
+    bool set_backing_hd = false;
 
     if (!backup->has_speed) {
         backup->speed = 0;
@@ -3205,6 +3206,8 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     }
     if (backup->sync == MIRROR_SYNC_MODE_NONE) {
         source = bs;
+        flags |= BDRV_O_NO_BACKING;
+        set_backing_hd = true;
     }
 
     size = bdrv_getlength(bs);
@@ -3231,7 +3234,9 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
     }
 
     if (backup->format) {
-        options = qdict_new();
+        if (!options) {
+            options = qdict_new();
+        }
         qdict_put(options, "driver", qstring_from_str(backup->format));
     }
 
@@ -3242,6 +3247,14 @@ static BlockJob *do_drive_backup(DriveBackup *backup, BlockJobTxn *txn,
 
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
2.9.3
