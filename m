Received: from eggs.gnu.org ([2001:4830:134:3::10]:47165)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1csWfx-00036w-Pq
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:35:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1csWfu-0003ma-Oh
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:35:21 -0400
Received: from mailhub.sw.ru ([195.214.232.25]:26230 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1csWfu-0003hK-ES
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 11:35:18 -0400
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 27 Mar 2017 18:35:15 +0300
Message-Id: <1490628915-19459-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [RFC for 2.9 1/1] block: add missed
 aio_context_acquire into blk_unref
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Denis V. Lunev" <den@openvz.org>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>

Recently we expirience hang with iothreads enabled with the following
call trace:
Thread 1 (Thread 0x7fa95efebc80 (LWP 177117)):
0  ppoll () from /lib64/libc.so.6
2  qemu_poll_ns () at qemu-timer.c:313
3  aio_poll () at aio-posix.c:457
4  bdrv_flush () at block/io.c:2641
5  bdrv_close () at block.c:2143
6  bdrv_delete () at block.c:2352
7  bdrv_unref () at block.c:3429
8  blk_remove_bs () at block/block-backend.c:427
9  blk_delete () at block/block-backend.c:178
10 blk_unref () at block/block-backend.c:226
11 object_property_del_all () at qom/object.c:399
12 object_finalize () at qom/object.c:461
13 object_unref () at qom/object.c:898
14 object_property_del_child () at qom/object.c:422
15 qmp_marshal_device_del () at qmp-marshal.c:1145
16 handle_qmp_command () at /usr/src/debug/qemu-2.6.0/monitor.c:3929

Technically bdrv_flush() stucks in
    while (rwco.ret == NOT_DONE) {
        aio_poll(aio_context, true);
    }
but rwco.ret is equal to 0 thus we have missed wakeup. Code investigation
reveals that we do not have performed aio_context_acquire() on this call
stack.

This patch adds missed lock.

Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Kevin Wolf <kwolf@redhat.com>
CC: Max Reitz <mreitz@redhat.com>
CC: Eric Blake <eblake@redhat.com>
CC: Markus Armbruster <armbru@redhat.com>
---
 block/block-backend.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 5742c09..65d5da9 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -273,7 +273,11 @@ void blk_unref(BlockBackend *blk)
     if (blk) {
         assert(blk->refcnt > 0);
         if (!--blk->refcnt) {
+            AioContext *ctx = blk_get_aio_context(blk);
+
+            aio_context_acquire(ctx);
             blk_delete(blk);
+            aio_context_release(ctx);
         }
     }
 }
-- 
2.7.4
