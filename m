Received: from eggs.gnu.org ([2001:4830:134:3::10]:45815)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh9L-0001z0-V7
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh9G-0006IB-3D
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:27 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:18:22 +0000
Message-Id: <20170126101827.22378-14-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-1-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 13/18] qcow2: add support for LUKS
 encryption format
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

This adds support for using LUKS as an encryption format
with the qcow2 file. The use of the existing 'encryption=on'
parameter is replaced by a new parameter 'encryption-format'
which takes the values 'aes' or 'luks'. e.g.

  # qemu-img create --object secret,data=123456,id=sec0 \
       -f qcow2 -o encryption-format=luks,luks-key-secret=sec0 \
       test.qcow2 10G

results in the creation of an image using the LUKS format.
Use of the legacy 'encryption=on' parameter still results
in creation of the old qcow2 AES format, and is equivalent
to the new 'encryption-format=aes'. e.g. the following are
equivalent:

  # qemu-img create --object secret,data=123456,id=sec0 \
       -f qcow2 -o encryption=on,aes-key-secret=sec0 \
       test.qcow2 10G

 # qemu-img create --object secret,data=123456,id=sec0 \
       -f qcow2 -o encryption-format=aes,aes-key-secret=sec0 \
       test.qcow2 10G

With the LUKS format it is necessary to store the LUKS
partition header and key material in the QCow2 file. This
data can be many MB in size, so cannot go into the QCow2
header region directly. Thus the spec defines a FDE
(Full Disk Encryption) header extension that specifies
the offset of a set of clusters to hold the FDE headers,
as well as the length of that region. The LUKS header is
thus stored in these extra allocated clusters before the
main image payload.

Aside from all the cryptographic differences implied by
use of the LUKS format, there is one further key difference
between the use of legacy AES and LUKS encryption in qcow2.
For LUKS, the initialiazation vectors are generated using
the host physical sector as the input, rather than the
guest virtual sector. This guarantees unique initialization
vectors for all sectors when qcow2 internal snapshots are
used, thus giving stronger protection against watermarking
attacks.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/qcow2-cluster.c      |   4 +-
 block/qcow2-refcount.c     |  10 ++
 block/qcow2.c              | 284 +++++++++++++++++++++++++++++++++++++++------
 block/qcow2.h              |   9 ++
 include/block/block_int.h  |   1 +
 qapi/block-core.json       |  11 +-
 qemu-img.c                 |   4 +-
 tests/qemu-iotests/082.out | 270 +++++++++++++++++++++++++++++++++++++-----
 8 files changed, 527 insertions(+), 66 deletions(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index a2103dc..866b122 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -383,7 +383,9 @@ static int coroutine_fn do_perform_cow(BlockDriverState *bs,
 
     if (bs->encrypted) {
         Error *err = NULL;
-        int64_t sector = (src_cluster_offset + offset_in_cluster)
+        int64_t sector = (s->crypt_physical_offset ?
+                          (cluster_offset + offset_in_cluster) :
+                          (src_cluster_offset + offset_in_cluster))
                          >> BDRV_SECTOR_BITS;
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index cbfb3fe..afa4636 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1843,6 +1843,16 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
         return ret;
     }
 
+    /* encryption */
+    if (s->crypto_header.length) {
+        ret = inc_refcounts(bs, res, refcount_table, nb_clusters,
+                            s->crypto_header.offset,
+                            s->crypto_header.length);
+        if (ret < 0) {
+            return ret;
+        }
+    }
+
     return check_refblocks(bs, res, fix, rebuild, refcount_table, nb_clusters);
 }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index 6f5095b..4dc7a64 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -66,6 +66,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_END 0
 #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
 #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
+#define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
@@ -80,6 +81,86 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 }
 
 
+static ssize_t qcow2_crypto_hdr_read_func(QCryptoBlock *block, size_t offset,
+                                          uint8_t *buf, size_t buflen,
+                                          Error **errp, void *opaque)
+{
+    BlockDriverState *bs = opaque;
+    BDRVQcow2State *s = bs->opaque;
+    ssize_t ret;
+
+    if ((offset + buflen) > s->crypto_header.length) {
+        error_setg(errp, "Request for data outside of extension header");
+        return -1;
+    }
+
+    ret = bdrv_pread(bs->file,
+                     s->crypto_header.offset + offset, buf, buflen);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not read encryption header");
+        return -1;
+    }
+    return ret;
+}
+
+
+static ssize_t qcow2_crypto_hdr_init_func(QCryptoBlock *block, size_t headerlen,
+                                          Error **errp, void *opaque)
+{
+    BlockDriverState *bs = opaque;
+    BDRVQcow2State *s = bs->opaque;
+    int64_t ret;
+    int64_t clusterlen;
+
+    ret = qcow2_alloc_clusters(bs, headerlen);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret,
+                         "Cannot allocate cluster for LUKS header size %zu",
+                         headerlen);
+        return -1;
+    }
+
+    s->crypto_header.length = headerlen;
+    s->crypto_header.offset = ret;
+
+    /* Zero fill remaining space in cluster so it has predictable
+     * content in case of future spec changes */
+    clusterlen = size_to_clusters(s, headerlen) * s->cluster_size;
+    ret = bdrv_pwrite_zeroes(bs->file,
+                             ret + headerlen,
+                             clusterlen - headerlen, 0);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not zero fill encryption header");
+        return -1;
+    }
+
+    return ret;
+}
+
+
+static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
+                                           const uint8_t *buf, size_t buflen,
+                                           Error **errp, void *opaque)
+{
+    BlockDriverState *bs = opaque;
+    BDRVQcow2State *s = bs->opaque;
+    ssize_t ret;
+
+    if ((offset + buflen) > s->crypto_header.length) {
+        error_setg(errp, "Request for data outside of extension header");
+        return -1;
+    }
+
+    ret = bdrv_pwrite(bs->file,
+                      s->crypto_header.offset + offset, buf, buflen);
+    if (ret < 0) {
+        error_setg_errno(errp, -ret, "Could not read encryption header");
+        return -1;
+    }
+    return ret;
+}
+
+
 /* 
  * read qcow2 extension and fill bs
  * start reading from start_offset
@@ -89,7 +170,7 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
  */
 static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                                  uint64_t end_offset, void **p_feature_table,
