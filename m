Received: from eggs.gnu.org ([209.51.188.92]:34825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzndp-0002JM-C6
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:16:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1gzndm-0008Je-Ml
	for qemu-devel@nongnu.org; Fri, 01 Mar 2019 14:16:17 -0500
From: John Snow <jsnow@redhat.com>
Date: Fri,  1 Mar 2019 14:15:44 -0500
Message-Id: <20190301191545.8728-7-jsnow@redhat.com>
In-Reply-To: <20190301191545.8728-1-jsnow@redhat.com>
References: <20190301191545.8728-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/7] block/dirty-bitmaps: disallow busy
 bitmaps as merge source
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

We didn't do any state checking on source bitmaps at all,
so this adds inconsistent and busy checks. readonly is
allowed, so you can still copy a readonly bitmap to a new
destination to use it for operations like drive-backup.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/dirty-bitmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 769668ccdc..8403c9981d 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -825,6 +825,9 @@ void bdrv_merge_dirty_bitmap(BdrvDirtyBitmap *dest, const BdrvDirtyBitmap *src,
         goto out;
     }
 
+    if (bdrv_dirty_bitmap_check(src, BDRV_BITMAP_ALLOW_RO, errp)) {
+        goto out;
+    }
 
     if (!hbitmap_can_merge(dest->bitmap, src->bitmap)) {
         error_setg(errp, "Bitmaps are incompatible and can't be merged");
-- 
2.17.2
