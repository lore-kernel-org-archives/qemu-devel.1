Received: from eggs.gnu.org ([209.51.188.92]:45548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hKLdL-00067H-FJ
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 07:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hKLdJ-0005N7-Sb
	for qemu-devel@nongnu.org; Sat, 27 Apr 2019 07:36:43 -0400
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Sat, 27 Apr 2019 13:36:25 +0200
Message-Id: <20190427113625.46594-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] block/rbd: add preallocation support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>

This patch adds the support of preallocation (off/full) for the RBD
block driver.
If available, we use rbd_writesame() to quickly fill the image when
full preallocation is required.

Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 block/rbd.c          | 149 ++++++++++++++++++++++++++++++++++++++-----
 qapi/block-core.json |   4 +-
 2 files changed, 136 insertions(+), 17 deletions(-)

diff --git a/block/rbd.c b/block/rbd.c
index 0c549c9935..29dd1bb040 100644
--- a/block/rbd.c
+++ b/block/rbd.c
@@ -13,6 +13,7 @@
=20
 #include "qemu/osdep.h"
=20
+#include "qemu/units.h"
 #include <rbd/librbd.h>
 #include "qapi/error.h"
 #include "qemu/error-report.h"
@@ -331,6 +332,110 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t o=
ffs)
     }
 }
=20
+static int qemu_rbd_do_truncate(rbd_image_t image, int64_t offset,
+                                PreallocMode prealloc, Error **errp)
+{
+    uint64_t current_length;
+    char *buf =3D NULL;
+    int ret;
+
+    ret =3D rbd_get_size(image, &current_length);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Failed to get file length");
+        goto out;
+    }
+
+    if (current_length > offset && prealloc !=3D PREALLOC_MODE_OFF) {
+        error_setg(errp, "Cannot use preallocation for shrinking files")=
;
+        ret =3D -ENOTSUP;
+        goto out;
+    }
+
+    switch (prealloc) {
+    case PREALLOC_MODE_FULL: {
+        uint64_t current_offset =3D current_length;
+        int buf_size =3D 64 * KiB;
+        ssize_t bytes;
+
+        buf =3D g_malloc(buf_size);
+        /*
+         * Some versions of rbd_writesame() discards writes of buffers w=
ith
+         * all zeroes. In order to avoid this behaviour, we set the firs=
t byte
+         * to one.
+         */
+        buf[0] =3D 1;
+
+        ret =3D rbd_resize(image, offset);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to resize file");
+            goto out;
+        }
+
+#ifdef LIBRBD_SUPPORTS_WRITESAME
+        while (offset - current_offset > buf_size) {
+            /*
+             * rbd_writesame() supports only request where the size of t=
he
+             * operation is multiple of buffer size and it must be less =
or
+             * equal to INT_MAX.
+             */
+            bytes =3D MIN(offset - current_offset, INT_MAX);
+            bytes -=3D bytes % buf_size;
+
+            bytes =3D rbd_writesame(image, current_offset, bytes, buf, b=
uf_size,
+                                  0);
+            if (bytes < 0) {
+                ret =3D bytes;
+                error_setg_errno(errp, -ret,
+                                 "Failed to write for preallocation");
+                goto out;
+            }
+
+            current_offset +=3D bytes;
+        }
+#endif /* LIBRBD_SUPPORTS_WRITESAME */
+
+        while (current_offset < offset) {
+            bytes =3D rbd_write(image, current_offset,
+                              MIN(offset - current_offset, buf_size), bu=
f);
+            if (bytes < 0) {
+                ret =3D bytes;
+                error_setg_errno(errp, -ret,
+                                 "Failed to write for preallocation");
+                goto out;
+            }
+
+            current_offset +=3D bytes;
+        }
+
+        ret =3D rbd_flush(image);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to flush the file");
+            goto out;
+        }
+
+        break;
+    }
+    case PREALLOC_MODE_OFF:
+        ret =3D rbd_resize(image, offset);
+        if (ret < 0) {
+            error_setg_errno(errp, -ret, "Failed to resize file");
+            goto out;
+        }
+        break;
+    default:
+        error_setg(errp, "Unsupported preallocation mode: %s",
+                   PreallocMode_str(prealloc));
+        ret =3D -ENOTSUP;
+        goto out;
+    }
+
+    ret =3D 0;
+
+out:
+    g_free(buf);
+    return ret;
+}
+
 static QemuOptsList runtime_opts =3D {
     .name =3D "rbd",
     .head =3D QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
@@ -376,6 +481,7 @@ static int qemu_rbd_do_create(BlockdevCreateOptions *=
options,
     BlockdevCreateOptionsRbd *opts =3D &options->u.rbd;
     rados_t cluster;
     rados_ioctx_t io_ctx;
+    rbd_image_t image;
     int obj_order =3D 0;
     int ret;
=20
@@ -404,13 +510,21 @@ static int qemu_rbd_do_create(BlockdevCreateOptions=
 *options,
         return ret;
     }
=20
-    ret =3D rbd_create(io_ctx, opts->location->image, opts->size, &obj_o=
rder);
+    ret =3D rbd_create(io_ctx, opts->location->image, 0, &obj_order);
     if (ret < 0) {
         error_setg_errno(errp, -ret, "error rbd create");
         goto out;
     }
=20
-    ret =3D 0;
+    ret =3D rbd_open(io_ctx, opts->location->image, &image, NULL);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "error rbd open");
+        goto out;
+    }
+
+    ret =3D qemu_rbd_do_truncate(image, opts->size, opts->preallocation,=
 errp);
