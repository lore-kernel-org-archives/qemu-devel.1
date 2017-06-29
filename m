Received: from eggs.gnu.org ([2001:4830:134:3::10]:51786)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dQX8h-00074z-8Z
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dQX8d-000848-PG
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:35 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:34450 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dQX8d-00081f-EV
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:31 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 29 Jun 2017 12:57:08 +0200
Message-Id: <1498733831-15254-6-git-send-email-pl@kamp.de>
In-Reply-To: <1498733831-15254-1-git-send-email-pl@kamp.de>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V2 5/8] block/qcow2: read and write the
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
 block/qcow2.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++--------
 block/qcow2.h |  23 +++++++++++---
 2 files changed, 104 insertions(+), 19 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 308121a..39a8afc 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -63,6 +63,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_END 0
 #define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
 #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
+#define  QCOW2_EXT_MAGIC_COMPRESS_FORMAT 0xC03183A3
 
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
@@ -76,6 +77,26 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
         return 0;
 }
 
+static int qcow2_compress_format_from_name(char *fmt)
+{
+    if (!fmt || !fmt[0]) {
+        return QCOW2_COMPRESS_ZLIB_COMPAT;
+    } else if (g_str_equal(fmt, "zlib")) {
+        return QCOW2_COMPRESS_ZLIB;
+    } else {
+        return -EINVAL;
+    }
+}
+
+static int qcow2_compress_level_supported(int id, uint64_t level)
+{
+    if ((id == QCOW2_COMPRESS_ZLIB_COMPAT && level > 0) ||
+        (id == QCOW2_COMPRESS_ZLIB && level > 9) ||
+        level > 0xff) {
+        return -EINVAL;
+    }
+    return 0;
+}
 
 /* 
  * read qcow2 extension and fill bs
@@ -148,6 +169,43 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
 #endif
             break;
 
+        case QCOW2_EXT_MAGIC_COMPRESS_FORMAT:
+            if (ext.len != sizeof(s->compress_format)) {
+                error_setg(errp, "ERROR: ext_compress_format: len=%"
+                           PRIu32 " invalid (!=%zu)", ext.len,
+                           sizeof(s->compress_format));
+                return 2;
+            }
+            ret = bdrv_pread(bs->file, offset, &s->compress_format,
+                             ext.len);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "ERROR: ext_compress_fromat:"
+                                 " Could not read extension");
+                return 3;
+            }
+            s->compress_format_id =
+                qcow2_compress_format_from_name(s->compress_format.name);
+            if (s->compress_format_id < 0) {
+                error_setg(errp, "ERROR: compression algorithm '%s' is "
+                           " unsupported", s->compress_format.name);
+                return 4;
+            }
+            if (qcow2_compress_level_supported(s->compress_format_id,
+                                               s->compress_format.level) < 0) {
+                error_setg(errp, "ERROR: compress level %" PRIu8 " is not"
+                           " supported for format '%s'",
+                           s->compress_format.level, s->compress_format.name);
+                return 5;
+            }
+
+#ifdef DEBUG_EXT
+            printf("Qcow2: Got compress format %s with compress level %"
+                   PRIu8 "\n", s->compress_format.name,
+                   s->compress_format.level);
+#endif
+            break;
+
+
         case QCOW2_EXT_MAGIC_FEATURE_TABLE:
             if (p_feature_table != NULL) {
                 void* feature_table = g_malloc0(ext.len + 2 * sizeof(Qcow2Feature));
@@ -1981,6 +2039,20 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Compress Format header extension */
+    if (s->compress_format.name[0]) {
+        assert(!s->compress_format.extra_data_size);
+        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_COMPRESS_FORMAT,
+                             &s->compress_format, sizeof(s->compress_format),
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
@@ -1995,6 +2067,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -2333,6 +2410,13 @@ static int qcow2_create2(const char *filename, int64_t total_size,
         abort();
     }
 
+    if (compress_format_name[0]) {
+        BDRVQcow2State *s = blk_bs(blk)->opaque;
+        memcpy(s->compress_format.name, compress_format_name,
+               strlen(compress_format_name));
+        s->compress_format.level = compress_level;
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     if (ret < 0) {
@@ -2391,17 +2475,6 @@ out:
     return ret;
 }
 
-static int qcow2_compress_format_from_name(char *fmt)
-{
-    if (!fmt || !fmt[0]) {
-        return QCOW2_COMPRESS_ZLIB_COMPAT;
-    } else if (g_str_equal(fmt, "zlib")) {
-        return QCOW2_COMPRESS_ZLIB;
-    } else {
-        return -EINVAL;
-    }
-}
-
 static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     char *backing_file = NULL;
@@ -2505,11 +2578,10 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         ret = -EINVAL;
         goto finish;
     }
-    if ((ret == QCOW2_COMPRESS_ZLIB && compress_level > 9) ||
-        compress_level > 0xff) {
+    ret = qcow2_compress_level_supported(ret, compress_level);
+    if (ret < 0) {
         error_setg(errp, "Compress level %" PRIu64 " is not supported for"
                    " format '%s'", compress_level, compress_format_name);
-        ret = -EINVAL;
         goto finish;
     }
 
diff --git a/block/qcow2.h b/block/qcow2.h
index d21da33..4ceaba1 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -187,13 +187,16 @@ enum {
 
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
@@ -219,6 +222,13 @@ typedef struct Qcow2Feature {
     char    name[46];
 } QEMU_PACKED Qcow2Feature;
 
+typedef struct Qcow2CompressFormatExt {
+    char name[16];
+    uint8_t level;
+    char res[3];
+    uint32_t extra_data_size;
+} QEMU_PACKED Qcow2CompressFormatExt;
+
 typedef struct Qcow2DiscardRegion {
     BlockDriverState *bs;
     uint64_t offset;
@@ -303,6 +313,9 @@ typedef struct BDRVQcow2State {
      * override) */
     char *image_backing_file;
     char *image_backing_format;
+
+    Qcow2CompressFormatExt compress_format;
+    int compress_format_id;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
-- 
1.9.1
