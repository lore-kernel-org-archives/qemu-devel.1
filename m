Received: from eggs.gnu.org ([2001:4830:134:3::10]:44189)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunT-00051N-RE
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fcunS-0001aN-Oy
	for qemu-devel@nongnu.org; Tue, 10 Jul 2018 11:43:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 10 Jul 2018 17:42:41 +0200
Message-Id: <20180710154304.18304-2-kwolf@redhat.com>
In-Reply-To: <20180710154304.18304-1-kwolf@redhat.com>
References: <20180710154304.18304-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/24] block: Poll after drain on attaching a
 node
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

Commit dcf94a23b1 ('block: Don't poll in parent drain callbacks')
removed polling in bdrv_child_cb_drained_begin() on the grounds that the
original bdrv_drain() already will poll and BdrvChildRole.drained_begin
calls must not cause graph changes (and therefore must not call
aio_poll() or the recursion through the graph will break.

This reasoning is correct for calls through bdrv_do_drained_begin().
However, BdrvChildRole.drained_begin is also called when a node that is
already in a drained section (i.e. bdrv_do_drained_begin() has already
returned and therefore can't poll any more) is attached to a new parent.
In this case, we must explicitly poll to have all requests completed
before the drained new child can be attached to the parent.

In bdrv_replace_child_noperm(), we know that we're not inside the
recursion of bdrv_do_drained_begin() because graph changes are not
allowed there, and bdrv_replace_child_noperm() is a graph change. The
call of BdrvChildRole.drained_begin() must therefore be followed by a
BDRV_POLL_WHILE() that waits for the completion of requests.

Reported-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     |  8 ++++++++
 include/block/block_int.h |  3 +++
 block.c                   |  2 +-
 block/io.c                | 26 ++++++++++++++++++++------
 4 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index bc76b1e59f..706ef009ad 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -569,6 +569,14 @@ void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore,
                                bool ignore_bds_parents);
 
 /**
+ * bdrv_parent_drained_begin_single:
+ *
+ * Begin a quiesced section for the parent of @c. If @poll is true, wait for
+ * any pending activity to cease.
+ */
+void bdrv_parent_drained_begin_single(BdrvChild *c, bool poll);
+
+/**
  * bdrv_parent_drained_end:
  *
  * End a quiesced section of all users of @bs. This is part of
diff --git a/include/block/block_int.h b/include/block/block_int.h
index af71b414be..81cd3db7a9 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -606,6 +606,9 @@ struct BdrvChildRole {
      * requests after returning from .drained_begin() until .drained_end() is
      * called.
      *
+     * These functions must not change the graph (and therefore also must not
+     * call aio_poll(), which could change the graph indirectly).
+     *
      * Note that this can be nested. If drained_begin() was called twice, new
      * I/O is allowed only after drained_end() was called twice, too.
      */
diff --git a/block.c b/block.c
index ac8b3a3511..a2fe05ea96 100644
--- a/block.c
+++ b/block.c
@@ -2066,7 +2066,7 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
             }
             assert(num >= 0);
             for (i = 0; i < num; i++) {
-                child->role->drained_begin(child);
+                bdrv_parent_drained_begin_single(child, true);
             }
         }
 
diff --git a/block/io.c b/block/io.c
index 1a2272fad3..038449f81f 100644
--- a/block/io.c
+++ b/block/io.c
@@ -52,9 +52,7 @@ void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore,
         if (c == ignore || (ignore_bds_parents && c->role->parent_is_bds)) {
             continue;
         }
-        if (c->role->drained_begin) {
-            c->role->drained_begin(c);
-        }
+        bdrv_parent_drained_begin_single(c, false);
     }
 }
 
@@ -73,6 +71,14 @@ void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore,
     }
 }
 
+static bool bdrv_parent_drained_poll_single(BdrvChild *c)
+{
+    if (c->role->drained_poll) {
+        return c->role->drained_poll(c);
+    }
+    return false;
+}
+
 static bool bdrv_parent_drained_poll(BlockDriverState *bs, BdrvChild *ignore,
                                      bool ignore_bds_parents)
 {
@@ -83,14 +89,22 @@ static bool bdrv_parent_drained_poll(BlockDriverState *bs, BdrvChild *ignore,
         if (c == ignore || (ignore_bds_parents && c->role->parent_is_bds)) {
             continue;
         }
-        if (c->role->drained_poll) {
-            busy |= c->role->drained_poll(c);
-        }
+        busy |= bdrv_parent_drained_poll_single(c);
     }
 
     return busy;
 }
 
+void bdrv_parent_drained_begin_single(BdrvChild *c, bool poll)
+{
+    if (c->role->drained_begin) {
+        c->role->drained_begin(c);
+    }
+    if (poll) {
+        BDRV_POLL_WHILE(c->bs, bdrv_parent_drained_poll_single(c));
+    }
+}
+
 static void bdrv_merge_limits(BlockLimits *dst, const BlockLimits *src)
 {
     dst->opt_transfer = MAX(dst->opt_transfer, src->opt_transfer);
-- 
2.13.6
