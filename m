Received: from eggs.gnu.org ([2001:4830:134:3::10]:43196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Diq-0002M3-Uq
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d3Dip-0001ZU-Rs
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 23:34:32 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed, 26 Apr 2017 11:33:56 +0800
Message-Id: <20170426033413.17192-5-famz@redhat.com>
In-Reply-To: <20170426033413.17192-1-famz@redhat.com>
References: <20170426033413.17192-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v15 04/21] block: Respect "force-share" in perm
 propagating
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c | 32 ++++++++++++++++++++++++--------
 1 file changed, 24 insertions(+), 8 deletions(-)

diff --git a/block.c b/block.c
index 9db39b6..e9f4750 100644
--- a/block.c
+++ b/block.c
@@ -1430,6 +1430,22 @@ static int bdrv_child_check_perm(BdrvChild *c, uint64_t perm, uint64_t shared,
 static void bdrv_child_abort_perm_update(BdrvChild *c);
 static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t shared);
 
+static void bdrv_child_perm(BlockDriverState *bs, BlockDriverState *child_bs,
+                            BdrvChild *c,
+                            const BdrvChildRole *role,
+                            uint64_t parent_perm, uint64_t parent_shared,
+                            uint64_t *nperm, uint64_t *nshared)
+{
+    if (bs->drv && bs->drv->bdrv_child_perm) {
+        bs->drv->bdrv_child_perm(bs, c, role,
+                                 parent_perm, parent_shared,
+                                 nperm, nshared);
+    }
+    if (child_bs && child_bs->force_share) {
+        *nshared = BLK_PERM_ALL;
+    }
+}
+
 /*
  * Check whether permissions on this node can be changed in a way that
  * @cumulative_perms and @cumulative_shared_perms are the new cumulative
@@ -1474,9 +1490,9 @@ static int bdrv_check_perm(BlockDriverState *bs, uint64_t cumulative_perms,
     /* Check all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        drv->bdrv_child_perm(bs, c, c->role,
-                             cumulative_perms, cumulative_shared_perms,
-                             &cur_perm, &cur_shared);
+        bdrv_child_perm(bs, c->bs, c, c->role,
+                        cumulative_perms, cumulative_shared_perms,
+                        &cur_perm, &cur_shared);
         ret = bdrv_child_check_perm(c, cur_perm, cur_shared, ignore_children,
                                     errp);
         if (ret < 0) {
@@ -1536,9 +1552,9 @@ static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
     /* Update all children */
     QLIST_FOREACH(c, &bs->children, next) {
         uint64_t cur_perm, cur_shared;
-        drv->bdrv_child_perm(bs, c, c->role,
-                             cumulative_perms, cumulative_shared_perms,
-                             &cur_perm, &cur_shared);
+        bdrv_child_perm(bs, c->bs, c, c->role,
+                        cumulative_perms, cumulative_shared_perms,
+                        &cur_perm, &cur_shared);
         bdrv_child_set_perm(c, cur_perm, cur_shared);
     }
 }
@@ -1873,8 +1889,8 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
 
     assert(parent_bs->drv);
     assert(bdrv_get_aio_context(parent_bs) == bdrv_get_aio_context(child_bs));
-    parent_bs->drv->bdrv_child_perm(parent_bs, NULL, child_role,
-                                    perm, shared_perm, &perm, &shared_perm);
+    bdrv_child_perm(parent_bs, child_bs, NULL, child_role,
+                    perm, shared_perm, &perm, &shared_perm);
 
     child = bdrv_root_attach_child(child_bs, child_name, child_role,
                                    perm, shared_perm, parent_bs, errp);
-- 
2.9.3
