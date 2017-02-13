Received: from eggs.gnu.org ([2001:4830:134:3::10]:58880)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLX-0002jR-0J
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1cdKLV-0005mm-Pw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 12:23:27 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 13 Feb 2017 18:22:25 +0100
Message-Id: <1487006583-24350-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 03/41] block: Add Error argument to
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
 block.c               | 13 ++++++++++---
 block/quorum.c        |  8 +++++++-
 include/block/block.h |  3 ++-
 3 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/block.c b/block.c
index 0618f4b..9895aaf 100644
--- a/block.c
+++ b/block.c
@@ -1323,7 +1323,8 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState *child_bs,
 BdrvChild *bdrv_attach_child(BlockDriverState *parent_bs,
                              BlockDriverState *child_bs,
                              const char *child_name,
-                             const BdrvChildRole *child_role)
+                             const BdrvChildRole *child_role,
+                             Error **errp)
 {
     BdrvChild *child = bdrv_root_attach_child(child_bs, child_name, child_role,
                                               parent_bs);
@@ -1424,7 +1425,9 @@ void bdrv_set_backing_hd(BlockDriverState *bs, BlockDriverState *backing_hd)
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
@@ -1594,7 +1597,11 @@ BdrvChild *bdrv_open_child(const char *filename,
         goto done;
     }
 
-    c = bdrv_attach_child(parent, bs, bdref_key, child_role);
+    c = bdrv_attach_child(parent, bs, bdref_key, child_role, errp);
+    if (!c) {
+        bdrv_unref(bs);
+        goto done;
+    }
 
 done:
     qdict_del(options, bdref_key);
diff --git a/block/quorum.c b/block/quorum.c
index 86e2072..45bf010 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -1032,10 +1032,16 @@ static void quorum_add_child(BlockDriverState *bs, BlockDriverState *child_bs,
 
     /* We can safely add the child now */
     bdrv_ref(child_bs);
-    child = bdrv_attach_child(bs, child_bs, indexstr, &child_format);
+
+    child = bdrv_attach_child(bs, child_bs, indexstr, &child_format, errp);
+    if (child == NULL) {
+        bdrv_unref(child_bs);
+        goto out;
+    }
     s->children = g_renew(BdrvChild *, s->children, s->num_children + 1);
     s->children[s->num_children++] = child;
 
+out:
     bdrv_drained_end(bs);
 }
 
diff --git a/include/block/block.h b/include/block/block.h
index 4e81f20..93812df 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -482,7 +482,8 @@ void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child);
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
