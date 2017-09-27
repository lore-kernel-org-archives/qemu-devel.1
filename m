Received: from eggs.gnu.org ([2001:4830:134:3::10]:50087)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBqx-0004V8-Jk
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:54:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1dxBqr-0001aU-JQ
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 08:54:15 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 27 Sep 2017 13:53:37 +0100
Message-Id: <20170927125340.12360-4-berrange@redhat.com>
In-Reply-To: <20170927125340.12360-1-berrange@redhat.com>
References: <20170927125340.12360-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 3/6] block: fix data type casting for crypto
 payload offset
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

The crypto APIs report the offset of the data payload as an uint64_t
type, but the block driver is casting to size_t or ssize_t which will
potentially truncate.

Most of the block APIs use int64_t for offsets meanwhile, so even if
using uint64_t in the crypto block driver we are still at risk of
truncation.

Change the block crypto driver to use uint64_t, but add asserts that
the value is less than INT64_MAX.

Reviewed-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 684cabeaf8..61f5d77bc0 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -364,8 +364,9 @@ static int block_crypto_truncate(BlockDriverState *bs, int64_t offset,
                                  PreallocMode prealloc, Error **errp)
 {
     BlockCrypto *crypto = bs->opaque;
-    size_t payload_offset =
+    uint64_t payload_offset =
         qcrypto_block_get_payload_offset(crypto->block);
+    assert(payload_offset < (INT64_MAX - offset));
 
     offset += payload_offset;
 
@@ -395,8 +396,9 @@ block_crypto_co_readv(BlockDriverState *bs, int64_t sector_num,
     uint8_t *cipher_data = NULL;
     QEMUIOVector hd_qiov;
     int ret = 0;
-    size_t payload_offset =
+    uint64_t payload_offset =
         qcrypto_block_get_payload_offset(crypto->block) / 512;
+    assert(payload_offset < (INT64_MAX / 512));
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
@@ -462,8 +464,9 @@ block_crypto_co_writev(BlockDriverState *bs, int64_t sector_num,
     uint8_t *cipher_data = NULL;
     QEMUIOVector hd_qiov;
     int ret = 0;
-    size_t payload_offset =
+    uint64_t payload_offset =
         qcrypto_block_get_payload_offset(crypto->block) / 512;
+    assert(payload_offset < (INT64_MAX / 512));
 
     qemu_iovec_init(&hd_qiov, qiov->niov);
 
@@ -524,7 +527,9 @@ static int64_t block_crypto_getlength(BlockDriverState *bs)
     BlockCrypto *crypto = bs->opaque;
     int64_t len = bdrv_getlength(bs->file->bs);
 
-    ssize_t offset = qcrypto_block_get_payload_offset(crypto->block);
+    uint64_t offset = qcrypto_block_get_payload_offset(crypto->block);
+    assert(offset < INT64_MAX);
+    assert(offset < len);
 
     len -= offset;
 
-- 
2.13.5
