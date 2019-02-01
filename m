Received: from eggs.gnu.org ([209.51.188.92]:46961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeW6-00063M-D7
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeW2-0002fx-Jp
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:20 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:17 +0100
Message-Id: <20190201192935.18394-14-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 13/31] block: Fix bdrv_find_backing_image()
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

bdrv_find_backing_image() should use bdrv_get_full_backing_filename() or
bdrv_make_absolute_filename() instead of trying to do what those
functions do by itself.

path_combine_deprecated() can now be dropped, so let's do that.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 33 ++++++++++-----------------------
 1 file changed, 10 insertions(+), 23 deletions(-)

diff --git a/block.c b/block.c
index 21100ac7fd..d30389ff35 100644
--- a/block.c
+++ b/block.c
@@ -201,15 +201,6 @@ char *path_combine(const char *base_path, const char=
 *filename)
     return result;
 }
=20
-static void path_combine_deprecated(char *dest, int dest_size,
-                                    const char *base_path,
-                                    const char *filename)
-{
-    char *combined =3D path_combine(base_path, filename);
-    pstrcpy(dest, dest_size, combined);
-    g_free(combined);
-}
-
 /*
  * Helper function for bdrv_parse_filename() implementations to remove o=
ptional
  * protocol prefixes (especially "file:") from a filename and for puttin=
g the
@@ -4597,13 +4588,9 @@ BlockDriverState *bdrv_find_backing_image(BlockDri=
verState *bs,
=20
     filename_full     =3D g_malloc(PATH_MAX);
     backing_file_full =3D g_malloc(PATH_MAX);
-    filename_tmp      =3D g_malloc(PATH_MAX);
=20
     is_protocol =3D path_has_protocol(backing_file);
=20
-    /* This will recursively refresh everything in the backing chain */
-    bdrv_refresh_filename(bs);
-
     for (curr_bs =3D bs; curr_bs->backing; curr_bs =3D curr_bs->backing-=
>bs) {
=20
         /* If either of the filename paths is actually a protocol, then
@@ -4629,22 +4616,23 @@ BlockDriverState *bdrv_find_backing_image(BlockDr=
iverState *bs,
         } else {
             /* If not an absolute filename path, make it relative to the=
 current
              * image's filename path */
-            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->fil=
ename,
-                                    backing_file);
-
-            /* We are going to compare absolute pathnames */
-            if (!realpath(filename_tmp, filename_full)) {
+            filename_tmp =3D bdrv_make_absolute_filename(curr_bs, backin=
g_file,
+                                                       NULL);
+            /* We are going to compare canonicalized absolute pathnames =
*/
+            if (!filename_tmp || !realpath(filename_tmp, filename_full))=
 {
+                g_free(filename_tmp);
                 continue;
             }
+            g_free(filename_tmp);
=20
             /* We need to make sure the backing filename we are comparin=
g against
              * is relative to the current image filename (or absolute) *=
/
-            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->fil=
ename,
-                                    curr_bs->backing_file);
-
-            if (!realpath(filename_tmp, backing_file_full)) {
+            filename_tmp =3D bdrv_get_full_backing_filename(curr_bs, NUL=
L);
+            if (!filename_tmp || !realpath(filename_tmp, backing_file_fu=
ll)) {
+                g_free(filename_tmp);
                 continue;
             }
+            g_free(filename_tmp);
=20
             if (strcmp(backing_file_full, filename_full) =3D=3D 0) {
                 retval =3D curr_bs->backing->bs;
@@ -4655,7 +4643,6 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
=20
     g_free(filename_full);
     g_free(backing_file_full);
-    g_free(filename_tmp);
     return retval;
 }
=20
--=20
2.20.1
