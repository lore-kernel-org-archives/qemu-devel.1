Received: from eggs.gnu.org ([2001:4830:134:3::10]:48409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOTpV-0004W5-9W
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:29:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cOTpP-0001FK-28
	for qemu-devel@nongnu.org; Tue, 03 Jan 2017 13:29:01 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue,  3 Jan 2017 18:27:58 +0000
Message-Id: <20170103182801.9638-13-berrange@redhat.com>
In-Reply-To: <20170103182801.9638-1-berrange@redhat.com>
References: <20170103182801.9638-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 12/15] qcow2: add support for LUKS
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, "Daniel P. Berrange" <berrange@redhat.com>

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
 block/qcow2.c              | 236 ++++++++++++++++++++++++++++++++++++++-------
 block/qcow2.h              |   9 ++
 docs/specs/qcow2.txt       |  99 +++++++++++++++++++
 qapi/block-core.json       |   6 +-
 tests/qemu-iotests/049     |   2 +-
 tests/qemu-iotests/082.out | 216 +++++++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/087     |  65 ++++++++++++-
 tests/qemu-iotests/087.out |  22 ++++-
 tests/qemu-iotests/134     |   4 +-
 tests/qemu-iotests/158     |   8 +-
 tests/qemu-iotests/174     |  76 +++++++++++++++
 tests/qemu-iotests/174.out |  19 ++++
 tests/qemu-iotests/175     |  85 ++++++++++++++++
 tests/qemu-iotests/175.out |  26 +++++
 tests/qemu-iotests/group   |   2 +
 17 files changed, 840 insertions(+), 49 deletions(-)
 create mode 100755 tests/qemu-iotests/174
 create mode 100644 tests/qemu-iotests/174.out
 create mode 100755 tests/qemu-iotests/175
 create mode 100644 tests/qemu-iotests/175.out

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
index 5c9e196..b354914 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -66,6 +66,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_END 0
 #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
 #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
+#define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
@@ -80,6 +81,73 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
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
@@ -89,7 +157,7 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
  */
 static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
                                  uint64_t end_offset, void **p_feature_table,
-                                 Error **errp)
+                                 int flags, Error **errp)
 {
     BDRVQcow2State *s = bs->opaque;
     QCowExtension ext;
@@ -165,6 +233,45 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
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
+            be64_to_cpu(s->crypto_header.offset);
+            be64_to_cpu(s->crypto_header.length);
+
+            if (flags & BDRV_O_NO_IO) {
+                cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
+            }
+            /* XXX how do we pass the same crypto opts down to the
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
+            s->crypt_physical_offset = true;
+        }   break;
         default:
             /* unknown magic - save it in case we need to rewrite the header */
             {
@@ -465,6 +572,7 @@ static QemuOptsList qcow2_runtime_opts = {
             .help = "Clean unused cache entries after this time (in seconds)",
         },
         BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("aes-"),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_KEY_SECRET("luks-"),
         { /* end of list */ }
     },
 };
@@ -766,6 +874,11 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
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
@@ -956,7 +1069,7 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
     if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
         void *feature_table = NULL;
         qcow2_read_extensions(bs, header.header_length, ext_end,
-                              &feature_table, NULL);
+                              &feature_table, flags, NULL);
         report_unsupported_feature(errp, feature_table,
                                    s->incompatible_features &
                                    ~QCOW2_INCOMPAT_MASK);
