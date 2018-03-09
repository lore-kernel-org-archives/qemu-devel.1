Received: from eggs.gnu.org ([2001:4830:134:3::10]:60080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLnm-0000pY-MU
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLnl-0006d0-Ok
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 18:27:09 +0100
Message-Id: <20180309172713.26318-3-kwolf@redhat.com>
In-Reply-To: <20180309172713.26318-1-kwolf@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 2/6] luks: Create
 block_crypto_co_create_generic()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

Everything that refers to the protocol layer or QemuOpts is moved out of
block_crypto_create_generic(), so that the remaining function is
suitable to be called by a .bdrv_co_create implementation.

LUKS is the only driver that actually implements the old interface, and
we don't intend to use it in any new drivers, so put the moved out code
directly into a LUKS function rather than creating a generic
intermediate one.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/crypto.c | 95 +++++++++++++++++++++++++++++++++++++---------------------
 1 file changed, 61 insertions(+), 34 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 77871640cc..b0a4cb3388 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -306,43 +306,29 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
 }
 
 
-static int block_crypto_create_generic(QCryptoBlockFormat format,
-                                       const char *filename,
-                                       QemuOpts *opts,
-                                       Error **errp)
+static int block_crypto_co_create_generic(BlockDriverState *bs,
+                                          int64_t size,
+                                          QCryptoBlockCreateOptions *opts,
+                                          Error **errp)
 {
-    int ret = -EINVAL;
-    QCryptoBlockCreateOptions *create_opts = NULL;
+    int ret;
+    BlockBackend *blk;
     QCryptoBlock *crypto = NULL;
-    struct BlockCryptoCreateData data = {
-        .size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
-                         BDRV_SECTOR_SIZE),
-    };
-    QDict *cryptoopts;
-
-    /* Parse options */
-    cryptoopts = qemu_opts_to_qdict(opts, NULL);
+    struct BlockCryptoCreateData data;
 
-    create_opts = block_crypto_create_opts_init(format, cryptoopts, errp);
-    if (!create_opts) {
-        return -1;
-    }
+    blk = blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
 
-    /* Create protocol layer */
-    ret = bdrv_create_file(filename, opts, errp);
+    ret = blk_insert_bs(blk, bs, errp);
     if (ret < 0) {
-        return ret;
+        goto cleanup;
     }
 
-    data.blk = blk_new_open(filename, NULL, NULL,
-                            BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
-                            errp);
-    if (!data.blk) {
-        return -EINVAL;
-    }
+    data = (struct BlockCryptoCreateData) {
+        .blk = blk,
+        .size = size,
+    };
 
-    /* Create format layer */
-    crypto = qcrypto_block_create(create_opts, NULL,
+    crypto = qcrypto_block_create(opts, NULL,
                                   block_crypto_init_func,
                                   block_crypto_write_func,
                                   &data,
@@ -355,10 +341,8 @@ static int block_crypto_create_generic(QCryptoBlockFormat format,
 
     ret = 0;
  cleanup:
-    QDECREF(cryptoopts);
     qcrypto_block_free(crypto);
-    blk_unref(data.blk);
-    qapi_free_QCryptoBlockCreateOptions(create_opts);
+    blk_unref(blk);
     return ret;
 }
 
@@ -563,8 +547,51 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
                                                          QemuOpts *opts,
                                                          Error **errp)
 {
-    return block_crypto_create_generic(Q_CRYPTO_BLOCK_FORMAT_LUKS,
-                                       filename, opts, errp);
+    QCryptoBlockCreateOptions *create_opts = NULL;
+    BlockDriverState *bs = NULL;
+    QDict *cryptoopts;
+    int64_t size;
+    int ret;
+
+    /* Parse options */
+    size = qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0);
+
+    cryptoopts = qemu_opts_to_qdict_filtered(opts, NULL,
+                                             &block_crypto_create_opts_luks,
+                                             true);
+
+    create_opts = block_crypto_create_opts_init(Q_CRYPTO_BLOCK_FORMAT_LUKS,
+                                                cryptoopts, errp);
+    if (!create_opts) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    /* Create protocol layer */
+    ret = bdrv_create_file(filename, opts, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    bs = bdrv_open(filename, NULL, NULL,
+                   BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL, errp);
+    if (!bs) {
+        ret = -EINVAL;
+        goto fail;
+    }
+
+    /* Create format layer */
+    ret = block_crypto_co_create_generic(bs, size, create_opts, errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
+    ret = 0;
+fail:
+    bdrv_unref(bs);
+    qapi_free_QCryptoBlockCreateOptions(create_opts);
+    QDECREF(cryptoopts);
+    return ret;
 }
 
 static int block_crypto_get_info_luks(BlockDriverState *bs,
-- 
2.13.6
