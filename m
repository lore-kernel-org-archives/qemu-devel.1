Received: from eggs.gnu.org ([2001:4830:134:3::10]:45297)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTECP-0008HV-QL
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:48:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTECO-0003TU-RZ
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:48:17 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 21:48:07 +0100
Message-Id: <20170116204807.30814-1-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-1-mreitz@redhat.com>
References: <20170111181432.18868-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 06/25] block:
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

Make bdrv_get_full_backing_filename_from_filename() return an allocated
string instead of placing the result in a caller-provided buffer.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block.h |  7 +++----
 block.c               | 32 +++++++++++++++++++-------------
 block/vmdk.c          |  8 +++-----
 3 files changed, 25 insertions(+), 22 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 6e5d4b25a4..fe16e45aba 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -437,10 +437,9 @@ void bdrv_get_backing_filename(BlockDriverState *bs,
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
index 28ce42c8a3..b02e492653 100644
--- a/block.c
+++ b/block.c
@@ -203,20 +203,20 @@ static void path_combine_deprecated(char *dest, int dest_size,
     g_free(combined);
 }
 
-void bdrv_get_full_backing_filename_from_filename(const char *backed,
-                                                  const char *backing,
-                                                  char *dest, size_t sz,
-                                                  Error **errp)
+char *bdrv_get_full_backing_filename_from_filename(const char *backed,
+                                                   const char *backing,
+                                                   Error **errp)
 {
     if (backing[0] == '\0' || path_has_protocol(backing) ||
         path_is_absolute(backing))
     {
-        pstrcpy(dest, sz, backing);
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
 
@@ -224,9 +224,15 @@ void bdrv_get_full_backing_filename(BlockDriverState *bs, char *dest, size_t sz,
                                     Error **errp)
 {
     char *backed = bs->exact_filename[0] ? bs->exact_filename : bs->filename;
+    char *full_name;
 
-    bdrv_get_full_backing_filename_from_filename(backed, bs->backing_file,
-                                                 dest, sz, errp);
+    full_name = bdrv_get_full_backing_filename_from_filename(backed,
+                                                             bs->backing_file,
+                                                             errp);
+    if (full_name) {
+        pstrcpy(dest, sz, full_name);
+        g_free(full_name);
+    }
 }
 
 void bdrv_register(BlockDriver *bdrv)
@@ -3607,16 +3613,16 @@ void bdrv_img_create(const char *filename, const char *fmt,
     if (size == -1) {
         if (backing_file) {
             BlockDriverState *bs;
-            char *full_backing = g_new0(char, PATH_MAX);
+            char *full_backing;
             int64_t size;
             int back_flags;
             QDict *backing_options = NULL;
 
-            bdrv_get_full_backing_filename_from_filename(filename, backing_file,
-                                                         full_backing, PATH_MAX,
-                                                         &local_err);
+            full_backing =
+                bdrv_get_full_backing_filename_from_filename(filename,
+                                                             backing_file,
+                                                             &local_err);
             if (local_err) {
-                g_free(full_backing);
                 goto out;
             }
 
diff --git a/block/vmdk.c b/block/vmdk.c
index aad2d7de01..6f6932aa3f 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -1973,12 +1973,10 @@ static int vmdk_create(const char *filename, QemuOpts *opts, Error **errp)
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
-- 
2.11.0
