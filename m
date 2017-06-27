Received: from eggs.gnu.org ([2001:4830:134:3::10]:42454)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dPphQ-00057W-A3
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dPphN-0005H5-Rw
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:32 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:47924 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dPphN-0005FA-IR
	for qemu-devel@nongnu.org; Tue, 27 Jun 2017 08:34:29 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 27 Jun 2017 14:34:07 +0200
Message-Id: <1498566850-7934-2-git-send-email-pl@kamp.de>
In-Reply-To: <1498566850-7934-1-git-send-email-pl@kamp.de>
References: <1498566850-7934-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH 1/4] block/qcow2: add compression_algorithm
 create option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, lersek@redhat.com, den@openvz.org, mreitz@redhat.com, eblake@redhat.com, Peter Lieven <pl@kamp.de>

this patch adds a new compression_algorithm option when creating qcow2 images.
The current default for the compresison algorithm is zlib and zlib will be
used when this option is omitted (like before).

If the option is specified e.g. with:

 qemu-img create -f qcow2 -o compression_algorithm=zlib image.qcow2 1G

then a new compression algorithm header extension is added and an incompatible
feature bit is set. This means that if the header is present it must be parsed
by Qemu on qcow2_open and it must be validated if the specified compression
algorithm is supported by the current build of Qemu.

This means if the compression_algorithm option is specified Qemu prior to this
commit will not be able to open the created image.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/qcow2.c             | 93 ++++++++++++++++++++++++++++++++++++++++++++---
 block/qcow2.h             | 20 +++++++---
 docs/interop/qcow2.txt    |  8 +++-
 include/block/block_int.h | 35 +++++++++---------
 qemu-img.texi             | 10 +++++
 5 files changed, 138 insertions(+), 28 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2f94f03..893b145 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -60,9 +60,11 @@ typedef struct {
     uint32_t len;
 } QEMU_PACKED QCowExtension;
 
-#define  QCOW2_EXT_MAGIC_END 0
-#define  QCOW2_EXT_MAGIC_BACKING_FORMAT 0xE2792ACA
-#define  QCOW2_EXT_MAGIC_FEATURE_TABLE 0x6803f857
+#define QCOW2_EXT_MAGIC_END                   0
+#define QCOW2_EXT_MAGIC_BACKING_FORMAT        0xE2792ACA
+#define QCOW2_EXT_MAGIC_FEATURE_TABLE         0x6803f857
+#define QCOW2_EXT_MAGIC_COMPRESSION_ALGORITHM 0xc0318300
+/* 0xc03183xx reserved for further use of compression algorithm parameters */
 
 static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
 {
@@ -76,6 +78,15 @@ static int qcow2_probe(const uint8_t *buf, int buf_size, const char *filename)
         return 0;
 }
 
