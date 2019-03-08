Received: from eggs.gnu.org ([209.51.188.92]:42696)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2HZn-0005g8-PP
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:38:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h2HZl-0001Q3-Qw
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 10:38:23 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  8 Mar 2019 16:37:55 +0100
Message-Id: <20190308153757.25794-7-kwolf@redhat.com>
In-Reply-To: <20190308153757.25794-1-kwolf@redhat.com>
References: <20190308153757.25794-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 6/8] file-posix: Lock new fd in
 raw_reopen_prepare()
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

There is no reason why we can take locks on the new file descriptor only
in raw_reopen_commit() where error handling isn't possible any more.
Instead, we can already do this in raw_reopen_prepare().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/file-posix.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/block/file-posix.c b/block/file-posix.c
index 6aaee1df16..932cc8e58c 100644
--- a/block/file-posix.c
+++ b/block/file-posix.c
@@ -906,7 +906,7 @@ static int raw_reopen_prepare(BDRVReopenState *state,
     BDRVRawState *s;
     BDRVRawReopenState *rs;
     QemuOpts *opts;
-    int ret =3D 0;
+    int ret;
     Error *local_err =3D NULL;
=20
     assert(state !=3D NULL);
@@ -947,14 +947,27 @@ static int raw_reopen_prepare(BDRVReopenState *stat=
e,
     if (rs->fd !=3D -1) {
         raw_probe_alignment(state->bs, rs->fd, &local_err);
         if (local_err) {
-            qemu_close(rs->fd);
-            rs->fd =3D -1;
             error_propagate(errp, local_err);
             ret =3D -EINVAL;
+            goto out_fd;
+        }
+
+        /* Copy locks to the new fd */
+        ret =3D raw_apply_lock_bytes(NULL, rs->fd, s->locked_perm,
+                                   s->locked_shared_perm, false, errp);
+        if (ret < 0) {
+            ret =3D -EINVAL;
+            goto out_fd;
         }
     }
=20
     s->reopen_state =3D state;
+    ret =3D 0;
+out_fd:
+    if (ret < 0) {
+        qemu_close(rs->fd);
+        rs->fd =3D -1;
+    }
 out:
     qemu_opts_del(opts);
     return ret;
@@ -964,18 +977,10 @@ static void raw_reopen_commit(BDRVReopenState *stat=
e)
 {
     BDRVRawReopenState *rs =3D state->opaque;
     BDRVRawState *s =3D state->bs->opaque;
-    Error *local_err =3D NULL;
=20
     s->check_cache_dropped =3D rs->check_cache_dropped;
     s->open_flags =3D rs->open_flags;
=20
-    /* Copy locks to the new fd before closing the old one. */
-    raw_apply_lock_bytes(NULL, rs->fd, s->locked_perm,
-                         s->locked_shared_perm, false, &local_err);
-    if (local_err) {
-        /* shouldn't fail in a sane host, but report it just in case. */
-        error_report_err(local_err);
-    }
     qemu_close(s->fd);
     s->fd =3D rs->fd;
=20
--=20
2.20.1
