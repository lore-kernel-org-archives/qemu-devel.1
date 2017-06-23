Received: from eggs.gnu.org ([2001:4830:134:3::10]:33315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dORON-0003bk-LR
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:25:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dOROI-00015M-1C
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:25:07 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 23 Jun 2017 17:24:06 +0100
Message-Id: <20170623162419.26068-8-berrange@redhat.com>
In-Reply-To: <20170623162419.26068-1-berrange@redhat.com>
References: <20170623162419.26068-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v10 07/20] block: deprecate "encryption=on" in
 favor of "encrypt.format=aes"
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
 block/qcow.c               | 31 ++++++++++++---
 block/qcow2.c              | 34 ++++++++++++----
 include/block/block_int.h  |  2 +-
 qemu-img.c                 |  4 +-
 tests/qemu-iotests/049.out | 98 +++++++++++++++++++++++-----------------------
 tests/qemu-iotests/082.out | 95 ++++++++++++++++++++++++++++----------------
 tests/qemu-iotests/085.out | 38 +++++++++---------
 tests/qemu-iotests/144.out |  4 +-
 tests/qemu-iotests/185.out |  8 ++--
 9 files changed, 191 insertions(+), 123 deletions(-)

diff --git a/block/qcow.c b/block/qcow.c
index 49871fb..a442ed7 100644
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
+        if (qemu_opt_get(opts, BLOCK_OPT_ENCRYPT)) {
+            error_setg(errp, "Options " BLOCK_OPT_ENCRYPT " and "
+                       BLOCK_OPT_ENCRYPT_FORMAT " are mutually exclusive");
+            ret = -EINVAL;
+            goto cleanup;
+        }
+    } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
+        encryptfmt = "aes";
     }
 
     ret = bdrv_create_file(filename, opts, &local_err);
@@ -873,7 +881,13 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
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
@@ -1047,8 +1061,13 @@ static QemuOptsList qcow_create_opts = {
         {
             .name = BLOCK_OPT_ENCRYPT,
             .type = QEMU_OPT_BOOL,
-            .help = "Encrypt the image",
-            .def_value_str = "off"
+            .help = "Encrypt the image with format 'aes'. (Deprecated "
+                    "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",
+        },
+        {
+            .name = BLOCK_OPT_ENCRYPT_FORMAT,
+            .type = QEMU_OPT_STRING,
+            .help = "Encrypt the image, format choices: 'aes'",
         },
         { /* end of list */ }
     }
