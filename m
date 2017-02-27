Received: from eggs.gnu.org ([2001:4830:134:3::10]:56890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciRcm-0007yp-Qr
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:10:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ciRcm-00035Q-0Y
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 15:10:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 27 Feb 2017 21:09:12 +0100
Message-Id: <1488226184-9044-12-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488226184-9044-1-git-send-email-kwolf@redhat.com>
References: <1488226184-9044-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 11/43] block: Request real permissions in
 bdrv_attach_child()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

Now that all block drivers with children tell us what permissions they
need from each of their children, bdrv_attach_child() can use this
information and make the right requirements while trying to attach new
children.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index d2c8126..08476bb 100644
--- a/block.c
+++ b/block.c
@@ -1438,7 +1438,8 @@ static void bdrv_set_perm(BlockDriverState *bs, uint64_t cumulative_perms,
     }
 }
 
-static void bdrv_update_perm(BlockDriverState *bs)
+static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *perm,
+                                     uint64_t *shared_perm)
 {
     BdrvChild *c;
     uint64_t cumulative_perms = 0;
@@ -1449,6 +1450,15 @@ static void bdrv_update_perm(BlockDriverState *bs)
         cumulative_shared_perms &= c->shared_perm;
     }
 
+    *perm = cumulative_perms;
+    *shared_perm = cumulative_shared_perms;
+}
+
+static void bdrv_update_perm(BlockDriverState *bs)
+{
+    uint64_t cumulative_perms, cumulative_shared_perms;
+
+    bdrv_get_cumulative_perm(bs, &cumulative_perms, &cumulative_shared_perms);
     bdrv_set_perm(bs, cumulative_perms, cumulative_shared_perms);
 }
 
@@ -1661,10 +1671,16 @@ BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              Error **errp)
 {
     BdrvChild *child;
+    uint64_t perm, shared_perm;
+
+    bdrv_get_cumulative_perm(parent_bs, &perm, &shared_perm);
+
+    assert(parent_bs->drv);
+    parent_bs->drv->bdrv_child_perm(parent_bs, NULL, child_role,
+                                    perm, shared_perm, &perm, &shared_perm);
 
-    /* FIXME Use real permissions */
     child = bdrv_root_attach_child(child_bs, child_name, child_role,
-                                   0, BLK_PERM_ALL, parent_bs, errp);
+                                   perm, shared_perm, parent_bs, errp);
     if (child == NULL) {
         return NULL;
     }
-- 
1.8.3.1
