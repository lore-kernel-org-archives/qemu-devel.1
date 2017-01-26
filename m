Received: from eggs.gnu.org ([2001:4830:134:3::10]:45539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh8z-0001bz-CS
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh8x-00067b-I8
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:05 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:18:18 +0000
Message-Id: <20170126101827.22378-10-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-1-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 09/18] qcow: convert QCow to use
 QCryptoBlock for encryption
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

This converts the qcow2 driver to make use of the QCryptoBlock
APIs for encrypting image content. This is only wired up to
permit use of the legacy QCow encryption format. Users who wish
to have the strong LUKS format should switch to qcow2 instead.

With this change it is now required to use the QCryptoSecret
object for providing passwords, instead of the current block
password APIs / interactive prompting.

  $QEMU \
    -object secret,id=sec0,filename=/home/berrange/encrypted.pw \
    -drive file=/home/berrange/encrypted.qcow,aes-key-secret=sec0

Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c       |  10 +++
 block/crypto.h       |   9 +++
 block/qcow.c         | 184 +++++++++++++++++++++++----------------------------
 qapi/block-core.json |  17 ++++-
 4 files changed, 117 insertions(+), 103 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 876eabc..9201cb0 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -251,6 +251,11 @@ block_crypto_open_opts_init(QCryptoBlockFormat format,
             v, &ret->u.luks, &local_err);
         break;
 
+    case Q_CRYPTO_BLOCK_FORMAT_QCOW:
+        visit_type_QCryptoBlockOptionsQCow_members(
+            v, &ret->u.qcow, &local_err);
+        break;
+
     default:
         error_setg(&local_err, "Unsupported block format %d", format);
         break;
@@ -308,6 +313,11 @@ block_crypto_create_opts_init(QCryptoBlockFormat format,
             v, &ret->u.luks, &local_err);
         break;
 
+    case Q_CRYPTO_BLOCK_FORMAT_QCOW:
+        visit_type_QCryptoBlockOptionsQCow_members(
+            v, &ret->u.qcow, &local_err);
+        break;
+
     default:
         error_setg(&local_err, "Unsupported block format %d", format);
         break;
diff --git a/block/crypto.h b/block/crypto.h
index e70e2f0..1d64676 100644
--- a/block/crypto.h
+++ b/block/crypto.h
@@ -21,6 +21,15 @@
 #ifndef BLOCK_CRYPTO_H__
 #define BLOCK_CRYPTO_H__
 
+#define BLOCK_CRYPTO_OPT_QCOW_KEY_SECRET "key-secret"
+
+#define BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET(prefix)                    \
+    {                                                                   \
+        .name = prefix BLOCK_CRYPTO_OPT_QCOW_KEY_SECRET,                \
+        .type = QEMU_OPT_STRING,                                        \
+        .help = "ID of the secret that provides the AES encryption key", \
+    }
+
 #define BLOCK_CRYPTO_OPT_LUKS_KEY_SECRET "key-secret"
 #define BLOCK_CRYPTO_OPT_LUKS_CIPHER_ALG "cipher-alg"
 #define BLOCK_CRYPTO_OPT_LUKS_CIPHER_MODE "cipher-mode"
diff --git a/block/qcow.c b/block/qcow.c
index 38d7298..9bec081 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -31,8 +31,9 @@
 #include "qemu/bswap.h"
 #include <zlib.h>
 #include "qapi/qmp/qerror.h"
-#include "crypto/cipher.h"
+#include "crypto/block.h"
 #include "migration/migration.h"
+#include "block/crypto.h"
 
 /**************************************************************/
 /* QEMU COW block driver with compression and encryption support */
@@ -77,7 +78,7 @@ typedef struct BDRVQcowState {
     uint8_t *cluster_cache;
     uint8_t *cluster_data;
     uint64_t cluster_cache_offset;
-    QCryptoCipher *cipher; /* NULL if no key yet */
+    QCryptoBlock *crypto; /* Disk encryption format driver */
     uint32_t crypt_method_header;
     CoMutex lock;
     Error *migration_blocker;
@@ -97,6 +98,15 @@ static int qcow_probe(const uint8_t *buf, int buf_size, const char *filename)
         return 0;
 }
 
