Received: from eggs.gnu.org ([2001:4830:134:3::10]:37949)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUrD-0000d5-Rg
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:54:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eoUr9-0002Yq-Tm
	for qemu-devel@nongnu.org; Wed, 21 Feb 2018 08:54:51 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 21 Feb 2018 14:53:34 +0100
Message-Id: <20180221135404.27598-7-kwolf@redhat.com>
In-Reply-To: <20180221135404.27598-1-kwolf@redhat.com>
References: <20180221135404.27598-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 06/36] qcow2: Use QCryptoBlockCreateOptions
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
Cc: kwolf@redhat.com, mreitz@redhat.com, pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

Instead of passing the encryption format name and the QemuOpts down, use
the QCryptoBlockCreateOptions contained in BlockdevCreateOptions.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2.c | 62 +++++++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 45 insertions(+), 17 deletions(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index b34924b0f0..9a2028b3cf 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -2414,13 +2414,10 @@ static int qcow2_crypt_method_from_format(const char *encryptfmt)
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
 
@@ -2443,10 +2440,31 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
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
@@ -2454,8 +2472,7 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
                                   qcow2_crypto_hdr_write_func,
                                   bs, errp);
     if (!crypto) {
-        ret = -EINVAL;
-        goto out;
+        return -EINVAL;
     }
 
     ret = qcow2_update_header(bs);
@@ -2464,10 +2481,9 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, const char *encryptfmt,
         goto out;
     }
 
+    ret = 0;
  out:
-    QDECREF(encryptopts);
     qcrypto_block_free(crypto);
-    qapi_free_QCryptoBlockCreateOptions(cryptoopts);
     return ret;
 }
 
@@ -2732,8 +2748,7 @@ static uint64_t qcow2_opt_get_refcount_bits_del(QemuOpts *opts, int version,
     return refcount_bits;
 }
 
-static int qcow2_create2(BlockdevCreateOptions *create_options,
-                         QemuOpts *opts, const char *encryptfmt, Error **errp)
+static int qcow2_create2(BlockdevCreateOptions *create_options, Error **errp)
 {
     BlockdevCreateOptionsQcow2 *qcow2_opts;
     QDict *options;
@@ -2963,8 +2978,8 @@ static int qcow2_create2(BlockdevCreateOptions *create_options,
     }
 
     /* Want encryption? There you go. */
-    if (encryptfmt) {
-        ret = qcow2_set_up_encryption(blk_bs(blk), encryptfmt, opts, errp);
+    if (qcow2_opts->has_encrypt) {
+        ret = qcow2_set_up_encryption(blk_bs(blk), qcow2_opts->encrypt, errp);
         if (ret < 0) {
             goto out;
         }
@@ -3021,6 +3036,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
     int version;
     uint64_t refcount_bits;
     char *encryptfmt = NULL;
+    QCryptoBlockCreateOptions *cryptoopts = NULL;
     BlockDriverState *bs = NULL;
     Error *local_err = NULL;
     int ret;
@@ -3037,6 +3053,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
         ret = -EINVAL;
         goto finish;
     }
+
     encryptfmt = qemu_opt_get_del(opts, BLOCK_OPT_ENCRYPT_FORMAT);
     if (encryptfmt) {
         if (qemu_opt_get(opts, BLOCK_OPT_ENCRYPT)) {
@@ -3048,6 +3065,14 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
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
@@ -3121,6 +3146,8 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
             .backing_file       = backing_file,
             .has_backing_fmt    = (backing_fmt != NULL),
             .backing_fmt        = backing_drv,
+            .has_encrypt        = (encryptfmt != NULL),
+            .encrypt            = cryptoopts,
             .has_cluster_size   = true,
             .cluster_size       = cluster_size,
             .has_preallocation  = true,
@@ -3131,7 +3158,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
             .refcount_bits      = refcount_bits,
         },
     };
-    ret = qcow2_create2(&create_options, opts, encryptfmt, errp);
+    ret = qcow2_create2(&create_options, errp);
     if (ret < 0) {
         goto finish;
     }
@@ -3139,6 +3166,7 @@ static int qcow2_create(const char *filename, QemuOpts *opts, Error **errp)
 finish:
     bdrv_unref(bs);
 
+    qapi_free_QCryptoBlockCreateOptions(cryptoopts);
     g_free(backing_file);
     g_free(backing_fmt);
     g_free(encryptfmt);
-- 
2.13.6
