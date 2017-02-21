Received: from eggs.gnu.org ([2001:4830:134:3::10]:38633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg948-0006aq-5y
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cg945-0005Qj-5R
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cg944-0005Qd-VY
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 06:57:05 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 21 Feb 2017 11:56:28 +0000
Message-Id: <20170221115644.28264-9-stefanha@redhat.com>
In-Reply-To: <20170221115644.28264-1-stefanha@redhat.com>
References: <20170221115644.28264-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL v2 08/24] coroutine-lock: reschedule coroutine
 on the AioContext it was running on
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

As a small step towards the introduction of multiqueue, we want
coroutines to remain on the same AioContext that started them,
unless they are moved explicitly with e.g. aio_co_schedule.  This patch
avoids that coroutines switch AioContext when they use a CoMutex.
For now it does not make much of a difference, because the CoMutex
is not thread-safe and the AioContext itself is used to protect the
CoMutex from concurrent access.  However, this is going to change.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170213135235.12274-9-pbonzini@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
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
index 53bd70c..65c9787 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -28,7 +28,6 @@ qemu_coroutine_terminate(void *co) "self %p"
 
 # util/qemu-coroutine-lock.c
 qemu_co_queue_run_restart(void *co) "co %p"
-qemu_co_queue_next(void *nxt) "next %p"
 qemu_co_mutex_lock_entry(void *mutex, void *self) "mutex %p self %p"
 qemu_co_mutex_lock_return(void *mutex, void *self) "mutex %p self %p"
 qemu_co_mutex_unlock_entry(void *mutex, void *self) "mutex %p self %p"
-- 
2.9.3
