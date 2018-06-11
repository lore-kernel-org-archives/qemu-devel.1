Received: from eggs.gnu.org ([2001:4830:134:3::10]:53468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmq-00052v-Rf
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:27:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fSNmn-00023p-TX
	for qemu-devel@nongnu.org; Mon, 11 Jun 2018 10:27:12 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 11 Jun 2018 16:26:07 +0200
Message-Id: <20180611142611.6609-26-mreitz@redhat.com>
In-Reply-To: <20180611142611.6609-1-mreitz@redhat.com>
References: <20180611142611.6609-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 25/29] block/qcow2-bitmap: fix
 free_bitmap_clusters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

This assert may fail, because bitmap_table is not initialized. Just
drop it, as it's obvious, that bitmap_table_load sets bitmap_table
parameter only when returning zero.

Reported-by: Pavel Butsykin <pbutsykin@virtuozzo.com>
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20180608101225.2575-1-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
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
2.17.1
