Received: from eggs.gnu.org ([2001:4830:134:3::10]:33448)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dOROX-0003q7-WF
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:25:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dOROS-0001Gl-Hu
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:25:17 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 23 Jun 2017 17:24:10 +0100
Message-Id: <20170623162419.26068-12-berrange@redhat.com>
In-Reply-To: <20170623162419.26068-1-berrange@redhat.com>
References: <20170623162419.26068-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v10 11/20] qcow2: convert QCow2 to use
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
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "Daniel P. Berrange" <berrange@redhat.com>

This converts the qcow2 driver to make use of the QCryptoBlock
APIs for encrypting image content, using the legacy QCow2 AES
scheme.

With this change it is now required to use the QCryptoSecret
object for providing passwords, instead of the current block
password APIs / interactive prompting.

  $QEMU \
    -object secret,id=sec0,filename=/home/berrange/encrypted.pw \
    -drive file=/home/berrange/encrypted.qcow2,encrypt.key-secret=sec0

The test 087 could be simplified since there is no longer a
difference in behaviour when using blockdev_add with encrypted
images for the running vs stopped CPU state.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/qcow2-cluster.c      |  47 +---------
 block/qcow2.c              | 226 ++++++++++++++++++++++++++++++---------------
 block/qcow2.h              |   5 +-
 qapi/block-core.json       |  27 +++++-
 tests/qemu-iotests/049     |   2 +-
 tests/qemu-iotests/049.out |   4 +-
 tests/qemu-iotests/082.out |  27 ++++++
 tests/qemu-iotests/087     |  28 +++---
 tests/qemu-iotests/087.out |  12 +--
 tests/qemu-iotests/134     |  18 +++-
 tests/qemu-iotests/134.out |  10 +-
 tests/qemu-iotests/158     |  19 ++--
 tests/qemu-iotests/158.out |  14 +--
 tests/qemu-iotests/common  |  10 +-
 14 files changed, 263 insertions(+), 186 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a570929..71a5e0d 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -357,47 +357,6 @@ static int count_contiguous_clusters_unallocated(int nb_clusters,
     return i;
 }
 
-/* The crypt function is compatible with the linux cryptoloop
-   algorithm for < 4 GB images. */
-int qcow2_encrypt_sectors(BDRVQcow2State *s, int64_t sector_num,
-                          uint8_t *buf, int nb_sectors, bool enc,
-                          Error **errp)
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
-
 static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
                                             uint64_t src_cluster_offset,
                                             unsigned offset_in_cluster,
@@ -438,11 +397,11 @@ static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
         BDRVQcow2State *s = bs->opaque;
         int64_t sector = (src_cluster_offset + offset_in_cluster)
                          >> BDRV_SECTOR_BITS;
-        assert(s->cipher);
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
-        if (qcow2_encrypt_sectors(s, sector, buffer,
-                                  bytes >> BDRV_SECTOR_BITS, true, NULL) < 0) {
+        assert(s->crypto);
+        if (qcrypto_block_encrypt(s->crypto, sector, buffer,
+                                  bytes, NULL) < 0) {
             return false;
         }
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index f4b5207..0a31127 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -37,6 +37,9 @@
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
+#include "qapi/opts-visitor.h"
+#include "qapi-visit.h"
+#include "block/crypto.h"
 
 /*
   Differences with QCOW:
@@ -461,6 +464,7 @@ static QemuOptsList qcow2_runtime_opts = {
             .type = QEMU_OPT_NUMBER,
             .help = "Clean unused cache entries after this time (in seconds)",
         },
+        BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("encrypt."),
         { /* end of list */ }
     },
 };
