Received: from eggs.gnu.org ([2001:4830:134:3::10]:44795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dGoWT-0000cu-CN
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:29:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <roman.penyaev@profitbricks.com>) id 1dGoWS-00070x-0i
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:29:57 -0400
Received: from mail-it0-x22f.google.com ([2607:f8b0:4001:c0b::22f]:34203)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <roman.penyaev@profitbricks.com>)
	id 1dGoWR-00070T-PX
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 11:29:55 -0400
Received: by mail-it0-x22f.google.com with SMTP id m47so4639281iti.1
	for <qemu-devel@nongnu.org>; Fri, 02 Jun 2017 08:29:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170601160847.23720-1-roman.penyaev@profitbricks.com>
References: <20170601160847.23720-1-roman.penyaev@profitbricks.com>
From: Roman Penyaev <roman.penyaev@profitbricks.com>
Date: Fri, 2 Jun 2017 17:29:34 +0200
Message-ID: <CAJrWOzBUNdcNXKPnYCLz+qM3B7hB5ubHw6Zhh0e+41-txg9zAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 1/1] coroutine-lock: do not touch
 coroutine after another one has been entered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Pen <roman.penyaev@profitbricks.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On Thu, Jun 1, 2017 at 6:08 PM, Roman Pen
<roman.penyaev@profitbricks.com> wrote:

[cut]

>  Thread 12 (Thread 0x7f57f2ffd700 (LWP 56426)):
>  #0  raise () from /lib/x86_64-linux-gnu/libc.so.6
>  #1  abort () from /lib/x86_64-linux-gnu/libc.so.6
>  #2  qemu_coroutine_enter (co=0x7f5804009af0) at qemu-coroutine.c:113
>  #3  qemu_co_queue_run_restart (co=0x7f5804009a30) at qemu-coroutine-lock.c:60
>  #4  qemu_coroutine_enter (co=0x7f5804009a30) at qemu-coroutine.c:119
>                            ^^^^^^^^^^^^^^^^^^
>                            WTF?? this is equal to elem from crashed thread
>
>  #5  qemu_co_queue_run_restart (co=0x7f57e7f16ae0) at qemu-coroutine-lock.c:60
>  #6  qemu_coroutine_enter (co=0x7f57e7f16ae0) at qemu-coroutine.c:119
>  #7  qemu_co_queue_run_restart (co=0x7f5807e112a0) at qemu-coroutine-lock.c:60
>  #8  qemu_coroutine_enter (co=0x7f5807e112a0) at qemu-coroutine.c:119
>  #9  qemu_co_queue_run_restart (co=0x7f5807f17820) at qemu-coroutine-lock.c:60
>  #10 qemu_coroutine_enter (co=0x7f5807f17820) at qemu-coroutine.c:119
>  #11 qemu_co_queue_run_restart (co=0x7f57e7f18e10) at qemu-coroutine-lock.c:60
>  #12 qemu_coroutine_enter (co=0x7f57e7f18e10) at qemu-coroutine.c:119
>  #13 qemu_co_enter_next (queue=queue@entry=0x5598b1e742d0) at qemu-coroutine-lock.c:106
>  #14 timer_cb (blk=0x5598b1e74280, is_write=<optimized out>) at throttle-groups.c:419

BTW, while chasing current bug I observed utterly long recursive backtraces with
repeating:

qemu_co_queue_run_restart
qemu_coroutine_enter
....

like in the current bug but much much longer.

It is clear that each pair qemu_coroutine_enter(),qemu_co_queue_run_restart()
is one request/coroutine, so in the worst case we can get stack depth equal to
number of requests in flight which were throttled.

But real number of requests with MQ virtio device can be very huge.  When virtio
device is created with num-queues=$VCPU we have requests in total equal to
nr_requests x num_queues.  Say if guest has 16 VCPUS, virtio block
device can have
128x16 = 2048 requests in flight.  If my calculations are correct each
loop costs
around 112 bytes on stack, so 2048x112 = 224K.  Definitely not nice.

Straightforward fix can be in keeping queue_wakeup on stack.  I did
just fast dirty
diff (below), but seems the idea should be clear.  That will iron out recursion
and save 8 bytes for each coroutine.

--
Roman


diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
index e46a32d0fcc2..4f1a3278e432 100644
--- a/include/qemu/coroutine.h
+++ b/include/qemu/coroutine.h
@@ -65,10 +65,13 @@ typedef void coroutine_fn CoroutineEntry(void *opaque);
  */
 Coroutine *qemu_coroutine_create(CoroutineEntry *entry, void *opaque);

+typedef QSIMPLEQ_HEAD(CoroutineQueue, Coroutine) CoroutineQueue;
+
 /**
  * Transfer control to a coroutine
  */
 void qemu_coroutine_enter(Coroutine *coroutine);
+void __qemu_coroutine_enter(Coroutine *coroutine, CoroutineQueue
*queue_wakeup);

 /**
  * Transfer control back to a coroutine's caller
diff --git a/include/qemu/coroutine_int.h b/include/qemu/coroutine_int.h
index 581a7f514075..edf1c0a4edbb 100644
--- a/include/qemu/coroutine_int.h
+++ b/include/qemu/coroutine_int.h
@@ -41,7 +41,7 @@ struct Coroutine {
     QSLIST_ENTRY(Coroutine) pool_next;

     /* Coroutines that should be woken up when we yield or terminate */
