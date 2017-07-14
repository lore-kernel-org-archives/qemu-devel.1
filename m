Received: from eggs.gnu.org ([2001:4830:134:3::10]:38260)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <pl@kamp.de>)
	id 1dVxLU-0003fR-Qh
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pl@kamp.de>) id 1dVxLT-00081O-GA
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:12 -0400
Received: from mx-v6.kamp.de ([2a02:248:0:51::16]:36078 helo=mx01.kamp.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pl@kamp.de>) id 1dVxLT-00080B-6I
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:57:11 -0400
From: Peter Lieven <pl@kamp.de>
Date: Fri, 14 Jul 2017 11:56:39 +0200
Message-Id: <1500026205-15542-4-git-send-email-pl@kamp.de>
In-Reply-To: <1500026205-15542-1-git-send-email-pl@kamp.de>
References: <1500026205-15542-1-git-send-email-pl@kamp.de>
Subject: [Qemu-devel] [PATCH V3 3/9] block/qcow2: parse compress create
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
 block/qcow2.c             | 53 +++++++++++++++++++++++++++++++++++++++++++++--
 include/block/block_int.h |  2 ++
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index c144ea5..6bf4ea5 100644
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
@@ -2706,7 +2708,8 @@ static int qcow2_create2(const char *filename, int64_t total_size,
                          const char *backing_file, const char *backing_format,
                          int flags, size_t cluster_size, PreallocMode prealloc,
                          QemuOpts *opts, int version, int refcount_order,
-                         const char *encryptfmt, Error **errp)
+                         const char *encryptfmt, Qcow2Compress *compress,
+                         Error **errp)
 {
     QDict *options;
 
@@ -2898,6 +2901,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     char *backing_file = NULL;
     char *backing_fmt = NULL;
     char *buf = NULL;
+    Qcow2Compress compress, *compress_ptr = NULL;
     uint64_t size = 0;
     int flags = 0;
     size_t cluster_size = DEFAULT_CLUSTER_SIZE;
@@ -2975,9 +2979,43 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 
     refcount_order = ctz32(refcount_bits);
 
+    if (qemu_opt_get(opts, BLOCK_OPT_COMPRESS_FORMAT) ||
+        qemu_opt_get(opts, BLOCK_OPT_COMPRESS_LEVEL)) {
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
+        if (compress.format == QCOW2_COMPRESS_FORMAT_ZLIB &&
+            compress.level > 9) {
+            error_setg(errp, "Compress level %" PRIu8 " is not supported for"
+                       " format '%s'", compress.level,
+                       Qcow2CompressFormat_lookup[compress.format]);
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
@@ -4287,6 +4325,17 @@ static QemuOptsList qcow2_create_opts = {
             .help = "Width of a reference count entry in bits",
             .def_value_str = "16"
         },
+        {
+            .name = BLOCK_OPT_COMPRESS_FORMAT,
+            .type = QEMU_OPT_STRING,
+            .help = "Compress format used for compressed clusters (zlib)",
+        },
+        {
+            .name = BLOCK_OPT_COMPRESS_LEVEL,
+            .type = QEMU_OPT_NUMBER,
+            .help = "Compress level used for compressed clusters (0 = default,"
+                    " 1=fastest, x=best; x varies depending on compress.format)",
+        },
         { /* end of list */ }
     }
 };
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 669a279..eac61cd 100644
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
