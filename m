Received: from eggs.gnu.org ([209.51.188.92]:51084)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP5-0000nl-Mt
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIaP4-00038F-M4
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 10:58:43 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 17:58:37 +0300
Message-Id: <20190422145838.70903-9-vsementsov@virtuozzo.com>
In-Reply-To: <20190422145838.70903-1-vsementsov@virtuozzo.com>
References: <20190422145838.70903-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 8/9] block/stream: use buffer-based io
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
 block/stream.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index bfaebb861a..1a906fd860 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -42,12 +42,10 @@ static int coroutine_fn stream_populate(BlockBackend *blk,
                                         int64_t offset, uint64_t bytes,
                                         void *buf)
 {
-    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, bytes);
-
     assert(bytes < SIZE_MAX);
 
     /* Copy-on-read the unallocated clusters */
-    return blk_co_preadv(blk, offset, qiov.size, &qiov, BDRV_REQ_COPY_ON_READ);
+    return blk_co_pread(blk, offset, bytes, buf, BDRV_REQ_COPY_ON_READ);
 }
 
 static void stream_abort(Job *job)
-- 
2.18.0
