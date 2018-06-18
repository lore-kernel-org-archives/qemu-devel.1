Received: from eggs.gnu.org ([2001:4830:134:3::10]:52115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHa-00054H-3D
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHX-0006NR-Rb
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:34 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:47 +0200
Message-Id: <20180618164504.24488-19-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/35] block: ignore_bds_parents parameter for
 drain functions
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

In the future, bdrv_drained_all_begin/end() will drain all invidiual
nodes separately rather than whole subtrees. This means that we don't
want to propagate the drain to all parents any more: If the parent is a
BDS, it will already be drained separately. Recursing to all parents is
unnecessary work and would make it an O(n=C2=B2) operation.

Prepare the drain function for the changed drain_all by adding an
ignore_bds_parents parameter to the internal implementation that
prevents the propagation of the drain to BDS parents. We still (have to)
propagate it to non-BDS parents like BlockBackends or Jobs because those
are not drained separately.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h     | 16 ++++++---
 include/block/block_int.h |  6 ++++
 block.c                   | 11 +++---
 block/io.c                | 88 ++++++++++++++++++++++++++++-------------=
------
 block/vvfat.c             |  1 +
 5 files changed, 78 insertions(+), 44 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 067d24cc4a..836746e4e1 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -557,7 +557,8 @@ void bdrv_io_unplug(BlockDriverState *bs);
  * Begin a quiesced section of all users of @bs. This is part of
  * bdrv_drained_begin.
  */
-void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore);
+void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore,
+                               bool ignore_bds_parents);
=20
 /**
  * bdrv_parent_drained_end:
@@ -565,18 +566,23 @@ void bdrv_parent_drained_begin(BlockDriverState *bs=
, BdrvChild *ignore);
  * End a quiesced section of all users of @bs. This is part of
  * bdrv_drained_end.
  */
-void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore);
+void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore,
+                             bool ignore_bds_parents);
=20
 /**
  * bdrv_drain_poll:
  *
  * Poll for pending requests in @bs, its parents (except for @ignore_par=
ent),
- * and if @recursive is true its children as well.
+ * and if @recursive is true its children as well (used for subtree drai=
n).
+ *
+ * If @ignore_bds_parents is true, parents that are BlockDriverStates mu=
st
+ * ignore the drain request because they will be drained separately (use=
d for
+ * drain_all).
  *
  * This is part of bdrv_drained_begin.
  */
 bool bdrv_drain_poll(BlockDriverState *bs, bool recursive,
-                     BdrvChild *ignore_parent);
+                     BdrvChild *ignore_parent, bool ignore_bds_parents);
=20
 /**
  * bdrv_drained_begin:
@@ -597,7 +603,7 @@ void bdrv_drained_begin(BlockDriverState *bs);
  * running requests to complete.
  */
 void bdrv_do_drained_begin_quiesce(BlockDriverState *bs,
-                                   BdrvChild *parent);
+                                   BdrvChild *parent, bool ignore_bds_pa=
rents);
=20
 /**
  * Like bdrv_drained_begin, but recursively begins a quiesced section fo=
r
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 1b811db8ec..1abfc26d76 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -577,6 +577,12 @@ struct BdrvChildRole {
      * points to. */
     bool stay_at_node;
=20
+    /* If true, the parent is a BlockDriverState and bdrv_next_all_state=
s()
+     * will return it. This information is used for drain_all, where eve=
ry node
+     * will be drained separately, so the drain only needs to be propaga=
ted to
+     * non-BDS parents. */
+    bool parent_is_bds;
+
     void (*inherit_options)(int *child_flags, QDict *child_options,
                             int parent_flags, QDict *parent_options);
=20
diff --git a/block.c b/block.c
index 50f8e3dc3b..c8586f41ba 100644
--- a/block.c
+++ b/block.c
@@ -818,13 +818,13 @@ static char *bdrv_child_get_parent_desc(BdrvChild *=
c)
 static void bdrv_child_cb_drained_begin(BdrvChild *child)
 {
     BlockDriverState *bs =3D child->opaque;
-    bdrv_do_drained_begin_quiesce(bs, NULL);
+    bdrv_do_drained_begin_quiesce(bs, NULL, false);
 }
=20
 static bool bdrv_child_cb_drained_poll(BdrvChild *child)
 {
     BlockDriverState *bs =3D child->opaque;
-    return bdrv_drain_poll(bs, false, NULL);
+    return bdrv_drain_poll(bs, false, NULL, false);
 }
=20
 static void bdrv_child_cb_drained_end(BdrvChild *child)
@@ -908,6 +908,7 @@ static void bdrv_inherited_options(int *child_flags, =
QDict *child_options,
 }
