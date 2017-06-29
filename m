Received: from eggs.gnu.org ([2001:4830:134:3::10]:51656)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dQX8d-00071z-KL
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dQX8a-000803-K0
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:30 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:36025 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dQX8a-0007vc-AY
	for qemu-devel@nongnu.org; Thu, 29 Jun 2017 06:57:28 -0400
From: Peter Lieven <pl@kamp.de>
Date: Thu, 29 Jun 2017 12:57:06 +0200
Message-Id: <1498733831-15254-4-git-send-email-pl@kamp.de>
In-Reply-To: <1498733831-15254-1-git-send-email-pl@kamp.de>
References: <1498733831-15254-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V2 3/8] block/qcow2: parse compress create
 options
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

this adds parsing and validation for the compress create
options. They are only validated but not yet used.

Signed-off-by: Peter Lieven <pl@kamp.de>
---
 block/qcow2.c             | 56 +++++++++++++++++++++++++++++++++++++++++++++--
 block/qcow2.h             |  9 ++++++++
 include/block/block_int.h |  2 ++
 3 files changed, 65 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 2f94f03..308121a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2144,7 +2144,8 @@ static int qcow2_create2(const char *filename, int64_t total_size,
                          const char *backing_file, const char *backing_format,
                          int flags, size_t cluster_size, PreallocMode prealloc,
                          QemuOpts *opts, int version, int refcount_order,
-                         Error **errp)
+                         const char *compress_format_name,
+                         uint8_t compress_level, Error **errp)
 {
     int cluster_bits;
     QDict *options;
@@ -2390,11 +2391,24 @@ out:
     return ret;
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
 static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 {
     char *backing_file = NULL;
     char *backing_fmt = NULL;
     char *buf = NULL;
+    char *compress_format_name = NULL;
+    uint64_t compress_level = 0;
     uint64_t size = 0;
     int flags = 0;
     size_t cluster_size = DEFAULT_CLUSTER_SIZE;
@@ -2475,15 +2489,40 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 
     refcount_order = ctz32(refcount_bits);
 
+    compress_format_name = qemu_opt_get_del(opts,
+                                            BLOCK_OPT_COMPRESS_FORMAT);
+    ret = qcow2_compress_format_from_name(compress_format_name);
+    if (ret < 0) {
+        error_setg(errp, "Compress format '%s' is not supported",
+                   compress_format_name);
+        goto finish;
+    }
+    compress_level = qemu_opt_get_number_del(opts, BLOCK_OPT_COMPRESS_LEVEL,
+                                             compress_level);
+    if (ret == QCOW2_COMPRESS_ZLIB_COMPAT && compress_level > 0) {
+        error_setg(errp, "Compress level can only be defined in conjunction"
+                   " with compress format");
+        ret = -EINVAL;
+        goto finish;
+    }
+    if ((ret == QCOW2_COMPRESS_ZLIB && compress_level > 9) ||
+        compress_level > 0xff) {
+        error_setg(errp, "Compress level %" PRIu64 " is not supported for"
+                   " format '%s'", compress_level, compress_format_name);
+        ret = -EINVAL;
+        goto finish;
+    }
+
     ret = qcow2_create2(filename, size, backing_file, backing_fmt, flags,
                         cluster_size, prealloc, opts, version, refcount_order,
-                        &local_err);
+                        compress_format_name, compress_level, &local_err);
     error_propagate(errp, local_err);
 
 finish:
     g_free(backing_file);
     g_free(backing_fmt);
     g_free(buf);
+    g_free(compress_format_name);
     return ret;
 }
 
@@ -3458,6 +3497,19 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Width of a reference count entry in bits",
             .def_value_str = "16"
         },
+        {
+            .name = BLOCK_OPT_COMPRESS_FORMAT,
+            .type = QEMU_OPT_STRING,
+            .help = "Compress format used for compressed clusters (zlib)",
+            .def_value_str = ""
+        },
+        {
+            .name = BLOCK_OPT_COMPRESS_LEVEL,
+            .type = QEMU_OPT_NUMBER,
+            .help = "Compress level used for compressed clusters (0 = default,"
+                    " 1=fastest, x=best; x varies depending on compress.format)",
+            .def_value_str = "0"
+        },
         { /* end of list */ }
     }
 };
diff --git a/block/qcow2.h b/block/qcow2.h
index 87b15eb..d21da33 100644
--- a/block/qcow2.h
+++ b/block/qcow2.h
@@ -171,6 +171,15 @@ typedef struct Qcow2UnknownHeaderExtension {
 } Qcow2UnknownHeaderExtension;
 
 enum {
+    /* QCOW2_COMPRESS_ZLIB_COMPAT specifies to use the old standard
+     * zlib compression with a smaller window size that is compatible with
+     * old QEMU versions. This compression is used if no compression format
+     * is specified at create time */
+    QCOW2_COMPRESS_ZLIB_COMPAT = 0,
+    QCOW2_COMPRESS_ZLIB        = 1,
+};
+
+enum {
     QCOW2_FEAT_TYPE_INCOMPATIBLE    = 0,
     QCOW2_FEAT_TYPE_COMPATIBLE      = 1,
     QCOW2_FEAT_TYPE_AUTOCLEAR       = 2,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 15fa602..49811b0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -57,6 +57,8 @@
 #define BLOCK_OPT_NOCOW             "nocow"
 #define BLOCK_OPT_OBJECT_SIZE       "object_size"
 #define BLOCK_OPT_REFCOUNT_BITS     "refcount_bits"
+#define BLOCK_OPT_COMPRESS_FORMAT   "compress.format"
+#define BLOCK_OPT_COMPRESS_LEVEL    "compress.level"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
-- 
1.9.1