-                                 Error **errp)
+                                 int flags, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     QCowExtension ext;
@@ -165,6 +246,52 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
             }
             break;
 
+        case QCOW2_EXT_MAGIC_CRYPTO_HEADER: {
+            unsigned int cflags = 0;
+            if (s->crypt_method_header != QCOW_CRYPT_LUKS) {
+                error_setg(errp, "CRYPTO header extension only "
+                           "expected with LUKS encryption method");
+                return -EINVAL;
+            }
+            if (ext.len != sizeof(Qcow2CryptoHeaderExtension)) {
+                error_setg(errp, "CRYPTO header extension size %u, "
+                           "but expected size %zu", ext.len,
+                           sizeof(Qcow2CryptoHeaderExtension));
+                return -EINVAL;
+            }
+
+            ret = bdrv_pread(bs->file, offset, &s->crypto_header, ext.len);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret,
+                                 "Unable to read CRYPTO header extension");
+                return ret;
+            }
+            be64_to_cpus(&s->crypto_header.offset);
+            be64_to_cpus(&s->crypto_header.length);
+
+            if ((s->crypto_header.offset % s->cluster_size) != 0) {
+                error_setg(errp, "Encryption header offset '%" PRIu64 "' is "
+                           "not a multiple of cluster size '%u'",
+                           s->crypto_header.offset, s->cluster_size);
+                return -EINVAL;
+            }
+
+            if (flags & BDRV_O_NO_IO) {
+                cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
+            }
+            /* TODO how do we pass the same crypto opts down to the
+             * backing file by default, so we don't have to manually
+             * provide the same key-secret property against the full
+             * backing chain
+             */
+            s->crypto = qcrypto_block_open(s->crypto_opts,
+                                           qcow2_crypto_hdr_read_func,
+                                           bs, cflags, errp);
+            if (!s->crypto) {
+                return -EINVAL;
+            }
+        }   break;
+
         default:
             /* unknown magic - save it in case we need to rewrite the header */
             {
@@ -465,6 +592,7 @@ static QemuOptsList qcow2_runtime_opts = {
             .help = "Clean unused cache entries after this time (in seconds)",
         },
         BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("aes-"),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET("luks-"),
         { /* end of list */ }
     },
 };
