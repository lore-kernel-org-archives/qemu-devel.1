Received: from eggs.gnu.org ([2001:4830:134:3::10]:60033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfq-0000m6-No
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfp-0007JO-Kx
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:54 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:05:56 +0100
Message-Id: <20181112170603.23986-8-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/14] file-posix: Drop s->lock_fd
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

From: Fam Zheng <famz@redhat.com>

The lock_fd field is not strictly necessary because transferring locked
bytes from old fd to the new one shouldn't fail anyway. This spares the
user one fd per image.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 1b4ff8de00..58c86a01ea 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -142,7 +142,6 @@ do { \
=20
 typedef struct BDRVRawState {
     int fd;
-    int lock_fd;
     bool use_lock;
     int type;
     int open_flags;
@@ -153,7 +152,7 @@ typedef struct BDRVRawState {
     uint64_t shared_perm;
=20
     /* The perms bits whose corresponding bytes are already locked in
-     * s->lock_fd. */
+     * s->fd. */
     uint64_t locked_perm;
     uint64_t locked_shared_perm;
=20
@@ -551,18 +550,6 @@ static int raw_open_common(BlockDriverState *bs, QDi=
ct *options,
     }
     s->fd =3D fd;
=20
-    s->lock_fd =3D -1;
-    if (s->use_lock) {
-        fd =3D qemu_open(filename, s->open_flags);
-        if (fd < 0) {
-            ret =3D -errno;
-            error_setg_errno(errp, errno, "Could not open '%s' for locki=
ng",
-                             filename);
-            qemu_close(s->fd);
-            goto fail;
-        }
-        s->lock_fd =3D fd;
-    }
     s->perm =3D 0;
     s->shared_perm =3D BLK_PERM_ALL;
=20
@@ -823,15 +810,13 @@ static int raw_handle_perm_lock(BlockDriverState *b=
s,
         return 0;
     }
=20
-    assert(s->lock_fd > 0);
-
     switch (op) {
     case RAW_PL_PREPARE:
-        ret =3D raw_apply_lock_bytes(s, s->lock_fd, s->perm | new_perm,
+        ret =3D raw_apply_lock_bytes(s, s->fd, s->perm | new_perm,
                                    ~s->shared_perm | ~new_shared,
                                    false, errp);
         if (!ret) {
-            ret =3D raw_check_lock_bytes(s->lock_fd, new_perm, new_share=
d, errp);
+            ret =3D raw_check_lock_bytes(s->fd, new_perm, new_shared, er=
rp);
             if (!ret) {
                 return 0;
             }
@@ -842,7 +827,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         op =3D RAW_PL_ABORT;
         /* fall through to unlock bytes. */
     case RAW_PL_ABORT:
-        raw_apply_lock_bytes(s, s->lock_fd, s->perm, ~s->shared_perm,
+        raw_apply_lock_bytes(s, s->fd, s->perm, ~s->shared_perm,
                              true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it ca=
nnot
@@ -852,7 +837,7 @@ static int raw_handle_perm_lock(BlockDriverState *bs,
         }
         break;
     case RAW_PL_COMMIT:
-        raw_apply_lock_bytes(s, s->lock_fd, new_perm, ~new_shared,
+        raw_apply_lock_bytes(s, s->fd, new_perm, ~new_shared,
                              true, &local_err);
         if (local_err) {
             /* Theoretically the above call only unlocks bytes and it ca=
nnot
@@ -967,10 +952,18 @@ static void raw_reopen_commit(BDRVReopenState *stat=
e)
 {
     BDRVRawReopenState *rs =3D state->opaque;
     BDRVRawState *s =3D state->bs->opaque;
+    Error *local_err =3D NULL;
=20
     s->check_cache_dropped =3D rs->check_cache_dropped;
     s->open_flags =3D rs->open_flags;
=20
+    /* Copy locks to the new fd before closing the old one. */
+    raw_apply_lock_bytes(NULL, rs->fd, s->locked_perm,
+                         ~s->locked_shared_perm, false, &local_err);
+    if (local_err) {
+        /* shouldn't fail in a sane host, but report it just in case. */
+        error_report_err(local_err);
+    }
     qemu_close(s->fd);
     s->fd =3D rs->fd;
=20
@@ -1963,10 +1956,6 @@ static void raw_close(BlockDriverState *bs)
         qemu_close(s->fd);
         s->fd =3D -1;
     }
-    if (s->lock_fd >=3D 0) {
-        qemu_close(s->lock_fd);
-        s->lock_fd =3D -1;
-    }
 }
=20
 /**
--=20
2.19.1
