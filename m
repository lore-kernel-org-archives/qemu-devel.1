Received: from eggs.gnu.org ([2001:4830:134:3::10]:50650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCh9H-00073t-Mw
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <artem.k.pisarenko@gmail.com>) id 1gCh9F-0008Hn-UM
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 04:25:47 -0400
From: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Date: Wed, 17 Oct 2018 14:24:19 +0600
Message-Id: <f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
In-Reply-To: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
References: <cover.1539764043.git.artem.k.pisarenko@gmail.com>
Subject: [Qemu-devel] [PATCH v2 2/4] Introduce attributes to qemu timer
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
New/init functions family in timer interface updated and refactored (new 'attribute' argument added, timer_list replaced with timer_list_group+type combinations, comments improved to avoid info duplication).
Also existing aio interface extended with attribute-enabled variants of functions, which create/initialize timers.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
---

Notes:
    v2:
    - timer creation/initialize functions reworked and and their unnecessary variants removed (as Paolo Bonzini suggested)
    - also their comments improved to avoid info duplication

 include/block/aio.h       |  57 ++++++++++++++++++---
 include/qemu/timer.h      | 128 ++++++++++++++++++++++++++--------------------
 tests/ptimer-test-stubs.c |  13 +++--
 util/qemu-timer.c         |  18 +++++--
 4 files changed, 146 insertions(+), 70 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index f08630c..fce9d48 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -388,6 +388,31 @@ struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
 struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
 
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
+ * The preferred interface is aio_timer_init or aio_timer_init_with_attrs.
+ * Use that unless you really need dynamic memory allocation.
+ *
+ * Returns: a pointer to the new timer
+ */
+static inline QEMUTimer *aio_timer_new_with_attrs(AioContext *ctx,
+                                                  QEMUClockType type,
+                                                  int scale, int attributes,
+                                                  QEMUTimerCB *cb, void *opaque)
+{
+    return timer_new_full(&ctx->tlg, type, scale, attributes, cb, opaque);
+}
+
+/**
  * aio_timer_new:
  * @ctx: the aio context
  * @type: the clock type
@@ -396,10 +421,7 @@ struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
  * @opaque: the opaque pointer to pass to the callback
  *
  * Allocate a new timer attached to the context @ctx.
- * The function is responsible for memory allocation.
- *
- * The preferred interface is aio_timer_init. Use that
- * unless you really need dynamic memory allocation.
+ * See aio_timer_new_with_attrs for details.
  *
  * Returns: a pointer to the new timer
  */
@@ -407,7 +429,28 @@ static inline QEMUTimer *aio_timer_new(AioContext *ctx, QEMUClockType type,
                                        int scale,
                                        QEMUTimerCB *cb, void *opaque)
 {
-    return timer_new_tl(ctx->tlg.tl[type], scale, cb, opaque);
+    return timer_new_full(&ctx->tlg, type, scale, 0, cb, opaque);
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
+    timer_init_full(ts, &ctx->tlg, type, scale, attributes, cb, opaque);
 }
 
 /**
@@ -420,14 +463,14 @@ static inline QEMUTimer *aio_timer_new(AioContext *ctx, QEMUClockType type,
  * @opaque: the opaque pointer to pass to the callback
  *
  * Initialise a new timer attached to the context @ctx.
- * The caller is responsible for memory allocation.
+ * See aio_timer_init_with_attrs for details.
  */
 static inline void aio_timer_init(AioContext *ctx,
                                   QEMUTimer *ts, QEMUClockType type,
                                   int scale,
                                   QEMUTimerCB *cb, void *opaque)
 {
-    timer_init_tl(ts, ctx->tlg.tl[type], scale, cb, opaque);
+    timer_init_full(ts, &ctx->tlg, type, scale, 0, cb, opaque);
 }
 
 /**
diff --git a/include/qemu/timer.h b/include/qemu/timer.h
index 39ea907..e225ad4 100644
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
 
@@ -418,22 +441,27 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg);
  */
 
 /**
- * timer_init_tl:
+ * timer_init_full:
  * @ts: the timer to be initialised
- * @timer_list: the timer list to attach the timer to
+ * @timer_list_group: (optional) the timer list group to attach the timer to
+ * @type: the clock type to use
  * @scale: the scale value for the timer
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values to assign
  * @cb: the callback to be called when the timer expires
  * @opaque: the opaque pointer to be passed to the callback
  *
- * Initialise a new timer and associate it with @timer_list.
+ * Initialise a timer with the given scale and attributes,
+ * and associate it with timer list for given clock @type in @timer_list_group
+ * (or default timer list group, if NULL).
  * The caller is responsible for allocating the memory.
  *
  * You need not call an explicit deinit call. Simply make
  * sure it is not on a list with timer_del.
  */
