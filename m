Received: from eggs.gnu.org ([2001:4830:134:3::10]:45550)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEDb-0000ik-CX
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:49:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTEDa-0003kq-E0
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 15:49:31 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 16 Jan 2017 21:49:05 +0100
Message-Id: <20170116204921.31578-2-mreitz@redhat.com>
In-Reply-To: <20170111181432.18868-1-mreitz@redhat.com>
References: <20170111181432.18868-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 09/25] block: Fix bdrv_find_backing_image()
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

bdrv_find_backing_image() should use bdrv_get_full_backing_filename() or
bdrv_make_absolute_filename() instead of trying to do what those
functions do by itself.

path_combine_deprecated() can now be dropped, so let's do that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index 4ad561810f..2735ec4bcc 100644
--- a/block.c
+++ b/block.c
@@ -194,15 +194,6 @@ char *path_combine(const char *base_path, const char *filename)
     return result;
 }
 
-static void path_combine_deprecated(char *dest, int dest_size,
-                                    const char *base_path,
-                                    const char *filename)
-{
-    char *combined = path_combine(base_path, filename);
-    pstrcpy(dest, dest_size, combined);
-    g_free(combined);
-}
-
 char *bdrv_get_full_backing_filename_from_filename(const char *backed,
                                                    const char *backing,
                                                    Error **errp)
@@ -3177,7 +3168,6 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
 
     filename_full     = g_malloc(PATH_MAX);
     backing_file_full = g_malloc(PATH_MAX);
-    filename_tmp      = g_malloc(PATH_MAX);
 
     is_protocol = path_has_protocol(backing_file);
 
@@ -3193,22 +3183,31 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
         } else {
             /* If not an absolute filename path, make it relative to the current
              * image's filename path */
-            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->filename,
-                                    backing_file);
+            filename_tmp = bdrv_make_absolute_filename(curr_bs, backing_file,
+                                                       NULL);
+            if (!filename_tmp) {
+                continue;
+            }
 
             /* We are going to compare absolute pathnames */
             if (!realpath(filename_tmp, filename_full)) {
+                g_free(filename_tmp);
                 continue;
             }
+            g_free(filename_tmp);
 
             /* We need to make sure the backing filename we are comparing against
              * is relative to the current image filename (or absolute) */
-            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->filename,
-                                    curr_bs->backing_file);
+            filename_tmp = bdrv_get_full_backing_filename(curr_bs, NULL);
+            if (!filename_tmp) {
+                continue;
+            }
 
             if (!realpath(filename_tmp, backing_file_full)) {
+                g_free(filename_tmp);
                 continue;
             }
+            g_free(filename_tmp);
 
             if (strcmp(backing_file_full, filename_full) == 0) {
                 retval = curr_bs->backing->bs;
@@ -3219,7 +3218,6 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
 
     g_free(filename_full);
     g_free(backing_file_full);
-    g_free(filename_tmp);
     return retval;
 }
 
-- 
2.11.0
