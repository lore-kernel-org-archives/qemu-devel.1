Received: from eggs.gnu.org ([2001:4830:134:3::10]:43039)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYXrX-0005Dy-NA
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:25:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1fYXrS-0004Mg-QS
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:25:31 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:41134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1fYXrS-0004Lw-G9
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:25:26 -0400
Received: by mail-pl0-x241.google.com with SMTP id w8-v6so2862473ply.8
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 07:25:26 -0700 (PDT)
References: <20180604095520.8563-1-xiaoguangrong@tencent.com>
	<20180604095520.8563-11-xiaoguangrong@tencent.com>
	<20180620065202.GG18985@xz-mi>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <6192b914-59ef-8417-39f9-176f95f95a92@gmail.com>
Date: Thu, 28 Jun 2018 22:25:20 +0800
MIME-Version: 1.0
In-Reply-To: <20180620065202.GG18985@xz-mi>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 10/12] migration: introduce lockless
 multithreads model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, jiang.biao2@zte.com.cn, wei.w.wang@intel.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 06/20/2018 02:52 PM, Peter Xu wrote:
> On Mon, Jun 04, 2018 at 05:55:18PM +0800, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> Current implementation of compression and decompression are very
>> hard to be enabled on productions. We noticed that too many wait-wakes
>> go to kernel space and CPU usages are very low even if the system
>> is really free
>>

> Not sure how other people think, for me these information suites
> better as cover letter.  For commit message, I would prefer to know
> about something like: what this thread model can do; how the APIs are
> designed and used; what's the limitations, etc.  After all until this
> patch nowhere is using the new model yet, so these numbers are a bit
> misleading.
> 

Yes, i completely agree with you, i will remove it for its changelog.

