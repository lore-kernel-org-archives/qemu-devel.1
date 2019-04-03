Received: from eggs.gnu.org ([209.51.188.92]:39505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hBh26-0007l5-4U
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berto@igalia.com>) id 1hBh24-0001X9-AF
	for qemu-devel@nongnu.org; Wed, 03 Apr 2019 10:38:30 -0400
From: Alberto Garcia <berto@igalia.com>
Date: Wed,  3 Apr 2019 17:37:48 +0300
Message-Id: <20190403143748.9790-1-berto@igalia.com>
Subject: [Qemu-devel] [PATCH for-4.1] commit: Use bdrv_append() in
 commit_start()
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

This function combines bdrv_set_backing_hd() and bdrv_replace_node()
so we can use it to simplify the code a bit in commit_start().

Signed-off-by: Alberto Garcia <berto@igalia.com>
---
 block/commit.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index ba60fef58a..a0beb7d265 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -304,23 +304,14 @@ void commit_start(const char *job_id, BlockDriverState *bs,
     commit_top_bs->total_sectors = top->total_sectors;
     bdrv_set_aio_context(commit_top_bs, bdrv_get_aio_context(top));
 
-    bdrv_set_backing_hd(commit_top_bs, top, &local_err);
+    bdrv_append(commit_top_bs, top, &local_err);
     if (local_err) {
-        bdrv_unref(commit_top_bs);
-        commit_top_bs = NULL;
-        error_propagate(errp, local_err);
-        goto fail;
-    }
-    bdrv_replace_node(top, commit_top_bs, &local_err);
-    if (local_err) {
-        bdrv_unref(commit_top_bs);
         commit_top_bs = NULL;
         error_propagate(errp, local_err);
         goto fail;
     }
 
     s->commit_top_bs = commit_top_bs;
-    bdrv_unref(commit_top_bs);
 
     /* Block all nodes between top and base, because they will
      * disappear from the chain after this operation. */
-- 
2.11.0
