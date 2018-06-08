Received: from eggs.gnu.org ([2001:4830:134:3::10]:44061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRENl-0003Oh-8t
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 06:12:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fRENh-0001eQ-VM
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 06:12:33 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri,  8 Jun 2018 13:12:25 +0300
Message-Id: <20180608101225.2575-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block/qcow2-bitmap: fix free_bitmap_clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, vsementsov@virtuozzo.com

This assert may fail, because bitmap_table is not initialized. Just
drop it, as it's obvious, that bitmap_table_load sets bitmap_table
parameter only when returning zero.

Reported-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-bitmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 60d5290f10..69485aa1de 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -254,7 +254,6 @@ static int free_bitmap_clusters(BlockDriverState *bs, Qcow2BitmapTable *tb)
 
     ret = bitmap_table_load(bs, tb, &bitmap_table);
     if (ret < 0) {
-        assert(bitmap_table == NULL);
         return ret;
     }
 
-- 
2.11.1
