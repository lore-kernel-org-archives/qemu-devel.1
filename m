Received: from eggs.gnu.org ([209.51.188.92]:47085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeWL-0006Kt-T0
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeWJ-0002qL-J8
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:37 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:18 +0100
Message-Id: <20190201192935.18394-15-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 14/31] block: Add bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

This function may be implemented by block drivers to derive a directory
name from a BDS. Concatenating this g_free()-able string with a relative
filename must result in a valid (not necessarily existing) filename, so
this is a function that should generally be not implemented by format
drivers, because this is protocol-specific.

If a BDS's driver does not implement this function, bdrv_dirname() will
fall through to the BDS's file if it exists. If it does not, the
exact_filename field will be used to generate a directory name.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block.h     |  1 +
 include/block/block_int.h |  7 +++++++
 block.c                   | 27 +++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 9222cce3c3..5334ba1261 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -490,6 +490,7 @@ char *bdrv_get_full_backing_filename(BlockDriverState=
 *bs, Error **errp);
 char *bdrv_get_full_backing_filename_from_filename(const char *backed,
                                                    const char *backing,
                                                    Error **errp);
+char *bdrv_dirname(BlockDriverState *bs, Error **errp);
=20
 int path_has_protocol(const char *path);
 int path_is_absolute(const char *path);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 93cd669a35..d65f80a013 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -141,6 +141,13 @@ struct BlockDriver {
=20
     void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
=20
+    /*
+     * Returns an allocated string which is the directory name of this B=
DS: It
+     * will be used to make relative filenames absolute by prepending th=
is
+     * function's return value to them.
+     */
+    char *(*bdrv_dirname)(BlockDriverState *bs, Error **errp);
+
     /* aio */
     BlockAIOCB *(*bdrv_aio_preadv)(BlockDriverState *bs,
         uint64_t offset, uint64_t bytes, QEMUIOVector *qiov, int flags,
diff --git a/block.c b/block.c
index d30389ff35..dba05ee349 100644
--- a/block.c
+++ b/block.c
@@ -5654,6 +5654,33 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     }
 }
=20
+char *bdrv_dirname(BlockDriverState *bs, Error **errp)
+{
+    BlockDriver *drv =3D bs->drv;
+
+    if (!drv) {
+        error_setg(errp, "Node '%s' is ejected", bs->node_name);
+        return NULL;
+    }
+
+    if (drv->bdrv_dirname) {
+        return drv->bdrv_dirname(bs, errp);
+    }
+
+    if (bs->file) {
+        return bdrv_dirname(bs->file->bs, errp);
+    }
+
+    bdrv_refresh_filename(bs);
+    if (bs->exact_filename[0] !=3D '\0') {
+        return path_combine(bs->exact_filename, "");
+    }
+
+    error_setg(errp, "Cannot generate a base directory for %s nodes",
+               drv->format_name);
+    return NULL;
+}
+
 /*
  * Hot add/remove a BDS's child. So the user can take a child offline wh=
en
  * it is broken and take a new child online
--=20
2.20.1
