Received: from eggs.gnu.org ([2001:4830:134:3::10]:48345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRvct-0004jI-8C
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:55:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gRvcq-0001Vo-Ha
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:55:19 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34089)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gRvcq-0001Uo-4G
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 03:55:16 -0500
Received: by mail-pl1-x641.google.com with SMTP id w4so43944plz.1
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 00:55:15 -0800 (PST)
References: <20181122072028.22819-1-xiaoguangrong@tencent.com>
	<20181122072028.22819-3-xiaoguangrong@tencent.com>
	<BB9071C9-5BED-4763-99B3-7083B8EB49CF@redhat.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <0a287afc-1782-737e-b886-62d21220726f@gmail.com>
Date: Wed, 28 Nov 2018 16:55:06 +0800
MIME-Version: 1.0
In-Reply-To: <BB9071C9-5BED-4763-99B3-7083B8EB49CF@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christophe de Dinechin <dinechin@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, cota@braap.org, Xiao Guangrong <xiaoguangrong@tencent.com>



On 11/27/18 8:49 PM, Christophe de Dinechin wrote:
> (I did not finish the review, but decided to send what I already had).
> 
> 
>> On 22 Nov 2018, at 08:20, guangrong.xiao@gmail.com wrote:
>>
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> This modules implements the lockless and efficient threaded workqueue.
> 
> I’m not entirely convinced that it’s either “lockless” or “efficient”
> in the current iteration. I believe that it’s relatively easy to fix, though.
> 

I think Emilio has already replied to your concern why it is "lockless". :)

>>
>> Three abstracted objects are used in this module:
>> - Request.
>>      It not only contains the data that the workqueue fetches out
>>     to finish the request but also offers the space to save the result
>>     after the workqueue handles the request.
>>
>>     It's flowed between user and workqueue. The user fills the request
>>     data into it when it is owned by user. After it is submitted to the
>>     workqueue, the workqueue fetched data out and save the result into
>>     it after the request is handled.
> 
> fetched -> fetches
> save -> saves

