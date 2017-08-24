Received: from eggs.gnu.org ([2001:4830:134:3::10]:42286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dku92-0004xU-Ez
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:34:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dku91-0000Bz-ES
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 11:34:08 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 24 Aug 2017 16:33:43 +0100
Message-Id: <20170824153345.2244-2-stefanha@redhat.com>
In-Reply-To: <20170824153345.2244-1-stefanha@redhat.com>
References: <20170824153345.2244-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PATCH 1/3] nbd-client: enter read_reply_co during
 init to avoid crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

The following segfault is encountered if the NBD server closes the UNIX
domain socket immediately after negotiation:

  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  aio_co_schedule (ctx=0x0, co=0xd3c0ff2ef0) at util/async.c:441
  441	    QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
  (gdb) bt
  #0  0x000000d3c01a50f8 in aio_co_schedule (ctx=0x0, co=0xd3c0ff2ef0) at util/async.c:441
  #1  0x000000d3c012fa90 in nbd_coroutine_end (bs=bs@entry=0xd3c0fec650, request=<optimized out>) at block/nbd-client.c:207
  #2  0x000000d3c012fb58 in nbd_client_co_preadv (bs=0xd3c0fec650, offset=0, bytes=<optimized out>, qiov=0x7ffc10a91b20, flags=0) at block/nbd-client.c:237
  #3  0x000000d3c0128e63 in bdrv_driver_preadv (bs=bs@entry=0xd3c0fec650, offset=offset@entry=0, bytes=bytes@entry=512, qiov=qiov@entry=0x7ffc10a91b20, flags=0) at block/io.c:836
  #4  0x000000d3c012c3e0 in bdrv_aligned_preadv (child=child@entry=0xd3c0ff51d0, req=req@entry=0x7f31885d6e90, offset=offset@entry=0, bytes=bytes@entry=512, align=align@entry=1, qiov=qiov@entry=0x7ffc10a91b20, flags=0) at block/io.c:1086
  #5  0x000000d3c012c6b8 in bdrv_co_preadv (child=0xd3c0ff51d0, offset=offset@entry=0, bytes=bytes@entry=512, qiov=qiov@entry=0x7ffc10a91b20, flags=flags@entry=0) at block/io.c:1182
  #6  0x000000d3c011cc17 in blk_co_preadv (blk=0xd3c0ff4f80, offset=0, bytes=512, qiov=0x7ffc10a91b20, flags=0) at block/block-backend.c:1032
  #7  0x000000d3c011ccec in blk_read_entry (opaque=0x7ffc10a91b40) at block/block-backend.c:1079
  #8  0x000000d3c01bbb96 in coroutine_trampoline (i0=<optimized out>, i1=<optimized out>) at util/coroutine-ucontext.c:79
  #9  0x00007f3196cb8600 in __start_context () at /lib64/libc.so.6

The problem is that nbd_client_init() uses
nbd_client_attach_aio_context() -> aio_co_schedule(new_context,
client->read_reply_co).  Execution of read_reply_co is deferred to a BH
which doesn't run until later.

In the mean time blk_co_preadv() can be called and nbd_coroutine_end()
calls aio_wake() on read_reply_co.  At this point in time
read_reply_co's ctx isn't set because it has never been entered yet.

This patch enters read_reply_co directly in
nbd_client_attach_aio_context().  This is safe because new_context is
acquired by the caller.  This ensures that read_reply_co reaches its
first yield point and its ctx is set up.

Note this only happens with UNIX domain sockets on Linux.  It doesn't
seem possible to reproduce this with TCP sockets.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/nbd-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 25bcaa2346..0a7f32779e 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -371,7 +371,7 @@ void nbd_client_attach_aio_context(BlockDriverState *bs,
 {
     NBDClientSession *client = nbd_get_client_session(bs);
     qio_channel_attach_aio_context(QIO_CHANNEL(client->ioc), new_context);
-    aio_co_schedule(new_context, client->read_reply_co);
+    qemu_aio_coroutine_enter(new_context, client->read_reply_co);
 }
 
 void nbd_client_close(BlockDriverState *bs)
-- 
2.13.5
