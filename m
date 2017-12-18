Received: from eggs.gnu.org ([2001:4830:134:3::10]:45849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwX2-0006nH-JF
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwX1-0007Cs-O4
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwX1-0007CZ-HN
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:39 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:35:19 +0000
Message-Id: <20171218143530.12082-13-stefanha@redhat.com>
In-Reply-To: <20171218143530.12082-1-stefanha@redhat.com>
References: <20171218143530.12082-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 12/23] block: drop unused
 BlockDirtyBitmapState->aio_context field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

The dirty bitmap actions in qmp_transaction have not used AioContext
since the dirty bitmap locking discipline was introduced in commit
2119882c7eb7e2c612b24fc0c8d86f5887d6f1c3 ("block: introduce
dirty_bitmap_mutex").  Remove the unused field.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-id: 20171206144550.22295-7-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 blockdev.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 6332a249ea..e865ae4873 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -2049,7 +2049,6 @@ typedef struct BlockDirtyBitmapState {
     BlkActionState common;
     BdrvDirtyBitmap *bitmap;
     BlockDriverState *bs;
-    AioContext *aio_context;
     HBitmap *backup;
     bool prepared;
 } BlockDirtyBitmapState;
@@ -2128,7 +2127,6 @@ static void block_dirty_bitmap_clear_prepare(BlkActionState *common,
     }
 
     bdrv_clear_dirty_bitmap(state->bitmap, &state->backup);
-    /* AioContext is released in .clean() */
 }
 
 static void block_dirty_bitmap_clear_abort(BlkActionState *common)
@@ -2149,16 +2147,6 @@ static void block_dirty_bitmap_clear_commit(BlkActionState *common)
     hbitmap_free(state->backup);
 }
 
-static void block_dirty_bitmap_clear_clean(BlkActionState *common)
-{
-    BlockDirtyBitmapState *state = DO_UPCAST(BlockDirtyBitmapState,
-                                             common, common);
-
-    if (state->aio_context) {
-        aio_context_release(state->aio_context);
-    }
-}
-
 static void abort_prepare(BlkActionState *common, Error **errp)
 {
     error_setg(errp, "Transaction aborted using Abort action");
@@ -2219,7 +2207,6 @@ static const BlkActionOps actions[] = {
         .prepare = block_dirty_bitmap_clear_prepare,
         .commit = block_dirty_bitmap_clear_commit,
         .abort = block_dirty_bitmap_clear_abort,
-        .clean = block_dirty_bitmap_clear_clean,
     }
 };
 
-- 
2.14.3
