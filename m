Received: from eggs.gnu.org ([2001:4830:134:3::10]:54967)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCimk-0001oF-S3
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:10:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gCimf-0002aO-UX
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:10:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gCimf-0002Uf-LG
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:10:33 -0400
References: <20181016111006.629-1-xiaoguangrong@tencent.com>
	<20181016111006.629-3-xiaoguangrong@tencent.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <873d9b11-3643-28d1-e7d8-44657402fa56@redhat.com>
Date: Wed, 17 Oct 2018 12:10:15 +0200
MIME-Version: 1.0
In-Reply-To: <20181016111006.629-3-xiaoguangrong@tencent.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/4] migration: introduce lockless
 multithreads model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com, mst@redhat.com, mtosatti@redhat.com
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>, "Emilio G. Cota" <cota@braap.org>

On 16/10/2018 13:10, guangrong.xiao@gmail.com wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>=20
> Current implementation of compression and decompression are very
> hard to be enabled on productions. We noticed that too many wait-wakes
> go to kernel space and CPU usages are very low even if the system
> is really free
>=20
> The reasons are:
> 1) there are two many locks used to do synchronous=EF=BC=8Cthere
> =E3=80=80=E3=80=80is a global lock and each single thread has its own l=
ock,
> =E3=80=80=E3=80=80migration thread and work threads need to go to sleep=
 if
> =E3=80=80=E3=80=80these locks are busy
>=20
> 2) migration thread separately submits request to the thread
>    however, only one request can be pended, that means, the
>    thread has to go to sleep after finishing the request
>=20
> To make it work better, we introduce a lockless multithread model,
> the user, currently it is the migration thread, submits request
> to each thread which has its own ring whose capacity is 4 and
> puts the result to a global ring where the user fetches result
> out and do remaining operations for the request, e.g, posting the
> compressed data out for migration on the source QEMU
>=20
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  include/qemu/lockless-threads.h |  63 +++++++
>  util/Makefile.objs              |   1 +
>  util/lockless-threads.c         | 373 ++++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 437 insertions(+)
>  create mode 100644 include/qemu/lockless-threads.h
>  create mode 100644 util/lockless-threads.c
>=20
> diff --git a/include/qemu/lockless-threads.h b/include/qemu/lockless-th=
reads.h
> new file mode 100644
> index 0000000000..9340d3a748
> --- /dev/null
> +++ b/include/qemu/lockless-threads.h
> @@ -0,0 +1,63 @@
> +/*
> + * Lockless Multithreads Abstraction
> + *
> + * This is the abstraction layer for lockless multithreads management.
> + *
> + * Note: currently only one producer is allowed.
> + *
> + * Copyright(C) 2018 Tencent Corporation.
> + *
> + * Author:
> + *   Xiao Guangrong <xiaoguangrong@tencent.com>
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 =
or later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#ifndef QEMU_LOCKLESS_THREAD_H
> +#define QEMU_LOCKLESS_THREAD_H
> +
> +#include "qemu/queue.h"
> +#include "qemu/thread.h"
> +#include "qemu/ptr_ring.h"
> +
> +/*
> + * the request representation which contains the internally used mete =
data,
> + * it can be embedded to user's self-defined data struct and the user =
can
> + * use container_of() to get the self-defined data
> + */
> +struct ThreadRequest {
> +    QSLIST_ENTRY(ThreadRequest) node;
> +    unsigned int thread_index;
> +};
> +typedef struct ThreadRequest ThreadRequest;
> +
> +typedef struct Threads Threads;

The module is really nice.  I just have a few suggestions on the naming
and the data organization, but it's really small stuff.  The only bigger
suggestion is about the communication of completed requests back to the
submitter.

First, can you rename this module to something like ThreadedWorkqueue?
(So threaded_workqueue_create, threaded_workqueue_destroy, ...)  The
file can also be renamed to {qemu,utils}/threaded-workqueue.[ch].

> +/* the size of thread local request ring on default */
> +#define DEFAULT_THREAD_RING_SIZE 4
> +
> +Threads *threads_create(unsigned int threads_nr, const char *name,
> +                        int thread_ring_size,
> +                        ThreadRequest *(*thread_request_init)(void),
> +                        void (*thread_request_uninit)(ThreadRequest *r=
equest),
> +                        void (*thread_request_handler)(ThreadRequest *=
request),
> +                        void (*thread_request_done)(ThreadRequest *req=
uest));

Please put these four members into a ThreadedWorkqueueOps struct.

> +void threads_destroy(Threads *threads);
> +
> +/*
> + * find a free request and associate it with a free thread.
> + * If no request or no thread is free, return NULL
> + */
> +ThreadRequest *threads_submit_request_prepare(Threads *threads);

threaded_workqueue_get_request

> +/*
> + * push the request to its thread's local ring and notify the thread
> + */
> +void threads_submit_request_commit(Threads *threads, ThreadRequest *re=
quest);

threaded_workqueue_submit_request

> +/*
> + * wait all threads to complete the request filled in their local ring=
s
> + * to make sure there is no previous request exists.
> + */
> +void threads_wait_done(Threads *threads);

threaded_workqueue_wait_for_requests

?

