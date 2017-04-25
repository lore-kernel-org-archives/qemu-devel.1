Received: from eggs.gnu.org ([2001:4830:134:3::10]:52315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d32Yz-0008AM-V2
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1d32Yv-00085K-0c
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 11:39:37 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 25 Apr 2017 16:38:47 +0100
Message-Id: <20170425153858.25660-8-berrange@redhat.com>
In-Reply-To: <20170425153858.25660-1-berrange@redhat.com>
References: <20170425153858.25660-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v6 07/18] block: deprecate "encryption=on" in
 favour of "encrypt.format=aes"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, "Daniel P. Berrange" <berrange@redhat.com>

Historically the qcow & qcow2 image formats supported a property
"encryption=on" to enable their built-in AES encryption. We'll
soon be supporting LUKS for qcow2, so need a more general purpose
way to enable encryption, with a choice of formats.

This introduces an "encrypt.format" option, which will later be
joined by a number of other "encrypt.XXX" options. The use of
a "encrypt." prefix instead of "encrypt-" is done to facilitate
mapping to a nested QAPI schema at later date.

e.g. the preferred syntax is now

  qemu-img create -f qcow2 -o encrypt.format=aes demo.qcow2

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/qcow.c               | 30 ++++++++++++++---
 block/qcow2.c              | 33 +++++++++++++++----
 include/block/block_int.h  |  2 +-
 qemu-img.c                 |  4 ++-
 tests/qemu-iotests/082.out | 81 ++++++++++++++++++++++++++++++----------------
 5 files changed, 110 insertions(+), 40 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index d6ce46c..e9b7861 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -803,10 +803,10 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
     uint8_t *tmp;
     int64_t total_size = 0;
     char *backing_file = NULL;
-    int flags = 0;
     Error *local_err = NULL;
     int ret;
     BlockBackend *qcow_blk;
+    const char *encryptfmt = NULL;
 
     /* Read out options */
     total_size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
@@ -818,8 +818,16 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
     }
 
     backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
-    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
-        flags |= BLOCK_FLAG_ENCRYPT;
+    encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
+    if (encryptfmt) {
+        if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
+            error_setg(errp, "Options " BLOCK_OPT_ENCRYPT " and "
+                       BLOCK_OPT_ENCRYPT_FORMAT " are mutually exclusive");
+            ret = -EINVAL;
+            goto cleanup;
+        }
+    } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
+        encryptfmt = "aes";
     }
 
     ret = bdrv_create_file(filename, opts, &local_err);
@@ -872,7 +880,13 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
     l1_size = (total_size + (1LL << shift) - 1) >> shift;
 
     header.l1_table_offset = cpu_to_be64(header_size);
-    if (flags & BLOCK_FLAG_ENCRYPT) {
+    if (encryptfmt) {
+        if (!g_str_equal(encryptfmt, "aes")) {
+            error_setg(errp, "Unknown encryption format '%s', expected 'aes'",
+                       encryptfmt);
+            ret = -EINVAL;
+            goto exit;
+        }
         header.crypt_method = cpu_to_be32(QCOW_CRYPT_AES);
     } else {
         header.crypt_method = cpu_to_be32(QCOW_CRYPT_NONE);
@@ -1046,9 +1060,15 @@ static QemuOptsList qcow_create_opts = {
         {
             .name = BLOCK_OPT_ENCRYPT,
             .type = QEMU_OPT_BOOL,
-            .help = "Encrypt the image",
+            .help = "Encrypt the image with format 'aes'. (Deprecated "
+                    "in favour of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",
             .def_value_str = "off"
         },
+        {
+            .name = BLOCK_OPT_ENCRYPT_FORMAT,
+            .type = QEMU_OPT_STRING,
+            .help = "Encrypt the image, format choices: 'aes'",
+        },
         { /* end of list */ }
     }
 };
diff --git a/block/qcow2.c b/block/qcow2.c
index 6a92d2e..98ca6ed 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2099,7 +2099,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
                          const char *backing_file, const char *backing_format,
                          int flags, size_t cluster_size, PreallocMode prealloc,
                          QemuOpts *opts, int version, int refcount_order,
-                         Error **errp)
+                         const char *encryptfmt, Error **errp)
 {
     int cluster_bits;
     QDict *options;
@@ -2227,7 +2227,13 @@ static int qcow2_create2(const char *filename, int64_t total_size,
         .header_length              = cpu_to_be32(sizeof(*header)),
     };
 
-    if (flags & BLOCK_FLAG_ENCRYPT) {
+    if (encryptfmt) {
+        if (!g_str_equal(encryptfmt, "aes")) {
+            error_setg(errp, "Unknown encryption format '%s', expected 'aes'",
+                       encryptfmt);
+            ret = -EINVAL;
+            goto out;
+        }
         header->crypt_method = cpu_to_be32(QCOW_CRYPT_AES);
     } else {
         header->crypt_method = cpu_to_be32(QCOW_CRYPT_NONE);
@@ -2356,6 +2362,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     int version = 3;
     uint64_t refcount_bits = 16;
     int refcount_order;
+    const char *encryptfmt = NULL;
     Error *local_err = NULL;
     int ret;
 
@@ -2364,8 +2371,16 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
                     BDRV_SECTOR_SIZE);
     backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
     backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
-    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
-        flags |= BLOCK_FLAG_ENCRYPT;
+    encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
+    if (encryptfmt) {
+        if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
+            error_setg(errp, "Options " BLOCK_OPT_ENCRYPT " and "
+                       BLOCK_OPT_ENCRYPT_FORMAT " are mutually exclusive");
+            ret = -EINVAL;
+            goto finish;
+        }
+    } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
+        encryptfmt = "aes";
     }
     cluster_size = qemu_opt_get_size_del(opts, BLOCK_OPT_CLUSTER_SIZE,
                                          DEFAULT_CLUSTER_SIZE);
