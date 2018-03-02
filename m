Received: from eggs.gnu.org ([2001:4830:134:3::10]:53053)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqe-0001om-Tr
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1erpqb-0003DZ-Jk
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 13:56:04 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  2 Mar 2018 19:54:38 +0100
Message-Id: <20180302185448.6314-28-kwolf@redhat.com>
In-Reply-To: <20180302185448.6314-1-kwolf@redhat.com>
References: <20180302185448.6314-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 27/37] block: extract AIO_WAIT_WHILE() from
 BlockDriverState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Stefan Hajnoczi <stefanha@redhat.com>

BlockDriverState has the BDRV_POLL_WHILE() macro to wait on event loop
activity while a condition evaluates to true.  This is used to implement
synchronous operations where it acts as a condvar between the IOThread
running the operation and the main loop waiting for the operation.  It
can also be called from the thread that owns the AioContext and in that
case it's just a nested event loop.

BlockBackend needs this behavior but doesn't always have a
BlockDriverState it can use.  This patch extracts BDRV_POLL_WHILE() into
the AioWait abstraction, which can be used with AioContext and isn't
tied to BlockDriverState anymore.

This feature could be built directly into AioContext but then all users
would kick the event loop even if they signal different conditions.
Imagine an AioContext with many BlockDriverStates, each time a request
completes any waiter would wake up and re-check their condition.  It's
nicer to keep a separate AioWait object for each condition instead.

Please see "block/aio-wait.h" for details on the API.

The name AIO_WAIT_WHILE() avoids the confusion between AIO_POLL_WHILE()
and AioContext polling.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 include/block/aio-wait.h  | 116 ++++++++++++++++++++++++++++++++++++++++++++++
 include/block/block.h     |  40 +++-------------
 include/block/block_int.h |   7 ++-
 block.c                   |   5 ++
 block/io.c                |  10 +---
 util/aio-wait.c           |  40 ++++++++++++++++
 util/Makefile.objs        |   2 +-
 7 files changed, 174 insertions(+), 46 deletions(-)
 create mode 100644 include/block/aio-wait.h
 create mode 100644 util/aio-wait.c

diff --git a/include/block/aio-wait.h b/include/block/aio-wait.h
new file mode 100644
index 0000000000..a48c744fa8
--- /dev/null
+++ b/include/block/aio-wait.h
@@ -0,0 +1,116 @@
+/*
+ * AioContext wait support
+ *
+ * Copyright (C) 2018 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#ifndef QEMU_AIO_WAIT_H
+#define QEMU_AIO_WAIT_H
+
+#include "block/aio.h"
+
+/**
+ * AioWait:
+ *
+ * An object that facilitates synchronous waiting on a condition.  The main
+ * loop can wait on an operation running in an IOThread as follows:
+ *
+ *   AioWait *wait = ...;
+ *   AioContext *ctx = ...;
+ *   MyWork work = { .done = false };
+ *   schedule_my_work_in_iothread(ctx, &work);
+ *   AIO_WAIT_WHILE(wait, ctx, !work.done);
+ *
+ * The IOThread must call aio_wait_kick() to notify the main loop when
+ * work.done changes:
+ *
+ *   static void do_work(...)
+ *   {
+ *       ...
+ *       work.done = true;
+ *       aio_wait_kick(wait);
+ *   }
+ */
+typedef struct {
+    /* Is the main loop waiting for a kick?  Accessed with atomic ops. */
+    bool need_kick;
+} AioWait;
+
+/**
+ * AIO_WAIT_WHILE:
+ * @wait: the aio wait object
+ * @ctx: the aio context
+ * @cond: wait while this conditional expression is true
+ *
+ * Wait while a condition is true.  Use this to implement synchronous
+ * operations that require event loop activity.
+ *
+ * The caller must be sure that something calls aio_wait_kick() when the value
+ * of @cond might have changed.
+ *
+ * The caller's thread must be the IOThread that owns @ctx or the main loop
+ * thread (with @ctx acquired exactly once).  This function cannot be used to
+ * wait on conditions between two IOThreads since that could lead to deadlock,
+ * go via the main loop instead.
+ */
+#define AIO_WAIT_WHILE(wait, ctx, cond) ({                  \
+    bool waited_ = false;                                   \
+    bool busy_ = true;                                      \
+    AioWait *wait_ = (wait);                                \
+    AioContext *ctx_ = (ctx);                               \
+    if (in_aio_context_home_thread(ctx_)) {                 \
+        while ((cond) || busy_) {                           \
+            busy_ = aio_poll(ctx_, (cond));                 \
+            waited_ |= !!(cond) | busy_;                    \
+        }                                                   \
+    } else {                                                \
+        assert(qemu_get_current_aio_context() ==            \
+               qemu_get_aio_context());                     \
+        assert(!wait_->need_kick);                          \
+        /* Set wait_->need_kick before evaluating cond.  */ \
+        atomic_mb_set(&wait_->need_kick, true);             \
+        while (busy_) {                                     \
+            if ((cond)) {                                   \
+                waited_ = busy_ = true;                     \
+                aio_context_release(ctx_);                  \
+                aio_poll(qemu_get_aio_context(), true);     \
+                aio_context_acquire(ctx_);                  \
+            } else {                                        \
+                busy_ = aio_poll(ctx_, false);              \
+                waited_ |= busy_;                           \
+            }                                               \
+        }                                                   \
+        atomic_set(&wait_->need_kick, false);               \
+    }                                                       \
+    waited_; })
+
+/**
+ * aio_wait_kick:
+ * @wait: the aio wait object that should re-evaluate its condition
+ *
+ * Wake up the main thread if it is waiting on AIO_WAIT_WHILE().  During
+ * synchronous operations performed in an IOThread, the main thread lets the
+ * IOThread's event loop run, waiting for the operation to complete.  A
+ * aio_wait_kick() call will wake up the main thread.
+ */
+void aio_wait_kick(AioWait *wait);
+
+#endif /* QEMU_AIO_WAIT */
diff --git a/include/block/block.h b/include/block/block.h
index bc41ed253b..4a80a2acd4 100644
--- a/include/block/block.h
+++ b/include/block/block.h
@@ -2,6 +2,7 @@
 #define BLOCK_H
 
 #include "block/aio.h"
