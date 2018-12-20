Received: from eggs.gnu.org ([2001:4830:134:3::10]:44930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6K-00048p-Vn
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gZo6A-0007O0-VC
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 21:30:12 -0500
From: John Snow <jsnow@redhat.com>
Date: Wed, 19 Dec 2018 21:29:43 -0500
Message-Id: <20181220022952.20493-3-jsnow@redhat.com>
In-Reply-To: <20181220022952.20493-1-jsnow@redhat.com>
References: <20181220022952.20493-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v5 02/11] block/dirty-bitmap: remove assertion
 from restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, vsementsov@virtuozzo.com, Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Markus Armbruster <armbru@redhat.com>

When making a backup of a dirty bitmap (for transactions), we want to
restore that backup whether or not the bitmap is enabled or not.

It is perfectly valid to write into bitmaps that are disabled. It is
only illegitimate for the guest to have done so.

Remove this assertion.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 89fd1d7f8b..6b688394e4 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -625,7 +625,6 @@ void bdrv_clear_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap **out)
 void bdrv_restore_dirty_bitmap(BdrvDirtyBitmap *bitmap, HBitmap *backup)
 {
     HBitmap *tmp = bitmap->bitmap;
-    assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
     bitmap->bitmap = backup;
     hbitmap_free(tmp);
-- 
2.17.2
