Received: from eggs.gnu.org ([2001:4830:134:3::10]:33115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkk-0000oY-3C
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1euKkh-0006Vy-HY
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 11:20:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  9 Mar 2018 17:18:38 +0100
Message-Id: <20180309161933.8168-2-kwolf@redhat.com>
In-Reply-To: <20180309161933.8168-1-kwolf@redhat.com>
References: <20180309161933.8168-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 01/56] block: implement the bdrv_reopen_prepare
 helper for LUKS driver
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

If the bdrv_reopen_prepare helper isn't provided, the qemu-img commit
command fails to re-open the base layer after committing changes into
it. Provide a no-op implementation for the LUKS driver, since there
is not any custom work that needs doing to re-open it.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/crypto.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block/crypto.c b/block/crypto.c
index 17b5c0abad..e6095e7807 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -384,6 +384,12 @@ static void block_crypto_close(BlockDriverState *bs)
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
@@ -621,6 +627,7 @@ BlockDriver bdrv_crypto_luks = {
     .bdrv_truncate      = block_crypto_truncate,
     .create_opts        = &block_crypto_create_opts_luks,
 
+    .bdrv_reopen_prepare = block_crypto_reopen_prepare,
     .bdrv_refresh_limits = block_crypto_refresh_limits,
     .bdrv_co_preadv     = block_crypto_co_preadv,
     .bdrv_co_pwritev    = block_crypto_co_pwritev,
-- 
2.13.6
