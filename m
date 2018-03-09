Received: from eggs.gnu.org ([2001:4830:134:3::10]:33566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkz-00017x-8W
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKku-0006sS-G0
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:33 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:58 +0100
Message-Id: <20180309161933.8168-22-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 21/56] qcow2: Use QCryptoBlockCreateOptions in
 qcow2_co_create()
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

Instead of passing the encryption format name and the QemuOpts down, use
the QCryptoBlockCreateOptions contained in BlockdevCreateOptions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 62 +++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b7df2d5cab..e1821eb3c8 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2449,13 +2449,10 @@ static int qcow2_crypt_method_from_format(const char *encryptfmt)
     }
 }
 
-static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
-                                   QemuOpts *opts, Error **errp)
+static QCryptoBlockCreateOptions *
+qcow2_parse_encryption(const char *encryptfmt, QemuOpts *opts, Error **errp)
 {
-    BDRVQcow2State *s = bs->opaque;
     QCryptoBlockCreateOptions *cryptoopts = NULL;
-    QCryptoBlock *crypto = NULL;
-    int ret = -EINVAL;
     QDict *options, *encryptopts;
     int fmt;
 
@@ -2478,10 +2475,31 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
         error_setg(errp, "Unknown encryption format '%s'", encryptfmt);
         break;
     }
-    if (!cryptoopts) {
-        ret = -EINVAL;
-        goto out;
+
+    QDECREF(encryptopts);
+    return cryptoopts;
+}
+
+static int qcow2_set_up_encryption(BlockDriverState *bs,
+                                   QCryptoBlockCreateOptions *cryptoopts,
+                                   Error **errp)
+{
+    BDRVQcow2State *s = bs->opaque;
+    QCryptoBlock *crypto = NULL;
+    int fmt, ret;
+
+    switch (cryptoopts->format) {
+    case Q_CRYPTO_BLOCK_FORMAT_LUKS:
+        fmt = QCOW_CRYPT_LUKS;
+        break;
+    case Q_CRYPTO_BLOCK_FORMAT_QCOW:
+        fmt = QCOW_CRYPT_AES;
+        break;
+    default:
+        error_setg(errp, "Crypto format not supported in qcow2");
+        return -EINVAL;
     }
+
     s->crypt_method_header = fmt;
 
     crypto = qcrypto_block_create(cryptoopts, "encrypt.",
@@ -2489,8 +2507,7 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
                                   qcow2_crypto_hdr_write_func,
                                   bs, errp);
     if (!crypto) {
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
     ret = qcow2_update_header(bs);
@@ -2499,10 +2516,9 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
         goto out;
     }
 
+    ret = 0;
  out:
-    QDECREF(encryptopts);
     qcrypto_block_free(crypto);
-    qapi_free_QCryptoBlockCreateOptions(cryptoopts);
     return ret;
 }
 
@@ -2768,8 +2784,7 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
 }
 
 static int coroutine_fn
-qcow2_co_create(BlockdevCreateOptions *create_options, QemuOpts *opts,
-                const char *encryptfmt, Error **errp)
+qcow2_co_create(BlockdevCreateOptions *create_options, Error **errp)
 {
     BlockdevCreateOptionsQcow2 *qcow2_opts;
     QDict *options;
@@ -2999,8 +3014,8 @@ qcow2_co_create(BlockdevCreateOptions *create_options, QemuOpts *opts,
     }
 
     /* Want encryption? There you go. */
-    if (encryptfmt) {
-        ret = qcow2_set_up_encryption(blk_bs(blk), encryptfmt, opts, errp);
+    if (qcow2_opts->has_encrypt) {
+        ret = qcow2_set_up_encryption(blk_bs(blk), qcow2_opts->encrypt, errp);
         if (ret < 0) {
             goto out;
         }
@@ -3058,6 +3073,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
     int version;
     uint64_t refcount_bits;
     char *encryptfmt = NULL;
+    QCryptoBlockCreateOptions *cryptoopts = NULL;
     BlockDriverState *bs = NULL;
     Error *local_err = NULL;
     int ret;
@@ -3074,6 +3090,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
         ret = -EINVAL;
         goto finish;
     }
+
     encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
     if (encryptfmt) {
         if (qemu_opt_get(opts, BLOCK_OPT_ENCRYPT)) {
@@ -3085,6 +3102,14 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
     } else if (qemu_opt_get_bool_del(opts, BLOCK_OPT_ENCRYPT, false)) {
         encryptfmt = g_strdup("aes");
     }
+    if (encryptfmt) {
+        cryptoopts = qcow2_parse_encryption(encryptfmt, opts, errp);
+        if (cryptoopts == NULL) {
+            ret = -EINVAL;
+            goto finish;
+        }
+    }
+
     cluster_size = qcow2_opt_get_cluster_size_del(opts, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
@@ -3158,6 +3183,8 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
             .backing_file       = backing_file,
             .has_backing_fmt    = (backing_fmt != NULL),
             .backing_fmt        = backing_drv,
+            .has_encrypt        = (encryptfmt != NULL),
+            .encrypt            = cryptoopts,
             .has_cluster_size   = true,
             .cluster_size       = cluster_size,
             .has_preallocation  = true,
@@ -3168,7 +3195,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
             .refcount_bits      = refcount_bits,
         },
     };
-    ret = qcow2_co_create(&create_options, opts, encryptfmt, errp);
+    ret = qcow2_co_create(&create_options, errp);
     if (ret < 0) {
         goto finish;
     }
@@ -3176,6 +3203,7 @@ static int coroutine_fn qcow2_co_create_opts(const char *filename, QemuOpts *opt
 finish:
     bdrv_unref(bs);
 
+    qapi_free_QCryptoBlockCreateOptions(cryptoopts);
     g_free(backing_file);
     g_free(backing_fmt);
     g_free(encryptfmt);
-- 
2.13.6
