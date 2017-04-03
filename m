Received: from eggs.gnu.org ([2001:4830:134:3::10]:36168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv693-0002YH-2B
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:52:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv692-00049d-8M
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 13:52:01 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 19:51:49 +0200
Message-Id: <20170403175150.15253-2-mreitz@redhat.com>
In-Reply-To: <20170403175150.15253-1-mreitz@redhat.com>
References: <20170403175150.15253-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.9 1/2] block/mirror: Fix use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

If @bs does not have any parents, the only reference to @mirror_top_bs
will be held by the BlockJob object after the bdrv_unref() following
block_job_create(). However, if block_job_create() fails, this reference
will not exist and @mirror_top_bs will have been deleted when we
goto fail.

The issue comes back at all later entries to the fail label: We delete
the BlockJob object before rolling back our changes to the node graph.
This means that we will delete @mirror_top_bs in the process.

All in all, whenever @bs does not have any parents and we go down the
fail path we will dereference @mirror_top_bs after it has been deleted.

Fix this by invoking bdrv_unref() only when block_job_create() was
successful and by bdrv_ref()'ing @mirror_top_bs in the fail path before
deleting the BlockJob object. Finally, bdrv_unref() it at the end of the
fail path after we actually no longer need it.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 9e2fecc15e..46ecd38ef0 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1150,7 +1150,7 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
     mirror_top_bs->total_sectors = bs->total_sectors;
 
     /* bdrv_append takes ownership of the mirror_top_bs reference, need to keep
-     * it alive until block_job_create() even if bs has no parent. */
+     * it alive until block_job_create() succeeds even if bs has no parent. */
     bdrv_ref(mirror_top_bs);
     bdrv_drained_begin(bs);
     bdrv_append(mirror_top_bs, bs, &local_err);
@@ -1168,10 +1168,12 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
                          BLK_PERM_CONSISTENT_READ | BLK_PERM_WRITE_UNCHANGED |
                          BLK_PERM_WRITE | BLK_PERM_GRAPH_MOD, speed,
                          creation_flags, cb, opaque, errp);
-    bdrv_unref(mirror_top_bs);
     if (!s) {
         goto fail;
     }
+    /* The block job now has a reference to this node */
+    bdrv_unref(mirror_top_bs);
+
     s->source = bs;
     s->mirror_top_bs = mirror_top_bs;
 
@@ -1242,6 +1244,10 @@ static void mirror_start_job(const char *job_id, BlockDriverState *bs,
 
 fail:
     if (s) {
+        /* Make sure this BDS does not go away until we have completed the graph
+         * changes below */
+        bdrv_ref(mirror_top_bs);
+
         g_free(s->replaces);
         blk_unref(s->target);
         block_job_unref(&s->common);
@@ -1250,6 +1256,8 @@ fail:
     bdrv_child_try_set_perm(mirror_top_bs->backing, 0, BLK_PERM_ALL,
                             &error_abort);
     bdrv_replace_node(mirror_top_bs, backing_bs(mirror_top_bs), &error_abort);
+
+    bdrv_unref(mirror_top_bs);
 }
 
 void mirror_start(const char *job_id, BlockDriverState *bs,
-- 
2.12.1
