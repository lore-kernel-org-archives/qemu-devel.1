Received: from eggs.gnu.org ([2001:4830:134:3::10]:34839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEjj-00083O-PB
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gQEje-0002CI-J7
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 11:55:23 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 23 Nov 2018 19:55:07 +0300
Message-Id: <20181123165511.416480-8-vsementsov@virtuozzo.com>
In-Reply-To: <20181123165511.416480-1-vsementsov@virtuozzo.com>
References: <20181123165511.416480-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 07/11] qcow2-threads: add encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berrange@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org

Add thread-based encrypt/decrypt. QCrypto don't support parallel
operations with one block, so we need QCryptoBlock for each thread.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2.h         | 12 +++++++++
 block/qcow2-threads.c | 62 +++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.c         | 57 ++++++++++++++++++++++++++++++++-------
 3 files changed, 122 insertions(+), 9 deletions(-)

diff --git a/block/qcow2.h b/block/qcow2.h
index 7bef0393ce..351ad8d3e7 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -260,6 +260,12 @@ typedef struct Qcow2BitmapHeaderExt {
 #define QCOW2_MAX_THREADS 4
 typedef struct Qcow2PerThreadData {
     bool in_use;
+
+    /* QCryptoBlock doesn't support parallel operations in threads, so we can't
+     * use BDRVQcow2State.crypto and instead we need separate crypto block for
+     * each thread.
+     */
+    QCryptoBlock *crypto;
 } Qcow2PerThreadData;
 
 typedef struct Qcow2ThreadsState {
@@ -711,5 +717,11 @@ qcow2_co_compress(BlockDriverState *bs, void *dest, size_t dest_size,
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
diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 3ed990ef2f..0a75c1aead 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -30,6 +30,7 @@
 
 #include "qcow2.h"
 #include "block/thread-pool.h"
+#include "crypto.h"
 
 typedef struct Qcow2ProcessData {
     Qcow2PerThreadData *self;
@@ -217,3 +218,64 @@ qcow2_co_decompress(BlockDriverState *bs, void *dest, size_t dest_size,
     return qcow2_co_do_compress(bs, dest, dest_size, src, src_size,
                                 qcow2_decompress);
 }
+
+
+/*
+ * Encryption
+ */
+
+typedef int (*Qcow2EncryptFunc)(QCryptoBlock *block, uint64_t offset,
+                                uint8_t *buf, size_t len, Error **errp);
+/*
+ * encrypt functions are qcrypto_block_encrypt() and qcrypto_block_decrypt()
+ */
+
+typedef struct Qcow2EncryptData {
+    uint64_t offset;
+    uint8_t *buf;
+    size_t len;
+
+    Qcow2EncryptFunc func;
+} Qcow2EncryptData;
+
+static int qcow2_encrypt_pool_func(void *opaque)
+{
+    Qcow2ProcessData *pdata = opaque;
+    Qcow2EncryptData *data = pdata->arg;
+
+    return data->func(pdata->self->crypto,
+                      data->offset, data->buf, data->len, NULL);
+}
+
+static int coroutine_fn
+qcow2_co_do_crypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                  uint64_t offset, void *buf, size_t len, Qcow2EncryptFunc func)
+{
+    BDRVQcow2State *s = bs->opaque;
+    Qcow2EncryptData arg = {
+        .offset = s->crypt_physical_offset ?
+                      file_cluster_offset + offset_into_cluster(s, offset) :
+                      offset,
+        .buf = buf,
+        .len = len,
+        .func = func,
+    };
+
+    return qcow2_co_process(bs, qcow2_encrypt_pool_func, &arg);
+}
+
+int coroutine_fn
+qcow2_co_encrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len)
+{
+    return qcow2_co_do_crypt(bs, file_cluster_offset, offset, buf, len,
+                             qcrypto_block_encrypt);
+}
+
+int coroutine_fn
+qcow2_co_decrypt(BlockDriverState *bs, uint64_t file_cluster_offset,
+                 uint64_t offset, void *buf, size_t len)
+{
+    return qcow2_co_do_crypt(bs, file_cluster_offset, offset, buf, len,
+                             qcrypto_block_decrypt);
+}
diff --git a/block/qcow2.c b/block/qcow2.c
index 295ae926ee..1e28f17373 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -170,6 +170,47 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
     return ret;
 }
 
+static void qcow2_crypto_blocks_free(BDRVQcow2State *s)
+{
+    int i;
+
+    qcrypto_block_free(s->crypto);
+    s->crypto = NULL;
+
+    for (i = 0; i < QCOW2_MAX_THREADS; i++) {
+        qcrypto_block_free(s->threads.per_thread[i].crypto);
+        s->threads.per_thread[i].crypto = NULL;
+    }
+}
+
+static int qcow2_crypto_blocks_open(BDRVQcow2State *s,
+                                    const char *optprefix,
+                                    QCryptoBlockReadFunc readfunc,
+                                    void *opaque,
+                                    unsigned int flags,
+                                    Error **errp)
+{
+    int i;
+
+    s->crypto = qcrypto_block_open(s->crypto_opts, optprefix,
+                                   readfunc, opaque, flags, errp);
+    if (!s->crypto) {
+        qcrypto_block_free(s->crypto);
+        return -EINVAL;
+    }
+
+    for (i = 0; i < QCOW2_MAX_THREADS; i++) {
+        s->threads.per_thread[i].crypto =
+                qcrypto_block_open(s->crypto_opts, optprefix,
+                                   readfunc, opaque, flags, errp);
+        if (!s->threads.per_thread[i].crypto) {
+            qcow2_crypto_blocks_free(s);
+            return -EINVAL;
+        }
+    }
+
+    return 0;
+}
 
 /* 
  * read qcow2 extension and fill bs
@@ -295,11 +336,11 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             if (flags & BDRV_O_NO_IO) {
                 cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
             }
-            s->crypto = qcrypto_block_open(s->crypto_opts, "encrypt.",
+            ret = qcow2_crypto_blocks_open(s, "encrypt.",
                                            qcow2_crypto_hdr_read_func,
                                            bs, cflags, errp);
-            if (!s->crypto) {
-                return -EINVAL;
+            if (ret < 0) {
+                return ret;
             }
         }   break;
 
@@ -1446,10 +1487,9 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
             if (flags & BDRV_O_NO_IO) {
                 cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
             }
-            s->crypto = qcrypto_block_open(s->crypto_opts, "encrypt.",
+            ret = qcow2_crypto_blocks_open(s, "encrypt.",
                                            NULL, NULL, cflags, errp);
-            if (!s->crypto) {
-                ret = -EINVAL;
+            if (ret < 0) {
                 goto fail;
             }
         } else if (!(flags & BDRV_O_NO_IO)) {
@@ -1619,7 +1659,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
     if (s->refcount_block_cache) {
         qcow2_cache_destroy(s->refcount_block_cache);
     }
-    qcrypto_block_free(s->crypto);
+    qcow2_crypto_blocks_free(s);
     qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
     return ret;
 }
@@ -2214,8 +2254,7 @@ static void qcow2_close(BlockDriverState *bs)
     qcow2_cache_destroy(s->l2_table_cache);
     qcow2_cache_destroy(s->refcount_block_cache);
 
-    qcrypto_block_free(s->crypto);
-    s->crypto = NULL;
+    qcow2_crypto_blocks_free(s);
 
     g_free(s->unknown_header_fields);
     cleanup_unknown_header_ext(bs);
-- 
2.18.0
