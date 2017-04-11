Received: from eggs.gnu.org ([2001:4830:134:3::10]:39104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxush-00041b-Nl
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cxusg-0003oz-Os
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35369)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cxusg-0003nl-Ig
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 08:26:46 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 11 Apr 2017 20:26:23 +0800
Message-Id: <20170411122632.14050-3-famz@redhat.com>
In-Reply-To: <20170411122632.14050-1-famz@redhat.com>
References: <20170411122632.14050-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 02/11] block: Quiesce old aio context during
 bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, famz@redhat.com

The fact that the bs->aio_context is changing can confuse the dataplane
iothread, because of the now fine granularity aio context lock.
bdrv_drain should rather be a bdrv_drained_begin/end pair, but since
bs->aio_context is changing, we can just use aio_disable_external and
bdrv_parent_drained_begin.

Reported-by: Ed Swierk <eswierk@skyportsystems.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
---
 block.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index b8a3011..a995a8e 100644
--- a/block.c
+++ b/block.c
@@ -4396,11 +4396,12 @@ void bdrv_attach_aio_context(BlockDriverState *bs,
 
 void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
 {
-    AioContext *ctx;
+    AioContext *ctx = bdrv_get_aio_context(bs);
 
+    aio_disable_external(ctx);
+    bdrv_parent_drained_begin(bs);
     bdrv_drain(bs); /* ensure there are no in-flight requests */
 
-    ctx = bdrv_get_aio_context(bs);
     while (aio_poll(ctx, false)) {
         /* wait for all bottom halves to execute */
     }
@@ -4412,6 +4413,8 @@ void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
      */
     aio_context_acquire(new_context);
     bdrv_attach_aio_context(bs, new_context);
+    bdrv_parent_drained_end(bs);
+    aio_enable_external(ctx);
     aio_context_release(new_context);
 }
 
-- 
2.9.3
