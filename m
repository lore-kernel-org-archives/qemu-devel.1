Received: from eggs.gnu.org ([2001:4830:134:3::10]:57675)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eJwxb-0004H6-Me
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 02:39:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eJwxY-0002b5-IP
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 02:39:11 -0500
Received: from [45.249.212.32] (port=54194 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1eJwxY-0002Yp-7N
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 02:39:08 -0500
Message-ID: <5A1E63F2.5060309@huawei.com>
Date: Wed, 29 Nov 2017 15:38:26 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
	<20171128211326.GV3037@localhost.localdomain>
	<5A1E43A6.1010607@huawei.com> <20171129060149.GD2374@rkaganip.lan>
In-Reply-To: <20171129060149.GD2374@rkaganip.lan>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>



On 2017/11/29 14:01, Roman Kagan wrote:

> On Wed, Nov 29, 2017 at 01:20:38PM +0800, Longpeng (Mike) wrote:
>> On 2017/11/29 5:13, Eduardo Habkost wrote:
>>
>>> [CCing the people who were copied in the original patch that
>>> enabled l3cache]
>>>
>>> On Tue, Nov 28, 2017 at 11:20:27PM +0300, Denis V. Lunev wrote:
>>>> On 11/28/2017 10:58 PM, Eduardo Habkost wrote:
>>>>> Hi,
>>>>>
>>>>> On Fri, Nov 24, 2017 at 04:26:50PM +0300, Denis Plotnikov wrote:
>>>>>> Commit 14c985cffa "target-i386: present virtual L3 cache info for vcpus"
>>>>>> introduced and set by default exposing l3 to the guest.
>>>>>>
>>>>>> The motivation behind it was that in the Linux scheduler, when waking up
>>>>>> a task on a sibling CPU, the task was put onto the target CPU's runqueue
>>>>>> directly, without sending a reschedule IPI.  Reduction in the IPI count
>>>>>> led to performance gain.
>>>>>>
>>>>>> However, this isn't the whole story.  Once the task is on the target
>>>>>> CPU's runqueue, it may have to preempt the current task on that CPU, be
>>>>>> it the idle task putting the CPU to sleep or just another running task.
>>>>>> For that a reschedule IPI will have to be issued, too.  Only when that
>>>>>> other CPU is running a normal task for too little time, the fairness
>>>>>> constraints will prevent the preemption and thus the IPI.
>>>>>>
>>
>> Agree. :)
>>
>> Our testing VM is Suse11 guest with idle=poll at that time and now I realize
>                                       ^^^^^^^^^
> Oh, that's a whole lot of a difference!  I wish you mentioned that in
> that patch.
> 

:( Sorry for missing that...

>> that Suse11 has a BUG in its scheduler.
>>
>> For REHL 7.3 or upstream kernel, in ttwu_queue_remote(), a RES IPI is issued if
>> rq->idle is not polling:
>> '''
>> static void ttwu_queue_remote(struct task_struct *p, int cpu)
>> {
>> 	struct rq *rq = cpu_rq(cpu);
>>
>> 	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
>> 		if (!set_nr_if_polling(rq->idle))
>> 			smp_send_reschedule(cpu);
>> 		else
>> 			trace_sched_wake_idle_without_ipi(cpu);
>> 	}
>> }
>> '''
>>
>> But for Suse11, it does not check, it send a RES IPI unconditionally.
>>
>>>>>> This boils down to the improvement being only achievable in workloads
>>>>>> with many actively switching tasks.  We had no access to the
>>>>>> (proprietary?) SAP HANA benchmark the commit referred to, but the
>>>>>> pattern is also reproduced with "perf bench sched messaging -g 1"
>>>>>> on 1 socket, 8 cores vCPU topology, we see indeed:
>>>>>>
>>>>>> l3-cache	#res IPI /s	#time / 10000 loops
>>>>>> off		560K		1.8 sec
>>>>>> on		40K		0.9 sec
>>>>>>
>>>>>> Now there's a downside: with L3 cache the Linux scheduler is more eager
>>>>>> to wake up tasks on sibling CPUs, resulting in unnecessary cross-vCPU
>>>>>> interactions and therefore exessive halts and IPIs.  E.g. "perf bench
>>>>>> sched pipe -i 100000" gives
>>>>>>
>>>>>> l3-cache	#res IPI /s	#HLT /s		#time /100000 loops
>>>>>> off		200 (no K)	230		0.2 sec
>>>>>> on		400K		330K		0.5 sec
>>>>>>
>>
>> I guess this issue could be resolved by disable the SD_WAKE_AFFINE.
> 
> But that requires extra tuning in the guest which is even less likely to
> happen in the cloud case when VM admin != host admin.
> 

Ah, yep, that's a problem.

>> As Gonglei said:
>> 1. the L3 cache relates to the user experience.
>> 2. the glibc would get the cache info by CPUID directly, and relates to the
>> memory performance.
>>
>> What's more, the L3 cache relates to the sched_domain which is important to the
>> (load) balancer when system is busy.
>>
>> All this doesn't mean the patch is insignificant, I just think we should do more
>> research before decide. I'll do some tests, thanks. :)
> 
> Looking forward to it, thanks!

> Roman.
> 
> 


-- 
Regards,
Longpeng(Mike)
