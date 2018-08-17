Received: from eggs.gnu.org ([2001:4830:134:3::10]:58683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fqi9O-0002kC-Ef
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:03:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fqi9N-0002FX-OQ
	for qemu-devel@nongnu.org; Fri, 17 Aug 2018 13:03:02 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 17 Aug 2018 19:02:46 +0200
Message-Id: <20180817170246.14641-6-kwolf@redhat.com>
In-Reply-To: <20180817170246.14641-1-kwolf@redhat.com>
References: <20180817170246.14641-1-kwolf@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 5/5] [WIP] Lock AioContext in
 bdrv_co_drain_bh_cb()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org

Not sure if this is correct, but at least it makes qemu-iotests 127 pass
again.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/block/io.c b/block/io.c
index 832d2536bf..d3dde4d7fd 100644
--- a/block/io.c
+++ b/block/io.c
@@ -309,6 +309,10 @@ static void bdrv_co_drain_bh_cb(void *opaque)
     BdrvCoDrainData *data = opaque;
     Coroutine *co = data->co;
     BlockDriverState *bs = data->bs;
+    AioContext *ctx;
+
+    ctx = bdrv_get_aio_context(bs);
+    aio_context_acquire(ctx);
 
     if (bs) {
         bdrv_dec_in_flight(bs);
@@ -324,6 +328,8 @@ static void bdrv_co_drain_bh_cb(void *opaque)
         bdrv_drain_all_begin();
     }
 
+    aio_context_release(ctx);
+
     data->done = true;
     aio_co_wake(co);
 }
-- 
2.13.6