+static uint32_t is_compression_algorithm_supported(char *algorithm)
+{
+    if (!algorithm[0] || !strcmp(algorithm, "zlib")) {
+        /* no algorithm means the old default of zlib compression
+         * with 12 window bits */
+        return QCOW2_COMPRESSION_ZLIB;
+    }
+    return 0;
+}
 
 /* 
  * read qcow2 extension and fill bs
@@ -148,6 +159,34 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
 #endif
             break;
 
+        case QCOW2_EXT_MAGIC_COMPRESSION_ALGORITHM:
+            if (ext.len >= sizeof(s->compression_algorithm)) {
+                error_setg(errp, "ERROR: ext_compression_algorithm: len=%"
+                           PRIu32 " too large (>=%zu)", ext.len,
+                           sizeof(s->compression_algorithm));
+                return 2;
+            }
+            ret = bdrv_pread(bs->file, offset, s->compression_algorithm,
+                             ext.len);
+            if (ret < 0) {
+                error_setg_errno(errp, -ret, "ERROR: ext_compression_algorithm:"
+                                 " Could not read algorithm name");
+                return 3;
+            }
+            s->compression_algorithm[ext.len] = '\0';
+            s->compression_algorithm_id =
+                is_compression_algorithm_supported(s->compression_algorithm);
+            if (!s->compression_algorithm_id) {
+                error_setg(errp, "ERROR: compression algorithm '%s' is "
+                           " unsupported", s->compression_algorithm);
+                return 4;
+            }
+#ifdef DEBUG_EXT
+            printf("Qcow2: Got compression algorithm %s\n",
+                   s->compression_algorithm);
+#endif
+            break;
+
         case QCOW2_EXT_MAGIC_FEATURE_TABLE:
             if (p_feature_table != NULL) {
                 void* feature_table = g_malloc0(ext.len + 2 * sizeof(Qcow2Feature));
@@ -1104,6 +1143,7 @@ static int qcow2_do_open(BlockDriverState *bs, QDict *options, int flags,
 
     s->cluster_cache_offset = -1;
     s->flags = flags;
+    s->compression_algorithm_id = QCOW2_COMPRESSION_ZLIB;
 
     ret = qcow2_refcount_init(bs);
     if (ret != 0) {
@@ -1981,6 +2021,21 @@ int qcow2_update_header(BlockDriverState *bs)
         buflen -= ret;
     }
 
+    /* Compression Algorithm header extension */
+    if (s->compression_algorithm[0]) {
+        ret = header_ext_add(buf, QCOW2_EXT_MAGIC_COMPRESSION_ALGORITHM,
+                             s->compression_algorithm,
+                             strlen(s->compression_algorithm),
+                             buflen);
+        if (ret < 0) {
+            goto fail;
+        }
+        buf += ret;
+        buflen -= ret;
+        header->incompatible_features |=
+            cpu_to_be64(QCOW2_INCOMPAT_COMPRESSION);
+    }
+
     /* Feature table */
     if (s->qcow_version >= 3) {
         Qcow2Feature features[] = {
@@ -1995,6 +2050,11 @@ int qcow2_update_header(BlockDriverState *bs)
                 .name = "corrupt bit",
             },
             {
+                .type = QCOW2_FEAT_TYPE_INCOMPATIBLE,
+                .bit  = QCOW2_INCOMPAT_COMPRESSION_BITNR,
+                .name = "compression algorithm",
+            },
+            {
                 .type = QCOW2_FEAT_TYPE_COMPATIBLE,
                 .bit  = QCOW2_COMPAT_LAZY_REFCOUNTS_BITNR,
                 .name = "lazy refcounts",
@@ -2144,7 +2204,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
                          const char *backing_file, const char *backing_format,
                          int flags, size_t cluster_size, PreallocMode prealloc,
                          QemuOpts *opts, int version, int refcount_order,
-                         Error **errp)
+                         char *compression_algorithm, Error **errp)
 {
     int cluster_bits;
     QDict *options;
@@ -2332,6 +2392,12 @@ static int qcow2_create2(const char *filename, int64_t total_size,
         abort();
     }
 
+    if (compression_algorithm[0]) {
+        BDRVQcow2State *s = blk_bs(blk)->opaque;
+        memcpy(s->compression_algorithm, compression_algorithm,
+               strlen(compression_algorithm));
+    }
+
     /* Create a full header (including things like feature table) */
     ret = qcow2_update_header(blk_bs(blk));
     if (ret < 0) {
@@ -2395,6 +2461,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     char *backing_file = NULL;
     char *backing_fmt = NULL;
     char *buf = NULL;
+    char *compression_algorithm = NULL;
     uint64_t size = 0;
     int flags = 0;
     size_t cluster_size = DEFAULT_CLUSTER_SIZE;
@@ -2475,15 +2542,25 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 
     refcount_order = ctz32(refcount_bits);
 
+    compression_algorithm = qemu_opt_get_del(opts,
+                                             BLOCK_OPT_COMPRESSION_ALGORITHM);
+    if (!is_compression_algorithm_supported(compression_algorithm)) {
+        error_setg(errp, "Compression algorithm '%s' is not supported",
+                   compression_algorithm);
+        ret = -EINVAL;
+        goto finish;
+    }
+
     ret = qcow2_create2(filename, size, backing_file, backing_fmt, flags,
                         cluster_size, prealloc, opts, version, refcount_order,
-                        &local_err);
+                        compression_algorithm, &local_err);
     error_propagate(errp, local_err);
 
 finish:
     g_free(backing_file);
     g_free(backing_fmt);
     g_free(buf);
+    g_free(compression_algorithm);
     return ret;
 }
 
