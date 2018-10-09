Received: from eggs.gnu.org ([2001:4830:134:3::10]:46579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9vkr-0004di-3B
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9vkq-00055g-9a
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:25:09 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Oct 2018 18:25:01 +0100
Message-Id: <20181009172501.17353-4-peter.maydell@linaro.org>
In-Reply-To: <20181009172501.17353-1-peter.maydell@linaro.org>
References: <20181009172501.17353-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 3/3] block/qcow2-bitmap: Don't take address of
 fields in packed structs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org

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
+E = be16_to_cpu(E);
@@
expression E;
@@
-be32_to_cpus(&E);
+E = be32_to_cpu(E);
@@
expression E;
@@
-be64_to_cpus(&E);
+E = be64_to_cpu(E);
@@
expression E;
@@
-cpu_to_be16s(&E);
+E = cpu_to_be16(E);
@@
expression E;
@@
-cpu_to_be32s(&E);
+E = cpu_to_be32(E);
@@
expression E;
@@
-cpu_to_be64s(&E);
+E = cpu_to_be64(E);

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 block/qcow2-bitmap.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index ba978ad2aac..74f7638e03c 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -118,7 +118,7 @@ static inline void bitmap_table_to_be(uint64_t *bitmap_table, size_t size)
     size_t i;
 
     for (i = 0; i < size; ++i) {
-        cpu_to_be64s(&bitmap_table[i]);
+        bitmap_table[i] = cpu_to_be64(bitmap_table[i]);
     }
 }
 
@@ -231,7 +231,7 @@ static int bitmap_table_load(BlockDriverState *bs, Qcow2BitmapTable *tb,
     }
 
     for (i = 0; i < tb->size; ++i) {
-        be64_to_cpus(&table[i]);
+        table[i] = be64_to_cpu(table[i]);
         ret = check_table_entry(table[i], s->cluster_size);
         if (ret < 0) {
             goto fail;
@@ -394,20 +394,20 @@ fail:
 
 static inline void bitmap_dir_entry_to_cpu(Qcow2BitmapDirEntry *entry)
 {
-    be64_to_cpus(&entry->bitmap_table_offset);
-    be32_to_cpus(&entry->bitmap_table_size);
-    be32_to_cpus(&entry->flags);
-    be16_to_cpus(&entry->name_size);
-    be32_to_cpus(&entry->extra_data_size);
+    entry->bitmap_table_offset = be64_to_cpu(entry->bitmap_table_offset);
+    entry->bitmap_table_size = be32_to_cpu(entry->bitmap_table_size);
+    entry->flags = be32_to_cpu(entry->flags);
+    entry->name_size = be16_to_cpu(entry->name_size);
+    entry->extra_data_size = be32_to_cpu(entry->extra_data_size);
 }
 
 static inline void bitmap_dir_entry_to_be(Qcow2BitmapDirEntry *entry)
 {
-    cpu_to_be64s(&entry->bitmap_table_offset);
-    cpu_to_be32s(&entry->bitmap_table_size);
-    cpu_to_be32s(&entry->flags);
-    cpu_to_be16s(&entry->name_size);
-    cpu_to_be32s(&entry->extra_data_size);
+    entry->bitmap_table_offset = cpu_to_be64(entry->bitmap_table_offset);
+    entry->bitmap_table_size = cpu_to_be32(entry->bitmap_table_size);
+    entry->flags = cpu_to_be32(entry->flags);
+    entry->name_size = cpu_to_be16(entry->name_size);
+    entry->extra_data_size = cpu_to_be32(entry->extra_data_size);
 }
 
 static inline int calc_dir_entry_size(size_t name_size, size_t extra_data_size)
-- 
2.19.0
