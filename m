Received: from eggs.gnu.org ([2001:4830:134:3::10]:42697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsb9-0002QB-Ex
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fnsb4-0007vJ-Ju
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 17:35:59 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Thu,  9 Aug 2018 23:35:07 +0200
Message-Id: <20180809213528.14738-11-mreitz@redhat.com>
In-Reply-To: <20180809213528.14738-1-mreitz@redhat.com>
References: <20180809213528.14738-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH for-3.1 v10 10/31] block:
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Alberto Garcia <berto@igalia.com>

Make bdrv_get_full_backing_filename_from_filename() return an allocated
string instead of placing the result in a caller-provided buffer.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block.h |  7 +++---
 block.c               | 53 ++++++++++++++++++++++++++++++-------------
 block/vmdk.c          |  9 ++++----
 qemu-img.c            | 12 ++++------
 4 files changed, 48 insertions(+), 33 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 13d583dfd6..efb767d284 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -487,10 +487,9 @@ void bdrv_get_backing_filename(BlockDriverState *bs,
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
index 3c62c22454..741a5ff7e6 100644
--- a/block.c
+++ b/block.c
@@ -293,20 +293,29 @@ int bdrv_set_read_only(BlockDriverState *bs, bool read_only, Error **errp)
     return 0;
 }
 
-void bdrv_get_full_backing_filename_from_filename(const char *backed,
-                                                  const char *backing,
-                                                  char *dest, size_t sz,
-                                                  Error **errp)
+/*
+ * If @backing is empty, this function returns NULL without setting
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
 
@@ -314,12 +323,24 @@ void bdrv_get_full_backing_filename(BlockDriverState *bs, char *dest, size_t sz,
                                     Error **errp)
 {
     char *backed;
+    char *full_name;
+    Error *local_error = NULL;
 
     bdrv_refresh_filename(bs);
 
     backed = bs->exact_filename[0] ? bs->exact_filename : bs->filename;
-    bdrv_get_full_backing_filename_from_filename(backed, bs->backing_file,
-                                                 dest, sz, errp);
+
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
@@ -4802,17 +4823,17 @@ void bdrv_img_create(const char *filename, const char *fmt,
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
index 42b0f12021..1b1a829fa1 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2028,16 +2028,15 @@ static int coroutine_fn vmdk_co_create_opts(const char *filename, QemuOpts *opts
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
diff --git a/qemu-img.c b/qemu-img.c
index 1acddf693c..0752bbe4d9 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3329,18 +3329,14 @@ static int img_rebase(int argc, char **argv)
 
             overlay_filename = bs->exact_filename[0] ? bs->exact_filename
                                                      : bs->filename;
-            out_real_path = g_malloc(PATH_MAX);
-
-            bdrv_get_full_backing_filename_from_filename(overlay_filename,
-                                                         out_baseimg,
-                                                         out_real_path,
-                                                         PATH_MAX,
-                                                         &local_err);
+            out_real_path =
+                bdrv_get_full_backing_filename_from_filename(overlay_filename,
+                                                             out_baseimg,
+                                                             &local_err);
             if (local_err) {
                 error_reportf_err(local_err,
                                   "Could not resolve backing filename: ");
                 ret = -1;
-                g_free(out_real_path);
                 goto out;
             }
 
-- 
2.17.1
