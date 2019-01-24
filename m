Received: from eggs.gnu.org ([209.51.188.92]:39071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gmZpc-0000Zf-0P
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1gmZpa-0004LT-VK
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 02:53:47 -0500
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Thu, 24 Jan 2019 10:48:25 +0300
Message-Id: <20190124074825.2327-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] block: skip initializer BDS on recursive aio
 context attachment/detachment
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mreitz@redhat.com, kwolf@redhat.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, den@virtuozzo.com, vsementsov@virtuozzo.com

When there is a Backup Block Job running and shutdown command is sent to
a guest, the guest crushes due to assert(!bs->walking_aio_notifiers).

Call stack:

0  __GI_raise
1  __GI_abort
2  __assert_fail_base
3  __GI___assert_fail
4  bdrv_detach_aio_context (bs=0x55f54d65c000)      <<<
5  bdrv_detach_aio_context (bs=0x55f54fc8a800)
6  bdrv_set_aio_context (bs=0x55f54fc8a800, ...)
7  block_job_attached_aio_context
8  bdrv_attach_aio_context (bs=0x55f54d65c000, ...) <<<
9  bdrv_set_aio_context (bs=0x55f54d65c000)
10 blk_set_aio_context
11 virtio_blk_data_plane_stop
12 virtio_bus_stop_ioeventfd
13 virtio_vmstate_change
14 vm_state_notify (running=0, state=RUN_STATE_SHUTDOWN)
15 do_vm_stop (state=RUN_STATE_SHUTDOWN, send_stop=true)
16 vm_stop (state=RUN_STATE_SHUTDOWN)
17 main_loop_should_exit
18 main_loop
19 main

This happens because of "new" context attachment to VM disk bds.
When attaching a new context the corresponding aio context handler is
called for each of aio_notifiers registered on the VM disk bds context.
Among those handlers there is the block_job_attached_aio_context handler
which sets a new aio context for the block job bds. When doing so,
the old context is detached from all the block job bds children and one of
them is the VM disk bds, serving as backing store for the blockjob bds,
although the VM disk bds is actually the initializer of that process.
Since the VM disk bds is protected with walking_aio_notifiers flag
from double processing in recursive calls, the assert fires.

The patch fixes the problem by skipping the bds-es in recursive calls
which have started attachment/detachment already.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 block.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 9b1c5c5eaf..35a19fe1df 100644
--- a/block.c
+++ b/block.c
@@ -5064,7 +5064,9 @@ void bdrv_detach_aio_context(BlockDriverState *bs)
         bs->drv->bdrv_detach_aio_context(bs);
     }
     QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_detach_aio_context(child->bs);
+        if (!child->bs->walking_aio_notifiers) {
+            bdrv_detach_aio_context(child->bs);
+        }
     }
 
     bs->aio_context = NULL;
@@ -5083,7 +5085,9 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
     bs->aio_context = new_context;
 
     QLIST_FOREACH(child, &bs->children, next) {
-        bdrv_attach_aio_context(child->bs, new_context);
+        if (!child->bs->walking_aio_notifiers) {
+            bdrv_attach_aio_context(child->bs, new_context);
+        }
     }
     if (bs->drv->bdrv_attach_aio_context) {
         bs->drv->bdrv_attach_aio_context(bs, new_context);
-- 
2.17.0
