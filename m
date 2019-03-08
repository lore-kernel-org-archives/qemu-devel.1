Received: from eggs.gnu.org ([209.51.188.92]:42747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2HZt-0005k4-G7
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:38:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2HZr-0001d9-I9
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:38:29 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 16:37:56 +0100
Message-Id: <20190308153757.25794-8-kwolf@redhat.com>
In-Reply-To: <20190308153757.25794-1-kwolf@redhat.com>
References: <20190308153757.25794-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/8] file-posix: Prepare permission code for fd
 switching
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, eblake@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org

In order to be able to dynamically reopen the file read-only or
read-write, depending on the users that are attached, we need to be able
to switch to a different file descriptor during the permission change.

This interacts with reopen, which also creates a new file descriptor and
performs permission changes internally. In this case, the permission
change code must reuse the reopen file descriptor instead of creating a
third one.

In turn, reopen can drop its code to copy file locks to the new file
descriptor because that is now done when applying the new permissions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 91 ++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 80 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 932cc8e58c..bcfb38ec4b 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -144,6 +144,7 @@ typedef struct BDRVRawState {
     uint64_t locked_perm;
     uint64_t locked_shared_perm;
=20
+    int perm_change_fd;
     BDRVReopenState *reopen_state;
=20
 #ifdef CONFIG_XFS
@@ -845,7 +846,8 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
 }
=20
 static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
-                                 int *open_flags, Error **errp)
+                                 int *open_flags, bool force_dup,
+                                 Error **errp)
 {
     BDRVRawState *s =3D bs->opaque;
     int fd =3D -1;
@@ -871,6 +873,11 @@ static int raw_reconfigure_getfd(BlockDriverState *b=
s, int flags,
     assert((s->open_flags & O_ASYNC) =3D=3D 0);
 #endif
=20
+    if (!force_dup && *open_flags =3D=3D s->open_flags) {
+        /* We're lucky, the existing fd is fine */
+        return s->fd;
+    }
+
     if ((*open_flags & ~fcntl_flags) =3D=3D (s->open_flags & ~fcntl_flag=
s)) {
         /* dup the original fd */
         fd =3D qemu_dup(s->fd);
@@ -935,7 +942,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
     qemu_opts_to_qdict(opts, state->options);
=20
     rs->fd =3D raw_reconfigure_getfd(state->bs, state->flags, &rs->open_=
flags,
-                                   &local_err);
+                                   true, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret =3D -1;
@@ -951,14 +958,6 @@ static int raw_reopen_prepare(BDRVReopenState *state=
,
             ret =3D -EINVAL;
             goto out_fd;
         }
-
-        /* Copy locks to the new fd */
-        ret =3D raw_apply_lock_bytes(NULL, rs->fd, s->locked_perm,
-                                   s->locked_shared_perm, false, errp);
-        if (ret < 0) {
-            ret =3D -EINVAL;
-            goto out_fd;
-        }
     }
=20
     s->reopen_state =3D state;
@@ -2696,12 +2695,73 @@ static QemuOptsList raw_create_opts =3D {
 static int raw_check_perm(BlockDriverState *bs, uint64_t perm, uint64_t =
shared,
                           Error **errp)
 {
-    return raw_handle_perm_lock(bs, RAW_PL_PREPARE, perm, shared, errp);
+    BDRVRawState *s =3D bs->opaque;
+    BDRVRawReopenState *rs =3D NULL;
+    int open_flags;
+    int ret;
+
+    if (s->reopen_state) {
+        /* We already have a new file descriptor to set permissions for =
*/
+        assert(s->reopen_state->perm =3D=3D perm);
+        assert(s->reopen_state->shared_perm =3D=3D shared);
+        if (s->perm_change_fd) {
+            /* reopen may call this function several times (directly and
+             * recursively while change permissions of the parent). Igno=
re all
+             * but the first call. */
+            return 0;
+        }
+        rs =3D s->reopen_state->opaque;
+        s->perm_change_fd =3D rs->fd;
+    } else {
+        /* We may need a new fd if auto-read-only switches the mode */
+        assert(!s->perm_change_fd);
+        ret =3D raw_reconfigure_getfd(bs, bs->open_flags, &open_flags,
+                                    false, errp);
+        if (ret < 0) {
+            return ret;
+        } else if (ret !=3D s->fd) {
+            s->perm_change_fd =3D ret;
+        }
+    }
+
+    /* Prepare permissions on old fd to avoid conflicts between old and =
new,
+     * but keep everything locked that new will need. */
+    ret =3D raw_handle_perm_lock(bs, RAW_PL_PREPARE, perm, shared, errp)=
;
+    if (ret < 0) {
+        goto fail;
+    }
+
+    /* Copy locks to the new fd */
+    if (s->perm_change_fd) {
+        ret =3D raw_apply_lock_bytes(NULL, s->perm_change_fd, perm, ~sha=
red,
+                                   false, errp);
+        if (ret < 0) {
+            raw_handle_perm_lock(bs, RAW_PL_ABORT, 0, 0, NULL);
+            goto fail;
+        }
+    }
+    return 0;
+
+fail:
+    if (s->perm_change_fd && !s->reopen_state) {
+        qemu_close(s->perm_change_fd);
+    }
+    s->perm_change_fd =3D 0;
+    return ret;
 }
=20
 static void raw_set_perm(BlockDriverState *bs, uint64_t perm, uint64_t s=
hared)
 {
     BDRVRawState *s =3D bs->opaque;
+
+    /* For reopen, we have already switched to the new fd (.bdrv_set_per=
m is
+     * called after .bdrv_reopen_commit) */
+    if (s->perm_change_fd && s->fd !=3D s->perm_change_fd) {
+        qemu_close(s->fd);
+        s->fd =3D s->perm_change_fd;
+    }
+    s->perm_change_fd =3D 0;
+
     raw_handle_perm_lock(bs, RAW_PL_COMMIT, perm, shared, NULL);
     s->perm =3D perm;
     s->shared_perm =3D shared;
@@ -2709,6 +2769,15 @@ static void raw_set_perm(BlockDriverState *bs, uin=
t64_t perm, uint64_t shared)
=20
 static void raw_abort_perm_update(BlockDriverState *bs)
 {
+    BDRVRawState *s =3D bs->opaque;
+
+    /* For reopen, .bdrv_reopen_abort is called afterwards and will clos=
e
+     * the file descriptor. */
+    if (s->perm_change_fd && !s->reopen_state) {
+        qemu_close(s->perm_change_fd);
+    }
+    s->perm_change_fd =3D 0;
+
     raw_handle_perm_lock(bs, RAW_PL_ABORT, 0, 0, NULL);
 }
=20
--=20
2.20.1