@@ -988,12 +1101,6 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1138,25 +1245,37 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
 
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
-        /* XXX how do we pass the same crypto opts down to the
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
+            /* XXX how do we pass the same crypto opts down to the
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
+            s->crypt_physical_offset = false;
+        } else if (!(flags & BDRV_O_NO_IO)) {
+            error_setg(errp, "Missing CRYPTO header for crypt method %d",
+                       s->crypt_method_header);
             ret = -EINVAL;
             goto fail;
         }
@@ -1535,7 +1654,9 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
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
@@ -1631,7 +1752,10 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
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
@@ -1929,6 +2053,22 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Full disk encryption header pointer extension */
+    if (s->crypto_header.offset != 0) {
+        cpu_to_be64(s->crypto_header.offset);
+        cpu_to_be64(s->crypto_header.length);
+        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_CRYPTO_HEADER,
+                             &s->crypto_header, sizeof(s->crypto_header),
+                             buflen);
+        be64_to_cpu(s->crypto_header.offset);
+        be64_to_cpu(s->crypto_header.length);
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
@@ -2029,23 +2169,34 @@ static int qcow2_change_backing_file(BlockDriverState *bs,
 
 
 static int qcow2_change_encryption(BlockDriverState *bs, QemuOpts *opts,
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
@@ -2134,6 +2285,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
 {
     int cluster_bits;
     QDict *options;
+    const char *encryption_format;
 
     /* Calculate cluster_bits */
     cluster_bits = ctz32(cluster_size);
@@ -2337,8 +2489,15 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     }
 
     /* Want encryption? There you go. */
-    if (flags & BLOCK_FLAG_ENCRYPT) {
-        ret = qcow2_change_encryption(blk_bs(blk), opts, errp);
+    encryption_format = qemu_opt_get_del(opts, QCOW2_OPT_ENCRYPTION_FORMAT);
+    if (!encryption_format &&
+        qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
+        encryption_format = "aes";
+    }
+
+    if (encryption_format) {
+        ret = qcow2_change_encryption(blk_bs(blk), opts, encryption_format,
+                                      errp);
         if (ret < 0) {
             goto out;
         }
@@ -2404,9 +2563,6 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
                     BDRV_SECTOR_SIZE);
     backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
     backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
-    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
-        flags |= BLOCK_FLAG_ENCRYPT;
-    }
     cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
                                          DEFAULT_CLUSTER_SIZE);
     buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
@@ -3426,7 +3582,19 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Width of a reference count entry in bits",
             .def_value_str = "16"
         },
