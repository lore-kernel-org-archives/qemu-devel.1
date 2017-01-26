Received: from eggs.gnu.org ([2001:4830:134:3::10]:45813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh9L-0001yo-P0
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWh9K-0006K4-4Q
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:27 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 26 Jan 2017 10:18:27 +0000
Message-Id: <20170126101827.22378-19-berrange@redhat.com>
In-Reply-To: <20170126101827.22378-1-berrange@redhat.com>
References: <20170126101827.22378-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 18/18] block: pass option prefix down to
 crypto layer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

While the crypto layer uses a fixed option name "key-secret",
the upper block layer may have a prefix on the options. e.g.
"luks-key-secret", "aes-key-secret", in order to avoid clashes
between crypto option names & other block option names. To
ensure the crypto layer can report accurate error messages,
we must tell it what option name prefix was used.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c         |  4 ++--
 block/qcow.c           |  7 ++++---
 block/qcow2.c          | 15 +++++++++------
 crypto/block-luks.c    |  8 ++++++--
 crypto/block-qcow.c    |  8 ++++++--
 crypto/block.c         |  6 ++++--
 crypto/blockpriv.h     |  2 ++
 include/crypto/block.h |  6 +++++-
 8 files changed, 38 insertions(+), 18 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 6d6bd90..22bc6ba 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -369,7 +369,7 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
     if (flags & BDRV_O_NO_IO) {
         cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
     }
