Received: from eggs.gnu.org ([209.51.188.92]:35659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gguqS-00078Q-Qp
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:07:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gguqM-0004o1-P0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:07:16 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  8 Jan 2019 20:06:55 +0300
Message-Id: <20190108170655.29766-10-vsementsov@virtuozzo.com>
In-Reply-To: <20190108170655.29766-1-vsementsov@virtuozzo.com>
References: <20190108170655.29766-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 9/9] qcow2: do encryption in threads
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org, pbonzini@redhat.com

Do encryption/decryption in threads, like it is already done for
compression. This improves asynchronous encrypted io.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h         |  8 ++++++
 block/qcow2-cluster.c |  7 ++---
 block/qcow2-threads.c | 65 +++++++++++++++++++++++++++++++++++++++++--
 block/qcow2.c         | 22 +++++----------
 4 files changed, 81 insertions(+), 21 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 9c2f6749ba..7e75f20373 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -257,6 +257,8 @@ typedef struct Qcow2BitmapHeaderExt {
     uint64_t bitmap_directory_offset;
 } QEMU_PACKED Qcow2BitmapHeaderExt;
 
+#define QCOW2_MAX_THREADS 4
+
 typedef struct BDRVQcow2State {
     int cluster_bits;
     int cluster_size;
@@ -701,5 +703,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
 ssize_t coroutine_fn
 qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
                     const void *src, size_t src_size);
+int coroutine_fn
+qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len);
+int coroutine_fn
+qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len);
 
 #endif
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 7815772116..55dd4144de 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -467,13 +467,12 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
 {
     if (bytes && bs->encrypted) {
         BDRVQcow2State *s = bs->opaque;
-        int64_t offset = (s->crypt_physical_offset ?
-                          (cluster_offset + offset_in_cluster) :
-                          (src_cluster_offset + offset_in_cluster));
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
         assert(s->crypto);
-        if (qcrypto_block_encrypt(s->crypto, offset, buffer, bytes, NULL) < 0) {
+        if (qcow2_co_encrypt(bs, cluster_offset,
+                             src_cluster_offset + offset_in_cluster,
+                             buffer, bytes) < 0) {
             return false;
         }
     }
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index e3066075da..0e20723a4b 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -30,8 +30,7 @@
 
 #include "qcow2.h"
 #include "block/thread-pool.h"
-
-#define QCOW2_MAX_THREADS 4
+#include "crypto.h"
 
 static int coroutine_fn
 qcow2_co_process(BlockDriverState *bs, ThreadPoolFunc *func, void *arg)
@@ -205,3 +204,65 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
     return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
                                 qcow2_decompress);
 }
+
+
+/*
+ * Cryptography
+ */
+
+/*
+ * Qcow2EncDecFunc: common prototype of qcrypto_block_encrypt() and
+ * qcrypto_block_decrypt() functions.
+ */
+typedef int (*Qcow2EncDecFunc)(QCryptoBlock *block, uint64_t offset,
+                               uint8_t *buf, size_t len, Error **errp);
+
+typedef struct Qcow2EncDecData {
+    QCryptoBlock *block;
+    uint64_t offset;
+    uint8_t *buf;
+    size_t len;
+
+    Qcow2EncDecFunc func;
+} Qcow2EncDecData;
+
+static int qcow2_encdec_pool_func(void *opaque)
+{
+    Qcow2EncDecData *data = opaque;
+
+    return data->func(data->block, data->offset, data->buf, data->len, NULL);
+}
+
+static int coroutine_fn
+qcow2_co_encdec(BlockDriverState *bs, uint64_t file_cluster_offset,
+                  uint64_t offset, void *buf, size_t len, Qcow2EncDecFunc func)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2EncDecData arg = {
+        .block = s->crypto,
+        .offset = s->crypt_physical_offset ?
+                      file_cluster_offset + offset_into_cluster(s, offset) :
+                      offset,
+        .buf = buf,
+        .len = len,
+        .func = func,
+    };
+
+    return qcow2_co_process(bs, qcow2_encdec_pool_func, &arg);
+}
+
+int coroutine_fn
+qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len)
+{
+    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
+                             qcrypto_block_encrypt);
+}
+
+int coroutine_fn
+qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len)
+{
+    return qcow2_co_encdec(bs, file_cluster_offset, offset, buf, len,
+                             qcrypto_block_decrypt);
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 76d3715350..f94e5960f2 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -296,7 +296,7 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             }
             s->crypto = qcrypto_block_open(s->crypto_opts, "encrypt.",
                                            qcow2_crypto_hdr_read_func,
-                                           bs, cflags, 1, errp);
+                                           bs, cflags, QCOW2_MAX_THREADS, errp);
             if (!s->crypto) {
                 return -EINVAL;
             }
@@ -1446,7 +1446,8 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
                 cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
             }
             s->crypto = qcrypto_block_open(s->crypto_opts, "encrypt.",
-                                           NULL, NULL, cflags, 1, errp);
+                                           NULL, NULL, cflags,
+                                           QCOW2_MAX_THREADS, errp);
             if (!s->crypto) {
                 ret = -EINVAL;
                 goto fail;
@@ -1966,13 +1967,8 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                 assert(s->crypto);
                 assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
                 assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
-                if (qcrypto_block_decrypt(s->crypto,
-                                          (s->crypt_physical_offset ?
-                                           cluster_offset + offset_in_cluster :
-                                           offset),
-                                          cluster_data,
-                                          cur_bytes,
-                                          NULL) < 0) {
+                if (qcow2_co_decrypt(bs, cluster_offset, offset,
+                                     cluster_data, cur_bytes) < 0) {
                     ret = -EIO;
                     goto fail;
                 }
@@ -2110,12 +2106,8 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
             qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
 
-            if (qcrypto_block_encrypt(s->crypto,
-                                      (s->crypt_physical_offset ?
-                                       cluster_offset + offset_in_cluster :
-                                       offset),
-                                      cluster_data,
-                                      cur_bytes, NULL) < 0) {
+            if (qcow2_co_encrypt(bs, cluster_offset, offset,
+                                 cluster_data, cur_bytes) < 0) {
                 ret = -EIO;
                 goto out_unlocked;
             }
-- 
2.18.0
