Received: from eggs.gnu.org ([2001:4830:134:3::10]:44637)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioWA-0005aF-C5
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cioW7-0007cU-KL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 15:37:06 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 28 Feb 2017 21:36:03 +0100
Message-Id: <1488314205-16264-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
References: <1488314205-16264-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 04/46] block: Add Error argument to
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

It will have to return an error soon, so prepare the callers for it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Acked-by: Fam Zheng <famz@redhat.com>
---
 block.c               | 16 +++++++++++++---
 block/quorum.c        |  9 ++++++++-
 include/block/block.h |  3 ++-
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index b663204..65240fa 100644
--- a/block.c
+++ b/block.c
@@ -1368,7 +1368,8 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
                              const char *child_name,
-                             const BdrvChildRole *child_role)
+                             const BdrvChildRole *child_role,
+                             Error **errp)
 {
     BdrvChild *child = bdrv_root_attach_child(child_bs, child_name, child_role,
                                               parent_bs);
@@ -1469,7 +1470,9 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd)
         bs->backing = NULL;
         goto out;
     }
-    bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_backing);
+    /* FIXME Error handling */
+    bs->backing = bdrv_attach_child(bs, backing_hd, "backing", &child_backing,
+                                    &error_abort);
     bs->open_flags &= ~BDRV_O_NO_BACKING;
     pstrcpy(bs->backing_file, sizeof(bs->backing_file), backing_hd->filename);
     pstrcpy(bs->backing_format, sizeof(bs->backing_format),
@@ -1648,6 +1651,7 @@ BdrvChild *bdrv_open_child(const char *filename,
                            const BdrvChildRole *child_role,
                            bool allow_none, Error **errp)
 {
+    BdrvChild *c;
     BlockDriverState *bs;
 
     bs = bdrv_open_child_bs(filename, options, bdref_key, parent, child_role,
@@ -1656,7 +1660,13 @@ BdrvChild *bdrv_open_child(const char *filename,
         return NULL;
     }
 
-    return bdrv_attach_child(parent, bs, bdref_key, child_role);
+    c = bdrv_attach_child(parent, bs, bdref_key, child_role, errp);
+    if (!c) {
+        bdrv_unref(bs);
+        return NULL;
+    }
+
+    return c;
 }
 
 static BlockDriverState *bdrv_append_temp_snapshot(BlockDriverState *bs,
diff --git a/block/quorum.c b/block/quorum.c
index 86e2072..bdbcec6 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1032,10 +1032,17 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
 
     /* We can safely add the child now */
     bdrv_ref(child_bs);
-    child = bdrv_attach_child(bs, child_bs, indexstr, &child_format);
+
+    child = bdrv_attach_child(bs, child_bs, indexstr, &child_format, errp);
+    if (child == NULL) {
+        s->next_child_index--;
+        bdrv_unref(child_bs);
+        goto out;
+    }
     s->children = g_renew(BdrvChild *, s->children, s->num_children + 1);
     s->children[s->num_children++] = child;
 
+out:
     bdrv_drained_end(bs);
 }
 
diff --git a/include/block/block.h b/include/block/block.h
index f62f38e..ff951ea 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -520,7 +520,8 @@ void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child);
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
                              const char *child_name,
-                             const BdrvChildRole *child_role);
+                             const BdrvChildRole *child_role,
+                             Error **errp);
 
 bool bdrv_op_is_blocked(BlockDriverState *bs, BlockOpType op, Error **errp);
 void bdrv_op_block(BlockDriverState *bs, BlockOpType op, Error *reason);
-- 
1.8.3.1
