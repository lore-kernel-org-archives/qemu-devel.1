Received: from eggs.gnu.org ([209.51.188.92]:51134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP6-0000ns-Ko
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-00038k-ON
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:44 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 17:58:36 +0300
Message-Id: <20190422145838.70903-8-vsementsov@virtuozzo.com>
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 7/9] block/commit: use buffer-based io
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: jsnow@redhat.com, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, vsementsov@virtuozzo.com

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/commit.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/commit.c b/block/commit.c
index ba60fef58a..08204fa6f8 100644
--- a/block/commit.c
+++ b/block/commit.c
@@ -48,16 +48,15 @@ static int coroutine_fn commit_populate(BlockBackend *bs, BlockBackend *base,
                                         void *buf)
 {
     int ret = 0;
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
 
     assert(bytes < SIZE_MAX);
 
-    ret = blk_co_preadv(bs, offset, qiov.size, &qiov, 0);
+    ret = blk_co_pread(bs, offset, bytes, buf, 0);
     if (ret < 0) {
         return ret;
     }
 
-    ret = blk_co_pwritev(base, offset, qiov.size, &qiov, 0);
+    ret = blk_co_pwrite(base, offset, bytes, buf, 0);
     if (ret < 0) {
         return ret;
     }
-- 
2.18.0
