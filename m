Received: from eggs.gnu.org ([2001:4830:134:3::10]:35061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eKL7Z-000576-Fx
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:27:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <longpeng2@huawei.com>) id 1eKL7W-0000LY-6E
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:27:05 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2051 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <longpeng2@huawei.com>)
	id 1eKL7V-0000Iq-JF
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 04:27:02 -0500
Message-ID: <5A1FCED4.8030600@huawei.com>
Date: Thu, 30 Nov 2017 17:26:44 +0800
From: "Longpeng (Mike)" <longpeng2@huawei.com>
MIME-Version: 1.0
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
	<20171128211326.GV3037@localhost.localdomain>
	<5A1E43A6.1010607@huawei.com>
	<20171129104122.GY3037@localhost.localdomain>
	<5A1EA0DB.60303@huawei.com> <20171129133524.GA2279@rkaganb.sw.ru>
In-Reply-To: <20171129133524.GA2279@rkaganb.sw.ru>
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
To: Roman Kagan <rkagan@virtuozzo.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, zhaoshenglong <zhaoshenglong@huawei.com>



On 2017/11/29 21:35, Roman Kagan wrote:

> On Wed, Nov 29, 2017 at 07:58:19PM +0800, Longpeng (Mike) wrote:
>> On 2017/11/29 18:41, Eduardo Habkost wrote:
>>> On Wed, Nov 29, 2017 at 01:20:38PM +0800, Longpeng (Mike) wrote:
>>>> On 2017/11/29 5:13, Eduardo Habkost wrote:
>>>>> On Tue, Nov 28, 2017 at 11:20:27PM +0300, Denis V. Lunev wrote:
>>>>>> On 11/28/2017 10:58 PM, Eduardo Habkost wrote:
>>>>>>> On Fri, Nov 24, 2017 at 04:26:50PM +0300, Denis Plotnikov wrote:
>>>>>>>> Commit 14c985cffa "target-i386: present virtual L3 cache info for vcpus"
>>>>>>>> introduced and set by default exposing l3 to the guest.
>>>>>>>>
>>>>>>>> The motivation behind it was that in the Linux scheduler, when waking up
>>>>>>>> a task on a sibling CPU, the task was put onto the target CPU's runqueue
>>>>>>>> directly, without sending a reschedule IPI.  Reduction in the IPI count
>>>>>>>> led to performance gain.
>>>>>>>>
>>>>>>>> However, this isn't the whole story.  Once the task is on the target
>>>>>>>> CPU's runqueue, it may have to preempt the current task on that CPU, be
>>>>>>>> it the idle task putting the CPU to sleep or just another running task.
>>>>>>>> For that a reschedule IPI will have to be issued, too.  Only when that
>>>>>>>> other CPU is running a normal task for too little time, the fairness
>>>>>>>> constraints will prevent the preemption and thus the IPI.
>>>>>>>>
>>>>
>>>> Agree. :)
>>>>
>>>> Our testing VM is Suse11 guest with idle=poll at that time and now I realize
>>>> that Suse11 has a BUG in its scheduler.
>>>>
>>>> For REHL 7.3 or upstream kernel, in ttwu_queue_remote(), a RES IPI is issued if
>>>> rq->idle is not polling:
>>>> '''
>>>> static void ttwu_queue_remote(struct task_struct *p, int cpu)
>>>> {
>>>> 	struct rq *rq = cpu_rq(cpu);
>>>>
>>>> 	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
>>>> 		if (!set_nr_if_polling(rq->idle))
>>>> 			smp_send_reschedule(cpu);
>>>> 		else
>>>> 			trace_sched_wake_idle_without_ipi(cpu);
>>>> 	}
>>>> }
>>>> '''
>>>>
>>>> But for Suse11, it does not check, it send a RES IPI unconditionally.
>>>
>>> So, does that mean no Linux guest benefits from the l3-cache=on
>>> default except SuSE 11 guests?
>>>
>>
>> Not only that, there is another scenario:
>>
>> static void ttwu_queue(...)
>> {
>> 	if (...two cpus NOT sharing L3-cache) {
>> 		...
>> 		ttwu_queue_remote(p, cpu, wake_flags);
>> 		return;
>> 	}
>> 	...
>> 	ttwu_do_activate(rq, p, wake_flags, &rf); <--*Here*
>> 	...
>> }
>>
>> In ttwu_do_activate(), there are also some opportunities with low probability to
>> do not send RES IPI even if the target cpu isn't in IDLE polling state.
> 
> Well it isn't so low actually, what you need is to keep the cpus busy
> switching tasks.  In that case it's not uncommon that the task being
> woken up on a remote cpu has accumulated more vruntime than the task
> already running on that cpu; in that case the new task won't preempt the
> current task and the IPI won't be issued.  E.g. on a RHEL 7.4 guest we
> saw:
> 

I get it, thanks.