+#include "block/aio-wait.h"
 #include "qapi-types.h"
 #include "qemu/iov.h"
 #include "qemu/coroutine.h"
@@ -367,41 +368,14 @@ void bdrv_drain_all_begin(void);
 void bdrv_drain_all_end(void);
 void bdrv_drain_all(void);
 
+/* Returns NULL when bs == NULL */
+AioWait *bdrv_get_aio_wait(BlockDriverState *bs);
+
 #define BDRV_POLL_WHILE(bs, cond) ({                       \
-    bool waited_ = false;                                  \
-    bool busy_ = true;                                     \
     BlockDriverState *bs_ = (bs);                          \
-    AioContext *ctx_ = bdrv_get_aio_context(bs_);          \
-    if (in_aio_context_home_thread(ctx_)) {                \
-        while ((cond) || busy_) {                          \
-            busy_ = aio_poll(ctx_, (cond));                \
-            waited_ |= !!(cond) | busy_;                   \
-        }                                                  \
-    } else {                                               \
-        assert(qemu_get_current_aio_context() ==           \
-               qemu_get_aio_context());                    \
-        /* Ask bdrv_dec_in_flight to wake up the main      \
-         * QEMU AioContext.  Extra I/O threads never take  \
-         * other I/O threads' AioContexts (see for example \
-         * block_job_defer_to_main_loop for how to do it). \
-         */                                                \
-        assert(!bs_->wakeup);                              \
-        /* Set bs->wakeup before evaluating cond.  */      \
-        atomic_mb_set(&bs_->wakeup, true);                 \
-        while (busy_) {                                    \
-            if ((cond)) {                                  \
-                waited_ = busy_ = true;                    \
-                aio_context_release(ctx_);                 \
-                aio_poll(qemu_get_aio_context(), true);    \
-                aio_context_acquire(ctx_);                 \
-            } else {                                       \
-                busy_ = aio_poll(ctx_, false);             \
-                waited_ |= busy_;                          \
-            }                                              \
-        }                                                  \
-        atomic_set(&bs_->wakeup, false);                   \
-    }                                                      \
-    waited_; })
+    AIO_WAIT_WHILE(bdrv_get_aio_wait(bs_),                 \
+                   bdrv_get_aio_context(bs_),              \
+                   cond); })
 
 int bdrv_pdiscard(BlockDriverState *bs, int64_t offset, int bytes);
 int bdrv_co_pdiscard(BlockDriverState *bs, int64_t offset, int bytes);
