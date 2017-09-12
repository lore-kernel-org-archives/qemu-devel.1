Received: from eggs.gnu.org ([2001:4830:134:3::10]:53900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drjNW-00036N-5F
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:29:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1drjNV-0004Ug-AP
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:29:18 -0400
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 12 Sep 2017 12:28:55 +0100
Message-Id: <20170912112855.24269-8-berrange@redhat.com>
In-Reply-To: <20170912112855.24269-1-berrange@redhat.com>
References: <20170912112855.24269-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 7/7] block: support passthrough of
 BDRV_REQ_FUA in crypto driver
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

The BDRV_REQ_FUA flag can trivially be allowed in the crypt driver
as a passthrough to the underlying block driver.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/crypto.c b/block/crypto.c
index 1f77095336..d1c28d62c1 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -279,6 +279,9 @@ static int block_crypto_open_generic(QCryptoBlockFormat format,
         return -EINVAL;
     }
 
+    bs->supported_write_flags = BDRV_REQ_FUA &
+        bs->file->bs->supported_write_flags;
+
     opts = qemu_opts_create(opts_spec, NULL, 0, &error_abort);
     qemu_opts_absorb_qdict(opts, options, &local_err);
     if (local_err) {
@@ -462,7 +465,7 @@ block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
     uint64_t sector_size = qcrypto_block_get_sector_size(crypto->block);
     uint64_t payload_offset = qcrypto_block_get_payload_offset(crypto->block);
 
-    assert(!flags);
+    assert(!(flags & ~BDRV_REQ_FUA));
     assert(payload_offset < INT64_MAX);
     assert(QEMU_IS_ALIGNED(offset, sector_size));
     assert(QEMU_IS_ALIGNED(bytes, sector_size));
@@ -499,7 +502,7 @@ block_crypto_co_pwritev(BlockDriverState *bs, uint64_t offset, uint64_t bytes,
         qemu_iovec_add(&hd_qiov, cipher_data, cur_bytes);
 
         ret = bdrv_co_pwritev(bs->file, payload_offset + offset + bytes_done,
-                              cur_bytes, &hd_qiov, 0);
+                              cur_bytes, &hd_qiov, flags);
         if (ret < 0) {
             goto cleanup;
         }
-- 
2.13.5
