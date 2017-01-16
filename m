Received: from eggs.gnu.org ([2001:4830:134:3::10]:41063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT5Af-0002Gn-LU
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:09:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cT5Ab-0005sA-GN
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:09:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:38232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cT5Ab-0005s2-7Q
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:09:49 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com
	(int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6D26A7F08B
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 11:09:48 +0000 (UTC)
Date: Mon, 16 Jan 2017 19:09:42 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170116110942.GB14226@lemon.Home>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-2-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 01/16] aio: introduce aio_co_schedule and
 aio_co_wake
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, stefanha@redhat.com

On Fri, 01/13 14:17, Paolo Bonzini wrote:
> aio_co_wake provides the infrastructure to start a coroutine on a "home"
> AioContext.  It will be used by CoMutex and CoQueue, so that coroutines
> don't jump from one context to another when they go to sleep on a
> mutex or waitqueue.  However, it can also be used as a more efficient
> alternative to one-shot bottom halves, and saves the effort of tracking
> which AioContext a coroutine is running on.
> 
> aio_co_schedule is the part of aio_co_wake that starts a coroutine
> on a remove AioContext, but it is also useful to implement e.g.

s/remove/remote/ and maybe s/but/and/ ?

> bdrv_set_aio_context callbacks.
> 
> The implementation of aio_co_schedule is based on a lock-free
> multiple-producer, single-consumer queue.  The multiple producers use
> cmpxchg to add to a LIFO stack.  The consumer (a per-AioContext bottom
> half) grabs all items added so far, inverts the list to make it FIFO,
> and goes through it one item at a time until it's empty.  The data
> structure was inspired by OSv, which uses it in the very code we'll
> "port" to QEMU for the thread-safe CoMutex.
> 
> Most of the new code is really tests.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  async.c                      |  65 +++++++++++++
>  include/block/aio.h          |  32 +++++++
>  include/qemu/coroutine_int.h |  10 +-
>  tests/Makefile.include       |  13 ++-
>  tests/iothread.c             |  91 ++++++++++++++++++
>  tests/iothread.h             |  25 +++++
>  tests/test-aio-multithread.c | 213 +++++++++++++++++++++++++++++++++++++++++++
>  tests/test-vmstate.c         |  11 ---
>  trace-events                 |   4 +
>  util/qemu-coroutine.c        |   8 ++
>  10 files changed, 456 insertions(+), 16 deletions(-)
>  create mode 100644 tests/iothread.c
>  create mode 100644 tests/iothread.h
>  create mode 100644 tests/test-aio-multithread.c
> 
> diff --git a/async.c b/async.c
> index 0d218ab..1338682 100644
> --- a/async.c
> +++ b/async.c
> @@ -30,6 +30,8 @@
>  #include "qemu/main-loop.h"
>  #include "qemu/atomic.h"
>  #include "block/raw-aio.h"
> +#include "trace/generated-tracers.h"
> +#include "qemu/coroutine_int.h"
>  
>  /***********************************************************/
>  /* bottom halves (can be seen as timers which expire ASAP) */
> @@ -274,6 +276,9 @@ aio_ctx_finalize(GSource     *source)
>      }
>  #endif
>  
> +    assert(QSLIST_EMPTY(&ctx->scheduled_coroutines));
> +    qemu_bh_delete(ctx->co_schedule_bh);
> +
>      qemu_lockcnt_lock(&ctx->list_lock);
>      assert(!qemu_lockcnt_count(&ctx->list_lock));
>      while (ctx->first_bh) {
> @@ -363,6 +368,28 @@ static bool event_notifier_poll(void *opaque)
>      return atomic_read(&ctx->notified);
>  }
>  
> +static void co_schedule_bh_cb(void *opaque)
> +{
> +    AioContext *ctx = opaque;
> +    QSLIST_HEAD(, Coroutine) straight, reversed;
> +
> +    QSLIST_MOVE_ATOMIC(&reversed, &ctx->scheduled_coroutines);
> +    QSLIST_INIT(&straight);

Worth special casing 1 element case?

> +
> +    while (!QSLIST_EMPTY(&reversed)) {
> +        Coroutine *co = QSLIST_FIRST(&reversed);
> +        QSLIST_REMOVE_HEAD(&reversed, co_scheduled_next);
> +        QSLIST_INSERT_HEAD(&straight, co, co_scheduled_next);
> +    }
> +
> +    while (!QSLIST_EMPTY(&straight)) {
> +        Coroutine *co = QSLIST_FIRST(&straight);
> +        QSLIST_REMOVE_HEAD(&straight, co_scheduled_next);
> +        trace_aio_co_schedule_bh_cb(ctx, co);
> +        qemu_coroutine_enter(co);
> +    }
> +}
> +
> diff --git a/tests/iothread.c b/tests/iothread.c
> new file mode 100644
> index 0000000..777d9ee
> --- /dev/null
> +++ b/tests/iothread.c
> @@ -0,0 +1,91 @@
> +/*
> + * Event loop thread implementation for unit tests

Curious: what is preventing from (perhaps enhancing and then) using the top
iothread.c implementation?

> + *
> + * Copyright Red Hat Inc., 2013, 2016
> + *
> + * Authors:
> + *  Stefan Hajnoczi   <stefanha@redhat.com>
> + *  Paolo Bonzini     <pbonzini@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or later.
> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "block/aio.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/rcu.h"
> +#include "iothread.h"
> +
> +struct IOThread {
> +    AioContext *ctx;
> +
> +    QemuThread thread;
> +    QemuMutex init_done_lock;
> +    QemuCond init_done_cond;    /* is thread initialization done? */
> +    bool stopping;
> +};
> +
> +static __thread IOThread *my_iothread;
> +
> +AioContext *qemu_get_current_aio_context(void)
> +{
> +    return my_iothread ? my_iothread->ctx : qemu_get_aio_context();
> +}
> +
> +static void *iothread_run(void *opaque)
> +{
> +    IOThread *iothread = opaque;
> +
> +    rcu_register_thread();
> +
> +    my_iothread = iothread;
> +    qemu_mutex_lock(&iothread->init_done_lock);
> +    iothread->ctx = aio_context_new(&error_abort);
> +    qemu_cond_signal(&iothread->init_done_cond);
> +    qemu_mutex_unlock(&iothread->init_done_lock);
> +
> +    while (!atomic_read(&iothread->stopping)) {
> +        aio_poll(iothread->ctx, true);
> +    }
> +
> +    rcu_unregister_thread();
> +    return NULL;
> +}
> +
> +void iothread_join(IOThread *iothread)
> +{
> +    iothread->stopping = true;
> +    aio_notify(iothread->ctx);
> +    qemu_thread_join(&iothread->thread);
> +    qemu_cond_destroy(&iothread->init_done_cond);
> +    qemu_mutex_destroy(&iothread->init_done_lock);
> +    aio_context_unref(iothread->ctx);
> +    g_free(iothread);
> +}
> +
> +IOThread *iothread_new(void)
> +{
> +    IOThread *iothread = g_new0(IOThread, 1);
> +
> +    qemu_mutex_init(&iothread->init_done_lock);
> +    qemu_cond_init(&iothread->init_done_cond);
> +    qemu_thread_create(&iothread->thread, NULL, iothread_run,
> +                       iothread, QEMU_THREAD_JOINABLE);
> +
> +    /* Wait for initialization to complete */
> +    qemu_mutex_lock(&iothread->init_done_lock);
> +    while (iothread->ctx == NULL) {
> +        qemu_cond_wait(&iothread->init_done_cond,
> +                       &iothread->init_done_lock);
> +    }
> +    qemu_mutex_unlock(&iothread->init_done_lock);
> +    return iothread;
> +}
> +
> +AioContext *iothread_get_aio_context(IOThread *iothread)
> +{
> +    return iothread->ctx;
> +}
> diff --git a/tests/test-aio-multithread.c b/tests/test-aio-multithread.c
> new file mode 100644
> index 0000000..17e81f9
> --- /dev/null
> +++ b/tests/test-aio-multithread.c
> @@ -0,0 +1,213 @@
> +/*
> + * AioContext multithreading tests
> + *
> + * Copyright Red Hat, Inc. 2016
> + *
> + * Authors:
> + *  Paolo Bonzini    <pbonzini@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2 or later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include <glib.h>
> +#include "block/aio.h"
> +#include "qapi/error.h"
> +#include "qemu/coroutine.h"
> +#include "qemu/thread.h"
> +#include "qemu/error-report.h"
> +#include "iothread.h"
> +
> +/* AioContext management */
> +
> +#define NUM_CONTEXTS 5
> +
> +static IOThread *threads[NUM_CONTEXTS];
> +static AioContext *ctx[NUM_CONTEXTS];
> +static __thread int id = -1;
> +
> +static QemuEvent done_event;
> +
> +/* Run a function synchronously on a remote iothread. */
> +
> +typedef struct CtxRunData {
> +    QEMUBHFunc *cb;
> +    void *arg;
> +} CtxRunData;
> +
> +static void ctx_run_bh_cb(void *opaque)
> +{
> +    CtxRunData *data = opaque;
> +
> +    data->cb(data->arg);
> +    qemu_event_set(&done_event);
> +}
> +
> +static void ctx_run(int i, QEMUBHFunc *cb, void *opaque)
> +{
> +    CtxRunData data = {
> +        .cb = cb,
> +        .arg = opaque
> +    };
> +
> +    qemu_event_reset(&done_event);
> +    aio_bh_schedule_oneshot(ctx[i], ctx_run_bh_cb, &data);
> +    qemu_event_wait(&done_event);
> +}
> +
> +/* Starting the iothreads. */
> +
> +static void set_id_cb(void *opaque)
> +{
> +    int *i = opaque;
> +
> +    id = *i;
> +}
> +
> +static void create_aio_contexts(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < NUM_CONTEXTS; i++) {
> +        threads[i] = iothread_new();
> +        ctx[i] = iothread_get_aio_context(threads[i]);
> +    }
> +
> +    qemu_event_init(&done_event, false);
> +    for (i = 0; i < NUM_CONTEXTS; i++) {
> +        ctx_run(i, set_id_cb, &i);
> +    }
> +}
> +
> +/* Stopping the iothreads. */
> +
> +static void join_aio_contexts(void)
> +{
> +    int i;
> +
> +    for (i = 0; i < NUM_CONTEXTS; i++) {
> +        aio_context_ref(ctx[i]);
> +    }
> +    for (i = 0; i < NUM_CONTEXTS; i++) {
> +        iothread_join(threads[i]);
> +    }
> +    for (i = 0; i < NUM_CONTEXTS; i++) {
> +        aio_context_unref(ctx[i]);
> +    }
> +    qemu_event_destroy(&done_event);
> +}
> +
> +/* Basic test for the stuff above. */
> +
> +static void test_lifecycle(void)
> +{
> +    create_aio_contexts();
> +    join_aio_contexts();
> +}
> +
> +/* aio_co_schedule test.  */
> +
> +static Coroutine *to_schedule[NUM_CONTEXTS];
> +
> +static bool now_stopping;
> +
> +static int count_retry;
> +static int count_here;
> +static int count_other;
> +
> +static bool schedule_next(int n)
> +{
> +    Coroutine *co;
> +
> +    co = atomic_xchg(&to_schedule[n], NULL);
> +    if (!co) {
> +        atomic_inc(&count_retry);
> +        return false;
> +    }
> +
> +    if (n == id) {
> +        atomic_inc(&count_here);
> +    } else {
> +        atomic_inc(&count_other);
> +    }
> +
> +    aio_co_schedule(ctx[n], co);
> +    return true;
> +}
> +
> +static void finish_cb(void *opaque)
> +{
> +    schedule_next(id);
> +}
> +
> +static void test_multi_co_schedule_entry(void *opaque)
> +{
> +    g_assert(to_schedule[id] == NULL);
> +    atomic_mb_set(&to_schedule[id], qemu_coroutine_self());
> +
> +    while (!atomic_mb_read(&now_stopping)) {
> +        int n;
> +
> +        n = g_test_rand_int_range(0, NUM_CONTEXTS);
> +        schedule_next(n);
> +        qemu_coroutine_yield();
> +
> +        g_assert(to_schedule[id] == NULL);
> +        atomic_mb_set(&to_schedule[id], qemu_coroutine_self());
> +    }
> +}
> +
> +
> +static void test_multi_co_schedule(int seconds)
> +{
> +    int i;
> +
> +    count_here = count_other = count_retry = 0;
> +    now_stopping = false;
> +
> +    create_aio_contexts();
> +    for (i = 0; i < NUM_CONTEXTS; i++) {
> +        Coroutine *co1 = qemu_coroutine_create(test_multi_co_schedule_entry, NULL);
> +        aio_co_schedule(ctx[i], co1);
> +    }
> +
> +    g_usleep(seconds * 1000000);
> +
> +    atomic_mb_set(&now_stopping, true);
> +    for (i = 0; i < NUM_CONTEXTS; i++) {
> +        ctx_run(i, finish_cb, NULL);
> +        to_schedule[i] = NULL;
> +    }
> +
> +    join_aio_contexts();
> +    g_test_message("scheduled %d, queued %d, retry %d, total %d\n",
> +                  count_other, count_here, count_retry,
> +                  count_here + count_other + count_retry);
> +}
> +
> +static void test_multi_co_schedule_1(void)
> +{
> +    test_multi_co_schedule(1);
> +}
> +
> +static void test_multi_co_schedule_10(void)
> +{
> +    test_multi_co_schedule(10);
> +}
> +
> +/* End of tests.  */
> +
> +int main(int argc, char **argv)
> +{
> +    init_clocks();
> +
> +    g_test_init(&argc, &argv, NULL);
> +    g_test_add_func("/aio/multi/lifecycle", test_lifecycle);
> +    if (g_test_quick()) {
> +        g_test_add_func("/aio/multi/schedule", test_multi_co_schedule_1);
> +    } else {
> +        g_test_add_func("/aio/multi/schedule", test_multi_co_schedule_10);
> +    }
> +    return g_test_run();
> +}

Fam
