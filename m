Received: from eggs.gnu.org ([209.51.188.92]:37824)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3Pt-0004ls-6J
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gu3P6-0005w4-8K
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 17:53:20 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed, 13 Feb 2019 23:53:01 +0100
Message-Id: <20190213225311.17876-3-mreitz@redhat.com>
In-Reply-To: <20190213225311.17876-1-mreitz@redhat.com>
References: <20190213225311.17876-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 02/12] blockdev: Check @replaces in
 blockdev_mirror_common
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

There is no reason why the constraints we put on @replaces should be
limited to drive-mirror.  Therefore, move the sanity checks from
qmp_drive_mirror() to blockdev_mirror_common() so they apply to
blockdev-mirror as well.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 blockdev.c | 55 ++++++++++++++++++++++++++++++++----------------------
 1 file changed, 33 insertions(+), 22 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 3bab7e4f5a..22e41fb862 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3771,6 +3771,39 @@ static void blockdev_mirror_common(const char *job=
_id, BlockDriverState *bs,
         sync =3D MIRROR_SYNC_MODE_FULL;
     }
=20
+    if (has_replaces) {
+        BlockDriverState *to_replace_bs;
+        AioContext *replace_aio_context;
+        int64_t bs_size, replace_size;
+
+        bs_size =3D bdrv_getlength(bs);
+        if (bs_size < 0) {
+            error_setg_errno(errp, -bs_size, "Failed to query device's s=
ize");
+            return;
+        }
+
+        to_replace_bs =3D check_to_replace_node(bs, replaces, errp);
+        if (!to_replace_bs) {
+            return;
+        }
+
+        replace_aio_context =3D bdrv_get_aio_context(to_replace_bs);
+        aio_context_acquire(replace_aio_context);
+        replace_size =3D bdrv_getlength(to_replace_bs);
+        aio_context_release(replace_aio_context);
+
+        if (replace_size < 0) {
+            error_setg_errno(errp, -replace_size,
+                             "Failed to query the replacement node's siz=
e");
+            return;
+        }
+        if (bs_size !=3D replace_size) {
+            error_setg(errp, "cannot replace image with a mirror image o=
f "
+                             "different size");
+            return;
+        }
+    }
+
     /* pass the node name to replace to mirror start since it's loose co=
upling
      * and will allow to check whether the node still exist at mirror co=
mpletion
      */
@@ -3831,33 +3864,11 @@ void qmp_drive_mirror(DriveMirror *arg, Error **e=
rrp)
     }
=20
     if (arg->has_replaces) {
-        BlockDriverState *to_replace_bs;
-        AioContext *replace_aio_context;
-        int64_t replace_size;
-
         if (!arg->has_node_name) {
             error_setg(errp, "a node-name must be provided when replacin=
g a"
                              " named node of the graph");
             goto out;
         }
-
-        to_replace_bs =3D check_to_replace_node(bs, arg->replaces, &loca=
l_err);
-
-        if (!to_replace_bs) {
-            error_propagate(errp, local_err);
-            goto out;
-        }
-
-        replace_aio_context =3D bdrv_get_aio_context(to_replace_bs);
-        aio_context_acquire(replace_aio_context);
-        replace_size =3D bdrv_getlength(to_replace_bs);
-        aio_context_release(replace_aio_context);
-
-        if (size !=3D replace_size) {
-            error_setg(errp, "cannot replace image with a mirror image o=
f "
-                             "different size");
-            goto out;
-        }
     }
=20
     if (arg->mode =3D=3D NEW_IMAGE_MODE_ABSOLUTE_PATHS) {
--=20
2.20.1
