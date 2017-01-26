Received: from eggs.gnu.org ([2001:4830:134:3::10]:45900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWh9x-0002Rv-O0
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:20:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cWh9r-0006PK-MR
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:20:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43750)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cWh9r-0006P2-Di
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 05:19:59 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 26 Jan 2017 10:19:54 +0000
Message-Id: <20170126101954.21236-2-stefanha@redhat.com>
In-Reply-To: <20170126101954.21236-1-stefanha@redhat.com>
References: <20170126101954.21236-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/1] aio-posix: honor is_external in AioContext
 polling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

AioHandlers marked ->is_external must be skipped when aio_node_check()
fails.  bdrv_drained_begin() needs this to prevent dataplane from
submitting new I/O requests while another thread accesses the device and
relies on it being quiesced.

This patch fixes the following segfault:

  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  0x00005577f6127dad in bdrv_io_plug (bs=0x5577f7ae52f0) at qemu/block/io.c:2650
  2650            bdrv_io_plug(child->bs);
  [Current thread is 1 (Thread 0x7ff5c4bd1c80 (LWP 10917))]
  (gdb) bt
  #0  0x00005577f6127dad in bdrv_io_plug (bs=0x5577f7ae52f0) at qemu/block/io.c:2650
  #1  0x00005577f6114363 in blk_io_plug (blk=0x5577f7b8ba20) at qemu/block/block-backend.c:1561
  #2  0x00005577f5d4091d in virtio_blk_handle_vq (s=0x5577f9ada030, vq=0x5577f9b3d2a0) at qemu/hw/block/virtio-blk.c:589
  #3  0x00005577f5d4240d in virtio_blk_data_plane_handle_output (vdev=0x5577f9ada030, vq=0x5577f9b3d2a0) at qemu/hw/block/dataplane/virtio-blk.c:158
  #4  0x00005577f5d88acd in virtio_queue_notify_aio_vq (vq=0x5577f9b3d2a0) at qemu/hw/virtio/virtio.c:1304
  #5  0x00005577f5d8aaaf in virtio_queue_host_notifier_aio_poll (opaque=0x5577f9b3d308) at qemu/hw/virtio/virtio.c:2134
  #6  0x00005577f60ca077 in run_poll_handlers_once (ctx=0x5577f79ddbb0) at qemu/aio-posix.c:493
  #7  0x00005577f60ca268 in try_poll_mode (ctx=0x5577f79ddbb0, blocking=true) at qemu/aio-posix.c:569
  #8  0x00005577f60ca331 in aio_poll (ctx=0x5577f79ddbb0, blocking=true) at qemu/aio-posix.c:601
  #9  0x00005577f612722a in bdrv_flush (bs=0x5577f7c20970) at qemu/block/io.c:2403
  #10 0x00005577f60c1b2d in bdrv_close (bs=0x5577f7c20970) at qemu/block.c:2322
  #11 0x00005577f60c20e7 in bdrv_delete (bs=0x5577f7c20970) at qemu/block.c:2465
  #12 0x00005577f60c3ecf in bdrv_unref (bs=0x5577f7c20970) at qemu/block.c:3425
  #13 0x00005577f60bf951 in bdrv_root_unref_child (child=0x5577f7a2de70) at qemu/block.c:1361
  #14 0x00005577f6112162 in blk_remove_bs (blk=0x5577f7b8ba20) at qemu/block/block-backend.c:491
  #15 0x00005577f6111b1b in blk_remove_all_bs () at qemu/block/block-backend.c:245
  #16 0x00005577f60c1db6 in bdrv_close_all () at qemu/block.c:2382
  #17 0x00005577f5e60cca in main (argc=20, argv=0x7ffea6eb8398, envp=0x7ffea6eb8440) at qemu/vl.c:4684

The key thing is that bdrv_close() uses bdrv_drained_begin() and
virtio_queue_host_notifier_aio_poll() must not be called.

Thanks to Fam Zheng <famz@redhat.com> for identifying the root cause of
this crash.

Reported-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Tested-by: Alberto Garcia <berto@igalia.com>
Message-id: 20170124095350.16679-1-stefanha@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 aio-posix.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/aio-posix.c b/aio-posix.c
index 9453d83..a8d7090 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -508,7 +508,8 @@ static bool run_poll_handlers_once(AioContext *ctx)
 
     QLIST_FOREACH_RCU(node, &ctx->aio_handlers, node) {
         if (!node->deleted && node->io_poll &&
-                node->io_poll(node->opaque)) {
+            aio_node_check(ctx, node->is_external) &&
+            node->io_poll(node->opaque)) {
             progress = true;
         }
 
-- 
2.9.3
