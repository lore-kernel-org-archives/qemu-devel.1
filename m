Received: from eggs.gnu.org ([2001:4830:134:3::10]:52285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCP2g-0006qP-Rk
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:05:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCP2b-0003eb-So
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 09:05:46 -0400
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Tue, 16 Oct 2018 19:03:38 +0600
Message-Id: <09ea4617167b5cc88f2a65cf3248ffbdab25093c.1539694545.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <442bb618199daa309d3191a5ee848e659a46c0ce.1539528213.git.artem.k.pisarenko@gmail.com>
References: <442bb618199daa309d3191a5ee848e659a46c0ce.1539528213.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH v2] Introduce attributes to qemu timer subsystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "open list:Block I/O path" <qemu-block@nongnu.org>

Attributes are simple flags, associated with individual timers for their whole lifetime.
They intended to be used to mark individual timers for special handling by various qemu features operating at qemu core level.
New/init functions family in timer interface updated and their comments improved to avoid info duplication.
Also existing aio interface extended with attribute-enabled variants of functions, which create/initialize timers.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---

Notes:
    v2:
    - timer creation/initialize functions reworked and and their unnecessary variants removed (as Paolo Bonzini suggested)
    - also their comments improved to avoid info duplication

 include/block/aio.h       |  53 ++++++++++++++++++-
 include/qemu/timer.h      | 126 ++++++++++++++++++++++++++--------------------
 tests/ptimer-test-stubs.c |   7 +--
 util/qemu-timer.c         |  12 +++--
 4 files changed, 136 insertions(+), 62 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index f08630c..07c291a 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -407,10 +407,38 @@ static inline QEMUTimer *aio_timer_new(AioContext *ctx, QEMUClockType type,
                                        int scale,
                                        QEMUTimerCB *cb, void *opaque)
 {
-    return timer_new_tl(ctx->tlg.tl[type], scale, cb, opaque);
+    return timer_new_full(type, ctx->tlg.tl[type],
+                          scale, 0, cb, opaque);
 }
 
 /**
+ * aio_timer_new_with_attrs:
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
+static inline QEMUTimer *aio_timer_new_with_attrs(AioContext *ctx,
+                                                  QEMUClockType type,
+                                                  int scale, int attributes,
+                                                  QEMUTimerCB *cb, void *opaque)
+{
+    return timer_new_full(type, ctx->tlg.tl[type],
+                          scale, attributes, cb, opaque);
+}
+
+
+/**
  * aio_timer_init:
  * @ctx: the aio context
  * @ts: the timer
@@ -427,7 +455,28 @@ static inline void aio_timer_init(AioContext *ctx,
                                   int scale,
                                   QEMUTimerCB *cb, void *opaque)
 {
-    timer_init_tl(ts, ctx->tlg.tl[type], scale, cb, opaque);
+    timer_init_full(ts, ctx->tlg.tl[type], scale, 0, cb, opaque);
+}
+
+/**
+ * aio_timer_init_with_attrs:
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
+static inline void aio_timer_init_with_attrs(AioContext *ctx,
+                                             QEMUTimer *ts, QEMUClockType type,
+                                             int scale, int attributes,
+                                             QEMUTimerCB *cb, void *opaque)
+{
+    timer_init_full(ts, ctx->tlg.tl[type], scale, attributes, cb, opaque);
 }
 
 /**
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 39ea907..64a84ea 100644
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
+ * instead each attribute in bit set accessed with QEMU_TIMER_ATTR_<id> macro,
+ * where <id> is a unique part of attribute identifier.
+ *
+ * No attributes defined currently.
+ */
+
+typedef enum {
+    QEMU_TIMER_ATTRBIT__NONE
+} QEMUTimerAttrBit;
+
+#define QEMU_TIMER_ATTR__NONE (1 << QEMU_TIMER_ATTRBIT__NONE)
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
 
@@ -418,22 +441,24 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg);
  */
 
 /**
- * timer_init_tl:
+ * timer_init_full:
  * @ts: the timer to be initialised
  * @timer_list: the timer list to attach the timer to
  * @scale: the scale value for the timer
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values to assign
  * @cb: the callback to be called when the timer expires
  * @opaque: the opaque pointer to be passed to the callback
  *
- * Initialise a new timer and associate it with @timer_list.
+ * Initialise a timer with the given scale and attributes,
+ * and associate it with @timer_list.
  * The caller is responsible for allocating the memory.
  *
  * You need not call an explicit deinit call. Simply make
  * sure it is not on a list with timer_del.
  */
