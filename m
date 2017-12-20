Received: from eggs.gnu.org ([2001:4830:134:3::10]:39923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbjM-00054j-AT
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:36:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbjJ-0005Wz-Ki
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:36:08 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 11:34:09 +0100
Message-Id: <20171220103412.13048-17-kwolf@redhat.com>
In-Reply-To: <20171220103412.13048-1-kwolf@redhat.com>
References: <20171220103412.13048-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 16/19] block: Allow graph changes in subtree
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
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

We need to remember how many of the drain sections in which a node is
were recursive (i.e. subtree drain rather than node drain), so that they
can be correctly applied when children are added or removed during the
drained section.

With this change, it is safe to modify the graph even inside a
bdrv_subtree_drained_begin/end() section.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     |  7 +++++--
 include/block/block_int.h |  2 ++
 block.c                   | 40 +++++++++++++++++++++++++++++++++++++---
 block/io.c                | 15 ++++++---------
 4 files changed, 50 insertions(+), 14 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index de9c5a2b9b..c8e6163cf7 100644
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
 
@@ -627,6 +625,11 @@ void bdrv_drained_end(BlockDriverState *bs);
  */
 void bdrv_subtree_drained_end(BlockDriverState *bs);
 
+void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
+                           BdrvChild *parent);
+void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
+                         BdrvChild *parent);
+
 void bdrv_add_child(BlockDriverState *parent, BlockDriverState *child,
                     Error **errp);
 void bdrv_del_child(BlockDriverState *parent, BdrvChild *child, Error **errp);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index e107163594..c2d3956633 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -717,6 +717,8 @@ struct BlockDriverState {
 
     /* Accessed with atomic ops.  */
     int quiesce_counter;
+    int recursive_quiesce_counter;
+
     unsigned int write_gen;               /* Current data generation */
 
     /* Protected by reqs_lock.  */
diff --git a/block.c b/block.c
index 5867a2a2a0..37f8639fe9 100644
--- a/block.c
+++ b/block.c
@@ -822,6 +822,26 @@ static void bdrv_child_cb_drained_end(BdrvChild *child)
     bdrv_drained_end(bs);
 }
 
+static void bdrv_child_cb_attach(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+    int i;
+
+    for (i = 0; i < bs->recursive_quiesce_counter; i++) {
+        bdrv_do_drained_begin(child->bs, true, child);
+    }
+}
+
+static void bdrv_child_cb_detach(BdrvChild *child)
+{
+    BlockDriverState *bs = child->opaque;
+    int i;
+
+    for (i = 0; i < bs->recursive_quiesce_counter; i++) {
+        bdrv_do_drained_end(child->bs, true, child);
+    }
+}
+
 static int bdrv_child_cb_inactivate(BdrvChild *child)
 {
     BlockDriverState *bs = child->opaque;
@@ -889,6 +909,8 @@ const BdrvChildRole child_file = {
     .inherit_options = bdrv_inherited_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
+    .attach          = bdrv_child_cb_attach,
+    .detach          = bdrv_child_cb_detach,
     .inactivate      = bdrv_child_cb_inactivate,
 };
 
@@ -911,6 +933,8 @@ const BdrvChildRole child_format = {
     .inherit_options = bdrv_inherited_fmt_options,
     .drained_begin   = bdrv_child_cb_drained_begin,
     .drained_end     = bdrv_child_cb_drained_end,
+    .attach          = bdrv_child_cb_attach,
+    .detach          = bdrv_child_cb_detach,
     .inactivate      = bdrv_child_cb_inactivate,
 };
 
@@ -953,6 +977,8 @@ static void bdrv_backing_attach(BdrvChild *c)
                     parent->backing_blocker);
     bdrv_op_unblock(backing_hd, BLOCK_OP_TYPE_BACKUP_TARGET,
                     parent->backing_blocker);
+
+    bdrv_child_cb_attach(c);
 }
 
 static void bdrv_backing_detach(BdrvChild *c)
@@ -963,6 +989,8 @@ static void bdrv_backing_detach(BdrvChild *c)
     bdrv_op_unblock_all(c->bs, parent->backing_blocker);
     error_free(parent->backing_blocker);
     parent->backing_blocker = NULL;
+
+    bdrv_child_cb_detach(c);
 }
 
 /*
@@ -1978,14 +2006,17 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
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
 
@@ -1999,6 +2030,9 @@ static void bdrv_replace_child_noperm(BdrvChild *child,
             }
         }
 
+        /* Attach only after starting new drained sections, so that recursive
+         * drain sections coming from @child don't get an extra .drained_begin
+         * callback. */
         if (child->role->attach) {
             child->role->attach(child);
         }
diff --git a/block/io.c b/block/io.c
index 6befef166d..2eb0783506 100644
--- a/block/io.c
+++ b/block/io.c
@@ -219,11 +219,6 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
     return waited;
 }
 
-static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
-                                  BdrvChild *parent);
-static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
-                                BdrvChild *parent);
-
 static void bdrv_co_drain_bh_cb(void *opaque)
 {
     BdrvCoDrainData *data = opaque;
@@ -270,8 +265,8 @@ static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
     assert(data.done);
 }
 
-static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
-                                  BdrvChild *parent)
+void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
+                           BdrvChild *parent)
 {
     BdrvChild *child, *next;
 
@@ -290,6 +285,7 @@ static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
     bdrv_drain_recurse(bs);
 
     if (recursive) {
+        bs->recursive_quiesce_counter++;
         QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
             bdrv_do_drained_begin(child->bs, true, child);
         }
@@ -306,8 +302,8 @@ void bdrv_subtree_drained_begin(BlockDriverState *bs)
     bdrv_do_drained_begin(bs, true, NULL);
 }
 
-static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
-                                BdrvChild *parent)
+void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
+                         BdrvChild *parent)
 {
     BdrvChild *child, *next;
     int old_quiesce_counter;
@@ -327,6 +323,7 @@ static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
     }
 
     if (recursive) {
+        bs->recursive_quiesce_counter--;
         QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
             bdrv_do_drained_end(child->bs, true, child);
         }
-- 
2.13.6
