Received: from eggs.gnu.org ([2001:4830:134:3::10]:53222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coGT1-0005Kc-1q
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 17:28:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1coGT0-0005Ma-6d
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 17:28:23 -0400
From: John Snow <jsnow@redhat.com>
Date: Wed, 15 Mar 2017 17:28:11 -0400
Message-Id: <20170315212811.15937-1-jsnow@redhat.com>
Subject: [Qemu-devel] [PATCH] blockdev: fix bitmap clear undo
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, armbru@redhat.com, mreitz@redhat.com, John Snow <jsnow@redhat.com>

Only undo the action if we actually prepared the action.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 blockdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index f1f49bd..c5b2c2c 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2047,7 +2047,9 @@ static void block_dirty_bitmap_clear_abort(BlkActionState *common)
     BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
                                              common, common);
 
-    bdrv_undo_clear_dirty_bitmap(state->bitmap, state->backup);
+    if (state->backup) {
+        bdrv_undo_clear_dirty_bitmap(state->bitmap, state->backup);
+    }
 }
 
 static void block_dirty_bitmap_clear_commit(BlkActionState *common)
-- 
2.9.3
