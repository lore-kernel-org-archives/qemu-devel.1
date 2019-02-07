Received: from eggs.gnu.org ([209.51.188.92]:36654)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrb-0002iW-JV
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgra-0001k1-8F
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:24:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:31 +0300
Message-Id: <20190207102445.71998-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 03/17] block/block-backend: use
 QEMU_IOVEC_INIT_BUF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: dgilbert@redhat.com, quintela@redhat.com, jsnow@redhat.com, den@openvz.org, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, vsementsov@virtuozzo.com

Use new QEMU_IOVEC_INIT_BUF() instead of
qemu_iovec_init_external( ... , 1), which simplifies the code.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/block-backend.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index f6ea824308..6cc25569ef 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1204,17 +1204,8 @@ static int blk_prw(BlockBackend *blk, int64_t offset, uint8_t *buf,
                    int64_t bytes, CoroutineEntry co_entry,
                    BdrvRequestFlags flags)
 {
-    QEMUIOVector qiov;
-    struct iovec iov;
-    BlkRwCo rwco;
-
-    iov = (struct iovec) {
-        .iov_base = buf,
-        .iov_len = bytes,
-    };
-    qemu_iovec_init_external(&qiov, &iov, 1);
-
-    rwco = (BlkRwCo) {
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
+    BlkRwCo rwco = {
         .blk    = blk,
         .offset = offset,
         .iobuf  = &qiov,
-- 
2.18.0
