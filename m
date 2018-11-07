Received: from eggs.gnu.org ([2001:4830:134:3::10]:46775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNSW-0003xq-9i
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:01:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1gKNSC-0002Ia-1C
	for qemu-devel@nongnu.org; Wed, 07 Nov 2018 08:01:15 -0500
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  7 Nov 2018 14:59:44 +0200
Message-Id: <23fc7cf1ae15080a1a0379af219bdd90bcda5993.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
In-Reply-To: <cover.1541595424.git.berto@igalia.com>
References: <cover.1541595424.git.berto@igalia.com>
Subject: [Qemu-devel] [PATCH v4 09/15] block: Drop bdrv_reopen()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

No one is using this function anymore, so we can safely remove it.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c               | 21 ---------------------
 include/block/block.h |  1 -
 2 files changed, 22 deletions(-)

diff --git a/block.c b/block.c
index cfa53f7114..31de7b2299 100644
--- a/block.c
+++ b/block.c
@@ -3106,27 +3106,6 @@ cleanup:
     return ret;
 }
 
-
-/* Reopen a single BlockDriverState with the specified flags. */
-int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp)
-{
-    int ret = -1;
-    Error *local_err = NULL;
-    BlockReopenQueue *queue;
-
-    bdrv_subtree_drained_begin(bs);
-
-    queue = bdrv_reopen_queue(NULL, bs, NULL, bdrv_flags);
-    ret = bdrv_reopen_multiple(bdrv_get_aio_context(bs), queue, &local_err);
-    if (local_err != NULL) {
-        error_propagate(errp, local_err);
-    }
-
-    bdrv_subtree_drained_end(bs);
-
-    return ret;
-}
-
 int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
                               Error **errp)
 {
diff --git a/include/block/block.h b/include/block/block.h
index 382e6643fc..de72c7a093 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -302,7 +302,6 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueue *bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options, int flags);
 int bdrv_reopen_multiple(AioContext *ctx, BlockReopenQueue *bs_queue, Error **errp);
-int bdrv_reopen(BlockDriverState *bs, int bdrv_flags, Error **errp);
 int bdrv_reopen_set_read_only(BlockDriverState *bs, bool read_only,
                               Error **errp);
 int bdrv_reopen_prepare(BDRVReopenState *reopen_state,
-- 
2.11.0
