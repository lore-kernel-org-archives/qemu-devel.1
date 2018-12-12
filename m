Received: from eggs.gnu.org ([2001:4830:134:3::10]:37681)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2e6-0003I0-Ff
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gX2e2-0004jE-OX
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 06:25:42 -0500
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Wed, 12 Dec 2018 11:24:50 +0000
Message-Id: <20181212112450.2103-7-berrange@redhat.com>
In-Reply-To: <20181212112450.2103-1-berrange@redhat.com>
References: <20181212112450.2103-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 6/6] crypto: support multiple threads accessing
 one QCryptoBlock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

The two thing that should be handled are cipher and ivgen. For ivgen
the solution is just mutex, as iv calculations should not be long in
comparison with encryption/decryption. And for cipher let's just keep
per-thread ciphers.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 block/crypto.c            |   1 +
 block/qcow.c              |   2 +-
 block/qcow2.c             |   4 +-
 crypto/block-luks.c       |  22 +++---
 crypto/block-qcow.c       |  20 +++---
 crypto/block.c            | 146 +++++++++++++++++++++++++++++++++-----
 crypto/blockpriv.h        |  16 ++++-
 include/crypto/block.h    |   2 +
 tests/test-crypto-block.c |   3 +
 9 files changed, 172 insertions(+), 44 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 33ee01bebd..f0a5f6b987 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -229,6 +229,7 @@ static int block_crypto_open_generic(QCryptoBlockForm=
at format,
                                        block_crypto_read_func,
                                        bs,
                                        cflags,
+                                       1,
                                        errp);
=20
     if (!crypto->block) {
diff --git a/block/qcow.c b/block/qcow.c
index 4518cb4c35..0a235bf393 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -213,7 +213,7 @@ static int qcow_open(BlockDriverState *bs, QDict *opt=
ions, int flags,
                 cflags |=3D QCRYPTO_BLOCK_OPEN_NO_IO;
             }
             s->crypto =3D qcrypto_block_open(crypto_opts, "encrypt.",
-                                           NULL, NULL, cflags, errp);
+                                           NULL, NULL, cflags, 1, errp);
             if (!s->crypto) {
                 ret =3D -EINVAL;
                 goto fail;
diff --git a/block/qcow2.c b/block/qcow2.c
index 991d6ac91b..bc8868c36a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -294,7 +294,7 @@ static int qcow2_read_extensions(BlockDriverState *bs=
, uint64_t start_offset,
             }
             s->crypto =3D qcrypto_block_open(s->crypto_opts, "encrypt.",
                                            qcow2_crypto_hdr_read_func,
-                                           bs, cflags, errp);
+                                           bs, cflags, 1, errp);
             if (!s->crypto) {
                 return -EINVAL;
             }