+static QemuOptsList qcow_runtime_opts = {
+    .name = "qcow",
+    .head = QTAILQ_HEAD_INITIALIZER(qcow_runtime_opts.head),
+    .desc = {
+        BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("aes-"),
+        { /* end of list */ }
+    },
+};
+
 static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
                      Error **errp)
 {
@@ -104,6 +114,18 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     unsigned int len, i, shift;
     int ret;
     QCowHeader header;
+    QemuOpts *opts = NULL;
+    Error *local_err = NULL;
+    QCryptoBlockOpenOptions *crypto_opts = NULL;
+    unsigned int cflags = 0;
+
+    opts = qemu_opts_create(&qcow_runtime_opts, NULL, 0, &error_abort);
+    qemu_opts_absorb_qdict(opts, options, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto fail;
+    }
 
     ret = bdrv_pread(bs->file, 0, &header, sizeof(header));
     if (ret < 0) {
@@ -148,17 +170,6 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
-    if (header.crypt_method > QCOW_CRYPT_AES) {
-        error_setg(errp, "invalid encryption method in qcow header");
-        ret = -EINVAL;
-        goto fail;
-    }
-    if (!qcrypto_cipher_supports(QCRYPTO_CIPHER_ALG_AES_128,
-                                 QCRYPTO_CIPHER_MODE_CBC)) {
-        error_setg(errp, "AES cipher not available");
-        ret = -EINVAL;
-        goto fail;
-    }
     s->crypt_method_header = header.crypt_method;
     if (s->crypt_method_header) {
         if (bdrv_uses_whitelist() &&
@@ -174,8 +185,31 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
             ret = -ENOSYS;
             goto fail;
         }
+        if (s->crypt_method_header == QCOW_CRYPT_AES) {
+            crypto_opts = block_crypto_open_opts_init(
+                Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                ret = -EINVAL;
+                goto fail;
+            }
 
+            if (flags & BDRV_O_NO_IO) {
+                cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
+            }
+            s->crypto = qcrypto_block_open(crypto_opts, NULL, NULL,
+                                           cflags, errp);
+            if (!s->crypto) {
+                ret = -EINVAL;
+                goto fail;
+            }
+        } else {
+            error_setg(errp, "invalid encryption method in qcow header");
+            ret = -EINVAL;
+            goto fail;
+        }
         bs->encrypted = true;
+        bs->valid_key = true;
     }
     s->cluster_bits = header.cluster_bits;
     s->cluster_size = 1 << s->cluster_bits;
@@ -254,6 +288,7 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
                bdrv_get_device_or_node_name(bs));
     migrate_add_blocker(s->migration_blocker);
 
+    qapi_free_QCryptoBlockOpenOptions(crypto_opts);
     qemu_co_mutex_init(&s->lock);
     return 0;
 
@@ -262,6 +297,7 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
     qemu_vfree(s->l2_cache);
     g_free(s->cluster_cache);
     g_free(s->cluster_data);
+    qapi_free_QCryptoBlockOpenOptions(crypto_opts);
     return ret;
 }
 
@@ -274,81 +310,6 @@ static int qcow_reopen_prepare(BDRVReopenState *state,
     return 0;
 }
 
