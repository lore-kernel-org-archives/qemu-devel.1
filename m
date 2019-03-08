Received: from eggs.gnu.org ([209.51.188.92]:44923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7L-0000uP-U6
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1h2M7J-0006yU-PT
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1h2M7J-0006u2-2a
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 15:29:17 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  8 Mar 2019 15:28:57 -0500
Message-Id: <20190308202858.26636-17-jsnow@redhat.com>
In-Reply-To: <20190308202858.26636-1-jsnow@redhat.com>
References: <20190308202858.26636-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PULL 16/17] block/dirty-bitmaps: disallow busy
 bitmaps as merge source
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

We didn't do any state checking on source bitmaps at all,
so this adds inconsistent and busy checks. readonly is
allowed, so you can still copy a readonly bitmap to a new
destination to use it for operations like drive-backup.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190301191545.8728-7-jsnow@redhat.com
Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 6b6fed1363..59c403c3fd 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -824,6 +824,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
         goto out;
     }
 
+    if (bdrv_dirty_bitmap_check(src, BDRV_BITMAP_ALLOW_RO, errp)) {
+        goto out;
+    }
 
     if (!hbitmap_can_merge(dest->bitmap, src->bitmap)) {
         error_setg(errp, "Bitmaps are incompatible and can't be merged");
-- 
2.17.2