>>
>> Signed-off-by: Xiao Guangrong <xiaoguangrong@tencent.com>
>> ---
>>   migration/Makefile.objs |   1 +
>>   migration/threads.c     | 265 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   migration/threads.h     | 116 +++++++++++++++++++++
> 
> Again, this model seems to be suitable for scenarios even outside
> migration.  So I'm not sure whether you'd like to generalize it (I
> still see e.g. constants and comments related to migration, but there
> aren't much) and put it into util/.

Sure, that's good to me. :)

> 
>>   3 files changed, 382 insertions(+)
>>   create mode 100644 migration/threads.c
>>   create mode 100644 migration/threads.h
>>
>> diff --git a/migration/Makefile.objs b/migration/Makefile.objs
>> index c83ec47ba8..bdb61a7983 100644
>> --- a/migration/Makefile.objs
>> +++ b/migration/Makefile.objs
>> @@ -7,6 +7,7 @@ common-obj-y += qemu-file-channel.o
>>   common-obj-y += xbzrle.o postcopy-ram.o
>>   common-obj-y += qjson.o
>>   common-obj-y += block-dirty-bitmap.o
>> +common-obj-y += threads.o
>>   
>>   common-obj-$(CONFIG_RDMA) += rdma.o
>>   
>> diff --git a/migration/threads.c b/migration/threads.c
>> new file mode 100644
>> index 0000000000..eecd3229b7
>> --- /dev/null
>> +++ b/migration/threads.c
>> @@ -0,0 +1,265 @@
>> +#include "threads.h"
>> +
>> +/* retry to see if there is avilable request before actually go to wait. */
>> +#define BUSY_WAIT_COUNT 1000
>> +
>> +static void *thread_run(void *opaque)
>> +{
>> +    ThreadLocal *self_data = (ThreadLocal *)opaque;
>> +    Threads *threads = self_data->threads;
>> +    void (*handler)(ThreadRequest *data) = threads->thread_request_handler;
>> +    ThreadRequest *request;
>> +    int count, ret;
>> +
>> +    for ( ; !atomic_read(&self_data->quit); ) {
>> +        qemu_event_reset(&self_data->ev);
>> +
>> +        count = 0;
>> +        while ((request = ring_get(self_data->request_ring)) ||
>> +            count < BUSY_WAIT_COUNT) {
>> +             /*
>> +             * wait some while before go to sleep so that the user
>> +             * needn't go to kernel space to wake up the consumer
>> +             * threads.
>> +             *
>> +             * That will waste some CPU resource indeed however it
>> +             * can significantly improve the case that the request
>> +             * will be available soon.
>> +             */
>> +             if (!request) {
>> +                cpu_relax();
>> +                count++;
>> +                continue;
>> +            }
>> +            count = 0;
>> +
>> +            handler(request);
>> +
>> +            do {
>> +                ret = ring_put(threads->request_done_ring, request);
>> +                /*
>> +                 * request_done_ring has enough room to contain all
>> +                 * requests, however, theoretically, it still can be
>> +                 * fail if the ring's indexes are overflow that would
>> +                 * happen if there is more than 2^32 requests are
> 
> Could you elaborate why this ring_put() could fail, and why failure is
> somehow related to 2^32 overflow?
> 
> Firstly, I don't understand why it will fail.

As we explained in the previous mail:

| Without it we can easily observe a "strange" behavior that the thread will
| put the result to the global ring failed even if we allocated enough room
| for the global ring (its capability >= total requests), that's because
| these two indexes can be updated at anytime, consider the case that multiple
| get and put operations can be finished between reading ring->in and ring->out
| so that very possibly ring->in can pass the value readed from ring->out.
|
| Having this code, the negative case only happens if these two indexes (32 bits)
| overflows to the same value, that can help us to catch potential bug in the
| code.
> 
> Meanwhile, AFAIU your ring can even live well with that 2^32 overflow.
> Or did I misunderstood?

Please refer to the code:
+        if (__ring_is_full(ring, in, out)) {
+            if (atomic_read(&ring->in) == in &&
+                atomic_read(&ring->out) == out) {
+                return -ENOBUFS;
+            }

As we allocated enough room for this global ring so there is the only case
that put data will fail that the indexes are overflowed to the same value.

This possibly 2^32 get/put operations happened on other threads and main
thread when this thread is reading these two indexes.


>> +                 * handled between two calls of threads_wait_done().
>> +                 * So we do retry to make the code more robust.
>> +                 *
>> +                 * It is unlikely the case for migration as the block's
>> +                 * memory is unlikely more than 16T (2^32 pages) memory.
> 
> (some migration-related comments; maybe we can remove that)

Okay, i will consider it to make it more general.

>> +Threads *threads_create(unsigned int threads_nr, const char *name,
>> +                        ThreadRequest *(*thread_request_init)(void),
>> +                        void (*thread_request_uninit)(ThreadRequest *request),
>> +                        void (*thread_request_handler)(ThreadRequest *request),
>> +                        void (*thread_request_done)(ThreadRequest *request))
>> +{
>> +    Threads *threads;
>> +    int ret;
>> +
>> +    threads = g_malloc0(sizeof(*threads) + threads_nr * sizeof(ThreadLocal));
>> +    threads->threads_nr = threads_nr;
>> +    threads->thread_ring_size = THREAD_REQ_RING_SIZE;
> 
> (If we're going to generalize this thread model, maybe you'd consider
>   to allow specify this ring size as well?)

Good point, will do it.

> 
>> +    threads->total_requests = threads->thread_ring_size * threads_nr;
>> +
>> +    threads->name = name;
>> +    threads->thread_request_init = thread_request_init;
>> +    threads->thread_request_uninit = thread_request_uninit;
>> +    threads->thread_request_handler = thread_request_handler;
>> +    threads->thread_request_done = thread_request_done;
>> +
>> +    ret = init_requests(threads);
>> +    if (ret) {
>> +        g_free(threads);
>> +        return NULL;
>> +    }
>> +
>> +    init_thread_data(threads);
>> +    return threads;
>> +}
>> +
>> +void threads_destroy(Threads *threads)
>> +{
>> +    uninit_thread_data(threads);
>> +    uninit_requests(threads, threads->total_requests);
>> +    g_free(threads);
>> +}
>> +
>> +ThreadRequest *threads_submit_request_prepare(Threads *threads)
>> +{
>> +    ThreadRequest *request;
>> +    unsigned int index;
>> +
>> +    index = threads->current_thread_index % threads->threads_nr;
> 
> Why round-robin rather than simply find a idle thread (still with
> valid free requests) and put the request onto that?
> 
> Asked since I don't see much difficulty to achieve that, meanwhile for
> round-robin I'm not sure whether it can happen that one thread stuck
> due to some reason (e.g., scheduling reason?), while the rest of the
> threads are idle, then would threads_submit_request_prepare() be stuck
> for that hanging thread?
> 

You concern is reasonable indeed, however, the RR is the simplest
algorithm to push one request to threads without figuring the
lightest thread out one by one which makes the main thread fast
enough.

And i think it generally works not bad for a load-balanced system,
further more, the good configuration we think is that if the user
uses N threads to compression, he should make sure the system should
have enough CPU resource to run these N threads.

We can improve it after this basic framework gets merged by using
more advanced distribution approach if we see it's needed in
the future.

>> diff --git a/migration/threads.h b/migration/threads.h
>> new file mode 100644
>> index 0000000000..eced913065
>> --- /dev/null
>> +++ b/migration/threads.h
>> @@ -0,0 +1,116 @@
>> +#ifndef QEMU_MIGRATION_THREAD_H
>> +#define QEMU_MIGRATION_THREAD_H
>> +
>> +/*
>> + * Multithreads abstraction
>> + *
>> + * This is the abstraction layer for multithreads management which is
>> + * used to speed up migration.
>> + *
>> + * Note: currently only one producer is allowed.
>> + *
>> + * Copyright(C) 2018 Tencent Corporation.
>> + *
>> + * Author:
>> + *   Xiao Guangrong <xiaoguangrong@tencent.com>
>> + *
>> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
>> + * See the COPYING.LIB file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
> 
> I was told (more than once) that we should not include "osdep.h" in
> headers. :) I'll suggest you include that in the source file.

Okay, good to know it. :)

> 
>> +#include "hw/boards.h"
> 
> Why do we need this header?

Well, i need to figure out the right head files to include the declarations
we used. :)

> 
>> +
>> +#include "ring.h"
>> +
>> +/*
>> + * the request representation which contains the internally used mete data,
>> + * it can be embedded to user's self-defined data struct and the user can
>> + * use container_of() to get the self-defined data
>> + */
>> +struct ThreadRequest {
>> +    QSLIST_ENTRY(ThreadRequest) node;
>> +    unsigned int thread_index;
>> +};
>> +typedef struct ThreadRequest ThreadRequest;
>> +
>> +struct Threads;
>> +
>> +struct ThreadLocal {
>> +    QemuThread thread;
>> +
>> +    /* the event used to wake up the thread */
>> +    QemuEvent ev;
>> +
>> +    struct Threads *threads;
>> +
>> +    /* local request ring which is filled by the user */
>> +    Ring *request_ring;
>> +
>> +    /* the index of the thread */
>> +    int self;
>> +
>> +    /* thread is useless and needs to exit */
>> +    bool quit;
>> +};
>> +typedef struct ThreadLocal ThreadLocal;
>> +
>> +/*
>> + * the main data struct represents multithreads which is shared by
>> + * all threads
>> + */
>> +struct Threads {
>> +    const char *name;
>> +    unsigned int threads_nr;
>> +    /* the request is pushed to the thread with round-robin manner */
>> +    unsigned int current_thread_index;
>> +
>> +    int thread_ring_size;
>> +    int total_requests;
>> +
>> +    /* the request is pre-allocated and linked in the list */
>> +    int free_requests_nr;
>> +    QSLIST_HEAD(, ThreadRequest) free_requests;
>> +
>> +    /* the constructor of request */
>> +    ThreadRequest *(*thread_request_init)(void);
>> +    /* the destructor of request */
>> +    void (*thread_request_uninit)(ThreadRequest *request);
>> +    /* the handler of the request which is called in the thread */
>> +    void (*thread_request_handler)(ThreadRequest *request);
>> +    /*
>> +     * the handler to process the result which is called in the
>> +     * user's context
>> +     */
>> +    void (*thread_request_done)(ThreadRequest *request);
>> +
>> +    /* the thread push the result to this ring so it has multiple producers */
>> +    Ring *request_done_ring;
>> +
>> +    ThreadLocal per_thread_data[0];
>> +};
>> +typedef struct Threads Threads;
> 
> Not sure whether we can move Threads/ThreadLocal definition into the
> source file, then we only expose the struct definition, along with the
> APIs.

Yup, that's better indeed, thank you, Peter!
