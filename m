Received: from eggs.gnu.org ([2001:4830:134:3::10]:56868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uyk-0001YE-TP
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1e0Uyh-0004X8-0H
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 11:55:58 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  6 Oct 2017 17:54:22 +0200
Message-Id: <20171006155422.10135-55-kwolf@redhat.com>
In-Reply-To: <20171006155422.10135-1-kwolf@redhat.com>
References: <20171006155422.10135-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 54/54] block/mirror: check backing in
 bdrv_mirror_top_flush
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Backing may be zero after failed bdrv_append in mirror_start_job,
which leads to SIGSEGV.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20170929152255.5431-1-vsementsov@virtuozzo.com
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 block/mirror.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 3b6f0c5772..153758ca9f 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1041,6 +1041,10 @@ static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
 
 static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
 {
+    if (bs->backing == NULL) {
+        /* we can be here after failed bdrv_append in mirror_start_job */
+        return 0;
+    }
     return bdrv_co_flush(bs->backing->bs);
 }
 
-- 
2.13.6
