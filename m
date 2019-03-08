Received: from eggs.gnu.org ([209.51.188.92]:44774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7E-0000nO-W5
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7B-0006pW-UI
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M79-0006jf-2t
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:07 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:44 -0500
Message-Id: <20190308202858.26636-4-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 03/17] block/dirty-bitmap: remove set/reset
 assertions against enabled bit
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

bdrv_set_dirty_bitmap and bdrv_reset_dirty_bitmap are only used as an
internal API by the mirror and migration areas of our code. These
calls modify the bitmap, but do so at the behest of QEMU and not the
guest.

Presently, these bitmaps are always "enabled" anyway, but there's no
reason they have to be.

Modify these internal APIs to drop this assertion.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190223000614.13894-4-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index c8fa21b526..b2b32e0323 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -544,7 +544,6 @@ int64_t bdrv_dirty_iter_next(BdrvDirtyBitmapIter *iter)
 void bdrv_set_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                   int64_t offset, int64_t bytes)
 {
-    assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_set(bitmap->bitmap, offset, bytes);
 }
@@ -561,7 +560,6 @@ void bdrv_set_dirty_bitmap(BdrvDirtyBitmap *bitmap,
 void bdrv_reset_dirty_bitmap_locked(BdrvDirtyBitmap *bitmap,
                                     int64_t offset, int64_t bytes)
 {
-    assert(bdrv_dirty_bitmap_enabled(bitmap));
     assert(!bdrv_dirty_bitmap_readonly(bitmap));
     hbitmap_reset(bitmap->bitmap, offset, bytes);
 }
-- 
2.17.2
