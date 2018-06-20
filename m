Received: from eggs.gnu.org ([2001:4830:134:3::10]:49282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVePe-00010S-PX
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:48:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVePd-0004zv-R8
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 10:48:46 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed, 20 Jun 2018 17:48:36 +0300
Message-Id: <20180620144837.19341-3-vsementsov@virtuozzo.com>
In-Reply-To: <20180620144837.19341-1-vsementsov@virtuozzo.com>
References: <20180620144837.19341-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/3] qcow2: refactor data compression
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, stefanha@gmail.com, pl@kamp.de, den@openvz.org, vsementsov@virtuozzo.com

Make a separate function for compression to be parallelized later.
 - use .avail_out field instead of .next_out to calculate size of
   compressed data. It looks more natural and it allows to keep dest to
   be void pointer
 - set avail_out to be at least one byte less than input, to be sure
   avoid inefficient compression earlier

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.c | 76 ++++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 49 insertions(+), 27 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 945132f692..e431c73e0d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -23,11 +23,14 @@
  */
 
 #include "qemu/osdep.h"
+
+#define ZLIB_CONST
+#include <zlib.h>
+
 #include "block/block_int.h"
 #include "block/qdict.h"
 #include "sysemu/block-backend.h"
 #include "qemu/module.h"
-#include <zlib.h>
 #include "qcow2.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
@@ -3671,6 +3674,46 @@ static int qcow2_truncate(BlockDriverState *bs, int64_t offset,
     return 0;
 }
 
+/*
+ * qcow2_compress()
+ *
+ * @dest - destination buffer, at least of @size-1 bytes
+ * @src - source buffer, @size bytes
+ *
+ * Returns: compressed size on success
+ *          -1 if compression is inefficient
+ *          -2 on any other error
+ */
+static ssize_t qcow2_compress(void *dest, const void *src, size_t size)
+{
+    ssize_t ret;
+    z_stream strm;
+
+    /* best compression, small window, no zlib header */
+    memset(&strm, 0, sizeof(strm));
+    ret = deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
+                       -12, 9, Z_DEFAULT_STRATEGY);
+    if (ret != 0) {
+        return -2;
+    }
+
+    strm.avail_in = size;
+    strm.next_in = src;
+    strm.avail_out = size - 1;
+    strm.next_out = dest;
+
+    ret = deflate(&strm, Z_FINISH);
+    if (ret == Z_STREAM_END) {
+        ret = size - 1 - strm.avail_out;
+    } else {
+        ret = (ret == Z_OK ? -1 : -2);
+    }
+
+    deflateEnd(&strm);
+
+    return ret;
+}
+
 /* XXX: put compressed sectors first, then all the cluster aligned
    tables to avoid losing bytes in alignment */
 static coroutine_fn int
@@ -3680,8 +3723,8 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
     BDRVQcow2State *s = bs->opaque;
     QEMUIOVector hd_qiov;
     struct iovec iov;
-    z_stream strm;
-    int ret, out_len;
+    int ret;
+    size_t out_len;
     uint8_t *buf, *out_buf;
     int64_t cluster_offset;
 
@@ -3714,32 +3757,11 @@ qcow2_co_pwritev_compressed(BlockDriverState *bs, uint64_t offset,
 
     out_buf = g_malloc(s->cluster_size);
 
-    /* best compression, small window, no zlib header */
-    memset(&strm, 0, sizeof(strm));
-    ret = deflateInit2(&strm, Z_DEFAULT_COMPRESSION,
-                       Z_DEFLATED, -12,
-                       9, Z_DEFAULT_STRATEGY);
-    if (ret != 0) {
+    out_len = qcow2_compress(out_buf, buf, s->cluster_size);
+    if (out_len == -2) {
         ret = -EINVAL;
         goto fail;
-    }
-
-    strm.avail_in = s->cluster_size;
-    strm.next_in = (uint8_t *)buf;
-    strm.avail_out = s->cluster_size;
-    strm.next_out = out_buf;
-
-    ret = deflate(&strm, Z_FINISH);
-    if (ret != Z_STREAM_END && ret != Z_OK) {
-        deflateEnd(&strm);
-        ret = -EINVAL;
-        goto fail;
-    }
-    out_len = strm.next_out - out_buf;
-
-    deflateEnd(&strm);
-
-    if (ret != Z_STREAM_END || out_len >= s->cluster_size) {
+    } else if (out_len == -1) {
         /* could not compress: write normal cluster */
         ret = qcow2_co_pwritev(bs, offset, bytes, qiov, 0);
         if (ret < 0) {
-- 
2.11.1
