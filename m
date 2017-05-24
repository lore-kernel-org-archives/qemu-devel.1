Received: from eggs.gnu.org ([2001:4830:134:3::10]:52003)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dDUby-0007wz-EK
	for qemu-devel@nongnu.org; Wed, 24 May 2017 07:37:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a.perevalov@samsung.com>) id 1dDUbt-0002S1-CV
	for qemu-devel@nongnu.org; Wed, 24 May 2017 07:37:54 -0400
Received: from mailout3.w1.samsung.com ([210.118.77.13]:20275)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a.perevalov@samsung.com>)
	id 1dDUbt-0002NQ-1n
	for qemu-devel@nongnu.org; Wed, 24 May 2017 07:37:49 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout3.w1.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0OQG00C4NGAUOK70@mailout3.w1.samsung.com> for
	qemu-devel@nongnu.org; Wed, 24 May 2017 12:37:43 +0100 (BST)
From: Alexey Perevalov <a.perevalov@samsung.com>
Message-id: <f8fb2757-5df1-7122-a60e-40dd1296223c@samsung.com>
Date: Wed, 24 May 2017 14:37:40 +0300
MIME-version: 1.0
In-reply-to: <20170524112220.GJ3873@pxdev.xzpeter.org>
Content-type: text/plain; charset=utf-8; format=flowed
Content-transfer-encoding: 7bit
Content-language: en-GB
References: <1495539071-12995-1-git-send-email-a.perevalov@samsung.com>
	<CGME20170523113131eucas1p24a041de6004237e437f97a24340507e2@eucas1p2.samsung.com>
	<1495539071-12995-9-git-send-email-a.perevalov@samsung.com>
	<20170524075305.GG3873@pxdev.xzpeter.org>
	<20170524093720.GC12925@aperevalov-ubuntu>
	<20170524112220.GJ3873@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH V6 08/10] migration: calculate vCPU
 blocktime on dst side
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: i.maximets@samsung.com, qemu-devel@nongnu.org, dgilbert@redhat.com

