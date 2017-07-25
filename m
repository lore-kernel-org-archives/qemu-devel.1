Received: from eggs.gnu.org ([2001:4830:134:3::10]:36594)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1da12E-00021B-6Z
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:42:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1da12C-00011e-Ui
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:42:06 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:54360 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1da12C-00010i-LT
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:42:04 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 25 Jul 2017 16:41:34 +0200
Message-Id: <1500993699-19299-6-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-1-git-send-email-pl@kamp.de>
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V5 05/10] block/qcow2: read and write the
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
 block/qcow2.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 block/qcow2.h | 21 ++++++++++----
 2 files changed, 108 insertions(+), 5 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index a5270a6..7fd52e1 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -70,6 +70,7 @@ typedef struct {
 #define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
 #define  QCOW2_EXT_MAGIC_CRYPTO_HEADER 0x0537be77
 #define  QCOW2_EXT_MAGIC_BITMAPS 0x23852875
+#define  QCOW2_EXT_MAGIC_COMPRESS_FORMAT 0xC03183A3
 
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
@@ -269,6 +270,57 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
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
+            s->compress.format =
+                qapi_enum_parse(Qcow2CompressFormat_lookup,
+                                compress_ext.name, QCOW2_COMPRESS_FORMAT__MAX,
+                                -1, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return 4;
+            }
+
+            if (s->compress.format == QCOW2_COMPRESS_FORMAT_DEFLATE) {
+                s->compress.u.deflate.has_level = true;
+                s->compress.u.deflate.level = compress_ext.level;
+                s->compress.u.deflate.has_window_size = true;
+                s->compress.u.deflate.window_size = compress_ext.window_size;
+            }
+
+            qcow2_check_compress_settings(&s->compress, &local_err);
+            if (local_err) {
+                error_propagate(errp, local_err);
+                return 5;
+            }
+
+#ifdef DEBUG_EXT
+            if (s->compress.format == QCOW2_COMPRESS_FORMAT_DEFLATE) {
+                printf("Qcow2: Got compress format %s with level %" PRIu8
+                       " window_size %" PRIu8 "\n",
+                       Qcow2CompressFormat_lookup[s->compress.format],
+                       s->compress.u.deflate.level,
+                       s->compress.u.deflate.window_size);
+            }
+#endif
+            break;
+        }
         case QCOW2_EXT_MAGIC_FEATURE_TABLE:
             if (p_feature_table != NULL) {
                 void* feature_table = g_malloc0(ext.len + 2 * sizeof(Qcow2Feature));
@@ -1403,6 +1455,12 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
     s->cluster_cache_offset = -1;
     s->flags = flags;
 
+    s->compress.format = QCOW2_COMPRESS_FORMAT_DEFLATE;
+    s->compress.u.deflate.has_level = true;
+    s->compress.u.deflate.level = 0;
+    s->compress.u.deflate.has_window_size = true;
+    s->compress.u.deflate.window_size = 12;
+
     ret = qcow2_refcount_init(bs);
     if (ret != 0) {
         error_setg_errno(errp, -ret, "Could not initialize refcount handling");
@@ -2320,6 +2378,30 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Compress Format header extension */
+    if (s->compress.format != QCOW2_COMPRESS_FORMAT_DEFLATE ||
+        s->compress.u.deflate.level != 0 ||
+        s->compress.u.deflate.window_size != 12) {
+        Qcow2CompressFormatExt ext = {};
+        assert(s->compress.format < QCOW2_COMPRESS_FORMAT__MAX);
+        strncpy((char *) &ext.name,
+                Qcow2CompressFormat_lookup[s->compress.format],
+                sizeof(ext.name));
+        if (s->compress.format == QCOW2_COMPRESS_FORMAT_DEFLATE) {
+            ext.level = s->compress.u.deflate.level;
+            ext.window_size = s->compress.u.deflate.window_size;
+        }
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
@@ -2334,6 +2416,11 @@ int qcow2_update_header(BlockDriverState *bs)
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
@@ -2855,6 +2942,11 @@ static int qcow2_create2(const char *filename, int64_t total_size,
         abort();
     }
 
+    if (compress) {
+        BDRVQcow2State *s = blk_bs(blk)->opaque;
+        memcpy(&s->compress, compress, sizeof(Qcow2Compress));
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     if (ret < 0) {
diff --git a/block/qcow2.h b/block/qcow2.h
index 96a8d43..abd35dd 100644
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
@@ -228,6 +231,12 @@ typedef struct Qcow2Feature {
     char    name[46];
 } QEMU_PACKED Qcow2Feature;
 
+typedef struct Qcow2CompressFormatExt {
+    char name[14];
+    uint8_t level;
+    uint8_t window_size;
+} QEMU_PACKED Qcow2CompressFormatExt;
+
 typedef struct Qcow2DiscardRegion {
     BlockDriverState *bs;
     uint64_t offset;
@@ -307,6 +316,8 @@ typedef struct BDRVQcow2State {
     Qcow2GetRefcountFunc *get_refcount;
     Qcow2SetRefcountFunc *set_refcount;
 
+    Qcow2Compress compress;
+
     bool discard_passthrough[QCOW2_DISCARD_MAX];
 
     int overlap_check; /* bitmask of Qcow2MetadataOverlap values */
-- 
1.9.1
