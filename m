Received: from eggs.gnu.org ([2001:4830:134:3::10]:56157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6K00-0008Cv-4T
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:53:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1d6Jzx-0003rR-Bq
	for qemu-devel@nongnu.org; Thu, 04 May 2017 12:53:04 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu,  4 May 2017 18:52:39 +0200
Message-Id: <1493916761-32319-5-git-send-email-kwolf@redhat.com>
In-Reply-To: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
References: <1493916761-32319-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 4/6] block: Inactivate parents before children
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

The proper order for inactivating block nodes is that first the parents
get inactivated and then the children. If we do things in this order, we
can assert that we didn't accidentally leave a parent activated when one
of its child nodes is inactive.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/block.c b/block.c
index c3e7ebd..773bd64 100644
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
@@ -4038,13 +4048,6 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
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
 
@@ -4058,6 +4061,14 @@ static int bdrv_inactivate_recurse(BlockDriverState *bs,
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
