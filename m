Received: from eggs.gnu.org ([209.51.188.92]:34751)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzndj-0002CY-30
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzndh-0008F5-2N
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:16:10 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  1 Mar 2019 14:15:42 -0500
Message-Id: <20190301191545.8728-5-jsnow@redhat.com>
In-Reply-To: <20190301191545.8728-1-jsnow@redhat.com>
References: <20190301191545.8728-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 4/7] block/dirty-bitmaps: prohibit readonly
 bitmaps for backups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>, eblake@redhat.com, vsementsov@virtuozzo.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela <quintela@redhat.com>

drive and blockdev backup cannot use readonly bitmaps, because the
sync=incremental mechanism actually edits the bitmaps on success.

If you really want to do this operation, use a copied bitmap.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 5d74479ba7..c8255dda0b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3526,7 +3526,7 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
             bdrv_unref(target_bs);
             goto out;
         }
-        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_ALLOW_RO, errp)) {
+        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_DEFAULT, errp)) {
             goto out;
         }
     }
@@ -3636,7 +3636,7 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
             error_setg(errp, "Bitmap '%s' could not be found", backup->bitmap);
             goto out;
         }
-        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_ALLOW_RO, errp)) {
+        if (bdrv_dirty_bitmap_check(bmap, BDRV_BITMAP_DEFAULT, errp)) {
             goto out;
         }
     }
-- 
2.17.2
