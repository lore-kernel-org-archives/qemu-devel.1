Received: from eggs.gnu.org ([2001:4830:134:3::10]:33554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1cg-00078o-0S
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gZ1ce-0006Dm-S1
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 17:44:25 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 17 Dec 2018 23:43:28 +0100
Message-Id: <20181217224348.14922-12-mreitz@redhat.com>
In-Reply-To: <20181217224348.14922-1-mreitz@redhat.com>
References: <20181217224348.14922-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v12 11/31] block:
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
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, Eric Blake <eblake@redhat.com>

Make bdrv_get_full_backing_filename() return an allocated string instead
of placing the result in a caller-provided buffer.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 include/block/block.h |  3 +--
 block.c               | 48 +++++++++++++++----------------------------
 block/qapi.c          | 12 ++---------
 3 files changed, 20 insertions(+), 43 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 9dd573351b..a1e1b59e9c 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -485,8 +485,7 @@ void bdrv_round_to_clusters(BlockDriverState *bs,
=20
 void bdrv_get_backing_filename(BlockDriverState *bs,
                                char *filename, int filename_size);
-void bdrv_get_full_backing_filename(BlockDriverState *bs,
-                                    char *dest, size_t sz, Error **errp)=
;
+char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)=
;
 char *bdrv_get_full_backing_filename_from_filename(const char *backed,
                                                    const char *backing,
                                                    Error **errp);
diff --git a/block.c b/block.c
index 0cd4412725..615ffa7f40 100644
--- a/block.c
+++ b/block.c
@@ -338,28 +338,16 @@ char *bdrv_get_full_backing_filename_from_filename(=
const char *backed,
     }
 }
=20
-void bdrv_get_full_backing_filename(BlockDriverState *bs, char *dest, si=
ze_t sz,
-                                    Error **errp)
+char *bdrv_get_full_backing_filename(BlockDriverState *bs, Error **errp)
 {
     char *backed;
-    char *full_name;
-    Error *local_error =3D NULL;
=20
     bdrv_refresh_filename(bs);
=20
     backed =3D bs->exact_filename[0] ? bs->exact_filename : bs->filename=
;
-
-    full_name =3D bdrv_get_full_backing_filename_from_filename(backed,
-                                                             bs->backing=
_file,
-                                                             &local_erro=
r);
-    if (full_name) {
-        pstrcpy(dest, sz, full_name);
-        g_free(full_name);
-    } else if (local_error) {
-        error_propagate(errp, local_error);
-    } else if (sz > 0) {
-        *dest =3D '\0';
-    }
+    return bdrv_get_full_backing_filename_from_filename(backed,
+                                                        bs->backing_file=
,
+                                                        errp);
 }
=20
 void bdrv_register(BlockDriver *bdrv)
@@ -2356,7 +2344,7 @@ out:
 int bdrv_open_backing_file(BlockDriverState *bs, QDict *parent_options,
                            const char *bdref_key, Error **errp)
 {
-    char *backing_filename =3D g_malloc0(PATH_MAX);
+    char *backing_filename =3D NULL;
     char *bdref_key_dot;
     const char *reference =3D NULL;
     int ret =3D 0;
@@ -2391,7 +2379,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QD=
ict *parent_options,
      */
     reference =3D qdict_get_try_str(parent_options, bdref_key);
     if (reference || qdict_haskey(options, "file.filename")) {
-        backing_filename[0] =3D '\0';
+        /* keep backing_filename NULL */
     } else if (bs->backing_file[0] =3D=3D '\0' && qdict_size(options) =3D=
=3D 0) {
         qobject_unref(options);
         goto free_exit;
@@ -2406,8 +2394,7 @@ int bdrv_open_backing_file(BlockDriverState *bs, QD=
ict *parent_options,
             implicit_backing =3D !strcmp(bs->auto_backing_file, bs->back=
ing_file);
         }
=20
-        bdrv_get_full_backing_filename(bs, backing_filename, PATH_MAX,
-                                       &local_err);
+        backing_filename =3D bdrv_get_full_backing_filename(bs, &local_e=
rr);
         if (local_err) {
             ret =3D -EINVAL;
             error_propagate(errp, local_err);
@@ -2428,9 +2415,8 @@ int bdrv_open_backing_file(BlockDriverState *bs, QD=
ict *parent_options,
         qdict_put_str(options, "driver", bs->backing_format);
     }
=20
-    backing_hd =3D bdrv_open_inherit(*backing_filename ? backing_filenam=
e : NULL,
-                                   reference, options, 0, bs, &child_bac=
king,
-                                   errp);
+    backing_hd =3D bdrv_open_inherit(backing_filename, reference, option=
s, 0, bs,
+                                   &child_backing, errp);
     if (!backing_hd) {
         bs->open_flags |=3D BDRV_O_NO_BACKING;
         error_prepend(errp, "Could not open backing file: ");
@@ -4436,7 +4422,6 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
     int is_protocol =3D 0;
     BlockDriverState *curr_bs =3D NULL;
     BlockDriverState *retval =3D NULL;
-    Error *local_error =3D NULL;
=20
     if (!bs || !bs->drv || !backing_file) {
         return NULL;
@@ -4456,21 +4441,22 @@ BlockDriverState *bdrv_find_backing_image(BlockDr=
iverState *bs,
         /* If either of the filename paths is actually a protocol, then
          * compare unmodified paths; otherwise make paths relative */
         if (is_protocol || path_has_protocol(curr_bs->backing_file)) {
+            char *backing_file_full_ret;
+
             if (strcmp(backing_file, curr_bs->backing_file) =3D=3D 0) {
                 retval =3D curr_bs->backing->bs;
                 break;
             }
             /* Also check against the full backing filename for the imag=
e */
-            bdrv_get_full_backing_filename(curr_bs, backing_file_full, P=
ATH_MAX,
-                                           &local_error);
-            if (local_error =3D=3D NULL) {
-                if (strcmp(backing_file, backing_file_full) =3D=3D 0) {
+            backing_file_full_ret =3D bdrv_get_full_backing_filename(cur=
r_bs,
+                                                                   NULL)=
;
+            if (backing_file_full_ret) {
+                bool equal =3D strcmp(backing_file, backing_file_full_re=
t) =3D=3D 0;
+                g_free(backing_file_full_ret);
+                if (equal) {
                     retval =3D curr_bs->backing->bs;
                     break;
                 }
-            } else {
-                error_free(local_error);
-                local_error =3D NULL;
             }
         } else {
             /* If not an absolute filename path, make it relative to the=
 current
diff --git a/block/qapi.c b/block/qapi.c
index 743136b84e..287e38e9de 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -291,18 +291,10 @@ void bdrv_query_image_info(BlockDriverState *bs,
=20
     backing_filename =3D bs->backing_file;
     if (backing_filename[0] !=3D '\0') {
-        char *backing_filename2 =3D g_malloc0(PATH_MAX);
+        char *backing_filename2;
         info->backing_filename =3D g_strdup(backing_filename);
         info->has_backing_filename =3D true;
-        bdrv_get_full_backing_filename(bs, backing_filename2, PATH_MAX, =
&err);
-        if (err) {
-            /* Can't reconstruct the full backing filename, so we must o=
mit
-             * this field and apply a Best Effort to this query. */
-            g_free(backing_filename2);
-            backing_filename2 =3D NULL;
-            error_free(err);
-            err =3D NULL;
-        }
+        backing_filename2 =3D bdrv_get_full_backing_filename(bs, NULL);
=20
         /* Always report the full_backing_filename if present, even if i=
t's the
          * same as backing_filename. That they are same is useful info. =
*/
--=20
2.19.2
