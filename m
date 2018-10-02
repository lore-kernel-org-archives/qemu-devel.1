Received: from eggs.gnu.org ([2001:4830:134:3::10]:40671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7TwE-00026S-LD
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:18:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1g7Tgb-0004Dt-LA
	for qemu-devel@nongnu.org; Tue, 02 Oct 2018 19:02:38 -0400
From: John Snow <jsnow@redhat.com>
Date: Tue,  2 Oct 2018 19:02:17 -0400
Message-Id: <20181002230218.13949-6-jsnow@redhat.com>
In-Reply-To: <20181002230218.13949-1-jsnow@redhat.com>
References: <20181002230218.13949-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/6] block/backup: prohibit backup from
 using in use bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Juan Quintela <quintela@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, vsementsov@virtuozzo.com, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>

If the bitmap is frozen, we shouldn't touch it.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index d0febfca79..098d4c337f 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3512,10 +3512,10 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
             bdrv_unref(target_bs);
             goto out;
         }
-        if (bdrv_dirty_bitmap_qmp_locked(bmap)) {
+        if (bdrv_dirty_bitmap_user_locked(bmap)) {
             error_setg(errp,
-                       "Bitmap '%s' is currently locked and cannot be used for "
-                       "backup", backup->bitmap);
+                       "Bitmap '%s' is currently in use by another operation"
+                       " and cannot be used for backup", backup->bitmap);
             goto out;
         }
     }
@@ -3620,10 +3620,10 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
             error_setg(errp, "Bitmap '%s' could not be found", backup->bitmap);
             goto out;
         }
-        if (bdrv_dirty_bitmap_qmp_locked(bmap)) {
+        if (bdrv_dirty_bitmap_user_locked(bmap)) {
             error_setg(errp,
-                       "Bitmap '%s' is currently locked and cannot be used for "
-                       "backup", backup->bitmap);
+                       "Bitmap '%s' is currently in use by another operation"
+                       " and cannot be used for backup", backup->bitmap);
             goto out;
         }
     }
-- 
2.14.4