-void timer_init_tl(QEMUTimer *ts,
-                   QEMUTimerList *timer_list, int scale,
-                   QEMUTimerCB *cb, void *opaque);
+void timer_init_full(QEMUTimer *ts,
+                     QEMUTimerList *timer_list, int scale, int attributes,
+                     QEMUTimerCB *cb, void *opaque);
 
 /**
  * timer_init:
@@ -445,14 +470,12 @@ void timer_init_tl(QEMUTimer *ts,
  *
  * Initialize a timer with the given scale on the default timer list
  * associated with the clock.
- *
- * You need not call an explicit deinit call. Simply make
- * sure it is not on a list with timer_del.
+ * See timer_init_full for details.
  */
 static inline void timer_init(QEMUTimer *ts, QEMUClockType type, int scale,
                               QEMUTimerCB *cb, void *opaque)
 {
-    timer_init_tl(ts, main_loop_tlg.tl[type], scale, cb, opaque);
+    timer_init_full(ts, main_loop_tlg.tl[type], scale, 0, cb, opaque);
 }
 
 /**
@@ -464,9 +487,7 @@ static inline void timer_init(QEMUTimer *ts, QEMUClockType type, int scale,
  *
  * Initialize a timer with nanosecond scale on the default timer list
  * associated with the clock.
- *
- * You need not call an explicit deinit call. Simply make
- * sure it is not on a list with timer_del.
+ * See timer_init_full for details.
  */
 static inline void timer_init_ns(QEMUTimer *ts, QEMUClockType type,
                                  QEMUTimerCB *cb, void *opaque)
