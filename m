Received: from eggs.gnu.org ([2001:4830:134:3::10]:47024)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyYz-0001H2-5A
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:54:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dxyYy-0003Ij-8p
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 12:54:57 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Fri, 29 Sep 2017 18:53:31 +0200
Message-Id: <20170929165347.29658-10-mreitz@redhat.com>
In-Reply-To: <20170929165347.29658-1-mreitz@redhat.com>
References: <20170929165347.29658-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PATCH v6 09/25] block: Fix bdrv_find_backing_image()
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

bdrv_find_backing_image() should use bdrv_get_full_backing_filename() or
bdrv_make_absolute_filename() instead of trying to do what those
functions do by itself.

path_combine_deprecated() can now be dropped, so let's do that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/block.c b/block.c
index 2da242c1e9..17579125de 100644
--- a/block.c
+++ b/block.c
@@ -196,15 +196,6 @@ char *path_combine(const char *base_path, const char *filename)
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
 /*
  * Helper function for bdrv_parse_filename() implementations to remove optional
  * protocol prefixes (especially "file:") from a filename and for putting the
@@ -4067,7 +4058,6 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
 
     filename_full     = g_malloc(PATH_MAX);
     backing_file_full = g_malloc(PATH_MAX);
-    filename_tmp      = g_malloc(PATH_MAX);
 
     is_protocol = path_has_protocol(backing_file);
 
@@ -4096,22 +4086,31 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
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
@@ -4122,7 +4121,6 @@ BlockDriverState *bdrv_find_backing_image(BlockDriverState *bs,
 
     g_free(filename_full);
     g_free(backing_file_full);
-    g_free(filename_tmp);
     return retval;
 }
 
-- 
2.13.6
