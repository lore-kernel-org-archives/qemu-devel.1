Received: from eggs.gnu.org ([2001:4830:134:3::10]:46609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9vks-0004fr-85
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:25:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9vkr-00058r-5A
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:25:10 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Oct 2018 18:24:59 +0100
Message-Id: <20181009172501.17353-2-peter.maydell@linaro.org>
In-Reply-To: <20181009172501.17353-1-peter.maydell@linaro.org>
References: <20181009172501.17353-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 1/3] block/qcow2: Don't take address of fields
 in packed structs
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

This patch was produced with the following spatch script
(and hand-editing to fold a few resulting overlength lines):

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
 block/qcow2.c | 64 +++++++++++++++++++++++++++------------------------
 1 file changed, 34 insertions(+), 30 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 7277feda135..33e12bbe0fd 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -210,8 +210,8 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                              "pread fail from offset %" PRIu64, offset);
             return 1;
         }
-        be32_to_cpus(&ext.magic);
-        be32_to_cpus(&ext.len);
+        ext.magic = be32_to_cpu(ext.magic);
+        ext.len = be32_to_cpu(ext.len);
         offset += sizeof(ext);
 #ifdef DEBUG_EXT
         printf("ext.magic = 0x%x\n", ext.magic);
@@ -279,8 +279,8 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                                  "Unable to read CRYPTO header extension");
                 return ret;
             }
-            be64_to_cpus(&s->crypto_header.offset);
-            be64_to_cpus(&s->crypto_header.length);
+            s->crypto_header.offset = be64_to_cpu(s->crypto_header.offset);
+            s->crypto_header.length = be64_to_cpu(s->crypto_header.length);
 
             if ((s->crypto_header.offset % s->cluster_size) != 0) {
                 error_setg(errp, "Encryption header offset '%" PRIu64 "' is "
@@ -342,9 +342,11 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                 return -EINVAL;
             }
 
-            be32_to_cpus(&bitmaps_ext.nb_bitmaps);
-            be64_to_cpus(&bitmaps_ext.bitmap_directory_size);
-            be64_to_cpus(&bitmaps_ext.bitmap_directory_offset);
+            bitmaps_ext.nb_bitmaps = be32_to_cpu(bitmaps_ext.nb_bitmaps);
+            bitmaps_ext.bitmap_directory_size =
+                be64_to_cpu(bitmaps_ext.bitmap_directory_size);
+            bitmaps_ext.bitmap_directory_offset =
+                be64_to_cpu(bitmaps_ext.bitmap_directory_offset);
 
             if (bitmaps_ext.nb_bitmaps > QCOW2_MAX_BITMAPS) {
                 error_setg(errp,
@@ -1160,19 +1162,20 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
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
+    header.magic = be32_to_cpu(header.magic);
+    header.version = be32_to_cpu(header.version);
+    header.backing_file_offset = be64_to_cpu(header.backing_file_offset);
+    header.backing_file_size = be32_to_cpu(header.backing_file_size);
+    header.size = be64_to_cpu(header.size);
+    header.cluster_bits = be32_to_cpu(header.cluster_bits);
+    header.crypt_method = be32_to_cpu(header.crypt_method);
+    header.l1_table_offset = be64_to_cpu(header.l1_table_offset);
+    header.l1_size = be32_to_cpu(header.l1_size);
+    header.refcount_table_offset = be64_to_cpu(header.refcount_table_offset);
+    header.refcount_table_clusters =
+        be32_to_cpu(header.refcount_table_clusters);
+    header.snapshots_offset = be64_to_cpu(header.snapshots_offset);
+    header.nb_snapshots = be32_to_cpu(header.nb_snapshots);
 
     if (header.magic != QCOW_MAGIC) {
         error_setg(errp, "Image is not in qcow2 format");
@@ -1208,11 +1211,12 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
         header.refcount_order           = 4;
         header.header_length            = 72;
     } else {
-        be64_to_cpus(&header.incompatible_features);
-        be64_to_cpus(&header.compatible_features);
-        be64_to_cpus(&header.autoclear_features);
-        be32_to_cpus(&header.refcount_order);
-        be32_to_cpus(&header.header_length);
+        header.incompatible_features =
+            be64_to_cpu(header.incompatible_features);
+        header.compatible_features = be64_to_cpu(header.compatible_features);
+        header.autoclear_features = be64_to_cpu(header.autoclear_features);
+        header.refcount_order = be32_to_cpu(header.refcount_order);
+        header.header_length = be32_to_cpu(header.header_length);
 
         if (header.header_length < 104) {
             error_setg(errp, "qcow2 header too short");
@@ -1401,7 +1405,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
             goto fail;
         }
         for(i = 0;i < s->l1_size; i++) {
-            be64_to_cpus(&s->l1_table[i]);
+            s->l1_table[i] = be64_to_cpu(s->l1_table[i]);
         }
     }
 
@@ -2346,13 +2350,13 @@ int qcow2_update_header(BlockDriverState *bs)
 
     /* Full disk encryption header pointer extension */
     if (s->crypto_header.offset != 0) {
-        cpu_to_be64s(&s->crypto_header.offset);
-        cpu_to_be64s(&s->crypto_header.length);
+        s->crypto_header.offset = cpu_to_be64(s->crypto_header.offset);
+        s->crypto_header.length = cpu_to_be64(s->crypto_header.length);
         ret = header_ext_add(buf, QCOW2_EXT_MAGIC_CRYPTO_HEADER,
                              &s->crypto_header, sizeof(s->crypto_header),
                              buflen);
-        be64_to_cpus(&s->crypto_header.offset);
-        be64_to_cpus(&s->crypto_header.length);
+        s->crypto_header.offset = be64_to_cpu(s->crypto_header.offset);
+        s->crypto_header.length = be64_to_cpu(s->crypto_header.length);
         if (ret < 0) {
             goto fail;
         }
-- 
2.19.0
