Received: from eggs.gnu.org ([2001:4830:134:3::10]:44634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxj8-00078y-CB
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxj3-0005Yt-9N
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:09:30 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:02 +0200
Message-Id: <20170711160814.20941-14-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 13/85] qcow2: add support for LUKS encryption
 format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

This adds support for using LUKS as an encryption format
with the qcow2 file, using the new encrypt.format parameter
to request "luks" format. e.g.

  # qemu-img create --object secret,data=123456,id=sec0 \
       -f qcow2 -o encrypt.format=luks,encrypt.key-secret=sec0 \
       test.qcow2 10G

The legacy "encryption=on" parameter still results in
creation of the old qcow2 AES format (and is equivalent
to the new 'encryption-format=aes'). e.g. the following are
equivalent:

  # qemu-img create --object secret,data=123456,id=sec0 \
       -f qcow2 -o encryption=on,encrypt.key-secret=sec0 \
       test.qcow2 10G

 # qemu-img create --object secret,data=123456,id=sec0 \
       -f qcow2 -o encryption-format=aes,encrypt.key-secret=sec0 \
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
Message-id: 20170623162419.26068-14-berrange@redhat.com
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 qapi/block-core.json       |   5 +-
 block/qcow2.h              |   9 ++
 block/qcow2-cluster.c      |  14 ++-
 block/qcow2-refcount.c     |  10 ++
 block/qcow2.c              | 268 ++++++++++++++++++++++++++++++++++++++------
 tests/qemu-iotests/082.out | 270 ++++++++++++++++++++++++++++++++++++---------
 6 files changed, 484 insertions(+), 92 deletions(-)

diff --git a/qapi/block-core.json b/qapi/block-core.json
index 1f268ee..bb075c0 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2325,7 +2325,7 @@
 # Since: 2.10
 ##
 { 'enum': 'BlockdevQcow2EncryptionFormat',
-  'data': [ 'aes' ] }
+  'data': [ 'aes', 'luks' ] }
 
 ##
 # @BlockdevQcow2Encryption:
@@ -2335,7 +2335,8 @@
 { 'union': 'BlockdevQcow2Encryption',
   'base': { 'format': 'BlockdevQcow2EncryptionFormat' },
   'discriminator': 'format',
-  'data': { 'aes': 'QCryptoBlockOptionsQCow' } }
+  'data': { 'aes': 'QCryptoBlockOptionsQCow',
+            'luks': 'QCryptoBlockOptionsLUKS'} }
 
 ##
 # @BlockdevOptionsQcow2:
diff --git a/block/qcow2.h b/block/qcow2.h
index 4b89610..84c9853 100644
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
@@ -257,8 +263,11 @@ typedef struct BDRVQcow2State {
 
     CoMutex lock;
 
+    Qcow2CryptoHeaderExtension crypto_header; /* QCow2 header extension */
     QCryptoBlockOpenOptions *crypto_opts; /* Disk encryption runtime options */
     QCryptoBlock *crypto; /* Disk encryption format driver */
+    bool crypt_physical_offset; /* Whether to use virtual or physical offset
+                                   for encryption initialization vector tweak */
     uint32_t crypt_method_header;
     uint64_t snapshots_offset;
     int snapshots_size;
diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 71a5e0d..f06c08f 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -389,13 +389,16 @@ static int coroutine_fn do_perform_cow_read(BlockDriverState *bs,
 
 static bool coroutine_fn do_perform_cow_encrypt(BlockDriverState *bs,
                                                 uint64_t src_cluster_offset,
+                                                uint64_t cluster_offset,
                                                 unsigned offset_in_cluster,
                                                 uint8_t *buffer,
                                                 unsigned bytes)
 {
     if (bytes && bs->encrypted) {
         BDRVQcow2State *s = bs->opaque;
-        int64_t sector = (src_cluster_offset + offset_in_cluster)
+        int64_t sector = (s->crypt_physical_offset ?
+                          (cluster_offset + offset_in_cluster) :
+                          (src_cluster_offset + offset_in_cluster))
                          >> BDRV_SECTOR_BITS;
         assert((offset_in_cluster & ~BDRV_SECTOR_MASK) == 0);
         assert((bytes & ~BDRV_SECTOR_MASK) == 0);
@@ -788,10 +791,11 @@ static int perform_cow(BlockDriverState *bs, QCowL2Meta *m)
 
     /* Encrypt the data if necessary before writing it */
     if (bs->encrypted) {
-        if (!do_perform_cow_encrypt(bs, m->offset, start->offset,
-                                    start_buffer, start->nb_bytes) ||
-            !do_perform_cow_encrypt(bs, m->offset, end->offset,
-                                    end_buffer, end->nb_bytes)) {
+        if (!do_perform_cow_encrypt(bs, m->offset, m->alloc_offset,
+                                    start->offset, start_buffer,
+                                    start->nb_bytes) ||
+            !do_perform_cow_encrypt(bs, m->offset, m->alloc_offset,
+                                    end->offset, end_buffer, end->nb_bytes)) {
             ret = -EIO;
             goto fail;
         }
diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
index 7c06061..81c22e6 100644
--- a/block/qcow2-refcount.c
+++ b/block/qcow2-refcount.c
@@ -1856,6 +1856,16 @@ static int calculate_refcounts(BlockDriverState *bs, BdrvCheckResult *res,
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
index 1c66ec1..7d1c5a3 100644
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
+                                          void *opaque, Error **errp)
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
+                                          void *opaque, Error **errp)
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
+                                           void *opaque, Error **errp)
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
@@ -165,6 +246,47 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
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
@@ -464,7 +586,8 @@ static QemuOptsList qcow2_runtime_opts = {
             .type = QEMU_OPT_NUMBER,
             .help = "Clean unused cache entries after this time (in seconds)",
         },
-        BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",
+            "ID of secret providing qcow2 AES key or LUKS passphrase"),
         { /* end of list */ }
     },
 };
@@ -784,6 +907,19 @@ static int qcow2_update_options_prepare(BlockDriverState *bs,
             Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, errp);
         break;
 
+    case QCOW_CRYPT_LUKS:
+        if (encryptfmt && !g_str_equal(encryptfmt, "luks")) {
+            error_setg(errp,
+                       "Header reported 'luks' encryption format but "
+                       "options specify '%s'", encryptfmt);
+            ret = -EINVAL;
+            goto fail;
+        }
+        qdict_del(encryptopts, "format");
+        r->crypto_opts = block_crypto_open_opts_init(
+            Q_CRYPTO_BLOCK_FORMAT_LUKS, encryptopts, errp);
+        break;
+
     default:
         error_setg(errp, "Unsupported encryption method %d",
                    s->crypt_method_header);
@@ -977,7 +1113,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     if (s->incompatible_features & ~QCOW2_INCOMPAT_MASK) {
         void *feature_table = NULL;
         qcow2_read_extensions(bs, header.header_length, ext_end,
-                              &feature_table, NULL);
+                              &feature_table, flags, NULL);
         report_unsupported_feature(errp, feature_table,
                                    s->incompatible_features &
                                    ~QCOW2_INCOMPAT_MASK);
@@ -1009,12 +1145,6 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
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
@@ -1031,6 +1161,15 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
             goto fail;
         }
 
+        if (s->crypt_method_header == QCOW_CRYPT_AES) {
+            s->crypt_physical_offset = false;
+        } else {
+            /* Assuming LUKS and any future crypt methods we
+             * add will all use physical offsets, due to the
+             * fact that the alternative is insecure...  */
+            s->crypt_physical_offset = true;
+        }
+
         bs->encrypted = true;
         bs->valid_key = true;
     }