-static int qcow_set_key(BlockDriverState *bs, const char *key)
-{
-    BDRVQcowState *s = bs->opaque;
-    uint8_t keybuf[16];
-    int len, i;
-    Error *err;
-
-    memset(keybuf, 0, 16);
-    len = strlen(key);
-    if (len > 16)
-        len = 16;
-    /* XXX: we could compress the chars to 7 bits to increase
-       entropy */
-    for(i = 0;i < len;i++) {
-        keybuf[i] = key[i];
-    }
-    assert(bs->encrypted);
-
-    qcrypto_cipher_free(s->cipher);
-    s->cipher = qcrypto_cipher_new(
-        QCRYPTO_CIPHER_ALG_AES_128,
-        QCRYPTO_CIPHER_MODE_CBC,
-        keybuf, G_N_ELEMENTS(keybuf),
-        &err);
-
-    if (!s->cipher) {
-        /* XXX would be nice if errors in this method could
-         * be properly propagate to the caller. Would need
-         * the bdrv_set_key() API signature to be fixed. */
-        error_free(err);
-        return -1;
-    }
-    return 0;
-}
-
-/* The crypt function is compatible with the linux cryptoloop
-   algorithm for < 4 GB images. */
-static int encrypt_sectors(BDRVQcowState *s, int64_t sector_num,
-                           uint8_t *buf, int nb_sectors, bool enc,
-                           Error **errp)
-{
-    union {
-        uint64_t ll[2];
-        uint8_t b[16];
-    } ivec;
-    int i;
-    int ret;
-
-    for(i = 0; i < nb_sectors; i++) {
-        ivec.ll[0] = cpu_to_le64(sector_num);
-        ivec.ll[1] = 0;
-        if (qcrypto_cipher_setiv(s->cipher,
-                                 ivec.b, G_N_ELEMENTS(ivec.b),
-                                 errp) < 0) {
-            return -1;
-        }
-        if (enc) {
-            ret = qcrypto_cipher_encrypt(s->cipher,
-                                         buf, buf,
-                                         512,
-                                         errp);
-        } else {
-            ret = qcrypto_cipher_decrypt(s->cipher,
-                                         buf, buf,
-                                         512,
-                                         errp);
-        }
-        if (ret < 0) {
-            return -1;
-        }
-        sector_num++;
-        buf += 512;
-    }
-    return 0;
-}
 
 /* 'allocate' is:
  *
@@ -463,15 +424,16 @@ static uint64_t get_cluster_offset(BlockDriverState *bs,
                 if (bs->encrypted &&
                     (n_end - n_start) < s->cluster_sectors) {
                     uint64_t start_sect;
-                    assert(s->cipher);
+                    assert(s->crypto);
                     start_sect = (offset & ~(s->cluster_size - 1)) >> 9;
                     for(i = 0; i < s->cluster_sectors; i++) {
                         if (i < n_start || i >= n_end) {
                             Error *err = NULL;
                             memset(s->cluster_data, 0x00, 512);
-                            if (encrypt_sectors(s, start_sect + i,
-                                                s->cluster_data, 1,
-                                                true, &err) < 0) {
+                            if (qcrypto_block_encrypt(s->crypto, start_sect + i,
+                                                      s->cluster_data,
+                                                      BDRV_SECTOR_SIZE,
+                                                      &err) < 0) {
                                 error_free(err);
                                 errno = EIO;
                                 return -1;
@@ -516,7 +478,7 @@ static int64_t coroutine_fn qcow_co_get_block_status(BlockDriverState *bs,
     if (!cluster_offset) {
         return 0;
     }
-    if ((cluster_offset & QCOW_OFLAG_COMPRESSED) || s->cipher) {
+    if ((cluster_offset & QCOW_OFLAG_COMPRESSED) || s->crypto) {
         return BDRV_BLOCK_DATA;
     }
     cluster_offset |= (index_in_cluster << BDRV_SECTOR_BITS);
@@ -647,9 +609,9 @@ static coroutine_fn int qcow_co_readv(BlockDriverState *bs, int64_t sector_num,
                 break;
             }
             if (bs->encrypted) {
-                assert(s->cipher);
-                if (encrypt_sectors(s, sector_num, buf,
-                                    n, false, &err) < 0) {
+                assert(s->crypto);
+                if (qcrypto_block_decrypt(s->crypto, sector_num, buf,
+                                          n * BDRV_SECTOR_SIZE, &err) < 0) {
                     goto fail;
                 }
             }
@@ -722,9 +684,9 @@ static coroutine_fn int qcow_co_writev(BlockDriverState *bs, int64_t sector_num,
         }
         if (bs->encrypted) {
             Error *err = NULL;
-            assert(s->cipher);
-            if (encrypt_sectors(s, sector_num, buf,
-                                n, true, &err) < 0) {
+            assert(s->crypto);
+            if (qcrypto_block_encrypt(s->crypto, sector_num, buf,
+                                      n * BDRV_SECTOR_SIZE, &err) < 0) {
                 error_free(err);
                 ret = -EIO;
                 break;
@@ -759,8 +721,8 @@ static void qcow_close(BlockDriverState *bs)
 {
     BDRVQcowState *s = bs->opaque;
 
-    qcrypto_cipher_free(s->cipher);
-    s->cipher = NULL;
+    qcrypto_block_free(s->crypto);
+    s->crypto = NULL;
     g_free(s->l1_table);
     qemu_vfree(s->l2_cache);
     g_free(s->cluster_cache);
@@ -781,6 +743,8 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
     Error *local_err = NULL;
     int ret;
     BlockBackend *qcow_blk;
+    QCryptoBlockCreateOptions *crypto_opts = NULL;
+    QCryptoBlock *crypto = NULL;
 
     /* Read out options */
     total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
