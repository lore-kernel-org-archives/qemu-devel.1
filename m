Received: from eggs.gnu.org ([2001:4830:134:3::10]:52440)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCT5i-0001fb-IH
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gCT5h-0002hj-HT
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 13:25:10 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Oct 2018 18:25:03 +0100
Message-Id: <20181016172503.27814-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH] block/vdi: Don't take address of fields in
 packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Stefan Weil <sw@weilnetz.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

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
---
Another "tested with make check" auto-conversion patch. In this
case, as noted above, it doesn't fix all the warnings for the file,
but we might as well put the easy part of the fix in. I'm not sure
what to do with the qemu_uuid_*() calls. Something like
     QemuUUID uuid_link = header->uuid_link;
and then using "qemu_uuid_is_null(uuid_link)" rather than
"qemu_uuid_is_null(&header.uuid_link)" ?
Or we could macroise the relevant qemu_uuid functions (notably
qemu_uuid_bswap()) or turn them into functions taking a QemuUUID
rather than a QemuUUID*. Suggestions ?

 block/vdi.c | 64 ++++++++++++++++++++++++++---------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/block/vdi.c b/block/vdi.c
index 6555cffb886..0ff1ead736c 100644
--- a/block/vdi.c
+++ b/block/vdi.c
@@ -187,22 +187,22 @@ typedef struct {
 
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
+    header->signature = le32_to_cpu(header->signature);
+    header->version = le32_to_cpu(header->version);
+    header->header_size = le32_to_cpu(header->header_size);
+    header->image_type = le32_to_cpu(header->image_type);
+    header->image_flags = le32_to_cpu(header->image_flags);
+    header->offset_bmap = le32_to_cpu(header->offset_bmap);
+    header->offset_data = le32_to_cpu(header->offset_data);
+    header->cylinders = le32_to_cpu(header->cylinders);
+    header->heads = le32_to_cpu(header->heads);
+    header->sectors = le32_to_cpu(header->sectors);
+    header->sector_size = le32_to_cpu(header->sector_size);
+    header->disk_size = le64_to_cpu(header->disk_size);
+    header->block_size = le32_to_cpu(header->block_size);
+    header->block_extra = le32_to_cpu(header->block_extra);
+    header->blocks_in_image = le32_to_cpu(header->blocks_in_image);
+    header->blocks_allocated = le32_to_cpu(header->blocks_allocated);
     qemu_uuid_bswap(&header->uuid_image);
     qemu_uuid_bswap(&header->uuid_last_snap);
     qemu_uuid_bswap(&header->uuid_link);
@@ -211,22 +211,22 @@ static void vdi_header_to_cpu(VdiHeader *header)
 
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
+    header->signature = cpu_to_le32(header->signature);
+    header->version = cpu_to_le32(header->version);
+    header->header_size = cpu_to_le32(header->header_size);
+    header->image_type = cpu_to_le32(header->image_type);
+    header->image_flags = cpu_to_le32(header->image_flags);
+    header->offset_bmap = cpu_to_le32(header->offset_bmap);
+    header->offset_data = cpu_to_le32(header->offset_data);
+    header->cylinders = cpu_to_le32(header->cylinders);
+    header->heads = cpu_to_le32(header->heads);
+    header->sectors = cpu_to_le32(header->sectors);
+    header->sector_size = cpu_to_le32(header->sector_size);
+    header->disk_size = cpu_to_le64(header->disk_size);
+    header->block_size = cpu_to_le32(header->block_size);
+    header->block_extra = cpu_to_le32(header->block_extra);
+    header->blocks_in_image = cpu_to_le32(header->blocks_in_image);
+    header->blocks_allocated = cpu_to_le32(header->blocks_allocated);
     qemu_uuid_bswap(&header->uuid_image);
     qemu_uuid_bswap(&header->uuid_last_snap);
     qemu_uuid_bswap(&header->uuid_link);
-- 
2.19.0
