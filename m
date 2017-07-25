Received: from eggs.gnu.org ([2001:4830:134:3::10]:36336)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1da121-0001nA-FL
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1da11z-0000sC-73
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:53 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:33578 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1da11y-0000r2-TP
	for qemu-devel@nongnu.org; Tue, 25 Jul 2017 10:41:51 -0400
From: Peter Lieven <pl@kamp.de>
Date: Tue, 25 Jul 2017 16:41:32 +0200
Message-Id: <1500993699-19299-4-git-send-email-pl@kamp.de>
In-Reply-To: <1500993699-19299-1-git-send-email-pl@kamp.de>
References: <1500993699-19299-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V5 03/10] block/qcow2: parse compress create
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
 block/qcow2.c             | 86 +++++++++++++++++++++++++++++++++++++++++++++--
 include/block/block_int.h | 39 +++++++++++----------
 2 files changed, 105 insertions(+), 20 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 90efa44..a5270a6 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -31,6 +31,8 @@
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qbool.h"
 #include "qapi/util.h"
+#include "qapi-visit.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qapi/qmp/types.h"
 #include "qapi-event.h"
 #include "trace.h"
@@ -161,6 +163,34 @@ static ssize_t qcow2_crypto_hdr_write_func(QCryptoBlock *block, size_t offset,
     return ret;
 }
 
+static void
+qcow2_check_compress_settings(Qcow2Compress *compress, Error **errp)
+{
+    if (compress->format == QCOW2_COMPRESS_FORMAT_DEFLATE) {
+        if (!compress->u.deflate.has_level) {
+            compress->u.deflate.has_level = true;
+            compress->u.deflate.level = 0;
+        }
+        if (compress->u.deflate.level > 9) {
+            error_setg(errp, "Compress level %" PRIu8 " is not supported for"
+                       " format '%s'", compress->u.deflate.level,
+                       Qcow2CompressFormat_lookup[compress->format]);
+            return;
+        }
+        if (!compress->u.deflate.has_window_size) {
+            compress->u.deflate.has_window_size = true;
+            compress->u.deflate.window_size = 15;
+        }
+        if (compress->u.deflate.window_size < 8 ||
+            compress->u.deflate.window_size > 15) {
+            error_setg(errp, "Compress window size %" PRIu8 " is not supported"
+                       " for format '%s'", compress->u.deflate.window_size,
+                       Qcow2CompressFormat_lookup[compress->format]);
+            return;
+        }
+    }
+}
+
 
 /* 
  * read qcow2 extension and fill bs
@@ -2706,7 +2736,8 @@ static int qcow2_create2(const char *filename, int64_t total_size,
                          const char *backing_file, const char *backing_format,
                          int flags, size_t cluster_size, PreallocMode prealloc,
                          QemuOpts *opts, int version, int refcount_order,
-                         const char *encryptfmt, Error **errp)
+                         const char *encryptfmt, Qcow2Compress *compress,
+                         Error **errp)
 {
     QDict *options;
 
@@ -2898,6 +2929,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     char *backing_file = NULL;
     char *backing_fmt = NULL;
     char *buf = NULL;
+    Qcow2Compress compress, *compress_ptr = NULL;
     uint64_t size = 0;
     int flags = 0;
     size_t cluster_size = DEFAULT_CLUSTER_SIZE;
@@ -2975,9 +3007,42 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 
     refcount_order = ctz32(refcount_bits);
 
+    if (qemu_opt_get(opts, BLOCK_OPT_COMPRESS_FORMAT) ||
+        qemu_opt_get(opts, BLOCK_OPT_COMPRESS_LEVEL) ||
+        qemu_opt_get(opts, BLOCK_OPT_COMPRESS_WINDOW_SIZE)) {
+        QDict *options, *compressopts = NULL;
+        Visitor *v;
+        options = qemu_opts_to_qdict(opts, NULL);
+        qdict_extract_subqdict(options, &compressopts, "compress.");
+        v = qobject_input_visitor_new_keyval(QOBJECT(compressopts));
+        visit_start_struct(v, NULL, NULL, 0, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            ret = -EINVAL;
+            goto finish;
+        }
+        visit_type_Qcow2Compress_members(v, &compress, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            ret = -EINVAL;
+            goto finish;
+        }
+        visit_end_struct(v, NULL);
+        visit_free(v);
+        QDECREF(compressopts);
+        QDECREF(options);
+        qcow2_check_compress_settings(&compress, &local_err);
+        if (local_err) {
+            error_propagate(errp, local_err);
+            ret = -EINVAL;
+            goto finish;
+        }
+        compress_ptr = &compress;
+    }
+
     ret = qcow2_create2(filename, size, backing_file, backing_fmt, flags,
                         cluster_size, prealloc, opts, version, refcount_order,
-                        encryptfmt, &local_err);
+                        encryptfmt, compress_ptr, &local_err);
     error_propagate(errp, local_err);
 
 finish:
@@ -4287,6 +4352,23 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Width of a reference count entry in bits",
             .def_value_str = "16"
         },
+        {
+            .name = BLOCK_OPT_COMPRESS_FORMAT,
+            .type = QEMU_OPT_STRING,
+            .help = "Compress format used for compressed clusters (deflate)",
+        },
+        {
+            .name = BLOCK_OPT_COMPRESS_LEVEL,
+            .type = QEMU_OPT_NUMBER,
+            .help = "Compress level used for compressed clusters (0 = default,"
+                    " further valid options for deflate: 1=fastest ... 9=best)",
+        },
+        {
+            .name = BLOCK_OPT_COMPRESS_WINDOW_SIZE,
+            .type = QEMU_OPT_NUMBER,
+            .help = "Compress windows size used for compression (valid for"
+                    " deflate compression with values from 8 to 15)",
+        },
         { /* end of list */ }
     }
 };
