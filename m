Received: from eggs.gnu.org ([2001:4830:134:3::10]:45766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxkb-0000NW-ET
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxka-0006Tw-HO
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:11:01 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:27 +0200
Message-Id: <20170711160814.20941-39-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 38/85] block: bdrv_close: release bitmaps after
 drv->bdrv_close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Release bitmaps after 'if (bs->drv) { ... }' block. This will allow
format driver to save persistent bitmaps, which will appear in following
commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-id: 20170628120530.31251-17-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 3ec6624..700431d 100644
--- a/block.c
+++ b/block.c
@@ -3054,9 +3054,6 @@ static void bdrv_close(BlockDriverState *bs)
     bdrv_flush(bs);
     bdrv_drain(bs); /* in case flush left pending I/O */
 
-    bdrv_release_named_dirty_bitmaps(bs);
-    assert(QLIST_EMPTY(&bs->dirty_bitmaps));
-
     if (bs->drv) {
         BdrvChild *child, *next;
 
@@ -3094,6 +3091,9 @@ static void bdrv_close(BlockDriverState *bs)
         bs->full_open_options = NULL;
     }
 
+    bdrv_release_named_dirty_bitmaps(bs);
+    assert(QLIST_EMPTY(&bs->dirty_bitmaps));
+
     QLIST_FOREACH_SAFE(ban, &bs->aio_notifiers, list, ban_next) {
         g_free(ban);
     }
-- 
2.9.4