Will fix... My English is even worse than C. :(

>> +
>> +/*
>> + * find a free request where the user can store the data that is needed to
>> + * finish the request
>> + *
>> + * If all requests are used up, return NULL
>> + */
>> +void *threaded_workqueue_get_request(Threads *threads);
> 
> Using void * to represent the payload makes it easy to get
> the wrong pointer in there without the compiler noticing.
> Consider adding a type for the payload?
> 

Another option could be taken is exporting the ThreadRequest to the user
and it's put at the very beginning in the user-defined data struct.

However, it will export the internal designed things to the user, i am
not sure it is a good idea...

>> + *
>> + * Author:
>> + *   Xiao Guangrong <xiaoguangrong@tencent.com>
>> + *
>> + * Copyright(C) 2018 Tencent Corporation.
>> + *
>> + * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
>> + * See the COPYING.LIB file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/bitmap.h"
>> +#include "qemu/threaded-workqueue.h"
>> +
>> +#define SMP_CACHE_BYTES 64
> 
> +1 on comments already made by others

Will improve it.

> 
>> +
>> +/*
>> + * the request representation which contains the internally used mete data,
> 
> mete -> meta

Will fix.

> 
>> + * it is the header of user-defined data.
>> + *
>> + * It should be aligned to the nature size of CPU.
>> + */
>> +struct ThreadRequest {
>> +    /*
>> +     * the request has been handled by the thread and need the user
>> +     * to fetch result out.
>> +     */
>> +    uint8_t done;
>> +
>> +    /*
>> +     * the index to Thread::requests.
>> +     * Save it to the padding space although it can be calculated at runtime.
>> +     */
>> +    uint8_t request_index;
> 
> So no more than 256?
> 
> This is blocked by MAX_THREAD_REQUEST_NR test at the beginning
> of threaded_workqueue_create, but I would make it more explicit either
> with a compile-time assert that MAX_THREAD_REQUEST_NR is
> below UINT8_MAX, or by adding a second test for UINT8_MAX in
> threaded_workqueue_create.

It's good to me.

I prefer the former one that "compile-time assert that MAX_THREAD_REQUEST_NR
is below UINT8_MAX"

> 
> Also, an obvious extension would be to make bitmaps into arrays.
> 
> Do you think someone would want to use the package to assign
> requests per CPU or per VCPU? If so, that could quickly go above 64.
> 

Well... it specifies the depth of each single thread, it has negative
affection if larger depth is used, as it causes
threaded_workqueue_wait_for_requests() too slow, at that point, the
user needs to wait all the threads to exhaust all its requests.

Another impact is that u64 is more efficient than bitmaps, we can see
it from the performance data:
    https://ibb.co/hq7u5V

Based on those, i think 64 should be enough, at least for the present
user, migration thread.

> 
>> +
>> +    /* the index to Threads::per_thread_data */
>> +    unsigned int thread_index;
> 
> Don’t you want to use a size_t for that?

size_t is 8 bytes... i'd like to make the request header more tiny...

> 
>> +} QEMU_ALIGNED(sizeof(unsigned long));
> 
> Nit: the alignment type is inconsistent with that given
> to QEMU_BUILD_BUG_ON in threaded_workqueue_create.
> (long vs. unsigned long).
> 

Yup, will make them consistent.

> Also, why is the alignment required? Aren’t you more interested
> in cache-line alignment?
> 

ThreadRequest actually is the header put at the very beginning of
the request. If is not aligned to "long", the user-defined data
struct could be accessed without properly aligned.

> 
>> +typedef struct ThreadRequest ThreadRequest;
> 
> 
>> +
>> +struct ThreadLocal {
>> +    struct Threads *threads;
>> +
>> +    /* the index of the thread */
>> +    int self;
> 
> Why signed?

Mistake, will fix.

> 
>> +
>> +    /* thread is useless and needs to exit */
>> +    bool quit;
>> +
>> +    QemuThread thread;
>> +
>> +    void *requests;
>> +
>> +   /*
>> +     * the bit in these two bitmaps indicates the index of the ＠requests
>> +     * respectively. If it's the same, the corresponding request is free
>> +     * and owned by the user, i.e, where the user fills a request. Otherwise,
>> +     * it is valid and owned by the thread, i.e, where the thread fetches
>> +     * the request and write the result.
>> +     */
>> +
>> +    /* after the user fills the request, the bit is flipped. */
>> +    uint64_t request_fill_bitmap QEMU_ALIGNED(SMP_CACHE_BYTES);
> 
> I believe you are trying to ensure that data accessed from multiple CPUs
> is on different cache lines. As others have pointed out, the real value for
> SMP_CACHE_BYTES can only be known at run-time. So this is not really
> helping. Also, the ThreadLocal structure itself is not necessarily aligned
> within struct Threads. Therefore, it’s possible that “requests” for example
> could be on the same cache line as request_fill_bitmap if planets align
> the wrong way.
> 
> In order to mitigate these effects, I would group the data that the user
> writes and the data that the thread writes, i.e. reorder declarations,
> put request_fill_bitmap and request_valid_ev together, and try
> to put them in the same cache line so that only one cache line is invalidated
> from within mark_request_valid instead of two.
> 

However, QemuEvent is atomically updated at both sides, it is not good to mix
it with other fields, isn't?


> Then you end up with a single alignment directive instead of 4, to
> separate requests from completions.
> 
> That being said, I’m not sure why you use a bitmap here. What is the
> expected benefit relative to atomic lists (which would also make it really
> lock-free)?
> 

I agree Paolo's comments in another mail. :)

> 
>> +
>> +/*
>> + * the main data struct represents multithreads which is shared by
>> + * all threads
>> + */
>> +struct Threads {
>> +    /* the request header, ThreadRequest, is contained */
>> +    unsigned int request_size;
> 
> size_t?

Please see the comments above about "unsigned int thread_index;" in
ThreadRequest.

>> +/*
>> + * free request: the request is not used by any thread, however, it might
>> + *   contain the result need the user to call thread_request_done()
> 
> might contain the result -> might still contain the result
> result need the user to call -> result. The user needs to call
> 

Will fix.

>> +static void uninit_thread_requests(ThreadLocal *thread, int free_nr)
>> +{
>> +    Threads *threads = thread->threads;
>> +    ThreadRequest *request = thread->requests;
>> +    int i;
>> +
>> +    for (i = 0; i < free_nr; i++) {
>> +        threads->ops->thread_request_uninit(request + 1);
>> +        request = (void *)request + threads->request_size;
> 
> Despite GCC’s tolerance for it and rather lengthy debates,
> pointer arithmetic on void * is illegal in C [1].
> 
> Consider using char * arithmetic, and using macros such as:
> 
> #define request_to_payload(req) (((ThreadRequest *) req) + 1)
> #define payload_to_request(req) (((ThreadRequest *) req) - 1)
> #define request_to_next(req,threads) ((ThreadRequest *) ((char *) req) + threads->request_size))
> 

These definitions are really nice, will use them instead.

>> +static void uninit_thread_data(Threads *threads, int free_nr)
>> +{
>> +    ThreadLocal *thread_local = threads->per_thread_data;
> 
> thread_local is a keyword in C++11. I would avoid it as a name,
> consider replacing with “per_thread_data” as in struct Threads?
> 

Sure, it's good to me.

>> +void threaded_workqueue_submit_request(Threads *threads, void *request)
>> +{
>> +    ThreadRequest *req = request - sizeof(ThreadRequest);
> 
> Pointer arithmetic on void *…
> 
> Please consider rewriting as:
> 
> 	ThreadRequest *req = (ThreadRequest *) request - 1;
> 
> which achieves the same objective, is legal C, and is the symmetric
> counterpart of “return request + 1” above.
> 

It's nice, indeed.
