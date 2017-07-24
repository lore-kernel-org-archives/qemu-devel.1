Received: from eggs.gnu.org ([2001:4830:134:3::10]:45546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZePS-0001kH-6d
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:32:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dZePM-00077m-I5
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:32:34 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 24 Jul 2017 16:32:07 +0200
Message-Id: <1500906730-26467-3-git-send-email-kwolf@redhat.com>
In-Reply-To: <1500906730-26467-1-git-send-email-kwolf@redhat.com>
References: <1500906730-26467-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 2/5] dirty-bitmap: Report BlockDirtyInfo.count
 in bytes, as documented
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Eric Blake <eblake@redhat.com>

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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
1.8.3.1
