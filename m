Received: from eggs.gnu.org ([2001:4830:134:3::10]:53040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Og-0001qQ-AB
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dn7Oe-0001a7-Uc
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 14:07:26 -0400
From: Eric Blake <eblake@redhat.com>
Date: Wed, 30 Aug 2017 13:07:02 -0500
Message-Id: <20170830180711.7974-3-eblake@redhat.com>
In-Reply-To: <20170830180711.7974-1-eblake@redhat.com>
References: <20170830180711.7974-1-eblake@redhat.com>
Subject: [Qemu-devel] [PULL 02/11] nbd-client: avoid read_reply_co entry if
 send failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

From: Stefan Hajnoczi <stefanha@redhat.com>

The following segfault is encountered if the NBD server closes the UNIX
domain socket immediately after negotiation:

  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  aio_co_schedule (ctx=0x0, co=0xd3c0ff2ef0) at util/async.c:441
  441       QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
  (gdb) bt
  #0  0x000000d3c01a50f8 in aio_co_schedule (ctx=0x0, co=0xd3c0ff2ef0) at util/async.c:441
  #1  0x000000d3c012fa90 in nbd_coroutine_end (bs=bs@entry=0xd3c0fec650, request=<optimized out>) at block/nbd-client.c:207
  #2  0x000000d3c012fb58 in nbd_client_co_preadv (bs=0xd3c0fec650, offset=0, bytes=<optimized out>, qiov=0x7ffc10a91b20, flags=0) at block/nbd-client.c:237
  #3  0x000000d3c0128e63 in bdrv_driver_preadv (bs=bs@entry=0xd3c0fec650, offset=offset@entry=0, bytes=bytes@entry=512, qiov=qiov@entry=0x7ffc10a91b20, flags=0) at block/io.c:836
  #4  0x000000d3c012c3e0 in bdrv_aligned_preadv (child=child@entry=0xd3c0ff51d0, req=req@entry=0x7f31885d6e90, offset=offset@entry=0, bytes=bytes@entry=512, align=align@entry=1, qiov=qiov@entry=0x7ffc10a91b20, f
+lags=0) at block/io.c:1086
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

This patch simplifies the nbd_co_send_request() ->
nbd_co_receive_reply() -> nbd_coroutine_end() lifecycle to just
nbd_co_send_request() -> nbd_co_receive_reply().  The request is "ended"
if an error occurs at any point.  Callers no longer have to invoke
nbd_coroutine_end().

This cleanup also eliminates the segfault because we don't call
aio_co_schedule() to wake up s->read_reply_co if sending the request
failed.  It is only necessary to wake up s->read_reply_co if a reply was
received.

Note this only happens with UNIX domain sockets on Linux.  It doesn't
seem possible to reproduce this with TCP sockets.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-Id: <20170829122745.14309-2-stefanha@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 block/nbd-client.c | 25 +++++++++----------------
 1 file changed, 9 insertions(+), 16 deletions(-)

diff --git a/block/nbd-client.c b/block/nbd-client.c
index 25bcaa2346..ea728fffc8 100644
--- a/block/nbd-client.c
+++ b/block/nbd-client.c
@@ -144,12 +144,12 @@ static int nbd_co_send_request(BlockDriverState *bs,
     request->handle = INDEX_TO_HANDLE(s, i);

     if (s->quit) {
-        qemu_co_mutex_unlock(&s->send_mutex);
-        return -EIO;
+        rc = -EIO;
+        goto err;
     }
     if (!s->ioc) {
-        qemu_co_mutex_unlock(&s->send_mutex);
-        return -EPIPE;
+        rc = -EPIPE;
+        goto err;
     }

     if (qiov) {
@@ -166,8 +166,13 @@ static int nbd_co_send_request(BlockDriverState *bs,
     } else {
         rc = nbd_send_request(s->ioc, request);
     }
+
+err:
     if (rc < 0) {
         s->quit = true;
+        s->requests[i].coroutine = NULL;
+        s->in_flight--;
+        qemu_co_queue_next(&s->free_sema);
     }
     qemu_co_mutex_unlock(&s->send_mutex);
     return rc;
@@ -201,13 +206,6 @@ static void nbd_co_receive_reply(NBDClientSession *s,
         /* Tell the read handler to read another header.  */
         s->reply.handle = 0;
     }
-}
-
-static void nbd_coroutine_end(BlockDriverState *bs,
-                              NBDRequest *request)
-{
-    NBDClientSession *s = nbd_get_client_session(bs);
-    int i = HANDLE_TO_INDEX(s, request->handle);

     s->requests[i].coroutine = NULL;

@@ -243,7 +241,6 @@ int nbd_client_co_preadv(BlockDriverState *bs, uint64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, qiov);
     }
-    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }

@@ -272,7 +269,6 @@ int nbd_client_co_pwritev(BlockDriverState *bs, uint64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }

@@ -306,7 +302,6 @@ int nbd_client_co_pwrite_zeroes(BlockDriverState *bs, int64_t offset,
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }

@@ -330,7 +325,6 @@ int nbd_client_co_flush(BlockDriverState *bs)
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(bs, &request);
     return -reply.error;
 }

@@ -355,7 +349,6 @@ int nbd_client_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes)
     } else {
         nbd_co_receive_reply(client, &request, &reply, NULL);
     }
-    nbd_coroutine_end(bs, &request);
     return -reply.error;

 }
-- 
2.13.5
