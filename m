Received: from eggs.gnu.org ([2001:4830:134:3::10]:50369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhtJ-0006wx-5J
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhtH-0003VC-A5
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:16 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:14 +0100
Message-Id: <20181105163744.25139-7-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/36] block/qcow2-bitmap: Don't take address of
 fields in packed structs
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

This patch was produced with the following spatch script:

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
 block/qcow2-bitmap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index b5f1b3563d..accebef4cf 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -118,7 +118,7 @@ static inline void bitmap_table_to_be(uint64_t *bitma=
p_table, size_t size)
     size_t i;
=20
     for (i =3D 0; i < size; ++i) {
-        cpu_to_be64s(&bitmap_table[i]);
+        bitmap_table[i] =3D cpu_to_be64(bitmap_table[i]);
     }
 }
=20
@@ -231,7 +231,7 @@ static int bitmap_table_load(BlockDriverState *bs, Qc=
ow2BitmapTable *tb,
     }
=20
     for (i =3D 0; i < tb->size; ++i) {
-        be64_to_cpus(&table[i]);
+        table[i] =3D be64_to_cpu(table[i]);
         ret =3D check_table_entry(table[i], s->cluster_size);
         if (ret < 0) {
             goto fail;
@@ -394,20 +394,20 @@ fail:
=20
 static inline void bitmap_dir_entry_to_cpu(Qcow2BitmapDirEntry *entry)
 {
-    be64_to_cpus(&entry->bitmap_table_offset);
-    be32_to_cpus(&entry->bitmap_table_size);
-    be32_to_cpus(&entry->flags);
-    be16_to_cpus(&entry->name_size);
-    be32_to_cpus(&entry->extra_data_size);
+    entry->bitmap_table_offset =3D be64_to_cpu(entry->bitmap_table_offse=
t);
+    entry->bitmap_table_size =3D be32_to_cpu(entry->bitmap_table_size);
+    entry->flags =3D be32_to_cpu(entry->flags);
+    entry->name_size =3D be16_to_cpu(entry->name_size);
+    entry->extra_data_size =3D be32_to_cpu(entry->extra_data_size);
 }
=20
 static inline void bitmap_dir_entry_to_be(Qcow2BitmapDirEntry *entry)
 {
-    cpu_to_be64s(&entry->bitmap_table_offset);
-    cpu_to_be32s(&entry->bitmap_table_size);
-    cpu_to_be32s(&entry->flags);
-    cpu_to_be16s(&entry->name_size);
-    cpu_to_be32s(&entry->extra_data_size);
+    entry->bitmap_table_offset =3D cpu_to_be64(entry->bitmap_table_offse=
t);
+    entry->bitmap_table_size =3D cpu_to_be32(entry->bitmap_table_size);
+    entry->flags =3D cpu_to_be32(entry->flags);
+    entry->name_size =3D cpu_to_be16(entry->name_size);
+    entry->extra_data_size =3D cpu_to_be32(entry->extra_data_size);
 }
=20
 static inline int calc_dir_entry_size(size_t name_size, size_t extra_dat=
a_size)
--=20
2.19.1
