Received: from eggs.gnu.org ([2001:4830:134:3::10]:45035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUYSI-0000o8-Pw
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:47:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gUYSG-0003nj-8p
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 09:47:14 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Wed,  5 Dec 2018 17:47:00 +0300
Message-Id: <20181205144700.26563-6-vsementsov@virtuozzo.com>
In-Reply-To: <20181205144700.26563-1-vsementsov@virtuozzo.com>
References: <20181205144700.26563-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 5/5] crypto: support multiple threads
 accessing one QCryptoBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: berrange@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

The two thing that should be handled are cipher and ivgen. For ivgen
the solution is just mutex, as iv calculations should not be long in
comparison with encryption/decryption. And for cipher let's just keep
per-thread ciphers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 crypto/blockpriv.h        |  16 ++++-
 include/crypto/block.h    |   3 +
 block/crypto.c            |   1 +
 block/qcow.c              |   2 +-
 block/qcow2.c             |   4 +-
 crypto/block-luks.c       |  25 +++----
 crypto/block-qcow.c       |  20 +++---
 crypto/block.c            | 146 +++++++++++++++++++++++++++++++++-----
 tests/test-crypto-block.c |   3 +
 9 files changed, 176 insertions(+), 44 deletions(-)

diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index e9fe3e5687..86dae49210 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -22,6 +22,7 @@
 #define QCRYPTO_BLOCKPRIV_H
 
 #include "crypto/block.h"
+#include "qemu/thread.h"
 
 typedef struct QCryptoBlockDriver QCryptoBlockDriver;
 
