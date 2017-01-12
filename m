Received: from eggs.gnu.org ([2001:4830:134:3::10]:44338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRjnR-0000L1-Ok
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cRjnN-0005Gl-3O
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:21 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:34092)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cRjnM-0005GO-Sr
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 13:08:17 -0500
Received: by mail-wm0-x242.google.com with SMTP id c85so5452641wmi.1
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 10:08:16 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 12 Jan 2017 19:07:59 +0100
Message-Id: <20170112180800.21085-10-pbonzini@redhat.com>
In-Reply-To: <20170112180800.21085-1-pbonzini@redhat.com>
References: <20170112180800.21085-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 09/10] aio: document locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: famz@redhat.com, stefanha@redhat.com

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/multiple-iothreads.txt | 13 +++++--------
 include/block/aio.h         | 32 ++++++++++++++++----------------
 2 files changed, 21 insertions(+), 24 deletions(-)

diff --git a/docs/multiple-iothreads.txt b/docs/multiple-iothreads.txt
index 0e7cdb2..e4d340b 100644
--- a/docs/multiple-iothreads.txt
+++ b/docs/multiple-iothreads.txt
@@ -84,9 +84,8 @@ How to synchronize with an IOThread
 AioContext is not thread-safe so some rules must be followed when using file
 descriptors, event notifiers, timers, or BHs across threads:
 
-1. AioContext functions can be called safely from file descriptor, event
-notifier, timer, or BH callbacks invoked by the AioContext.  No locking is
-necessary.
+1. AioContext functions can always be called safely.  They handle their
+own locking internally.
 
 2. Other threads wishing to access the AioContext must use
 aio_context_acquire()/aio_context_release() for mutual exclusion.  Once the
@@ -94,16 +93,14 @@ context is acquired no other thread can access it or run event loop iterations
 in this AioContext.
 
 aio_context_acquire()/aio_context_release() calls may be nested.  This
-means you can call them if you're not sure whether #1 applies.
+means you can call them if you're not sure whether #2 applies.
 
 There is currently no lock ordering rule if a thread needs to acquire multiple
 AioContexts simultaneously.  Therefore, it is only safe for code holding the
 QEMU global mutex to acquire other AioContexts.
 
-Side note: the best way to schedule a function call across threads is to create
-a BH in the target AioContext beforehand and then call qemu_bh_schedule().  No
-acquire/release or locking is needed for the qemu_bh_schedule() call.  But be
-sure to acquire the AioContext for aio_bh_new() if necessary.
+Side note: the best way to schedule a function call across threads is to call
+aio_bh_schedule_oneshot().  No acquire/release or locking is needed.
 
 AioContext and the block layer
 ------------------------------
diff --git a/include/block/aio.h b/include/block/aio.h
index be3adfe..7df271d 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -53,18 +53,12 @@ struct LinuxAioState;
 struct AioContext {
     GSource source;
 
-    /* Protects all fields from multi-threaded access */
+    /* Used by AioContext users to protect from multi-threaded access.  */
     QemuRecMutex lock;
 
-    /* The list of registered AIO handlers */
+    /* The list of registered AIO handlers.  Protected by ctx->list_lock. */
     QLIST_HEAD(, AioHandler) aio_handlers;
 
-    /* This is a simple lock used to protect the aio_handlers list.
-     * Specifically, it's used to ensure that no callbacks are removed while
-     * we're walking and dispatching callbacks.
-     */
-    int walking_handlers;
-
     /* Used to avoid unnecessary event_notifier_set calls in aio_notify;
      * accessed with atomic primitives.  If this field is 0, everything
      * (file descriptors, bottom halves, timers) will be re-evaluated
@@ -90,9 +84,9 @@ struct AioContext {
      */
     uint32_t notify_me;
 
-    /* A lock to protect between bh's adders and deleter, and to ensure
-     * that no callbacks are removed while we're walking and dispatching
-     * them.
+    /* A lock to protect between QEMUBH and AioHandler adders and deleter,
+     * and to ensure that no callbacks are removed while we're walking and
+     * dispatching them.
      */
     QemuLockCnt list_lock;
 
@@ -114,7 +108,9 @@ struct AioContext {
     bool notified;
     EventNotifier notifier;
 
-    /* Thread pool for performing work and receiving completion callbacks */
+    /* Thread pool for performing work and receiving completion callbacks.
+     * Has its own locking.
+     */
     struct ThreadPool *thread_pool;
 
 #ifdef CONFIG_LINUX_AIO
@@ -124,7 +120,9 @@ struct AioContext {
     struct LinuxAioState *linux_aio;
 #endif
 
-    /* TimerLists for calling timers - one per clock type */
+    /* TimerLists for calling timers - one per clock type.  Has its own
+     * locking.
+     */
     QEMUTimerListGroup tlg;
 
     int external_disable_cnt;
@@ -178,9 +176,11 @@ void aio_context_unref(AioContext *ctx);
  * automatically takes care of calling aio_context_acquire and
  * aio_context_release.
  *
- * Access to timers and BHs from a thread that has not acquired AioContext
- * is possible.  Access to callbacks for now must be done while the AioContext
- * is owned by the thread (FIXME).
+ * Note that this is separate from bdrv_drained_begin/bdrv_drained_end.  A
+ * thread still has to call those to avoid being interrupted by the guest.
+ *
+ * Bottom halves, timers and callbacks can be created or removed without
+ * acquiring the AioContext.
  */
 void aio_context_acquire(AioContext *ctx);
 
-- 
2.9.3
