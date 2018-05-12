Received: from eggs.gnu.org ([2001:4830:134:3::10]:40164)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJI7-0006KF-L5
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fHJI6-0006SM-UE
	for qemu-devel@nongnu.org; Fri, 11 May 2018 21:25:43 -0400
From: John Snow <jsnow@redhat.com>
Date: Fri, 11 May 2018 21:25:27 -0400
Message-Id: <20180512012537.22478-3-jsnow@redhat.com>
In-Reply-To: <20180512012537.22478-1-jsnow@redhat.com>
References: <20180512012537.22478-1-jsnow@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 02/12] qcow2/dirty-bitmap: cache loaded
 bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>

For bitmaps that we succeeded in loading, we can cache a reference
to that object. This will let us iterate over the more convenient
form of in-memory bitmaps for qemu-img bitmap manipulation tools.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 block/qcow2-bitmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index fb0a4f3ec4..d89758f235 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -986,6 +986,7 @@ bool qcow2_load_dirty_bitmaps(BlockDriverState *bs, Error **errp)
             if (bitmap == NULL) {
                 goto fail;
             }
+            bm->dirty_bitmap = bitmap;
 
             if (!(bm->flags & BME_FLAG_AUTO)) {
                 bdrv_disable_dirty_bitmap(bitmap);
-- 
2.14.3
