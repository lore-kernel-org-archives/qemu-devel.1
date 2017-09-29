Received: from eggs.gnu.org ([2001:4830:134:3::10]:47052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyZ3-0001Ks-9D
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:55:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyZ2-0003OV-E7
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:55:01 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 29 Sep 2017 18:53:32 +0200
Message-Id: <20170929165347.29658-11-mreitz@redhat.com>
In-Reply-To: <20170929165347.29658-1-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 10/25] block: Add bdrv_dirname()
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>, John Snow <jsnow@redhat.com>
List-ID: <qemu-devel.nongnu.org>

This function may be implemented by block drivers to derive a directory
name from a BDS. Concatenating this g_free()-able string with a relative
filename must result in a valid (not necessarily existing) filename, so
this is a function that should generally be not implemented by format
drivers, because this is protocol-specific.

If a BDS's driver does not implement this function, bdrv_dirname() will
fall through to the BDS's file if it exists. If it does not, the
exact_filename field will be used to generate a directory name.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 include/block/block.h     |  1 +
 include/block/block_int.h |  7 +++++++
 block.c                   | 26 ++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/block/block.h b/include/block/block.h
index 65b15ecd18..34422e87e7 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -486,6 +486,7 @@ char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp);
 char *bdrv_get_full_backing_filename_from_filename(const char *backed,
                                                    const char *backing,
                                                    Error **errp);
+char *bdrv_dirname(BlockDriverState *bs, Error **errp);
 
 int path_has_protocol(const char *path);
 int path_is_absolute(const char *path);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 2b816ec601..3a71be3734 100644
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
index 17579125de..d2ef7cbecb 100644
--- a/block.c
+++ b/block.c
@@ -5018,6 +5018,32 @@ void bdrv_refresh_filename(BlockDriverState *bs)
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
