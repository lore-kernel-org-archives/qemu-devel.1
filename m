Received: from eggs.gnu.org ([2001:4830:134:3::10]:39105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYcjT-0007UN-FJ
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:33:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dYcjQ-0003xS-ON
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 14:32:59 -0400
From: Eric Blake <eblake@redhat.com>
Date: Fri, 21 Jul 2017 13:32:42 -0500
Message-Id: <20170721183243.22706-2-eblake@redhat.com>
In-Reply-To: <20170721183243.22706-1-eblake@redhat.com>
References: <20170721183243.22706-1-eblake@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] dirty-bitmap: Report BlockDirtyInfo.count
 in bytes, as documented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, Fam Zheng <famz@redhat.com>, John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>

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
nine releases. But worth putting in 2.9.1 and 2.10.

v2-v4: no change
---
 block/dirty-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/dirty-bitmap.c b/block/dirty-bitmap.c
index 543bddb9b5..30462d4f9a 100644
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
2.13.3
