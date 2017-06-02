Received: from eggs.gnu.org ([2001:4830:134:3::10]:36076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGkeh-0006FE-6Q
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dGkee-0005a8-KA
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:22:11 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:25651 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dGkee-0005Wa-97
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 07:22:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  2 Jun 2017 14:21:44 +0300
Message-Id: <20170602112158.232757-17-vsementsov@virtuozzo.com>
In-Reply-To: <20170602112158.232757-1-vsementsov@virtuozzo.com>
References: <20170602112158.232757-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v20 16/30] block: bdrv_close: release bitmaps
 after drv->bdrv_close
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, vsementsov@virtuozzo.com, pbonzini@redhat.com

Release bitmaps after 'if (bs->drv) { ... }' block. This will allow
format driver to save persistent bitmaps, which will appear in following
commits.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 161db9e32a..b35387241a 100644
--- a/block.c
+++ b/block.c
@@ -3015,9 +3015,6 @@ static void bdrv_close(BlockDriverState *bs)
     bdrv_flush(bs);
     bdrv_drain(bs); /* in case flush left pending I/O */
 
-    bdrv_release_named_dirty_bitmaps(bs);
-    assert(QLIST_EMPTY(&bs->dirty_bitmaps));
-
     if (bs->drv) {
         BdrvChild *child, *next;
 
@@ -3056,6 +3053,9 @@ static void bdrv_close(BlockDriverState *bs)
         bs->full_open_options = NULL;
     }
 
+    bdrv_release_named_dirty_bitmaps(bs);
+    assert(QLIST_EMPTY(&bs->dirty_bitmaps));
+
     QLIST_FOREACH_SAFE(ban, &bs->aio_notifiers, list, ban_next) {
         g_free(ban);
     }
-- 
2.11.1