@@ -847,6 +811,20 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
     header.l1_table_offset = cpu_to_be64(header_size);
     if (flags & BLOCK_FLAG_ENCRYPT) {
         header.crypt_method = cpu_to_be32(QCOW_CRYPT_AES);
+
+        crypto_opts = block_crypto_create_opts_init(
+            Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            ret = -EINVAL;
+            goto exit;
+        }
+
+        crypto = qcrypto_block_create(crypto_opts, NULL, NULL, NULL, errp);
+        if (!crypto) {
+            ret = -EINVAL;
+            goto exit;
+        }
     } else {
         header.crypt_method = cpu_to_be32(QCOW_CRYPT_NONE);
     }
@@ -881,6 +859,8 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
 exit:
     blk_unref(qcow_blk);
 cleanup:
+    qcrypto_block_free(crypto);
+    qapi_free_QCryptoBlockCreateOptions(crypto_opts);
     g_free(backing_file);
     return ret;
 }
@@ -1022,6 +1002,7 @@ static QemuOptsList qcow_create_opts = {
             .help = "Encrypt the image",
             .def_value_str = "off"
         },
+        BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("aes-"),
         { /* end of list */ }
     }
 };
@@ -1041,7 +1022,6 @@ static BlockDriver bdrv_qcow = {
     .bdrv_co_writev         = qcow_co_writev,
     .bdrv_co_get_block_status   = qcow_co_get_block_status,
 
-    .bdrv_set_key           = qcow_set_key,
     .bdrv_make_empty        = qcow_make_empty,
     .bdrv_co_pwritev_compressed = qcow_co_pwritev_compressed,
     .bdrv_get_info          = qcow_get_info,
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1b3e6eb..bf02bd2 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2278,6 +2278,21 @@
             'mode':  'Qcow2OverlapCheckMode' } }
 
 ##
+# @BlockdevOptionsQcow:
+#
+# Driver specific block device options for qcow.
+#
+# @aes-key-secret: #optional ID of the "secret" object providing the
+#                  AES decryption key.
+#
+# Since: 2.9
+##
+{ 'struct': 'BlockdevOptionsQcow',
+  'base': 'BlockdevOptionsGenericCOWFormat',
+  'data': { '*aes-key-secret': 'str' } }
+
+
+##
 # @BlockdevOptionsQcow2:
 #
 # Driver specific block device options for qcow2.
@@ -2794,7 +2809,7 @@
       'null-co':    'BlockdevOptionsNull',
       'parallels':  'BlockdevOptionsGenericFormat',
       'qcow2':      'BlockdevOptionsQcow2',
-      'qcow':       'BlockdevOptionsGenericCOWFormat',
+      'qcow':       'BlockdevOptionsQcow',
       'qed':        'BlockdevOptionsGenericCOWFormat',
       'quorum':     'BlockdevOptionsQuorum',
       'raw':        'BlockdevOptionsRaw',
-- 
2.9.3
