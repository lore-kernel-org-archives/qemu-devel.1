Received: from eggs.gnu.org ([2001:4830:134:3::10]:57786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP7A-0006L8-HY
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:20:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eSP79-0002vp-4P
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 10:20:00 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 22 Dec 2017 16:18:43 +0100
Message-Id: <20171222151846.28110-33-kwolf@redhat.com>
In-Reply-To: <20171222151846.28110-1-kwolf@redhat.com>
References: <20171222151846.28110-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL v3 32/35] block: Allow graph changes in subtree
 drained section
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

We need to remember how many of the drain sections in which a node is
were recursive (i.e. subtree drain rather than node drain), so that they
can be correctly applied when children are added or removed during the
drained section.

With this change, it is safe to modify the graph even inside a
bdrv_subtree_drained_begin/end() section.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     |  2 --
 include/block/block_int.h |  5 +++++
 block.c                   | 32 +++++++++++++++++++++++++++++---
 block/io.c                | 28 ++++++++++++++++++++++++----
 4 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index de9c5a2b9b..9b12774ddf 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -610,8 +610,6 @@ void bdrv_drained_begin(BlockDriverState *bs);
 /**
  * Like bdrv_drained_begin, but recursively begins a quiesced section for
  * exclusive access to all child nodes as well.
- *
- * Graph changes are not allowed during a subtree drain section.
  */
 void bdrv_subtree_drained_begin(BlockDriverState *bs);
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index e107163594..29cafa4236 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -717,6 +717,8 @@ struct BlockDriverState {
 
     /* Accessed with atomic ops.  */
     int quiesce_counter;
+    int recursive_quiesce_counter;
+
     unsigned int write_gen;               /* Current data generation */
 
     /* Protected by reqs_lock.  */
@@ -768,6 +770,9 @@ int coroutine_fn bdrv_co_pwritev(BdrvChild *child,
     int64_t offset, unsigned int bytes, QEMUIOVector *qiov,
     BdrvRequestFlags flags);
 
+void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_parent);
+void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_parent);
+
 int get_tmp_filename(char *filename, int size);
 BlockDriver *bdrv_probe_all(const uint8_t *buf, int buf_size,
                             const char *filename);
diff --git a/block.c b/block.c
index 6c247167b8..8b46ba21b1 100644
--- a/block.c
+++ b/block.c
@@ -822,6 +822,18 @@ static void bdrv_child_cb_drained_end(BdrvChild *child)
     bdrv_drained_end(bs);
 }
 
+static void bdrv_child_cb_attach(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+    bdrv_apply_subtree_drain(child, bs);
+}
+
+static void bdrv_child_cb_detach(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+    bdrv_unapply_subtree_drain(child, bs);
+}
+
 static int bdrv_child_cb_inactivate(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
@@ -889,6 +901,8 @@ const BdrvChildRole child_file = {
     .inherit_options = bdrv_inherited_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
+    .attach          = bdrv_child_cb_attach,
+    .detach          = bdrv_child_cb_detach,
     .inactivate      = bdrv_child_cb_inactivate,
 };
 
@@ -911,6 +925,8 @@ const BdrvChildRole child_format = {
     .inherit_options = bdrv_inherited_fmt_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
+    .attach          = bdrv_child_cb_attach,
+    .detach          = bdrv_child_cb_detach,
     .inactivate      = bdrv_child_cb_inactivate,
 };
 
@@ -953,6 +969,8 @@ static void bdrv_backing_attach(BdrvChild *c)
                     parent->backing_blocker);
     bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_TARGET,
                     parent->backing_blocker);
+
+    bdrv_child_cb_attach(c);
 }
 
 static void bdrv_backing_detach(BdrvChild *c)
@@ -963,6 +981,8 @@ static void bdrv_backing_detach(BdrvChild *c)
     bdrv_op_unblock_all(c->bs, parent->backing_blocker);
     error_free(parent->backing_blocker);
     parent->backing_blocker = NULL;
+
+    bdrv_child_cb_detach(c);
 }
 
 /*
@@ -1978,14 +1998,17 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
         assert(bdrv_get_aio_context(old_bs) == bdrv_get_aio_context(new_bs));
     }
     if (old_bs) {
+        /* Detach first so that the recursive drain sections coming from @child
+         * are already gone and we only end the drain sections that came from
+         * elsewhere. */
+        if (child->role->detach) {
+            child->role->detach(child);
+        }
         if (old_bs->quiesce_counter && child->role->drained_end) {
             for (i = 0; i < old_bs->quiesce_counter; i++) {
                 child->role->drained_end(child);
             }
         }
-        if (child->role->detach) {
-            child->role->detach(child);
-        }
         QLIST_REMOVE(child, next_parent);
     }
 
@@ -1999,6 +2022,9 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
             }
         }
 
+        /* Attach only after starting new drained sections, so that recursive
+         * drain sections coming from @child don't get an extra .drained_begin
+         * callback. */
         if (child->role->attach) {
             child->role->attach(child);
         }
diff --git a/block/io.c b/block/io.c
index 6befef166d..7ea402352e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -270,8 +270,8 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     assert(data.done);
 }
 
-static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
-                                  BdrvChild *parent)
+void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
+                           BdrvChild *parent)
 {
     BdrvChild *child, *next;
 
@@ -290,6 +290,7 @@ static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
     bdrv_drain_recurse(bs);
 
     if (recursive) {
+        bs->recursive_quiesce_counter++;
         QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
             bdrv_do_drained_begin(child->bs, true, child);
         }
@@ -306,8 +307,8 @@ void bdrv_subtree_drained_begin(BlockDriverState *bs)
     bdrv_do_drained_begin(bs, true, NULL);
 }
 
-static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
-                                BdrvChild *parent)
+void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
+                         BdrvChild *parent)
 {
     BdrvChild *child, *next;
     int old_quiesce_counter;
@@ -327,6 +328,7 @@ static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
     }
 
     if (recursive) {
+        bs->recursive_quiesce_counter--;
         QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
             bdrv_do_drained_end(child->bs, true, child);
         }
@@ -343,6 +345,24 @@ void bdrv_subtree_drained_end(BlockDriverState *bs)
     bdrv_do_drained_end(bs, true, NULL);
 }
 
+void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_parent)
+{
+    int i;
+
+    for (i = 0; i < new_parent->recursive_quiesce_counter; i++) {
+        bdrv_do_drained_begin(child->bs, true, child);
+    }
+}
+
+void bdrv_unapply_subtree_drain(BdrvChild *child, BlockDriverState *old_parent)
+{
+    int i;
+
+    for (i = 0; i < old_parent->recursive_quiesce_counter; i++) {
+        bdrv_do_drained_end(child->bs, true, child);
+    }
+}
+
 /*
  * Wait for pending requests to complete on a single BlockDriverState subtree,
  * and suspend block driver's internal I/O until next request arrives.
-- 
2.13.6