diff --git a/include/block/block_int.h b/include/block/block_int.h
index d4f4ea7..91428d8 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -39,24 +39,27 @@
 
 #define BLOCK_FLAG_LAZY_REFCOUNTS   8
 
-#define BLOCK_OPT_SIZE              "size"
-#define BLOCK_OPT_ENCRYPT           "encryption"
-#define BLOCK_OPT_ENCRYPT_FORMAT    "encrypt.format"
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
+#define BLOCK_OPT_SIZE                 "size"
+#define BLOCK_OPT_ENCRYPT              "encryption"
+#define BLOCK_OPT_ENCRYPT_FORMAT       "encrypt.format"
+#define BLOCK_OPT_COMPAT6              "compat6"
+#define BLOCK_OPT_HWVERSION            "hwversion"
+#define BLOCK_OPT_BACKING_FILE         "backing_file"
+#define BLOCK_OPT_BACKING_FMT          "backing_fmt"
+#define BLOCK_OPT_CLUSTER_SIZE         "cluster_size"
+#define BLOCK_OPT_TABLE_SIZE           "table_size"
+#define BLOCK_OPT_PREALLOC             "preallocation"
+#define BLOCK_OPT_SUBFMT               "subformat"
+#define BLOCK_OPT_COMPAT_LEVEL         "compat"
+#define BLOCK_OPT_LAZY_REFCOUNTS       "lazy_refcounts"
+#define BLOCK_OPT_ADAPTER_TYPE         "adapter_type"
+#define BLOCK_OPT_REDUNDANCY           "redundancy"
+#define BLOCK_OPT_NOCOW                "nocow"
+#define BLOCK_OPT_OBJECT_SIZE          "object_size"
+#define BLOCK_OPT_REFCOUNT_BITS        "refcount_bits"
+#define BLOCK_OPT_COMPRESS_FORMAT      "compress.format"
+#define BLOCK_OPT_COMPRESS_LEVEL       "compress.level"
+#define BLOCK_OPT_COMPRESS_WINDOW_SIZE "compress.window-size"
 
 #define BLOCK_PROBE_BUF_SIZE        512
 
-- 
1.9.1