@@ -1159,20 +1298,31 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
 
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
@@ -1566,7 +1716,9 @@ static coroutine_fn int qcow2_co_preadv(BlockDriverState *bs, uint64_t offset,
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
@@ -1700,7 +1852,10 @@ static coroutine_fn int qcow2_co_pwritev(BlockDriverState *bs, uint64_t offset,
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
@@ -2004,6 +2159,22 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -2102,6 +2273,16 @@ static int qcow2_change_backing_file(BlockDriverState *bs,
     return qcow2_update_header(bs);
 }
 
+static int qcow2_crypt_method_from_format(const char *encryptfmt)
+{
+    if (g_str_equal(encryptfmt, "luks")) {
+        return QCOW_CRYPT_LUKS;
+    } else if (g_str_equal(encryptfmt, "aes")) {
+        return QCOW_CRYPT_AES;
+    } else {
+        return -EINVAL;
+    }
+}
 
 static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
                                    QemuOpts *opts, Error **errp)
@@ -2111,27 +2292,36 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
     QCryptoBlock *crypto = NULL;
     int ret = -EINVAL;
     QDict *options, *encryptopts;
+    int fmt;
 
     options = qemu_opts_to_qdict(opts, NULL);
     qdict_extract_subqdict(options, &encryptopts, "encrypt.");
     QDECREF(options);
 
-    if (!g_str_equal(encryptfmt, "aes")) {
-        error_setg(errp, "Unknown encryption format '%s', expected 'aes'",
-                   encryptfmt);
-        ret = -EINVAL;
-        goto out;
+    fmt = qcow2_crypt_method_from_format(encryptfmt);
+
+    switch (fmt) {
+    case QCOW_CRYPT_LUKS:
+        cryptoopts = block_crypto_create_opts_init(
+            Q_CRYPTO_BLOCK_FORMAT_LUKS, encryptopts, errp);
+        break;
+    case QCOW_CRYPT_AES:
+        cryptoopts = block_crypto_create_opts_init(
+            Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, errp);
+        break;
+    default:
+        error_setg(errp, "Unknown encryption format '%s'", encryptfmt);
+        break;
     }
-    cryptoopts = block_crypto_create_opts_init(
-        Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, errp);
     if (!cryptoopts) {
         ret = -EINVAL;
         goto out;
     }
-    s->crypt_method_header = QCOW_CRYPT_AES;
+    s->crypt_method_header = fmt;
 
     crypto = qcrypto_block_create(cryptoopts,
-                                  NULL, NULL,
+                                  qcow2_crypto_hdr_init_func,
+                                  qcow2_crypto_hdr_write_func,
                                   bs, errp);
     if (!crypto) {
         ret = -EINVAL;
@@ -3268,6 +3458,7 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
     const char *compat = NULL;
     uint64_t cluster_size = s->cluster_size;
     bool encrypt;
+    int encformat;
     int refcount_bits = s->refcount_bits;
     Error *local_err = NULL;
     int ret;
@@ -3310,6 +3501,14 @@ static int qcow2_amend_options(BlockDriverState *bs, QemuOpts *opts,
                 error_report("Changing the encryption flag is not supported");
                 return -ENOTSUP;
             }
+        } else if (!strcmp(desc->name, BLOCK_OPT_ENCRYPT_FORMAT)) {
+            encformat = qcow2_crypt_method_from_format(
+                qemu_opt_get(opts, BLOCK_OPT_ENCRYPT_FORMAT));
+
+            if (encformat != s->crypt_method_header) {
+                error_report("Changing the encryption format is not supported");
+                return -ENOTSUP;
+            }
         } else if (!strcmp(desc->name, BLOCK_OPT_CLUSTER_SIZE)) {
             cluster_size = qemu_opt_get_size(opts, BLOCK_OPT_CLUSTER_SIZE,
                                              cluster_size);
@@ -3530,9 +3729,16 @@ static QemuOptsList qcow2_create_opts = {
         {
             .name = BLOCK_OPT_ENCRYPT_FORMAT,
             .type = QEMU_OPT_STRING,
-            .help = "Encrypt the image, format choices: 'aes'",
+            .help = "Encrypt the image, format choices: 'aes', 'luks'",
         },
-        BLOCK_CRYPTO_OPT_DEF_QCOW_KEY_SECRET("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_KEY_SECRET("encrypt.",
+            "ID of secret providing qcow AES key or LUKS passphrase"),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_ALG("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_CIPHER_MODE("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_ALG("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_IVGEN_HASH_ALG("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_HASH_ALG("encrypt."),
+        BLOCK_CRYPTO_OPT_DEF_LUKS_ITER_TIME("encrypt."),
         {
             .name = BLOCK_OPT_CLUSTER_SIZE,
             .type = QEMU_OPT_SIZE,
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 3978db5..dbed67f 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -49,8 +49,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -64,8 +70,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -79,8 +91,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -94,8 +112,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -109,8 +133,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -124,8 +154,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -139,8 +175,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -154,8 +196,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -184,8 +232,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -248,8 +302,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -263,8 +323,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -278,8 +344,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -293,8 +365,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -308,8 +386,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -323,8 +407,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -338,8 +428,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -353,8 +449,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -383,8 +485,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -444,8 +552,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -459,8 +573,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -474,8 +594,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -489,8 +615,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -504,8 +636,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -519,8 +657,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -534,8 +678,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -549,8 +699,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -581,8 +737,14 @@ compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
 encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
-encrypt.format   Encrypt the image, format choices: 'aes'
-encrypt.key-secret ID of the secret that provides the AES encryption key
+encrypt.format   Encrypt the image, format choices: 'aes', 'luks'
+encrypt.key-secret ID of secret providing qcow AES key or LUKS passphrase
+encrypt.cipher-alg Name of encryption cipher algorithm
+encrypt.cipher-mode Name of encryption cipher mode
+encrypt.ivgen-alg Name of IV generator algorithm
+encrypt.ivgen-hash-alg Name of IV generator hash algorithm
+encrypt.hash-alg Name of encryption hash algorithm
+encrypt.iter-time Time to spend in PBKDF in milliseconds
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
-- 
2.9.4
