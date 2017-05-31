Received: from eggs.gnu.org ([2001:4830:134:3::10]:41802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dG0AR-0002dM-2B
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:43:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dG0AP-0001sm-AH
	for qemu-devel@nongnu.org; Wed, 31 May 2017 05:43:51 -0400
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 31 May 2017 11:43:30 +0200
Message-Id: <20170531094330.1808-12-pbonzini@redhat.com>
In-Reply-To: <20170531094330.1808-1-pbonzini@redhat.com>
References: <20170531094330.1808-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 11/11] ssh: support I/O from any AioContext
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

The coroutine may run in a different AioContext, causing the
fd handler to busy wait.  Fix this by resetting the handler
in restart_coroutine, before the coroutine is restarted.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/ssh.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/block/ssh.c b/block/ssh.c
index 11203fc5a2..b5a35824d7 100644
--- a/block/ssh.c
+++ b/block/ssh.c
@@ -889,13 +889,22 @@ static int ssh_has_zero_init(BlockDriverState *bs)
     return has_zero_init;
 }
 
+typedef struct BDRVSSHRestart {
+    BlockDriverState *bs;
+    Coroutine *co;
+} BDRVSSHRestart;
+
 static void restart_coroutine(void *opaque)
 {
-    Coroutine *co = opaque;
+    BDRVSSHRestart *restart = opaque;
+    BlockDriverState *bs = restart->bs;
+    BDRVSSHState *s = bs->opaque;
+    AioContext *ctx = bdrv_get_aio_context(bs);
 
-    DPRINTF("co=%p", co);
+    DPRINTF("co=%p", restart->co);
+    aio_set_fd_handler(ctx, s->sock, false, NULL, NULL, NULL, NULL);
 
-    aio_co_wake(co);
+    aio_co_wake(restart->co);
 }
 
 /* A non-blocking call returned EAGAIN, so yield, ensuring the
@@ -906,7 +915,10 @@ static coroutine_fn void co_yield(BDRVSSHState *s, BlockDriverState *bs)
 {
     int r;
     IOHandler *rd_handler = NULL, *wr_handler = NULL;
-    Coroutine *co = qemu_coroutine_self();
+    BDRVSSHRestart restart = {
+        .bs = bs,
+        .co = qemu_coroutine_self()
+    };
 
     r = libssh2_session_block_directions(s->session);
 
@@ -921,11 +933,9 @@ static coroutine_fn void co_yield(BDRVSSHState *s, BlockDriverState *bs)
             rd_handler, wr_handler);
 
     aio_set_fd_handler(bdrv_get_aio_context(bs), s->sock,
-                       false, rd_handler, wr_handler, NULL, co);
+                       false, rd_handler, wr_handler, NULL, &restart);
     qemu_coroutine_yield();
     DPRINTF("s->sock=%d - back", s->sock);
-    aio_set_fd_handler(bdrv_get_aio_context(bs), s->sock, false,
-                       NULL, NULL, NULL, NULL);
 }
 
 /* SFTP has a function `libssh2_sftp_seek64' which seeks to a position
-- 
2.13.0
