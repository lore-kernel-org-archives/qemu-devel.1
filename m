Received: from eggs.gnu.org ([2001:4830:134:3::10]:56555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UyT-0001E3-Ao
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0UyS-00048y-3U
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:41 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:54:12 +0200
Message-Id: <20171006155422.10135-45-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 44/54] block: use 1 MB bounce buffers for crypto
 instead of 16KB
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

From: "Daniel P. Berrange" <berrange@redhat.com>

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
Message-id: 20170927125340.12360-2-berrange@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
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
2.13.6
