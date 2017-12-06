Received: from eggs.gnu.org ([2001:4830:134:3::10]:50690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMXKO-0001nB-Hq
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:53:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eMXKN-0006ak-P2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:53:24 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed,  6 Dec 2017 11:53:05 +0100
Message-Id: <20171206105309.3468-3-kwolf@redhat.com>
In-Reply-To: <20171206105309.3468-1-kwolf@redhat.com>
References: <20171206105309.3468-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH v2 2/6] block: Call .drain_begin only once in
 bdrv_drain_all_begin()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, famz@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

bdrv_drain_all_begin() used to call the .bdrv_co_drain_begin() driver
callback inside its polling loop. This means that how many times it got
called for each node depended on long it had to poll the event loop.

This is obviously not right and results in nodes that stay drained even
after bdrv_drain_all_end(), which calls .bdrv_co_drain_begin() once per
node.

Fix bdrv_drain_all_begin() to call the callback only once, too.

Cc: qemu-stable@nongnu.org
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 096468b761..603f5b059e 100644
--- a/block/io.c
+++ b/block/io.c
@@ -355,6 +355,7 @@ void bdrv_drain_all_begin(void)
         aio_context_acquire(aio_context);
         bdrv_parent_drained_begin(bs);
         aio_disable_external(aio_context);
+        bdrv_drain_invoke(bs, true);
         aio_context_release(aio_context);
 
         if (!g_slist_find(aio_ctxs, aio_context)) {
@@ -377,8 +378,6 @@ void bdrv_drain_all_begin(void)
             aio_context_acquire(aio_context);
             for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
                 if (aio_context == bdrv_get_aio_context(bs)) {
-                    /* FIXME Calling this multiple times is wrong */
-                    bdrv_drain_invoke(bs, true);
                     waited |= bdrv_drain_recurse(bs, true);
                 }
             }
-- 
2.13.6
