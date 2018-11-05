Received: from eggs.gnu.org ([2001:4830:134:3::10]:50363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhtJ-0006wm-13
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhtH-0003V2-9z
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:38:16 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:13 +0100
Message-Id: <20181105163744.25139-6-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 05/36] block/qcow: Don't take address of fields
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
 block/qcow.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 385d935258..4518cb4c35 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -140,14 +140,14 @@ static int qcow_open(BlockDriverState *bs, QDict *o=
ptions, int flags,
     if (ret < 0) {
         goto fail;
     }
-    be32_to_cpus(&header.magic);
-    be32_to_cpus(&header.version);
-    be64_to_cpus(&header.backing_file_offset);
-    be32_to_cpus(&header.backing_file_size);
-    be32_to_cpus(&header.mtime);
-    be64_to_cpus(&header.size);
-    be32_to_cpus(&header.crypt_method);
-    be64_to_cpus(&header.l1_table_offset);
+    header.magic =3D be32_to_cpu(header.magic);
+    header.version =3D be32_to_cpu(header.version);
+    header.backing_file_offset =3D be64_to_cpu(header.backing_file_offse=
t);
+    header.backing_file_size =3D be32_to_cpu(header.backing_file_size);
+    header.mtime =3D be32_to_cpu(header.mtime);
+    header.size =3D be64_to_cpu(header.size);
+    header.crypt_method =3D be32_to_cpu(header.crypt_method);
+    header.l1_table_offset =3D be64_to_cpu(header.l1_table_offset);
=20
     if (header.magic !=3D QCOW_MAGIC) {
         error_setg(errp, "Image not in qcow format");
@@ -270,7 +270,7 @@ static int qcow_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
     }
=20
     for(i =3D 0;i < s->l1_size; i++) {
-        be64_to_cpus(&s->l1_table[i]);
+        s->l1_table[i] =3D be64_to_cpu(s->l1_table[i]);
     }
=20
     /* alloc L2 cache (max. 64k * 16 * 8 =3D 8 MB) */
--=20
2.19.1
