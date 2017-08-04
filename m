Received: from eggs.gnu.org ([2001:4830:134:3::10]:33419)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddcai-0001eq-VT
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 09:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ddabU-0004FZ-VX
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:18:23 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  4 Aug 2017 11:51:36 +0100
Message-Id: <20170804105136.12061-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.10] block: use 1 MB bounce buffers for
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
Cc: qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Using 16KB bounce buffers creates a significant performance
penalty for I/O to encrypted volumes on storage with high
I/O latency (rotating rust & network drives), because it
triggers lots of fairly small I/O operations.

On tests with rotating rust, and cache=none|directsync,
write speed increased from 2MiB/s to 32MiB/s, on a par
with that achieved by the in-kernel luks driver.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 58ef6f2f52..207941db9a 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -379,7 +379,7 @@ static void block_crypto_close(BlockDriverState *bs)
 }
 
 
-#define BLOCK_CRYPTO_MAX_SECTORS 32
+#define BLOCK_CRYPTO_MAX_SECTORS 2048
 
 static coroutine_fn int
 block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
@@ -396,9 +396,8 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
-    /* Bounce buffer so we have a linear mem region for
-     * entire sector. XXX optimize so we avoid bounce
-     * buffer in case that qiov->niov == 1
+    /* Bounce buffer because we're not permitted to touch
+     * contents of qiov - it points to guest memory.
      */
     cipher_data =
         qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * 512,
@@ -464,9 +463,8 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
-    /* Bounce buffer so we have a linear mem region for
-     * entire sector. XXX optimize so we avoid bounce
-     * buffer in case that qiov->niov == 1
+    /* Bounce buffer because we're not permitted to touch
+     * contents of qiov - it points to guest memory.
      */
     cipher_data =
         qemu_try_blockalign(bs->file->bs, MIN(BLOCK_CRYPTO_MAX_SECTORS * 512,
-- 
2.13.3
