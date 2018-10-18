Received: from eggs.gnu.org ([2001:4830:134:3::10]:48013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEyF-0007H3-DA
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gDEy7-0006C1-WB
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:37 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a]:39908)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gDEy3-000660-H8
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:32:29 -0400
Received: by mail-wr1-x42a.google.com with SMTP id 61-v6so35109149wrb.6
	for <qemu-devel@nongnu.org>; Thu, 18 Oct 2018 13:32:21 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 18 Oct 2018 22:31:30 +0200
Message-Id: <1539894735-14232-4-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
References: <1539894735-14232-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 03/48] qemu-timer: introduce timer attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Artem Pisarenko <artem.k.pisarenko@gmail.com>

From: Artem Pisarenko <artem.k.pisarenko@gmail.com>

Attributes are simple flags, associated with individual timers for their
whole lifetime.  They intended to be used to mark individual timers for
special handling when they fire.

New/init functions family in timer interface updated and refactored (new
'attribute' argument added, timer_list replaced with timer_list_group+type
combinations, comments improved to avoid info duplication).  Also existing
aio interface extended with attribute-enabled variants of functions,
which create/initialize timers.

Signed-off-by: Artem Pisarenko <artem.k.pisarenko@gmail.com>
Message-Id: <f47b81dbce734e9806f9516eba8ca588e6321c2f.1539764043.git.artem.k.pisarenko@gmail.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/block/aio.h       |  59 ++++++++++++++++++++++---
 include/qemu/timer.h      | 109 +++++++++++++++++++++++-----------------------
 tests/ptimer-test-stubs.c |  13 ++++--
 util/qemu-timer.c         |  13 ++++--
 4 files changed, 124 insertions(+), 70 deletions(-)

diff --git a/include/block/aio.h b/include/block/aio.h
index f08630c..0ca25df 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -388,18 +388,41 @@ struct LinuxAioState *aio_setup_linux_aio(AioContext *ctx, Error **errp);
 struct LinuxAioState *aio_get_linux_aio(AioContext *ctx);
 
 /**
- * aio_timer_new:
+ * aio_timer_new_with_attrs:
  * @ctx: the aio context
  * @type: the clock type
  * @scale: the scale
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR_<id> values
+ *              to assign
  * @cb: the callback to call on timer expiry
  * @opaque: the opaque pointer to pass to the callback
  *
- * Allocate a new timer attached to the context @ctx.
+ * Allocate a new timer (with attributes) attached to the context @ctx.
  * The function is responsible for memory allocation.
  *
- * The preferred interface is aio_timer_init. Use that
- * unless you really need dynamic memory allocation.
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
+ * aio_timer_new:
+ * @ctx: the aio context
+ * @type: the clock type
+ * @scale: the scale
+ * @cb: the callback to call on timer expiry
+ * @opaque: the opaque pointer to pass to the callback
+ *
+ * Allocate a new timer attached to the context @ctx.
+ * See aio_timer_new_with_attrs for details.
  *
  * Returns: a pointer to the new timer
  */
@@ -407,7 +430,29 @@ static inline QEMUTimer *aio_timer_new(AioContext *ctx, QEMUClockType type,
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
+ * @attributes: 0, or one to multiple OR'ed QEMU_TIMER_ATTR_<id> values
+ *              to assign
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
@@ -420,14 +465,14 @@ static inline QEMUTimer *aio_timer_new(AioContext *ctx, QEMUClockType type,
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
index 39ea907..8ff1092 100644
--- a/include/qemu/timer.h
+++ b/include/qemu/timer.h
@@ -2,6 +2,7 @@
 #define QEMU_TIMER_H
 
 #include "qemu-common.h"
+#include "qemu/bitops.h"
 #include "qemu/notify.h"
 #include "qemu/host-utils.h"
 
@@ -52,6 +53,16 @@ typedef enum {
     QEMU_CLOCK_MAX
 } QEMUClockType;
 
+/**
+ * QEMU Timer attributes:
+ *
+ * An individual timer may be given one or multiple attributes when initialized.
+ * Each attribute corresponds to one bit. Attributes modify the processing
+ * of timers when they fire.
+ *
+ * No attributes defined currently.
+ */
+
 typedef struct QEMUTimerList QEMUTimerList;
 
 struct QEMUTimerListGroup {
@@ -67,6 +78,7 @@ struct QEMUTimer {
     QEMUTimerCB *cb;
     void *opaque;
     QEMUTimer *next;
+    int attributes;
     int scale;
 };
 
@@ -418,22 +430,27 @@ int64_t timerlistgroup_deadline_ns(QEMUTimerListGroup *tlg);
  */
 
 /**
- * timer_init_tl:
+ * timer_init_full:
  * @ts: the timer to be initialised
- * @timer_list: the timer list to attach the timer to
+ * @timer_list_group: (optional) the timer list group to attach the timer to
+ * @type: the clock type to use
  * @scale: the scale value for the timer
+ * @attributes: 0, or one or more OR'ed QEMU_TIMER_ATTR_<id> values
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
@@ -445,14 +462,12 @@ void timer_init_tl(QEMUTimer *ts,
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
+    timer_init_full(ts, NULL, type, scale, 0, cb, opaque);
 }
 
 /**
@@ -464,9 +479,7 @@ static inline void timer_init(QEMUTimer *ts, QEMUClockType type, int scale,
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
@@ -483,9 +496,7 @@ static inline void timer_init_ns(QEMUTimer *ts, QEMUClockType type,
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
@@ -502,9 +513,7 @@ static inline void timer_init_us(QEMUTimer *ts, QEMUClockType type,
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
@@ -513,27 +522,37 @@ static inline void timer_init_ms(QEMUTimer *ts, QEMUClockType type,
 }
 
 /**
- * timer_new_tl:
- * @timer_list: the timer list to attach the timer to
+ * timer_new_full:
+ * @timer_list_group: (optional) the timer list group to attach the timer to
+ * @type: the clock type to use
  * @scale: the scale value for the timer
+ * @attributes: 0, or one or more OR'ed QEMU_TIMER_ATTR_<id> values
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
 
@@ -544,21 +563,16 @@ static inline QEMUTimer *timer_new_tl(QEMUTimerList *timer_list,
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
+    return timer_new_full(NULL, type, scale, 0, cb, opaque);
 }
 
 /**
@@ -569,12 +583,7 @@ static inline QEMUTimer *timer_new(QEMUClockType type, int scale,
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
@@ -590,14 +599,9 @@ static inline QEMUTimer *timer_new_ns(QEMUClockType type, QEMUTimerCB *cb,
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
@@ -613,14 +617,9 @@ static inline QEMUTimer *timer_new_us(QEMUClockType type, QEMUTimerCB *cb,
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
index 86bfe84..04527a3 100644
--- a/util/qemu-timer.c
+++ b/util/qemu-timer.c
@@ -339,14 +339,19 @@ int qemu_poll_ns(GPollFD *fds, guint nfds, int64_t timeout)
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
 
-- 
1.8.3.1
