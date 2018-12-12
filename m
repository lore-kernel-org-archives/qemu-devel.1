Received: from eggs.gnu.org ([2001:4830:134:3::10]:46879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZM-0003bD-3z
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4ZK-0001sM-VE
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:56 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:32 +0100
Message-Id: <20181212132735.16080-39-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 38/41] block: Stop passing flags to
 bdrv_reopen_queue_child()
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

From: Alberto Garcia <berto@igalia.com>

Now that all callers are passing the new options using the QDict we no
longer need the 'flags' parameter.

This patch makes the following changes:

   1) The update_options_from_flags() call is no longer necessary
      so it can be removed.

   2) The update_flags_from_options() call is now used in all cases,
      and is moved down a few lines so it happens after the options
      QDict contains the final set of values.

   3) The flags parameter is removed. Now the flags are initialized
      using the current value (for the top-level node) or the parent
      flags (after inherit_options()). In both cases the initial
      values are updated to reflect the new options in the QDict. This
      happens in bdrv_reopen_queue_child() (as explained above) and in
      bdrv_reopen_prepare().

Signed-off-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 48 +++++++++++++++++++-----------------------------
 1 file changed, 19 insertions(+), 29 deletions(-)

diff --git a/block.c b/block.c
index 800c341244..cb354438be 100644
--- a/block.c
+++ b/block.c
@@ -2931,7 +2931,6 @@ BlockDriverState *bdrv_open(const char *filename, c=
onst char *reference,
 static BlockReopenQueue *bdrv_reopen_queue_child(BlockReopenQueue *bs_qu=
eue,
                                                  BlockDriverState *bs,
                                                  QDict *options,
-                                                 int flags,
                                                  const BdrvChildRole *ro=
le,
                                                  QDict *parent_options,
                                                  int parent_flags)
@@ -2940,7 +2939,9 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bl=
ockReopenQueue *bs_queue,
=20
     BlockReopenQueueEntry *bs_entry;
     BdrvChild *child;
-    QDict *old_options, *explicit_options;
+    QDict *old_options, *explicit_options, *options_copy;
+    int flags;
+    QemuOpts *opts;
=20
     /* Make sure that the caller remembered to use a drained section. Th=
is is
      * important to avoid graph changes between the recursive queuing he=
re and
@@ -2966,22 +2967,11 @@ static BlockReopenQueue *bdrv_reopen_queue_child(=
BlockReopenQueue *bs_queue,
     /*
      * Precedence of options:
      * 1. Explicitly passed in options (highest)
-     * 2. Set in flags (only for top level)
-     * 3. Retained from explicitly set options of bs
-     * 4. Inherited from parent node
-     * 5. Retained from effective options of bs
+     * 2. Retained from explicitly set options of bs
+     * 3. Inherited from parent node
+     * 4. Retained from effective options of bs
      */
=20
-    if (!parent_options) {
-        /*
-         * Any setting represented by flags is always updated. If the
-         * corresponding QDict option is set, it takes precedence. Other=
wise
-         * the flag is translated into a QDict option. The old setting o=
f bs is
-         * not considered.
-         */
-        update_options_from_flags(options, flags);
-    }
-
     /* Old explicitly set values (don't overwrite by inherited value) */
     if (bs_entry) {
         old_options =3D qdict_clone_shallow(bs_entry->state.explicit_opt=
ions);
@@ -2995,16 +2985,10 @@ static BlockReopenQueue *bdrv_reopen_queue_child(=
BlockReopenQueue *bs_queue,
=20
     /* Inherit from parent node */
     if (parent_options) {
-        QemuOpts *opts;
-        QDict *options_copy;
-        assert(!flags);
+        flags =3D 0;
         role->inherit_options(&flags, options, parent_flags, parent_opti=
ons);
-        options_copy =3D qdict_clone_shallow(options);
-        opts =3D qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_ab=
ort);
-        qemu_opts_absorb_qdict(opts, options_copy, NULL);
-        update_flags_from_options(&flags, opts);
-        qemu_opts_del(opts);
-        qobject_unref(options_copy);
+    } else {
+        flags =3D bdrv_get_flags(bs);
     }
=20
     /* Old values are used for options that aren't set yet */
@@ -3012,6 +2996,14 @@ static BlockReopenQueue *bdrv_reopen_queue_child(B=
lockReopenQueue *bs_queue,
     bdrv_join_options(bs, options, old_options);
     qobject_unref(old_options);
=20
+    /* We have the final set of options so let's update the flags */
+    options_copy =3D qdict_clone_shallow(options);
+    opts =3D qemu_opts_create(&bdrv_runtime_opts, NULL, 0, &error_abort)=
;
+    qemu_opts_absorb_qdict(opts, options_copy, NULL);
+    update_flags_from_options(&flags, opts);
+    qemu_opts_del(opts);
+    qobject_unref(options_copy);
+
     /* bdrv_open_inherit() sets and clears some additional flags interna=
lly */
     flags &=3D ~BDRV_O_PROTOCOL;
     if (flags & BDRV_O_RDWR) {
@@ -3051,7 +3043,7 @@ static BlockReopenQueue *bdrv_reopen_queue_child(Bl=
ockReopenQueue *bs_queue,
         qdict_extract_subqdict(options, &new_child_options, child_key_do=
t);
         g_free(child_key_dot);
=20
-        bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options, =
0,
+        bdrv_reopen_queue_child(bs_queue, child->bs, new_child_options,
                                 child->role, options, flags);
     }
=20
@@ -3062,9 +3054,7 @@ BlockReopenQueue *bdrv_reopen_queue(BlockReopenQueu=
e *bs_queue,
                                     BlockDriverState *bs,
                                     QDict *options)
 {
-    int flags =3D bdrv_get_flags(bs);
-    return bdrv_reopen_queue_child(bs_queue, bs, options, flags,
-                                   NULL, NULL, 0);
+    return bdrv_reopen_queue_child(bs_queue, bs, options, NULL, NULL, 0)=
;
 }
=20
 /*
--=20
2.19.2