> +struct ThreadLocal {
> +    QemuThread thread;
> +
> +    /* the event used to wake up the thread */
> +    QemuEvent ev;
> +
> +    struct Threads *threads;
> +
> +    /* local request ring which is filled by the user */
> +    Ptr_Ring request_ring;

Put the request ring and ev first, so that they certainly fit a
cacheline together.

> +    /* the index of the thread */
> +    int self;
> +
> +    /* thread is useless and needs to exit */
> +    bool quit;
> +};
> +typedef struct ThreadLocal ThreadLocal;
> +
> +/*
> + * the main data struct represents multithreads which is shared by
> + * all threads
> + */
> +struct Threads {
> +    const char *name;
> +    unsigned int threads_nr;
> +    /* the request is pushed to the thread with round-robin manner */
> +    unsigned int current_thread_index;
> +
> +    int thread_ring_size;
> +    int total_requests;
> +
> +    /* the request is pre-allocated and linked in the list */
> +    int free_requests_nr;
> +    QSLIST_HEAD(, ThreadRequest) free_requests;
> +
> +    /* the constructor of request */
> +    ThreadRequest *(*thread_request_init)(void);
> +    /* the destructor of request */
> +    void (*thread_request_uninit)(ThreadRequest *request);
> +    /* the handler of the request which is called in the thread */
> +    void (*thread_request_handler)(ThreadRequest *request);
> +    /*
> +     * the handler to process the result which is called in the
> +     * user's context
> +     */
> +    void (*thread_request_done)(ThreadRequest *request);

You can now store the ops struct pointer here instead of the four
separate fields.

> +    /* the thread push the result to this ring so it has multiple prod=
ucers */
> +    QemuSpin done_ring_lock;
> +    Ptr_Ring request_done_ring;

Again, putting the request_done_ring first ensures that there's no false
sharing with ops.  Though, see more below about the request_done_ring.
My suggestion below would change these three fields to:

    char *requests;
    unsigned long *completed_requests;
    QemuEvent complete_ev;

> +    ThreadLocal per_thread_data[0];
> +};
> +typedef struct Threads Threads;
> +
> +static void put_done_request(Threads *threads, ThreadRequest *request)
> +{
> +    int ret;
> +
> +    qemu_spin_lock(&threads->done_ring_lock);
> +    ret =3D ptr_ring_produce(&threads->request_done_ring, request);
> +    /* there should be enough room to save all request. */
> +    assert(!ret);
> +    qemu_spin_unlock(&threads->done_ring_lock);
> +}

An idea: the total number of requests is going to be very small, and a
PtrRing is not the nicest data structure for multiple producer/single
consumer.  So you could instead:

- add the size of one request to the ops structure.  Move the allocation
in init_requests, so that you can have one single large array that
stores all requests.  thread_request_init gets the pointer to a single
request.

- now that you have a single array (let's call it threads->requests),
the request index can be found with "(req - threads->requests) /
threads->ops->request_size".  The thread index, furthermore, is just
request_index / threads->thread_ring_size and you can remove it from
ThreadRequest.

- now that you have request indices, you can replace the completion
ptr_ring with a bitmap, and set a bit in the bitmap with set_bit_atomic
to report completion.  On the writer side you use find_next_bit to find
a completed request and clear_bit_atomic to clear its index.  The index
passed to find_next_bit is threads->current_thread_index *
threads->thread_ring_size,  And you also don't need find_free_thread,
because you can update threads->current_thread_index to

    threads->current_thread_index =3D
       ((free_request_id / threads->thread_ring_size) + 1)
        % threads->thread_nr;

after you prepare a request, and threads will then naturally receive
requests in round-robin order.  (If find_next_bit fails it means you
have to move the current_thread_index to 0 and retry).

- you don't need the free requests list and free_requests_nr either: you
just initialize the completed request bitmap to all-ones, and
find_next_bit + clear_bit_atomic will do the work of free_requests.
ThreadRequest goes away completely now!

The advantage is that you get rid of the spinlock on the consumer side,
and many auxiliary data structures on the producer side: a bitmap is a
much nicer data structure for multiple producer/single consumer than the
PtrRing.  In addition, with this design the entire Threads structure
becomes read-mostly, which is nice for the cache.  The disadvantage is
that you add an atomic operation (clear_bit_atomic) to
threads_submit_request_prepare(*).

The PtrRing is still useful for the other direction, because there you
have single producer/single consumer.

	(*) It's probably possible to have two separate bitmaps, e.g.
	    where the producer and consumers *flip* bits and the
	    producer looks for mismatched bits between the two bitmaps.
	    I'm not asking you to flesh out and implement that; it's
	    just why I think you can ignore the extra cost of
	    clear_bit_atomic.  In fact, if the maintainers think this
	    is overkill you can go ahead with just the naming fixes and
	    I'll take a look at a rewrite when I have some time for fun
	    stuff. :)

> +void threads_wait_done(Threads *threads)
> +{
> +    ThreadRequest *requests[DEFAULT_THREAD_RING_SIZE * 2];
> +    int nr;
> +
> +retry:
> +    nr =3D ptr_ring_consume_batched(&threads->request_done_ring,
> +                                  (void **)requests, ARRAY_SIZE(reques=
ts));

This is not a fast path, so it should use an event in the
thread->submitter direction too.  qemu_event_set is quite fast
(basically a smp_mb but no cacheline bouncing) if the event is already
set, so it should not be a performance problem to add it in
put_done_request after set_bit_atomic.  (This is more or less unrelated
to the bitmap idea above).

Emilio, can you review the above ideas?

Paolo

> +    while (nr--) {
> +        threads->thread_request_done(requests[nr]);
> +       add_free_request(threads, requests[nr]);
> +    }
> +
> +    if (threads->free_requests_nr !=3D threads->total_requests) {
> +        cpu_relax();
> +        goto retry;
> +    }
> +}
>=20
