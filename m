Received: from eggs.gnu.org ([2001:4830:134:3::10]:48860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0UdV-0002Cm-3f
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:01:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d0UdU-0003vE-7i
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:01:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46096)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d0UdU-0003uJ-1B
	for qemu-devel@nongnu.org; Tue, 18 Apr 2017 11:01:44 -0400
From: Fam Zheng <famz@redhat.com>
Date: Tue, 18 Apr 2017 23:01:32 +0800
Message-Id: <20170418150133.22436-2-famz@redhat.com>
In-Reply-To: <20170418150133.22436-1-famz@redhat.com>
References: <20170418150133.22436-1-famz@redhat.com>
Subject: [Qemu-devel] [PULL 1/2] block: Walk bs->children carefully in
 bdrv_drain_recurse
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Fam Zheng <famz@redhat.com>

The recursive bdrv_drain_recurse may run a block job completion BH that
drops nodes. The coming changes will make that more likely and use-after-free
would happen without this patch

Stash the bs pointer and use bdrv_ref/bdrv_unref in addition to
QLIST_FOREACH_SAFE to prevent such a case from happening.

Since bdrv_unref accesses global state that is not protected by the AioContext
lock, we cannot use bdrv_ref/bdrv_unref unconditionally.  Fortunately the
protection is not needed in IOThread because only main loop can modify a graph
with the AioContext lock held.

Signed-off-by: Fam Zheng <famz@redhat.com>
Message-Id: <20170418143044.12187-2-famz@redhat.com>
Reviewed-by: Jeff Cody <jcody@redhat.com>
Tested-by: Jeff Cody <jcody@redhat.com>
Signed-off-by: Fam Zheng <famz@redhat.com>
---
 block/io.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/block/io.c b/block/io.c
index 8706bfa..a7142e0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -158,7 +158,7 @@ bool bdrv_requests_pending(BlockDriverState *bs)
 
 static bool bdrv_drain_recurse(BlockDriverState *bs)
 {
-    BdrvChild *child;
+    BdrvChild *child, *tmp;
     bool waited;
 
     waited = BDRV_POLL_WHILE(bs, atomic_read(&bs->in_flight) > 0);
@@ -167,8 +167,25 @@ static bool bdrv_drain_recurse(BlockDriverState *bs)
         bs->drv->bdrv_drain(bs);
     }
 
-    QLIST_FOREACH(child, &bs->children, next) {
-        waited |= bdrv_drain_recurse(child->bs);
+    QLIST_FOREACH_SAFE(child, &bs->children, next, tmp) {
+        BlockDriverState *bs = child->bs;
+        bool in_main_loop =
+            qemu_get_current_aio_context() == qemu_get_aio_context();
+        assert(bs->refcnt > 0);
+        if (in_main_loop) {
+            /* In case the recursive bdrv_drain_recurse processes a
+             * block_job_defer_to_main_loop BH and modifies the graph,
+             * let's hold a reference to bs until we are done.
+             *
+             * IOThread doesn't have such a BH, and it is not safe to call
+             * bdrv_unref without BQL, so skip doing it there.
+             */
+            bdrv_ref(bs);
+        }
+        waited |= bdrv_drain_recurse(bs);
+        if (in_main_loop) {
+            bdrv_unref(bs);
+        }
     }
 
     return waited;
-- 
2.9.3
