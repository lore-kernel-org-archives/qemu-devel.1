Received: from eggs.gnu.org ([2001:4830:134:3::10]:36781)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSa1-0004o9-HH
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dVSa0-0001XC-GQ
	for qemu-devel@nongnu.org; Wed, 12 Jul 2017 21:06:09 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 12 Jul 2017 20:05:38 -0500
Message-Id: <20170713010555.6769-2-eblake@redhat.com>
In-Reply-To: <20170713010555.6769-1-eblake@redhat.com>
References: <20170713010555.6769-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH v5 01/18] dirty-bitmap: Report
 BlockDirtyInfo.count in bytes, as documented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, jsnow@redhat.com, qemu-block@nongnu.org, vsementsov@virtuozzo.com, qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, Max Reitz <mreitz@redhat.com>

We've been documenting the value in bytes since its introduction
in commit b9a9b3a4 (v1.3), where it was actually reported in bytes.

Commit e4654d2 (v2.0) then removed things from block/qapi.c, in
preparation for a rewrite to a list of dirty sectors in the next
commit 21b5683 in block.c, but the new code mistakenly started
reporting in sectors.

Fixes: https://bugzilla.redhat.com/1441460

CC: qemu-stable@nongnu.org
Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>

---
Too late for 2.9, since the regression has been unnoticed for
nine releases. But worth putting in 2.9.1.

v2-v4: no change
---
 block/dirty-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 543bddb..30462d4 100644
--- a/block/dirty-bitmap.c
+++ b/block/dirty-bitmap.c
@@ -461,7 +461,7 @@ BlockDirtyInfoList *bdrv_query_dirty_bitmaps(BlockDriverState *bs)
     QLIST_FOREACH(bm, &bs->dirty_bitmaps, list) {
         BlockDirtyInfo *info = g_new0(BlockDirtyInfo, 1);
         BlockDirtyInfoList *entry = g_new0(BlockDirtyInfoList, 1);
-        info->count = bdrv_get_dirty_count(bm);
+        info->count = bdrv_get_dirty_count(bm) << BDRV_SECTOR_BITS;
         info->granularity = bdrv_dirty_bitmap_granularity(bm);
         info->has_name = !!bm->name;
         info->name = g_strdup(bm->name);
-- 
2.9.4