@@ -585,6 +589,7 @@ typedef struct Qcow2ReopenState {
     int overlap_check;
     bool discard_passthrough[QCOW2_DISCARD_MAX];
     uint64_t cache_clean_interval;
+    QCryptoBlockOpenOptions *crypto_opts; /* Disk encryption runtime options */
 } Qcow2ReopenState;
 
 static int qcow2_update_options_prepare(BlockDriverState *bs,
@@ -598,9 +603,14 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     int overlap_check_template = 0;
     uint64_t l2_cache_size, refcount_cache_size;
     int i;
+    const char *encryptfmt;
+    QDict *encryptopts = NULL;
     Error *local_err = NULL;
     int ret;
 
+    qdict_extract_subqdict(options, &encryptopts, "encrypt.");
+    encryptfmt = qdict_get_try_str(encryptopts, "format");
+
     opts = qemu_opts_create(&qcow2_runtime_opts, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -751,8 +761,42 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
     r->discard_passthrough[QCOW2_DISCARD_OTHER] =
         qemu_opt_get_bool(opts, QCOW2_OPT_DISCARD_OTHER, false);
 
+    switch (s->crypt_method_header) {
+    case QCOW_CRYPT_NONE:
+        if (encryptfmt) {
+            error_setg(errp, "No encryption in image header, but options "
+                       "specified format '%s'", encryptfmt);
+            ret = -EINVAL;
+            goto fail;
+        }
+        break;
+
+    case QCOW_CRYPT_AES:
+        if (encryptfmt && !g_str_equal(encryptfmt, "aes")) {
+            error_setg(errp,
+                       "Header reported 'aes' encryption format but "
+                       "options specify '%s'", encryptfmt);
+            ret = -EINVAL;
+            goto fail;
+        }
+        qdict_del(encryptopts, "format");
+        r->crypto_opts = block_crypto_open_opts_init(
+            Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, errp);
+        break;
+
+    default:
+        error_setg(errp, "Unsupported encryption method %d",
+                   s->crypt_method_header);
+        break;
+    }
+    if (s->crypt_method_header != QCOW_CRYPT_NONE && !r->crypto_opts) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
     ret = 0;
 fail:
+    QDECREF(encryptopts);
     qemu_opts_del(opts);
     opts = NULL;
     return ret;
@@ -785,6 +829,9 @@ static void qcow2_update_options_commit(BlockDriverState *bs,
         s->cache_clean_interval = r->cache_clean_interval;
         cache_clean_timer_init(bs, bdrv_get_aio_context(bs));
     }
+
+    qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
+    s->crypto_opts = r->crypto_opts;
 }
 
 static void qcow2_update_options_abort(BlockDriverState *bs,
@@ -796,6 +843,7 @@ static void qcow2_update_options_abort(BlockDriverState *bs,
     if (r->refcount_block_cache) {
         qcow2_cache_destroy(bs, r->refcount_block_cache);
     }
+    qapi_free_QCryptoBlockOpenOptions(r->crypto_opts);
 }
 
 static int qcow2_update_options(BlockDriverState *bs, QDict *options,
@@ -967,12 +1015,6 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         ret = -EINVAL;
         goto fail;
     }
-    if (!qcrypto_cipher_supports(QCRYPTO_CIPHER_ALG_AES_128,
-                                 QCRYPTO_CIPHER_MODE_CBC)) {
-        error_setg(errp, "AES cipher not available");
-        ret = -EINVAL;
-        goto fail;
-    }
     s->crypt_method_header = header.crypt_method;
     if (s->crypt_method_header) {
         if (bdrv_uses_whitelist() &&
@@ -990,6 +1032,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         }
 
         bs->encrypted = true;
+        bs->valid_key = true;
     }
 
     s->l2_bits = s->cluster_bits - 3; /* L2 is always one cluster */
@@ -1122,6 +1165,19 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
         goto fail;
     }
 
+    if (s->crypt_method_header == QCOW_CRYPT_AES) {
+        unsigned int cflags = 0;
+        if (flags & BDRV_O_NO_IO) {
+            cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
+        }
+        s->crypto = qcrypto_block_open(s->crypto_opts, NULL, NULL,
+                                       cflags, errp);
+        if (!s->crypto) {
+            ret = -EINVAL;
+            goto fail;
+        }
+    }
+
     /* read the backing file name */
     if (header.backing_file_offset != 0) {
         len = header.backing_file_size;
@@ -1202,6 +1258,8 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     }
     g_free(s->cluster_cache);
     qemu_vfree(s->cluster_data);
+    qcrypto_block_free(s->crypto);
+    qapi_free_QCryptoBlockOpenOptions(s->crypto_opts);
     return ret;
 }
 
