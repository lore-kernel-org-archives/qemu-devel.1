Received: from eggs.gnu.org ([2001:4830:134:3::10]:39415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbj2-0004k0-8V
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eRbj0-0005BO-JU
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 05:35:48 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 20 Dec 2017 11:34:02 +0100
Message-Id: <20171220103412.13048-10-kwolf@redhat.com>
In-Reply-To: <20171220103412.13048-1-kwolf@redhat.com>
References: <20171220103412.13048-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PATCH 09/19] block: Nested drain_end must still call
 callbacks
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, famz@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org

bdrv_do_drained_begin() restricts the call of parent callbacks and
aio_disable_external() to the outermost drain section, but the block
driver callbacks are always called. bdrv_do_drained_end() must match
this behaviour, otherwise nodes stay drained even if begin/end calls
were balanced.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index 74d2e5278e..6038a16c58 100644
--- a/block/io.c
+++ b/block/io.c
@@ -273,19 +273,21 @@ void bdrv_drained_begin(BlockDriverState *bs)
 
 void bdrv_drained_end(BlockDriverState *bs)
 {
+    int old_quiesce_counter;
+
     if (qemu_in_coroutine()) {
         bdrv_co_yield_to_drain(bs, false);
         return;
     }
     assert(bs->quiesce_counter > 0);
-    if (atomic_fetch_dec(&bs->quiesce_counter) > 1) {
-        return;
-    }
+    old_quiesce_counter = atomic_fetch_dec(&bs->quiesce_counter);
 
     /* Re-enable things in child-to-parent order */
     bdrv_drain_invoke(bs, false, false);
-    bdrv_parent_drained_end(bs);
-    aio_enable_external(bdrv_get_aio_context(bs));
+    if (old_quiesce_counter == 1) {
+        bdrv_parent_drained_end(bs);
+        aio_enable_external(bdrv_get_aio_context(bs));
+    }
 }
 
 /*
-- 
2.13.6