+        {
+            .name = QCOW2_OPT_ENCRYPTION_FORMAT,
+            .type = QEMU_OPT_STRING,
+            .help = "Encryption data format 'luks' (default) or 'aes'",
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
index f4cb171..cfa9eec 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -36,6 +36,7 @@
 
 #define QCOW_CRYPT_NONE 0
 #define QCOW_CRYPT_AES  1
+#define QCOW_CRYPT_LUKS 2
 
 #define QCOW_MAX_CRYPT_CLUSTERS 32
 #define QCOW_MAX_SNAPSHOTS 65536
@@ -97,6 +98,7 @@
 #define QCOW2_OPT_L2_CACHE_SIZE "l2-cache-size"
 #define QCOW2_OPT_REFCOUNT_CACHE_SIZE "refcount-cache-size"
 #define QCOW2_OPT_CACHE_CLEAN_INTERVAL "cache-clean-interval"
+#define QCOW2_OPT_ENCRYPTION_FORMAT "encryption-format"
 
 typedef struct QCowHeader {
     uint32_t magic;
@@ -163,6 +165,11 @@ typedef struct QCowSnapshot {
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
@@ -256,8 +263,10 @@ typedef struct BDRVQcow2State {
 
     CoMutex lock;
 
+    Qcow2CryptoHeaderExtension crypto_header; /* QCow2 header extension */
     QCryptoBlockOpenOptions *crypto_opts; /* Disk encryption runtime options */
     QCryptoBlock *crypto; /* Disk encryption format driver */
+    bool crypt_physical_offset; /* Whether to use virtual or physical offset for IV */
     uint32_t crypt_method_header;
     uint64_t snapshots_offset;
     int snapshots_size;
diff --git a/docs/specs/qcow2.txt b/docs/specs/qcow2.txt
index 80cdfd0..cc90276 100644
--- a/docs/specs/qcow2.txt
+++ b/docs/specs/qcow2.txt
@@ -45,6 +45,7 @@ The first cluster of a qcow2 image contains the file header:
          32 - 35:   crypt_method
                     0 for no encryption
                     1 for AES encryption
+                    2 for LUKS encryption
 
          36 - 39:   l1_size
                     Number of entries in the active L1 table
@@ -135,6 +136,7 @@ be stored. Each extension has a structure like the following:
                         0xE2792ACA - Backing file format name
                         0x6803f857 - Feature name table
                         0x23852875 - Bitmaps extension
+                        0x0537be77 - Full disk encryption header pointer
                         other      - Unknown header extension, can be safely
                                      ignored
 
@@ -207,6 +209,103 @@ The fields of the bitmaps extension are:
                    Offset into the image file at which the bitmap directory
                    starts. Must be aligned to a cluster boundary.
 
+== Full disk encryption header pointer ==
+
+The full disk encryption header must be present if, and only if, the
+'crypt_method' header requires metadata. Currently this is only true
+of the 'LUKS' crypt method. The header extension must be absent for
+other methods.
+
+This header provides the offset at which the crypt method can store
+its additional data, as well as the length of such data.
+
+    Byte  0 -  7:   Offset into the image file at which the encryption
+                    header starts in bytes. Must be aligned to a cluster
+		    boundary.
+    Byte  8 - 16:   Length of the written encryption header in bytes.
+                    Note actual space allocated in the qcow2 file may
+		    be larger than this value, since it will be rounded
+		    to the nearest multiple of the cluster size. Any
+		    unused bytes in the allocated space will be initialized
+		    to 0.
+
+For the LUKS crypt method, the encryption header works as follows.
+
+The first 592 bytes of the header clusters will contain the LUKS
+partition header. This is then followed by the key material data areas.
+The size of the key material data areas is determined by the number of
+stripes in the key slot and key size. Refer to the LUKS format
+specification ('docs/on-disk-format.pdf' in the cryptsetup source
+package) for details of the LUKS partition header format.
+
+In the LUKS partition header, the "payload-offset" field will be
+calculated as normal for the LUKS spec. ie the size of the LUKS
+header, plus key material regions, plus padding. Its value is not
+used, however, since the qcow2 file format itself defines where
+the real payload offset is.
+
+In the LUKS key slots header, the "key-material-offset" is relative
+to the start of the LUKS header clusters in the qcow2 container,
+not the start of the qcow2 file.
+
+Logically the layout looks like
+
+  +-----------------------------+
+  | QCow2 header                |
+  +-----------------------------+
+  | QCow2 header extension X    |
+  +-----------------------------+
+  | QCow2 header extension FDE  |
+  +-----------------------------+
+  | QCow2 header extension ...  |
+  +-----------------------------+
+  | QCow2 header extension Z    |
+  +-----------------------------+
+  | ....other QCow2 tables....  |
+  .                             .
+  .                             .
+  +-----------------------------+
+  | +-------------------------+ |
+  | | LUKS partition header   | |
+  | +-------------------------+ |
+  | | LUKS key material 1     | |
+  | +-------------------------+ |
+  | | LUKS key material 2     | |
+  | +-------------------------+ |
+  | | LUKS key material ...   | |
+  | +-------------------------+ |
+  | | LUKS key material 8     | |
+  | +-------------------------+ |
+  +-----------------------------+
+  | QCow2 cluster payload       |
+  .                             .
+  .                             .
+  .                             .
+  |                             |
+  +-----------------------------+
+
+== Data encryption ==
+
+When an encryption method is requested in the header, the image payload
+data must be encrypted/decrypted on every write/read. The image headers
+and metadata is never encrypted.
+
+The algorithms used for encryption vary depending on the method
+
+ - AES:
+
+   The AES cipher, in CBC mode, with 256 bit keys.
+
+   Initialization vectors generated using plain64 method, with
+   the virtual disk sector as the input tweak.
+
+ - LUKS:
+
+   The algorithms are specified in the LUKS header.
+
+   Initialization vectors generated using the method specified
+   in the LUKS header, with the physical disk sector as the
+   input tweak.
 
 == Host cluster management ==
 
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 2ca5674..08bc3e4 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1938,6 +1938,9 @@
 # @aes-key-secret:        #optional the ID of a QCryptoSecret object providing
 #                         the AES decryption key (since 2.9) Mandatory except
 #                         when doing a metadata-only probe of the image.
+# @luks-key-secret:       #optional the ID of a QCryptoSecret object providing
+#                         the LUKS keyslot passphrase (since 2.9) Mandatory
+#                         except when doing a metadata-only probe of the image.
 #
 # Since: 1.7
 ##
@@ -1952,7 +1955,8 @@
             '*l2-cache-size': 'int',
             '*refcount-cache-size': 'int',
             '*cache-clean-interval': 'int',
-            '*aes-key-secret': 'str' } }
+            '*aes-key-secret': 'str',
+            '*luks-key-secret': 'str' } }
 
 ##
 # @BlockdevOptionsArchipelago:
