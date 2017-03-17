Received: from eggs.gnu.org ([2001:4830:134:3::10]:52815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1corjg-0004YO-5j
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:16:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1corjf-0000mL-5I
	for qemu-devel@nongnu.org; Fri, 17 Mar 2017 09:16:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Mar 2017 14:15:43 +0100
Message-Id: <1489756546-27142-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
References: <1489756546-27142-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 5/8] blockdev: fix bitmap clear undo
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

From: John Snow <jsnow@redhat.com>

Only undo the action if we actually prepared the action.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
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
1.8.3.1
