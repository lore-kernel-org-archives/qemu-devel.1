Received: from eggs.gnu.org ([2001:4830:134:3::10]:47988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnkN7-0005sJ-Rf
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:12:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cnkN2-0005e5-0h
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 07:12:09 -0400
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 14 Mar 2017 12:11:57 +0100
Message-Id: <20170314111157.14464-2-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] block: quiesce AioContext when detaching from
 it
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, qemu-block@nongnu.org

While it is true that bdrv_set_aio_context only works on a single
BlockDriverState subtree (see commit message for 53ec73e, "block: Use
bdrv_drain to replace uncessary bdrv_drain_all", 2015-07-07), it works
at the AioContext level rather than the BlockDriverState level.

Therefore, it is also necessary to trigger pending bottom halves too,
even if no requests are pending.

For NBD this ensures that the aio_co_schedule of a previous call to
nbd_attach_aio_context is completed before detaching from the old
AioContext; it fixes qemu-iotest 094.  Another similar bug happens
when the VM is stopped and the virtio-blk dataplane irqfd is torn down.
In this case it's possible that guest I/O gets stuck if notify_guest_bh
was scheduled but doesn't run.

Calling aio_poll from another AioContext is safe if non-blocking; races
such as the one mentioned in the commit message for c9d1a56 ("block:
only call aio_poll on the current thread's AioContext", 2016-10-28)
are a concern for blocking calls.

I considered other options, including:

- moving the bs->wakeup mechanism to AioContext, and letting the caller
check.  This might work for virtio which has a clear place to wakeup
(notify_place_bh) and check the condition (virtio_blk_data_plane_stop).
For aio_co_schedule I couldn't find a clear place to check the condition.

- adding a dummy oneshot bottom half and waiting for it to trigger.
This has the complication that bottom half list is LIFO for historical
reasons.  There were performance issues caused by bottom half ordering
in the past, so I decided against it for 2.9.

Fixes: 99723548561978da8ef44cf804fb7912698f5d88
Reported-by: Max Reitz <mreitz@redhat.com>
Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Tested-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/block.c b/block.c
index f293ccb..e159251 100644
--- a/block.c
+++ b/block.c
@@ -4272,8 +4272,15 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
 
 void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
 {
+    AioContext *ctx;
+
     bdrv_drain(bs); /* ensure there are no in-flight requests */
 
+    ctx = bdrv_get_aio_context(bs);
+    while (aio_poll(ctx, false)) {
+        /* wait for all bottom halves to execute */
+    }
+
     bdrv_detach_aio_context(bs);
 
     /* This function executes in the old AioContext so acquire the new one in
-- 
2.9.3
