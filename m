Received: from eggs.gnu.org ([2001:4830:134:3::10]:33515)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1ce-00077D-Nj
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cd-0006Cj-IA
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:24 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:27 +0100
Message-Id: <20181217224348.14922-11-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 10/31] block:
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

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
index c69b08bef9..9dd573351b 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -487,10 +487,9 @@ void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size);
 void bdrv_get_full_backing_filename(BlockDriverState *bs,
                                     char *dest, size_t sz, Error **errp)=
;
-void bdrv_get_full_backing_filename_from_filename(const char *backed,
-                                                  const char *backing,
-                                                  char *dest, size_t sz,
-                                                  Error **errp);
+char *bdrv_get_full_backing_filename_from_filename(const char *backed,
+                                                   const char *backing,
+                                                   Error **errp);
=20
 int path_has_protocol(const char *path);
 int path_is_absolute(const char *path);
diff --git a/block.c b/block.c
index 933a43c989..0cd4412725 100644
--- a/block.c
+++ b/block.c
@@ -312,20 +312,29 @@ fail:
     return -EACCES;
 }
=20
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
-    if (backing[0] =3D=3D '\0' || path_has_protocol(backing) ||
-        path_is_absolute(backing))
-    {
-        pstrcpy(dest, sz, backing);
+    if (backing[0] =3D=3D '\0') {
+        return NULL;
+    } else if (path_has_protocol(backing) || path_is_absolute(backing)) =
{
+        return g_strdup(backing);
     } else if (backed[0] =3D=3D '\0' || strstart(backed, "json:", NULL))=
 {
         error_setg(errp, "Cannot use relative backing file names for '%s=
'",
                    backed);
+        return NULL;
     } else {
-        path_combine_deprecated(dest, sz, backed, backing);
+        return path_combine(backed, backing);
     }
 }
=20
@@ -333,12 +342,24 @@ void bdrv_get_full_backing_filename(BlockDriverStat=
e *bs, char *dest, size_t sz,
                                     Error **errp)
 {
     char *backed;
+    char *full_name;
+    Error *local_error =3D NULL;
=20
     bdrv_refresh_filename(bs);
=20
     backed =3D bs->exact_filename[0] ? bs->exact_filename : bs->filename=
;
-    bdrv_get_full_backing_filename_from_filename(backed, bs->backing_fil=
e,
-                                                 dest, sz, errp);
+
+    full_name =3D bdrv_get_full_backing_filename_from_filename(backed,
+                                                             bs->backing=
_file,
+                                                             &local_erro=
r);
+    if (full_name) {
+        pstrcpy(dest, sz, full_name);
+        g_free(full_name);
+    } else if (local_error) {
+        error_propagate(errp, local_error);
+    } else if (sz > 0) {
+        *dest =3D '\0';
+    }
 }
=20
 void bdrv_register(BlockDriver *bdrv)
@@ -4965,17 +4986,17 @@ void bdrv_img_create(const char *filename, const =
char *fmt,
     size =3D qemu_opt_get_size(opts, BLOCK_OPT_SIZE, img_size);
     if (backing_file && !(flags & BDRV_O_NO_BACKING)) {
         BlockDriverState *bs;
-        char *full_backing =3D g_new0(char, PATH_MAX);
+        char *full_backing;
         int back_flags;
         QDict *backing_options =3D NULL;
=20
-        bdrv_get_full_backing_filename_from_filename(filename, backing_f=
ile,
-                                                     full_backing, PATH_=
MAX,
-                                                     &local_err);
+        full_backing =3D
+            bdrv_get_full_backing_filename_from_filename(filename, backi=
ng_file,
+                                                         &local_err);
         if (local_err) {
-            g_free(full_backing);
             goto out;
         }
+        assert(full_backing);
=20
         /* backing files always opened read-only */
         back_flags =3D flags;
diff --git a/block/vmdk.c b/block/vmdk.c
index 3d3273e65b..b3fc3b9e12 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -2049,16 +2049,15 @@ static int coroutine_fn vmdk_co_create_opts(const=
 char *filename, QemuOpts *opts
     }
     if (backing_file) {
         BlockBackend *blk;
-        char *full_backing =3D g_new0(char, PATH_MAX);
-        bdrv_get_full_backing_filename_from_filename(filename, backing_f=
ile,
-                                                     full_backing, PATH_=
MAX,
-                                                     &local_err);
+        char *full_backing =3D
+            bdrv_get_full_backing_filename_from_filename(filename, backi=
ng_file,
+                                                         &local_err);
         if (local_err) {
-            g_free(full_backing);
             error_propagate(errp, local_err);
             ret =3D -ENOENT;
             goto exit;
         }
+        assert(full_backing);
=20
         blk =3D blk_new_open(full_backing, NULL, NULL,
                            BDRV_O_NO_BACKING, errp);
diff --git a/qemu-img.c b/qemu-img.c
index da14ec0bb5..cd81621554 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -3336,18 +3336,14 @@ static int img_rebase(int argc, char **argv)
             bdrv_refresh_filename(bs);
             overlay_filename =3D bs->exact_filename[0] ? bs->exact_filen=
ame
                                                      : bs->filename;
-            out_real_path =3D g_malloc(PATH_MAX);
-
-            bdrv_get_full_backing_filename_from_filename(overlay_filenam=
e,
-                                                         out_baseimg,
-                                                         out_real_path,
-                                                         PATH_MAX,
-                                                         &local_err);
+            out_real_path =3D
+                bdrv_get_full_backing_filename_from_filename(overlay_fil=
ename,
+                                                             out_baseimg=
,
+                                                             &local_err)=
;
             if (local_err) {
                 error_reportf_err(local_err,
                                   "Could not resolve backing filename: "=
);
                 ret =3D -1;
-                g_free(out_real_path);
                 goto out;
             }
=20
--=20
2.19.2
