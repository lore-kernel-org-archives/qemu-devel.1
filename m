Received: from eggs.gnu.org ([2001:4830:134:3::10]:56744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gBhpM-0000Bw-9H
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:57:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gBhpF-0003KL-Qk
	for qemu-devel@nongnu.org; Sun, 14 Oct 2018 10:57:08 -0400
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Sun, 14 Oct 2018 20:55:08 +0600
Message-Id: <442bb618199daa309d3191a5ee848e659a46c0ce.1539528213.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
References: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
References: <cover.1539528213.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH 2/3] Introduce attributes to qemu timer
 subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>, Artem Pisarenko <artem.k.pisarenko@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>

Attributes are simple flags, associated with individual timers for their whole lifetime.
They intended to be used to mark individual timers for special handling by various qemu features operating at qemu core level.
Existing timer, aio and coroutine interface extended with attribute-enabled variants of functions, which create/initialize timers.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---

Notes:
    Conversion and association between QEMUTimerAttrBit and accessor macro are dumb.
    Maybe better alternatives exist (like QFlags in Qt framework) or existing qemu code may be reused, if any.
    Attributes also may be better named as flags, but they looks like something volatile, whereas 'attribute' expresses constant nature better.

 include/block/aio.h         |  50 +++++++++++++++++++-
 include/qemu/coroutine.h    |   5 +-
 include/qemu/timer.h        | 110 ++++++++++++++++++++++++++++++++++++++------
 tests/ptimer-test-stubs.c   |   7 +--
 util/qemu-coroutine-sleep.c |   6 ++-
 util/qemu-timer.c           |  12 +++--
 6 files changed, 165 insertions(+), 25 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index f08630c..a6be3fb 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -407,10 +407,35 @@ static inline QEMUTimer *aio_timer_new(AioContext *ctx, QEMUClockType type,
                                        int scale,
                                        QEMUTimerCB *cb, void *opaque)
 {
-    return timer_new_tl(ctx->tlg.tl[type], scale, cb, opaque);
+    return timer_new_a_tl(ctx->tlg.tl[type], scale, 0, cb, opaque);
 }
 
 /**
+ * aio_timer_new_a:
+ * @ctx: the aio context
+ * @type: the clock type
+ * @scale: the scale
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values to assign
+ * @cb: the callback to call on timer expiry
+ * @opaque: the opaque pointer to pass to the callback
+ *
+ * Allocate a new timer (with attributes) attached to the context @ctx.
+ * The function is responsible for memory allocation.
+ *
+ * The preferred interface is aio_timer_init. Use that
+ * unless you really need dynamic memory allocation.
+ *
+ * Returns: a pointer to the new timer
+ */
+static inline QEMUTimer *aio_timer_new_a(AioContext *ctx, QEMUClockType type,
+                                         int scale, int attributes,
+                                         QEMUTimerCB *cb, void *opaque)
+{
+    return timer_new_a_tl(ctx->tlg.tl[type], scale, attributes, cb, opaque);
+}
+
+
+/**
  * aio_timer_init:
  * @ctx: the aio context
  * @ts: the timer
@@ -427,7 +452,28 @@ static inline void aio_timer_init(AioContext *ctx,
                                   int scale,
                                   QEMUTimerCB *cb, void *opaque)
 {
-    timer_init_tl(ts, ctx->tlg.tl[type], scale, cb, opaque);
+    timer_init_a_tl(ts, ctx->tlg.tl[type], scale, 0, cb, opaque);
+}
+
+/**
+ * aio_timer_init_a:
+ * @ctx: the aio context
+ * @ts: the timer
+ * @type: the clock type
+ * @scale: the scale
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values to assign
+ * @cb: the callback to call on timer expiry
+ * @opaque: the opaque pointer to pass to the callback
+ *
+ * Initialise a new timer (with attributes) attached to the context @ctx.
+ * The caller is responsible for memory allocation.
+ */
+static inline void aio_timer_init_a(AioContext *ctx,
+                                    QEMUTimer *ts, QEMUClockType type,
+                                    int scale, int attributes,
+                                    QEMUTimerCB *cb, void *opaque)
+{
+    timer_init_a_tl(ts, ctx->tlg.tl[type], scale, attributes, cb, opaque);
 }
 
 /**
diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index 9801e7f..cffc2b2 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -276,7 +276,10 @@ void qemu_co_rwlock_unlock(CoRwlock *lock);
 /**
  * Yield the coroutine for a given duration
  */
