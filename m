Received: from eggs.gnu.org ([2001:4830:134:3::10]:46575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9vkq-0004dW-Qg
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:25:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1g9vkq-00055V-1Y
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 13:25:08 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  9 Oct 2018 18:25:00 +0100
Message-Id: <20181009172501.17353-3-peter.maydell@linaro.org>
In-Reply-To: <20181009172501.17353-1-peter.maydell@linaro.org>
References: <20181009172501.17353-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 2/3] block/qcow: Don't take address of fields
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
 block/qcow.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 385d935258f..4518cb4c35e 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -140,14 +140,14 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
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
+    header.magic = be32_to_cpu(header.magic);
+    header.version = be32_to_cpu(header.version);
+    header.backing_file_offset = be64_to_cpu(header.backing_file_offset);
+    header.backing_file_size = be32_to_cpu(header.backing_file_size);
+    header.mtime = be32_to_cpu(header.mtime);
+    header.size = be64_to_cpu(header.size);
+    header.crypt_method = be32_to_cpu(header.crypt_method);
+    header.l1_table_offset = be64_to_cpu(header.l1_table_offset);
 
     if (header.magic != QCOW_MAGIC) {
         error_setg(errp, "Image not in qcow format");
@@ -270,7 +270,7 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     }
 
     for(i = 0;i < s->l1_size; i++) {
-        be64_to_cpus(&s->l1_table[i]);
+        s->l1_table[i] = be64_to_cpu(s->l1_table[i]);
     }
 
     /* alloc L2 cache (max. 64k * 16 * 8 = 8 MB) */
-- 
2.19.0