On 05/24/2017 02:22 PM, Peter Xu wrote:
> On Wed, May 24, 2017 at 12:37:20PM +0300, Alexey wrote:
>> On Wed, May 24, 2017 at 03:53:05PM +0800, Peter Xu wrote:
>>> On Tue, May 23, 2017 at 02:31:09PM +0300, Alexey Perevalov wrote:
>>>> This patch provides blocktime calculation per vCPU,
>>>> as a summary and as a overlapped value for all vCPUs.
>>>>
>>>> This approach was suggested by Peter Xu, as an improvements of
>>>> previous approch where QEMU kept tree with faulted page address and cpus bitmask
>>>> in it. Now QEMU is keeping array with faulted page address as value and vCPU
>>>> as index. It helps to find proper vCPU at UFFD_COPY time. Also it keeps
>>>> list for blocktime per vCPU (could be traced with page_fault_addr)
>>>>
>>>> Blocktime will not calculated if postcopy_blocktime field of
>>>> MigrationIncomingState wasn't initialized.
>>>>
>>>> Signed-off-by: Alexey Perevalov <a.perevalov@samsung.com>
>>>> ---
>>>>   migration/postcopy-ram.c | 102 ++++++++++++++++++++++++++++++++++++++++++++++-
>>>>   migration/trace-events   |   5 ++-
>>>>   2 files changed, 105 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
>>>> index d647769..e70c44b 100644
>>>> --- a/migration/postcopy-ram.c
>>>> +++ b/migration/postcopy-ram.c
>>>> @@ -23,6 +23,7 @@
>>>>   #include "postcopy-ram.h"
>>>>   #include "sysemu/sysemu.h"
>>>>   #include "sysemu/balloon.h"
>>>> +#include <sys/param.h>
>>>>   #include "qemu/error-report.h"
>>>>   #include "trace.h"
>>>>   
>>>> @@ -577,6 +578,101 @@ static int ram_block_enable_notify(const char *block_name, void *host_addr,
>>>>       return 0;
>>>>   }
>>>>   
>>>> +static int get_mem_fault_cpu_index(uint32_t pid)
>>>> +{
>>>> +    CPUState *cpu_iter;
>>>> +
>>>> +    CPU_FOREACH(cpu_iter) {
>>>> +        if (cpu_iter->thread_id == pid) {
>>>> +            return cpu_iter->cpu_index;
>>>> +        }
>>>> +    }
>>>> +    trace_get_mem_fault_cpu_index(pid);
>>>> +    return -1;
>>>> +}
>>>> +
>>>> +static void mark_postcopy_blocktime_begin(uint64_t addr, uint32_t ptid,
>>>> +        RAMBlock *rb)
>>>> +{
>>>> +    int cpu;
>>>> +    unsigned long int nr_bit;
>>>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>>>> +    PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
>>>> +    int64_t now_ms;
>>>> +
>>>> +    if (!dc || ptid == 0) {
>>>> +        return;
>>>> +    }
>>>> +    cpu = get_mem_fault_cpu_index(ptid);
>>>> +    if (cpu < 0) {
>>>> +        return;
>>>> +    }
>>>> +    nr_bit = get_copied_bit_offset(addr);
>>>> +    if (test_bit(nr_bit, mis->copied_pages)) {
>>>> +        return;
>>>> +    }
>>>> +    now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>>> +    if (dc->vcpu_addr[cpu] == 0) {
>>>> +        atomic_inc(&dc->smp_cpus_down);
>>>> +    }
>>>> +
>>>> +    atomic_xchg__nocheck(&dc->vcpu_addr[cpu], addr);
>>>> +    atomic_xchg__nocheck(&dc->last_begin, now_ms);
>>>> +    atomic_xchg__nocheck(&dc->page_fault_vcpu_time[cpu], now_ms);
>>> Looks like this is not what you and Dave have discussed?
>>>
>>> (Btw, sorry to have not followed the thread recently, so I just went
>>>   over the discussion again...)
>>>
>>> What I see that Dave suggested is (I copied from Dave's email):
>>>
>>> blocktime_start:
>>>     set CPU stall address
>>>     check bitmap entry
>>>       if set then zero stall-address
>>>
>>> While here it is:
>>>
>>> blocktime_start:
>>>     check bitmap entry
>>>       if set then return
>>>     set CPU stall address
>>>
>>> I don't think current version can really solve the risk condition. See
>>> this possible sequence:
>>>
>>>         receive-thread             fault-thread
>>>         --------------             ------------
>>>                                    blocktime_start
>>>                                      check bitmap entry,
>>>                                        if set then return
>>>         blocktime_end
>>>           set bitmap entry
>>>           read CPU stall address,
>>>             if none-0 then zero it
>>>                                      set CPU stall address [1]
>>>          
>>> Then imho the address set at [1] will be stall again until forever.
>>>
>> agree, I check is in incorrect order
>>
>>> I think we should follow exactly what Dave has suggested.
>>>
>>> And.. after a second thought, I am afraid even this would not satisfy
>>> all risk conditions. What if we consider the UFFDIO_COPY ioctl in?
>>> AFAIU after UFFDIO_COPY the faulted vcpu can be running again, then
>>> the question is, can it quickly trigger another page fault?
>>>
>> yes, it can
>>
>>> Firstly, a workable sequence is (adding UFFDIO_COPY ioctl in, and
>>> showing vcpu-thread X as well):
>>>
>>>    receive-thread       fault-thread        vcpu-thread X
>>>    --------------       ------------        -------------
>>>                                             fault at addr A1
>>>                         fault_addr[X]=A1
>>>    UFFDIO_COPY page A1
>>>    check fault_addr[X] with A1
>>>      if match, clear fault_addr[X]
>>>                                             vcpu X starts
>>>
>>> This is fine.
>>>
>>> While since "vcpu X starts" can be right after UFFDIO_COPY, can this
>>> be possible?
>> Previous picture isn't possible, due to mark_postcopy_blocktime_end
>> is being called right after ioctl, and vCPU is waking up
>> inside ioctl, so check fault_addr will be after vcpu X starts.
>>
>>>    receive-thread       fault-thread        vcpu-thread X
>>>    --------------       ------------        -------------
>>>                                             fault at addr A1
>>>                         fault_addr[X]=A1
>>>    UFFDIO_COPY page A1
>>>                                             vcpu X starts
>>>                                             fault at addr A2
>>>                         fault_addr[X]=A2
>>>    check fault_addr[X] with A1
>>>      if match, clear fault_addr[X]
>>>          ^
>>>          |
>>>          +---------- here it will not match since now fault_addr[X]==A2
>>>
>>> Then looks like fault_addr[X], which is currently A1, will stall
>>> again?
>> It will be another address(A2), but probably the same vCPU and if in
>> this case blocktime_start will be called before blocktime_end we lost
>> block time for page A1. Address of the page is unique key in this
>> process, not vCPU ;)
> I failed to understand the last sentence, anyway...
I mean calculation process, page address, in it is unique.
So when I kept start/end time in tree where page address was a key,
I could avoid such kind of problems, but memory cost and runtime complexity,
wasn't perfect, also operations on tree had to be guarded both in 
blocktime_end and
blocktime_begin.
>
>> Here maybe reasonable to wake up vCPU after blocktime_end.
> ... I guess this can solve the problem. :)
>
>>
>>
>>> (I feel like finally we may need something like a per-cpu lock... or I
>>>   must have missed something)
>> I think no, because locking time of the vCPU is critical in this process.
> Yes.
>
>>>> +
>>>> +    trace_mark_postcopy_blocktime_begin(addr, dc, dc->page_fault_vcpu_time[cpu],
>>>> +            cpu);
>>>> +}
>>>> +
>>>> +static void mark_postcopy_blocktime_end(uint64_t addr)
>>>> +{
>>>> +    MigrationIncomingState *mis = migration_incoming_get_current();
>>>> +    PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
>>>> +    int i, affected_cpu = 0;
>>>> +    int64_t now_ms;
>>>> +    bool vcpu_total_blocktime = false;
>>>> +    unsigned long int nr_bit;
>>>> +
>>>> +    if (!dc) {
>>>> +        return;
>>>> +    }
>>>> +    /* mark that page as copied */
>>>> +    nr_bit = get_copied_bit_offset(addr);
>>>> +    set_bit_atomic(nr_bit, mis->copied_pages);
>>>> +
>>>> +    now_ms = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>>>> +
>>>> +    /* lookup cpu, to clear it,
>>>> +     * that algorithm looks straighforward, but it's not
>>>> +     * optimal, more optimal algorithm is keeping tree or hash
>>>> +     * where key is address value is a list of  */
>>>> +    for (i = 0; i < smp_cpus; i++) {
>>>> +        uint64_t vcpu_blocktime = 0;
>>>> +        if (atomic_fetch_add(&dc->vcpu_addr[i], 0) != addr) {
>>>> +            continue;
>>>> +        }
>>>> +        atomic_xchg__nocheck(&dc->vcpu_addr[i], 0);
>>> Why use *__nocheck() rather than atomic_xchg() or even atomic_read()?
>>> Same thing happened a lot in current patch.
>> atomic_read/atomic_xchg for mingw/(gcc on arm32) has build time check,
>>
>> QEMU_BUILD_BUG_ON(sizeof(*ptr) > sizeof(void *));
>>
>> it prevents using 64 atomic operation on 32 architecture, just mingw I
>> think, but postcopy-ram.c isn't compiling for mingw.
>> On other 32 platforms as I know clang/gcc allow to use 8 bytes
>> long variables in built atomic operations. In arm32 it allows in
>> builtin. But QEMU on arm32 still
>> has that sanity check, and I think it's bug, so I just worked it around.
>> Maybe better was to fix it.
>>
>> I tested in docker, using follow command:
>> make docker-test-build@debian-armhf-cross
>>
>> And got following error
>>
>> /tmp/qemu-test/src/migration/postcopy-ram.c: In function
>> 'mark_postcopy_blocktime_begin':
>> /tmp/qemu-test/src/include/qemu/compiler.h:86:30: error: static
>> assertion failed: "not expecting: sizeof(*&dc->vcpu_addr[cpu]) >
>> sizeof(void *)"
>>   #define QEMU_BUILD_BUG_ON(x) _Static_assert(!(x), "not expecting: " #x)
>>
>> when I used atomic_xchg,
>> I agree with you, but I think need to fix atomic.h firstly and add additional
>> #ifdef there.
>>
>> And I didn't want to split 64 bit values onto 32 bit values, but I saw
>> in mailing list people are doing it.
> If this is a bug, then I guess the best way is to fix it. But before
> that - can a 32bit system really do 64bit atomic ops? Is it really a
> bug at all?
>
> Thanks,
>

-- 
Best regards,
Alexey Perevalov
