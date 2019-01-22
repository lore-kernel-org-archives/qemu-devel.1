Received: from eggs.gnu.org ([209.51.188.92]:47679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gm1p2-000148-JP
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:34:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1gm1oz-00024S-Hd
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:34:54 -0500
Received: from relay.sw.ru ([185.231.240.75]:36578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1gm1ov-0001ey-5N
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 14:34:50 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Tue, 22 Jan 2019 17:31:13 +0300
Message-Id: <20190122143113.20331-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH] qemu-coroutine-sleep: drop CoSleepCB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kwolf@redhat.com, stefanha@redhat.com, vsementsov@virtuozzo.com

Drop CoSleepCB structure. It's actually unused.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 util/qemu-coroutine-sleep.c | 27 ++++++++++-----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index afb678fbe5..4bfdd30cbf 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -17,38 +17,31 @@
 #include "qemu/timer.h"
 #include "block/aio.h"
 
-typedef struct CoSleepCB {
-    QEMUTimer *ts;
-    Coroutine *co;
-} CoSleepCB;
-
 static void co_sleep_cb(void *opaque)
 {
-    CoSleepCB *sleep_cb = opaque;
+    Coroutine *co = opaque;
 
     /* Write of schedule protected by barrier write in aio_co_schedule */
-    atomic_set(&sleep_cb->co->scheduled, NULL);
-    aio_co_wake(sleep_cb->co);
+    atomic_set(&co->scheduled, NULL);
+    aio_co_wake(co);
 }
 
 void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
 {
     AioContext *ctx = qemu_get_current_aio_context();
-    CoSleepCB sleep_cb = {
-        .co = qemu_coroutine_self(),
-    };
+    QEMUTimer *ts;
+    Coroutine *co = qemu_coroutine_self();
 
-    const char *scheduled = atomic_cmpxchg(&sleep_cb.co->scheduled, NULL,
-                                           __func__);
+    const char *scheduled = atomic_cmpxchg(&co->scheduled, NULL, __func__);
     if (scheduled) {
         fprintf(stderr,
                 "%s: Co-routine was already scheduled in '%s'\n",
                 __func__, scheduled);
         abort();
     }
-    sleep_cb.ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &sleep_cb);
-    timer_mod(sleep_cb.ts, qemu_clock_get_ns(type) + ns);
+    ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, co);
+    timer_mod(ts, qemu_clock_get_ns(type) + ns);
     qemu_coroutine_yield();
-    timer_del(sleep_cb.ts);
-    timer_free(sleep_cb.ts);
+    timer_del(ts);
+    timer_free(ts);
 }
-- 
2.18.0
