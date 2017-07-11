Received: from eggs.gnu.org ([2001:4830:134:3::10]:46756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxm2-0001mw-JD
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dUxlu-00072C-MW
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 12:12:25 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Tue, 11 Jul 2017 18:07:54 +0200
Message-Id: <20170711160814.20941-66-mreitz@redhat.com>
In-Reply-To: <20170711160814.20941-1-mreitz@redhat.com>
References: <20170711160814.20941-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 65/85] qcow2: extract image creation option
 parsing
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

From: Stefan Hajnoczi <stefanha@redhat.com>

The image creation options parsed by qcow2_create() are also needed to
implement .bdrv_measure().  Extract the parsing code, including input
validation.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Message-id: 20170705125738.8777-6-stefanha@redhat.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 109 +++++++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 73 insertions(+), 36 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index eb57013..db8d81f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2612,25 +2612,74 @@ static int64_t qcow2_calc_prealloc_size(int64_t total_size,
     return meta_size + aligned_total_size;
 }
 
-static int qcow2_create2(const char *filename, int64_t total_size,
-                         const char *backing_file, const char *backing_format,
-                         int flags, size_t cluster_size, PreallocMode prealloc,
-                         QemuOpts *opts, int version, int refcount_order,
-                         const char *encryptfmt, Error **errp)
+static size_t qcow2_opt_get_cluster_size_del(QemuOpts *opts, Error **errp)
 {
+    size_t cluster_size;
     int cluster_bits;
-    QDict *options;
 
-    /* Calculate cluster_bits */
+    cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
+                                         DEFAULT_CLUSTER_SIZE);
     cluster_bits = ctz32(cluster_size);
     if (cluster_bits < MIN_CLUSTER_BITS || cluster_bits > MAX_CLUSTER_BITS ||
         (1 << cluster_bits) != cluster_size)
     {
         error_setg(errp, "Cluster size must be a power of two between %d and "
                    "%dk", 1 << MIN_CLUSTER_BITS, 1 << (MAX_CLUSTER_BITS - 10));
-        return -EINVAL;
+        return 0;
+    }
+    return cluster_size;
+}
+
+static int qcow2_opt_get_version_del(QemuOpts *opts, Error **errp)
+{
+    char *buf;
+    int ret;
+
+    buf = qemu_opt_get_del(opts, BLOCK_OPT_COMPAT_LEVEL);
+    if (!buf) {
+        ret = 3; /* default */
+    } else if (!strcmp(buf, "0.10")) {
+        ret = 2;
+    } else if (!strcmp(buf, "1.1")) {
+        ret = 3;
+    } else {
+        error_setg(errp, "Invalid compatibility level: '%s'", buf);
+        ret = -EINVAL;
+    }
+    g_free(buf);
+    return ret;
+}
+
+static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
+                                                Error **errp)
+{
+    uint64_t refcount_bits;
+
+    refcount_bits = qemu_opt_get_number_del(opts, BLOCK_OPT_REFCOUNT_BITS, 16);
+    if (refcount_bits > 64 || !is_power_of_2(refcount_bits)) {
+        error_setg(errp, "Refcount width must be a power of two and may not "
+                   "exceed 64 bits");
+        return 0;
+    }
+
+    if (version < 3 && refcount_bits != 16) {
+        error_setg(errp, "Different refcount widths than 16 bits require "
+                   "compatibility level 1.1 or above (use compat=1.1 or "
+                   "greater)");
+        return 0;
     }
 
+    return refcount_bits;
+}
+
+static int qcow2_create2(const char *filename, int64_t total_size,
+                         const char *backing_file, const char *backing_format,
+                         int flags, size_t cluster_size, PreallocMode prealloc,
+                         QemuOpts *opts, int version, int refcount_order,
+                         const char *encryptfmt, Error **errp)
+{
+    QDict *options;
+
     /*
      * Open the image file and write a minimal qcow2 header.
      *
@@ -2679,7 +2728,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
     *header = (QCowHeader) {
         .magic                      = cpu_to_be32(QCOW_MAGIC),
         .version                    = cpu_to_be32(version),
-        .cluster_bits               = cpu_to_be32(cluster_bits),
+        .cluster_bits               = cpu_to_be32(ctz32(cluster_size)),
         .size                       = cpu_to_be64(0),
         .l1_table_offset            = cpu_to_be64(0),
         .l1_size                    = cpu_to_be32(0),
@@ -2826,8 +2875,8 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     int flags = 0;
     size_t cluster_size = DEFAULT_CLUSTER_SIZE;
     PreallocMode prealloc;
-    int version = 3;
-    uint64_t refcount_bits = 16;
+    int version;
+    uint64_t refcount_bits;
     int refcount_order;
     const char *encryptfmt = NULL;
     Error *local_err = NULL;
@@ -2849,8 +2898,12 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
         encryptfmt = "aes";
     }
-    cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
-                                         DEFAULT_CLUSTER_SIZE);
+    cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
+        ret = -EINVAL;
+        goto finish;
+    }
     buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
     prealloc = qapi_enum_parse(PreallocMode_lookup, buf,
                                PREALLOC_MODE__MAX, PREALLOC_MODE_OFF,
@@ -2860,16 +2913,10 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         ret = -EINVAL;
         goto finish;
     }
-    g_free(buf);
-    buf = qemu_opt_get_del(opts, BLOCK_OPT_COMPAT_LEVEL);
-    if (!buf) {
-        /* keep the default */
-    } else if (!strcmp(buf, "0.10")) {
-        version = 2;
-    } else if (!strcmp(buf, "1.1")) {
-        version = 3;
-    } else {
-        error_setg(errp, "Invalid compatibility level: '%s'", buf);
+
+    version = qcow2_opt_get_version_del(opts, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         ret = -EINVAL;
         goto finish;
     }
@@ -2892,19 +2939,9 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         goto finish;
     }
 
-    refcount_bits = qemu_opt_get_number_del(opts, BLOCK_OPT_REFCOUNT_BITS,
-                                            refcount_bits);
-    if (refcount_bits > 64 || !is_power_of_2(refcount_bits)) {
-        error_setg(errp, "Refcount width must be a power of two and may not "
-                   "exceed 64 bits");
-        ret = -EINVAL;
-        goto finish;
-    }
-
-    if (version < 3 && refcount_bits != 16) {
-        error_setg(errp, "Different refcount widths than 16 bits require "
-                   "compatibility level 1.1 or above (use compat=1.1 or "
-                   "greater)");
+    refcount_bits = qcow2_opt_get_refcount_bits_del(opts, version, &local_err);
+    if (local_err) {
+        error_propagate(errp, local_err);
         ret = -EINVAL;
         goto finish;
     }
-- 
2.9.4
