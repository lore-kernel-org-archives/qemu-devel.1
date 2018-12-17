Received: from eggs.gnu.org ([2001:4830:134:3::10]:33621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cj-0007Ck-JV
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1ci-0006GG-Oc
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:29 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:31 +0100
Message-Id: <20181217224348.14922-15-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 14/31] block: Add bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

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
index a1e1b59e9c..2e33535465 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -489,6 +489,7 @@ char *bdrv_get_full_backing_filename(BlockDriverState=
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
index ccddf4858a..3257bc2c9d 100644
--- a/block.c
+++ b/block.c
@@ -5497,6 +5497,33 @@ void bdrv_refresh_filename(BlockDriverState *bs)
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
2.19.2
