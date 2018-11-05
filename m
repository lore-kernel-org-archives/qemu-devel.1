Received: from eggs.gnu.org ([2001:4830:134:3::10]:50373)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhtJ-0006x5-8P
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhtH-0003V3-As
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:12 +0100
Message-Id: <20181105163744.25139-5-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/36] block/qcow2: Don't take address of fields
 in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Peter Maydell <peter.maydell@linaro.org>

Taking the address of a field in a packed struct is a bad idea, because
it might not be actually aligned enough for that pointer type (and
thus cause a crash on dereference on some host architectures). Newer
versions of clang warn about this. Avoid the bug by not using the
"modify in place" byte swapping functions.

There are a few places where the in-place swap function is
used on something other than a packed struct field; we convert
those anyway, for consistency.

This patch was produced with the following spatch script
(and hand-editing to fold a few resulting overlength lines):

@@
expression E;
@@
-be16_to_cpus(&E);
+E =3D be16_to_cpu(E);
@@
expression E;
@@
-be32_to_cpus(&E);
+E =3D be32_to_cpu(E);
@@
expression E;
@@
-be64_to_cpus(&E);
+E =3D be64_to_cpu(E);
@@
expression E;
@@
-cpu_to_be16s(&E);
+E =3D cpu_to_be16(E);
@@
expression E;
@@
-cpu_to_be32s(&E);
+E =3D cpu_to_be32(E);
@@
expression E;
@@
-cpu_to_be64s(&E);
+E =3D cpu_to_be64(E);

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: John Snow <jsnow@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 64 +++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 30689b7688..de94b290e6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -210,8 +210,8 @@ static int qcow2_read_extensions(BlockDriverState *bs=
, uint64_t start_offset,
                              "pread fail from offset %" PRIu64, offset);
             return 1;
         }
-        be32_to_cpus(&ext.magic);
-        be32_to_cpus(&ext.len);
+        ext.magic =3D be32_to_cpu(ext.magic);
+        ext.len =3D be32_to_cpu(ext.len);
         offset +=3D sizeof(ext);
 #ifdef DEBUG_EXT
         printf("ext.magic =3D 0x%x\n", ext.magic);
@@ -279,8 +279,8 @@ static int qcow2_read_extensions(BlockDriverState *bs=
, uint64_t start_offset,
                                  "Unable to read CRYPTO header extension=
");
                 return ret;
             }
