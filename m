Received: from eggs.gnu.org ([2001:4830:134:3::10]:58300)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiv9-0005sD-1w
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiv5-0000wM-4k
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:51 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Jan 2018 20:52:24 +0100
Message-Id: <20180111195225.4226-10-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 09/10] qcow2: Use visitor for options in
 qcow2_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c              | 227 ++++++++++++++++++---------------------------
 tests/qemu-iotests/049.out |  10 +-
 2 files changed, 93 insertions(+), 144 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 868e0e8a62..4031a18a77 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -36,7 +36,7 @@
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
-#include "qapi/opts-visitor.h"
+#include "qapi/qobject-input-visitor.h"
 #include "qapi-visit.h"
 #include "block/crypto.h"
 
@@ -2379,37 +2379,6 @@ static int qcow2_crypt_method_from_format(const char *encryptfmt)
     }
 }
 
-static QCryptoBlockCreateOptions *
-qcow2_parse_encryption(const char *encryptfmt, QemuOpts *opts, Error **errp)
-{
-    QCryptoBlockCreateOptions *cryptoopts = NULL;
-    QDict *options, *encryptopts;
-    int fmt;
-
-    options = qemu_opts_to_qdict(opts, NULL);
-    qdict_extract_subqdict(options, &encryptopts, "encrypt.");
-    QDECREF(options);
-
-    fmt = qcow2_crypt_method_from_format(encryptfmt);
-
-    switch (fmt) {
-    case QCOW_CRYPT_LUKS:
-        cryptoopts = block_crypto_create_opts_init(
-            Q_CRYPTO_BLOCK_FORMAT_LUKS, encryptopts, errp);
-        break;
-    case QCOW_CRYPT_AES:
-        cryptoopts = block_crypto_create_opts_init(
-            Q_CRYPTO_BLOCK_FORMAT_QCOW, encryptopts, errp);
-        break;
-    default:
-        error_setg(errp, "Unknown encryption format '%s'", encryptfmt);
-        break;
-    }
-
-    QDECREF(encryptopts);
-    return cryptoopts;
-}
-
 static int qcow2_set_up_encryption(BlockDriverState *bs,
                                    QCryptoBlockCreateOptions *cryptoopts,
                                    Error **errp)