@@ -766,6 +894,11 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
             Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
         break;
 
+    case QCOW_CRYPT_LUKS:
+        r->crypto_opts = block_crypto_open_opts_init(
+            Q_CRYPTO_BLOCK_FORMAT_LUKS, opts, "luks-", errp);
+        break;
+
     default:
         g_assert_not_reached();
     }
@@ -956,7 +1089,7 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
     if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
         void *feature_table = NULL;
         qcow2_read_extensions(bs, header.header_length, ext_end,
-                              &feature_table, NULL);
+                              &feature_table, flags, NULL);
         report_unsupported_feature(errp, feature_table,
                                    s->incompatible_features &
                                    ~QCOW2_INCOMPAT_MASK);
@@ -988,12 +1121,6 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
     s->refcount_max = UINT64_C(1) << (s->refcount_bits - 1);
     s->refcount_max += s->refcount_max - 1;
 
-    if (header.crypt_method > QCOW_CRYPT_AES) {
-        error_setg(errp, "Unsupported encryption method: %" PRIu32,
-                   header.crypt_method);
-        ret = -EINVAL;
-        goto fail;
-    }
     s->crypt_method_header = header.crypt_method;
     if (s->crypt_method_header) {
         if (bdrv_uses_whitelist() &&
@@ -1010,6 +1137,12 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
             goto fail;
         }
 
+        if (s->crypt_method_header == QCOW_CRYPT_AES) {
+            s->crypt_physical_offset = false;
+        } else {
+            s->crypt_physical_offset = true;
+        }
+
         bs->encrypted = true;
         bs->valid_key = true;
     }
@@ -1138,25 +1271,36 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
 
     /* read qcow2 extensions */
     if (qcow2_read_extensions(bs, header.header_length, ext_end, NULL,
-        &local_err)) {
+                              flags, &local_err)) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto fail;
     }
 