@@ -31,8 +32,12 @@ struct QCryptoBlock {
     const QCryptoBlockDriver *driver;
     void *opaque;
 
-    QCryptoCipher *cipher;
+    QCryptoCipher **ciphers;
+    int n_ciphers;
+    int n_free_ciphers;
     QCryptoIVGen *ivgen;
+    QemuMutex mutex;
+
     QCryptoHashAlgorithm kdfhash;
     size_t niv;
     uint64_t payload_offset; /* In bytes */
@@ -46,6 +51,7 @@ struct QCryptoBlockDriver {
                 QCryptoBlockReadFunc readfunc,
                 void *opaque,
                 unsigned int flags,
+                int n_threads,
                 Error **errp);
 
     int (*create)(QCryptoBlock *block,
@@ -110,4 +116,12 @@ int qcrypto_block_encrypt_helper(QCryptoBlock *block,
                                  size_t len,
                                  Error **errp);
 
+int qcrypto_block_init_cipher(QCryptoBlock *block,
+                              QCryptoCipherAlgorithm alg,
+                              QCryptoCipherMode mode,
+                              const uint8_t *key, size_t nkey,
+                              int n_threads, Error **errp);
+
+void qcrypto_block_free_cipher(QCryptoBlock *block);
+
 #endif /* QCRYPTO_BLOCKPRIV_H */
diff --git a/include/crypto/block.h b/include/crypto/block.h
index cd18f46d56..866a89b06a 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -75,6 +75,8 @@ typedef enum {
  * @readfunc: callback for reading data from the volume
  * @opaque: data to pass to @readfunc
  * @flags: bitmask of QCryptoBlockOpenFlags values
+ * @n_threads: prepare block to multi tasking with up to
+ *             @n_threads threads
  * @errp: pointer to a NULL-initialized error object
  *
  * Create a new block encryption object for an existing
@@ -107,6 +109,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
                                  QCryptoBlockReadFunc readfunc,
                                  void *opaque,
                                  unsigned int flags,
+                                 int n_threads,
                                  Error **errp);
 
 /**
diff --git a/block/crypto.c b/block/crypto.c
index 33ee01bebd..f0a5f6b987 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -229,6 +229,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
                                        block_crypto_read_func,
                                        bs,
                                        cflags,
+                                       1,
                                        errp);
 
     if (!crypto->block) {
diff --git a/block/qcow.c b/block/qcow.c
index 4518cb4c35..0a235bf393 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -213,7 +213,7 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
                 cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
             }
             s->crypto = qcrypto_block_open(crypto_opts, "encrypt.",
-                                           NULL, NULL, cflags, errp);
+                                           NULL, NULL, cflags, 1, errp);
             if (!s->crypto) {
                 ret = -EINVAL;
                 goto fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 991d6ac91b..bc8868c36a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -294,7 +294,7 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             }
             s->crypto = qcrypto_block_open(s->crypto_opts, "encrypt.",
                                            qcow2_crypto_hdr_read_func,
-                                           bs, cflags, errp);
+                                           bs, cflags, 1, errp);
             if (!s->crypto) {
                 return -EINVAL;
             }
@@ -1445,7 +1445,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverState *bs, QDict *options,
                 cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
             }
             s->crypto = qcrypto_block_open(s->crypto_opts, "encrypt.",
-                                           NULL, NULL, cflags, errp);
+                                           NULL, NULL, cflags, 1, errp);
             if (!s->crypto) {
                 ret = -EINVAL;
                 goto fail;
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index bbffd80fff..41fb0aa2e7 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -636,6 +636,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                         QCryptoBlockReadFunc readfunc,
                         void *opaque,
                         unsigned int flags,
+                        int n_threads,
                         Error **errp)
 {
     QCryptoBlockLUKS *luks;
@@ -836,11 +837,10 @@ qcrypto_block_luks_open(QCryptoBlock *block,
             goto fail;
         }
 
-        block->cipher = qcrypto_cipher_new(cipheralg,
-                                           ciphermode,
-                                           masterkey, masterkeylen,
-                                           errp);
-        if (!block->cipher) {
+        ret = qcrypto_block_init_cipher(block, cipheralg, ciphermode,
+                                        masterkey, masterkeylen, n_threads,
+                                        errp);
+        if (ret < 0) {
             ret = -ENOTSUP;
             goto fail;
         }
@@ -863,7 +863,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 
  fail:
     g_free(masterkey);
-    qcrypto_cipher_free(block->cipher);
+    qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
     g_free(luks);
     g_free(password);
@@ -888,6 +888,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
                           void *opaque,
                           Error **errp)
 {
+    int ret;
     QCryptoBlockLUKS *luks;
     QCryptoBlockCreateOptionsLUKS luks_opts;
     Error *local_err = NULL;
@@ -1030,11 +1031,11 @@ qcrypto_block_luks_create(QCryptoBlock *block,
 
 
     /* Setup the block device payload encryption objects */
-    block->cipher = qcrypto_cipher_new(luks_opts.cipher_alg,
-                                       luks_opts.cipher_mode,
-                                       masterkey, luks->header.key_bytes,
-                                       errp);
-    if (!block->cipher) {
+    ret = qcrypto_block_init_cipher(block, luks_opts.cipher_alg,
+                                    luks_opts.cipher_mode,
+                                    masterkey, luks->header.key_bytes,
+                                    1, errp);
+    if (ret < 0) {
         goto error;
     }
 
@@ -1341,7 +1342,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     qcrypto_ivgen_free(ivgen);
     qcrypto_cipher_free(cipher);
 
-    qcrypto_cipher_free(block->cipher);
+    qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
 
     g_free(luks);
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index 36bf5f09b7..e668145561 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -44,6 +44,7 @@ qcrypto_block_qcow_has_format(const uint8_t *buf G_GNUC_UNUSED,
 static int
 qcrypto_block_qcow_init(QCryptoBlock *block,
                         const char *keysecret,
+                        int n_threads,
                         Error **errp)
 {
     char *password;
@@ -71,11 +72,11 @@ qcrypto_block_qcow_init(QCryptoBlock *block,
         goto fail;
     }
 
-    block->cipher = qcrypto_cipher_new(QCRYPTO_CIPHER_ALG_AES_128,
-                                       QCRYPTO_CIPHER_MODE_CBC,
-                                       keybuf, G_N_ELEMENTS(keybuf),
-                                       errp);
-    if (!block->cipher) {
+    ret = qcrypto_block_init_cipher(block, QCRYPTO_CIPHER_ALG_AES_128,
+                                    QCRYPTO_CIPHER_MODE_CBC,
+                                    keybuf, G_N_ELEMENTS(keybuf),
+                                    n_threads, errp);
+    if (ret < 0) {
         ret = -ENOTSUP;
         goto fail;
     }
@@ -86,7 +87,7 @@ qcrypto_block_qcow_init(QCryptoBlock *block,
     return 0;
 
  fail:
-    qcrypto_cipher_free(block->cipher);
+    qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
     return ret;
 }
@@ -99,6 +100,7 @@ qcrypto_block_qcow_open(QCryptoBlock *block,
                         QCryptoBlockReadFunc readfunc G_GNUC_UNUSED,
                         void *opaque G_GNUC_UNUSED,
                         unsigned int flags,
+                        int n_threads,
                         Error **errp)
 {
     if (flags & QCRYPTO_BLOCK_OPEN_NO_IO) {
@@ -112,8 +114,8 @@ qcrypto_block_qcow_open(QCryptoBlock *block,
                        optprefix ? optprefix : "");
             return -1;
         }
-        return qcrypto_block_qcow_init(block,
-                                       options->u.qcow.key_secret, errp);
+        return qcrypto_block_qcow_init(block, options->u.qcow.key_secret,
+                                       n_threads, errp);
     }
 }
 
@@ -133,7 +135,7 @@ qcrypto_block_qcow_create(QCryptoBlock *block,
         return -1;
     }
     /* QCow2 has no special header, since everything is hardwired */
-    return qcrypto_block_qcow_init(block, options->u.qcow.key_secret, errp);
+    return qcrypto_block_qcow_init(block, options->u.qcow.key_secret, 1, errp);
 }
 
 
diff --git a/crypto/block.c b/crypto/block.c
index 3edd9ec251..43426268e6 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -52,10 +52,13 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
                                  QCryptoBlockReadFunc readfunc,
                                  void *opaque,
                                  unsigned int flags,
+                                 int n_threads,
                                  Error **errp)
 {
     QCryptoBlock *block = g_new0(QCryptoBlock, 1);
 
+    qemu_mutex_init(&block->mutex);
+
     block->format = options->format;
 
     if (options->format >= G_N_ELEMENTS(qcrypto_block_drivers) ||
@@ -69,7 +72,8 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
     block->driver = qcrypto_block_drivers[options->format];
 
     if (block->driver->open(block, options, optprefix,
-                            readfunc, opaque, flags, errp) < 0) {
+                            readfunc, opaque, flags, n_threads, errp) < 0)
+    {
         g_free(block);
         return NULL;
     }
@@ -87,6 +91,8 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
 {
     QCryptoBlock *block = g_new0(QCryptoBlock, 1);
 
+    qemu_mutex_init(&block->mutex);
+
     block->format = options->format;
 
     if (options->format >= G_N_ELEMENTS(qcrypto_block_drivers) ||
@@ -148,12 +154,94 @@ int qcrypto_block_encrypt(QCryptoBlock *block,
 
 QCryptoCipher *qcrypto_block_get_cipher(QCryptoBlock *block)
 {
-    return block->cipher;
+    /* ivgen should be accessed under mutex. However, this function is used only
+     * in test with one thread, so it's enough to assert it here:
+     */
+    assert(block->n_ciphers <= 1);
+    return block->ciphers ? block->ciphers[0] : NULL;
 }
 
 
+static QCryptoCipher *qcrypto_block_pop_cipher(QCryptoBlock *block)
+{
+    QCryptoCipher *cipher;
+
+    qemu_mutex_lock(&block->mutex);
+
+    assert(block->n_free_ciphers > 0);
+    block->n_free_ciphers--;
+    cipher = block->ciphers[block->n_free_ciphers];
+
+    qemu_mutex_unlock(&block->mutex);
+
+    return cipher;
+}
+
+
+static void qcrypto_block_push_cipher(QCryptoBlock *block,
+                                      QCryptoCipher *cipher)
+{
+    qemu_mutex_lock(&block->mutex);
+
+    assert(block->n_free_ciphers < block->n_ciphers);
+    block->ciphers[block->n_free_ciphers] = cipher;
+    block->n_free_ciphers++;
+
+    qemu_mutex_unlock(&block->mutex);
+}
+
+
+int qcrypto_block_init_cipher(QCryptoBlock *block,
+                              QCryptoCipherAlgorithm alg,
+                              QCryptoCipherMode mode,
+                              const uint8_t *key, size_t nkey,
+                              int n_threads, Error **errp)
+{
+    int i;
+
+    assert(!block->ciphers && !block->n_ciphers && !block->n_free_ciphers);
+
+    block->ciphers = g_new0(QCryptoCipher *, n_threads);
+
+    for (i = 0; i < n_threads; i++) {
+        block->ciphers[i] = qcrypto_cipher_new(alg, mode, key, nkey, errp);
+        if (!block->ciphers[i]) {
+            qcrypto_block_free_cipher(block);
+            return -1;
+        }
+        block->n_ciphers++;
+        block->n_free_ciphers++;
+    }
+
+    return 0;
+}
+
+
+void qcrypto_block_free_cipher(QCryptoBlock *block)
+{
+    int i;
+
+    if (!block->ciphers) {
+        return;
+    }
+
+    assert(block->n_ciphers == block->n_free_ciphers);
+
+    for (i = 0; i < block->n_ciphers; i++) {
+        qcrypto_cipher_free(block->ciphers[i]);
+    }
+
+    g_free(block->ciphers);
+    block->ciphers = NULL;
+    block->n_ciphers = block->n_free_ciphers = 0;
+}
+
 QCryptoIVGen *qcrypto_block_get_ivgen(QCryptoBlock *block)
 {
+    /* ivgen should be accessed under mutex. However, this function is used only
+     * in test with one thread, so it's enough to assert it here:
+     */
+    assert(block->n_ciphers <= 1);
     return block->ivgen;
 }
 
@@ -184,7 +272,7 @@ void qcrypto_block_free(QCryptoBlock *block)
 
     block->driver->cleanup(block);
 
-    qcrypto_cipher_free(block->cipher);
+    qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
     g_free(block);
 }
@@ -199,6 +287,7 @@ typedef int (*QCryptoCipherEncryptFunc)(QCryptoCipher *cipher,
 static int do_qcrypto_cipher_encrypt(QCryptoCipher *cipher,
                                      size_t niv,
                                      QCryptoIVGen *ivgen,
+                                     QemuMutex *ivgen_mutex,
                                      int sectorsize,
                                      uint64_t offset,
                                      uint8_t *buf,
@@ -218,10 +307,15 @@ static int do_qcrypto_cipher_encrypt(QCryptoCipher *cipher,
     while (len > 0) {
         size_t nbytes;
         if (niv) {
-            if (qcrypto_ivgen_calculate(ivgen,
-                                        startsector,
-                                        iv, niv,
-                                        errp) < 0) {
+            if (ivgen_mutex) {
+                qemu_mutex_lock(ivgen_mutex);
+            }
+            ret = qcrypto_ivgen_calculate(ivgen, startsector, iv, niv, errp);
+            if (ivgen_mutex) {
+                qemu_mutex_unlock(ivgen_mutex);
+            }
+
+            if (ret < 0) {
                 goto cleanup;
             }
 
@@ -258,8 +352,9 @@ int qcrypto_cipher_decrypt_helper(QCryptoCipher *cipher,
                                   size_t len,
                                   Error **errp)
 {
-    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, sectorsize, offset,
-                                     buf, len, qcrypto_cipher_decrypt, errp);
+    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, NULL, sectorsize,
+                                     offset, buf, len, qcrypto_cipher_decrypt,
+                                     errp);
 }
 
 
@@ -272,11 +367,11 @@ int qcrypto_cipher_encrypt_helper(QCryptoCipher *cipher,
                                   size_t len,
                                   Error **errp)
 {
-    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, sectorsize, offset,
-                                     buf, len, qcrypto_cipher_encrypt, errp);
+    return do_qcrypto_cipher_encrypt(cipher, niv, ivgen, NULL, sectorsize,
+                                     offset, buf, len, qcrypto_cipher_encrypt,
+                                     errp);
 }
 
-
 int qcrypto_block_decrypt_helper(QCryptoBlock *block,
                                  int sectorsize,
                                  uint64_t offset,
@@ -284,11 +379,17 @@ int qcrypto_block_decrypt_helper(QCryptoBlock *block,
                                  size_t len,
                                  Error **errp)
 {
-    return do_qcrypto_cipher_encrypt(block->cipher, block->niv, block->ivgen,
-                                     sectorsize, offset, buf, len,
-                                     qcrypto_cipher_decrypt, errp);
-}
+    int ret;
+    QCryptoCipher *cipher = qcrypto_block_pop_cipher(block);
+
+    ret = do_qcrypto_cipher_encrypt(cipher, block->niv, block->ivgen,
+                                    &block->mutex, sectorsize, offset, buf, len,
+                                    qcrypto_cipher_decrypt, errp);
+
+    qcrypto_block_push_cipher(block, cipher);
 
+    return ret;
+}
 
 int qcrypto_block_encrypt_helper(QCryptoBlock *block,
                                  int sectorsize,
@@ -297,7 +398,14 @@ int qcrypto_block_encrypt_helper(QCryptoBlock *block,
                                  size_t len,
                                  Error **errp)
 {
-    return do_qcrypto_cipher_encrypt(block->cipher, block->niv, block->ivgen,
-                                     sectorsize, offset, buf, len,
-                                     qcrypto_cipher_encrypt, errp);
+    int ret;
+    QCryptoCipher *cipher = qcrypto_block_pop_cipher(block);
+
+    ret = do_qcrypto_cipher_encrypt(cipher, block->niv, block->ivgen,
+                                    &block->mutex, sectorsize, offset, buf, len,
+                                    qcrypto_cipher_encrypt, errp);
+
+    qcrypto_block_push_cipher(block, cipher);
+
+    return ret;
 }
diff --git a/tests/test-crypto-block.c b/tests/test-crypto-block.c
index fae4ffc453..d309d044ef 100644
--- a/tests/test-crypto-block.c
+++ b/tests/test-crypto-block.c
@@ -305,6 +305,7 @@ static void test_block(gconstpointer opaque)
                              test_block_read_func,
                              &header,
                              0,
+                             1,
                              NULL);
     g_assert(blk == NULL);
 
@@ -313,6 +314,7 @@ static void test_block(gconstpointer opaque)
                              test_block_read_func,
                              &header,
                              QCRYPTO_BLOCK_OPEN_NO_IO,
+                             1,
                              &error_abort);
 
     g_assert(qcrypto_block_get_cipher(blk) == NULL);
@@ -327,6 +329,7 @@ static void test_block(gconstpointer opaque)
                              test_block_read_func,
                              &header,
                              0,
+                             1,
                              &error_abort);
     g_assert(blk);
 
-- 
2.18.0