-            be64_to_cpus(&s->crypto_header.offset);
-            be64_to_cpus(&s->crypto_header.length);
+            s->crypto_header.offset =3D be64_to_cpu(s->crypto_header.off=
set);
+            s->crypto_header.length =3D be64_to_cpu(s->crypto_header.len=
gth);
=20
             if ((s->crypto_header.offset % s->cluster_size) !=3D 0) {
                 error_setg(errp, "Encryption header offset '%" PRIu64 "'=
 is "
@@ -342,9 +342,11 @@ static int qcow2_read_extensions(BlockDriverState *b=
s, uint64_t start_offset,
                 return -EINVAL;
             }
=20
-            be32_to_cpus(&bitmaps_ext.nb_bitmaps);
-            be64_to_cpus(&bitmaps_ext.bitmap_directory_size);
-            be64_to_cpus(&bitmaps_ext.bitmap_directory_offset);
+            bitmaps_ext.nb_bitmaps =3D be32_to_cpu(bitmaps_ext.nb_bitmap=
s);
+            bitmaps_ext.bitmap_directory_size =3D
+                be64_to_cpu(bitmaps_ext.bitmap_directory_size);
+            bitmaps_ext.bitmap_directory_offset =3D
+                be64_to_cpu(bitmaps_ext.bitmap_directory_offset);
=20
             if (bitmaps_ext.nb_bitmaps > QCOW2_MAX_BITMAPS) {
                 error_setg(errp,
@@ -1159,19 +1161,20 @@ static int coroutine_fn qcow2_do_open(BlockDriver=
State *bs, QDict *options,
         error_setg_errno(errp, -ret, "Could not read qcow2 header");
         goto fail;
     }
-    be32_to_cpus(&header.magic);
-    be32_to_cpus(&header.version);
-    be64_to_cpus(&header.backing_file_offset);
-    be32_to_cpus(&header.backing_file_size);
-    be64_to_cpus(&header.size);
-    be32_to_cpus(&header.cluster_bits);
-    be32_to_cpus(&header.crypt_method);
-    be64_to_cpus(&header.l1_table_offset);
-    be32_to_cpus(&header.l1_size);
-    be64_to_cpus(&header.refcount_table_offset);
-    be32_to_cpus(&header.refcount_table_clusters);
-    be64_to_cpus(&header.snapshots_offset);
-    be32_to_cpus(&header.nb_snapshots);
+    header.magic =3D be32_to_cpu(header.magic);
+    header.version =3D be32_to_cpu(header.version);
+    header.backing_file_offset =3D be64_to_cpu(header.backing_file_offse=
t);
+    header.backing_file_size =3D be32_to_cpu(header.backing_file_size);
+    header.size =3D be64_to_cpu(header.size);
+    header.cluster_bits =3D be32_to_cpu(header.cluster_bits);
+    header.crypt_method =3D be32_to_cpu(header.crypt_method);
+    header.l1_table_offset =3D be64_to_cpu(header.l1_table_offset);
+    header.l1_size =3D be32_to_cpu(header.l1_size);
+    header.refcount_table_offset =3D be64_to_cpu(header.refcount_table_o=
ffset);
+    header.refcount_table_clusters =3D
+        be32_to_cpu(header.refcount_table_clusters);
+    header.snapshots_offset =3D be64_to_cpu(header.snapshots_offset);
+    header.nb_snapshots =3D be32_to_cpu(header.nb_snapshots);
=20
     if (header.magic !=3D QCOW_MAGIC) {
         error_setg(errp, "Image is not in qcow2 format");
@@ -1207,11 +1210,12 @@ static int coroutine_fn qcow2_do_open(BlockDriver=
State *bs, QDict *options,
         header.refcount_order           =3D 4;
         header.header_length            =3D 72;
     } else {
-        be64_to_cpus(&header.incompatible_features);
-        be64_to_cpus(&header.compatible_features);
-        be64_to_cpus(&header.autoclear_features);
-        be32_to_cpus(&header.refcount_order);
-        be32_to_cpus(&header.header_length);
+        header.incompatible_features =3D
+            be64_to_cpu(header.incompatible_features);
+        header.compatible_features =3D be64_to_cpu(header.compatible_fea=
tures);
+        header.autoclear_features =3D be64_to_cpu(header.autoclear_featu=
res);
+        header.refcount_order =3D be32_to_cpu(header.refcount_order);
+        header.header_length =3D be32_to_cpu(header.header_length);
=20
         if (header.header_length < 104) {
             error_setg(errp, "qcow2 header too short");
@@ -1400,7 +1404,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
             goto fail;
         }
         for(i =3D 0;i < s->l1_size; i++) {
-            be64_to_cpus(&s->l1_table[i]);
+            s->l1_table[i] =3D be64_to_cpu(s->l1_table[i]);
         }
     }
=20
@@ -2392,13 +2396,13 @@ int qcow2_update_header(BlockDriverState *bs)
=20
     /* Full disk encryption header pointer extension */
     if (s->crypto_header.offset !=3D 0) {
-        cpu_to_be64s(&s->crypto_header.offset);
-        cpu_to_be64s(&s->crypto_header.length);
+        s->crypto_header.offset =3D cpu_to_be64(s->crypto_header.offset)=
;
+        s->crypto_header.length =3D cpu_to_be64(s->crypto_header.length)=
;
         ret =3D header_ext_add(buf, QCOW2_EXT_MAGIC_CRYPTO_HEADER,
                              &s->crypto_header, sizeof(s->crypto_header)=
,
                              buflen);
-        be64_to_cpus(&s->crypto_header.offset);
-        be64_to_cpus(&s->crypto_header.length);
+        s->crypto_header.offset =3D be64_to_cpu(s->crypto_header.offset)=
;
+        s->crypto_header.length =3D be64_to_cpu(s->crypto_header.length)=
;
         if (ret < 0) {
             goto fail;
         }
--=20
2.19.1
