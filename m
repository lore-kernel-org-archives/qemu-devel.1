Received: from eggs.gnu.org ([2001:4830:134:3::10]:42825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuY-0008Vd-Rd
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cgBuS-0007sB-P7
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 09:59:26 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 21 Feb 2017 15:58:09 +0100
Message-Id: <1487689130-30373-14-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 13/54] block: Add Error argument to
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

It will have to return an error soon, so prepare the callers for it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c               | 16 +++++++++++++---
 block/quorum.c        |  9 ++++++++-
 include/block/block.h |  3 ++-
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index e166fe8..b2b6be0 100644
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
index ac40c8d..2d6ed7d 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -519,7 +519,8 @@ void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child);
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
