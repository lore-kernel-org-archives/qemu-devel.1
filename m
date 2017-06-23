Received: from eggs.gnu.org ([2001:4830:134:3::10]:59142)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLZ-0000LZ-Rz
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dORLY-0007SW-W1
	for qemu-devel@nongnu.org; Fri, 23 Jun 2017 12:22:13 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 23 Jun 2017 18:21:03 +0200
Message-Id: <1498234919-27316-6-git-send-email-kwolf@redhat.com>
In-Reply-To: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
References: <1498234919-27316-1-git-send-email-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/61] block: use BDRV_POLL_WHILE() in
 bdrv_rw_vmstate()
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Calling aio_poll() directly may have been fine previously, but this is
the future, man!  The difference between an aio_poll() loop and
BDRV_POLL_WHILE() is that BDRV_POLL_WHILE() releases the AioContext
around aio_poll().

This allows the IOThread to run fd handlers or BHs to complete the
request.  Failure to release the AioContext causes deadlocks.

Using BDRV_POLL_WHILE() partially fixes a 'savevm' hang with -object
iothread.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 684ea46..e158ae0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -2023,9 +2023,7 @@ bdrv_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
         Coroutine *co = qemu_coroutine_create(bdrv_co_rw_vmstate_entry, &data);
 
         bdrv_coroutine_enter(bs, co);
-        while (data.ret == -EINPROGRESS) {
-            aio_poll(bdrv_get_aio_context(bs), true);
-        }
+        BDRV_POLL_WHILE(bs, data.ret == -EINPROGRESS);
         return data.ret;
     }
 }
-- 
1.8.3.1
