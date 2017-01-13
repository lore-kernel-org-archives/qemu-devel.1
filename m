Received: from eggs.gnu.org ([2001:4830:134:3::10]:41106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1ji-0007WN-CM
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cS1jh-0002Vk-F8
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:42 -0500
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:33347)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cS1jh-0002Uj-9E
	for qemu-devel@nongnu.org; Fri, 13 Jan 2017 08:17:41 -0500
Received: by mail-wm0-x244.google.com with SMTP id r144so11646588wme.0
	for <qemu-devel@nongnu.org>; Fri, 13 Jan 2017 05:17:41 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 13 Jan 2017 14:17:22 +0100
Message-Id: <20170113131731.1246-8-pbonzini@redhat.com>
In-Reply-To: <20170113131731.1246-1-pbonzini@redhat.com>
References: <20170113131731.1246-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 07/16] coroutine-lock: reschedule coroutine on
 the AioContext it was running on
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

As a small step towards the introduction of multiqueue, we want
coroutines to remain on the same AioContext that started them,
unless they are moved explicitly with e.g. aio_co_schedule.  This patch
avoids that coroutines switch AioContext when they use a CoMutex.
For now it does not make much of a difference, because the CoMutex
is not thread-safe and the AioContext itself is used to protect the
CoMutex from concurrent access.  However, this is going to change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-coroutine-lock.c | 5 ++---
 util/trace-events          | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 14cf9ce..e6afd1a 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -27,6 +27,7 @@
 #include "qemu/coroutine.h"
 #include "qemu/coroutine_int.h"
 #include "qemu/queue.h"
+#include "block/aio.h"
 #include "trace.h"
 
 void qemu_co_queue_init(CoQueue *queue)
@@ -63,7 +64,6 @@ void qemu_co_queue_run_restart(Coroutine *co)
 
 static bool qemu_co_queue_do_restart(CoQueue *queue, bool single)
 {
-    Coroutine *self = qemu_coroutine_self();
     Coroutine *next;
 
     if (QSIMPLEQ_EMPTY(&queue->entries)) {
@@ -72,8 +72,7 @@ static bool qemu_co_queue_do_restart(CoQueue *queue, bool single)
 
     while ((next = QSIMPLEQ_FIRST(&queue->entries)) != NULL) {
         QSIMPLEQ_REMOVE_HEAD(&queue->entries, co_queue_next);
-        QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, next, co_queue_next);
-        trace_qemu_co_queue_next(next);
+        aio_co_wake(next);
         if (single) {
             break;
         }
diff --git a/util/trace-events b/util/trace-events
index 2b8aa30..65705c4 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -13,7 +13,6 @@ qemu_coroutine_terminate(void *co) "self %p"
 
 # util/qemu-coroutine-lock.c
 qemu_co_queue_run_restart(void *co) "co %p"
-qemu_co_queue_next(void *nxt) "next %p"
 qemu_co_mutex_lock_entry(void *mutex, void *self) "mutex %p self %p"
 qemu_co_mutex_lock_return(void *mutex, void *self) "mutex %p self %p"
 qemu_co_mutex_unlock_entry(void *mutex, void *self) "mutex %p self %p"
-- 
2.9.3
