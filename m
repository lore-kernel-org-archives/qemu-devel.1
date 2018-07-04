Received: from eggs.gnu.org ([2001:4830:134:3::10]:48595)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fahMR-0005wq-Ca
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:58:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fahMQ-0004ZY-MW
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 08:58:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  4 Jul 2018 14:58:02 +0200
Message-Id: <20180704125802.26394-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH] block/crypto: Fix memory leak in create error
 path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Fixes: Coverity CID 1393782
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/crypto.c b/block/crypto.c
index 994172a3de..146d81c90a 100644
--- a/block/crypto.c
+++ b/block/crypto.c
@@ -551,7 +551,7 @@ static int coroutine_fn block_crypto_co_create_opts_luks(const char *filename,
     /* Create protocol layer */
     ret = bdrv_create_file(filename, opts, errp);
     if (ret < 0) {
-        return ret;
+        goto fail;
     }
 
     bs = bdrv_open(filename, NULL, NULL,
-- 
2.13.6