@@ -3458,6 +3535,12 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Width of a reference count entry in bits",
             .def_value_str = "16"
         },
+        {
+            .name = BLOCK_OPT_COMPRESSION_ALGORITHM,
+            .type = QEMU_OPT_STRING,
+            .help = "Compression algorithm used for compressed clusters",
+            .def_value_str = ""
+        },
         { /* end of list */ }
     }
 };
diff --git a/block/qcow2.h b/block/qcow2.h
index 87b15eb..1c9ba06 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -171,6 +171,10 @@ typedef struct Qcow2UnknownHeaderExtension {
 } Qcow2UnknownHeaderExtension;
 
 enum {
+    QCOW2_COMPRESSION_ZLIB          = 0xC0318301,
+};
+
+enum {
     QCOW2_FEAT_TYPE_INCOMPATIBLE    = 0,
     QCOW2_FEAT_TYPE_COMPATIBLE      = 1,
     QCOW2_FEAT_TYPE_AUTOCLEAR       = 2,
@@ -178,13 +182,16 @@ enum {
 
 /* Incompatible feature bits */
 enum {
-    QCOW2_INCOMPAT_DIRTY_BITNR   = 0,
-    QCOW2_INCOMPAT_CORRUPT_BITNR = 1,
-    QCOW2_INCOMPAT_DIRTY         = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
-    QCOW2_INCOMPAT_CORRUPT       = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
+    QCOW2_INCOMPAT_DIRTY_BITNR        = 0,
+    QCOW2_INCOMPAT_CORRUPT_BITNR      = 1,
+    QCOW2_INCOMPAT_COMPRESSION_BITNR  = 2,
+    QCOW2_INCOMPAT_DIRTY              = 1 << QCOW2_INCOMPAT_DIRTY_BITNR,
+    QCOW2_INCOMPAT_CORRUPT            = 1 << QCOW2_INCOMPAT_CORRUPT_BITNR,
+    QCOW2_INCOMPAT_COMPRESSION        = 1 << QCOW2_INCOMPAT_COMPRESSION_BITNR,
 
     QCOW2_INCOMPAT_MASK          = QCOW2_INCOMPAT_DIRTY
-                                 | QCOW2_INCOMPAT_CORRUPT,
+                                 | QCOW2_INCOMPAT_CORRUPT
+                                 | QCOW2_INCOMPAT_COMPRESSION,
 };
 
 /* Compatible feature bits */
@@ -294,6 +301,9 @@ typedef struct BDRVQcow2State {
      * override) */
     char *image_backing_file;
     char *image_backing_format;
+
+    char compression_algorithm[16];
+    uint32_t compression_algorithm_id;
 } BDRVQcow2State;
 
 typedef struct Qcow2COWRegion {
diff --git a/docs/interop/qcow2.txt b/docs/interop/qcow2.txt
index 80cdfd0..1f165d6 100644
--- a/docs/interop/qcow2.txt
+++ b/docs/interop/qcow2.txt
@@ -85,7 +85,11 @@ in the description of a field.
                                 be written to (unless for regaining
                                 consistency).
 
-                    Bits 2-63:  Reserved (set to 0)
+                    Bit 2:      Compress algorithm bit.  If this bit is set then
+                                the compress algorithm extension must be parsed
+                                and checked for compatiblity.
+
+                    Bits 3-63:  Reserved (set to 0)
 
          80 -  87:  compatible_features
                     Bitmask of compatible features. An implementation can
@@ -135,6 +139,8 @@ be stored. Each extension has a structure like the following:
                         0xE2792ACA - Backing file format name
                         0x6803f857 - Feature name table
                         0x23852875 - Bitmaps extension
+                        0xC0318300 - Compression Algorithm
+                        0xC03183xx - Reserved for compression algorithm params
                         other      - Unknown header extension, can be safely
                                      ignored
 
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 15fa602..03a4b8f 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -40,23 +40,24 @@
 #define BLOCK_FLAG_ENCRYPT          1
 #define BLOCK_FLAG_LAZY_REFCOUNTS   8
 
-#define BLOCK_OPT_SIZE              "size"
-#define BLOCK_OPT_ENCRYPT           "encryption"
-#define BLOCK_OPT_COMPAT6           "compat6"
-#define BLOCK_OPT_HWVERSION         "hwversion"
-#define BLOCK_OPT_BACKING_FILE      "backing_file"
-#define BLOCK_OPT_BACKING_FMT       "backing_fmt"
-#define BLOCK_OPT_CLUSTER_SIZE      "cluster_size"
-#define BLOCK_OPT_TABLE_SIZE        "table_size"
-#define BLOCK_OPT_PREALLOC          "preallocation"
-#define BLOCK_OPT_SUBFMT            "subformat"
-#define BLOCK_OPT_COMPAT_LEVEL      "compat"
-#define BLOCK_OPT_LAZY_REFCOUNTS    "lazy_refcounts"
-#define BLOCK_OPT_ADAPTER_TYPE      "adapter_type"
-#define BLOCK_OPT_REDUNDANCY        "redundancy"
-#define BLOCK_OPT_NOCOW             "nocow"
-#define BLOCK_OPT_OBJECT_SIZE       "object_size"
-#define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
+#define BLOCK_OPT_SIZE                  "size"
+#define BLOCK_OPT_ENCRYPT               "encryption"
+#define BLOCK_OPT_COMPAT6               "compat6"
+#define BLOCK_OPT_HWVERSION             "hwversion"
+#define BLOCK_OPT_BACKING_FILE          "backing_file"
+#define BLOCK_OPT_BACKING_FMT           "backing_fmt"
+#define BLOCK_OPT_CLUSTER_SIZE          "cluster_size"
+#define BLOCK_OPT_TABLE_SIZE            "table_size"
+#define BLOCK_OPT_PREALLOC              "preallocation"
+#define BLOCK_OPT_SUBFMT                "subformat"
+#define BLOCK_OPT_COMPAT_LEVEL          "compat"
+#define BLOCK_OPT_LAZY_REFCOUNTS        "lazy_refcounts"
+#define BLOCK_OPT_ADAPTER_TYPE          "adapter_type"
+#define BLOCK_OPT_REDUNDANCY            "redundancy"
+#define BLOCK_OPT_NOCOW                 "nocow"
+#define BLOCK_OPT_OBJECT_SIZE           "object_size"
+#define BLOCK_OPT_REFCOUNT_BITS         "refcount_bits"
+#define BLOCK_OPT_COMPRESSION_ALGORITHM "compression_algorithm"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
diff --git a/qemu-img.texi b/qemu-img.texi
index 5b925ec..c0d1bec 100644
--- a/qemu-img.texi
+++ b/qemu-img.texi
@@ -621,6 +621,16 @@ file which is COW and has data blocks already, it couldn't be changed to NOCOW
 by setting @code{nocow=on}. One can issue @code{lsattr filename} to check if
 the NOCOW flag is set or not (Capital 'C' is NOCOW flag).
 
+@item compression_algorithm
+Defines which compression algorithm is should be used for compressed clusters.
+The following options are available if support for the respective libraries
+has been enabled at compile time:
+
+   zlib            Uses standard zlib compression (default)
+
+The compression algorithm can only be defined at image create time and cannot
+be changed later.
+
 @end table
 
 @item Other
-- 
1.9.1