@@ -3003,144 +2972,124 @@ out:
 
 static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 {
-    BlockdevCreateOptions create_options;
-    char *backing_file = NULL;
-    char *backing_fmt = NULL;
-    BlockdevDriver backing_drv;
-    char *buf = NULL;
-    uint64_t size = 0;
-    int flags = 0;
-    size_t cluster_size = DEFAULT_CLUSTER_SIZE;
-    PreallocMode prealloc;
-    int version;
-    uint64_t refcount_bits;
-    char *encryptfmt = NULL;
-    QCryptoBlockCreateOptions *cryptoopts = NULL;
+    BlockdevCreateOptions *create_options;
+    QDict *qdict = NULL;
+    QObject *qobj;
+    Visitor *v;
     BlockDriverState *bs = NULL;
+    const char *val;
+    int i, ret;
     Error *local_err = NULL;
-    int ret;
 
-    /* Read out options */
-    size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                    BDRV_SECTOR_SIZE);
-    backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
-    backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
-    backing_drv = qapi_enum_parse(&BlockdevDriver_lookup, backing_fmt,
-                                  0, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
-        goto finish;
-    }
+    /* Only the keyval visitor supports the dotted syntax needed for
+     * encryption, so go through a QDict before getting a QAPI type. Ignore
+     * options meant for the protocol layer so that the visitor doesn't
+     * complain. */
+    qdict = qemu_opts_to_qdict_filtered(opts, NULL, bdrv_qcow2.create_opts,
+                                        true);
+
+    /* Handle encryption options */
+    val = qdict_get_try_str(qdict, BLOCK_OPT_ENCRYPT);
+    if (val && !strcmp(val, "on")) {
+        qdict_put_str(qdict, BLOCK_OPT_ENCRYPT, "qcow");
+    } else if (val && !strcmp(val, "off")) {
+        qdict_del(qdict, BLOCK_OPT_ENCRYPT);
+    }
+
+    val = qdict_get_try_str(qdict, BLOCK_OPT_ENCRYPT_FORMAT);
+    if (val && !strcmp(val, "aes")) {
+        qdict_put_str(qdict, BLOCK_OPT_ENCRYPT_FORMAT, "qcow");
+    }
+
+    /* TODO QAPI doesn't allow dots in enum values. Either change QAPI or
+     * decide on the proper new representation for blockdev-create */
+    val = qdict_get_try_str(qdict, BLOCK_OPT_COMPAT_LEVEL);
+    if (val && !strcmp(val, "0.10")) {
+        qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "0_10");
+    } else if (val && !strcmp(val, "1.1")) {
+        qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "1_1");
+    }
+
+    /* Change legacy command line options into QMP ones */
+    static const struct {
+        const char *from;
+        const char *to;
+    } opt_renames[] = {
+        { BLOCK_OPT_BACKING_FILE,       "backing-file" },
+        { BLOCK_OPT_BACKING_FMT,        "backing-fmt" },
+        { BLOCK_OPT_CLUSTER_SIZE,       "cluster-size" },
+        { BLOCK_OPT_LAZY_REFCOUNTS,     "lazy-refcounts" },
+        { BLOCK_OPT_REFCOUNT_BITS,      "refcount-bits" },
+        { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
+    };
 
-    encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
-    if (encryptfmt) {
-        if (qemu_opt_get(opts, BLOCK_OPT_ENCRYPT)) {
-            error_setg(errp, "Options " BLOCK_OPT_ENCRYPT " and "
-                       BLOCK_OPT_ENCRYPT_FORMAT " are mutually exclusive");
-            ret = -EINVAL;
-            goto finish;
-        }
-    } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
-        encryptfmt = g_strdup("aes");
-    }
-    if (encryptfmt) {
-        cryptoopts = qcow2_parse_encryption(encryptfmt, opts, errp);
-        if (cryptoopts == NULL) {
-            ret = -EINVAL;
-            goto finish;
+    for (i = 0; i < ARRAY_SIZE(opt_renames); i++) {
+        if (qdict_haskey(qdict, opt_renames[i].from)) {
+            if (qdict_haskey(qdict, opt_renames[i].to)) {
+                error_setg(errp, "'%s' and its alias '%s' can't be used at the "
+                           "same time", opt_renames[i].to, opt_renames[i].from);
+                ret = -EINVAL;
+                goto finish;
+            }
+
+            qobj = qdict_get(qdict, opt_renames[i].from);
+            qobject_incref(qobj);
+            qdict_put_obj(qdict, opt_renames[i].to, qobj);
+            qdict_del(qdict, opt_renames[i].from);
         }
     }
 
-    cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
+    /* Create and open the file (protocol layer) */
+    ret = bdrv_create_file(filename, opts, errp);
+    if (ret < 0) {
         goto finish;
     }
-    buf = qemu_opt_get_del(opts, BLOCK_OPT_PREALLOC);
-    prealloc = qapi_enum_parse(&PreallocMode_lookup, buf,
-                               PREALLOC_MODE_OFF, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
-        ret = -EINVAL;
+
+    bs = bdrv_open(filename, NULL, NULL,
+                   BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
+    if (bs == NULL) {
+        ret = -EIO;
         goto finish;
     }
 
-    version = qcow2_opt_get_version_del(opts, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
+    /* Set 'driver' and 'node' options */
+    qdict_put_str(qdict, "driver", "qcow2");
+    qdict_put_str(qdict, "node", bs->node_name);
+
+    /* Now get the QAPI type BlockdevCreateOptions */
+    qobj = qdict_crumple(qdict, errp);
+    QDECREF(qdict);
+    qdict = qobject_to_qdict(qobj);
+    if (qdict == NULL) {
         ret = -EINVAL;
         goto finish;
     }
 
-    if (qemu_opt_get_bool_del(opts, BLOCK_OPT_LAZY_REFCOUNTS, false)) {
-        flags |= BLOCK_FLAG_LAZY_REFCOUNTS;
-    }
+    v = qobject_input_visitor_new_keyval(QOBJECT(qdict));
+    visit_type_BlockdevCreateOptions(v, NULL, &create_options, &local_err);
+    visit_free(v);
 
-    refcount_bits = qcow2_opt_get_refcount_bits_del(opts, version, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         ret = -EINVAL;
         goto finish;
     }
 
-
-    /* Create and open the file (protocol layer */
-    ret = bdrv_create_file(filename, opts, errp);
-    if (ret < 0) {
-        goto finish;
-    }
-
-    bs = bdrv_open(filename, NULL, NULL,
-                   BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
-    if (bs == NULL) {
-        ret = -EIO;
-        goto finish;
-    }
+    /* Silently round up size */
+    create_options->u.qcow2.size = ROUND_UP(create_options->u.qcow2.size,
+                                            BDRV_SECTOR_SIZE);
 
     /* Create the qcow2 image (format layer) */
-    create_options = (BlockdevCreateOptions) {
-        .driver         = BLOCKDEV_DRIVER_QCOW2,
-        .node           = & (BlockdevRef) {
-            .type               = QTYPE_QSTRING,
-            .u.reference        = bs->node_name,
-        },
-        .u.qcow2        = {
-            .size               = size,
-            .has_compat         = true,
-            .compat             = version == 2
-                                  ? BLOCKDEV_QCOW2_COMPAT_LEVEL_0_10
-                                  : BLOCKDEV_QCOW2_COMPAT_LEVEL_1_1,
-            .has_backing_file   = (backing_file != NULL),
-            .backing_file       = backing_file,
-            .has_backing_fmt    = (backing_fmt != NULL),
-            .backing_fmt        = backing_drv,
-            .has_encrypt        = (encryptfmt != NULL),
-            .encrypt            = cryptoopts,
-            .has_cluster_size   = true,
-            .cluster_size       = cluster_size,
-            .has_preallocation  = true,
-            .preallocation      = prealloc,
-            .has_lazy_refcounts = true,
-            .lazy_refcounts     = (flags & BLOCK_FLAG_LAZY_REFCOUNTS),
-            .has_refcount_bits  = true,
-            .refcount_bits      = refcount_bits,
-        },
-    };
-    ret = qcow2_create2(&create_options, errp);
+    ret = qcow2_create2(create_options, errp);
     if (ret < 0) {
         goto finish;
     }
 
+    ret = 0;
 finish:
+    QDECREF(qdict);
     bdrv_unref(bs);
-
-    qapi_free_QCryptoBlockCreateOptions(cryptoopts);
-    g_free(backing_file);
-    g_free(backing_fmt);
-    g_free(encryptfmt);
-    g_free(buf);
+    qapi_free_BlockdevCreateOptions(create_options);
     return ret;
 }
 
diff --git a/tests/qemu-iotests/049.out b/tests/qemu-iotests/049.out
index 003247023e..1115c27ccf 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
@@ -106,7 +106,7 @@ qemu-img: Value '-1k' is out of range for parameter 'size'
 qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- 1kilobyte
-qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
+qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for 
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=1kilobyte TEST_DIR/t.qcow2
@@ -116,7 +116,7 @@ and exabytes, respectively.
 qemu-img: TEST_DIR/t.qcow2: Invalid options for file format 'qcow2'
 
 qemu-img create -f qcow2 TEST_DIR/t.qcow2 -- foobar
-qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for
+qemu-img: Invalid image size specified! You may use k, M, G, T, P or E suffixes for 
 qemu-img: kilobytes, megabytes, gigabytes, terabytes, petabytes and exabytes.
 
 qemu-img create -f qcow2 -o size=foobar TEST_DIR/t.qcow2
@@ -166,11 +166,11 @@ qemu-img create -f qcow2 -o compat=1.1 TEST_DIR/t.qcow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=1.1 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.42 TEST_DIR/t.qcow2 64M
-qemu-img: TEST_DIR/t.qcow2: Invalid compatibility level: '0.42'
+qemu-img: TEST_DIR/t.qcow2: Invalid parameter '0.42'
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.42 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=foobar TEST_DIR/t.qcow2 64M
-qemu-img: TEST_DIR/t.qcow2: Invalid compatibility level: 'foobar'
+qemu-img: TEST_DIR/t.qcow2: Invalid parameter 'foobar'
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=foobar cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 == Check preallocation option ==
@@ -182,7 +182,7 @@ qemu-img create -f qcow2 -o preallocation=metadata TEST_DIR/t.qcow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=metadata lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o preallocation=1234 TEST_DIR/t.qcow2 64M
-qemu-img: TEST_DIR/t.qcow2: invalid parameter value: 1234
+qemu-img: TEST_DIR/t.qcow2: Invalid parameter '1234'
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 cluster_size=65536 preallocation=1234 lazy_refcounts=off refcount_bits=16
 
 == Check encryption option ==
-- 
2.13.6
