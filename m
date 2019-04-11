Received: from eggs.gnu.org ([209.51.188.92]:50426)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTm-0004ZH-Vt
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hEdTl-0003bl-Qs
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 13:27:14 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Thu, 11 Apr 2019 20:27:07 +0300
Message-Id: <20190411172709.205032-6-vsementsov@virtuozzo.com>
In-Reply-To: <20190411172709.205032-1-vsementsov@virtuozzo.com>
References: <20190411172709.205032-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v6 5/7] qemu-coroutine-sleep: introduce
 qemu_co_sleep_wake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: armbru@redhat.com, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, eblake@redhat.com, vsementsov@virtuozzo.com, den@openvz.org

Introduce a function to gracefully wake-up a coroutine, sleeping in
qemu_co_sleep_ns() sleep.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/qemu/coroutine.h    |  6 ++++++
 util/qemu-coroutine-sleep.c | 20 ++++++++++++++++----
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9801e7f5a4..ec765c26f0 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -278,6 +278,12 @@ void qemu_co_rwlock_unlock(CoRwlock *lock);
  */
 void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
 
+/*
+ * Wake a coroutine if it is sleeping by qemu_co_sleep_ns. Timer will be
+ * deleted.
+ */
+void qemu_co_sleep_wake(Coroutine *co);
+
 /**
  * Yield until a file descriptor becomes readable
  *
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index 4bfdd30cbf..bcc6afca3e 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -17,13 +17,24 @@
 #include "qemu/timer.h"
 #include "block/aio.h"
 
+const char *qemu_co_sleep_ns__scheduled = "qemu_co_sleep_ns";
+
+void qemu_co_sleep_wake(Coroutine *co)
+{
+    /* Write of schedule protected by barrier write in aio_co_schedule */
+    const char *scheduled = atomic_cmpxchg(&co->scheduled,
+                                           qemu_co_sleep_ns__scheduled, NULL);
+
+    if (scheduled == qemu_co_sleep_ns__scheduled) {
+        aio_co_wake(co);
+    }
+}
+
 static void co_sleep_cb(void *opaque)
 {
     Coroutine *co = opaque;
 
-    /* Write of schedule protected by barrier write in aio_co_schedule */
-    atomic_set(&co->scheduled, NULL);
-    aio_co_wake(co);
+    qemu_co_sleep_wake(co);
 }
 
 void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
@@ -32,7 +43,8 @@ void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
     QEMUTimer *ts;
     Coroutine *co = qemu_coroutine_self();
 
-    const char *scheduled = atomic_cmpxchg(&co->scheduled, NULL, __func__);
+    const char *scheduled = atomic_cmpxchg(&co->scheduled, NULL,
+                                           qemu_co_sleep_ns__scheduled);
     if (scheduled) {
         fprintf(stderr,
                 "%s: Co-routine was already scheduled in '%s'\n",
-- 
2.18.0