-void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
+#define qemu_co_sleep_ns(type, ns) \
+    qemu_co_sleep_a_ns(type, 0, ns)
+void coroutine_fn qemu_co_sleep_a_ns(QEMUClockType type, int attributes,
+                                     int64_t ns);
 
 /**
  * Yield until a file descriptor becomes readable
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 39ea907..031e3a1 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -52,6 +52,28 @@ typedef enum {
     QEMU_CLOCK_MAX
 } QEMUClockType;
 
+/**
+ * QEMU Timer attributes:
+ *
+ * An individual timer may be assigned with one or multiple attributes when
+ * initialized.
+ * Attribute is a static flag, meaning that timer has corresponding property.
+ * Attributes are defined in QEMUTimerAttrBit enum and encoded to bit set,
+ * which used to initialize timer, stored to 'attributes' member and can be
+ * retrieved externally with timer_get_attributes() call.
+ * Values of QEMUTimerAttrBit aren't used directly,
+ * instead each attribute in bit set accessed with QEMU_TIMER_ATTR(id) macro,
+ * where 'id' is a unique part of attribute identifier.
+ *
+ * No attributes defined currently.
+ */
+
+typedef enum {
+    /* none */
+} QEMUTimerAttrBit;
+
+#define QEMU_TIMER_ATTR(id) (1 << QEMU_TIMER_ATTRBIT_ ## id)
+
 typedef struct QEMUTimerList QEMUTimerList;
 
 struct QEMUTimerListGroup {
@@ -67,6 +89,7 @@ struct QEMUTimer {
     QEMUTimerCB *cb;
     void *opaque;
     QEMUTimer *next;
+    int attributes;
     int scale;
 };
 
@@ -418,10 +441,11 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg);
  */
 
 /**
- * timer_init_tl:
+ * timer_init_a_tl:
  * @ts: the timer to be initialised
  * @timer_list: the timer list to attach the timer to
  * @scale: the scale value for the timer
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values to assign
  * @cb: the callback to be called when the timer expires
  * @opaque: the opaque pointer to be passed to the callback
  *
@@ -431,9 +455,9 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg);
  * You need not call an explicit deinit call. Simply make
  * sure it is not on a list with timer_del.
  */
-void timer_init_tl(QEMUTimer *ts,
-                   QEMUTimerList *timer_list, int scale,
-                   QEMUTimerCB *cb, void *opaque);
+void timer_init_a_tl(QEMUTimer *ts,
+                     QEMUTimerList *timer_list, int scale, int attributes,
+                     QEMUTimerCB *cb, void *opaque);
 
 /**
  * timer_init:
@@ -452,7 +476,29 @@ void timer_init_tl(QEMUTimer *ts,
 static inline void timer_init(QEMUTimer *ts, QEMUClockType type, int scale,
                               QEMUTimerCB *cb, void *opaque)
 {
-    timer_init_tl(ts, main_loop_tlg.tl[type], scale, cb, opaque);
+    timer_init_a_tl(ts, main_loop_tlg.tl[type], scale, 0, cb, opaque);
+}
+
+/**
+ * timer_init_a:
+ * @ts: the timer to be initialised
+ * @type: the clock to associate with the timer
+ * @scale: the scale value for the timer
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values to assign
+ * @cb: the callback to call when the timer expires
+ * @opaque: the opaque pointer to pass to the callback
+ *
+ * Initialize a timer with the given scale and attributes on the default
+ * timer list associated with the clock.
+ *
+ * You need not call an explicit deinit call. Simply make
+ * sure it is not on a list with timer_del.
+ */
+static inline void timer_init_a(QEMUTimer *ts, QEMUClockType type,
+                                int scale, int attributes,
+                                QEMUTimerCB *cb, void *opaque)
+{
+    timer_init_a_tl(ts, main_loop_tlg.tl[type], scale, attributes, cb, opaque);
 }
 
 /**
@@ -513,9 +559,10 @@ static inline void timer_init_ms(QEMUTimer *ts, QEMUClockType type,
 }
 
 /**
- * timer_new_tl:
+ * timer_new_a_tl:
  * @timer_list: the timer list to attach the timer to
  * @scale: the scale value for the timer
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values to assign
  * @cb: the callback to be called when the timer expires
  * @opaque: the opaque pointer to be passed to the callback
  *
@@ -527,13 +574,13 @@ static inline void timer_init_ms(QEMUTimer *ts, QEMUClockType type,
  *
  * Returns: a pointer to the timer
  */
-static inline QEMUTimer *timer_new_tl(QEMUTimerList *timer_list,
-                                      int scale,
-                                      QEMUTimerCB *cb,
-                                      void *opaque)
+static inline QEMUTimer *timer_new_a_tl(QEMUTimerList *timer_list,
+                                        int scale, int attributes,
+                                        QEMUTimerCB *cb,
+                                        void *opaque)
 {
     QEMUTimer *ts = g_malloc0(sizeof(QEMUTimer));
-    timer_init_tl(ts, timer_list, scale, cb, opaque);
+    timer_init_a_tl(ts, timer_list, scale, attributes, cb, opaque);
     return ts;
 }
 