>>>>>>>> This boils down to the improvement being only achievable in workloads
>>>>>>>> with many actively switching tasks.  We had no access to the
>>>>>>>> (proprietary?) SAP HANA benchmark the commit referred to, but the
>>>>>>>> pattern is also reproduced with "perf bench sched messaging -g 1"
>>>>>>>> on 1 socket, 8 cores vCPU topology, we see indeed:
>>>>>>>>
>>>>>>>> l3-cache	#res IPI /s	#time / 10000 loops
>>>>>>>> off		560K		1.8 sec
>>>>>>>> on		40K		0.9 sec
> 
> The workload where it bites is mostly idle guest, with chains of
> dependent wakeups, i.e. with little parallelism:
> 
>>>>>>>> Now there's a downside: with L3 cache the Linux scheduler is more eager
>>>>>>>> to wake up tasks on sibling CPUs, resulting in unnecessary cross-vCPU
>>>>>>>> interactions and therefore exessive halts and IPIs.  E.g. "perf bench
>>>>>>>> sched pipe -i 100000" gives
>>>>>>>>
>>>>>>>> l3-cache	#res IPI /s	#HLT /s		#time /100000 loops
>>>>>>>> off		200 (no K)	230		0.2 sec
>>>>>>>> on		400K		330K		0.5 sec
>>>>>>>>
>>>>
>>>> I guess this issue could be resolved by disable the SD_WAKE_AFFINE.
> 
> Actually, it's SD_WAKE_AFFINE that's being effectively defeated by this
> l3-cache, because the scheduler thinks that the cpus that share the
> last-level cache are close enough that a dependent task can be woken up
> on a sibling cpu.
> 

In this case (sched pipe), without L3-cache, a dependent task is woken up on the
original cpu mostly, if these two tasks ran on the same cpu then the dependent
task is woken up without a RES IPI. The related codes are:
'''
void resched_curr(struct rq *rq)
{
	if (cpu == smp_processor_id()) {
		set_tsk_need_resched(curr);
		set_preempt_need_resched();
		return;
	}
}
	
'''

Do I understand correctly ? If not, hope you could point out what's wrong :)

>>>> As Gonglei said:
>>>> 1. the L3 cache relates to the user experience.
>>>
>>> This is true, in a way: I have seen a fair share of user reports
>>> where they incorrectly blame the L3 cache absence or the L3 cache
>>> size for performance problems.
>>>
>>>> 2. the glibc would get the cache info by CPUID directly, and relates to the
>>>> memory performance.
>>>
>>> I'm interested in numbers that demonstrate that.
> 
> Me too.  I vaguely remember debugging a memcpy degradation in the guest
> (on the Parallels proprietary hypervisor), that turned out being due a
> combination of l3 cache size and the cpu topology exposed to the guest,
> which caused glibc to choose an inadequate buffuer size.
> 

We faced the same problem several months ago.


I did some simple tests at noon, it seems that numbers are better without
L3-cache except 'perf bench sched messaging'.

VM: 1 sockets, 8 cores, 3.10.0 guest
Hardware: Intel(R) Xeon(R) CPU E7-8890 v2 @ 2.80GHz

Stream:(100 turns)
l3    Copy    Scale    Add    Triad
------------------------------------
off  8025.8  8019.5  8363.1  8589.9
on   8016.7  7999.9  8344.2  8568.9

perf sched bench message:(100 turns)
l3    Total-time
-----------------
off   0.0238
on    0.0178

perf sched bench pipe:(100 turns)
l3    Total-time
-----------------
off   0.3190
on    1.2688

We are so busy at end of each month, maybe my tests is insufficient, I'm sorry
for that.
According the numbers above, I think it's worth to turn off L3-cache by default.


>> Sorry I have no numbers in hand currently :(
>>
>> I'll do some tests these days, please give me some time.
> 
> We'll try to get some data on this, too.
> 
>>>> What's more, the L3 cache relates to the sched_domain which is important to the
>>>> (load) balancer when system is busy.
>>>>
>>>> All this doesn't mean the patch is insignificant, I just think we should do more
>>>> research before decide. I'll do some tests, thanks. :)
>>>
>>> Yes, we need more data.  But if we find out that there are no
>>> cases where the l3-cache=on default actually improves
>>> performance, I will be willing to apply this patch.
>>>
>>
>> That's a good thing if we find the truth, it's free. :)
>>
>> OTOH, I think we should notice that: Linux is designed on real hardware, maybe
>> there're some other problems if QEMU lacks some related features. If we search
>> 'cpus_share_cache' in the Linux kernel, we can see that it's also used by Block
>> Layer.
>>
>>> IMO, the long term solution is to make Linux guests not misbehave
>>> when we stop lying about the L3 cache.  Maybe we could provide a
>>> "IPIs are expensive, please avoid them" hint in the KVM CPUID
>>> leaf?
> 
> We already have it, it's the hypervisor bit ;)  Seriously, I'm unaware
> of hypervisors where IPIs aren't expensive.
> 
>> Maybe more PV features could be digged.
> 
> One problem with this is that PV features are hard to get into other
> guest OSes or existing Linux guests.
> 

Some cloud providers (e.g. Amazon,AliBaBa...) provide a customized guest which
could includes more PV features to reach the limiting performance.

> Roman.
> 
> 


-- 
Regards,
Longpeng(Mike)
