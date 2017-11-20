Received: from eggs.gnu.org ([2001:4830:134:3::10]:35049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsP6-0008BR-U2
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eGsP5-0006zQ-N6
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 15:10:52 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 20 Nov 2017 21:09:47 +0100
Message-Id: <20171120201004.14999-9-mreitz@redhat.com>
In-Reply-To: <20171120201004.14999-1-mreitz@redhat.com>
References: <20171120201004.14999-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v7 for-2.12 08/25] block:
 bdrv_get_full_backing_filename's ret. val.
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

Make bdrv_get_full_backing_filename() return an allocated string instead
of placing the result in a caller-provided buffer.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block.h |  3 +--
 block.c               | 47 +++++++++++++++++------------------------------
 block/qapi.c          | 12 ++----------
 3 files changed, 20 insertions(+), 42 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 46c6190414..3e2ea6c879 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -481,8 +481,7 @@ void bdrv_round_to_clusters(BlockDriverState *bs,
 const char *bdrv_get_encrypted_filename(BlockDriverState *bs);
 void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size);
-void bdrv_get_full_backing_filename(BlockDriverState *bs,
-                                    char *dest, size_t sz, Error **errp);
+char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp);
 char *bdrv_get_full_backing_filename_from_filename(const char *backed,
                                                    const char *backing,
                                                    Error **errp);
diff --git a/block.c b/block.c
index f8b3edd5bb..804adceafa 100644
--- a/block.c
+++ b/block.c
@@ -313,24 +313,13 @@ char *bdrv_get_full_backing_filename_from_filename(const char *backed,
     }
 }
 
-void bdrv_get_full_backing_filename(BlockDriverState *bs, char *dest, size_t sz,
-                                    Error **errp)
+char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
 {
     char *backed = bs->exact_filename[0] ? bs->exact_filename : bs->filename;
-    char *full_name;
-    Error *local_error = NULL;
 
-    full_name = bdrv_get_full_backing_filename_from_filename(backed,
-                                                             bs->backing_file,
-                                                             &local_error);
-    if (full_name) {
-        pstrcpy(dest, sz, full_name);
-        g_free(full_name);
-    } else if (local_error) {
-        error_propagate(errp, local_error);
-    } else if (sz > 0) {
-        *dest = '\0';
-    }
+    return bdrv_get_full_backing_filename_from_filename(backed,
+                                                        bs->backing_file,
+                                                        errp);
 }
 
 void bdrv_register(BlockDriver *bdrv)
@@ -2226,7 +2215,7 @@ out:
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                            const char *bdref_key, Error **errp)
 {
-    char *backing_filename = g_malloc0(PATH_MAX);
+    char *backing_filename = NULL;
     char *bdref_key_dot;
     const char *reference = NULL;
     int ret = 0;
@@ -2260,7 +2249,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
      */
     reference = qdict_get_try_str(parent_options, bdref_key);
     if (reference || qdict_haskey(options, "file.filename")) {
-        backing_filename[0] = '\0';
+        /* keep backing_filename NULL */
 
         /* FIXME: Should also be set to true if @options contains other runtime
          *        options which control the data that is read from the backing
@@ -2270,8 +2259,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
         QDECREF(options);
         goto free_exit;
     } else {
-        bdrv_get_full_backing_filename(bs, backing_filename, PATH_MAX,
-                                       &local_err);
+        backing_filename = bdrv_get_full_backing_filename(bs, &local_err);
         if (local_err) {
             ret = -EINVAL;
             error_propagate(errp, local_err);
@@ -2292,9 +2280,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
         qdict_put_str(options, "driver", bs->backing_format);
     }
 
-    backing_hd = bdrv_open_inherit(*backing_filename ? backing_filename : NULL,
-                                   reference, options, 0, bs, &child_backing,
-                                   errp);
+    backing_hd = bdrv_open_inherit(backing_filename, reference, options, 0, bs,
+                                   &child_backing, errp);
     if (!backing_hd) {
         bs->open_flags |= BDRV_O_NO_BACKING;
         error_prepend(errp, "Could not open backing file: ");
@@ -4128,7 +4115,6 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
     int is_protocol = 0;
     BlockDriverState *curr_bs = NULL;
     BlockDriverState *retval = NULL;
-    Error *local_error = NULL;
 
     if (!bs || !bs->drv || !backing_file) {
         return NULL;
@@ -4145,21 +4131,22 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
         /* If either of the filename paths is actually a protocol, then
          * compare unmodified paths; otherwise make paths relative */
         if (is_protocol || path_has_protocol(curr_bs->backing_file)) {
+            char *backing_file_full_ret;
+
             if (strcmp(backing_file, curr_bs->backing_file) == 0) {
                 retval = curr_bs->backing->bs;
                 break;
             }
             /* Also check against the full backing filename for the image */
-            bdrv_get_full_backing_filename(curr_bs, backing_file_full, PATH_MAX,
-                                           &local_error);
-            if (local_error == NULL) {
-                if (strcmp(backing_file, backing_file_full) == 0) {
+            backing_file_full_ret = bdrv_get_full_backing_filename(curr_bs,
+                                                                   NULL);
+            if (backing_file_full_ret) {
+                bool equal = strcmp(backing_file, backing_file_full_ret) == 0;
+                g_free(backing_file_full_ret);
+                if (equal) {
                     retval = curr_bs->backing->bs;
                     break;
                 }
-            } else {
-                error_free(local_error);
-                local_error = NULL;
             }
         } else {
             /* If not an absolute filename path, make it relative to the current
diff --git a/block/qapi.c b/block/qapi.c
index fc10f0a565..c7da9bd312 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -282,18 +282,10 @@ void bdrv_query_image_info(BlockDriverState *bs,
 
     backing_filename = bs->backing_file;
     if (backing_filename[0] != '\0') {
-        char *backing_filename2 = g_malloc0(PATH_MAX);
+        char *backing_filename2;
         info->backing_filename = g_strdup(backing_filename);
         info->has_backing_filename = true;
-        bdrv_get_full_backing_filename(bs, backing_filename2, PATH_MAX, &err);
-        if (err) {
-            /* Can't reconstruct the full backing filename, so we must omit
-             * this field and apply a Best Effort to this query. */
-            g_free(backing_filename2);
-            backing_filename2 = NULL;
-            error_free(err);
-            err = NULL;
-        }
+        backing_filename2 = bdrv_get_full_backing_filename(bs, NULL);
 
         /* Always report the full_backing_filename if present, even if it's the
          * same as backing_filename. That they are same is useful info. */
-- 
2.13.6
