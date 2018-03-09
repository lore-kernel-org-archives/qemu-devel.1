Received: from eggs.gnu.org ([2001:4830:134:3::10]:33797)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl5-0001EX-T1
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKl2-00071d-2f
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:39 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:19:04 +0100
Message-Id: <20180309161933.8168-28-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 27/56] qcow2: Use visitor for options in
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

Instead of manually creating the BlockdevCreateOptions object, use a
visitor to parse the given options into the QAPI object.

This involves translation from the old command line syntax to the syntax
mandated by the QAPI schema. Option names are still checked against
qcow2_create_opts, so only the old option names are allowed on the
command line, even if they are translated in qcow2_create().

In contrast, new option values are optionally recognised besides the old
values: 'compat' accepts 'v2'/'v3' as an alias for '0.10'/'1.1', and
'encrypt.format' accepts 'qcow' as an alias for 'aes' now.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 block/qcow2.c              | 218 ++++++++++++++++-----------------------------
 tests/qemu-iotests/049.out |   8 +-
 tests/qemu-iotests/112.out |   4 +-
 3 files changed, 84 insertions(+), 146 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 933c612754..37b0e36c1e 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -37,7 +37,8 @@
 #include "qemu/option_int.h"
 #include "qemu/cutils.h"
 #include "qemu/bswap.h"
-#include "qapi/opts-visitor.h"
+#include "qapi/qobject-input-visitor.h"
+#include "qapi/qapi-visit-block-core.h"
 #include "block/crypto.h"
 
 /*
@@ -2449,37 +2450,6 @@ static int qcow2_crypt_method_from_format(const char *encryptfmt)
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
@@ -2874,7 +2844,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
     if (version < 3 && qcow2_opts->lazy_refcounts) {
         error_setg(errp, "Lazy refcounts only supported with compatibility "
-                   "level 1.1 and above (use compat=1.1 or greater)");
+                   "level 1.1 and above (use version=v3 or greater)");
         ret = -EINVAL;
         goto out;
     }
@@ -2892,7 +2862,7 @@ qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
     }
     if (version < 3 && qcow2_opts->refcount_bits != 16) {
         error_setg(errp, "Different refcount widths than 16 bits require "
-                   "compatibility level 1.1 or above (use compat=1.1 or "
+                   "compatibility level 1.1 or above (use version=v3 or "
                    "greater)");
         ret = -EINVAL;
         goto out;
@@ -3080,144 +3050,112 @@ out:
 static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opts,
                                              Error **errp)
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
+    BlockdevCreateOptions *create_options = NULL;
+    QDict *qdict = NULL;
+    QObject *qobj;
+    Visitor *v;
     BlockDriverState *bs = NULL;
     Error *local_err = NULL;
+    const char *val;
     int ret;
 
-    /* Read out options */
-    size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                    BDRV_SECTOR_SIZE);
-    backing_file = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FILE);
-    backing_fmt = qemu_opt_get_del(opts, BLOCK_OPT_BACKING_FMT);
-    backing_drv = qapi_enum_parse(&BlockdevDriver_lookup, backing_fmt,
-                                  0, &local_err);
-    if (local_err) {
-        error_propagate(errp, local_err);
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
+    /* Convert compat=0.10/1.1 into compat=v2/v3, to be renamed into
+     * version=v2/v3 below. */
+    val = qdict_get_try_str(qdict, BLOCK_OPT_COMPAT_LEVEL);
+    if (val && !strcmp(val, "0.10")) {
+        qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "v2");
+    } else if (val && !strcmp(val, "1.1")) {
+        qdict_put_str(qdict, BLOCK_OPT_COMPAT_LEVEL, "v3");
+    }
+
+    /* Change legacy command line options into QMP ones */
+    static const QDictRenames opt_renames[] = {
+        { BLOCK_OPT_BACKING_FILE,       "backing-file" },
+        { BLOCK_OPT_BACKING_FMT,        "backing-fmt" },
+        { BLOCK_OPT_CLUSTER_SIZE,       "cluster-size" },
+        { BLOCK_OPT_LAZY_REFCOUNTS,     "lazy-refcounts" },
+        { BLOCK_OPT_REFCOUNT_BITS,      "refcount-bits" },
+        { BLOCK_OPT_ENCRYPT,            BLOCK_OPT_ENCRYPT_FORMAT },
+        { BLOCK_OPT_COMPAT_LEVEL,       "version" },
+        { NULL, NULL },
+    };
+
+    if (!qdict_rename_keys(qdict, opt_renames, errp)) {
         ret = -EINVAL;
         goto finish;
     }
 
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
-        }
-    }
-
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
+    qdict_put_str(qdict, "file", bs->node_name);
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
-    /* Create and open the file (protocol layer) */
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
-        .u.qcow2        = {
-            .file               = &(BlockdevRef) {
-                .type               = QTYPE_QSTRING,
-                .u.reference        = bs->node_name,
-            },
-            .size               = size,
-            .has_version        = true,
-            .version            = version == 2
-                                  ? BLOCKDEV_QCOW2_VERSION_V2
-                                  : BLOCKDEV_QCOW2_VERSION_V3,
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
-    ret = qcow2_co_create(&create_options, errp);
+    ret = qcow2_co_create(create_options, errp);
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
index 003247023e..0871bff564 100644
--- a/tests/qemu-iotests/049.out
+++ b/tests/qemu-iotests/049.out
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
@@ -205,7 +205,7 @@ qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=off TEST_DIR/t.qcow2 64M
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=off refcount_bits=16
 
 qemu-img create -f qcow2 -o compat=0.10,lazy_refcounts=on TEST_DIR/t.qcow2 64M
-qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use compat=1.1 or greater)
+qemu-img: TEST_DIR/t.qcow2: Lazy refcounts only supported with compatibility level 1.1 and above (use version=v3 or greater)
 Formatting 'TEST_DIR/t.qcow2', fmt=qcow2 size=67108864 compat=0.10 cluster_size=65536 lazy_refcounts=on refcount_bits=16
 
 *** done
diff --git a/tests/qemu-iotests/112.out b/tests/qemu-iotests/112.out
index 81b04d1452..86f041075d 100644
--- a/tests/qemu-iotests/112.out
+++ b/tests/qemu-iotests/112.out
@@ -21,9 +21,9 @@ refcount bits: 16
 
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 refcount bits: 16
-qemu-img: TEST_DIR/t.IMGFMT: Different refcount widths than 16 bits require compatibility level 1.1 or above (use or greater)
+qemu-img: TEST_DIR/t.IMGFMT: Different refcount widths than 16 bits require compatibility level 1.1 or above (use version=v3 or greater)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-qemu-img: TEST_DIR/t.IMGFMT: Different refcount widths than 16 bits require compatibility level 1.1 or above (use or greater)
+qemu-img: TEST_DIR/t.IMGFMT: Different refcount widths than 16 bits require compatibility level 1.1 or above (use version=v3 or greater)
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
 
 === Snapshot limit on refcount_bits=1 ===
-- 
2.13.6