@@ -1229,41 +1287,6 @@ static void qcow2_refresh_limits(BlockDriverState *bs, Error **errp)
     bs->bl.pdiscard_alignment = s->cluster_size;
 }
 
-static int qcow2_set_key(BlockDriverState *bs, const char *key)
-{
-    BDRVQcow2State *s = bs->opaque;
-    uint8_t keybuf[16];
-    int len, i;
-    Error *err = NULL;
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
 static int qcow2_reopen_prepare(BDRVReopenState *state,
                                 BlockReopenQueue *queue, Error **errp)
 {
@@ -1379,7 +1402,7 @@ static int64_t coroutine_fn qcow2_co_get_block_status(BlockDriverState *bs,
     *pnum = bytes >> BDRV_SECTOR_BITS;
 
     if (cluster_offset != 0 && ret != QCOW2_CLUSTER_COMPRESSED &&
-        !s->cipher) {
+        !s->crypto) {
         index_in_cluster = sector_num & (s->cluster_sectors - 1);
         cluster_offset |= (index_in_cluster << BDRV_SECTOR_BITS);
         *file = bs->file->bs;
@@ -1436,7 +1459,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
 
         /* prepare next request */
         cur_bytes = MIN(bytes, INT_MAX);
-        if (s->cipher) {
+        if (s->crypto) {
             cur_bytes = MIN(cur_bytes,
                             QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
         }
@@ -1506,7 +1529,7 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
             }
 
             if (bs->encrypted) {
-                assert(s->cipher);
+                assert(s->crypto);
 
                 /*
                  * For encrypted images, read everything into a temporary
@@ -1538,14 +1561,15 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                 goto fail;
             }
             if (bs->encrypted) {
-                assert(s->cipher);
+                assert(s->crypto);
                 assert((offset & (BDRV_SECTOR_SIZE - 1)) == 0);
                 assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
                 Error *err = NULL;
-                if (qcow2_encrypt_sectors(s, offset >> BDRV_SECTOR_BITS,
+                if (qcrypto_block_decrypt(s->crypto,
+                                          offset >> BDRV_SECTOR_BITS,
                                           cluster_data,
-                                          cur_bytes >> BDRV_SECTOR_BITS,
-                                          false, &err) < 0) {
+                                          cur_bytes,
+                                          &err) < 0) {
                     error_free(err);
                     ret = -EIO;
                     goto fail;
@@ -1661,7 +1685,7 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
 
         if (bs->encrypted) {
             Error *err = NULL;
-            assert(s->cipher);
+            assert(s->crypto);
             if (!cluster_data) {
                 cluster_data = qemu_try_blockalign(bs->file->bs,
                                                    QCOW_MAX_CRYPT_CLUSTERS
@@ -1676,10 +1700,9 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
             qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
 
-            if (qcow2_encrypt_sectors(s, offset >> BDRV_SECTOR_BITS,
+            if (qcrypto_block_encrypt(s->crypto, offset >> BDRV_SECTOR_BITS,
                                       cluster_data,
-                                      cur_bytes >>BDRV_SECTOR_BITS,
-                                      true, &err) < 0) {
+                                      cur_bytes, &err) < 0) {
                 error_free(err);
                 ret = -EIO;
                 goto fail;
@@ -1804,8 +1827,8 @@ static void qcow2_close(BlockDriverState *bs)
     qcow2_cache_destroy(bs, s->l2_table_cache);
     qcow2_cache_destroy(bs, s->refcount_block_cache);
 
-    qcrypto_cipher_free(s->cipher);
-    s->cipher = NULL;
+    qcrypto_block_free(s->crypto);
+    s->crypto = NULL;
 
     g_free(s->unknown_header_fields);
     cleanup_unknown_header_ext(bs);
@@ -1823,7 +1846,7 @@ static void qcow2_invalidate_cache(BlockDriverState *bs, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     int flags = s->flags;
-    QCryptoCipher *cipher = NULL;
+    QCryptoBlock *crypto = NULL;
     QDict *options;
     Error *local_err = NULL;
     int ret;
@@ -1833,8 +1856,8 @@ static void qcow2_invalidate_cache(BlockDriverState *bs, Error **errp)
      * that means we don't have to worry about reopening them here.
      */
 
-    cipher = s->cipher;
-    s->cipher = NULL;
+    crypto = s->crypto;
+    s->crypto = NULL;
 
     qcow2_close(bs);
 
@@ -1855,7 +1878,7 @@ static void qcow2_invalidate_cache(BlockDriverState *bs, Error **errp)
         return;
     }
 
-    s->cipher = cipher;
+    s->crypto = crypto;
 }
 
 static size_t header_ext_add(char *buf, uint32_t magic, const void *s,
@@ -2079,6 +2102,56 @@ static int qcow2_change_backing_file(BlockDriverState *bs,
     return qcow2_update_header(bs);
 }
 
+
+static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
+                                   QemuOpts *opts, Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    QCryptoBlockCreateOptions *cryptoopts = NULL;
+    QCryptoBlock *crypto = NULL;
+    int ret = -EINVAL;
+    QDict *options, *encryptopts;
+
+    options = qemu_opts_to_qdict(opts, NULL);
+    qdict_extract_subqdict(options, &encryptopts, "encrypt.");
+    QDECREF(options);
+
+    if (!g_str_equal(encryptfmt, "aes")) {
+        error_setg(errp, "Unknown encryption format '%s', expected 'aes'",
+                   encryptfmt);
+        ret = -EINVAL;
+        goto out;
+    }
+    cryptoopts = block_crypto_create_opts_init(
+        Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, errp);
+    if (!cryptoopts) {
+        ret = -EINVAL;
+        goto out;
+    }
+    s->crypt_method_header = QCOW_CRYPT_AES;
+
+    crypto = qcrypto_block_create(cryptoopts,
+                                  NULL, NULL,
+                                  bs, errp);
+    if (!crypto) {
+        ret = -EINVAL;
+        goto out;
+    }
+
+    ret = qcow2_update_header(bs);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not write encryption header");
+        goto out;
+    }
+
+ out:
+    QDECREF(encryptopts);
+    qcrypto_block_free(crypto);
+    qapi_free_QCryptoBlockCreateOptions(cryptoopts);
+    return ret;
+}
+
+
 static int preallocate(BlockDriverState *bs)
 {
     uint64_t bytes;
@@ -2273,17 +2346,8 @@ static int qcow2_create2(const char *filename, int64_t total_size,
         .header_length              = cpu_to_be32(sizeof(*header)),
     };
 
-    if (encryptfmt) {
-        if (!g_str_equal(encryptfmt, "aes")) {
-            error_setg(errp, "Unknown encryption format '%s', expected 'aes'",
-                       encryptfmt);
-            ret = -EINVAL;
-            goto out;
-        }
-        header->crypt_method = cpu_to_be32(QCOW_CRYPT_AES);
-    } else {
-        header->crypt_method = cpu_to_be32(QCOW_CRYPT_NONE);
-    }
+    /* We'll update this to correct value later */
+    header->crypt_method = cpu_to_be32(QCOW_CRYPT_NONE);
 
     if (flags & BLOCK_FLAG_LAZY_REFCOUNTS) {
         header->compatible_features |=
@@ -2362,6 +2426,14 @@ static int qcow2_create2(const char *filename, int64_t total_size,
         }
     }
 
+    /* Want encryption? There you go. */
+    if (encryptfmt) {
+        ret = qcow2_set_up_encryption(blk_bs(blk), encryptfmt, opts, errp);
+        if (ret < 0) {
+            goto out;
+        }
+    }
+
     /* And if we're supposed to preallocate metadata, do that now */
     if (prealloc != PREALLOC_MODE_OFF) {
         BDRVQcow2State *s = blk_bs(blk)->opaque;
@@ -2377,11 +2449,17 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     blk_unref(blk);
     blk = NULL;
 
-    /* Reopen the image without BDRV_O_NO_FLUSH to flush it before returning */
+    /* Reopen the image without BDRV_O_NO_FLUSH to flush it before returning.
+     * Using BDRV_O_NO_IO, since encryption is now setup we don't want to
+     * have to setup decryption context. We're not doing any I/O on the top
+     * level BlockDriverState, only lower layers, where BDRV_O_NO_IO does
+     * not have effect.
+     */
     options = qdict_new();
     qdict_put_str(options, "driver", "qcow2");
     blk = blk_new_open(filename, NULL, options,
-                       BDRV_O_RDWR | BDRV_O_NO_BACKING, &local_err);
+                       BDRV_O_RDWR | BDRV_O_NO_BACKING | BDRV_O_NO_IO,
+                       &local_err);
     if (blk == NULL) {
         error_propagate(errp, local_err);
         ret = -EIO;
@@ -3226,9 +3304,9 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
             backing_format = qemu_opt_get(opts, BLOCK_OPT_BACKING_FMT);
         } else if (!strcmp(desc->name, BLOCK_OPT_ENCRYPT)) {
             encrypt = qemu_opt_get_bool(opts, BLOCK_OPT_ENCRYPT,
-                                        !!s->cipher);
+                                        !!s->crypto);
 
-            if (encrypt != !!s->cipher) {
+            if (encrypt != !!s->crypto) {
                 error_report("Changing the encryption flag is not supported");
                 return -ENOTSUP;
             }
@@ -3454,6 +3532,7 @@ static QemuOptsList qcow2_create_opts = {
             .type = QEMU_OPT_STRING,
             .help = "Encrypt the image, format choices: 'aes'",
         },
+        BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("encrypt."),
         {
             .name = BLOCK_OPT_CLUSTER_SIZE,
             .type = QEMU_OPT_SIZE,
@@ -3496,7 +3575,6 @@ BlockDriver bdrv_qcow2 = {
     .bdrv_create        = qcow2_create,
     .bdrv_has_zero_init = bdrv_has_zero_init_1,
     .bdrv_co_get_block_status = qcow2_co_get_block_status,
-    .bdrv_set_key       = qcow2_set_key,
 
     .bdrv_co_preadv         = qcow2_co_preadv,
     .bdrv_co_pwritev        = qcow2_co_pwritev,
diff --git a/block/qcow2.h b/block/qcow2.h
index 5a3f07e..4b89610 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -25,7 +25,7 @@
 #ifndef BLOCK_QCOW2_H
 #define BLOCK_QCOW2_H
 
-#include "crypto/cipher.h"
+#include "crypto/block.h"
 #include "qemu/coroutine.h"
 
 //#define DEBUG_ALLOC
@@ -257,7 +257,8 @@ typedef struct BDRVQcow2State {
 
     CoMutex lock;
 
-    QCryptoCipher *cipher; /* current cipher, NULL if no key yet */
+    QCryptoBlockOpenOptions *crypto_opts; /* Disk encryption runtime options */
+    QCryptoBlock *crypto; /* Disk encryption format driver */
     uint32_t crypt_method_header;
     uint64_t snapshots_offset;
     int snapshots_size;
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c4b7e6e..1f268ee 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2317,6 +2317,26 @@
   'data': { '*encrypt': 'BlockdevQcowEncryption' } }
 
 
+
+##
+# @BlockdevQcow2EncryptionFormat:
+# @aes: AES-CBC with plain64 initialization venctors
+#
+# Since: 2.10
+##
+{ 'enum': 'BlockdevQcow2EncryptionFormat',
+  'data': [ 'aes' ] }
+
+##
+# @BlockdevQcow2Encryption:
+#
+# Since: 2.10
+##
+{ 'union': 'BlockdevQcow2Encryption',
+  'base': { 'format': 'BlockdevQcow2EncryptionFormat' },
+  'discriminator': 'format',
+  'data': { 'aes': 'QCryptoBlockOptionsQCow' } }
+
 ##
 # @BlockdevOptionsQcow2:
 #
@@ -2351,6 +2371,9 @@
 # @cache-clean-interval:  clean unused entries in the L2 and refcount
 #                         caches. The interval is in seconds. The default value
 #                         is 0 and it disables this feature (since 2.5)
+# @encrypt:               Image decryption options. Mandatory for
+#                         encrypted images, except when doing a metadata-only
+#                         probe of the image. (since 2.10)
 #
 # Since: 2.9
 ##
@@ -2364,8 +2387,8 @@
             '*cache-size': 'int',
             '*l2-cache-size': 'int',
             '*refcount-cache-size': 'int',
-            '*cache-clean-interval': 'int' } }
-
+            '*cache-clean-interval': 'int',
+            '*encrypt': 'BlockdevQcow2Encryption' } }
 
 ##
 # @BlockdevOptionsSsh:
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index fff0760..df35b6d 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -106,7 +106,7 @@ test_qemu_img create -f $IMGFMT -o preallocation=1234 "$TEST_IMG" 64M
 echo "== Check encryption option =="
 echo
 test_qemu_img create -f $IMGFMT -o encryption=off "$TEST_IMG" 64M
-test_qemu_img create -f $IMGFMT -o encryption=on "$TEST_IMG" 64M
+test_qemu_img create -f $IMGFMT --object secret,id=sec0,data=123456 -o encryption=on,encrypt.key-secret=sec0 "$TEST_IMG" 64M
 
 echo "== Check lazy_refcounts option (only with v3) =="
 echo
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 50e91c8..0032470 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -190,8 +190,8 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preall
 qemu-img create -f qcow2 -o encryption=off TEST_DIR/t.qcow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
-qemu-img create -f qcow2 -o encryption=on TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=on cluster_size=65536 lazy_refcounts=off refcount_bits=16
+qemu-img create -f qcow2 --object secret,id=sec0,data=123456 -o encryption=on,encrypt.key-secret=sec0 TEST_DIR/t.qcow2 64M
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=on encrypt.key-secret=sec0 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 == Check lazy_refcounts option (only with v3) ==
 
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 621386b..3978db5 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -50,6 +50,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -64,6 +65,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -78,6 +80,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -92,6 +95,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -106,6 +110,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -120,6 +125,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -134,6 +140,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -148,6 +155,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -177,6 +185,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -240,6 +249,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -254,6 +264,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -268,6 +279,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -282,6 +294,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -296,6 +309,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -310,6 +324,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -324,6 +339,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -338,6 +354,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -367,6 +384,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -427,6 +445,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -441,6 +460,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -455,6 +475,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -469,6 +490,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -483,6 +505,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -497,6 +520,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -511,6 +535,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -525,6 +550,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -556,6 +582,7 @@ backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
 encrypt.format   Encrypt the image, format choices: 'aes'
+encrypt.key-secret ID of the secret that provides the AES encryption key
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index 6d52f7d..1d595b2 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -122,24 +122,18 @@ echo
 echo === Encrypted image ===
 echo
 
-_make_test_img -o encryption=on $size
-run_qemu -S <<EOF
+_make_test_img --object secret,id=sec0,data=123456 -o encryption=on,encrypt.key-secret=sec0 $size
+run_qemu <<EOF
 { "execute": "qmp_capabilities" }
-{ "execute": "blockdev-add",
+{ "execute": "object-add",
   "arguments": {
-      "driver": "$IMGFMT",
-      "node-name": "disk",
-      "file": {
-          "driver": "file",
-          "filename": "$TEST_IMG"
+      "qom-type": "secret",
+      "id": "sec0",
+      "props": {
+          "data": "123456"
       }
-    }
   }
-{ "execute": "quit" }
-EOF
-
-run_qemu <<EOF
-{ "execute": "qmp_capabilities" }
+}
 { "execute": "blockdev-add",
   "arguments": {
       "driver": "$IMGFMT",
@@ -147,6 +141,10 @@ run_qemu <<EOF
       "file": {
           "driver": "file",
           "filename": "$TEST_IMG"
+      },
+      "encrypt": {
+          "format": "aes",
+          "key-secret": "sec0"
       }
     }
   }
@@ -157,7 +155,7 @@ echo
 echo === Missing driver ===
 echo
 
-_make_test_img -o encryption=on $size
+_make_test_img --object secret,id=sec0,data=123456 -o encryption=on,encrypt.key-secret=sec0 $size
 run_qemu -S <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "blockdev-add",
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 59c5208..69e4c3b 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -34,17 +34,11 @@ QMP_VERSION
 
 === Encrypted image ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on
-Testing: -S
-QMP_VERSION
-{"return": {}}
-{"error": {"class": "GenericError", "desc": "Use of AES-CBC encrypted IMGFMT images is no longer supported in system emulators"}}
-{"return": {}}
-{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
 Testing:
 QMP_VERSION
 {"return": {}}
+{"return": {}}
 {"error": {"class": "GenericError", "desc": "Use of AES-CBC encrypted IMGFMT images is no longer supported in system emulators"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
@@ -52,7 +46,7 @@ QMP_VERSION
 
 === Missing driver ===
 
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
 Testing: -S
 QMP_VERSION
 {"return": {}}
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index acce946..f851d92 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -44,23 +44,31 @@ _supported_os Linux
 
 
 size=128M
-IMGOPTS="encryption=on" _make_test_img $size
+
+SECRET="secret,id=sec0,data=astrochicken"
+SECRETALT="secret,id=sec0,data=platypus"
+
+_make_test_img --object $SECRET -o "encryption=on,encrypt.key-secret=sec0" $size
+
+IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,encrypt.key-secret=sec0"
+
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
 
 echo
 echo "== reading whole image =="
-echo "astrochicken" | $QEMU_IO -c "read 0 $size" "$TEST_IMG" | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "read 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== rewriting whole image =="
-echo "astrochicken" | $QEMU_IO -c "write -P 0xa 0 $size" "$TEST_IMG" | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== verify pattern =="
-echo "astrochicken" | $QEMU_IO -c "read -P 0xa 0 $size" "$TEST_IMG" | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "read -P 0xa 0 $size"  --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== verify pattern failure with wrong password =="
-echo "platypus" | $QEMU_IO -c "read -P 0xa 0 $size" "$TEST_IMG" | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
 
 
 # success, all done
diff --git a/tests/qemu-iotests/134.out b/tests/qemu-iotests/134.out
index 6493704..972be49 100644
--- a/tests/qemu-iotests/134.out
+++ b/tests/qemu-iotests/134.out
@@ -1,27 +1,19 @@
 QA output created by 134
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
 
 == reading whole image ==
-Disk image 'TEST_DIR/t.qcow2' is encrypted.
-password:
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == rewriting whole image ==
-Disk image 'TEST_DIR/t.qcow2' is encrypted.
-password:
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == verify pattern ==
-Disk image 'TEST_DIR/t.qcow2' is encrypted.
-password:
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == verify pattern failure with wrong password ==
-Disk image 'TEST_DIR/t.qcow2' is encrypted.
-password:
 Pattern verification failed at offset 0, 134217728 bytes
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index ef8d70f..e280b79 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -45,34 +45,39 @@ _supported_os Linux
 
 size=128M
 TEST_IMG_BASE=$TEST_IMG.base
+SECRET="secret,id=sec0,data=astrochicken"
 
 TEST_IMG_SAVE=$TEST_IMG
 TEST_IMG=$TEST_IMG_BASE
 echo "== create base =="
-IMGOPTS="encryption=on" _make_test_img $size
+_make_test_img --object $SECRET -o "encryption=on,encrypt.key-secret=sec0" $size
 TEST_IMG=$TEST_IMG_SAVE
 
+IMGSPECBASE="driver=$IMGFMT,file.filename=$TEST_IMG_BASE,encrypt.key-secret=sec0"
+IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,backing.driver=$IMGFMT,backing.file.filename=$TEST_IMG_BASE,backing.encrypt.key-secret=sec0,encrypt.key-secret=sec0"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
 echo
 echo "== writing whole image =="
-echo "astrochicken" | $QEMU_IO -c "write -P 0xa 0 $size" "$TEST_IMG_BASE" | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== verify pattern =="
-echo "astrochicken" | $QEMU_IO -c "read -P 0xa 0 $size" "$TEST_IMG_BASE" | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "read -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
 
 echo "== create overlay =="
-IMGOPTS="encryption=on" _make_test_img -b "$TEST_IMG_BASE" $size
+_make_test_img --object $SECRET -o "encryption=on,encrypt.key-secret=sec0" -b "$TEST_IMG_BASE" $size
 
 echo
 echo "== writing part of a cluster =="
-echo "astrochicken" | $QEMU_IO -c "write -P 0xe 0 1024" "$TEST_IMG" | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "write -P 0xe 0 1024" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
 
 echo
 echo "== verify pattern =="
-echo "astrochicken" | $QEMU_IO -c "read -P 0xe 0 1024" "$TEST_IMG" | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "read -P 0xe 0 1024" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
 echo
 echo "== verify pattern =="
-echo "astrochicken" | $QEMU_IO -c "read -P 0xa 1024 64512" "$TEST_IMG" | _filter_qemu_io | _filter_testdir
+$QEMU_IO --object $SECRET -c "read -P 0xa 1024 64512" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
 
 
 # success, all done
diff --git a/tests/qemu-iotests/158.out b/tests/qemu-iotests/158.out
index b3f37e2..6def216 100644
--- a/tests/qemu-iotests/158.out
+++ b/tests/qemu-iotests/158.out
@@ -1,36 +1,26 @@
 QA output created by 158
 == create base ==
-Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728 encryption=on
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728 encryption=on encrypt.key-secret=sec0
 
 == writing whole image ==
-Disk image 'TEST_DIR/t.qcow2.base' is encrypted.
-password:
 wrote 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == verify pattern ==
-Disk image 'TEST_DIR/t.qcow2.base' is encrypted.
-password:
 read 134217728/134217728 bytes at offset 0
 128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 == create overlay ==
-Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base encryption=on
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base encryption=on encrypt.key-secret=sec0
 
 == writing part of a cluster ==
-Disk image 'TEST_DIR/t.qcow2' is encrypted.
-password:
 wrote 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == verify pattern ==
-Disk image 'TEST_DIR/t.qcow2' is encrypted.
-password:
 read 1024/1024 bytes at offset 0
 1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 
 == verify pattern ==
-Disk image 'TEST_DIR/t.qcow2' is encrypted.
-password:
 read 64512/64512 bytes at offset 1024
 63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 *** done
diff --git a/tests/qemu-iotests/common b/tests/qemu-iotests/common
index f2a7199..d34c11c 100644
--- a/tests/qemu-iotests/common
+++ b/tests/qemu-iotests/common
@@ -50,6 +50,7 @@ export IMGPROTO=file
 export IMGOPTS=""
 export CACHEMODE="writeback"
 export QEMU_IO_OPTIONS=""
+export QEMU_IO_OPTIONS_NO_FMT=""
 export CACHEMODE_IS_DEFAULT=true
 export QEMU_OPTIONS="-nodefaults -machine accel=qtest"
 export VALGRIND_QEMU=
@@ -413,10 +414,11 @@ BEGIN        { for (t='$start'; t<='$end'; t++) printf "%03d\n",t }' \
 done
 
 # Set qemu-io cache mode with $CACHEMODE we have
-if [ "$IMGOPTSSYNTAX" = "true" ]; then
-    QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS --cache $CACHEMODE"
-else
-    QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS -f $IMGFMT --cache $CACHEMODE"
+QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS --cache $CACHEMODE"
+
+QEMU_IO_OPTIONS_NO_FMT="$QEMU_IO_OPTIONS"
+if [ "$IMGOPTSSYNTAX" != "true" ]; then
+    QEMU_IO_OPTIONS="$QEMU_IO_OPTIONS -f $IMGFMT"
 fi
 
 # Set default options for qemu-img create -o if they were not specified
-- 
2.9.3
