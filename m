Received: from eggs.gnu.org ([209.51.188.92]:36982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4D-0008B9-3Q
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI4C-0000bz-5J
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:21:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:19:48 +0100
Message-Id: <20190225152053.15976-7-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/71] block: don't set the same context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Denis Plotnikov <dplotnikov@virtuozzo.com>

Adds a fast path on aio context setting preventing
unnecessary context setting routine.
Also, it prevents issues with cyclic walk of child
bds-es appeared because of registering aio walking
notifiers:

Call stack:

0  __GI_raise
1  __GI_abort
2  __assert_fail_base
3  __GI___assert_fail
4  bdrv_detach_aio_context (bs=3D0x55f54d65c000)      <<<
5  bdrv_detach_aio_context (bs=3D0x55f54fc8a800)
6  bdrv_set_aio_context (bs=3D0x55f54fc8a800, ...)
7  block_job_attached_aio_context
8  bdrv_attach_aio_context (bs=3D0x55f54d65c000, ...) <<<
9  bdrv_set_aio_context (bs=3D0x55f54d65c000)
10 blk_set_aio_context
11 virtio_blk_data_plane_stop
12 virtio_bus_stop_ioeventfd
13 virtio_vmstate_change
14 vm_state_notify (running=3D0, state=3DRUN_STATE_SHUTDOWN)
15 do_vm_stop (state=3DRUN_STATE_SHUTDOWN, send_stop=3Dtrue)
16 vm_stop (state=3DRUN_STATE_SHUTDOWN)
17 main_loop_should_exit
18 main_loop
19 main

This can happen because of "new" context attachment to VM disk bds.
When attaching a new context the corresponding aio context handler is
called for each of aio_notifiers registered on the VM disk bds context.
Among those handlers, there is the block_job_attached_aio_context handler
which sets a new aio context for the block job bds. When doing so,
the old context is detached from all the block job bds children and one o=
f
them is the VM disk bds, serving as backing store for the blockjob bds,
although the VM disk bds is actually the initializer of that process.
Since the VM disk bds is protected with walking_aio_notifiers flag
from double processing in recursive calls, the assert fires.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/block.c b/block.c
index 4ad0e90d7e..0c12632661 100644
--- a/block.c
+++ b/block.c
@@ -5265,6 +5265,10 @@ void bdrv_set_aio_context(BlockDriverState *bs, Ai=
oContext *new_context)
 {
     AioContext *ctx =3D bdrv_get_aio_context(bs);
=20
+    if (ctx =3D=3D new_context) {
+        return;
+    }
+
     aio_disable_external(ctx);
     bdrv_parent_drained_begin(bs, NULL, false);
     bdrv_drain(bs); /* ensure there are no in-flight requests */
--=20
2.20.1