@@ -483,9 +504,7 @@ static inline void timer_init_ns(QEMUTimer *ts, QEMUClockType type,
  *
  * Initialize a timer with microsecond scale on the default timer list
  * associated with the clock.
- *
- * You need not call an explicit deinit call. Simply make
- * sure it is not on a list with timer_del.
+ * See timer_init_full for details.
  */
 static inline void timer_init_us(QEMUTimer *ts, QEMUClockType type,
                                  QEMUTimerCB *cb, void *opaque)
@@ -502,9 +521,7 @@ static inline void timer_init_us(QEMUTimer *ts, QEMUClockType type,
  *
  * Initialize a timer with millisecond scale on the default timer list
  * associated with the clock.
- *
- * You need not call an explicit deinit call. Simply make
- * sure it is not on a list with timer_del.
+ * See timer_init_full for details.
  */
 static inline void timer_init_ms(QEMUTimer *ts, QEMUClockType type,
                                  QEMUTimerCB *cb, void *opaque)
@@ -513,27 +530,40 @@ static inline void timer_init_ms(QEMUTimer *ts, QEMUClockType type,
 }
 
 /**
- * timer_new_tl:
- * @timer_list: the timer list to attach the timer to
+ * timer_new_full:
+ * @type: the clock type to use
+ * @timer_list: (optional) the timer list to attach the timer to
  * @scale: the scale value for the timer
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values to assign
  * @cb: the callback to be called when the timer expires
  * @opaque: the opaque pointer to be passed to the callback
  *
- * Create a new timer and associate it with @timer_list.
+ * Create a new timer with the given scale and attributes,
+ * and associate it with @timer_list or, if NULL, default timer list for
+ * the clock type @type.
  * The memory is allocated by the function.
  *
  * This is not the preferred interface unless you know you
- * are going to call timer_free. Use timer_init instead.
+ * are going to call timer_free. Use timer_init or timer_init_full instead.
+ *
+ * The default timer list has one special feature: in icount mode,
+ * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
+ * not true of other timer lists, which are typically associated
+ * with an AioContext---each of them runs its timer callbacks in its own
+ * AioContext thread.
  *
  * Returns: a pointer to the timer
  */
-static inline QEMUTimer *timer_new_tl(QEMUTimerList *timer_list,
-                                      int scale,
-                                      QEMUTimerCB *cb,
-                                      void *opaque)
+static inline QEMUTimer *timer_new_full(QEMUClockType type,
+                                        QEMUTimerList *timer_list,
+                                        int scale, int attributes,
+                                        QEMUTimerCB *cb, void *opaque)
 {
     QEMUTimer *ts = g_malloc0(sizeof(QEMUTimer));
-    timer_init_tl(ts, timer_list, scale, cb, opaque);
+    if (!timer_list) {
+        timer_list = main_loop_tlg.tl[type];
+    }
+    timer_init_full(ts, timer_list, scale, attributes, cb, opaque);
     return ts;
 }
 
@@ -544,21 +574,16 @@ static inline QEMUTimer *timer_new_tl(QEMUTimerList *timer_list,
  * @cb: the callback to be called when the timer expires
  * @opaque: the opaque pointer to be passed to the callback
  *
- * Create a new timer and associate it with the default
- * timer list for the clock type @type.
- *
- * The default timer list has one special feature: in icount mode,
- * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
- * not true of other timer lists, which are typically associated
- * with an AioContext---each of them runs its timer callbacks in its own
- * AioContext thread.
+ * Create a new timer with the given scale,
+ * and associate it with the default timer list for the clock type @type.
+ * See timer_new_full for details.
  *
  * Returns: a pointer to the timer
  */
 static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
                                    QEMUTimerCB *cb, void *opaque)
 {
-    return timer_new_tl(main_loop_tlg.tl[type], scale, cb, opaque);
+    return timer_new_full(type, main_loop_tlg.tl[type], scale, 0, cb, opaque);
 }
 
 /**
@@ -569,12 +594,7 @@ static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
  *
  * Create a new timer with nanosecond scale on the default timer list
  * associated with the clock.
- *
- * The default timer list has one special feature: in icount mode,
- * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
- * not true of other timer lists, which are typically associated
- * with an AioContext---each of them runs its timer callbacks in its own
- * AioContext thread.
+ * See timer_new_full for details.
  *
  * Returns: a pointer to the newly created timer
  */
@@ -590,14 +610,9 @@ static inline QEMUTimer *timer_new_ns(QEMUClockType type, QEMUTimerCB *cb,
  * @cb: the callback to call when the timer expires
  * @opaque: the opaque pointer to pass to the callback
  *
- * The default timer list has one special feature: in icount mode,
- * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
- * not true of other timer lists, which are typically associated
- * with an AioContext---each of them runs its timer callbacks in its own
- * AioContext thread.
- *
  * Create a new timer with microsecond scale on the default timer list
  * associated with the clock.
+ * See timer_new_full for details.
  *
  * Returns: a pointer to the newly created timer
  */
@@ -613,14 +628,9 @@ static inline QEMUTimer *timer_new_us(QEMUClockType type, QEMUTimerCB *cb,
  * @cb: the callback to call when the timer expires
  * @opaque: the opaque pointer to pass to the callback
  *
- * The default timer list has one special feature: in icount mode,
- * %QEMU_CLOCK_VIRTUAL timers are run in the vCPU thread.  This is
- * not true of other timer lists, which are typically associated
- * with an AioContext---each of them runs its timer callbacks in its own
- * AioContext thread.
- *
  * Create a new timer with millisecond scale on the default timer list
  * associated with the clock.
+ * See timer_new_full for details.
  *
  * Returns: a pointer to the newly created timer
  */
@@ -631,6 +641,14 @@ static inline QEMUTimer *timer_new_ms(QEMUClockType type, QEMUTimerCB *cb,
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
index ca5cc3b..2b60216 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -34,14 +34,15 @@ int64_t ptimer_test_time_ns;
 int use_icount = 1;
 bool qtest_allowed;
 
-void timer_init_tl(QEMUTimer *ts,
-                   QEMUTimerList *timer_list, int scale,
-                   QEMUTimerCB *cb, void *opaque)
+void timer_init_full(QEMUTimer *ts,
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
 
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 86bfe84..c579b05 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -339,17 +339,23 @@ int qemu_poll_ns(GPollFD *fds, guint nfds, int64_t timeout)
 }
 
 
-void timer_init_tl(QEMUTimer *ts,
-                   QEMUTimerList *timer_list, int scale,
-                   QEMUTimerCB *cb, void *opaque)
+void timer_init_full(QEMUTimer *ts,
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
