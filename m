Received: from eggs.gnu.org ([2001:4830:134:3::10]:51772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVEhh-0006yH-Fx
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:53:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gVEhg-0004aN-9O
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 06:53:57 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  7 Dec 2018 12:53:39 +0100
Message-Id: <20181207115343.6747-2-kwolf@redhat.com>
In-Reply-To: <20181207115343.6747-1-kwolf@redhat.com>
References: <20181207115343.6747-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 1/5] vmdk: Refactor vmdk_create_extent
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

From: Fam Zheng <famz@redhat.com>

The extracted vmdk_init_extent takes a BlockBackend object and
initializes the format metadata. It is the common part between "qemu-img
create" and "blockdev-create".

Add a "BlockBackend *pbb" parameter to vmdk_create_extent, to return the
opened BB to the caller in the next patch.

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vmdk.c | 69 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 43 insertions(+), 26 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index 2c9e86d98f..32fc2c84b3 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1741,35 +1741,17 @@ static int coroutine_fn vmdk_co_pwrite_zeroes(Blo=
ckDriverState *bs,
     return ret;
 }
=20
-static int vmdk_create_extent(const char *filename, int64_t filesize,
-                              bool flat, bool compress, bool zeroed_grai=
n,
-                              QemuOpts *opts, Error **errp)
+static int vmdk_init_extent(BlockBackend *blk,
+                            int64_t filesize, bool flat,
+                            bool compress, bool zeroed_grain,
+                            Error **errp)
 {
     int ret, i;
-    BlockBackend *blk =3D NULL;
     VMDK4Header header;
-    Error *local_err =3D NULL;
     uint32_t tmp, magic, grains, gd_sectors, gt_size, gt_count;
     uint32_t *gd_buf =3D NULL;
     int gd_buf_size;
=20
-    ret =3D bdrv_create_file(filename, opts, &local_err);
-    if (ret < 0) {
-        error_propagate(errp, local_err);
-        goto exit;
-    }
-
-    blk =3D blk_new_open(filename, NULL, NULL,
-                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
-                       &local_err);
-    if (blk =3D=3D NULL) {
-        error_propagate(errp, local_err);
-        ret =3D -EIO;
-        goto exit;
-    }
-
-    blk_set_allow_write_beyond_eof(blk, true);
-
     if (flat) {
         ret =3D blk_truncate(blk, filesize, PREALLOC_MODE_OFF, errp);
         goto exit;
@@ -1863,15 +1845,50 @@ static int vmdk_create_extent(const char *filenam=
e, int64_t filesize,
                      gd_buf, gd_buf_size, 0);
     if (ret < 0) {
         error_setg(errp, QERR_IO_ERROR);
-        goto exit;
     }
=20
     ret =3D 0;
+exit:
+    g_free(gd_buf);
+    return ret;
+}
+
+static int vmdk_create_extent(const char *filename, int64_t filesize,
+                              bool flat, bool compress, bool zeroed_grai=
n,
+                              BlockBackend **pbb,
+                              QemuOpts *opts, Error **errp)
+{
+    int ret;
+    BlockBackend *blk =3D NULL;
+    Error *local_err =3D NULL;
+
+    ret =3D bdrv_create_file(filename, opts, &local_err);
+    if (ret < 0) {
+        error_propagate(errp, local_err);
+        goto exit;
+    }
+
+    blk =3D blk_new_open(filename, NULL, NULL,
+                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
+                       &local_err);
+    if (blk =3D=3D NULL) {
+        error_propagate(errp, local_err);
+        ret =3D -EIO;
+        goto exit;
+    }
+
+    blk_set_allow_write_beyond_eof(blk, true);
+
+    ret =3D vmdk_init_extent(blk, filesize, flat, compress, zeroed_grain=
, errp);
 exit:
     if (blk) {
-        blk_unref(blk);
+        if (pbb) {
+            *pbb =3D blk;
+        } else {
+            blk_unref(blk);
+            blk =3D NULL;
+        }
     }
-    g_free(gd_buf);
     return ret;
 }
=20
@@ -2094,7 +2111,7 @@ static int coroutine_fn vmdk_co_create_opts(const c=
har *filename, QemuOpts *opts
         snprintf(ext_filename, PATH_MAX, "%s%s", path, desc_filename);
=20
         if (vmdk_create_extent(ext_filename, size,
-                               flat, compress, zeroed_grain, opts, errp)=
) {
+                               flat, compress, zeroed_grain, NULL, opts,=
 errp)) {
             ret =3D -EINVAL;
             goto exit;
         }
--=20
2.19.2
