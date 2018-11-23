Received: from eggs.gnu.org ([2001:4830:134:3::10]:33406)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gQ9FB-0007cx-IS
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 06:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gQ9F7-0004bv-DU
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 06:03:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49960)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gQ9F7-0004ar-3f
	for qemu-devel@nongnu.org; Fri, 23 Nov 2018 06:03:25 -0500
Date: Fri, 23 Nov 2018 11:02:40 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181123110239.GC2373@work-vm>
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181122072028.22819-3-xiaoguangrong@tencent.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: guangrong.xiao@gmail.com
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>

* guangrong.xiao@gmail.com (guangrong.xiao@gmail.com) wrote:
> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>=20
> This modules implements the lockless and efficient threaded workqueue.
>=20
> Three abstracted objects are used in this module:
> - Request.
>      It not only contains the data that the workqueue fetches out
>     to finish the request but also offers the space to save the result
>     after the workqueue handles the request.
>=20
>     It's flowed between user and workqueue. The user fills the request
>     data into it when it is owned by user. After it is submitted to the
>     workqueue, the workqueue fetched data out and save the result into
>     it after the request is handled.
>=20
>     All the requests are pre-allocated and carefully partitioned betwee=
n
>     threads so there is no contention on the request, that make threads
>     be parallel as much as possible.
>=20
> - User, i.e, the submitter
>     It's the one fills the request and submits it to the workqueue,
>     the result will be collected after it is handled by the work queue.
>=20
>     The user can consecutively submit requests without waiting the prev=
ious
>     requests been handled.
>     It only supports one submitter, you should do serial submission by
>     yourself if you want more, e.g, use lock on you side.
>=20
> - Workqueue, i.e, thread
>     Each workqueue is represented by a running thread that fetches
>     the request submitted by the user, do the specified work and save
>     the result to the request.
>=20
> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
> ---
>  include/qemu/threaded-workqueue.h | 106 +++++++++
>  util/Makefile.objs                |   1 +
>  util/threaded-workqueue.c         | 463 ++++++++++++++++++++++++++++++=
++++++++
>  3 files changed, 570 insertions(+)
>  create mode 100644 include/qemu/threaded-workqueue.h
>  create mode 100644 util/threaded-workqueue.c
>=20
> diff --git a/include/qemu/threaded-workqueue.h b/include/qemu/threaded-=
workqueue.h
> new file mode 100644
> index 0000000000..e0ede496d0
> --- /dev/null
> +++ b/include/qemu/threaded-workqueue.h
> @@ -0,0 +1,106 @@
> +/*
> + * Lockless and Efficient Threaded Workqueue Abstraction
> + *
> + * Author:
> + *   Xiao Guangrong <xiaoguangrong@tencent.com>
> + *
> + * Copyright(C) 2018 Tencent Corporation.
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 =
or later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#ifndef QEMU_THREADED_WORKQUEUE_H
> +#define QEMU_THREADED_WORKQUEUE_H
> +
> +#include "qemu/queue.h"
> +#include "qemu/thread.h"
> +
> +/*
> + * This modules implements the lockless and efficient threaded workque=
ue.
> + *
> + * Three abstracted objects are used in this module:
> + * - Request.
> + *   It not only contains the data that the workqueue fetches out
> + *   to finish the request but also offers the space to save the resul=
t
> + *   after the workqueue handles the request.
> + *
> + *   It's flowed between user and workqueue. The user fills the reques=
t
> + *   data into it when it is owned by user. After it is submitted to t=
he
> + *   workqueue, the workqueue fetched data out and save the result int=
o
> + *   it after the request is handled.
> + *
> + *   All the requests are pre-allocated and carefully partitioned betw=
een
> + *   threads so there is no contention on the request, that make threa=
ds
> + *   be parallel as much as possible.
> + *
> + * - User, i.e, the submitter
> + *   It's the one fills the request and submits it to the workqueue,
> + *   the result will be collected after it is handled by the work queu=
e.
> + *
> + *   The user can consecutively submit requests without waiting the pr=
evious
> + *   requests been handled.
> + *   It only supports one submitter, you should do serial submission b=
y
> + *   yourself if you want more, e.g, use lock on you side.
> + *
> + * - Workqueue, i.e, thread
> + *   Each workqueue is represented by a running thread that fetches
> + *   the request submitted by the user, do the specified work and save
> + *   the result to the request.
> + */
> +
> +typedef struct Threads Threads;
> +
> +struct ThreadedWorkqueueOps {
> +    /* constructor of the request */
> +    int (*thread_request_init)(void *request);
> +    /*  destructor of the request */
> +    void (*thread_request_uninit)(void *request);
> +
> +    /* the handler of the request that is called by the thread */
> +    void (*thread_request_handler)(void *request);
> +    /* called by the user after the request has been handled */
> +    void (*thread_request_done)(void *request);
> +
> +    size_t request_size;
> +};
> +typedef struct ThreadedWorkqueueOps ThreadedWorkqueueOps;
> +
> +/* the default number of requests that thread need handle */
> +#define DEFAULT_THREAD_REQUEST_NR 4
> +/* the max number of requests that thread need handle */
> +#define MAX_THREAD_REQUEST_NR     (sizeof(uint64_t) * BITS_PER_BYTE)
> +
> +/*
> + * create a threaded queue. Other APIs will work on the Threads it ret=
urned
> + *
> + * @name: the identity of the workqueue which is used to construct the=
 name
> + *    of threads only
> + * @threads_nr: the number of threads that the workqueue will create
> + * @thread_requests_nr: the number of requests that each single thread=
 will
> + *    handle
> + * @ops: the handlers of the request
> + *
> + * Return NULL if it failed
> + */
> +Threads *threaded_workqueue_create(const char *name, unsigned int thre=
ads_nr,
> +                                   unsigned int thread_requests_nr,
> +                                   const ThreadedWorkqueueOps *ops);
> +void threaded_workqueue_destroy(Threads *threads);
> +
> +/*
> + * find a free request where the user can store the data that is neede=
d to
> + * finish the request
> + *
> + * If all requests are used up, return NULL
> + */
> +void *threaded_workqueue_get_request(Threads *threads);
> +/* submit the request and notify the thread */
> +void threaded_workqueue_submit_request(Threads *threads, void *request=
);
> +
> +/*
> + * wait all threads to complete the request to make sure there is no
> + * previous request exists
> + */
> +void threaded_workqueue_wait_for_requests(Threads *threads);
> +#endif
> diff --git a/util/Makefile.objs b/util/Makefile.objs
> index 0820923c18..f26dfe5182 100644
> --- a/util/Makefile.objs
> +++ b/util/Makefile.objs
> @@ -50,5 +50,6 @@ util-obj-y +=3D range.o
>  util-obj-y +=3D stats64.o
>  util-obj-y +=3D systemd.o
>  util-obj-y +=3D iova-tree.o
> +util-obj-y +=3D threaded-workqueue.o
>  util-obj-$(CONFIG_LINUX) +=3D vfio-helpers.o
>  util-obj-$(CONFIG_OPENGL) +=3D drm.o
> diff --git a/util/threaded-workqueue.c b/util/threaded-workqueue.c
> new file mode 100644
> index 0000000000..2ab37cee8d
> --- /dev/null
> +++ b/util/threaded-workqueue.c
> @@ -0,0 +1,463 @@
> +/*
> + * Lockless and Efficient Threaded Workqueue Abstraction
> + *
> + * Author:
> + *   Xiao Guangrong <xiaoguangrong@tencent.com>
> + *
> + * Copyright(C) 2018 Tencent Corporation.
> + *
> + * This work is licensed under the terms of the GNU LGPL, version 2.1 =
or later.
> + * See the COPYING.LIB file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/bitmap.h"
> +#include "qemu/threaded-workqueue.h"
> +
> +#define SMP_CACHE_BYTES 64

That's architecture dependent isn't it?

> +
> +/*
> + * the request representation which contains the internally used mete =
data,
> + * it is the header of user-defined data.
> + *
> + * It should be aligned to the nature size of CPU.
> + */
> +struct ThreadRequest {
> +    /*
> +     * the request has been handled by the thread and need the user
> +     * to fetch result out.
> +     */
> +    uint8_t done;
> +
> +    /*
> +     * the index to Thread::requests.
> +     * Save it to the padding space although it can be calculated at r=
untime.
> +     */
> +    uint8_t request_index;
> +
> +    /* the index to Threads::per_thread_data */
> +    unsigned int thread_index;
> +} QEMU_ALIGNED(sizeof(unsigned long));
> +typedef struct ThreadRequest ThreadRequest;
> +
> +struct ThreadLocal {
> +    struct Threads *threads;
> +
> +    /* the index of the thread */
> +    int self;
> +
> +    /* thread is useless and needs to exit */
> +    bool quit;
> +
> +    QemuThread thread;
> +
> +    void *requests;
> +
> +   /*
> +     * the bit in these two bitmaps indicates the index of the =EF=BC=A0=
requests
> +     * respectively. If it's the same, the corresponding request is fr=
ee
> +     * and owned by the user, i.e, where the user fills a request. Oth=
erwise,
> +     * it is valid and owned by the thread, i.e, where the thread fetc=
hes
> +     * the request and write the result.
> +     */
> +
> +    /* after the user fills the request, the bit is flipped. */
> +    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
> +    /* after handles the request, the thread flips the bit. */
> +    uint64_t request_done_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);

