Received: from eggs.gnu.org ([2001:4830:134:3::10]:59965)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfkLh-0006ky-0D
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:33:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cfkLg-0007D4-AP
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:33:37 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34304)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cfkLg-0007Cl-5R
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 04:33:36 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 20 Feb 2017 09:32:49 +0000
Message-Id: <20170220093304.20515-10-stefanha@redhat.com>
In-Reply-To: <20170220093304.20515-1-stefanha@redhat.com>
References: <20170220093304.20515-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 09/24] blkdebug: reschedule coroutine on the
 AioContext it is running on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Keep the coroutine on the same AioContext.  Without this change,
there would be a race between yielding the coroutine and reentering it.
While the race cannot happen now, because the code only runs from a single
AioContext, this will change with multiqueue support in the block layer.

While doing the change, replace custom bottom half with aio_co_schedule.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170213135235.12274-10-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/blkdebug.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blkdebug.c b/block/blkdebug.c
index acccf85..d8eee1b 100644
--- a/block/blkdebug.c
+++ b/block/blkdebug.c
@@ -405,12 +405,6 @@ out:
     return ret;
 }
 
-static void error_callback_bh(void *opaque)
-{
-    Coroutine *co = opaque;
-    qemu_coroutine_enter(co);
-}
-
 static int inject_error(BlockDriverState *bs, BlkdebugRule *rule)
 {
     BDRVBlkdebugState *s = bs->opaque;
@@ -423,8 +417,7 @@ static int inject_error(BlockDriverState *bs, BlkdebugRule *rule)
     }
 
     if (!immediately) {
-        aio_bh_schedule_oneshot(bdrv_get_aio_context(bs), error_callback_bh,
-                                qemu_coroutine_self());
+        aio_co_schedule(qemu_get_current_aio_context(), qemu_coroutine_self());
         qemu_coroutine_yield();
     }
 
-- 
2.9.3