=20
 const BdrvChildRole child_file =3D {
+    .parent_is_bds   =3D true,
     .get_parent_desc =3D bdrv_child_get_parent_desc,
     .inherit_options =3D bdrv_inherited_options,
     .drained_begin   =3D bdrv_child_cb_drained_begin,
@@ -933,6 +934,7 @@ static void bdrv_inherited_fmt_options(int *child_fla=
gs, QDict *child_options,
 }
=20
 const BdrvChildRole child_format =3D {
+    .parent_is_bds   =3D true,
     .get_parent_desc =3D bdrv_child_get_parent_desc,
     .inherit_options =3D bdrv_inherited_fmt_options,
     .drained_begin   =3D bdrv_child_cb_drained_begin,
@@ -1051,6 +1053,7 @@ static int bdrv_backing_update_filename(BdrvChild *=
c, BlockDriverState *base,
 }
=20
 const BdrvChildRole child_backing =3D {
+    .parent_is_bds   =3D true,
     .get_parent_desc =3D bdrv_child_get_parent_desc,
     .attach          =3D bdrv_backing_attach,
     .detach          =3D bdrv_backing_detach,
@@ -4957,7 +4960,7 @@ void bdrv_set_aio_context(BlockDriverState *bs, Aio=
Context *new_context)
     AioContext *ctx =3D bdrv_get_aio_context(bs);
=20
     aio_disable_external(ctx);
-    bdrv_parent_drained_begin(bs, NULL);
+    bdrv_parent_drained_begin(bs, NULL, false);
     bdrv_drain(bs); /* ensure there are no in-flight requests */
=20
     while (aio_poll(ctx, false)) {
@@ -4971,7 +4974,7 @@ void bdrv_set_aio_context(BlockDriverState *bs, Aio=
Context *new_context)
      */
     aio_context_acquire(new_context);
     bdrv_attach_aio_context(bs, new_context);
-    bdrv_parent_drained_end(bs, NULL);
+    bdrv_parent_drained_end(bs, NULL, false);
     aio_enable_external(ctx);
     aio_context_release(new_context);
 }
diff --git a/block/io.c b/block/io.c
index 1a9974c136..1834a14aa6 100644
--- a/block/io.c
+++ b/block/io.c
@@ -41,12 +41,13 @@
 static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
     int64_t offset, int bytes, BdrvRequestFlags flags);
=20
-void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore)
+void bdrv_parent_drained_begin(BlockDriverState *bs, BdrvChild *ignore,
+                               bool ignore_bds_parents)
 {
     BdrvChild *c, *next;
=20
     QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
-        if (c =3D=3D ignore) {
+        if (c =3D=3D ignore || (ignore_bds_parents && c->role->parent_is=
_bds)) {
             continue;
         }
         if (c->role->drained_begin) {
@@ -55,12 +56,13 @@ void bdrv_parent_drained_begin(BlockDriverState *bs, =
BdrvChild *ignore)
     }
 }
=20
-void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore)
+void bdrv_parent_drained_end(BlockDriverState *bs, BdrvChild *ignore,
+                             bool ignore_bds_parents)
 {
     BdrvChild *c, *next;
=20
     QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
-        if (c =3D=3D ignore) {
+        if (c =3D=3D ignore || (ignore_bds_parents && c->role->parent_is=
_bds)) {
             continue;
         }
         if (c->role->drained_end) {
@@ -69,13 +71,14 @@ void bdrv_parent_drained_end(BlockDriverState *bs, Bd=
rvChild *ignore)
     }
 }
=20
-static bool bdrv_parent_drained_poll(BlockDriverState *bs, BdrvChild *ig=
nore)
+static bool bdrv_parent_drained_poll(BlockDriverState *bs, BdrvChild *ig=
nore,
+                                     bool ignore_bds_parents)
 {
     BdrvChild *c, *next;
     bool busy =3D false;
=20
     QLIST_FOREACH_SAFE(c, &bs->parents, next_parent, next) {
-        if (c =3D=3D ignore) {
+        if (c =3D=3D ignore || (ignore_bds_parents && c->role->parent_is=
_bds)) {
             continue;
         }
         if (c->role->drained_poll) {
@@ -167,6 +170,7 @@ typedef struct {
     bool recursive;
     bool poll;
     BdrvChild *parent;
+    bool ignore_bds_parents;
 } BdrvCoDrainData;
=20
 static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
@@ -220,11 +224,11 @@ static void bdrv_drain_invoke(BlockDriverState *bs,=
 bool begin)
=20
 /* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll(=
) */
 bool bdrv_drain_poll(BlockDriverState *bs, bool recursive,
-                     BdrvChild *ignore_parent)
+                     BdrvChild *ignore_parent, bool ignore_bds_parents)
 {
     BdrvChild *child, *next;
=20
-    if (bdrv_parent_drained_poll(bs, ignore_parent)) {
+    if (bdrv_parent_drained_poll(bs, ignore_parent, ignore_bds_parents))=
 {
         return true;
     }
=20
@@ -233,8 +237,9 @@ bool bdrv_drain_poll(BlockDriverState *bs, bool recur=
sive,
     }
=20
     if (recursive) {
+        assert(!ignore_bds_parents);
         QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
-            if (bdrv_drain_poll(child->bs, recursive, child)) {
+            if (bdrv_drain_poll(child->bs, recursive, child, false)) {
                 return true;
             }
         }
@@ -250,13 +255,14 @@ static bool bdrv_drain_poll_top_level(BlockDriverSt=
ate *bs, bool recursive,
      * have executed. */
     while (aio_poll(bs->aio_context, false));
=20
-    return bdrv_drain_poll(bs, recursive, ignore_parent);
+    return bdrv_drain_poll(bs, recursive, ignore_parent, false);
 }
=20
 static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
-                                  BdrvChild *parent, bool poll);
+                                  BdrvChild *parent, bool ignore_bds_par=
ents,
+                                  bool poll);
 static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
-                                BdrvChild *parent);
+                                BdrvChild *parent, bool ignore_bds_paren=
ts);
=20
 static void bdrv_co_drain_bh_cb(void *opaque)
 {
@@ -267,9 +273,11 @@ static void bdrv_co_drain_bh_cb(void *opaque)
     if (bs) {
         bdrv_dec_in_flight(bs);
         if (data->begin) {
-            bdrv_do_drained_begin(bs, data->recursive, data->parent, dat=
a->poll);
+            bdrv_do_drained_begin(bs, data->recursive, data->parent,
+                                  data->ignore_bds_parents, data->poll);
         } else {
-            bdrv_do_drained_end(bs, data->recursive, data->parent);
+            bdrv_do_drained_end(bs, data->recursive, data->parent,
+                                data->ignore_bds_parents);
         }
     } else {
         assert(data->begin);
@@ -282,7 +290,9 @@ static void bdrv_co_drain_bh_cb(void *opaque)
=20
 static void coroutine_fn bdrv_co_yield_to_drain(BlockDriverState *bs,
                                                 bool begin, bool recursi=
ve,
-                                                BdrvChild *parent, bool =
poll)
+                                                BdrvChild *parent,
+                                                bool ignore_bds_parents,
+                                                bool poll)
 {
     BdrvCoDrainData data;
=20
@@ -297,6 +307,7 @@ static void coroutine_fn bdrv_co_yield_to_drain(Block=
DriverState *bs,
         .begin =3D begin,
         .recursive =3D recursive,
         .parent =3D parent,
+        .ignore_bds_parents =3D ignore_bds_parents,
         .poll =3D poll,
     };
     if (bs) {
@@ -312,7 +323,7 @@ static void coroutine_fn bdrv_co_yield_to_drain(Block=
DriverState *bs,
 }
=20
 void bdrv_do_drained_begin_quiesce(BlockDriverState *bs,
-                                   BdrvChild *parent)
+                                   BdrvChild *parent, bool ignore_bds_pa=
rents)
 {
     assert(!qemu_in_coroutine());
=20
@@ -321,26 +332,30 @@ void bdrv_do_drained_begin_quiesce(BlockDriverState=
 *bs,
         aio_disable_external(bdrv_get_aio_context(bs));
     }
=20
-    bdrv_parent_drained_begin(bs, parent);
+    bdrv_parent_drained_begin(bs, parent, ignore_bds_parents);
     bdrv_drain_invoke(bs, true);
 }
=20
 static void bdrv_do_drained_begin(BlockDriverState *bs, bool recursive,
-                                  BdrvChild *parent, bool poll)
+                                  BdrvChild *parent, bool ignore_bds_par=
ents,
+                                  bool poll)
 {
     BdrvChild *child, *next;
=20
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(bs, true, recursive, parent, poll);
+        bdrv_co_yield_to_drain(bs, true, recursive, parent, ignore_bds_p=
arents,
+                               poll);
         return;
     }
=20
-    bdrv_do_drained_begin_quiesce(bs, parent);
+    bdrv_do_drained_begin_quiesce(bs, parent, ignore_bds_parents);
=20
     if (recursive) {
+        assert(!ignore_bds_parents);
         bs->recursive_quiesce_counter++;
         QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
-            bdrv_do_drained_begin(child->bs, true, child, false);
+            bdrv_do_drained_begin(child->bs, true, child, ignore_bds_par=
ents,
+                                  false);
         }
     }
=20
@@ -354,28 +369,30 @@ static void bdrv_do_drained_begin(BlockDriverState =
*bs, bool recursive,
      * nodes.
      */
     if (poll) {
+        assert(!ignore_bds_parents);
         BDRV_POLL_WHILE(bs, bdrv_drain_poll_top_level(bs, recursive, par=
ent));
     }
 }
=20
 void bdrv_drained_begin(BlockDriverState *bs)
 {
-    bdrv_do_drained_begin(bs, false, NULL, true);
+    bdrv_do_drained_begin(bs, false, NULL, false, true);
 }
=20
 void bdrv_subtree_drained_begin(BlockDriverState *bs)
 {
-    bdrv_do_drained_begin(bs, true, NULL, true);
+    bdrv_do_drained_begin(bs, true, NULL, false, true);
 }
=20
-void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
-                         BdrvChild *parent)
+static void bdrv_do_drained_end(BlockDriverState *bs, bool recursive,
+                                BdrvChild *parent, bool ignore_bds_paren=
ts)
 {
     BdrvChild *child, *next;
     int old_quiesce_counter;
=20
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(bs, false, recursive, parent, false);
+        bdrv_co_yield_to_drain(bs, false, recursive, parent, ignore_bds_=
parents,
+                               false);
         return;
     }
     assert(bs->quiesce_counter > 0);
@@ -383,27 +400,28 @@ void bdrv_do_drained_end(BlockDriverState *bs, bool=
 recursive,
=20
     /* Re-enable things in child-to-parent order */
     bdrv_drain_invoke(bs, false);
-    bdrv_parent_drained_end(bs, parent);
+    bdrv_parent_drained_end(bs, parent, ignore_bds_parents);
     if (old_quiesce_counter =3D=3D 1) {
         aio_enable_external(bdrv_get_aio_context(bs));
     }
=20
     if (recursive) {
+        assert(!ignore_bds_parents);
         bs->recursive_quiesce_counter--;
         QLIST_FOREACH_SAFE(child, &bs->children, next, next) {
-            bdrv_do_drained_end(child->bs, true, child);
+            bdrv_do_drained_end(child->bs, true, child, ignore_bds_paren=
ts);
         }
     }
 }
=20
 void bdrv_drained_end(BlockDriverState *bs)
 {
-    bdrv_do_drained_end(bs, false, NULL);
+    bdrv_do_drained_end(bs, false, NULL, false);
 }
=20
 void bdrv_subtree_drained_end(BlockDriverState *bs)
 {
-    bdrv_do_drained_end(bs, true, NULL);
+    bdrv_do_drained_end(bs, true, NULL, false);
 }
=20
 void bdrv_apply_subtree_drain(BdrvChild *child, BlockDriverState *new_pa=
rent)
@@ -411,7 +429,7 @@ void bdrv_apply_subtree_drain(BdrvChild *child, Block=
DriverState *new_parent)
     int i;
=20
     for (i =3D 0; i < new_parent->recursive_quiesce_counter; i++) {
-        bdrv_do_drained_begin(child->bs, true, child, true);
+        bdrv_do_drained_begin(child->bs, true, child, false, true);
     }
 }
=20
@@ -420,7 +438,7 @@ void bdrv_unapply_subtree_drain(BdrvChild *child, Blo=
ckDriverState *old_parent)
     int i;
=20
     for (i =3D 0; i < old_parent->recursive_quiesce_counter; i++) {
-        bdrv_do_drained_end(child->bs, true, child);
+        bdrv_do_drained_end(child->bs, true, child, false);
     }
 }
=20
@@ -472,7 +490,7 @@ void bdrv_drain_all_begin(void)
     BdrvNextIterator it;
=20
     if (qemu_in_coroutine()) {
-        bdrv_co_yield_to_drain(NULL, true, false, NULL, true);
+        bdrv_co_yield_to_drain(NULL, true, false, NULL, false, true);
         return;
     }
=20
@@ -486,7 +504,7 @@ void bdrv_drain_all_begin(void)
         AioContext *aio_context =3D bdrv_get_aio_context(bs);
=20
         aio_context_acquire(aio_context);
-        bdrv_do_drained_begin(bs, true, NULL, true);
+        bdrv_do_drained_begin(bs, true, NULL, false, true);
         aio_context_release(aio_context);
     }
=20
@@ -504,7 +522,7 @@ void bdrv_drain_all_end(void)
         AioContext *aio_context =3D bdrv_get_aio_context(bs);
=20
         aio_context_acquire(aio_context);
-        bdrv_do_drained_end(bs, true, NULL);
+        bdrv_do_drained_end(bs, true, NULL, false);
         aio_context_release(aio_context);
     }
 }
diff --git a/block/vvfat.c b/block/vvfat.c
index 4595f335b8..c7d2ed2d96 100644
--- a/block/vvfat.c
+++ b/block/vvfat.c
@@ -3134,6 +3134,7 @@ static void vvfat_qcow_options(int *child_flags, QD=
ict *child_options,
 }
=20
 static const BdrvChildRole child_vvfat_qcow =3D {
+    .parent_is_bds      =3D true,
     .inherit_options    =3D vvfat_qcow_options,
 };
=20
--=20
2.13.6
