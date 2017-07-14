Received: from eggs.gnu.org ([2001:4830:134:3::10]:38364)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dVxLZ-0003jf-15
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dVxLX-00084p-Ux
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:17 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:60938 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dVxLX-00083q-KL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:15 -0400
From: Peter Lieven <pl@kamp.de>
Date: Fri, 14 Jul 2017 11:56:41 +0200
Message-Id: <1500026205-15542-6-git-send-email-pl@kamp.de>
In-Reply-To: <1500026205-15542-1-git-send-email-pl@kamp.de>
References: <1500026205-15542-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V3 5/9] block/qcow2: read and write the
 compress format extension
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, berrange@redhat.com, Peter Lieven <pl@kamp.de>

we now read the extension on open and write it on update, but
do not yet use it.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/qcow2.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 block/qcow2.h | 21 +++++++++----
 2 files changed, 105 insertions(+), 10 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 6bf4ea5..1dd2a48 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -70,6 +70,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
+#define  QCOW2_EXT_MAGIC_COMPRESS_FORMAT 0xC03183A3
 
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
@@ -164,6 +165,17 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
 }
 
 
+static void qcow2_compress_level_supported(int format, uint8_t level,
+                                           Error **errp)
+{
+    if (format == QCOW2_COMPRESS_FORMAT_ZLIB && level > 9) {
+        error_setg(errp, "ERROR: compress level %" PRIu8 " is not"
+                         " supported for format '%s'", level,
+                         Qcow2CompressFormat_lookup[format]);
+    }
+}
+
+
 /* 
  * read qcow2 extension and fill bs
  * start reading from start_offset
@@ -241,6 +253,48 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
 #endif
             break;
 
+        case QCOW2_EXT_MAGIC_COMPRESS_FORMAT:
+        {
+            Qcow2CompressFormatExt compress_ext;
+            Error *local_err = NULL;
+            if (ext.len != sizeof(compress_ext)) {
+                error_setg(errp, "ERROR: ext_compress_format: len=%"
+                           PRIu32 " invalid (!=%zu)", ext.len,
+                           sizeof(compress_ext));
+                return 2;
+            }
+            ret = bdrv_pread(bs->file, offset, &compress_ext,
+                             ext.len);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "ERROR: ext_compress_fromat:"
+                                 " Could not read extension");
+                return 3;
+            }
+
+            s->compress_format =
+                qapi_enum_parse(Qcow2CompressFormat_lookup,
+                                compress_ext.name, QCOW2_COMPRESS_FORMAT__MAX,
+                                -1, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return 4;
+            }
+
+            qcow2_compress_level_supported(s->compress_format,
+                                           compress_ext.level, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return 5;
+            }
+            s->compress_level = compress_ext.level;
+
+#ifdef DEBUG_EXT
+            printf("Qcow2: Got compress format %s with compress level %"
+                   PRIu8 "\n", Qcow2CompressFormat_lookup[s->compress_format],
+                   s->compress_level);
+#endif
+            break;
+        }
         case QCOW2_EXT_MAGIC_FEATURE_TABLE:
             if (p_feature_table != NULL) {
                 void* feature_table = g_malloc0(ext.len + 2 * sizeof(Qcow2Feature));
@@ -1374,6 +1428,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->cluster_cache_offset = -1;
     s->flags = flags;
+    s->compress_format = -1;
 
     ret = qcow2_refcount_init(bs);
     if (ret != 0) {
@@ -2292,6 +2347,25 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Compress Format header extension */
+    if (s->compress_format >= 0) {
+        Qcow2CompressFormatExt ext;
+        assert(s->compress_format < QCOW2_COMPRESS_FORMAT__MAX);
+        strncpy((char *) &ext.name,
+                Qcow2CompressFormat_lookup[s->compress_format],
+                sizeof(ext.name));
+        ext.level = s->compress_level;
+        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_COMPRESS_FORMAT,
+                             &ext, sizeof(ext),
+                             buflen);
+        if (ret < 0) {
+            goto fail;
+        }
+        buf += ret;
+        buflen -= ret;
+        header->incompatible_features |= cpu_to_be64(QCOW2_INCOMPAT_COMPRESS);
+    }
+
     /* Feature table */
     if (s->qcow_version >= 3) {
         Qcow2Feature features[] = {
@@ -2306,6 +2380,11 @@ int qcow2_update_header(BlockDriverState *bs)
                 .name = "corrupt bit",
             },
             {
+                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
+                .bit  = QCOW2_INCOMPAT_COMPRESS_BITNR,
+                .name = "compress format bit",
+            },
+            {
                 .type = QCOW2_FEAT_TYPE_COMPATIBLE,
                 .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
                 .name = "lazy refcounts",
@@ -2827,6 +2906,12 @@ static int qcow2_create2(const char *filename, int64_t total_size,
         abort();
     }
 
+    if (compress) {
+        BDRVQcow2State *s = blk_bs(blk)->opaque;
+        s->compress_format = compress->format;
+        s->compress_level = compress->level;
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     if (ret < 0) {
@@ -3002,11 +3087,10 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         visit_free(v);
         QDECREF(compressopts);
         QDECREF(options);
-        if (compress.format == QCOW2_COMPRESS_FORMAT_ZLIB &&
-            compress.level > 9) {
-            error_setg(errp, "Compress level %" PRIu8 " is not supported for"
-                       " format '%s'", compress.level,
-                       Qcow2CompressFormat_lookup[compress.format]);
+        qcow2_compress_level_supported(compress.format, compress.level,
+                                       &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
             ret = -EINVAL;
             goto finish;
         }
diff --git a/block/qcow2.h b/block/qcow2.h
index 96a8d43..c48d29e 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -188,13 +188,16 @@ enum {
 
 /* Incompatible feature bits */
 enum {
-    QCOW2_INCOMPAT_DIRTY_BITNR   = 0,
-    QCOW2_INCOMPAT_CORRUPT_BITNR = 1,
-    QCOW2_INCOMPAT_DIRTY         = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
-    QCOW2_INCOMPAT_CORRUPT       = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
+    QCOW2_INCOMPAT_DIRTY_BITNR    = 0,
+    QCOW2_INCOMPAT_CORRUPT_BITNR  = 1,
+    QCOW2_INCOMPAT_COMPRESS_BITNR = 2,
+    QCOW2_INCOMPAT_DIRTY          = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
+    QCOW2_INCOMPAT_CORRUPT        = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
+    QCOW2_INCOMPAT_COMPRESS       = 1 << QCOW2_INCOMPAT_COMPRESS_BITNR,
 
     QCOW2_INCOMPAT_MASK          = QCOW2_INCOMPAT_DIRTY
-                                 | QCOW2_INCOMPAT_CORRUPT,
+                                 | QCOW2_INCOMPAT_CORRUPT
+                                 | QCOW2_INCOMPAT_COMPRESS,
 };
 
 /* Compatible feature bits */
@@ -228,6 +231,11 @@ typedef struct Qcow2Feature {
     char    name[46];
 } QEMU_PACKED Qcow2Feature;
 
+typedef struct Qcow2CompressFormatExt {
+    char name[16];
+    uint8_t level;
+} QEMU_PACKED Qcow2CompressFormatExt;
+
 typedef struct Qcow2DiscardRegion {
     BlockDriverState *bs;
     uint64_t offset;
@@ -304,6 +312,9 @@ typedef struct BDRVQcow2State {
     int refcount_bits;
     uint64_t refcount_max;
 
+    int compress_format;
+    uint8_t compress_level;
+
     Qcow2GetRefcountFunc *get_refcount;
     Qcow2SetRefcountFunc *set_refcount;
 
-- 
1.9.1
