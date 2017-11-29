Received: from eggs.gnu.org ([2001:4830:134:3::10]:41601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3iT-0005ze-7H
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:52:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1eK3iS-0006G1-JN
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 09:52:01 -0500
From: Fam Zheng <famz@redhat.com>
Date: Wed, 29 Nov 2017 22:49:53 +0800
Message-Id: <20171129144956.11409-7-famz@redhat.com>
In-Reply-To: <20171129144956.11409-1-famz@redhat.com>
References: <20171129144956.11409-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 6/9] block: Use aio_context_drained_begin
 in bdrv_set_aio_context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, jcody@redhat.com, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, pbonzini@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block.c b/block.c
index 9a1a0d1e73..949f0dec11 100644
--- a/block.c
+++ b/block.c
@@ -4745,8 +4745,7 @@ void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
 {
     AioContext *ctx = bdrv_get_aio_context(bs);
 
-    aio_disable_external(ctx);
-    bdrv_parent_drained_begin(bs);
+    aio_context_drained_begin(ctx);
     bdrv_drain(bs); /* ensure there are no in-flight requests */
 
     while (aio_poll(ctx, false)) {
@@ -4760,8 +4759,7 @@ void bdrv_set_aio_context(BlockDriverState *bs, AioContext *new_context)
      */
     aio_context_acquire(new_context);
     bdrv_attach_aio_context(bs, new_context);
-    bdrv_parent_drained_end(bs);
-    aio_enable_external(ctx);
+    aio_context_drained_end(ctx);
     aio_context_release(new_context);
 }
 
-- 
2.14.3
