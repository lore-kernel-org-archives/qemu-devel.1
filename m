Received: from eggs.gnu.org ([2001:4830:134:3::10]:53421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dxx88-0007I0-Qz
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 11:23:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dxx85-0006nM-Md
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 11:23:08 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Fri, 29 Sep 2017 18:22:55 +0300
Message-Id: <20170929152255.5431-1-vsementsov@virtuozzo.com>
In-Reply-To: <20170928120300.58164-1-vsementsov@virtuozzo.com>
References: <20170928120300.58164-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block/mirror: check backing in
 bdrv_mirror_top_flush
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, jcody@redhat.com, eblake@redhat.com, qemu-stable@nongnu.org
List-ID: <qemu-devel.nongnu.org>

Backing may be zero after failed bdrv_append in mirror_start_job,
which leads to SIGSEGV.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

similar SIGSEGV.
looks like (I guess by code, don't have full back-trace because of
coroutine switch on bdrv_flush):
mirror_start_job,
  bdrv_append failed, backing is not set 
  bdrv_unref
    bdrv_delete
      bdrv_close
        bdrv_flush
         ...
         bdrv_mirror_top_flush 
           Segmentation fault on
           return bdrv_co_flush(bs->backing->bs);
           as bs->backing = 0

 block/mirror.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/mirror.c b/block/mirror.c
index 6f5cb9f26c..f17c0d8726 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1056,6 +1056,10 @@ static int coroutine_fn bdrv_mirror_top_pwritev(BlockDriverState *bs,
 
 static int coroutine_fn bdrv_mirror_top_flush(BlockDriverState *bs)
 {
+    if (bs->backing == NULL) {
+        /* we can be here after failed bdrv_append in mirror_start_job */
+        return 0;
+    }
     return bdrv_co_flush(bs->backing->bs);
 }
 
-- 
2.11.1
