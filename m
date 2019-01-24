Received: from eggs.gnu.org ([209.51.188.92]:37938)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmcGS-0001sD-HR
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:29:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gmcGR-0001DY-J3
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 05:29:40 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 24 Jan 2019 10:29:00 +0000
Message-Id: <20190124102900.20079-4-stefanha@redhat.com>
In-Reply-To: <20190124102900.20079-1-stefanha@redhat.com>
References: <20190124102900.20079-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/3] qemu-coroutine-sleep: drop CoSleepCB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>, qemu-block@nongnu.org, Alberto Garcia <berto@igalia.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Drop CoSleepCB structure. It's actually unused.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-id: 20190122143113.20331-1-vsementsov@virtuozzo.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
=20
-typedef struct CoSleepCB {
-    QEMUTimer *ts;
-    Coroutine *co;
-} CoSleepCB;
-
 static void co_sleep_cb(void *opaque)
 {
-    CoSleepCB *sleep_cb =3D opaque;
+    Coroutine *co =3D opaque;
=20
     /* Write of schedule protected by barrier write in aio_co_schedule *=
/
-    atomic_set(&sleep_cb->co->scheduled, NULL);
-    aio_co_wake(sleep_cb->co);
+    atomic_set(&co->scheduled, NULL);
+    aio_co_wake(co);
 }
=20
 void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
 {
     AioContext *ctx =3D qemu_get_current_aio_context();
-    CoSleepCB sleep_cb =3D {
-        .co =3D qemu_coroutine_self(),
-    };
+    QEMUTimer *ts;
+    Coroutine *co =3D qemu_coroutine_self();
=20
-    const char *scheduled =3D atomic_cmpxchg(&sleep_cb.co->scheduled, NU=
LL,
-                                           __func__);
+    const char *scheduled =3D atomic_cmpxchg(&co->scheduled, NULL, __fun=
c__);
     if (scheduled) {
         fprintf(stderr,
                 "%s: Co-routine was already scheduled in '%s'\n",
                 __func__, scheduled);
         abort();
     }
-    sleep_cb.ts =3D aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &sle=
ep_cb);
-    timer_mod(sleep_cb.ts, qemu_clock_get_ns(type) + ns);
+    ts =3D aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, co);
+    timer_mod(ts, qemu_clock_get_ns(type) + ns);
     qemu_coroutine_yield();
-    timer_del(sleep_cb.ts);
-    timer_free(sleep_cb.ts);
+    timer_del(ts);
+    timer_free(ts);
 }
--=20
2.20.1
