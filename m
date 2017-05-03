Received: from eggs.gnu.org ([2001:4830:134:3::10]:52872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d5uNc-0002Jg-RZ
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jemmy858585@gmail.com>) id 1d5uNb-0004HL-9Q
	for qemu-devel@nongnu.org; Wed, 03 May 2017 09:31:44 -0400
MIME-Version: 1.0
In-Reply-To: <CAOGPPbedJ-wbzgPbMN+7azSAPExR7ONb6CqSGiBYU4ZLMWon1g@mail.gmail.com>
References: <1491384478-12325-1-git-send-email-lidongchen@tencent.com>
	<20170406140255.GA31259@stefanha-x1.localdomain>
	<CAOGPPbfpN5QVxzvAkRv4MY7nE0YBxU0-UeMuJpVCe-wBB_9p8A@mail.gmail.com>
	<20170407113450.GO13602@stefanha-x1.localdomain>
	<CAOGPPbcf6bPXmVGFcw3niNznPx1BHsA=uR2G0sN=AV6xhWXMrA@mail.gmail.com>
	<20170410135203.GA20631@stefanha-x1.localdomain>
	<CAOGPPbedJ-wbzgPbMN+7azSAPExR7ONb6CqSGiBYU4ZLMWon1g@mail.gmail.com>
From: 858585 jemmy <jemmy858585@gmail.com>
Date: Wed, 3 May 2017 21:31:32 +0800
Message-ID: <CAOGPPbd4Eyiemsh5Kfkxa5hM_DQcjLvfK57B_oSSnCR_ZwsyLg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3] migration/block:limit the
 time used for block migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>, qemu block <qemu-block@nongnu.org>, Juan Quintela <quintela@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Dave Gilbert <dgilbert@redhat.com>, Lidong Chen <lidongchen@tencent.com>