diff --git a/include/block/block_int.h b/include/block/block_int.h
index 5ae7738cf8..aef10296b0 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -26,6 +26,7 @@
 
 #include "block/accounting.h"
 #include "block/block.h"
+#include "block/aio-wait.h"
 #include "qemu/queue.h"
 #include "qemu/coroutine.h"
 #include "qemu/stats64.h"
@@ -716,10 +717,8 @@ struct BlockDriverState {
     unsigned int in_flight;
     unsigned int serialising_in_flight;
 
-    /* Internal to BDRV_POLL_WHILE and bdrv_wakeup.  Accessed with atomic
-     * ops.
-     */
-    bool wakeup;
+    /* Kicked to signal main loop when a request completes. */
+    AioWait wait;
 
     /* counter for nested bdrv_io_plug.
      * Accessed with atomic ops.
diff --git a/block.c b/block.c
index 814e5a02da..9e4da81213 100644
--- a/block.c
+++ b/block.c
@@ -4716,6 +4716,11 @@ AioContext *bdrv_get_aio_context(BlockDriverState *bs)
     return bs->aio_context;
 }
 
+AioWait *bdrv_get_aio_wait(BlockDriverState *bs)
+{
+    return bs ? &bs->wait : NULL;
+}
+
 void bdrv_coroutine_enter(BlockDriverState *bs, Coroutine *co)
 {
     aio_co_enter(bdrv_get_aio_context(bs), co);
diff --git a/block/io.c b/block/io.c
index 4d3d1f640a..2b09c656d0 100644
--- a/block/io.c
+++ b/block/io.c
@@ -25,6 +25,7 @@
 #include "qemu/osdep.h"
 #include "trace.h"
 #include "sysemu/block-backend.h"
+#include "block/aio-wait.h"
 #include "block/blockjob.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
@@ -587,16 +588,9 @@ void bdrv_inc_in_flight(BlockDriverState *bs)
     atomic_inc(&bs->in_flight);
 }
 
-static void dummy_bh_cb(void *opaque)
-{
-}
-
 void bdrv_wakeup(BlockDriverState *bs)
 {
-    /* The barrier (or an atomic op) is in the caller.  */
-    if (atomic_read(&bs->wakeup)) {
-        aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, NULL);
-    }
+    aio_wait_kick(bdrv_get_aio_wait(bs));
 }
 
 void bdrv_dec_in_flight(BlockDriverState *bs)
diff --git a/util/aio-wait.c b/util/aio-wait.c
new file mode 100644
index 0000000000..a487cdb852
--- /dev/null
+++ b/util/aio-wait.c
@@ -0,0 +1,40 @@
+/*
+ * AioContext wait support
+ *
+ * Copyright (C) 2018 Red Hat, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "block/aio-wait.h"
+
+static void dummy_bh_cb(void *opaque)
+{
+    /* The point is to make AIO_WAIT_WHILE()'s aio_poll() return */
+}
+
+void aio_wait_kick(AioWait *wait)
+{
+    /* The barrier (or an atomic op) is in the caller.  */
+    if (atomic_read(&wait->need_kick)) {
+        aio_bh_schedule_oneshot(qemu_get_aio_context(), dummy_bh_cb, NULL);
+    }
+}
diff --git a/util/Makefile.objs b/util/Makefile.objs
index 3fb611631f..ae90b9963d 100644
--- a/util/Makefile.objs
+++ b/util/Makefile.objs
@@ -1,7 +1,7 @@
 util-obj-y = osdep.o cutils.o unicode.o qemu-timer-common.o
 util-obj-y += bufferiszero.o
 util-obj-y += lockcnt.o
-util-obj-y += aiocb.o async.o thread-pool.o qemu-timer.o
+util-obj-y += aiocb.o async.o aio-wait.o thread-pool.o qemu-timer.o
 util-obj-y += main-loop.o iohandler.o
 util-obj-$(CONFIG_POSIX) += aio-posix.o
 util-obj-$(CONFIG_POSIX) += compatfd.o
-- 
2.13.6