@@ -1445,7 +1445,7 @@ static int coroutine_fn qcow2_do_open(BlockDriverSt=
ate *bs, QDict *options,
                 cflags |=3D QCRYPTO_BLOCK_OPEN_NO_IO;
             }
             s->crypto =3D qcrypto_block_open(s->crypto_opts, "encrypt.",
-                                           NULL, NULL, cflags, errp);
+                                           NULL, NULL, cflags, 1, errp);
             if (!s->crypto) {
                 ret =3D -EINVAL;
                 goto fail;
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index e486e7ee94..6bac79c3ab 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -636,6 +636,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
                         QCryptoBlockReadFunc readfunc,
                         void *opaque,
                         unsigned int flags,
+                        size_t n_threads,
                         Error **errp)
 {
     QCryptoBlockLUKS *luks;
@@ -836,11 +837,10 @@ qcrypto_block_luks_open(QCryptoBlock *block,
             goto fail;
         }
=20
-        block->cipher =3D qcrypto_cipher_new(cipheralg,
-                                           ciphermode,
-                                           masterkey, masterkeylen,
-                                           errp);
-        if (!block->cipher) {
+        ret =3D qcrypto_block_init_cipher(block, cipheralg, ciphermode,
+                                        masterkey, masterkeylen, n_threa=
ds,
+                                        errp);
+        if (ret < 0) {
             ret =3D -ENOTSUP;
             goto fail;
         }
@@ -863,7 +863,7 @@ qcrypto_block_luks_open(QCryptoBlock *block,
=20
  fail:
     g_free(masterkey);
-    qcrypto_cipher_free(block->cipher);
+    qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
     g_free(luks);
     g_free(password);
@@ -1030,11 +1030,9 @@ qcrypto_block_luks_create(QCryptoBlock *block,
=20
=20
     /* Setup the block device payload encryption objects */
-    block->cipher =3D qcrypto_cipher_new(luks_opts.cipher_alg,
-                                       luks_opts.cipher_mode,
-                                       masterkey, luks->header.key_bytes=
,
-                                       errp);
-    if (!block->cipher) {
+    if (qcrypto_block_init_cipher(block, luks_opts.cipher_alg,
+                                  luks_opts.cipher_mode, masterkey,
+                                  luks->header.key_bytes, 1, errp) < 0) =
{
         goto error;
     }
=20
@@ -1341,7 +1339,7 @@ qcrypto_block_luks_create(QCryptoBlock *block,
     qcrypto_ivgen_free(ivgen);
     qcrypto_cipher_free(cipher);
=20
-    qcrypto_cipher_free(block->cipher);
+    qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
=20
     g_free(luks);
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index 36bf5f09b7..cefb3b2a7b 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -44,6 +44,7 @@ qcrypto_block_qcow_has_format(const uint8_t *buf G_GNUC=
_UNUSED,
 static int
 qcrypto_block_qcow_init(QCryptoBlock *block,
                         const char *keysecret,
+                        size_t n_threads,
                         Error **errp)
 {
     char *password;
@@ -71,11 +72,11 @@ qcrypto_block_qcow_init(QCryptoBlock *block,
         goto fail;
     }
=20
-    block->cipher =3D qcrypto_cipher_new(QCRYPTO_CIPHER_ALG_AES_128,
-                                       QCRYPTO_CIPHER_MODE_CBC,
-                                       keybuf, G_N_ELEMENTS(keybuf),
-                                       errp);
-    if (!block->cipher) {
+    ret =3D qcrypto_block_init_cipher(block, QCRYPTO_CIPHER_ALG_AES_128,
+                                    QCRYPTO_CIPHER_MODE_CBC,
+                                    keybuf, G_N_ELEMENTS(keybuf),
+                                    n_threads, errp);
+    if (ret < 0) {
         ret =3D -ENOTSUP;
         goto fail;
     }
@@ -86,7 +87,7 @@ qcrypto_block_qcow_init(QCryptoBlock *block,
     return 0;
=20
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
+                        size_t n_threads,
                         Error **errp)
 {
     if (flags & QCRYPTO_BLOCK_OPEN_NO_IO) {
@@ -112,8 +114,8 @@ qcrypto_block_qcow_open(QCryptoBlock *block,
                        optprefix ? optprefix : "");
             return -1;
         }
-        return qcrypto_block_qcow_init(block,
-                                       options->u.qcow.key_secret, errp)=
;
+        return qcrypto_block_qcow_init(block, options->u.qcow.key_secret=
,
+                                       n_threads, errp);
     }
 }
=20
@@ -133,7 +135,7 @@ qcrypto_block_qcow_create(QCryptoBlock *block,
         return -1;
     }
     /* QCow2 has no special header, since everything is hardwired */
-    return qcrypto_block_qcow_init(block, options->u.qcow.key_secret, er=
rp);
+    return qcrypto_block_qcow_init(block, options->u.qcow.key_secret, 1,=
 errp);
 }
=20
=20
diff --git a/crypto/block.c b/crypto/block.c
index 3fe3de2ef8..d70d401f87 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -52,6 +52,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOption=
s *options,
                                  QCryptoBlockReadFunc readfunc,
                                  void *opaque,
                                  unsigned int flags,
+                                 size_t n_threads,
                                  Error **errp)
 {
     QCryptoBlock *block =3D g_new0(QCryptoBlock, 1);
@@ -69,11 +70,14 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOpti=
ons *options,
     block->driver =3D qcrypto_block_drivers[options->format];
=20
     if (block->driver->open(block, options, optprefix,
-                            readfunc, opaque, flags, errp) < 0) {
+                            readfunc, opaque, flags, n_threads, errp) < =
0)
+    {
         g_free(block);
         return NULL;
     }
=20
+    qemu_mutex_init(&block->mutex);
+
     return block;
 }
=20
@@ -105,6 +109,8 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreate=
Options *options,
         return NULL;
     }
=20
+    qemu_mutex_init(&block->mutex);
+
     return block;
 }
=20
@@ -148,12 +154,97 @@ int qcrypto_block_encrypt(QCryptoBlock *block,
=20
 QCryptoCipher *qcrypto_block_get_cipher(QCryptoBlock *block)
 {
-    return block->cipher;
+    /* Ciphers should be accessed through pop/push method to be thread-s=
afe.
+     * Better, they should not be accessed externally at all (note, that
+     * pop/push are static functions)
+     * This function is used only in test with one thread (it's safe to =
skip
+     * pop/push interface), so it's enough to assert it here:
+     */
+    assert(block->n_ciphers <=3D 1);
+    return block->ciphers ? block->ciphers[0] : NULL;
+}
+
+
+static QCryptoCipher *qcrypto_block_pop_cipher(QCryptoBlock *block)
+{
+    QCryptoCipher *cipher;
+
+    qemu_mutex_lock(&block->mutex);
+
+    assert(block->n_free_ciphers > 0);
+    block->n_free_ciphers--;
+    cipher =3D block->ciphers[block->n_free_ciphers];
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
+    block->ciphers[block->n_free_ciphers] =3D cipher;
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
+                              size_t n_threads, Error **errp)
+{
+    size_t i;
+
+    assert(!block->ciphers && !block->n_ciphers && !block->n_free_cipher=
s);
+
+    block->ciphers =3D g_new0(QCryptoCipher *, n_threads);
+
+    for (i =3D 0; i < n_threads; i++) {
+        block->ciphers[i] =3D qcrypto_cipher_new(alg, mode, key, nkey, e=
rrp);
+        if (!block->ciphers[i]) {
+            qcrypto_block_free_cipher(block);
+            return -1;
+        }
+        block->n_ciphers++;
+        block->n_free_ciphers++;
+    }
+
+    return 0;
 }
=20
=20
+void qcrypto_block_free_cipher(QCryptoBlock *block)
+{
+    size_t i;
+
+    if (!block->ciphers) {
+        return;
+    }
+
+    assert(block->n_ciphers =3D=3D block->n_free_ciphers);
+
+    for (i =3D 0; i < block->n_ciphers; i++) {
+        qcrypto_cipher_free(block->ciphers[i]);
+    }
+
+    g_free(block->ciphers);
+    block->ciphers =3D NULL;
+    block->n_ciphers =3D block->n_free_ciphers =3D 0;
+}
+
 QCryptoIVGen *qcrypto_block_get_ivgen(QCryptoBlock *block)
 {
+    /* ivgen should be accessed under mutex. However, this function is u=
sed only
+     * in test with one thread, so it's enough to assert it here:
+     */
+    assert(block->n_ciphers <=3D 1);
     return block->ivgen;
 }
=20
@@ -184,8 +275,9 @@ void qcrypto_block_free(QCryptoBlock *block)
=20
     block->driver->cleanup(block);
=20
-    qcrypto_cipher_free(block->cipher);
+    qcrypto_block_free_cipher(block);
     qcrypto_ivgen_free(block->ivgen);
+    qemu_mutex_destroy(&block->mutex);
     g_free(block);
 }
=20
@@ -199,6 +291,7 @@ typedef int (*QCryptoCipherEncDecFunc)(QCryptoCipher =
*cipher,
 static int do_qcrypto_block_cipher_encdec(QCryptoCipher *cipher,
                                           size_t niv,
                                           QCryptoIVGen *ivgen,
+                                          QemuMutex *ivgen_mutex,
                                           int sectorsize,
                                           uint64_t offset,
                                           uint8_t *buf,
@@ -218,10 +311,15 @@ static int do_qcrypto_block_cipher_encdec(QCryptoCi=
pher *cipher,
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
+            ret =3D qcrypto_ivgen_calculate(ivgen, startsector, iv, niv,=
 errp);
+            if (ivgen_mutex) {
+                qemu_mutex_unlock(ivgen_mutex);
+            }
+
+            if (ret < 0) {
                 goto cleanup;
             }
=20
@@ -258,7 +356,7 @@ int qcrypto_block_cipher_decrypt_helper(QCryptoCipher=
 *cipher,
                                         size_t len,
                                         Error **errp)
 {
-    return do_qcrypto_block_cipher_encdec(cipher, niv, ivgen, sectorsize=
,
+    return do_qcrypto_block_cipher_encdec(cipher, niv, ivgen, NULL, sect=
orsize,
                                           offset, buf, len,
                                           qcrypto_cipher_decrypt, errp);
 }
@@ -273,12 +371,11 @@ int qcrypto_block_cipher_encrypt_helper(QCryptoCiph=
er *cipher,
                                         size_t len,
                                         Error **errp)
 {
-    return do_qcrypto_block_cipher_encdec(cipher, niv, ivgen, sectorsize=
,
+    return do_qcrypto_block_cipher_encdec(cipher, niv, ivgen, NULL, sect=
orsize,
                                           offset, buf, len,
                                           qcrypto_cipher_encrypt, errp);
 }
=20
-
 int qcrypto_block_decrypt_helper(QCryptoBlock *block,
                                  int sectorsize,
                                  uint64_t offset,
@@ -286,12 +383,17 @@ int qcrypto_block_decrypt_helper(QCryptoBlock *bloc=
k,
                                  size_t len,
                                  Error **errp)
 {
-    return do_qcrypto_block_cipher_encdec(block->cipher, block->niv,
-                                          block->ivgen,
-                                          sectorsize, offset, buf, len,
-                                          qcrypto_cipher_decrypt, errp);
-}
+    int ret;
+    QCryptoCipher *cipher =3D qcrypto_block_pop_cipher(block);
=20
+    ret =3D do_qcrypto_block_cipher_encdec(cipher, block->niv, block->iv=
gen,
+                                         &block->mutex, sectorsize, offs=
et, buf,
+                                         len, qcrypto_cipher_decrypt, er=
rp);
+
+    qcrypto_block_push_cipher(block, cipher);
+
+    return ret;
+}
=20
 int qcrypto_block_encrypt_helper(QCryptoBlock *block,
                                  int sectorsize,
@@ -300,8 +402,14 @@ int qcrypto_block_encrypt_helper(QCryptoBlock *block=
,
                                  size_t len,
                                  Error **errp)
 {
-    return do_qcrypto_block_cipher_encdec(block->cipher, block->niv,
-                                          block->ivgen,
-                                          sectorsize, offset, buf, len,
-                                          qcrypto_cipher_encrypt, errp);
+    int ret;
+    QCryptoCipher *cipher =3D qcrypto_block_pop_cipher(block);
+
+    ret =3D do_qcrypto_block_cipher_encdec(cipher, block->niv, block->iv=
gen,
+                                         &block->mutex, sectorsize, offs=
et, buf,
+                                         len, qcrypto_cipher_encrypt, er=
rp);
+
+    qcrypto_block_push_cipher(block, cipher);
+
+    return ret;
 }
diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 438c08bec2..5438e822fd 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -22,6 +22,7 @@
 #define QCRYPTO_BLOCKPRIV_H
=20
 #include "crypto/block.h"
+#include "qemu/thread.h"
=20
 typedef struct QCryptoBlockDriver QCryptoBlockDriver;
=20
@@ -31,8 +32,12 @@ struct QCryptoBlock {
     const QCryptoBlockDriver *driver;
     void *opaque;
=20
-    QCryptoCipher *cipher;
+    QCryptoCipher **ciphers;
+    size_t n_ciphers;
+    size_t n_free_ciphers;
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
+                size_t n_threads,
                 Error **errp);
=20
     int (*create)(QCryptoBlock *block,
@@ -110,4 +116,12 @@ int qcrypto_block_encrypt_helper(QCryptoBlock *block=
,
                                  size_t len,
                                  Error **errp);
=20
+int qcrypto_block_init_cipher(QCryptoBlock *block,
+                              QCryptoCipherAlgorithm alg,
+                              QCryptoCipherMode mode,
+                              const uint8_t *key, size_t nkey,
+                              size_t n_threads, Error **errp);
+
+void qcrypto_block_free_cipher(QCryptoBlock *block);
+
 #endif /* QCRYPTO_BLOCKPRIV_H */
diff --git a/include/crypto/block.h b/include/crypto/block.h
index cd18f46d56..e729d5bd66 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -75,6 +75,7 @@ typedef enum {
  * @readfunc: callback for reading data from the volume
  * @opaque: data to pass to @readfunc
  * @flags: bitmask of QCryptoBlockOpenFlags values
+ * @n_threads: allow concurrent I/O from up to @n_threads threads
  * @errp: pointer to a NULL-initialized error object
  *
  * Create a new block encryption object for an existing
@@ -107,6 +108,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOpti=
ons *options,
                                  QCryptoBlockReadFunc readfunc,
                                  void *opaque,
                                  unsigned int flags,
+                                 size_t n_threads,
                                  Error **errp);
=20
 /**
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
     g_assert(blk =3D=3D NULL);
=20
@@ -313,6 +314,7 @@ static void test_block(gconstpointer opaque)
                              test_block_read_func,
                              &header,
                              QCRYPTO_BLOCK_OPEN_NO_IO,
+                             1,
                              &error_abort);
=20
     g_assert(qcrypto_block_get_cipher(blk) =3D=3D NULL);
@@ -327,6 +329,7 @@ static void test_block(gconstpointer opaque)
                              test_block_read_func,
                              &header,
                              0,
+                             1,
                              &error_abort);
     g_assert(blk);
=20
--=20
2.19.2