On Wed, May 3, 2017 at 11:44 AM, 858585 jemmy <jemmy858585@gmail.com> wrote:
> On Mon, Apr 10, 2017 at 9:52 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Sat, Apr 08, 2017 at 09:17:58PM +0800, 858585 jemmy wrote:
>>> On Fri, Apr 7, 2017 at 7:34 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>> > On Fri, Apr 07, 2017 at 09:30:33AM +0800, 858585 jemmy wrote:
>>> >> On Thu, Apr 6, 2017 at 10:02 PM, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>>> >> > On Wed, Apr 05, 2017 at 05:27:58PM +0800, jemmy858585@gmail.com wrote:
>>> >> >
>>> >> > A proper solution is to refactor the synchronous code to make it
>>> >> > asynchronous.  This might require invoking the system call from a
>>> >> > thread pool worker.
>>> >> >
>>> >>
>>> >> yes, i agree with you, but this is a big change.
>>> >> I will try to find how to optimize this code, maybe need a long time.
>>> >>
>>> >> this patch is not a perfect solution, but can alleviate the problem.
>>> >
>>> > Let's try to understand the problem fully first.
>>> >
>>>
>>> when migrate the vm with high speed, i find vnc response slowly sometime.
>>> not only vnc response slowly, virsh console aslo response slowly sometime.
>>> and the guest os block io performance is also reduce.
>>>
>>> the bug can be reproduce by this command:
>>> virsh migrate-setspeed 165cf436-312f-47e7-90f2-f8aa63f34893 900
>>> virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893
>>> --copy-storage-inc qemu+ssh://10.59.163.38/system
>>>
>>> and --copy-storage-all have no problem.
>>> virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893
>>> --copy-storage-all qemu+ssh://10.59.163.38/system
>>>
>>> compare the difference between --copy-storage-inc and
>>> --copy-storage-all. i find out the reason is
>>> mig_save_device_bulk invoke bdrv_is_allocated, but bdrv_is_allocated
>>> is synchronous and maybe wait
>>> for a long time.
>>>
>>> i write this code to measure the time used by  brdrv_is_allocated()
>>>
>>>  279     static int max_time = 0;
>>>  280     int tmp;
>>>
>>>  288             clock_gettime(CLOCK_MONOTONIC_RAW, &ts1);
>>>  289             ret = bdrv_is_allocated(blk_bs(bb), cur_sector,
>>>  290                                     MAX_IS_ALLOCATED_SEARCH, &nr_sectors);
>>>  291             clock_gettime(CLOCK_MONOTONIC_RAW, &ts2);
>>>  292
>>>  293
>>>  294             tmp =  (ts2.tv_sec - ts1.tv_sec)*1000000000L
>>>  295                            + (ts2.tv_nsec - ts1.tv_nsec);
>>>  296             if (tmp > max_time) {
>>>  297                max_time=tmp;
>>>  298                fprintf(stderr, "max_time is %d\n", max_time);
>>>  299             }
>>>
>>> the test result is below:
>>>
>>>  max_time is 37014
>>>  max_time is 1075534
>>>  max_time is 17180913
>>>  max_time is 28586762
>>>  max_time is 49563584
>>>  max_time is 103085447
>>>  max_time is 110836833
>>>  max_time is 120331438
>>>
>>> bdrv_is_allocated is called after qemu_mutex_lock_iothread.
>>> and the main thread is also call qemu_mutex_lock_iothread.
>>> so cause the main thread maybe wait for a long time.
>>>
>>>    if (bmds->shared_base) {
>>>         qemu_mutex_lock_iothread();
>>>         aio_context_acquire(blk_get_aio_context(bb));
>>>         /* Skip unallocated sectors; intentionally treats failure as
>>>          * an allocated sector */
>>>         while (cur_sector < total_sectors &&
>>>                !bdrv_is_allocated(blk_bs(bb), cur_sector,
>>>                                   MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
>>>             cur_sector += nr_sectors;
>>>         }
>>>         aio_context_release(blk_get_aio_context(bb));
>>>         qemu_mutex_unlock_iothread();
>>>     }
>>>
>>> #0  0x00007f107322f264 in __lll_lock_wait () from /lib64/libpthread.so.0
>>> #1  0x00007f107322a508 in _L_lock_854 () from /lib64/libpthread.so.0
>>> #2  0x00007f107322a3d7 in pthread_mutex_lock () from /lib64/libpthread.so.0
>>> #3  0x0000000000949ecb in qemu_mutex_lock (mutex=0xfc51a0) at
>>> util/qemu-thread-posix.c:60
>>> #4  0x0000000000459e58 in qemu_mutex_lock_iothread () at /root/qemu/cpus.c:1516
>>> #5  0x0000000000945322 in os_host_main_loop_wait (timeout=28911939) at
>>> util/main-loop.c:258
>>> #6  0x00000000009453f2 in main_loop_wait (nonblocking=0) at util/main-loop.c:517
>>> #7  0x00000000005c76b4 in main_loop () at vl.c:1898
>>> #8  0x00000000005ceb77 in main (argc=49, argv=0x7fff921182b8,
>>> envp=0x7fff92118448) at vl.c:4709
>>
>> The following patch moves bdrv_is_allocated() into bb's AioContext.  It
>> will execute without blocking other I/O activity.
>>
>> Compile-tested only.
>>
>> diff --git a/migration/block.c b/migration/block.c
>> index 7734ff7..a5572a4 100644
>> --- a/migration/block.c
>> +++ b/migration/block.c
>> @@ -263,6 +263,29 @@ static void blk_mig_read_cb(void *opaque, int ret)
>>      blk_mig_unlock();
>>  }
>>
>> +typedef struct {
>> +    int64_t *total_sectors;
>> +    int64_t *cur_sector;
>> +    BlockBackend *bb;
>> +    QemuEvent event;
>> +} MigNextAllocatedClusterData;
>> +
>> +static void coroutine_fn mig_next_allocated_cluster(void *opaque)
>> +{
>> +    MigNextAllocatedClusterData *data = opaque;
>> +    int nr_sectors;
>> +
>> +    /* Skip unallocated sectors; intentionally treats failure as
>> +     * an allocated sector */
>> +    while (*data->cur_sector < *data->total_sectors &&
>> +           !bdrv_is_allocated(blk_bs(data->bb), *data->cur_sector,
>> +                              MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
>> +        *data->cur_sector += nr_sectors;
>> +    }
>> +
>> +    qemu_event_set(&data->event);
>> +}
>> +
>>  /* Called with no lock taken.  */
>>
>>  static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>> @@ -274,17 +297,27 @@ static int mig_save_device_bulk(QEMUFile *f, BlkMigDevState *bmds)
>>      int nr_sectors;
>>
>>      if (bmds->shared_base) {
>> +        /* Searching for the next allocated cluster can block.  Do it in a
>> +         * coroutine inside bb's AioContext.  That way we don't need to hold
>> +         * the global mutex while blocked.
>> +         */
>> +        AioContext *bb_ctx;
>> +        Coroutine *co;
>> +        MigNextAllocatedClusterData data = {
>> +            .cur_sector = &cur_sector,
>> +            .total_sectors = &total_sectors,
>> +            .bb = bb,
>> +        };
>> +
>> +        qemu_event_init(&data.event, false);
>> +
>>          qemu_mutex_lock_iothread();
>> -        aio_context_acquire(blk_get_aio_context(bb));
>> -        /* Skip unallocated sectors; intentionally treats failure as
>> -         * an allocated sector */
>> -        while (cur_sector < total_sectors &&
>> -               !bdrv_is_allocated(blk_bs(bb), cur_sector,
>> -                                  MAX_IS_ALLOCATED_SEARCH, &nr_sectors)) {
>> -            cur_sector += nr_sectors;
>> -        }
>> -        aio_context_release(blk_get_aio_context(bb));
>> +        bb_ctx = blk_get_aio_context(bb);
>>          qemu_mutex_unlock_iothread();
>> +
>
> Hi Stefan:
>     bb_ctx maybe change after qemu_mutex_unlock_iothread().
>     blk_set_aio_context maybe invoked by vcpu thread. like this:
>               blk_set_aio_context
>                    virtio_blk_data_plane_stop
>                             virtio_pci_stop_ioeventfd
>                                   virtio_pci_common_write
>
>     run this command in guest os:
>           while [ 1 ]; do rmmod virtio_blk; modprobe virtio_blk; done
>
>     write this code to test whether bb_ctx is changed.
>
>     qemu_mutex_lock_iothread();
>     bb_ctx = blk_get_aio_context(bb);
>     qemu_mutex_unlock_iothread();
>
>     sleep(0.1);
>
>     qemu_mutex_lock_iothread();
>     bb_ctx1 = blk_get_aio_context(bb);
>     qemu_mutex_unlock_iothread();
>
>     if (bb_ctx != bb_ctx1) {
>          fprintf(stderr, "bb_ctx is not bb_ctx1\n");
>     }
>
>     and i find bb_ctx is not bb_ctx1. so i change the code.
>     move aio_co_schedule into qemu_mutex_lock_iothread block.
>
>     if (bmds->shared_base) {
>         AioContext *bb_ctx;
>         Coroutine *co;
>         MigNextAllocatedClusterData data = {
>             .cur_sector = &cur_sector,
>             .total_sectors = &total_sectors,
>             .bb = bb,
>         };
>         qemu_event_init(&data.event, false);
>
>         qemu_mutex_lock_iothread();
>         bb_ctx = blk_get_aio_context(bb);
>         co = qemu_coroutine_create(mig_next_allocated_cluster, &data);
>         aio_co_schedule(bb_ctx, co);
>         qemu_mutex_unlock_iothread();

I find bs->ctx still maybe change after aio_co_schedule. but before
mig_next_allocated_cluster.

i use bdrv_inc_in_flight(blk_bs(bb)) and bdrv_dec_in_flight(blk_bs(bb))
to avoid it.


>
>         qemu_event_wait(&data.event);
>     }
>
>     I test four case for this patch:
>
>     1.qemu virtio_blk with iothreads,run dd 8 times inside guest then migrate.
>     2.qemu virtio_blk without iothreads,run dd 8 times inside guest
> then migrate.
>     3.qemu ide,run dd 8 times inside guest then migrate.
>     4.qemu virtio_blk with iothreads, run rmmod virtio_blk; modprobe virtio_blk;
>     inside guest then migrate.
>
>     All the test case passed. I will send the patch later.
>     Thanks.
>
>> +        co = qemu_coroutine_create(mig_next_allocated_cluster, &data);
>> +        aio_co_schedule(bb_ctx, co);
>> +        qemu_event_wait(&data.event);
>>      }
>>
>>      if (cur_sector >= total_sectors) {