-    QSIMPLEQ_HEAD(, Coroutine) co_queue_wakeup;
+    CoroutineQueue *co_queue_wakeup;
     QSIMPLEQ_ENTRY(Coroutine) co_queue_next;
 };

@@ -49,6 +49,6 @@ Coroutine *qemu_coroutine_new(void);
 void qemu_coroutine_delete(Coroutine *co);
 CoroutineAction qemu_coroutine_switch(Coroutine *from, Coroutine *to,
                                       CoroutineAction action);
-void coroutine_fn qemu_co_queue_run_restart(Coroutine *co);
+void coroutine_fn qemu_co_queue_run_restart(CoroutineQueue *queue_wakeup);

 #endif
diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index 0db8e4fc6d98..9282e5b82824 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -50,27 +50,13 @@ void coroutine_fn qemu_co_queue_wait(CoQueue *queue)
  * invoked by the core coroutine code when the current coroutine yields or
  * terminates.
  */
-void qemu_co_queue_run_restart(Coroutine *co)
+void qemu_co_queue_run_restart(CoroutineQueue *queue_wakeup)
 {
     Coroutine *next;
-    QSIMPLEQ_HEAD(, Coroutine) tmp_queue_wakeup =
-        QSIMPLEQ_HEAD_INITIALIZER(tmp_queue_wakeup);
-
-    trace_qemu_co_queue_run_restart(co);
-
-    /*
-     * We use temporal queue in order not to touch 'co' after entering
-     * 'next' coroutine.  The thing is that 'next' coroutine can resume
-     * current 'co' coroutine and eventually terminate (free) it (see
-     * linux-aio.c: ioq_submit() where qemu_laio_process_completions()
-     * is invoked).  The rule of thumb is simple: do not touch coroutine
-     * when you enter another one.
-     */
-    QSIMPLEQ_CONCAT(&tmp_queue_wakeup, &co->co_queue_wakeup);
-
-    while ((next = QSIMPLEQ_FIRST(&tmp_queue_wakeup))) {
-        QSIMPLEQ_REMOVE_HEAD(&tmp_queue_wakeup, co_queue_next);
-        qemu_coroutine_enter(next);
+
+    while ((next = QSIMPLEQ_FIRST(queue_wakeup))) {
+        QSIMPLEQ_REMOVE_HEAD(queue_wakeup, co_queue_next);
+        __qemu_coroutine_enter(next, queue_wakeup);
     }
 }

@@ -85,7 +71,7 @@ static bool qemu_co_queue_do_restart(CoQueue *queue,
bool single)

     while ((next = QSIMPLEQ_FIRST(&queue->entries)) != NULL) {
         QSIMPLEQ_REMOVE_HEAD(&queue->entries, co_queue_next);
-        QSIMPLEQ_INSERT_TAIL(&self->co_queue_wakeup, next, co_queue_next);
+        QSIMPLEQ_INSERT_TAIL(self->co_queue_wakeup, next, co_queue_next);
         trace_qemu_co_queue_next(next);
         if (single) {
             break;
diff --git a/util/qemu-coroutine.c b/util/qemu-coroutine.c
index 1a89e04238fa..6d280921c161 100644
--- a/util/qemu-coroutine.c
+++ b/util/qemu-coroutine.c
@@ -77,7 +77,7 @@ Coroutine *qemu_coroutine_create(CoroutineEntry
*entry, void *opaque)

     co->entry = entry;
     co->entry_arg = opaque;
-    QSIMPLEQ_INIT(&co->co_queue_wakeup);
+    co->co_queue_wakeup = NULL;
     return co;
 }

@@ -101,7 +101,7 @@ static void coroutine_delete(Coroutine *co)
     qemu_coroutine_delete(co);
 }

-void qemu_coroutine_enter(Coroutine *co)
+void __qemu_coroutine_enter(Coroutine *co, CoroutineQueue *queue_wakeup)
 {
     Coroutine *self = qemu_coroutine_self();
     CoroutineAction ret;
@@ -114,17 +114,9 @@ void qemu_coroutine_enter(Coroutine *co)
     }

     co->caller = self;
+    co->co_queue_wakeup = queue_wakeup;
     ret = qemu_coroutine_switch(self, co, COROUTINE_ENTER);

-    qemu_co_queue_run_restart(co);
-
-    /*
-     * BEWARE: in case of ret == COROUTINE_YIELD here at this point
-     *         after qemu_co_queue_run_restart() 'co' can be already
-     *         freed by other coroutine, which has entered 'co'. So
-     *         be careful and do not touch it.
-     */
-
     switch (ret) {
     case COROUTINE_YIELD:
         return;
@@ -137,6 +129,15 @@ void qemu_coroutine_enter(Coroutine *co)
     }
 }

+void qemu_coroutine_enter(Coroutine *co)
+{
+    CoroutineQueue queue_wakeup =
+        QSIMPLEQ_HEAD_INITIALIZER(queue_wakeup);
+
+    __qemu_coroutine_enter(co, &queue_wakeup);
+    qemu_co_queue_run_restart(&queue_wakeup);
+}
+
 void coroutine_fn qemu_coroutine_yield(void)
 {
     Coroutine *self = qemu_coroutine_self();
@@ -150,6 +151,7 @@ void coroutine_fn qemu_coroutine_yield(void)
     }

     self->caller = NULL;
+    self->co_queue_wakeup = NULL;
     qemu_coroutine_switch(self, to, COROUTINE_YIELD);
 }
