Received: from eggs.gnu.org ([2001:4830:134:3::10]:34321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ec7UL-0002J2-F9
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ec7UH-0000JO-I4
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 05:32:05 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Thu, 18 Jan 2018 10:31:43 +0000
Message-Id: <20180118103143.11780-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH] block: implement the bdrv_reopen_prepare
 helper for LUKS driver
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

If the bdrv_reopen_prepare helper isn't provided, the qemu-img commit
command fails to re-open the base layer after committing changes into
it. Provide a no-op implementation for the LUKS driver, since there
is not any custom work that needs doing to re-open it.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 block/crypto.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 60ddf8623e..bb9a8f5376 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -382,6 +382,12 @@ static void block_crypto_close(BlockDriverState *bs)
     qcrypto_block_free(crypto->block);
 }
 
+static int block_crypto_reopen_prepare(BDRVReopenState *state,
+                                       BlockReopenQueue *queue, Error **errp)
+{
+    /* nothing needs checking */
+    return 0;
+}
 
 /*
  * 1 MB bounce buffer gives good performance / memory tradeoff
@@ -620,6 +626,7 @@ BlockDriver bdrv_crypto_luks = {
     .bdrv_truncate      = block_crypto_truncate,
     .create_opts        = &block_crypto_create_opts_luks,
 
+    .bdrv_reopen_prepare = block_crypto_reopen_prepare,
     .bdrv_refresh_limits = block_crypto_refresh_limits,
     .bdrv_co_preadv     = block_crypto_co_preadv,
     .bdrv_co_pwritev    = block_crypto_co_pwritev,
-- 
2.14.3
