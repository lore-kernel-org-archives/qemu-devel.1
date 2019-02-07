Received: from eggs.gnu.org ([209.51.188.92]:36661)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgrc-0002iY-3G
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:25:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1grgra-0001kD-Ar
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 05:24:59 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu,  7 Feb 2019 13:24:34 +0300
Message-Id: <20190207102445.71998-7-vsementsov@virtuozzo.com>
In-Reply-To: <20190207102445.71998-1-vsementsov@virtuozzo.com>
References: <20190207102445.71998-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 06/17] block/stream: use QEMU_IOVEC_INIT_BUF
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
 block/stream.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 7a49ac0992..e14579ff80 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -41,14 +41,9 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
                                         int64_t offset, uint64_t bytes,
                                         void *buf)
 {
-    struct iovec iov = {
-        .iov_base = buf,
-        .iov_len  = bytes,
-    };
-    QEMUIOVector qiov;
+    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
     assert(bytes < SIZE_MAX);
-    qemu_iovec_init_external(&qiov, &iov, 1);
 
     /* Copy-on-read the unallocated clusters */
     return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
-- 
2.18.0
