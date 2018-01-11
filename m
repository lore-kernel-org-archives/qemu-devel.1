Received: from eggs.gnu.org ([2001:4830:134:3::10]:57941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZiut-0005Ye-63
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eZius-0000ht-32
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:53:35 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Thu, 11 Jan 2018 20:52:21 +0100
Message-Id: <20180111195225.4226-7-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-1-kwolf@redhat.com>
References: <20180111195225.4226-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 06/10] qcow2: Use QCryptoBlockCreateOptions
 in qcow2_create2()
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

Instead of passing the encryption format name and the QemuOpts down, use
the QCryptoBlockCreateOptions contained in BlockdevCreateOptions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 62 +++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 1a0f8f2e6d..686b765c06 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2379,13 +2379,10 @@ static int qcow2_crypt_method_from_format(const char *encryptfmt)
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
 
@@ -2408,10 +2405,31 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
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
@@ -2419,8 +2437,7 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
                                   qcow2_crypto_hdr_write_func,
                                   bs, errp);
     if (!crypto) {
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
     ret = qcow2_update_header(bs);
@@ -2429,10 +2446,9 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
         goto out;
     }
 
+    ret = 0;
  out:
-    QDECREF(encryptopts);
     qcrypto_block_free(crypto);
-    qapi_free_QCryptoBlockCreateOptions(cryptoopts);
     return ret;
 }
 
@@ -2697,8 +2713,7 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
     return refcount_bits;
 }
 
-static int qcow2_create2(BlockdevCreateOptions *create_options,
-                         QemuOpts *opts, const char *encryptfmt, Error **errp)
+static int qcow2_create2(BlockdevCreateOptions *create_options, Error **errp)
 {
     BlockdevCreateOptionsQcow2 *qcow2_opts;
     QDict *options;
@@ -2923,8 +2938,8 @@ static int qcow2_create2(BlockdevCreateOptions *create_options,
     }
 
     /* Want encryption? There you go. */
-    if (encryptfmt) {
-        ret = qcow2_set_up_encryption(blk_bs(blk), encryptfmt, opts, errp);
+    if (qcow2_opts->has_encrypt) {
+        ret = qcow2_set_up_encryption(blk_bs(blk), qcow2_opts->encrypt, errp);
         if (ret < 0) {
             goto out;
         }
@@ -2981,6 +2996,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     int version;
     uint64_t refcount_bits;
     char *encryptfmt = NULL;
+    QCryptoBlockCreateOptions *cryptoopts = NULL;
     BlockDriverState *bs = NULL;
     Error *local_err = NULL;
     int ret;
@@ -2997,6 +3013,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         ret = -EINVAL;
         goto finish;
     }
+
     encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
     if (encryptfmt) {
         if (qemu_opt_get(opts, BLOCK_OPT_ENCRYPT)) {
@@ -3008,6 +3025,14 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
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
@@ -3081,6 +3106,8 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
             .backing_file       = backing_file,
             .has_backing_fmt    = (backing_fmt != NULL),
             .backing_fmt        = backing_drv,
+            .has_encrypt        = (encryptfmt != NULL),
+            .encrypt            = cryptoopts,
             .has_cluster_size   = true,
             .cluster_size       = cluster_size,
             .has_preallocation  = true,
@@ -3091,7 +3118,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
             .refcount_bits      = refcount_bits,
         },
     };
-    ret = qcow2_create2(&create_options, opts, encryptfmt, errp);
+    ret = qcow2_create2(&create_options, errp);
     if (ret < 0) {
         goto finish;
     }
@@ -3099,6 +3126,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 finish:
     bdrv_unref(bs);
 
+    qapi_free_QCryptoBlockCreateOptions(cryptoopts);
     g_free(backing_file);
     g_free(backing_fmt);
     g_free(encryptfmt);
-- 
2.13.6