diff --git a/block/qcow2.c b/block/qcow2.c
index 088ffe1..67fb50d 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2144,7 +2144,7 @@ static int qcow2_create2(const char *filename, int64_t total_size,
                          const char *backing_file, const char *backing_format,
                          int flags, size_t cluster_size, PreallocMode prealloc,
                          QemuOpts *opts, int version, int refcount_order,
-                         Error **errp)
+                         const char *encryptfmt, Error **errp)
 {
     int cluster_bits;
     QDict *options;
@@ -2273,7 +2273,13 @@ static int qcow2_create2(const char *filename, int64_t total_size,
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
@@ -2402,6 +2408,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     int version = 3;
     uint64_t refcount_bits = 16;
     int refcount_order;
+    const char *encryptfmt = NULL;
     Error *local_err = NULL;
     int ret;
 
@@ -2410,8 +2417,16 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
                     BDRV_SECTOR_SIZE);
     backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
     backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
-    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
-        flags |= BLOCK_FLAG_ENCRYPT;
+    encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
+    if (encryptfmt) {
+        if (qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT)) {
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
@@ -2477,7 +2492,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 
     ret = qcow2_create2(filename, size, backing_file, backing_fmt, flags,
                         cluster_size, prealloc, opts, version, refcount_order,
-                        &local_err);
+                        encryptfmt, &local_err);
     error_propagate(errp, local_err);
 
 finish:
@@ -3431,8 +3446,13 @@ static QemuOptsList qcow2_create_opts = {
         {
             .name = BLOCK_OPT_ENCRYPT,
             .type = QEMU_OPT_BOOL,
-            .help = "Encrypt the image",
-            .def_value_str = "off"
+            .help = "Encrypt the image with format 'aes'. (Deprecated "
+                    "in favor of " BLOCK_OPT_ENCRYPT_FORMAT "=aes)",
+        },
+        {
+            .name = BLOCK_OPT_ENCRYPT_FORMAT,
+            .type = QEMU_OPT_STRING,
+            .help = "Encrypt the image, format choices: 'aes'",
         },
         {
             .name = BLOCK_OPT_CLUSTER_SIZE,
diff --git a/include/block/block_int.h b/include/block/block_int.h
index cb78c4f..01040e2 100644
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
index 0ad698d..31dd0cc 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -2267,6 +2267,8 @@ static int img_convert(int argc, char **argv)
     if (s.compressed) {
         bool encryption =
             qemu_opt_get_bool(opts, BLOCK_OPT_ENCRYPT, false);
+        const char *encryptfmt =
+            qemu_opt_get(opts, BLOCK_OPT_ENCRYPT_FORMAT);
         const char *preallocation =
             qemu_opt_get(opts, BLOCK_OPT_PREALLOC);
 
@@ -2276,7 +2278,7 @@ static int img_convert(int argc, char **argv)
             goto out;
         }
 
-        if (encryption) {
+        if (encryption || encryptfmt) {
             error_report("Compression and encryption not supported at "
                          "the same time");
             ret = -1;
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 34e66db..50e91c8 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -4,90 +4,90 @@ QA output created by 049
 == 1. Traditional size parameter ==
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024b
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1k
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1K
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1G
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1T
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1024.0b
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5k
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5K
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5G
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 1.5T
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 == 2. Specifying size via -o ==
 
 qemu-img create -f qcow2 -o size=1024 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1048576 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1073741824 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1099511627776 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024.0 TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1024.0b TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1024 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5k TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5K TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1536 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5M TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1572864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5G TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1610612736 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o size=1.5T TEST_DIR/t.qcow2
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=1649267441664 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 == 3. Invalid sizes ==
 
@@ -128,62 +128,62 @@ qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 == Check correct interpretation of suffixes for cluster size ==
 
 qemu-img create -f qcow2 -o cluster_size=1024 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=1048576 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1048576 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024.0 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=1024.0b TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=1024 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=1024 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5k TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=512 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5K TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=512 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=512 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o cluster_size=0.5M TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=524288 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=524288 lazy_refcounts=off refcount_bits=16
 
 == Check compat level option ==
 
 qemu-img create -f qcow2 -o compat=0.10 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=1.1 TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.42 TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid compatibility level: '0.42'
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=foobar TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Invalid compatibility level: 'foobar'
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=foobar encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=foobar cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 == Check preallocation option ==
 
 qemu-img create -f qcow2 -o preallocation=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 preallocation=off lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=off lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o preallocation=metadata TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 preallocation=metadata lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=metadata lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o preallocation=1234 TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: invalid parameter value: 1234
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 preallocation=1234 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=1234 lazy_refcounts=off refcount_bits=16
 
 == Check encryption option ==
 
@@ -196,16 +196,16 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 encryption=on cluster_siz
 == Check lazy_refcounts option (only with v3) ==
 
 qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=1.1,lazy_refcounts=on TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 encryption=off cluster_size=65536 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=on refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=off TEST_DIR/t.qcow2 64M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=on TEST_DIR/t.qcow2 64M
 qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use compat=1.1 or greater)
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 encryption=off cluster_size=65536 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=on refcount_bits=16
 
 *** done
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index a952330..621386b 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -3,14 +3,14 @@ QA output created by 082
 === create: Options specified more than once ===
 
 Testing: create -f foo -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128M (134217728 bytes)
 cluster_size: 65536
 
 Testing: create -f qcow2 -o cluster_size=4k -o lazy_refcounts=on TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 encryption=off cluster_size=4096 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=4096 lazy_refcounts=on refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128M (134217728 bytes)
@@ -22,7 +22,7 @@ Format specific information:
     corrupt: false
 
 Testing: create -f qcow2 -o cluster_size=4k -o lazy_refcounts=on -o cluster_size=8k TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 encryption=off cluster_size=8192 lazy_refcounts=on refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=on refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128M (134217728 bytes)
@@ -34,7 +34,7 @@ Format specific information:
     corrupt: false
 
 Testing: create -f qcow2 -o cluster_size=4k,cluster_size=8k TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 encryption=off cluster_size=8192 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=8192 lazy_refcounts=off refcount_bits=16
 image: TEST_DIR/t.IMGFMT
 file format: IMGFMT
 virtual size: 128M (134217728 bytes)
@@ -48,7 +48,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -61,7 +62,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -74,7 +76,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -87,7 +90,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -100,7 +104,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -113,7 +118,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -126,7 +132,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -139,7 +146,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -147,10 +155,10 @@ refcount_bits    Width of a reference count entry in bits
 nocow            Turn off copy-on-write (valid only on btrfs)
 
 Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,help TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,help cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2,,? TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,? encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2,,? cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 Testing: create -f qcow2 -o backing_file=TEST_DIR/t.qcow2, -o help TEST_DIR/t.qcow2 128M
 qemu-img: Invalid option list: backing_file=TEST_DIR/t.qcow2,
@@ -167,7 +175,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -180,7 +189,7 @@ size             Virtual disk size
 === convert: Options specified more than once ===
 
 Testing: create -f qcow2 TEST_DIR/t.qcow2 128M
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=134217728 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 Testing: convert -f foo -f qcow2 TEST_DIR/t.qcow2 TEST_DIR/t.qcow2.base
 image: TEST_DIR/t.IMGFMT.base
@@ -229,7 +238,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -242,7 +252,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -255,7 +266,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -268,7 +280,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -281,7 +294,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -294,7 +308,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -307,7 +322,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -320,7 +336,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -348,7 +365,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -407,7 +425,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -420,7 +439,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -433,7 +453,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -446,7 +467,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -459,7 +481,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -472,7 +495,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -485,7 +509,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -498,7 +523,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
@@ -528,7 +554,8 @@ size             Virtual disk size
 compat           Compatibility level (0.10 or 1.1)
 backing_file     File name of a base image
 backing_fmt      Image format of the base image
-encryption       Encrypt the image
+encryption       Encrypt the image with format 'aes'. (Deprecated in favor of encrypt.format=aes)
+encrypt.format   Encrypt the image, format choices: 'aes'
 cluster_size     qcow2 cluster size
 preallocation    Preallocation mode (allowed values: off, metadata, falloc, full)
 lazy_refcounts   Postpone refcount updates
diff --git a/tests/qemu-iotests/085.out b/tests/qemu-iotests/085.out
index a5d4cc3..6edf107 100644
--- a/tests/qemu-iotests/085.out
+++ b/tests/qemu-iotests/085.out
@@ -11,7 +11,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 
 === Create a single snapshot on virtio0 ===
 
-Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.1 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.1 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Invalid command - missing device and nodename ===
@@ -25,32 +25,32 @@ Formatting 'TEST_DIR/1-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file
 
 === Create several transactional group snapshots ===
 
-Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/1-snapshot-v0.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/2-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/1-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/2-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/t.qcow2.2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
-Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v0.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v1.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/3-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/3-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/2-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
-Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v0.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v1.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/4-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/4-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/3-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
-Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v0.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v1.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/5-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/5-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/4-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
-Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v0.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v1.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/6-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/6-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/5-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
-Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v0.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v1.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/7-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/7-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/6-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
-Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v0.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v1.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/8-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/8-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/7-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
-Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v0.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v1.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/9-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/9-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/8-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
-Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v0.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
-Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v1.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/10-snapshot-v0.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v0.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/10-snapshot-v1.qcow2', fmt=qcow2 size=134217728 backing_file=TEST_DIR/9-snapshot-v1.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Create a couple of snapshots using blockdev-snapshot ===
diff --git a/tests/qemu-iotests/144.out b/tests/qemu-iotests/144.out
index 387855c..014b281 100644
--- a/tests/qemu-iotests/144.out
+++ b/tests/qemu-iotests/144.out
@@ -7,7 +7,7 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=536870912
 === Performing Live Snapshot 1 ===
 
 {"return": {}}
-Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Performing block-commit on active layer ===
@@ -19,6 +19,6 @@ Formatting 'TEST_DIR/tmp.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/
 
 === Performing Live Snapshot 2 ===
 
-Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/tmp2.qcow2', fmt=qcow2 size=536870912 backing_file=TEST_DIR/t.qcow2 backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 *** done
diff --git a/tests/qemu-iotests/185.out b/tests/qemu-iotests/185.out
index 45bc7cb..57eaf8d 100644
--- a/tests/qemu-iotests/185.out
+++ b/tests/qemu-iotests/185.out
@@ -7,12 +7,12 @@ Formatting 'TEST_DIR/t.IMGFMT.base', fmt=IMGFMT size=67108864
 
 === Creating backing chain ===
 
-Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.mid', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.base backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 wrote 4194304/4194304 bytes at offset 0
 4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
 {"return": ""}
-Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.mid backing_fmt=qcow2 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.qcow2.mid backing_fmt=qcow2 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 
 === Start commit job and exit qemu ===
@@ -33,7 +33,7 @@ Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 backing_file=TEST_DIR/t.q
 === Start mirror job and exit qemu ===
 
 {"return": {}}
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
@@ -42,7 +42,7 @@ Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 encryption=off clust
 === Start backup job and exit qemu ===
 
 {"return": {}}
-Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 encryption=off cluster_size=65536 lazy_refcounts=off refcount_bits=16
+Formatting 'TEST_DIR/t.qcow2.copy', fmt=qcow2 size=67108864 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 {"return": {}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false}}
-- 
2.9.3
