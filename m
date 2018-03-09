Received: from eggs.gnu.org ([2001:4830:134:3::10]:60078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLnm-0000pX-MT
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euLnl-0006cv-Om
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 12:27:30 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 18:27:08 +0100
Message-Id: <20180309172713.26318-2-kwolf@redhat.com>
In-Reply-To: <20180309172713.26318-1-kwolf@redhat.com>
References: <20180309172713.26318-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 1/6] luks: Separate image file creation from
 formatting
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

The crypto driver used to create the image file in a callback from the
crypto subsystem. If we want to implement .bdrv_co_create, this needs to
go away because that callback will get a reference to an already
existing block node.

Move the image file creation to block_crypto_create_generic().

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/crypto.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index e6095e7807..77871640cc 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -71,8 +71,6 @@ static ssize_t block_crypto_read_func(QCryptoBlock *block,
 
 
 struct BlockCryptoCreateData {
-    const char *filename;
-    QemuOpts *opts;
     BlockBackend *blk;
     uint64_t size;
 };
@@ -103,27 +101,13 @@ static ssize_t block_crypto_init_func(QCryptoBlock *block,
                                       Error **errp)
 {
     struct BlockCryptoCreateData *data = opaque;
-    int ret;
 
     /* User provided size should reflect amount of space made
      * available to the guest, so we must take account of that
      * which will be used by the crypto header
      */
-    data->size += headerlen;
-
-    qemu_opt_set_number(data->opts, BLOCK_OPT_SIZE, data->size, &error_abort);
-    ret = bdrv_create_file(data->filename, data->opts, errp);
-    if (ret < 0) {
-        return -1;
-    }
-
-    data->blk = blk_new_open(data->filename, NULL, NULL,
-                             BDRV_O_RDWR | BDRV_O_PROTOCOL, errp);
-    if (!data->blk) {
-        return -1;
-    }
-
-    return 0;
+    return blk_truncate(data->blk, data->size + headerlen, PREALLOC_MODE_OFF,
+                        errp);
 }
 
 
@@ -333,11 +317,10 @@ static int block_crypto_create_generic(QCryptoBlockFormat format,
     struct BlockCryptoCreateData data = {
         .size = ROUND_UP(qemu_opt_get_size_del(opts, BLOCK_OPT_SIZE, 0),
                          BDRV_SECTOR_SIZE),
-        .opts = opts,
-        .filename = filename,
     };
     QDict *cryptoopts;
 
+    /* Parse options */
     cryptoopts = qemu_opts_to_qdict(opts, NULL);
 
     create_opts = block_crypto_create_opts_init(format, cryptoopts, errp);
@@ -345,6 +328,20 @@ static int block_crypto_create_generic(QCryptoBlockFormat format,
         return -1;
     }
 
+    /* Create protocol layer */
+    ret = bdrv_create_file(filename, opts, errp);
+    if (ret < 0) {
+        return ret;
+    }
+
+    data.blk = blk_new_open(filename, NULL, NULL,
+                            BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
+                            errp);
+    if (!data.blk) {
+        return -EINVAL;
+    }
+
+    /* Create format layer */
     crypto = qcrypto_block_create(create_opts, NULL,
                                   block_crypto_init_func,
                                   block_crypto_write_func,
-- 
2.13.6
