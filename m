Received: from eggs.gnu.org ([2001:4830:134:3::10]:45475)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3ze-00062Q-1F
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cv3zd-0007AQ-05
	for qemu-devel@nongnu.org; Mon, 03 Apr 2017 11:34:10 -0400
From: Max Reitz <mreitz@redhat.com>
Date: Mon,  3 Apr 2017 17:33:41 +0200
Message-Id: <20170403153355.19722-2-mreitz@redhat.com>
In-Reply-To: <20170403153355.19722-1-mreitz@redhat.com>
References: <20170403153355.19722-1-mreitz@redhat.com>
Subject: [Qemu-devel] [PULL 01/15] block: add missed aio_context_acquire
 into release_drive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

From: "Denis V. Lunev" <den@openvz.org>

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
Message-id: 1490717566-25516-1-git-send-email-den@openvz.org
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 hw/core/qdev-properties-system.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index c34be1c1ba..e885e650fb 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -124,8 +124,12 @@ static void release_drive(Object *obj, const char *name, void *opaque)
     BlockBackend **ptr = qdev_get_prop_ptr(dev, prop);
 
     if (*ptr) {
+        AioContext *ctx = blk_get_aio_context(*ptr);
+
+        aio_context_acquire(ctx);
         blockdev_auto_del(*ptr);
         blk_detach_dev(*ptr, dev);
+        aio_context_release(ctx);
     }
 }
 
-- 
2.12.1
