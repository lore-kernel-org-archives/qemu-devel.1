Received: from eggs.gnu.org ([2001:4830:134:3::10]:55624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRe1C-0008BS-4e
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:07:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gRe1A-0007H7-37
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 09:07:14 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 27 Nov 2018 15:06:38 +0100
Message-Id: <20181127140640.24830-2-kwolf@redhat.com>
In-Reply-To: <20181127140640.24830-1-kwolf@redhat.com>
References: <20181127140640.24830-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] block: Don't inactivate children before
 parents
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

bdrv_child_cb_inactivate() asserts that parents are already inactive
when children get inactivated. This precondition is necessary because
parents could still issue requests in their inactivation code.

When block nodes are created individually with -blockdev, all of them
are monitor owned and will be returned by bdrv_next() in an undefined
order (in practice, in the order of their creation, which is usually
children before parents), which obviously fails the assertion:

qemu: block.c:899: bdrv_child_cb_inactivate: Assertion `bs->open_flags & =
BDRV_O_INACTIVE' failed.

This patch fixes the ordering by skipping nodes with still active
parents in bdrv_inactivate_recurse() because we know that they will be
covered by recursion when the last active parent becomes inactive.

With the correct parents-before-children ordering, we also got rid of
the reason why commit aad0b7a0bfb introduced two passes, so we can go
back to a single-pass recursion. This is necessary so we can rely on the
BDRV_O_INACTIVE flag to skip nodes with active parents (the flag used
to be set only in pass 2, so we would always skip non-root nodes in
pass 1 because all parents would still be considered active; setting the
flag in pass 1 would mean, that we never skip anything in pass 2 because
all parents are already considered inactive).

Because of the change to single pass, this patch is best reviewed with
whitespace changes ignored.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 84 ++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 53 insertions(+), 31 deletions(-)

diff --git a/block.c b/block.c
index 5ba3435f8f..811239ca23 100644
--- a/block.c
+++ b/block.c
@@ -4612,45 +4612,68 @@ void bdrv_invalidate_cache_all(Error **errp)
     }
 }
=20
-static int bdrv_inactivate_recurse(BlockDriverState *bs,
-                                   bool setting_flag)
+static bool bdrv_has_bds_parent(BlockDriverState *bs, bool only_active)
+{
+    BdrvChild *parent;
+
+    QLIST_FOREACH(parent, &bs->parents, next_parent) {
+        if (parent->role->parent_is_bds) {
+            BlockDriverState *parent_bs =3D parent->opaque;
+            if (!only_active || !(parent_bs->open_flags & BDRV_O_INACTIV=
E)) {
+                return true;
+            }
+        }
+    }
+
+    return false;
+}
+
+static int bdrv_inactivate_recurse(BlockDriverState *bs)
 {
     BdrvChild *child, *parent;
+    uint64_t perm, shared_perm;
     int ret;
=20
     if (!bs->drv) {
         return -ENOMEDIUM;
     }
=20
-    if (!setting_flag && bs->drv->bdrv_inactivate) {
+    /* Make sure that we don't inactivate a child before its parent.
+     * It will be covered by recursion from the yet active parent. */
+    if (bdrv_has_bds_parent(bs, true)) {
+        return 0;
+    }
+
+    assert(!(bs->open_flags & BDRV_O_INACTIVE));
+
+    /* Inactivate this node */
+    if (bs->drv->bdrv_inactivate) {
         ret =3D bs->drv->bdrv_inactivate(bs);
         if (ret < 0) {
             return ret;
         }
     }
=20
-    if (setting_flag && !(bs->open_flags & BDRV_O_INACTIVE)) {
-        uint64_t perm, shared_perm;
-
-        QLIST_FOREACH(parent, &bs->parents, next_parent) {
-            if (parent->role->inactivate) {
-                ret =3D parent->role->inactivate(parent);
-                if (ret < 0) {
-                    return ret;
-                }
+    QLIST_FOREACH(parent, &bs->parents, next_parent) {
+        if (parent->role->inactivate) {
+            ret =3D parent->role->inactivate(parent);
+            if (ret < 0) {
+                return ret;
             }
         }
+    }
=20
-        bs->open_flags |=3D BDRV_O_INACTIVE;
+    bs->open_flags |=3D BDRV_O_INACTIVE;
+
+    /* Update permissions, they may differ for inactive nodes */
+    bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
+    bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, &error_abort);
+    bdrv_set_perm(bs, perm, shared_perm);
=20
-        /* Update permissions, they may differ for inactive nodes */
-        bdrv_get_cumulative_perm(bs, &perm, &shared_perm);
-        bdrv_check_perm(bs, NULL, perm, shared_perm, NULL, &error_abort)=
;
-        bdrv_set_perm(bs, perm, shared_perm);
-    }
=20
+    /* Recursively inactivate children */
     QLIST_FOREACH(child, &bs->children, next) {
-        ret =3D bdrv_inactivate_recurse(child->bs, setting_flag);
+        ret =3D bdrv_inactivate_recurse(child->bs);
         if (ret < 0) {
             return ret;
         }
@@ -4664,7 +4687,6 @@ int bdrv_inactivate_all(void)
     BlockDriverState *bs =3D NULL;
     BdrvNextIterator it;
     int ret =3D 0;
-    int pass;
     GSList *aio_ctxs =3D NULL, *ctx;
=20
     for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
@@ -4676,17 +4698,17 @@ int bdrv_inactivate_all(void)
         }
     }
=20
-    /* We do two passes of inactivation. The first pass calls to drivers=
'
-     * .bdrv_inactivate callbacks recursively so all cache is flushed to=
 disk;
-     * the second pass sets the BDRV_O_INACTIVE flag so that no further =
write
-     * is allowed. */
-    for (pass =3D 0; pass < 2; pass++) {
-        for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
-            ret =3D bdrv_inactivate_recurse(bs, pass);
-            if (ret < 0) {
-                bdrv_next_cleanup(&it);
-                goto out;
-            }
+    for (bs =3D bdrv_first(&it); bs; bs =3D bdrv_next(&it)) {
+        /* Nodes with BDS parents are covered by recursion from the last
+         * parent that gets inactivated. Don't inactivate them a second
+         * time if that has already happened. */
+        if (bdrv_has_bds_parent(bs, false)) {
+            continue;
+        }
+        ret =3D bdrv_inactivate_recurse(bs);
+        if (ret < 0) {
+            bdrv_next_cleanup(&it);
+            goto out;
         }
     }
=20
--=20
2.19.1
