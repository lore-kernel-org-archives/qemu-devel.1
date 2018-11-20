Received: from eggs.gnu.org ([2001:4830:134:3::10]:35941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gP3Dr-0006Kt-B9
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1gP3Dn-0000Em-CP
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:25:35 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:36455)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1gP3Dn-0000CV-1K
	for qemu-devel@nongnu.org; Tue, 20 Nov 2018 05:25:31 -0500
Received: by mail-pl1-x641.google.com with SMTP id y6-v6so796658plt.3
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 02:25:30 -0800 (PST)
References: <20181106122025.3487-1-xiaoguangrong@tencent.com>
	<20181106122025.3487-3-xiaoguangrong@tencent.com>
	<20181113183821.GA11606@flamenco>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <35f0eb1a-3ec9-344b-7dda-d766c1b79626@gmail.com>
Date: Tue, 20 Nov 2018 18:25:25 +0800
MIME-Version: 1.0
In-Reply-To: <20181113183821.GA11606@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] util: introduce threaded workqueue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: pbonzini@redhat.com, mst@redhat.com, mtosatti@redhat.com, qemu-devel@nongnu.org, kvm@vger.kernel.org, dgilbert@redhat.com, peterx@redhat.com, wei.w.wang@intel.com, jiang.biao2@zte.com.cn, eblake@redhat.com, quintela@redhat.com, Xiao Guangrong <xiaoguangrong@tencent.com>



On 11/14/18 2:38 AM, Emilio G. Cota wrote:
> On Tue, Nov 06, 2018 at 20:20:22 +0800, guangrong.xiao@gmail.com wrote:
>> From: Xiao Guangrong <xiaoguangrong@tencent.com>
>>
>> This modules implements the lockless and efficient threaded workqueue.
> (snip)
>> +++ b/util/threaded-workqueue.c
>> +struct Threads {
>> +    /*
>> +     * in order to avoid contention, the @requests is partitioned to
>> +     * @threads_nr pieces, each thread exclusively handles
>> +     * @thread_request_nr requests in the array.
>> +     */
>> +    void *requests;
> (snip)
>> +    /*
>> +     * the bit in these two bitmaps indicates the index of the ＠requests
>> +     * respectively. If it's the same, the corresponding request is free
>> +     * and owned by the user, i.e, where the user fills a request. Otherwise,
>> +     * it is valid and owned by the thread, i.e, where the thread fetches
>> +     * the request and write the result.
>> +     */
>> +
>> +    /* after the user fills the request, the bit is flipped. */
>> +    unsigned long *request_fill_bitmap;
>> +    /* after handles the request, the thread flips the bit. */
>> +    unsigned long *request_done_bitmap;
> (snip)
>> +    /* the request is pushed to the thread with round-robin manner */
>> +    unsigned int current_thread_index;
> (snip)
>> +    QemuEvent ev;
> (snip)
>> +};
> 
> The fields I'm showing above are all shared by all worker threads.
> This can lead to unnecessary contention. For example:
> - Adjacent requests can share the same cache line, which might be
>    written to by different worker threads (when setting request->done)
> 
> - The request_done bitmap is written to by worker threads every time
>    a job completes. At high core counts with low numbers of job slots,
>    this can result in high contention. For example, imagine we have
>    16 threads with 4 jobs each. This only requires 64 bits == 8 bytes, i.e.
>    much less than a cache line. Whenever a job completes, the cache line
>    will be atomically updated by one of the 16 threads.
> 
> - The completion event (Threads.ev above) is written to by every thread.
>    Again, this can result in contention at large core counts.
> 
> An orthogonal issue is the round-robin policy. This can give us fairness,
> in that we guarantee that all workers get a similar number of jobs.
> But giving one job at a time to each worker is suboptimal when the job
> sizes are small-ish, because it misses out on the benefits of batching,
> which amortize the cost of communication.
> Given that the number of jobs that we have (at least in the benchmark)
> are small, filling up a worker's queue before moving on to the next
> can yield a significant speedup at high core counts.
> 
> I implemented the above on top of your series. The results are as follows:
> 
>                                           threaded-workqueue-bench -r 4 -m 2 -c 20 -t #N
>                                                Host: AMD Opteron(tm) Processor 6376
>                                            Thread pinning: #N+1 cores, same-socket first
> 
>           12 +-------------------------------------------------------------------------------------------------------+
>              |    +   +     +     +     +     +    A+     +     +     +     +     +     +     +     +     +     +    |
>              |                                     $                                                  before ***B*** |
>           10 |-+                                  $$                                               +batching ###D###-|
>              |                                    $$                                       +per-thread-state $$$A$$$ |
>              |                                    $$  A        A                                                     |
>              |                     $AD     D$A $A $ $ $A  A   $$               A        A  A$       A        A$ A    |
>            8 |-+               D$AA  A# D$AA# A  $#D$$  $ $$ A  $   $A $A      $$ A$ A$A $ $ AA   $A $  $A   $ A   +-|
>              |                AA  B* B$DA D  DD# A #$$   A  A   $$AA  A  A$A  $  A  A     A    $ A    AA  A$A        |
>              |               $DB*B  B $ $ BB    D   $$  #D #D   A           A$A                 A                    |
>            6 |-+          $AA*B       *A *  *       $# D  D  D#  #D #D   D#    D#DD#D   D# D#  # ##D      D#       +-|
>              |           A             BB   *       A D        DD  D  D#D  DD#D      D#D  D  DD  D  D# D#D  DD#DD    |
>              |           $                   B                                                        D              |
>              |         $A                     **BB     B                                                             |
>            4 |-+      A#                      B   *    **                                                          +-|
>              |        $                            B *B  BB* B*                    *BB*B   B*BB*BB*B  B *BB* B*BB    |
>              |      $A                              B       B  BB*BB*BB*BB*BB*BB*BB     **B         ** B    B        |
>            2 |-+   A                                                                    B           B              +-|
>              |     $                                                                                                 |
>              |    A                                                                                                  |
>              |    +   +     +     +     +     +     +     +     +     +     +     +     +     +     +     +     +    |
>            0 +-------------------------------------------------------------------------------------------------------+
>                   1   4     8     12    16    20    24    28    32    36    40    44    48    52    56    60    64
>                                                               Threads
>    png: https://imgur.com/Aj4yfGO
> 
> Note: "Threads" in the X axis means "worker threads".
> 
> Batching achieves higher performance at high core counts (>8),
> since worker threads go through fewer sleep+wake cycles while
> waiting for jobs. Performance however diminishes as more threads
> are used (>=24) due to cache line contention.
> 
> Contention can be avoided by partitioning the request array, bitmaps
> and completion event to be entirely local to worker threads
> ("+per-thread-state"). This avoids the performance decrease at >=24
> threads that we observe with batching alone. Note that the overall
> speedup does not go beyond ~8; this is explained by the fact that we
> use a single requester thread. Thus, as we add more worker threads,
> they become increasingly less busy, yet throughput remains roughly
> constant. I say roughly because there's quite a bit of noise--this
> is a 4-socket machine and I'm letting the scheduler move threads
> around, although I'm limiting the cores that can be used with
> taskset to maximize locality (this means that for 15 threads we're
> using 16 host cores that are all in the same socket; note that
> the additional thread is the requester one).

