Received: from eggs.gnu.org ([209.51.188.92]:35519)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gguqM-000753-6q
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:07:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gguqJ-0004ev-7a
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 12:07:09 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue,  8 Jan 2019 20:06:50 +0300
Message-Id: <20190108170655.29766-5-vsementsov@virtuozzo.com>
In-Reply-To: <20190108170655.29766-1-vsementsov@virtuozzo.com>
References: <20190108170655.29766-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v3 4/9] qcow2-threads: qcow2_co_do_compress:
 protect queuing by mutex
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

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/qcow2-threads.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-threads.c b/block/qcow2-threads.c
index 20b2616529..156e0667be 100644
--- a/block/qcow2-threads.c
+++ b/block/qcow2-threads.c
@@ -158,15 +158,19 @@ qcow2_co_do_compress(BlockDriverState *bs, void *dest, size_t dest_size,
         .func = func,
     };
 
+    qemu_co_mutex_lock(&s->lock);
     while (s->nb_compress_threads >= MAX_COMPRESS_THREADS) {
-        qemu_co_queue_wait(&s->compress_wait_queue, NULL);
+        qemu_co_queue_wait(&s->compress_wait_queue, &s->lock);
     }
-
     s->nb_compress_threads++;
+    qemu_co_mutex_unlock(&s->lock);
+
     thread_pool_submit_co(pool, qcow2_compress_pool_func, &arg);
-    s->nb_compress_threads--;
 
+    qemu_co_mutex_lock(&s->lock);
+    s->nb_compress_threads--;
     qemu_co_queue_next(&s->compress_wait_queue);
+    qemu_co_mutex_unlock(&s->lock);
 
     return arg.ret;
 }
-- 
2.18.0
