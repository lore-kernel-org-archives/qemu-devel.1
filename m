Received: from eggs.gnu.org ([2001:4830:134:3::10]:45384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2f-0004ab-SS
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gHF2c-0002Ub-U9
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1gHF2a-0002JM-TU
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 17:25:41 -0400
From: John Snow <jsnow@redhat.com>
Date: Mon, 29 Oct 2018 17:24:56 -0400
Message-Id: <20181029212501.5897-15-jsnow@redhat.com>
In-Reply-To: <20181029212501.5897-1-jsnow@redhat.com>
References: <20181029212501.5897-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 14/19] block/backup: prohibit backup from using
 in use bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, peter.maydell@linaro.org

If the bitmap is frozen, we shouldn't touch it.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20181002230218.13949-6-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 35097b92cc..c30495d035 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3513,10 +3513,10 @@ static BlockJob *do_drive_backup(DriveBackup *backup, JobTxn *txn,
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
@@ -3621,10 +3621,10 @@ BlockJob *do_blockdev_backup(BlockdevBackup *backup, JobTxn *txn,
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
2.14.5