Hmm... I have carefully written the stuff step by step:
1. separate @requests from threads to each single thread
2. separate @completion from threads
3. use batch mode
4. separate bitmaps from threads
5. revert batch mode based on step 4
6. compare them with directly using Emilio's patches.

The big different between my modification and Emilio's patches is
that i still make per-thread-data be attached in the end of
@Threads.

I got these performance data:
	https://ibb.co/kcLnLL

Indeed, i can almost reproduce your conclusion. The confused part
is batch -  I used 16G memory to do the benchmark, the batch improved
nothing, I guess all the threads keep busy under this case anyway.


> 
> I have pushed the above changes, along with some minor fixes (e.g.
> removing the Threads.name field) here:
> 
>    https://github.com/cota/qemu/tree/xiao
> 
> Note that the 0-len variable goes away, and that Threads become
> read-only. I also use padding to make sure the events are in
> separate cache lines.
> 
> Feel free to incorporate whatever you see fit from that branch into
> a subsequent iteraiton.

Nice, I will add you to the author list if you do not object. :)

> 
> I have also some minor comments, but we can postpone those for later.
> There are some issues I'd like you to consider now, however:
> 
> - Make sure all bitmap ops are using atomic_set/read. Add additional
>    helpers if necessary.
> 

Good to me. And we have moved the requests to each thread, that is
requests-per-thread, i think 64 is big enough, so i am planning to
limit it to the max of 64 and use u64 as bitmap.

> - Constify everywhere the Ops struct.

Good suggestion.

> 
> - Consider just registering a size_t instead of a function to get the
>    job size from the Ops struct.
> 

Okay, that's good to me.

> And then a possible optimization for the actual use case you have:
> 
> - Consider using a system-specific number of threads (determined at
>    run-time) for compression/decompression. For example, if the host
>    system has a single core, there's no point in spawning more than a single
>    thread. If the host system has 32 cores, you're probably leaving performance
>    on the table if you just use the default.
>    Ideally determining this number would also take into account the
>    size of each job, which should also determine the number of
>    job slots per worker thread.
> 

It can not work well... It depends on the CPU usage rather than CPU number.
Furthermore, we developed adaptive migration that will dynimically adjust
thread number based on the resource usage. more detailed please see:
   https://kvmforum2018.sched.com/event/FzuU/adaptive-live-migration-xiao-guangrong-yulei-zhang-tencent-cloud

Thanks!
