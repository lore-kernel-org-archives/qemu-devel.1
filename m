Received: from eggs.gnu.org ([2001:4830:134:3::10]:53538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdDZT-00081N-W1
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cdDZR-0007aI-RU
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:09:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cdDZR-0007a8-Lw
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 05:09:21 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DB992C04B302
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 10:09:21 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 13 Feb 2017 11:08:57 +0100
Message-Id: <20170213100906.23486-10-pbonzini@redhat.com>
In-Reply-To: <20170213100906.23486-1-pbonzini@redhat.com>
References: <20170213100906.23486-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/18] blkdebug: reschedule coroutine on the
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
Cc: famz@redhat.com, stefanha@redhat.com

Keep the coroutine on the same AioContext.  Without this change,
there would be a race between yielding the coroutine and reentering it.
While the race cannot happen now, because the code only runs from a single
AioContext, this will change with multiqueue support in the block layer.

While doing the change, replace custom bottom half with aio_co_schedule.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
