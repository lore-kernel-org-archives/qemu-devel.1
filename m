Received: from eggs.gnu.org ([2001:4830:134:3::10]:56120)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6Jzw-0008BH-PS
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:53:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6Jzv-0003ot-Qy
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:53:00 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  4 May 2017 18:52:38 +0200
Message-Id: <1493916761-32319-4-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 3/6] block: Drop permissions when migration
 completes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

With image locking, permissions affect other qemu processes as well. We
want to be sure that the destination can run, so let's drop permissions
on the source when migration completes.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c                   | 12 +++++++++++-
 block/block-backend.c     | 25 +++++++++++++++++++++++++
 include/block/block_int.h |  7 ++++---
 3 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 3e7f124..c3e7ebd 100644
--- a/block.c
+++ b/block.c
@@ -4028,7 +4028,7 @@ void bdrv_invalidate_cache_all(Error **errp)
 static int bdrv_inactivate_recurse(BlockDriverState *bs,
                                    bool setting_flag)
 {
-    BdrvChild *child;
+    BdrvChild *child, *parent;
     int ret;
 
     if (!setting_flag && bs->drv->bdrv_inactivate) {
@@ -4047,6 +4047,16 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
 
     if (setting_flag) {
         bs->open_flags |= BDRV_O_INACTIVE;
+
+        QLIST_FOREACH(parent, &bs->parents, next_parent) {
+            if (parent->role->inactivate) {
+                ret = parent->role->inactivate(parent);
+                if (ret < 0) {
+                    bs->open_flags &= ~BDRV_O_INACTIVE;
+                    return ret;
+                }
+            }
+        }
     }
     return 0;
 }
diff --git a/block/block-backend.c b/block/block-backend.c
index a7ce72b..f3a6008 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -156,6 +156,30 @@ static void blk_root_activate(BdrvChild *child, Error **errp)
     }
 }
 
+static int blk_root_inactivate(BdrvChild *child)
+{
+    BlockBackend *blk = child->opaque;
+
+    if (blk->disable_perm) {
+        return 0;
+    }
+
+    /* Only inactivate BlockBackends for guest devices (which are inactive at
+     * this point because the VM is stopped) and unattached monitor-owned
+     * BlockBackends. If there is still any other user like a block job, then
+     * we simply can't inactivate the image. */
+    if (!blk->dev && !blk->name[0]) {
+        return -EPERM;
+    }
+
+    blk->disable_perm = true;
+    if (blk->root) {
+        bdrv_child_try_set_perm(blk->root, 0, BLK_PERM_ALL, &error_abort);
+    }
+
+    return 0;
+}
+
 static const BdrvChildRole child_root = {
     .inherit_options    = blk_root_inherit_options,
 
@@ -168,6 +192,7 @@ static const BdrvChildRole child_root = {
     .drained_end        = blk_root_drained_end,
 
     .activate           = blk_root_activate,
+    .inactivate         = blk_root_inactivate,
 };
 
 /*
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 5637925..5750a44 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -473,10 +473,11 @@ struct BdrvChildRole {
     void (*drained_begin)(BdrvChild *child);
     void (*drained_end)(BdrvChild *child);
 
-    /* Notifies the parent that the child has been activated (e.g. when
-     * migration is completing) and it can start requesting permissions and
-     * doing I/O on it. */
+    /* Notifies the parent that the child has been activated/inactivated (e.g.
+     * when migration is completing) and it can start/stop requesting
+     * permissions and doing I/O on it. */
     void (*activate)(BdrvChild *child, Error **errp);
+    int (*inactivate)(BdrvChild *child);
 
     void (*attach)(BdrvChild *child);
     void (*detach)(BdrvChild *child);
-- 
1.8.3.1