diff --git a/tests/qemu-iotests/049 b/tests/qemu-iotests/049
index 7da4ac8..a16430d 100755
--- a/tests/qemu-iotests/049
+++ b/tests/qemu-iotests/049
@@ -106,7 +106,7 @@ test_qemu_img create -f $IMGFMT -o preallocation=1234 "$TEST_IMG" 64M
 echo "== Check encryption option =="
 echo
 test_qemu_img create -f $IMGFMT -o encryption=off "$TEST_IMG" 64M
-test_qemu_img create -f $IMGFMT --object secret,id=sec0,data=123456 -o encryption=on,qcow-key-secret=sec0 "$TEST_IMG" 64M
+test_qemu_img create -f $IMGFMT --object secret,id=sec0,data=123456 -o encryption=on,aes-key-secret=sec0 "$TEST_IMG" 64M
 
 echo "== Check lazy_refcounts option (only with v3) =="
 echo
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index f8dee34..aa53cf7 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -53,7 +53,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -67,7 +75,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -81,7 +97,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -95,7 +119,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -109,7 +141,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -123,7 +163,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -137,7 +185,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -151,7 +207,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -180,7 +244,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -243,7 +315,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -257,7 +337,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -271,7 +359,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -285,7 +381,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -299,7 +403,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -313,7 +425,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -327,7 +447,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -341,7 +469,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -370,7 +506,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -430,7 +574,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -444,7 +596,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -458,7 +618,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -472,7 +640,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -486,7 +662,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -500,7 +684,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -514,7 +706,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -528,7 +728,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
@@ -559,7 +767,15 @@ cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
 refcount_bits    Width of a reference count entry in bits
+encryption-format Encryption data format 'luks' (default) or 'aes'
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
diff --git a/tests/qemu-iotests/087 b/tests/qemu-iotests/087
index fe30383..6690715 100755
--- a/tests/qemu-iotests/087
+++ b/tests/qemu-iotests/087
@@ -121,10 +121,10 @@ run_qemu <<EOF
 EOF
 
 echo
-echo === Encrypted image ===
+echo === Encrypted image QCow ===
 echo
 
-_make_test_img --object secret,id=sec0,data=123456 -o encryption=on,qcow-key-secret=sec0 $size
+_make_test_img --object secret,id=sec0,data=123456 -o encryption=on,aes-key-secret=sec0 $size
 run_qemu -S <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "object-add",
@@ -144,7 +144,7 @@ run_qemu -S <<EOF
           "driver": "file",
           "filename": "$TEST_IMG"
       },
-      "qcow-key-secret": "sec0"
+      "aes-key-secret": "sec0"
     }
   }
 { "execute": "quit" }
@@ -169,7 +169,62 @@ run_qemu <<EOF
           "driver": "file",
           "filename": "$TEST_IMG"
       },
-      "qcow-key-secret": "sec0"
+      "aes-key-secret": "sec0"
+    }
+  }
+{ "execute": "quit" }
+EOF
+
+echo
+echo === Encrypted image LUKS ===
+echo
+
+_make_test_img --object secret,id=sec0,data=123456 -o encryption-format=luks,luks-key-secret=sec0 $size
+run_qemu -S <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "object-add",
+  "arguments": {
+      "qom-type": "secret",
+      "id": "sec0",
+      "props": {
+          "data": "123456"
+      }
+  }
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "node-name": "disk",
+      "file": {
+          "driver": "file",
+          "filename": "$TEST_IMG"
+      },
+      "luks-key-secret": "sec0"
+    }
+  }
+{ "execute": "quit" }
+EOF
+
+run_qemu <<EOF
+{ "execute": "qmp_capabilities" }
+{ "execute": "object-add",
+  "arguments": {
+      "qom-type": "secret",
+      "id": "sec0",
+      "props": {
+          "data": "123456"
+      }
+  }
+}
+{ "execute": "blockdev-add",
+  "arguments": {
+      "driver": "$IMGFMT",
+      "node-name": "disk",
+      "file": {
+          "driver": "file",
+          "filename": "$TEST_IMG"
+      },
+      "luks-key-secret": "sec0"
     }
   }
 { "execute": "quit" }
@@ -179,7 +234,7 @@ echo
 echo === Missing driver ===
 echo
 
