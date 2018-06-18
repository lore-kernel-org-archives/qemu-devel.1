Received: from eggs.gnu.org ([2001:4830:134:3::10]:51944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHT-0004w3-EF
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fUxHR-0006JQ-T1
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:45:27 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 18 Jun 2018 18:44:43 +0200
Message-Id: <20180618164504.24488-15-kwolf@redhat.com>
In-Reply-To: <20180618164504.24488-1-kwolf@redhat.com>
References: <20180618164504.24488-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 14/35] block: Defer .bdrv_drain_begin callback
 to polling phase
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

We cannot allow aio_poll() in bdrv_drain_invoke(begin=true) until we're
done with propagating the drain through the graph and are doing the
single final BDRV_POLL_WHILE().

Just schedule the coroutine with the callback and increase bs->in_flight
to make sure that the polling phase will wait for it.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/io.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/block/io.c b/block/io.c
index ffb273708a..e08d53c8a5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -182,22 +182,40 @@ static void coroutine_fn bdrv_drain_invoke_entry(void *opaque)
 
     /* Set data->done before reading bs->wakeup.  */
     atomic_mb_set(&data->done, true);
-    bdrv_wakeup(bs);
+    bdrv_dec_in_flight(bs);
+
+    if (data->begin) {
+        g_free(data);
+    }
 }
 
 /* Recursively call BlockDriver.bdrv_co_drain_begin/end callbacks */
 static void bdrv_drain_invoke(BlockDriverState *bs, bool begin)
 {
-    BdrvCoDrainData data = { .bs = bs, .done = false, .begin = begin};
+    BdrvCoDrainData *data;
 
     if (!bs->drv || (begin && !bs->drv->bdrv_co_drain_begin) ||
             (!begin && !bs->drv->bdrv_co_drain_end)) {
         return;
     }
 
-    data.co = qemu_coroutine_create(bdrv_drain_invoke_entry, &data);
-    bdrv_coroutine_enter(bs, data.co);
-    BDRV_POLL_WHILE(bs, !data.done);
+    data = g_new(BdrvCoDrainData, 1);
+    *data = (BdrvCoDrainData) {
+        .bs = bs,
+        .done = false,
+        .begin = begin
+    };
+
+    /* Make sure the driver callback completes during the polling phase for
+     * drain_begin. */
+    bdrv_inc_in_flight(bs);
+    data->co = qemu_coroutine_create(bdrv_drain_invoke_entry, data);
+    aio_co_schedule(bdrv_get_aio_context(bs), data->co);
+
+    if (!begin) {
+        BDRV_POLL_WHILE(bs, !data->done);
+        g_free(data);
+    }
 }
 
 /* Returns true if BDRV_POLL_WHILE() should go into a blocking aio_poll() */
-- 
2.13.6
