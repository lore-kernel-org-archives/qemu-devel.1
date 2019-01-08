Received: from eggs.gnu.org ([209.51.188.92]:35518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gguqM-000752-6n
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:07:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gguqL-0004iw-73
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:07:10 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  8 Jan 2019 20:06:49 +0300
Message-Id: <20190108170655.29766-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190108170655.29766-1-vsementsov@virtuozzo.com>
References: <20190108170655.29766-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 3/9] qcow2-threads: use thread_pool_submit_co
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, berrange@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org, pbonzini@redhat.com

Use thread_pool_submit_co, instead of reinventing it here. Note, that
thread_pool_submit_aio() never returns NULL, so checking it was an
extra thing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/qcow2-threads.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index dea9ac431c..20b2616529 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -144,17 +144,11 @@ static int qcow2_compress_pool_func(void *opaque)
     return 0;
 }
 
-static void qcow2_compress_complete(void *opaque, int ret)
-{
-    qemu_coroutine_enter(opaque);
-}
-
 static ssize_t coroutine_fn
 qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
                      const void *src, size_t src_size, Qcow2CompressFunc func)
 {
     BDRVQcow2State *s = bs->opaque;
-    BlockAIOCB *acb;
     ThreadPool *pool = aio_get_thread_pool(bdrv_get_aio_context(bs));
     Qcow2CompressData arg = {
         .dest = dest,
@@ -169,16 +163,9 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
     }
 
     s->nb_compress_threads++;
-    acb = thread_pool_submit_aio(pool, qcow2_compress_pool_func, &arg,
-                                 qcow2_compress_complete,
-                                 qemu_coroutine_self());
-
-    if (!acb) {
-        s->nb_compress_threads--;
-        return -EINVAL;
-    }
-    qemu_coroutine_yield();
+    thread_pool_submit_co(pool, qcow2_compress_pool_func, &arg);
     s->nb_compress_threads--;
+
     qemu_co_queue_next(&s->compress_wait_queue);
 
     return arg.ret;
-- 
2.18.0
