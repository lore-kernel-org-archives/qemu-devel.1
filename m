Received: from eggs.gnu.org ([2001:4830:134:3::10]:35197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsPM-0008Qh-9q
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:11:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsPH-00079X-Ve
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:11:08 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 20 Nov 2017 21:09:50 +0100
Message-Id: <20171120201004.14999-12-mreitz@redhat.com>
In-Reply-To: <20171120201004.14999-1-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 for-2.12 11/25] block: Add bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>

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
 block.c                   | 26 ++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 3e2ea6c879..a053a27148 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -485,6 +485,7 @@ char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp);
 char *bdrv_get_full_backing_filename_from_filename(const char *backed,
                                                    const char *backing,
                                                    Error **errp);
+char *bdrv_dirname(BlockDriverState *bs, Error **errp);
 
 int path_has_protocol(const char *path);
 int path_is_absolute(const char *path);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 5e9734d8b5..c07882962d 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -135,6 +135,13 @@ struct BlockDriver {
 
     void (*bdrv_refresh_filename)(BlockDriverState *bs, QDict *options);
 
+    /*
+     * Returns an allocated string which is the directory name of this BDS: It
+     * will be used to make relative filenames absolute by prepending this
+     * function's return value to them.
+     */
+    char *(*bdrv_dirname)(BlockDriverState *bs, Error **errp);
+
     /* aio */
     BlockAIOCB *(*bdrv_aio_readv)(BlockDriverState *bs,
         int64_t sector_num, QEMUIOVector *qiov, int nb_sectors,
diff --git a/block.c b/block.c
index ecea78dae0..20e45c85c6 100644
--- a/block.c
+++ b/block.c
@@ -5098,6 +5098,32 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     }
 }
 
+char *bdrv_dirname(BlockDriverState *bs, Error **errp)
+{
+    BlockDriver *drv = bs->drv;
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
+    if (bs->exact_filename[0] != '\0') {
+        return path_combine(bs->exact_filename, "");
+    }
+
+    error_setg(errp, "Cannot generate a base directory for %s nodes",
+               drv->format_name);
+    return NULL;
+}
+
 /*
  * Hot add/remove a BDS's child. So the user can take a child offline when
  * it is broken and take a new child online
-- 
2.13.6
