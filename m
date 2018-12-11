Received: from eggs.gnu.org ([2001:4830:134:3::10]:42056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWl85-0001u8-CX
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:43:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gWl84-0004K0-AH
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 11:43:29 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 11 Dec 2018 19:43:12 +0300
Message-Id: <20181211164317.32893-4-vsementsov@virtuozzo.com>
In-Reply-To: <20181211164317.32893-1-vsementsov@virtuozzo.com>
References: <20181211164317.32893-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 3/8] qcow2-threads: use thread_pool_submit_co
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, berrange@redhat.com, berto@igalia.com, vsementsov@virtuozzo.com, den@openvz.org

Use thread_pool_submit_co, instead of reinventing it here. Note, that
thread_pool_submit_aio() never returns an error, so checking it was an
extra thing.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-threads.c | 17 ++---------------
 1 file changed, 2 insertions(+), 15 deletions(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index b75fad6e07..8c10191f2f 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -140,17 +140,11 @@ static int qcow2_compress_pool_func(void *opaque)
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
@@ -165,16 +159,9 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
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