@@ -2431,7 +2446,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 
     ret = qcow2_create2(filename, size, backing_file, backing_fmt, flags,
                         cluster_size, prealloc, opts, version, refcount_order,
-                        &local_err);
+                        encryptfmt, &local_err);
     error_propagate(errp, local_err);
 
 finish:
@@ -3370,10 +3385,16 @@ static QemuOptsList qcow2_create_opts = {
         {
             .name = BLOCK_OPT_ENCRYPT,
             .type = QEMU_OPT_BOOL,
-            .help = "Encrypt the image",
+            .help = "Encrypt the image with format 'aes'. (Deprecated "
+                    "in favour of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",
             .def_value_str = "off"
         },
         {
+            .name = BLOCK_OPT_ENCRYPT_FORMAT,
+            .type = QEMU_OPT_STRING,
+            .help = "Encrypt the image, format choices: 'aes'",
+        },
+        {
             .name = BLOCK_OPT_CLUSTER_SIZE,
             .type = QEMU_OPT_SIZE,
             .help = "qcow2 cluster size",
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 4f8cd29..4b2f8b0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -36,11 +36,11 @@
 #include "qemu/main-loop.h"
 #include "qemu/throttle.h"
 
-#define BLOCK_FLAG_ENCRYPT          1
 #define BLOCK_FLAG_LAZY_REFCOUNTS   8
 
 #define BLOCK_OPT_SIZE              "size"
 #define BLOCK_OPT_ENCRYPT           "encryption"
+#define BLOCK_OPT_ENCRYPT_FORMAT    "encrypt.format"
 #define BLOCK_OPT_COMPAT6           "compat6"
 #define BLOCK_OPT_HWVERSION         "hwversion"
 #define BLOCK_OPT_BACKING_FILE      "backing_file"
diff --git a/qemu-img.c b/qemu-img.c
index bbe1574..26be4d6 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2229,6 +2229,8 @@ static int img_convert(int argc, char **argv)
     if (compress) {
         bool encryption =
             qemu_opt_get_bool(opts, BLOCK_OPT_ENCRYPT, false);
+        const char *encryptfmt =
+            qemu_opt_get(opts, BLOCK_OPT_ENCRYPT_FORMAT);
         const char *preallocation =
             qemu_opt_get(opts, BLOCK_OPT_PREALLOC);
 
@@ -2238,7 +2240,7 @@ static int img_convert(int argc, char **argv)
             goto out;
         }
 
-        if (encryption) {
+        if (encryption || encryptfmt) {
             error_report("Compression and encryption not supported at "
                          "the same time");
             ret = -1;
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index a952330..e7ca3b1 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -48,7 +48,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -61,7 +62,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -74,7 +76,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -87,7 +90,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -100,7 +104,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -113,7 +118,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -126,7 +132,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -139,7 +146,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -167,7 +175,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -229,7 +238,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -242,7 +252,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -255,7 +266,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -268,7 +280,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -281,7 +294,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -294,7 +308,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -307,7 +322,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -320,7 +336,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -348,7 +365,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -407,7 +425,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -420,7 +439,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -433,7 +453,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -446,7 +467,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -459,7 +481,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -472,7 +495,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -485,7 +509,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -498,7 +523,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -528,7 +554,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favour of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
-- 
2.9.3
