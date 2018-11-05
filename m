Received: from eggs.gnu.org ([2001:4830:134:3::10]:52961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhy9-00051N-C7
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:43:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gJhy7-0008Ds-SY
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:43:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  5 Nov 2018 17:37:21 +0100
Message-Id: <20181105163744.25139-14-kwolf@redhat.com>
In-Reply-To: <20181105163744.25139-1-kwolf@redhat.com>
References: <20181105163744.25139-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/36] block/vdi: Don't take address of fields
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

Patch produced with scripts/coccinelle/inplace-byteswaps.cocci.

There are other places where we take the address of a packed member
in this file for other purposes than passing it to a byteswap
function (all the calls to qemu_uuid_*()); we leave those for now.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/vdi.c | 64 ++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 6555cffb88..0ff1ead736 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -187,22 +187,22 @@ typedef struct {
=20
 static void vdi_header_to_cpu(VdiHeader *header)
 {
-    le32_to_cpus(&header->signature);
-    le32_to_cpus(&header->version);
-    le32_to_cpus(&header->header_size);
-    le32_to_cpus(&header->image_type);
-    le32_to_cpus(&header->image_flags);
-    le32_to_cpus(&header->offset_bmap);
-    le32_to_cpus(&header->offset_data);
-    le32_to_cpus(&header->cylinders);
-    le32_to_cpus(&header->heads);
-    le32_to_cpus(&header->sectors);
-    le32_to_cpus(&header->sector_size);
-    le64_to_cpus(&header->disk_size);
-    le32_to_cpus(&header->block_size);
-    le32_to_cpus(&header->block_extra);
-    le32_to_cpus(&header->blocks_in_image);
-    le32_to_cpus(&header->blocks_allocated);
+    header->signature =3D le32_to_cpu(header->signature);
+    header->version =3D le32_to_cpu(header->version);
+    header->header_size =3D le32_to_cpu(header->header_size);
+    header->image_type =3D le32_to_cpu(header->image_type);
+    header->image_flags =3D le32_to_cpu(header->image_flags);
+    header->offset_bmap =3D le32_to_cpu(header->offset_bmap);
+    header->offset_data =3D le32_to_cpu(header->offset_data);
+    header->cylinders =3D le32_to_cpu(header->cylinders);
+    header->heads =3D le32_to_cpu(header->heads);
+    header->sectors =3D le32_to_cpu(header->sectors);
+    header->sector_size =3D le32_to_cpu(header->sector_size);
+    header->disk_size =3D le64_to_cpu(header->disk_size);
+    header->block_size =3D le32_to_cpu(header->block_size);
+    header->block_extra =3D le32_to_cpu(header->block_extra);
+    header->blocks_in_image =3D le32_to_cpu(header->blocks_in_image);
+    header->blocks_allocated =3D le32_to_cpu(header->blocks_allocated);
     qemu_uuid_bswap(&header->uuid_image);
     qemu_uuid_bswap(&header->uuid_last_snap);
     qemu_uuid_bswap(&header->uuid_link);
@@ -211,22 +211,22 @@ static void vdi_header_to_cpu(VdiHeader *header)
=20
 static void vdi_header_to_le(VdiHeader *header)
 {
-    cpu_to_le32s(&header->signature);
-    cpu_to_le32s(&header->version);
-    cpu_to_le32s(&header->header_size);
-    cpu_to_le32s(&header->image_type);
-    cpu_to_le32s(&header->image_flags);
-    cpu_to_le32s(&header->offset_bmap);
-    cpu_to_le32s(&header->offset_data);
-    cpu_to_le32s(&header->cylinders);
-    cpu_to_le32s(&header->heads);
-    cpu_to_le32s(&header->sectors);
-    cpu_to_le32s(&header->sector_size);
-    cpu_to_le64s(&header->disk_size);
-    cpu_to_le32s(&header->block_size);
-    cpu_to_le32s(&header->block_extra);
-    cpu_to_le32s(&header->blocks_in_image);
-    cpu_to_le32s(&header->blocks_allocated);
+    header->signature =3D cpu_to_le32(header->signature);
+    header->version =3D cpu_to_le32(header->version);
+    header->header_size =3D cpu_to_le32(header->header_size);
+    header->image_type =3D cpu_to_le32(header->image_type);
+    header->image_flags =3D cpu_to_le32(header->image_flags);
+    header->offset_bmap =3D cpu_to_le32(header->offset_bmap);
+    header->offset_data =3D cpu_to_le32(header->offset_data);
+    header->cylinders =3D cpu_to_le32(header->cylinders);
+    header->heads =3D cpu_to_le32(header->heads);
+    header->sectors =3D cpu_to_le32(header->sectors);
+    header->sector_size =3D cpu_to_le32(header->sector_size);
+    header->disk_size =3D cpu_to_le64(header->disk_size);
+    header->block_size =3D cpu_to_le32(header->block_size);
+    header->block_extra =3D cpu_to_le32(header->block_extra);
+    header->blocks_in_image =3D cpu_to_le32(header->blocks_in_image);
+    header->blocks_allocated =3D cpu_to_le32(header->blocks_allocated);
     qemu_uuid_bswap(&header->uuid_image);
     qemu_uuid_bswap(&header->uuid_last_snap);
     qemu_uuid_bswap(&header->uuid_link);
--=20
2.19.1
