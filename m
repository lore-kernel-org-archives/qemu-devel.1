Received: from eggs.gnu.org ([2001:4830:134:3::10]:49930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBqi-0004I2-Ac
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:54:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBqe-0001Qr-Cf
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:54:00 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 27 Sep 2017 13:53:35 +0100
Message-Id: <20170927125340.12360-2-berrange@redhat.com>
In-Reply-To: <20170927125340.12360-1-berrange@redhat.com>
References: <20170927125340.12360-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 1/6] block: use 1 MB bounce buffers for
 crypto instead of 16KB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, "Daniel P. Berrange" <berrange@redhat.com>

Using 16KB bounce buffers creates a significant performance
penalty for I/O to encrypted volumes on storage which high
I/O latency (rotating rust & network drives), because it
triggers lots of fairly small I/O operations.

On tests with rotating rust, and cache=none|directsync,
write speed increased from 2MiB/s to 32MiB/s, on a par
with that achieved by the in-kernel luks driver. With
other cache modes the in-kernel driver is still notably
faster because it is able to report completion of the
I/O request before any encryption is done, while the
in-QEMU driver must encrypt the data before completion.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 58ef6f2f52..684cabeaf8 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -379,7 +379,11 @@ static void block_crypto_close(BlockDriverState *bs)
 }
 
 
-#define BLOCK_CRYPTO_MAX_SECTORS 32
+/*
+ * 1 MB bounce buffer gives good performance / memory tradeoff
+ * when using cache=none|directsync.
+ */
+#define BLOCK_CRYPTO_MAX_IO_SIZE (1024 * 1024)
 
 static coroutine_fn int
 block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
@@ -396,12 +400,11 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
-    /* Bounce buffer so we have a linear mem region for
-     * entire sector. XXX optimize so we avoid bounce
-     * buffer in case that qiov->niov == 1
+    /* Bounce buffer because we don't wish to expose cipher text
+     * in qiov which points to guest memory.
      */
     cipher_data =
-        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * 512,
+        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_IO_SIZE,
                                               qiov->size));
     if (cipher_data == NULL) {
         ret = -ENOMEM;
@@ -411,8 +414,8 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
     while (remaining_sectors) {
         cur_nr_sectors = remaining_sectors;
 
-        if (cur_nr_sectors > BLOCK_CRYPTO_MAX_SECTORS) {
-            cur_nr_sectors = BLOCK_CRYPTO_MAX_SECTORS;
+        if (cur_nr_sectors > (BLOCK_CRYPTO_MAX_IO_SIZE / 512)) {
+            cur_nr_sectors = (BLOCK_CRYPTO_MAX_IO_SIZE / 512);
         }
 
         qemu_iovec_reset(&hd_qiov);
@@ -464,12 +467,11 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
-    /* Bounce buffer so we have a linear mem region for
-     * entire sector. XXX optimize so we avoid bounce
-     * buffer in case that qiov->niov == 1
+    /* Bounce buffer because we're not permitted to touch
+     * contents of qiov - it points to guest memory.
      */
     cipher_data =
-        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * 512,
+        qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_IO_SIZE,
                                               qiov->size));
     if (cipher_data == NULL) {
         ret = -ENOMEM;
@@ -479,8 +481,8 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
     while (remaining_sectors) {
         cur_nr_sectors = remaining_sectors;
 
-        if (cur_nr_sectors > BLOCK_CRYPTO_MAX_SECTORS) {
-            cur_nr_sectors = BLOCK_CRYPTO_MAX_SECTORS;
+        if (cur_nr_sectors > (BLOCK_CRYPTO_MAX_IO_SIZE / 512)) {
+            cur_nr_sectors = (BLOCK_CRYPTO_MAX_IO_SIZE / 512);
         }
 
         qemu_iovec_to_buf(qiov, bytes_done,
-- 
2.13.5