@@ -544,8 +591,8 @@ static inline QEMUTimer *timer_new_tl(QEMUTimerList *timer_list,
  * @cb: the callback to be called when the timer expires
  * @opaque: the opaque pointer to be passed to the callback
  *
- * Create a new timer and associate it with the default
- * timer list for the clock type @type.
+ * Create a new timer with the given scale,
+ * and associate it with the default timer list for the clock type @type.
  *
  * The default timer list has one special feature: in icount mode,
  * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
@@ -558,7 +605,34 @@ static inline QEMUTimer *timer_new_tl(QEMUTimerList *timer_list,
 static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
                                    QEMUTimerCB *cb, void *opaque)
 {
-    return timer_new_tl(main_loop_tlg.tl[type], scale, cb, opaque);
+    return timer_new_a_tl(main_loop_tlg.tl[type], scale, 0, cb, opaque);
+}
+
+/**
+ * timer_new_a:
+ * @type: the clock type to use
+ * @scale: the scale value for the timer
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values to assign
+ * @cb: the callback to be called when the timer expires
+ * @opaque: the opaque pointer to be passed to the callback
+ *
+ * Create a new timer with the given scale and attributes,
+ * and associate it with the default timer list for the clock type @type.
+ *
+ * The default timer list has one special feature: in icount mode,
+ * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
+ * not true of other timer lists, which are typically associated
+ * with an AioContext---each of them runs its timer callbacks in its own
+ * AioContext thread.
+ *
+ * Returns: a pointer to the timer
+ */
+static inline QEMUTimer *timer_new_a(QEMUClockType type,
+                                     int scale, int attributes,
+                                     QEMUTimerCB *cb, void *opaque)
+{
+    return timer_new_a_tl(main_loop_tlg.tl[type],
+                          scale, attributes, cb, opaque);
 }
 
 /**
@@ -631,6 +705,14 @@ static inline QEMUTimer *timer_new_ms(QEMUClockType type, QEMUTimerCB *cb,
 }
 
 /**
+ * timer_get_attributes:
+ * @ts: the timer
+ *
+ * Return 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values
+ */
+int timer_get_attributes(QEMUTimer *ts);
+
+/**
  * timer_deinit:
  * @ts: the timer to be de-initialised
  *
diff --git a/tests/ptimer-test-stubs.c b/tests/ptimer-test-stubs.c
index ca5cc3b..5c5a7f7 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -34,14 +34,15 @@ int64_t ptimer_test_time_ns;
 int use_icount = 1;
 bool qtest_allowed;
 
-void timer_init_tl(QEMUTimer *ts,
-                   QEMUTimerList *timer_list, int scale,
-                   QEMUTimerCB *cb, void *opaque)
+void timer_init_a_tl(QEMUTimer *ts,
+                     QEMUTimerList *timer_list, int scale, int attributes,
+                     QEMUTimerCB *cb, void *opaque)
 {
     ts->timer_list = timer_list;
     ts->cb = cb;
     ts->opaque = opaque;
     ts->scale = scale;
+    ts->attributes = attributes;
     ts->expire_time = -1;
 }
 
diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
index afb678f..d54ed09 100644
--- a/util/qemu-coroutine-sleep.c
+++ b/util/qemu-coroutine-sleep.c
@@ -31,7 +31,8 @@ static void co_sleep_cb(void *opaque)
     aio_co_wake(sleep_cb->co);
 }
 
-void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
+void coroutine_fn qemu_co_sleep_a_ns(QEMUClockType type, int attributes,
+                                     int64_t ns)
 {
     AioContext *ctx = qemu_get_current_aio_context();
     CoSleepCB sleep_cb = {
@@ -46,7 +47,8 @@ void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
                 __func__, scheduled);
         abort();
     }
-    sleep_cb.ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &sleep_cb);
+    sleep_cb.ts = aio_timer_new_a(ctx, type, SCALE_NS, attributes,
+                                  co_sleep_cb, &sleep_cb);
     timer_mod(sleep_cb.ts, qemu_clock_get_ns(type) + ns);
     qemu_coroutine_yield();
     timer_del(sleep_cb.ts);
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 86bfe84..29d8e39 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -339,17 +339,23 @@ int qemu_poll_ns(GPollFD *fds, guint nfds, int64_t timeout)
 }
 
 
-void timer_init_tl(QEMUTimer *ts,
-                   QEMUTimerList *timer_list, int scale,
-                   QEMUTimerCB *cb, void *opaque)
+void timer_init_a_tl(QEMUTimer *ts,
+                     QEMUTimerList *timer_list, int scale, int attributes,
+                     QEMUTimerCB *cb, void *opaque)
 {
     ts->timer_list = timer_list;
     ts->cb = cb;
     ts->opaque = opaque;
     ts->scale = scale;
+    ts->attributes = attributes;
     ts->expire_time = -1;
 }
 
+int timer_get_attributes(QEMUTimer *ts)
+{
+    return ts->attributes;
+}
+
 void timer_deinit(QEMUTimer *ts)
 {
     assert(ts->expire_time == -1);
-- 
2.7.4