-void timer_init_tl(QEMUTimer *ts,
-                   QEMUTimerList *timer_list, int scale,
-                   QEMUTimerCB *cb, void *opaque);
+void timer_init_full(QEMUTimer *ts,
+                     QEMUTimerListGroup *timer_list_group, QEMUClockType type,
+                     int scale, int attributes,
+                     QEMUTimerCB *cb, void *opaque);
 
 /**
  * timer_init:
@@ -445,14 +473,12 @@ void timer_init_tl(QEMUTimer *ts,
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
+    timer_init_full(ts, &main_loop_tlg, type, scale, 0, cb, opaque);
 }
 
 /**
@@ -464,9 +490,7 @@ static inline void timer_init(QEMUTimer *ts, QEMUClockType type, int scale,
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
@@ -483,9 +507,7 @@ static inline void timer_init_ns(QEMUTimer *ts, QEMUClockType type,
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
@@ -502,9 +524,7 @@ static inline void timer_init_us(QEMUTimer *ts, QEMUClockType type,
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
@@ -513,27 +533,37 @@ static inline void timer_init_ms(QEMUTimer *ts, QEMUClockType type,
 }
 
 /**
- * timer_new_tl:
- * @timer_list: the timer list to attach the timer to
+ * timer_new_full:
+ * @timer_list_group: (optional) the timer list group to attach the timer to
+ * @type: the clock type to use
  * @scale: the scale value for the timer
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR(id) values to assign
  * @cb: the callback to be called when the timer expires
  * @opaque: the opaque pointer to be passed to the callback
  *
- * Create a new timer and associate it with @timer_list.
+ * Create a new timer with the given scale and attributes,
+ * and associate it with timer list for given clock @type in @timer_list_group
+ * (or default timer list group, if NULL).
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
+static inline QEMUTimer *timer_new_full(QEMUTimerListGroup *timer_list_group,
+                                        QEMUClockType type,
+                                        int scale, int attributes,
+                                        QEMUTimerCB *cb, void *opaque)
 {
     QEMUTimer *ts = g_malloc0(sizeof(QEMUTimer));
-    timer_init_tl(ts, timer_list, scale, cb, opaque);
+    timer_init_full(ts, timer_list_group, type, scale, attributes, cb, opaque);
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
+    return timer_new_full(&main_loop_tlg, type, scale, 0, cb, opaque);
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
index ca5cc3b..54b3fd2 100644
--- a/tests/ptimer-test-stubs.c
+++ b/tests/ptimer-test-stubs.c
@@ -34,14 +34,19 @@ int64_t ptimer_test_time_ns;
 int use_icount = 1;
 bool qtest_allowed;
 
-void timer_init_tl(QEMUTimer *ts,
-                   QEMUTimerList *timer_list, int scale,
-                   QEMUTimerCB *cb, void *opaque)
+void timer_init_full(QEMUTimer *ts,
+                     QEMUTimerListGroup *timer_list_group, QEMUClockType type,
+                     int scale, int attributes,
+                     QEMUTimerCB *cb, void *opaque)
 {
-    ts->timer_list = timer_list;
+    if (!timer_list_group) {
+        timer_list_group = &main_loop_tlg;
+    }
+    ts->timer_list = timer_list_group->tl[type];
     ts->cb = cb;
     ts->opaque = opaque;
     ts->scale = scale;
+    ts->attributes = attributes;
     ts->expire_time = -1;
 }
 
diff --git a/util/qemu-timer.c b/util/qemu-timer.c
index 86bfe84..2046b68 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -339,17 +339,27 @@ int qemu_poll_ns(GPollFD *fds, guint nfds, int64_t timeout)
 }
 
 
-void timer_init_tl(QEMUTimer *ts,
-                   QEMUTimerList *timer_list, int scale,
-                   QEMUTimerCB *cb, void *opaque)
+void timer_init_full(QEMUTimer *ts,
+                     QEMUTimerListGroup *timer_list_group, QEMUClockType type,
+                     int scale, int attributes,
+                     QEMUTimerCB *cb, void *opaque)
 {
-    ts->timer_list = timer_list;
+    if (!timer_list_group) {
+        timer_list_group = &main_loop_tlg;
+    }
+    ts->timer_list = timer_list_group->tl[type];
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
