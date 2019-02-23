Received: from eggs.gnu.org ([209.51.188.92]:55983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxKr0-0000fp-3u
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:07:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gxKqx-0002Hy-Jy
	for qemu-devel@nongnu.org; Fri, 22 Feb 2019 19:07:41 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri, 22 Feb 2019 19:06:07 -0500
Message-Id: <20190223000614.13894-4-jsnow@redhat.com>
In-Reply-To: <20190223000614.13894-1-jsnow@redhat.com>
References: <20190223000614.13894-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 03/10] block/dirty-bitmap: remove set/reset
 assertions against enabled bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>, eblake@redhat.com, Max Reitz <mreitz@redhat.com>, libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>

bdrv_set_dirty_bitmap and bdrv_reset_dirty_bitmap are only used as an
internal API by the mirror and migration areas of our code. These
calls modify the bitmap, but do so at the behest of QEMU and not the
guest.

Presently, these bitmaps are always "enabled" anyway, but there's no
reason they have to be.

Modify these internal APIs to drop this assertion.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index aa3f86bb73..9ea5738420 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -542,7 +542,6 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                   int64_t offset, int64_t bytes)
 {
-    assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_set(bitmap->bitmap, offset, bytes);
 }
@@ -559,7 +558,6 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                     int64_t offset, int64_t bytes)
 {
-    assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_reset(bitmap->bitmap, offset, bytes);
 }
-- 
2.17.2
