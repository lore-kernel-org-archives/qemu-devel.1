Received: from eggs.gnu.org ([209.51.188.92]:46765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVv-0005r9-Rk
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeVs-0002Vz-LG
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:30:11 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:13 +0100
Message-Id: <20190201192935.18394-10-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 09/31] block: Make path_combine() return
 the path
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

Besides being safe for arbitrary path lengths, after some follow-up
patches all callers will want a freshly allocated buffer anyway.

In the meantime, path_combine_deprecated() is added which has the same
interface as path_combine() had before this patch. All callers to that
function will be converted in follow-up patches.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/block.h |  4 +-
 block.c               | 85 ++++++++++++++++++++++++-------------------
 block/vmdk.c          |  3 +-
 3 files changed, 49 insertions(+), 43 deletions(-)

diff --git a/include/block/block.h b/include/block/block.h
index 2eecff73fe..67a6264c44 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -495,9 +495,7 @@ void bdrv_get_full_backing_filename_from_filename(con=
st char *backed,
=20
 int path_has_protocol(const char *path);
 int path_is_absolute(const char *path);
-void path_combine(char *dest, int dest_size,
-                  const char *base_path,
-                  const char *filename);
+char *path_combine(const char *base_path, const char *filename);
=20
 int bdrv_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t=
 pos);
 int bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_=
t pos);
diff --git a/block.c b/block.c
index 223b9b19cb..dbb11693f0 100644
--- a/block.c
+++ b/block.c
@@ -152,53 +152,62 @@ int path_is_absolute(const char *path)
 #endif
 }
=20
-/* if filename is absolute, just copy it to dest. Otherwise, build a
+/* if filename is absolute, just return its duplicate. Otherwise, build =
a
    path to it by considering it is relative to base_path. URL are
    supported. */
-void path_combine(char *dest, int dest_size,
-                  const char *base_path,
-                  const char *filename)
+char *path_combine(const char *base_path, const char *filename)
 {
+    const char *protocol_stripped =3D NULL;
     const char *p, *p1;
+    char *result;
     int len;
=20
-    if (dest_size <=3D 0)
-        return;
     if (path_is_absolute(filename)) {
-        pstrcpy(dest, dest_size, filename);
-    } else {
-        const char *protocol_stripped =3D NULL;
+        return g_strdup(filename);
+    }
=20
-        if (path_has_protocol(base_path)) {
-            protocol_stripped =3D strchr(base_path, ':');
-            if (protocol_stripped) {
-                protocol_stripped++;
-            }
+    if (path_has_protocol(base_path)) {
+        protocol_stripped =3D strchr(base_path, ':');
+        if (protocol_stripped) {
+            protocol_stripped++;
         }
-        p =3D protocol_stripped ?: base_path;
+    }
+    p =3D protocol_stripped ?: base_path;
=20
-        p1 =3D strrchr(base_path, '/');
+    p1 =3D strrchr(base_path, '/');
 #ifdef _WIN32
-        {
-            const char *p2;
-            p2 =3D strrchr(base_path, '\\');
-            if (!p1 || p2 > p1)
-                p1 =3D p2;
+    {
+        const char *p2;
+        p2 =3D strrchr(base_path, '\\');
+        if (!p1 || p2 > p1) {
+            p1 =3D p2;
         }
+    }
 #endif
-        if (p1)
-            p1++;
-        else
-            p1 =3D base_path;
-        if (p1 > p)
-            p =3D p1;
-        len =3D p - base_path;
-        if (len > dest_size - 1)
-            len =3D dest_size - 1;
-        memcpy(dest, base_path, len);
-        dest[len] =3D '\0';
-        pstrcat(dest, dest_size, filename);
+    if (p1) {
+        p1++;
+    } else {
+        p1 =3D base_path;
+    }
+    if (p1 > p) {
+        p =3D p1;
     }
+    len =3D p - base_path;
+
+    result =3D g_malloc(len + strlen(filename) + 1);
+    memcpy(result, base_path, len);
+    strcpy(result + len, filename);
+
+    return result;
+}
+
+static void path_combine_deprecated(char *dest, int dest_size,
+                                    const char *base_path,
+                                    const char *filename)
+{
+    char *combined =3D path_combine(base_path, filename);
+    pstrcpy(dest, dest_size, combined);
+    g_free(combined);
 }
=20
 /*
@@ -316,7 +325,7 @@ void bdrv_get_full_backing_filename_from_filename(con=
st char *backed,
         error_setg(errp, "Cannot use relative backing file names for '%s=
'",
                    backed);
     } else {
-        path_combine(dest, sz, backed, backing);
+        path_combine_deprecated(dest, sz, backed, backing);
     }
 }
=20
@@ -4600,8 +4609,8 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
         } else {
             /* If not an absolute filename path, make it relative to the=
 current
              * image's filename path */
-            path_combine(filename_tmp, PATH_MAX, curr_bs->filename,
-                         backing_file);
+            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->fil=
ename,
+                                    backing_file);
=20
             /* We are going to compare absolute pathnames */
             if (!realpath(filename_tmp, filename_full)) {
@@ -4610,8 +4619,8 @@ BlockDriverState *bdrv_find_backing_image(BlockDriv=
erState *bs,
=20
             /* We need to make sure the backing filename we are comparin=
g against
              * is relative to the current image filename (or absolute) *=
/
-            path_combine(filename_tmp, PATH_MAX, curr_bs->filename,
-                         curr_bs->backing_file);
+            path_combine_deprecated(filename_tmp, PATH_MAX, curr_bs->fil=
ename,
+                                    curr_bs->backing_file);
=20
             if (!realpath(filename_tmp, backing_file_full)) {
                 continue;
diff --git a/block/vmdk.c b/block/vmdk.c
index d21f6a9f2c..144e24685d 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -873,8 +873,7 @@ static int vmdk_parse_extents(const char *desc, Block=
DriverState *bs,
             return -EINVAL;
         }
=20
-        extent_path =3D g_malloc0(PATH_MAX);
-        path_combine(extent_path, PATH_MAX, desc_file_path, fname);
+        extent_path =3D path_combine(desc_file_path, fname);
=20
         ret =3D snprintf(extent_opt_prefix, 32, "extents.%d", s->num_ext=
ents);
         assert(ret < 32);
--=20
2.20.1