-    if (s->crypt_method_header == QCOW_CRYPT_AES) {
-        unsigned int cflags = 0;
-        if (flags & BDRV_O_NO_IO) {
-            cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
-        }
-        /* TODO how do we pass the same crypto opts down to the
-         * backing file by default, so we don't have to manually
-         * provide the same key-secret property against the full
-         * backing chain
-         */
-        s->crypto = qcrypto_block_open(s->crypto_opts, NULL, NULL,
-                                       cflags, errp);
-        if (!s->crypto) {
+    /* qcow2_read_extension may have set up the crypto context
+     * if the crypt method needs a header region, some methods
+     * don't need header extensions, so must check here
+     */
+    if (s->crypt_method_header && !s->crypto) {
+        if (s->crypt_method_header == QCOW_CRYPT_AES) {
+            unsigned int cflags = 0;
+            if (flags & BDRV_O_NO_IO) {
+                cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
+            }
+            /* TODO how do we pass the same crypto opts down to the
+             * backing file by default, so we don't have to manually
+             * provide the same key-secret property against the full
+             * backing chain
+             */
+            s->crypto = qcrypto_block_open(s->crypto_opts, NULL, NULL,
+                                           cflags, errp);
+            if (!s->crypto) {
+                ret = -EINVAL;
+                goto fail;
+            }
+        } else if (!(flags & BDRV_O_NO_IO)) {
+            error_setg(errp, "Missing CRYPTO header for crypt method %d",
+                       s->crypt_method_header);
             ret = -EINVAL;
             goto fail;
         }
@@ -1535,7 +1679,9 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
                 assert((cur_bytes & (BDRV_SECTOR_SIZE - 1)) == 0);
                 Error *err = NULL;
                 if (qcrypto_block_decrypt(s->crypto,
-                                          offset >> BDRV_SECTOR_BITS,
+                                          (s->crypt_physical_offset ?
+                                           cluster_offset + offset_in_cluster :
+                                           offset) >> BDRV_SECTOR_BITS,
                                           cluster_data,
                                           cur_bytes,
                                           &err) < 0) {
@@ -1631,7 +1777,10 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
                    QCOW_MAX_CRYPT_CLUSTERS * s->cluster_size);
             qemu_iovec_to_buf(&hd_qiov, 0, cluster_data, hd_qiov.size);
 
-            if (qcrypto_block_encrypt(s->crypto, offset >> BDRV_SECTOR_BITS,
+            if (qcrypto_block_encrypt(s->crypto,
+                                      (s->crypt_physical_offset ?
+                                       cluster_offset + offset_in_cluster :
+                                       offset) >> BDRV_SECTOR_BITS,
                                       cluster_data,
                                       cur_bytes, &err) < 0) {
                 error_free(err);
@@ -1929,6 +2078,22 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Full disk encryption header pointer extension */
+    if (s->crypto_header.offset != 0) {
+        cpu_to_be64s(&s->crypto_header.offset);
+        cpu_to_be64s(&s->crypto_header.length);
+        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_CRYPTO_HEADER,
+                             &s->crypto_header, sizeof(s->crypto_header),
+                             buflen);
+        be64_to_cpus(&s->crypto_header.offset);
+        be64_to_cpus(&s->crypto_header.length);
+        if (ret < 0) {
+            goto fail;
+        }
+        buf += ret;
+        buflen -= ret;
+    }
+
     /* Feature table */
     if (s->qcow_version >= 3) {
         Qcow2Feature features[] = {
@@ -2027,25 +2192,46 @@ static int qcow2_change_backing_file(BlockDriverState *bs,
     return qcow2_update_header(bs);
 }
 
+static int qcow2_crypt_method_from_format(const char *format)
+{
+    if (g_str_equal(format, "luks")) {
+        return QCOW_CRYPT_LUKS;
+    } else if (g_str_equal(format, "aes")) {
+        return QCOW_CRYPT_AES;
+    } else {
+        return -EINVAL;
+    }
+}
 
 static int qcow2_set_up_encryption(BlockDriverState *bs, QemuOpts *opts,
-                                   Error **errp)
+                                   const char *format, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     QCryptoBlockCreateOptions *cryptoopts = NULL;
     QCryptoBlock *crypto = NULL;
     int ret = -EINVAL;
 
-    cryptoopts = block_crypto_create_opts_init(
-        Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
+    if (g_str_equal(format, "luks")) {
+        cryptoopts = block_crypto_create_opts_init(
+            Q_CRYPTO_BLOCK_FORMAT_LUKS, opts, "luks-", errp);
+        s->crypt_method_header = QCOW_CRYPT_LUKS;
+    } else if (g_str_equal(format, "aes")) {
+        cryptoopts = block_crypto_create_opts_init(
+            Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
+        s->crypt_method_header = QCOW_CRYPT_AES;
+    } else {
+        error_setg(errp, "Unknown encryption format %s", format);
+        ret = -EINVAL;
+        goto out;
+    }
     if (!cryptoopts) {
         ret = -EINVAL;
         goto out;
     }
-    s->crypt_method_header = QCOW_CRYPT_AES;
 
     crypto = qcrypto_block_create(cryptoopts,
-                                  NULL, NULL,
+                                  qcow2_crypto_hdr_init_func,
+                                  qcow2_crypto_hdr_write_func,
                                   bs, errp);
     if (!crypto) {
         ret = -EINVAL;
@@ -2134,6 +2320,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
 {
     int cluster_bits;
     QDict *options;
+    const char *encryption_format;
 
     /* Calculate cluster_bits */
     cluster_bits = ctz32(cluster_size);
@@ -2337,8 +2524,15 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     }
 
     /* Want encryption? There you go. */
-    if (flags & BLOCK_FLAG_ENCRYPT) {
-        ret = qcow2_set_up_encryption(blk_bs(blk), opts, errp);
+    encryption_format = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPTION_FORMAT);
+    if (!encryption_format &&
+        qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
+        encryption_format = "aes";
+    }
+
+    if (encryption_format) {
+        ret = qcow2_set_up_encryption(blk_bs(blk), opts, encryption_format,
+                                      errp);
         if (ret < 0) {
             goto out;
         }
@@ -2404,9 +2598,6 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
                     BDRV_SECTOR_SIZE);
     backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
     backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
-    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
-        flags |= BLOCK_FLAG_ENCRYPT;
-    }
     cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
                                          DEFAULT_CLUSTER_SIZE);
     buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
@@ -3153,6 +3344,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     const char *compat = NULL;
     uint64_t cluster_size = s->cluster_size;
     bool encrypt;
+    int encformat;
     int refcount_bits = s->refcount_bits;
     int ret;
     QemuOptDesc *desc = opts->list->desc;
@@ -3194,6 +3386,14 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                 error_report("Changing the encryption flag is not supported");
                 return -ENOTSUP;
             }
+        } else if (!strcmp(desc->name, BLOCK_OPT_ENCRYPTION_FORMAT)) {
+            encformat = qcow2_crypt_method_from_format(
+                qemu_opt_get(opts, BLOCK_OPT_ENCRYPT));
+
+            if (encformat != s->crypt_method_header) {
+                error_report("Changing the encryption format is not supported");
+                return -ENOTSUP;
+            }
         } else if (!strcmp(desc->name, BLOCK_OPT_CLUSTER_SIZE)) {
             cluster_size = qemu_opt_get_size(opts, BLOCK_OPT_CLUSTER_SIZE,
                                              cluster_size);
@@ -3399,7 +3599,8 @@ static QemuOptsList qcow2_create_opts = {
         {
             .name = BLOCK_OPT_ENCRYPT,
             .type = QEMU_OPT_BOOL,
-            .help = "Encrypt the image",
+            .help = "Deprecated, use the " BLOCK_OPT_ENCRYPTION_FORMAT
+                    " option instead",
             .def_value_str = "off"
         },
         {
@@ -3426,7 +3627,20 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Width of a reference count entry in bits",
             .def_value_str = "16"
         },
+        {
+            .name = BLOCK_OPT_ENCRYPTION_FORMAT,
+            .type = QEMU_OPT_STRING,
+            .help = "Encryption data format 'luks' (recommended) or "
+                    "'aes' (deprecated)",
+        },
         BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("aes-"),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET("luks-"),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("luks-"),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("luks-"),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("luks-"),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("luks-"),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("luks-"),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("luks-"),
         { /* end of list */ }
     }
 };
diff --git a/block/qcow2.h b/block/qcow2.h
index f4cb171..8cc22f0 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -36,6 +36,7 @@
 
 #define QCOW_CRYPT_NONE 0
 #define QCOW_CRYPT_AES  1
+#define QCOW_CRYPT_LUKS 2
 
 #define QCOW_MAX_CRYPT_CLUSTERS 32
 #define QCOW_MAX_SNAPSHOTS 65536
@@ -163,6 +164,11 @@ typedef struct QCowSnapshot {
 struct Qcow2Cache;
 typedef struct Qcow2Cache Qcow2Cache;
 
+typedef struct Qcow2CryptoHeaderExtension {
+    uint64_t offset;
+    uint64_t length;
+} QEMU_PACKED Qcow2CryptoHeaderExtension;
+
 typedef struct Qcow2UnknownHeaderExtension {
     uint32_t magic;
     uint32_t len;
@@ -256,8 +262,11 @@ typedef struct BDRVQcow2State {
 
     CoMutex lock;
 
+    Qcow2CryptoHeaderExtension crypto_header; /* QCow2 header extension */
     QCryptoBlockOpenOptions *crypto_opts; /* Disk encryption runtime options */
     QCryptoBlock *crypto; /* Disk encryption format driver */
+    bool crypt_physical_offset; /* Whether to use virtual or physical offset
+                                   for encryption initialization vector tweak */
     uint32_t crypt_method_header;
     uint64_t snapshots_offset;
     int snapshots_size;
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 2d92d7e..95e630e 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -41,6 +41,7 @@
 
 #define BLOCK_OPT_SIZE              "size"
 #define BLOCK_OPT_ENCRYPT           "encryption"
+#define BLOCK_OPT_ENCRYPTION_FORMAT "encryption-format"
 #define BLOCK_OPT_COMPAT6           "compat6"
 #define BLOCK_OPT_HWVERSION         "hwversion"
 #define BLOCK_OPT_BACKING_FILE      "backing_file"
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 4943942..d15c6a9 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2327,9 +2327,15 @@
 #                         caches. The interval is in seconds. The default value
 #                         is 0 and it disables this feature (since 2.5)
 # @aes-key-secret:        #optional the ID of a QCryptoSecret object providing
-#                         the AES decryption key (since 2.9). Mandatory for
+#                         the AES decryption key (since 2.9). Mandatory for AES
 #                         encrypted images, except when doing a metadata-only
 #                         probe of the image.
+#                         the AES decryption key (since 2.9) Mandatory except
+#                         when doing a metadata-only probe of the image.
+# @luks-key-secret:       #optional the ID of a QCryptoSecret object providing
+#                         the LUKS keyslot passphrase (since 2.9). Mandatory for
+#                         LUKS encrypted images, except when doing a metadata-
+#                         only probe of the image.
 #
 # Since: 1.7
 ##
@@ -2344,7 +2350,8 @@
             '*l2-cache-size': 'int',
             '*refcount-cache-size': 'int',
             '*cache-clean-interval': 'int',
-            '*aes-key-secret': 'str' } }
+            '*aes-key-secret': 'str',
+            '*luks-key-secret': 'str' } }
 
 ##
 # @BlockdevOptionsArchipelago:
diff --git a/qemu-img.c b/qemu-img.c
index 5df66fe..f6b04f6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2046,6 +2046,8 @@ static int img_convert(int argc, char **argv)
     if (compress) {
         bool encryption =
             qemu_opt_get_bool(opts, BLOCK_OPT_ENCRYPT, false);
+        const char *encryption_format =
+            qemu_opt_get(opts, BLOCK_OPT_ENCRYPTION_FORMAT);
         const char *preallocation =
             qemu_opt_get(opts, BLOCK_OPT_PREALLOC);
 
@@ -2055,7 +2057,7 @@ static int img_convert(int argc, char **argv)
             goto out;
         }
 
-        if (encryption) {
+        if (encryption || encryption_format) {
             error_report("Compression and encryption not supported at "
                          "the same time");
             ret = -1;
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index f8dee34..953a1c9 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -48,12 +48,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: create -f qcow2 -o ? TEST_DIR/t.qcow2 128M
@@ -62,12 +70,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: create -f qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2 128M
@@ -76,12 +92,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: create -f qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2 128M
@@ -90,12 +114,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: create -f qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2 128M
@@ -104,12 +136,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: create -f qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2 128M
@@ -118,12 +158,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: create -f qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2 128M
@@ -132,12 +180,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: create -f qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2 128M
@@ -146,12 +202,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg   Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 128M
@@ -175,12 +239,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 
 Testing: create -o help
 Supported options:
@@ -238,12 +310,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: convert -O qcow2 -o ? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
@@ -252,12 +332,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: convert -O qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
@@ -266,12 +354,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: convert -O qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
@@ -280,12 +376,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: convert -O qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
@@ -294,12 +398,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: convert -O qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
@@ -308,12 +420,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: convert -O qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
@@ -322,12 +442,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: convert -O qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
@@ -336,12 +464,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: convert -O qcow2 -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
@@ -365,12 +501,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 
 Testing: convert -o help
 Supported options:
@@ -425,12 +569,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: amend -f qcow2 -o ? TEST_DIR/t.qcow2
@@ -439,12 +591,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: amend -f qcow2 -o cluster_size=4k,help TEST_DIR/t.qcow2
@@ -453,12 +613,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: amend -f qcow2 -o cluster_size=4k,? TEST_DIR/t.qcow2
@@ -467,12 +635,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: amend -f qcow2 -o help,cluster_size=4k TEST_DIR/t.qcow2
@@ -481,12 +657,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: amend -f qcow2 -o ?,cluster_size=4k TEST_DIR/t.qcow2
@@ -495,12 +679,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: amend -f qcow2 -o cluster_size=4k -o help TEST_DIR/t.qcow2
@@ -509,12 +701,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: amend -f qcow2 -o cluster_size=4k -o ? TEST_DIR/t.qcow2
@@ -523,12 +723,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: amend -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2
@@ -554,12 +762,20 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Deprecated, use the encryption-format option instead
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (recommended) or 'aes' (deprecated)
 aes-key-secret   ID of the secret that provides the AES encryption key
+luks-key-secret  ID of the secret that provides the keyslot passphrase
+luks-cipher-alg  Name of encryption cipher algorithm
+luks-cipher-mode Name of encryption cipher mode
+luks-ivgen-alg   Name of IV generator algorithm
+luks-ivgen-hash-alg Name of IV generator hash algorithm
+luks-hash-alg    Name of encryption hash algorithm
+luks-iter-time   Time to spend in PBKDF in milliseconds
 
 Testing: convert -o help
 Supported options:
-- 
2.9.3
