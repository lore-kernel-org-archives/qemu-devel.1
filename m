Received: from eggs.gnu.org ([2001:4830:134:3::10]:53811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drjNQ-0002zU-Ly
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drjNP-0004RQ-Ii
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:29:12 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 12:28:49 +0100
Message-Id: <20170912112855.24269-2-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-1-berrange@redhat.com>
References: <20170912112855.24269-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 1/7] block: use 1 MB bounce buffers for
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

Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 58ef6f2f52..cc8afe0e0d 100644
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
+    /* Bounce buffer because we don't wish to expose cipher text
+     * in qiov which points to guest memory.
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
2.13.5
