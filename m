Received: from eggs.gnu.org ([209.51.188.92]:42654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2HZg-0005Zu-An
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:38:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2HZf-00015S-BJ
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:38:16 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 16:37:53 +0100
Message-Id: <20190308153757.25794-5-kwolf@redhat.com>
In-Reply-To: <20190308153757.25794-1-kwolf@redhat.com>
References: <20190308153757.25794-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 4/8] file-posix: Factor out
 raw_reconfigure_getfd()
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

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 107 ++++++++++++++++++++++++++-------------------
 1 file changed, 62 insertions(+), 45 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index ba6ab62a38..ae57ba1fc6 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -842,6 +842,62 @@ static int raw_handle_perm_lock(BlockDriverState *bs=
,
     return ret;
 }
=20
+static int raw_reconfigure_getfd(BlockDriverState *bs, int flags,
+                                 int *open_flags, Error **errp)
+{
+    BDRVRawState *s =3D bs->opaque;
+    int fd =3D -1;
+    int ret;
+    int fcntl_flags =3D O_APPEND | O_NONBLOCK;
+#ifdef O_NOATIME
+    fcntl_flags |=3D O_NOATIME;
+#endif
+
+    *open_flags =3D 0;
+    if (s->type =3D=3D FTYPE_CD) {
+        *open_flags |=3D O_NONBLOCK;
+    }
+
+    raw_parse_flags(flags, open_flags);
+
+#ifdef O_ASYNC
+    /* Not all operating systems have O_ASYNC, and those that don't
+     * will not let us track the state into rs->open_flags (typically
+     * you achieve the same effect with an ioctl, for example I_SETSIG
+     * on Solaris). But we do not use O_ASYNC, so that's fine.
+     */
+    assert((s->open_flags & O_ASYNC) =3D=3D 0);
+#endif
+
+    if ((*open_flags & ~fcntl_flags) =3D=3D (s->open_flags & ~fcntl_flag=
s)) {
+        /* dup the original fd */
+        fd =3D qemu_dup(s->fd);
+        if (fd >=3D 0) {
+            ret =3D fcntl_setfl(fd, *open_flags);
+            if (ret) {
+                qemu_close(fd);
+                fd =3D -1;
+            }
+        }
+    }
+
+    /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open()=
 */
+    if (fd =3D=3D -1) {
+        const char *normalized_filename =3D bs->filename;
+        ret =3D raw_normalize_devicepath(&normalized_filename, errp);
+        if (ret >=3D 0) {
+            assert(!(*open_flags & O_CREAT));
+            fd =3D qemu_open(normalized_filename, *open_flags);
+            if (fd =3D=3D -1) {
+                error_setg_errno(errp, errno, "Could not reopen file");
+                return -1;
+            }
+        }
+    }
+
+    return fd;
+}
+
 static int raw_reopen_prepare(BDRVReopenState *state,
                               BlockReopenQueue *queue, Error **errp)
 {
@@ -858,7 +914,6 @@ static int raw_reopen_prepare(BDRVReopenState *state,
=20
     state->opaque =3D g_new0(BDRVRawReopenState, 1);
     rs =3D state->opaque;
-    rs->fd =3D -1;
=20
     /* Handle options changes */
     opts =3D qemu_opts_create(&raw_runtime_opts, NULL, 0, &error_abort);
@@ -877,50 +932,12 @@ static int raw_reopen_prepare(BDRVReopenState *stat=
e,
      * bdrv_reopen_prepare() will detect changes and complain. */
     qemu_opts_to_qdict(opts, state->options);
=20
-    if (s->type =3D=3D FTYPE_CD) {
-        rs->open_flags |=3D O_NONBLOCK;
-    }
-
-    raw_parse_flags(state->flags, &rs->open_flags);
-
-    int fcntl_flags =3D O_APPEND | O_NONBLOCK;
-#ifdef O_NOATIME
-    fcntl_flags |=3D O_NOATIME;
-#endif
-
-#ifdef O_ASYNC
-    /* Not all operating systems have O_ASYNC, and those that don't
-     * will not let us track the state into rs->open_flags (typically
-     * you achieve the same effect with an ioctl, for example I_SETSIG
-     * on Solaris). But we do not use O_ASYNC, so that's fine.
-     */
-    assert((s->open_flags & O_ASYNC) =3D=3D 0);
-#endif
-
-    if ((rs->open_flags & ~fcntl_flags) =3D=3D (s->open_flags & ~fcntl_f=
lags)) {
-        /* dup the original fd */
-        rs->fd =3D qemu_dup(s->fd);
-        if (rs->fd >=3D 0) {
-            ret =3D fcntl_setfl(rs->fd, rs->open_flags);
-            if (ret) {
-                qemu_close(rs->fd);
-                rs->fd =3D -1;
-            }
-        }
-    }
-
-    /* If we cannot use fcntl, or fcntl failed, fall back to qemu_open()=
 */
-    if (rs->fd =3D=3D -1) {
-        const char *normalized_filename =3D state->bs->filename;
-        ret =3D raw_normalize_devicepath(&normalized_filename, errp);
-        if (ret >=3D 0) {
-            assert(!(rs->open_flags & O_CREAT));
-            rs->fd =3D qemu_open(normalized_filename, rs->open_flags);
-            if (rs->fd =3D=3D -1) {
-                error_setg_errno(errp, errno, "Could not reopen file");
-                ret =3D -1;
-            }
-        }
+    rs->fd =3D raw_reconfigure_getfd(state->bs, state->flags, &rs->open_=
flags,
+                                   &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret =3D -1;
+        goto out;
     }
=20
     /* Fail already reopen_prepare() if we can't get a working O_DIRECT
--=20
2.20.1
