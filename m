Received: from eggs.gnu.org ([2001:4830:134:3::10]:45993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eddMC-00050k-2X
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:45:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1eddM9-0007so-Ga
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 09:45:56 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Jan 2018 17:45:49 +0300
Message-Id: <20180122144549.25318-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [RFC] block-backend: fix double inc/dec inflight
 requests number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

blk_co_preadv and blk_co_pwritev calls bdrv_inc_in_flight and
bdrv_dec_in_flight. But they calls correspondingly bdrv_co_preadv
and bdrv_co_pwritev, which inc/dec in-flight count by themselves.
Counting in-flight requests in blk_ layer is redundant, drop it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

Is it a bug or a feature? Why do we call inc/dec twice for read/write?
We don't do this for flush and discard..

(patch is called RFC, but it may be applied as is, if it is OK)

 block/block-backend.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index baef8e7abc..8219f59d93 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1094,17 +1094,13 @@ int coroutine_fn blk_co_preadv(BlockBackend *blk, int64_t offset,
         return ret;
     }
 
-    bdrv_inc_in_flight(bs);
-
     /* throttling disk I/O */
     if (blk->public.throttle_group_member.throttle_state) {
         throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
                 bytes, false);
     }
 
-    ret = bdrv_co_preadv(blk->root, offset, bytes, qiov, flags);
-    bdrv_dec_in_flight(bs);
-    return ret;
+    return bdrv_co_preadv(blk->root, offset, bytes, qiov, flags);
 }
 
 int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
@@ -1121,7 +1117,6 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
         return ret;
     }
 
-    bdrv_inc_in_flight(bs);
     /* throttling disk I/O */
     if (blk->public.throttle_group_member.throttle_state) {
         throttle_group_co_io_limits_intercept(&blk->public.throttle_group_member,
@@ -1132,9 +1127,7 @@ int coroutine_fn blk_co_pwritev(BlockBackend *blk, int64_t offset,
         flags |= BDRV_REQ_FUA;
     }
 
-    ret = bdrv_co_pwritev(blk->root, offset, bytes, qiov, flags);
-    bdrv_dec_in_flight(bs);
-    return ret;
+    return bdrv_co_pwritev(blk->root, offset, bytes, qiov, flags);
 }
 
 typedef struct BlkRwCo {
-- 
2.11.1