-_make_test_img --object secret,id=sec0,data=123456 -o encryption=on,qcow-key-secret=sec0 $size
+_make_test_img --object secret,id=sec0,data=123456 -o encryption=on,aes-key-secret=sec0 $size
 run_qemu -S <<EOF
 { "execute": "qmp_capabilities" }
 { "execute": "blockdev-add",
diff --git a/tests/qemu-iotests/087.out b/tests/qemu-iotests/087.out
index 02c9e42..2266100 100644
--- a/tests/qemu-iotests/087.out
+++ b/tests/qemu-iotests/087.out
@@ -32,7 +32,7 @@ QMP_VERSION
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
 
 
-=== Encrypted image ===
+=== Encrypted image QCow ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on aes-key-secret=sec0
 Testing: -S
@@ -52,6 +52,26 @@ QMP_VERSION
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
 
 
+=== Encrypted image LUKS ===
+
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption-format=luks luks-key-secret=sec0
+Testing: -S
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+
+Testing:
+QMP_VERSION
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN"}
+
+
 === Missing driver ===
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption=on aes-key-secret=sec0
diff --git a/tests/qemu-iotests/134 b/tests/qemu-iotests/134
index c2458d8..dd080a2 100755
--- a/tests/qemu-iotests/134
+++ b/tests/qemu-iotests/134
@@ -47,9 +47,9 @@ size=128M
 SECRET="secret,id=sec0,data=astrochicken"
 SECRETALT="secret,id=sec0,data=platypus"
 
-_make_test_img --object $SECRET -o "encryption=on,qcow-key-secret=sec0" $size
+_make_test_img --object $SECRET -o "encryption=on,aes-key-secret=sec0" $size
 
-IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,qcow-key-secret=sec0"
+IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,aes-key-secret=sec0"
 
 QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
 
diff --git a/tests/qemu-iotests/158 b/tests/qemu-iotests/158
index 2d1c015..7a1eb5c 100755
--- a/tests/qemu-iotests/158
+++ b/tests/qemu-iotests/158
@@ -49,11 +49,11 @@ SECRET="secret,id=sec0,data=astrochicken"
 TEST_IMG_SAVE=$TEST_IMG
 TEST_IMG=$TEST_IMG_BASE
 echo "== create base =="
-_make_test_img --object $SECRET -o "encryption=on,qcow-key-secret=sec0" $size
+_make_test_img --object $SECRET -o "encryption=on,aes-key-secret=sec0" $size
 TEST_IMG=$TEST_IMG_SAVE
 
-IMGSPECBASE="driver=$IMGFMT,file.filename=$TEST_IMG_BASE,qcow-key-secret=sec0"
-IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,backing.driver=$IMGFMT,backing.file.filename=$TEST_IMG_BASE,backing.qcow-key-secret=sec0,qcow-key-secret=sec0"
+IMGSPECBASE="driver=$IMGFMT,file.filename=$TEST_IMG_BASE,aes-key-secret=sec0"
+IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,backing.driver=$IMGFMT,backing.file.filename=$TEST_IMG_BASE,backing.aes-key-secret=sec0,aes-key-secret=sec0"
 QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
 
 echo
@@ -65,7 +65,7 @@ echo "== verify pattern =="
 $QEMU_IO --object $SECRET -c "read -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
 
 echo "== create overlay =="
-_make_test_img --object $SECRET -o "encryption=on,qcow-key-secret=sec0" -b "$TEST_IMG_BASE" $size
+_make_test_img --object $SECRET -o "encryption=on,aes-key-secret=sec0" -b "$TEST_IMG_BASE" $size
 
 echo
 echo "== writing part of a cluster =="
diff --git a/tests/qemu-iotests/174 b/tests/qemu-iotests/174
new file mode 100755
index 0000000..27d4870
--- /dev/null
+++ b/tests/qemu-iotests/174
@@ -0,0 +1,76 @@
+#!/bin/bash
+#
+# Test encrypted read/write using plain bdrv_read/bdrv_write
+#
+# Copyright (C) 2015 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=berrange@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto generic
+_supported_os Linux
+
+
+size=128M
+
+SECRET="secret,id=sec0,data=astrochicken"
+SECRETALT="secret,id=sec0,data=platypus"
+
+_make_test_img --object $SECRET -o "encryption-format=luks,luks-key-secret=sec0" $size
+
+IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,luks-key-secret=sec0"
+
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+echo
+echo "== reading whole image =="
+$QEMU_IO --object $SECRET -c "read 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== rewriting whole image =="
+$QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern =="
+$QEMU_IO --object $SECRET -c "read -P 0xa 0 $size"  --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern failure with wrong password =="
+$QEMU_IO --object $SECRETALT -c "read -P 0xa 0 $size" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/174.out b/tests/qemu-iotests/174.out
new file mode 100644
index 0000000..c96d0e4
--- /dev/null
+++ b/tests/qemu-iotests/174.out
@@ -0,0 +1,19 @@
+QA output created by 174
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 encryption-format=luks luks-key-secret=sec0
+
+== reading whole image ==
+read 134217728/134217728 bytes at offset 0
+128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== rewriting whole image ==
+wrote 134217728/134217728 bytes at offset 0
+128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+read 134217728/134217728 bytes at offset 0
+128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern failure with wrong password ==
+can't open: Invalid password, cannot unlock any keyslot
+no file open, try 'help open'
+*** done
diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
new file mode 100755
index 0000000..f8a629d
--- /dev/null
+++ b/tests/qemu-iotests/175
@@ -0,0 +1,85 @@
+#!/bin/bash
+#
+# Test encrypted read/write using backing files
+#
+# Copyright (C) 2015 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=berrange@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+here=`pwd`
+status=1	# failure is the default!
+
+_cleanup()
+{
+	_cleanup_test_img
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+
+_supported_fmt qcow2
+_supported_proto generic
+_supported_os Linux
+
+
+size=128M
+TEST_IMG_BASE=$TEST_IMG.base
+SECRET="secret,id=sec0,data=astrochicken"
+
+TEST_IMG_SAVE=$TEST_IMG
+TEST_IMG=$TEST_IMG_BASE
+echo "== create base =="
+_make_test_img --object $SECRET -o "encryption-format=luks,luks-key-secret=sec0" $size
+TEST_IMG=$TEST_IMG_SAVE
+
+IMGSPECBASE="driver=$IMGFMT,file.filename=$TEST_IMG_BASE,luks-key-secret=sec0"
+IMGSPEC="driver=$IMGFMT,file.filename=$TEST_IMG,backing.driver=$IMGFMT,backing.file.filename=$TEST_IMG_BASE,backing.luks-key-secret=sec0,luks-key-secret=sec0"
+QEMU_IO_OPTIONS=$QEMU_IO_OPTIONS_NO_FMT
+
+echo
+echo "== writing whole image =="
+$QEMU_IO --object $SECRET -c "write -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern =="
+$QEMU_IO --object $SECRET -c "read -P 0xa 0 $size" --image-opts $IMGSPECBASE | _filter_qemu_io | _filter_testdir
+
+echo "== create overlay =="
+_make_test_img --object $SECRET -o "encryption-format=luks,luks-key-secret=sec0" -b "$TEST_IMG_BASE" $size
+
+echo
+echo "== writing part of a cluster =="
+$QEMU_IO --object $SECRET -c "write -P 0xe 0 1024" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+echo
+echo "== verify pattern =="
+$QEMU_IO --object $SECRET -c "read -P 0xe 0 1024" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+echo
+echo "== verify pattern =="
+$QEMU_IO --object $SECRET -c "read -P 0xa 1024 64512" --image-opts $IMGSPEC | _filter_qemu_io | _filter_testdir
+
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/175.out b/tests/qemu-iotests/175.out
new file mode 100644
index 0000000..7846d8a
--- /dev/null
+++ b/tests/qemu-iotests/175.out
@@ -0,0 +1,26 @@
+QA output created by 175
+== create base ==
+Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=134217728 encryption-format=luks luks-key-secret=sec0
+
+== writing whole image ==
+wrote 134217728/134217728 bytes at offset 0
+128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+read 134217728/134217728 bytes at offset 0
+128 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+== create overlay ==
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728 backing_file=TEST_DIR/t.IMGFMT.base encryption-format=luks luks-key-secret=sec0
+
+== writing part of a cluster ==
+wrote 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+read 1024/1024 bytes at offset 0
+1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+
+== verify pattern ==
+read 64512/64512 bytes at offset 1024
+63 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index f5d7bc8..dd510d0 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -166,3 +166,5 @@
 171 rw auto quick
 172 auto
 173 rw auto backing
+174 rw auto quick
+175 rw auto quick
-- 
2.9.3