Patchew complained about some type mismatches; I think those are because
you're using the bitmap_* functions on these; those functions always
operate on 'long' not on uint64_t - and on some platforms they're
unfortunately not the same.


Dave

> +    /*
> +     * the event used to wake up the thread whenever a valid request h=
as
> +     * been submitted
> +     */
> +    QemuEvent request_valid_ev QEMU_ALIGNED(SMP_CACHE_BYTES);
> +
> +    /*
> +     * the event is notified whenever a request has been completed
> +     * (i.e, become free), which is used to wake up the user
> +     */
> +    QemuEvent request_free_ev QEMU_ALIGNED(SMP_CACHE_BYTES);
> +};
> +typedef struct ThreadLocal ThreadLocal;
> +
> +/*
> + * the main data struct represents multithreads which is shared by
> + * all threads
> + */
> +struct Threads {
> +    /* the request header, ThreadRequest, is contained */
> +    unsigned int request_size;
> +    unsigned int thread_requests_nr;
> +    unsigned int threads_nr;
> +
> +    /* the request is pushed to the thread with round-robin manner */
> +    unsigned int current_thread_index;
> +
> +    const ThreadedWorkqueueOps *ops;
> +
> +    ThreadLocal per_thread_data[0];
> +};
> +typedef struct Threads Threads;
> +
> +static ThreadRequest *index_to_request(ThreadLocal *thread, int reques=
t_index)
> +{
> +    ThreadRequest *request;
> +
> +    request =3D thread->requests + request_index * thread->threads->re=
quest_size;
> +    assert(request->request_index =3D=3D request_index);
> +    assert(request->thread_index =3D=3D thread->self);
> +    return request;
> +}
> +
> +static int request_to_index(ThreadRequest *request)
> +{
> +    return request->request_index;
> +}
> +
> +static int request_to_thread_index(ThreadRequest *request)
> +{
> +    return request->thread_index;
> +}
> +
> +/*
> + * free request: the request is not used by any thread, however, it mi=
ght
> + *   contain the result need the user to call thread_request_done()
> + *
> + * valid request: the request contains the request data and it's commi=
tted
> + *   to the thread, i,e. it's owned by thread.
> + */
> +static uint64_t get_free_request_bitmap(Threads *threads, ThreadLocal =
*thread)
> +{
> +    uint64_t request_fill_bitmap, request_done_bitmap, result_bitmap;
> +
> +    request_fill_bitmap =3D atomic_rcu_read(&thread->request_fill_bitm=
ap);
> +    request_done_bitmap =3D atomic_rcu_read(&thread->request_done_bitm=
ap);
> +    bitmap_xor(&result_bitmap, &request_fill_bitmap, &request_done_bit=
map,
> +               threads->thread_requests_nr);
> +
> +    /*
> +     * paired with smp_wmb() in mark_request_free() to make sure that =
we
> +     * read request_done_bitmap before fetching the result out.
> +     */
> +    smp_rmb();
> +
> +    return result_bitmap;
> +}
> +
> +static ThreadRequest
> +*find_thread_free_request(Threads *threads, ThreadLocal *thread)
> +{
> +    uint64_t result_bitmap =3D get_free_request_bitmap(threads, thread=
);
> +    int index;
> +
> +    index  =3D find_first_zero_bit(&result_bitmap, threads->thread_req=
uests_nr);
> +    if (index >=3D threads->thread_requests_nr) {
> +        return NULL;
> +    }
> +
> +    return index_to_request(thread, index);
> +}
> +
> +static ThreadRequest *threads_find_free_request(Threads *threads)
> +{
> +    ThreadLocal *thread;
> +    ThreadRequest *request;
> +    int cur_thread, thread_index;
> +
> +    cur_thread =3D threads->current_thread_index % threads->threads_nr=
;
> +    thread_index =3D cur_thread;
> +    do {
> +        thread =3D threads->per_thread_data + thread_index++;
> +        request =3D find_thread_free_request(threads, thread);
> +        if (request) {
> +            break;
> +        }
> +        thread_index %=3D threads->threads_nr;
> +    } while (thread_index !=3D cur_thread);
> +
> +    return request;
> +}
> +
> +/*
> + * the change bit operation combined with READ_ONCE and WRITE_ONCE whi=
ch
> + * only works on single uint64_t width
> + */
> +static void change_bit_once(long nr, uint64_t *addr)
> +{
> +    uint64_t value =3D atomic_rcu_read(addr) ^ BIT_MASK(nr);
> +
> +    atomic_rcu_set(addr, value);
> +}
> +
> +static void mark_request_valid(Threads *threads, ThreadRequest *reques=
t)
> +{
> +    int thread_index =3D request_to_thread_index(request);
> +    int request_index =3D request_to_index(request);
> +    ThreadLocal *thread =3D threads->per_thread_data + thread_index;
> +
> +    /*
> +     * paired with smp_rmb() in find_first_valid_request_index() to ma=
ke
> +     * sure the request has been filled before the bit is flipped that
> +     * will make the request be visible to the thread
> +     */
> +    smp_wmb();
> +
> +    change_bit_once(request_index, &thread->request_fill_bitmap);
> +    qemu_event_set(&thread->request_valid_ev);
> +}
> +
> +static int thread_find_first_valid_request_index(ThreadLocal *thread)
> +{
> +    Threads *threads =3D thread->threads;
> +    uint64_t request_fill_bitmap, request_done_bitmap, result_bitmap;
> +    int index;
> +
> +    request_fill_bitmap =3D atomic_rcu_read(&thread->request_fill_bitm=
ap);
> +    request_done_bitmap =3D atomic_rcu_read(&thread->request_done_bitm=
ap);
> +    bitmap_xor(&result_bitmap, &request_fill_bitmap, &request_done_bit=
map,
> +               threads->thread_requests_nr);
> +    /*
> +     * paired with smp_wmb() in mark_request_valid() to make sure that
> +     * we read request_fill_bitmap before fetch the request out.
> +     */
> +    smp_rmb();
> +
> +    index =3D find_first_bit(&result_bitmap, threads->thread_requests_=
nr);
> +    return index >=3D threads->thread_requests_nr ? -1 : index;
> +}
> +
> +static void mark_request_free(ThreadLocal *thread, ThreadRequest *requ=
est)
> +{
> +    int index =3D request_to_index(request);
> +
> +    /*
> +     * smp_wmb() is implied in change_bit_atomic() that is paired with
> +     * smp_rmb() in get_free_request_bitmap() to make sure the result
> +     * has been saved before the bit is flipped.
> +     */
> +    change_bit_atomic(index, &thread->request_done_bitmap);
> +    qemu_event_set(&thread->request_free_ev);
> +}
> +
> +/* retry to see if there is available request before actually go to wa=
it. */
> +#define BUSY_WAIT_COUNT 1000
> +
> +static ThreadRequest *
> +thread_busy_wait_for_request(ThreadLocal *thread)
> +{
> +    int index, count =3D 0;
> +
> +    for (count =3D 0; count < BUSY_WAIT_COUNT; count++) {
> +        index =3D thread_find_first_valid_request_index(thread);
> +        if (index >=3D 0) {
> +            return index_to_request(thread, index);
> +        }
> +
> +        cpu_relax();
> +    }
> +
> +    return NULL;
> +}
> +
> +static void *thread_run(void *opaque)
> +{
> +    ThreadLocal *self_data =3D (ThreadLocal *)opaque;
> +    Threads *threads =3D self_data->threads;
> +    void (*handler)(void *request) =3D threads->ops->thread_request_ha=
ndler;
> +    ThreadRequest *request;
> +
> +    for ( ; !atomic_read(&self_data->quit); ) {
> +        qemu_event_reset(&self_data->request_valid_ev);
> +
> +        request =3D thread_busy_wait_for_request(self_data);
> +        if (!request) {
> +            qemu_event_wait(&self_data->request_valid_ev);
> +            continue;
> +        }
> +
> +        assert(!request->done);
> +
> +        handler(request + 1);
> +        request->done =3D true;
> +        mark_request_free(self_data, request);
> +    }
> +
> +    return NULL;
> +}
> +
> +static void uninit_thread_requests(ThreadLocal *thread, int free_nr)
> +{
> +    Threads *threads =3D thread->threads;
> +    ThreadRequest *request =3D thread->requests;
> +    int i;
> +
> +    for (i =3D 0; i < free_nr; i++) {
> +        threads->ops->thread_request_uninit(request + 1);
> +        request =3D (void *)request + threads->request_size;
> +    }
> +    g_free(thread->requests);
> +}
> +
> +static int init_thread_requests(ThreadLocal *thread)
> +{
> +    Threads *threads =3D thread->threads;
> +    ThreadRequest *request;
> +    int ret, i, thread_reqs_size;
> +
> +    thread_reqs_size =3D threads->thread_requests_nr * threads->reques=
t_size;
> +    thread_reqs_size =3D QEMU_ALIGN_UP(thread_reqs_size, SMP_CACHE_BYT=
ES);
> +    thread->requests =3D g_malloc0(thread_reqs_size);
> +
> +    request =3D thread->requests;
> +    for (i =3D 0; i < threads->thread_requests_nr; i++) {
> +        ret =3D threads->ops->thread_request_init(request + 1);
> +        if (ret < 0) {
> +            goto exit;
> +        }
> +
> +        request->request_index =3D i;
> +        request->thread_index =3D thread->self;
> +        request =3D (void *)request + threads->request_size;
> +    }
> +    return 0;
> +
> +exit:
> +    uninit_thread_requests(thread, i);
> +    return -1;
> +}
> +
> +static void uninit_thread_data(Threads *threads, int free_nr)
> +{
> +    ThreadLocal *thread_local =3D threads->per_thread_data;
> +    int i;
> +
> +    for (i =3D 0; i < free_nr; i++) {
> +        thread_local[i].quit =3D true;
> +        qemu_event_set(&thread_local[i].request_valid_ev);
> +        qemu_thread_join(&thread_local[i].thread);
> +        qemu_event_destroy(&thread_local[i].request_valid_ev);
> +        qemu_event_destroy(&thread_local[i].request_free_ev);
> +        uninit_thread_requests(&thread_local[i], threads->thread_reque=
sts_nr);
> +    }
> +}
> +
> +static int
> +init_thread_data(Threads *threads, const char *thread_name, int thread=
_nr)
> +{
> +    ThreadLocal *thread_local =3D threads->per_thread_data;
> +    char *name;
> +    int i;
> +
> +    for (i =3D 0; i < thread_nr; i++) {
> +        thread_local[i].threads =3D threads;
> +        thread_local[i].self =3D i;
> +
> +        if (init_thread_requests(&thread_local[i]) < 0) {
> +            goto exit;
> +        }
> +
> +        qemu_event_init(&thread_local[i].request_free_ev, false);
> +        qemu_event_init(&thread_local[i].request_valid_ev, false);
> +
> +        name =3D g_strdup_printf("%s/%d", thread_name, thread_local[i]=
.self);
> +        qemu_thread_create(&thread_local[i].thread, name,
> +                           thread_run, &thread_local[i], QEMU_THREAD_J=
OINABLE);
> +        g_free(name);
> +    }
> +    return 0;
> +
> +exit:
> +    uninit_thread_data(threads, i);
> +    return -1;
> +}
> +
> +Threads *threaded_workqueue_create(const char *name, unsigned int thre=
ads_nr,
> +                                   unsigned int thread_requests_nr,
> +                                   const ThreadedWorkqueueOps *ops)
> +{
> +    Threads *threads;
> +
> +    if (threads_nr > MAX_THREAD_REQUEST_NR) {
> +        return NULL;
> +    }
> +
> +    threads =3D g_malloc0(sizeof(*threads) + threads_nr * sizeof(Threa=
dLocal));
> +    threads->ops =3D ops;
> +    threads->threads_nr =3D threads_nr;
> +    threads->thread_requests_nr =3D thread_requests_nr;
> +
> +    QEMU_BUILD_BUG_ON(!QEMU_IS_ALIGNED(sizeof(ThreadRequest), sizeof(l=
ong)));
> +    threads->request_size =3D threads->ops->request_size;
> +    threads->request_size =3D QEMU_ALIGN_UP(threads->request_size, siz=
eof(long));
> +    threads->request_size +=3D sizeof(ThreadRequest);
> +
> +    if (init_thread_data(threads, name, threads_nr) < 0) {
> +        g_free(threads);
> +        return NULL;
> +    }
> +
> +    return threads;
> +}
> +
> +void threaded_workqueue_destroy(Threads *threads)
> +{
> +    uninit_thread_data(threads, threads->threads_nr);
> +    g_free(threads);
> +}
> +
> +static void request_done(Threads *threads, ThreadRequest *request)
> +{
> +    if (!request->done) {
> +        return;
> +    }
> +
> +    threads->ops->thread_request_done(request + 1);
> +    request->done =3D false;
> +}
> +
> +void *threaded_workqueue_get_request(Threads *threads)
> +{
> +    ThreadRequest *request;
> +
> +    request =3D threads_find_free_request(threads);
> +    if (!request) {
> +        return NULL;
> +    }
> +
> +    request_done(threads, request);
> +    return request + 1;
> +}
> +
> +void threaded_workqueue_submit_request(Threads *threads, void *request=
)
> +{
> +    ThreadRequest *req =3D request - sizeof(ThreadRequest);
> +    int thread_index =3D request_to_thread_index(request);
> +
> +    assert(!req->done);
> +    mark_request_valid(threads, req);
> +    threads->current_thread_index =3D thread_index  + 1;
> +}
> +
> +void threaded_workqueue_wait_for_requests(Threads *threads)
> +{
> +    ThreadLocal *thread;
> +    uint64_t result_bitmap;
> +    int thread_index, index =3D 0;
> +
> +    for (thread_index =3D 0; thread_index < threads->threads_nr; threa=
d_index++) {
> +        thread =3D threads->per_thread_data + thread_index;
> +        index =3D 0;
> +retry:
> +        qemu_event_reset(&thread->request_free_ev);
> +        result_bitmap =3D get_free_request_bitmap(threads, thread);
> +
> +        for (; index < threads->thread_requests_nr; index++) {
> +            if (test_bit(index, &result_bitmap)) {
> +                qemu_event_wait(&thread->request_free_ev);
> +                goto retry;
> +            }
> +
> +            request_done(threads, index_to_request(thread, index));
> +        }
> +    }
> +}
> --=20
> 2.14.5
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
