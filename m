Received: from eggs.gnu.org ([2001:4830:134:3::10]:36912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAa-0002T3-Hh
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d8pAZ-0007bG-LY
	for qemu-devel@nongnu.org; Thu, 11 May 2017 10:34:20 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 May 2017 16:32:34 +0200
Message-Id: <1494513181-7900-32-git-send-email-kwolf@redhat.com>
In-Reply-To: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
References: <1494513181-7900-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 31/58] block: Inactivate parents before children
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

The proper order for inactivating block nodes is that first the parents
get inactivated and then the children. If we do things in this order, we
can assert that we didn't accidentally leave a parent activated when one
of its child nodes is inactive.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index 444a52e..170002e 100644
--- a/block.c
+++ b/block.c
@@ -762,6 +762,13 @@ static void bdrv_child_cb_drained_end(BdrvChild *child)
     bdrv_drained_end(bs);
 }
 
+static int bdrv_child_cb_inactivate(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+    assert(bs->open_flags & BDRV_O_INACTIVE);
+    return 0;
+}
+
 /*
  * Returns the options and flags that a temporary snapshot should get, based on
  * the originally requested flags (the originally requested image will have
@@ -822,6 +829,7 @@ const BdrvChildRole child_file = {
     .inherit_options = bdrv_inherited_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
+    .inactivate      = bdrv_child_cb_inactivate,
 };
 
 /*
@@ -843,6 +851,7 @@ const BdrvChildRole child_format = {
     .inherit_options = bdrv_inherited_fmt_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
+    .inactivate      = bdrv_child_cb_inactivate,
 };
 
 static void bdrv_backing_attach(BdrvChild *c)
@@ -928,6 +937,7 @@ const BdrvChildRole child_backing = {
     .inherit_options = bdrv_backing_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
+    .inactivate      = bdrv_child_cb_inactivate,
 };
 
 static int bdrv_open_flags(BlockDriverState *bs, int flags)
@@ -4029,13 +4039,6 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
         }
     }
 
-    QLIST_FOREACH(child, &bs->children, next) {
-        ret = bdrv_inactivate_recurse(child->bs, setting_flag);
-        if (ret < 0) {
-            return ret;
-        }
-    }
-
     if (setting_flag) {
         bs->open_flags |= BDRV_O_INACTIVE;
 
@@ -4049,6 +4052,14 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
             }
         }
     }
+
+    QLIST_FOREACH(child, &bs->children, next) {
+        ret = bdrv_inactivate_recurse(child->bs, setting_flag);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     return 0;
 }
 
-- 
1.8.3.1