-    crypto->block = qcrypto_block_open(open_opts,
+    crypto->block = qcrypto_block_open(open_opts, NULL,
                                        block_crypto_read_func,
                                        bs,
                                        cflags,
@@ -409,7 +409,7 @@ static int block_crypto_create_generic(QCryptoBlockFormat format,
         return -1;
     }
 
-    crypto = qcrypto_block_create(create_opts,
+    crypto = qcrypto_block_create(create_opts, NULL,
                                   block_crypto_init_func,
                                   block_crypto_write_func,
                                   &data,
diff --git a/block/qcow.c b/block/qcow.c
index cf05449..8047415 100644
--- a/block/qcow.c
+++ b/block/qcow.c
@@ -197,8 +197,8 @@ static int qcow_open(BlockDriverState *bs, QDict *options, int flags,
             if (flags & BDRV_O_NO_IO) {
                 cflags |= QCRYPTO_BLOCK_OPEN_NO_IO;
             }
-            s->crypto = qcrypto_block_open(crypto_opts, NULL, NULL,
-                                           cflags, errp);
+            s->crypto = qcrypto_block_open(crypto_opts, "aes-",
+                                           NULL, NULL, cflags, errp);
             if (!s->crypto) {
                 ret = -EINVAL;
                 goto fail;
@@ -819,7 +819,8 @@ static int qcow_create(const char *filename, QemuOpts *opts, Error **errp)
             goto exit;
         }
 
-        crypto = qcrypto_block_create(crypto_opts, NULL, NULL, NULL, errp);
+        crypto = qcrypto_block_create(crypto_opts, "aes-",
+                                      NULL, NULL, NULL, errp);
         if (!crypto) {
             ret = -EINVAL;
             goto exit;
diff --git a/block/qcow2.c b/block/qcow2.c
index 7c8e602..4f2da2f 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -284,7 +284,7 @@ static int qcow2_read_extensions(BlockDriverState *bs, uint64_t start_offset,
              * provide the same key-secret property against the full
              * backing chain
              */
-            s->crypto = qcrypto_block_open(s->crypto_opts,
+            s->crypto = qcrypto_block_open(s->crypto_opts, "luks-",
                                            qcow2_crypto_hdr_read_func,
                                            bs, cflags, errp);
             if (!s->crypto) {
@@ -1291,8 +1291,8 @@ static int qcow2_open(BlockDriverState *bs, QDict *options, int flags,
              * provide the same key-secret property against the full
              * backing chain
              */
-            s->crypto = qcrypto_block_open(s->crypto_opts, NULL, NULL,
-                                           cflags, errp);
+            s->crypto = qcrypto_block_open(s->crypto_opts, "aes-",
+                                           NULL, NULL, cflags, errp);
             if (!s->crypto) {
                 ret = -EINVAL;
                 goto fail;
@@ -2209,14 +2209,17 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, QemuOpts *opts,
     QCryptoBlockCreateOptions *cryptoopts = NULL;
     QCryptoBlock *crypto = NULL;
     int ret = -EINVAL;
+    const char *optprefix;
 
     if (g_str_equal(format, "luks")) {
+        optprefix = "luks-";
         cryptoopts = block_crypto_create_opts_init(
-            Q_CRYPTO_BLOCK_FORMAT_LUKS, opts, "luks-", errp);
+            Q_CRYPTO_BLOCK_FORMAT_LUKS, opts, optprefix, errp);
         s->crypt_method_header = QCOW_CRYPT_LUKS;
     } else if (g_str_equal(format, "aes")) {
+        optprefix = "aes-";
         cryptoopts = block_crypto_create_opts_init(
-            Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, "aes-", errp);
+            Q_CRYPTO_BLOCK_FORMAT_QCOW, opts, optprefix, errp);
         s->crypt_method_header = QCOW_CRYPT_AES;
     } else {
         error_setg(errp, "Unknown encryption format %s", format);
@@ -2228,7 +2231,7 @@ static int qcow2_set_up_encryption(BlockDriverState *bs, QemuOpts *opts,
         goto out;
     }
 
-    crypto = qcrypto_block_create(cryptoopts,
+    crypto = qcrypto_block_create(cryptoopts, optprefix,
                                   qcow2_crypto_hdr_init_func,
                                   qcow2_crypto_hdr_write_func,
                                   bs, errp);
diff --git a/crypto/block-luks.c b/crypto/block-luks.c
index 4530f82..4a4c4a0 100644
--- a/crypto/block-luks.c
+++ b/crypto/block-luks.c
@@ -638,6 +638,7 @@ qcrypto_block_luks_find_key(QCryptoBlock *block,
 static int
 qcrypto_block_luks_open(QCryptoBlock *block,
                         QCryptoBlockOpenOptions *options,
+                        const char *optprefix,
                         QCryptoBlockReadFunc readfunc,
                         void *opaque,
                         unsigned int flags,
@@ -661,7 +662,8 @@ qcrypto_block_luks_open(QCryptoBlock *block,
 
     if (!(flags & QCRYPTO_BLOCK_OPEN_NO_IO)) {
         if (!options->u.luks.key_secret) {
-            error_setg(errp, "Parameter 'key-secret' is required for cipher");
+            error_setg(errp, "Parameter '%skey-secret' is required for cipher",
+                       optprefix ? optprefix : "");
             return -1;
         }
         password = qcrypto_secret_lookup_as_utf8(
@@ -885,6 +887,7 @@ qcrypto_block_luks_uuid_gen(uint8_t *uuidstr)
 static int
 qcrypto_block_luks_create(QCryptoBlock *block,
                           QCryptoBlockCreateOptions *options,
+                          const char *optprefix,
                           QCryptoBlockInitFunc initfunc,
                           QCryptoBlockWriteFunc writefunc,
                           void *opaque,
@@ -937,7 +940,8 @@ qcrypto_block_luks_create(QCryptoBlock *block,
      * be silently ignored, for compatibility with dm-crypt */
 
     if (!options->u.luks.key_secret) {
-        error_setg(errp, "Parameter 'key-secret' is required for cipher");
+        error_setg(errp, "Parameter '%skey-secret' is required for cipher",
+                   optprefix ? optprefix : "");
         return -1;
     }
     password = qcrypto_secret_lookup_as_utf8(luks_opts.key_secret, errp);
diff --git a/crypto/block-qcow.c b/crypto/block-qcow.c
index be88c6f..a456fe3 100644
--- a/crypto/block-qcow.c
+++ b/crypto/block-qcow.c
@@ -94,6 +94,7 @@ qcrypto_block_qcow_init(QCryptoBlock *block,
 static int
 qcrypto_block_qcow_open(QCryptoBlock *block,
                         QCryptoBlockOpenOptions *options,
+                        const char *optprefix,
                         QCryptoBlockReadFunc readfunc G_GNUC_UNUSED,
                         void *opaque G_GNUC_UNUSED,
                         unsigned int flags,
@@ -104,7 +105,8 @@ qcrypto_block_qcow_open(QCryptoBlock *block,
     } else {
         if (!options->u.qcow.key_secret) {
             error_setg(errp,
-                       "Parameter 'key-secret' is required for cipher");
+                       "Parameter '%skey-secret' is required for cipher",
+                       optprefix ? optprefix : "");
             return -1;
         }
         return qcrypto_block_qcow_init(block,
@@ -116,13 +118,15 @@ qcrypto_block_qcow_open(QCryptoBlock *block,
 static int
 qcrypto_block_qcow_create(QCryptoBlock *block,
                           QCryptoBlockCreateOptions *options,
+                          const char *optprefix,
                           QCryptoBlockInitFunc initfunc G_GNUC_UNUSED,
                           QCryptoBlockWriteFunc writefunc G_GNUC_UNUSED,
                           void *opaque G_GNUC_UNUSED,
                           Error **errp)
 {
     if (!options->u.qcow.key_secret) {
-        error_setg(errp, "Parameter 'key-secret' is required for cipher");
+        error_setg(errp, "Parameter '%skey-secret' is required for cipher",
+                   optprefix ? optprefix : "");
         return -1;
     }
     /* QCow2 has no special header, since everything is hardwired */
diff --git a/crypto/block.c b/crypto/block.c
index 64c8420..b097d45 100644
--- a/crypto/block.c
+++ b/crypto/block.c
@@ -48,6 +48,7 @@ bool qcrypto_block_has_format(QCryptoBlockFormat format,
 
 
 QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
+                                 const char *optprefix,
                                  QCryptoBlockReadFunc readfunc,
                                  void *opaque,
                                  unsigned int flags,
@@ -67,7 +68,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
 
     block->driver = qcrypto_block_drivers[options->format];
 
-    if (block->driver->open(block, options,
+    if (block->driver->open(block, options, optprefix,
                             readfunc, opaque, flags, errp) < 0) {
         g_free(block);
         return NULL;
@@ -78,6 +79,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
 
 
 QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
+                                   const char *optprefix,
                                    QCryptoBlockInitFunc initfunc,
                                    QCryptoBlockWriteFunc writefunc,
                                    void *opaque,
@@ -97,7 +99,7 @@ QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
 
     block->driver = qcrypto_block_drivers[options->format];
 
-    if (block->driver->create(block, options, initfunc,
+    if (block->driver->create(block, options, optprefix, initfunc,
                               writefunc, opaque, errp) < 0) {
         g_free(block);
         return NULL;
diff --git a/crypto/blockpriv.h b/crypto/blockpriv.h
index 68f0f06..0edb810 100644
--- a/crypto/blockpriv.h
+++ b/crypto/blockpriv.h
@@ -41,6 +41,7 @@ struct QCryptoBlock {
 struct QCryptoBlockDriver {
     int (*open)(QCryptoBlock *block,
                 QCryptoBlockOpenOptions *options,
+                const char *optprefix,
                 QCryptoBlockReadFunc readfunc,
                 void *opaque,
                 unsigned int flags,
@@ -48,6 +49,7 @@ struct QCryptoBlockDriver {
 
     int (*create)(QCryptoBlock *block,
                   QCryptoBlockCreateOptions *options,
+                  const char *optprefix,
                   QCryptoBlockInitFunc initfunc,
                   QCryptoBlockWriteFunc writefunc,
                   void *opaque,
diff --git a/include/crypto/block.h b/include/crypto/block.h
index b6971de..c0c202a 100644
--- a/include/crypto/block.h
+++ b/include/crypto/block.h
@@ -71,6 +71,7 @@ typedef enum {
 /**
  * qcrypto_block_open:
  * @options: the encryption options
+ * @optprefix: name prefix for options
  * @readfunc: callback for reading data from the volume
  * @opaque: data to pass to @readfunc
  * @flags: bitmask of QCryptoBlockOpenFlags values
@@ -102,6 +103,7 @@ typedef enum {
  * Returns: a block encryption format, or NULL on error
  */
 QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
+                                 const char *optprefix,
                                  QCryptoBlockReadFunc readfunc,
                                  void *opaque,
                                  unsigned int flags,
@@ -109,7 +111,8 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
 
 /**
  * qcrypto_block_create:
- * @format: the encryption format
+ * @options: the encryption options
+ * @optprefix: name prefix for options
  * @initfunc: callback for initializing volume header
  * @writefunc: callback for writing data to the volume header
  * @opaque: data to pass to @initfunc and @writefunc
@@ -133,6 +136,7 @@ QCryptoBlock *qcrypto_block_open(QCryptoBlockOpenOptions *options,
  * Returns: a block encryption format, or NULL on error
  */
 QCryptoBlock *qcrypto_block_create(QCryptoBlockCreateOptions *options,
+                                   const char *optprefix,
                                    QCryptoBlockInitFunc initfunc,
                                    QCryptoBlockWriteFunc writefunc,
                                    void *opaque,
-- 
2.9.3
