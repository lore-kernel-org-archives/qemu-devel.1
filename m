Received: from eggs.gnu.org ([2001:4830:134:3::10]:51719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMaxh-00070u-4K
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:46:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eMaxg-0003Dm-85
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 09:46:13 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Wed,  6 Dec 2017 14:45:42 +0000
Message-Id: <20171206144550.22295-2-stefanha@redhat.com>
In-Reply-To: <20171206144550.22295-1-stefanha@redhat.com>
References: <20171206144550.22295-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/9] blockdev: hold AioContext for
 bdrv_unref() in external_snapshot_clean()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

bdrv_unref() requires the AioContext lock because bdrv_flush() uses
BDRV_POLL_WHILE(), which assumes the AioContext is currently held.  If
BDRV_POLL_WHILE() runs without AioContext held the
pthread_mutex_unlock() call in aio_context_release() fails.

This patch moves bdrv_unref() into the AioContext locked region to solve
the following pthread_mutex_unlock() failure:

  #0  0x00007f566181969b in raise () at /lib64/libc.so.6
  #1  0x00007f566181b3b1 in abort () at /lib64/libc.so.6
  #2  0x00005592cd590458 in error_exit (err=<optimized out>, msg=msg@entry=0x5592cdaf6d60 <__func__.23977> "qemu_mutex_unlock") at util/qemu-thread-posix.c:36
  #3  0x00005592cd96e738 in qemu_mutex_unlock (mutex=mutex@entry=0x5592ce9505e0) at util/qemu-thread-posix.c:96
  #4  0x00005592cd969b69 in aio_context_release (ctx=ctx@entry=0x5592ce950580) at util/async.c:507
  #5  0x00005592cd8ead78 in bdrv_flush (bs=bs@entry=0x5592cfa87210) at block/io.c:2478
  #6  0x00005592cd89df30 in bdrv_close (bs=0x5592cfa87210) at block.c:3207
  #7  0x00005592cd89df30 in bdrv_delete (bs=0x5592cfa87210) at block.c:3395
  #8  0x00005592cd89df30 in bdrv_unref (bs=0x5592cfa87210) at block.c:4418
  #9  0x00005592cd6b7f86 in qmp_transaction (dev_list=<optimized out>, has_props=<optimized out>, props=<optimized out>, errp=errp@entry=0x7ffe4a1fc9d8) at blockdev.c:2308

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 blockdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 56a6b24a0b..3c8d994ced 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1812,8 +1812,8 @@ static void external_snapshot_clean(BlkActionState *common)
                              DO_UPCAST(ExternalSnapshotState, common, common);
     if (state->aio_context) {
         bdrv_drained_end(state->old_bs);
-        aio_context_release(state->aio_context);
         bdrv_unref(state->new_bs);
+        aio_context_release(state->aio_context);
     }
 }
 
-- 
2.14.3
