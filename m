Received: from eggs.gnu.org ([2001:4830:134:3::10]:50659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYtfk-00018a-K6
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cYtfj-0002K1-NK
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:06:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39876)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cYtfj-0002Jx-IN
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 07:05:59 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com
	(int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CD90C61BA0
	for <qemu-devel@nongnu.org>; Wed,  1 Feb 2017 12:05:59 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed,  1 Feb 2017 04:05:23 -0800
Message-Id: <20170201120533.13838-9-pbonzini@redhat.com>
In-Reply-To: <20170201120533.13838-1-pbonzini@redhat.com>
References: <20170201120533.13838-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 08/18] coroutine-lock: reschedule coroutine on
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

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
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