+
+    rbd_close(image);
 out:
     rados_ioctx_destroy(io_ctx);
     rados_shutdown(cluster);
@@ -431,6 +545,7 @@ static int coroutine_fn qemu_rbd_co_create_opts(const=
 char *filename,
     BlockdevOptionsRbd *loc;
     Error *local_err =3D NULL;
     const char *keypairs, *password_secret;
+    char *prealloc;
     QDict *options =3D NULL;
     int ret =3D 0;
=20
@@ -449,6 +564,16 @@ static int coroutine_fn qemu_rbd_co_create_opts(cons=
t char *filename,
                                                    BLOCK_OPT_CLUSTER_SIZ=
E, 0);
     rbd_opts->has_cluster_size =3D (rbd_opts->cluster_size !=3D 0);
=20
+    prealloc =3D qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
+    rbd_opts->preallocation =3D qapi_enum_parse(&PreallocMode_lookup, pr=
ealloc,
+                                              PREALLOC_MODE_OFF, &local_=
err);
+    g_free(prealloc);
+    if (local_err) {
+        ret =3D -EINVAL;
+        error_propagate(errp, local_err);
+        goto exit;
+    }
+
     options =3D qdict_new();
     qemu_rbd_parse_filename(filename, options, &local_err);
     if (local_err) {
@@ -1052,21 +1177,8 @@ static int coroutine_fn qemu_rbd_co_truncate(Block=
DriverState *bs,
                                              Error **errp)
 {
     BDRVRBDState *s =3D bs->opaque;
-    int r;
-
-    if (prealloc !=3D PREALLOC_MODE_OFF) {
-        error_setg(errp, "Unsupported preallocation mode '%s'",
-                   PreallocMode_str(prealloc));
-        return -ENOTSUP;
-    }
-
-    r =3D rbd_resize(s->image, offset);
-    if (r < 0) {
-        error_setg_errno(errp, -r, "Failed to resize file");
-        return r;
-    }
=20
-    return 0;
+    return qemu_rbd_do_truncate(s->image, offset, prealloc, errp);
 }
=20
 static int qemu_rbd_snap_create(BlockDriverState *bs,
@@ -1219,6 +1331,11 @@ static QemuOptsList qemu_rbd_create_opts =3D {
             .type =3D QEMU_OPT_SIZE,
             .help =3D "RBD object size"
         },
+        {
+            .name =3D BLOCK_OPT_PREALLOC,
+            .type =3D QEMU_OPT_STRING,
+            .help =3D "Preallocation mode (allowed values: off, full)"
+        },
         {
             .name =3D "password-secret",
             .type =3D QEMU_OPT_STRING,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 7ccbfff9d0..db25a4065b 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -4277,13 +4277,15 @@
 #                   point to a snapshot.
 # @size             Size of the virtual disk in bytes
 # @cluster-size     RBD object size
+# @preallocation    Preallocation mode (allowed values: off, full)
 #
 # Since: 2.12
 ##
 { 'struct': 'BlockdevCreateOptionsRbd',
   'data': { 'location':         'BlockdevOptionsRbd',
             'size':             'size',
-            '*cluster-size' :   'size' } }
+            '*cluster-size' :   'size',
+            '*preallocation':   'PreallocMode' } }
=20
 ##
 # @BlockdevVmdkSubformat:
--=20
2.20.1
