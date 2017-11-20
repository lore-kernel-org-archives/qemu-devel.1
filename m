Received: from eggs.gnu.org ([2001:4830:134:3::10]:35011)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsP3-00088F-Pi
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsP2-0006xw-Nx
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:49 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 20 Nov 2017 21:09:46 +0100
Message-Id: <20171120201004.14999-8-mreitz@redhat.com>
In-Reply-To: <20171120201004.14999-1-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 for-2.12 07/25] block:
 bdrv_get_full_backing_filename_from_...'s ret. val.
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

Make bdrv_get_full_backing_filename_from_filename() return an allocated
string instead of placing the result in a caller-provided buffer.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block.h |  7 +++----
 block.c               | 51 +++++++++++++++++++++++++++++++++++----------------
 block/vmdk.c          |  9 ++++-----
 3 files changed, 42 insertions(+), 25 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 4584893c78..46c6190414 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -483,10 +483,9 @@ void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size);
 void bdrv_get_full_backing_filename(BlockDriverState *bs,
                                     char *dest, size_t sz, Error **errp);
-void bdrv_get_full_backing_filename_from_filename(const char *backed,
-                                                  const char *backing,
-                                                  char *dest, size_t sz,
-                                                  Error **errp);
+char *bdrv_get_full_backing_filename_from_filename(const char *backed,
+                                                   const char *backing,
+                                                   Error **errp);
 
 int path_has_protocol(const char *path);
 int path_is_absolute(const char *path);
diff --git a/block.c b/block.c
index 8786b9b520..f8b3edd5bb 100644
--- a/block.c
+++ b/block.c
@@ -288,20 +288,28 @@ int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
     return 0;
 }
 
-void bdrv_get_full_backing_filename_from_filename(const char *backed,
-                                                  const char *backing,
-                                                  char *dest, size_t sz,
-                                                  Error **errp)
+/* If @backing is empty, this function returns NULL without setting
+ * @errp.  In all other cases, NULL will only be returned with @errp
+ * set.
+ *
+ * Therefore, a return value of NULL without @errp set means that
+ * there is no backing file; if @errp is set, there is one but its
+ * absolute filename cannot be generated.
+ */
+char *bdrv_get_full_backing_filename_from_filename(const char *backed,
+                                                   const char *backing,
+                                                   Error **errp)
 {
-    if (backing[0] == '\0' || path_has_protocol(backing) ||
-        path_is_absolute(backing))
-    {
-        pstrcpy(dest, sz, backing);
+    if (backing[0] == '\0') {
+        return NULL;
+    } else if (path_has_protocol(backing) || path_is_absolute(backing)) {
+        return g_strdup(backing);
     } else if (backed[0] == '\0' || strstart(backed, "json:", NULL)) {
         error_setg(errp, "Cannot use relative backing file names for '%s'",
                    backed);
+        return NULL;
     } else {
-        path_combine_deprecated(dest, sz, backed, backing);
+        return path_combine(backed, backing);
     }
 }
 
@@ -309,9 +317,20 @@ void bdrv_get_full_backing_filename(BlockDriverState *bs, char *dest, size_t sz,
                                     Error **errp)
 {
     char *backed = bs->exact_filename[0] ? bs->exact_filename : bs->filename;
+    char *full_name;
+    Error *local_error = NULL;
 
-    bdrv_get_full_backing_filename_from_filename(backed, bs->backing_file,
-                                                 dest, sz, errp);
+    full_name = bdrv_get_full_backing_filename_from_filename(backed,
+                                                             bs->backing_file,
+                                                             &local_error);
+    if (full_name) {
+        pstrcpy(dest, sz, full_name);
+        g_free(full_name);
+    } else if (local_error) {
+        error_propagate(errp, local_error);
+    } else if (sz > 0) {
+        *dest = '\0';
+    }
 }
 
 void bdrv_register(BlockDriver *bdrv)
@@ -4593,17 +4612,17 @@ void bdrv_img_create(const char *filename, const char *fmt,
     size = qemu_opt_get_size(opts, BLOCK_OPT_SIZE, img_size);
     if (backing_file && !(flags & BDRV_O_NO_BACKING)) {
         BlockDriverState *bs;
-        char *full_backing = g_new0(char, PATH_MAX);
+        char *full_backing;
         int back_flags;
         QDict *backing_options = NULL;
 
-        bdrv_get_full_backing_filename_from_filename(filename, backing_file,
-                                                     full_backing, PATH_MAX,
-                                                     &local_err);
+        full_backing =
+            bdrv_get_full_backing_filename_from_filename(filename, backing_file,
+                                                         &local_err);
         if (local_err) {
-            g_free(full_backing);
             goto out;
         }
+        assert(full_backing);
 
         /* backing files always opened read-only */
         back_flags = flags;
diff --git a/block/vmdk.c b/block/vmdk.c
index 5397a4345e..c1dbcfe133 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2001,16 +2001,15 @@ static int vmdk_create(const char *filename, QemuOpts *opts, Error **errp)
     }
     if (backing_file) {
         BlockBackend *blk;
-        char *full_backing = g_new0(char, PATH_MAX);
-        bdrv_get_full_backing_filename_from_filename(filename, backing_file,
-                                                     full_backing, PATH_MAX,
-                                                     &local_err);
+        char *full_backing =
+            bdrv_get_full_backing_filename_from_filename(filename, backing_file,
+                                                         &local_err);
         if (local_err) {
-            g_free(full_backing);
             error_propagate(errp, local_err);
             ret = -ENOENT;
             goto exit;
         }
+        assert(full_backing);
 
         blk = blk_new_open(full_backing, NULL, NULL,
                            BDRV_O_NO_BACKING, errp);
-- 
2.13.6
