Received: from eggs.gnu.org ([2001:4830:134:3::10]:37328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsnZw-0002Do-D2
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dsnZs-0004NV-2l
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 06:10:32 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 15 Sep 2017 12:10:04 +0200
Message-Id: <20170915101008.16646-3-kwolf@redhat.com>
In-Reply-To: <20170915101008.16646-1-kwolf@redhat.com>
References: <20170915101008.16646-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] block: Add reopen_queue to
 bdrv_child_perm()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

In the context of bdrv_reopen(), we'll have to look at the state of the
graph as it will be after the reopen. This interface addition is in
preparation for the change.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block_int.h |  7 +++++++
 block.c                   | 19 ++++++++++++-------
 block/commit.c            |  1 +
 block/mirror.c            |  1 +
 block/replication.c       |  1 +
 block/vvfat.c             |  1 +
 6 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/include/block/block_int.h b/include/block/block_int.h
index ba4c383393..99abe2ce74 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -411,9 +411,14 @@ struct BlockDriver {
      *
      * If @c is NULL, return the permissions for attaching a new child for the
      * given @role.
+     *
+     * If @reopen_queue is non-NULL, don't return the currently needed
+     * permissions, but those that will be needed after applying the
+     * @reopen_queue.
      */
      void (*bdrv_child_perm)(BlockDriverState *bs, BdrvChild *c,
                              const BdrvChildRole *role,
+                             BlockReopenQueue *reopen_queue,
                              uint64_t parent_perm, uint64_t parent_shared,
                              uint64_t *nperm, uint64_t *nshared);
 
@@ -983,6 +988,7 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
  * all children */
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildRole *role,
+                               BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
 
@@ -992,6 +998,7 @@ void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
  * CONSISTENT_READ and doesn't share WRITE. */
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildRole *role,
+                               BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared);
 
diff --git a/block.c b/block.c
index 6dd47e414e..c7724c85e3 100644
--- a/block.c
+++ b/block.c
@@ -1537,16 +1537,17 @@ static void bdrv_child_abort_perm_update(BdrvChild *c);
 static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
 
 static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
-                            BdrvChild *c,
-                            const BdrvChildRole *role,
+                            BdrvChild *c, const BdrvChildRole *role,
+                            BlockReopenQueue *reopen_queue,
                             uint64_t parent_perm, uint64_t parent_shared,
                             uint64_t *nperm, uint64_t *nshared)
 {
     if (bs->drv && bs->drv->bdrv_child_perm) {
-        bs->drv->bdrv_child_perm(bs, c, role,
+        bs->drv->bdrv_child_perm(bs, c, role, reopen_queue,
                                  parent_perm, parent_shared,
                                  nperm, nshared);
     }
+    /* TODO Take force_share from reopen_queue */
     if (child_bs && child_bs->force_share) {
         *nshared = BLK_PERM_ALL;
     }
@@ -1596,7 +1597,7 @@ static int bdrv_check_perm(BlockDriverState *bs, uint64_t cumulative_perms,
     /* Check all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        bdrv_child_perm(bs, c->bs, c, c->role,
+        bdrv_child_perm(bs, c->bs, c, c->role, NULL,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         ret = bdrv_child_check_perm(c, cur_perm, cur_shared, ignore_children,
@@ -1658,7 +1659,7 @@ static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
     /* Update all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        bdrv_child_perm(bs, c->bs, c, c->role,
+        bdrv_child_perm(bs, c->bs, c, c->role, NULL,
                         cumulative_perms, cumulative_shared_perms,
                         &cur_perm, &cur_shared);
         bdrv_child_set_perm(c, cur_perm, cur_shared);
@@ -1827,6 +1828,7 @@ int bdrv_child_try_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
 
 void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildRole *role,
+                               BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
 {
@@ -1844,6 +1846,7 @@ void bdrv_filter_default_perms(BlockDriverState *bs, BdrvChild *c,
 
 void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
                                const BdrvChildRole *role,
+                               BlockReopenQueue *reopen_queue,
                                uint64_t perm, uint64_t shared,
                                uint64_t *nperm, uint64_t *nshared)
 {
@@ -1853,9 +1856,11 @@ void bdrv_format_default_perms(BlockDriverState *bs, BdrvChild *c,
     if (!backing) {
         /* Apart from the modifications below, the same permissions are
          * forwarded and left alone as for filters */
-        bdrv_filter_default_perms(bs, c, role, perm, shared, &perm, &shared);
+        bdrv_filter_default_perms(bs, c, role, reopen_queue, perm, shared,
+                                  &perm, &shared);
 
         /* Format drivers may touch metadata even if the guest doesn't write */
+        /* TODO Take flags from reopen_queue */
         if (bdrv_is_writable(bs)) {
             perm |= BLK_PERM_WRITE | BLK_PERM_RESIZE;
         }
@@ -1999,7 +2004,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
 
     assert(parent_bs->drv);
     assert(bdrv_get_aio_context(parent_bs) == bdrv_get_aio_context(child_bs));
-    bdrv_child_perm(parent_bs, child_bs, NULL, child_role,
+    bdrv_child_perm(parent_bs, child_bs, NULL, child_role, NULL,
                     perm, shared_perm, &perm, &shared_perm);
 
     child = bdrv_root_attach_child(child_bs, child_name, child_role,
diff --git a/block/commit.c b/block/commit.c
index 898d91f653..8f0e83578a 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -257,6 +257,7 @@ static void bdrv_commit_top_close(BlockDriverState *bs)
 
 static void bdrv_commit_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                        const BdrvChildRole *role,
+                                       BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
 {
diff --git a/block/mirror.c b/block/mirror.c
index 6531652d73..6f5cb9f26c 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1084,6 +1084,7 @@ static void bdrv_mirror_top_close(BlockDriverState *bs)
 
 static void bdrv_mirror_top_child_perm(BlockDriverState *bs, BdrvChild *c,
                                        const BdrvChildRole *role,
+                                       BlockReopenQueue *reopen_queue,
                                        uint64_t perm, uint64_t shared,
                                        uint64_t *nperm, uint64_t *nshared)
 {
diff --git a/block/replication.c b/block/replication.c
index bf4462c8e7..3a4e6822e4 100644
--- a/block/replication.c
+++ b/block/replication.c
@@ -157,6 +157,7 @@ static void replication_close(BlockDriverState *bs)
 
 static void replication_child_perm(BlockDriverState *bs, BdrvChild *c,
                                    const BdrvChildRole *role,
+                                   BlockReopenQueue *reopen_queue,
                                    uint64_t perm, uint64_t shared,
                                    uint64_t *nperm, uint64_t *nshared)
 {
diff --git a/block/vvfat.c b/block/vvfat.c
index c54fa94651..ee894bbe98 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3210,6 +3210,7 @@ err:
 
 static void vvfat_child_perm(BlockDriverState *bs, BdrvChild *c,
                              const BdrvChildRole *role,
+                             BlockReopenQueue *reopen_queue,
                              uint64_t perm, uint64_t shared,
                              uint64_t *nperm, uint64_t *nshared)
 {
-- 
2.13.5
