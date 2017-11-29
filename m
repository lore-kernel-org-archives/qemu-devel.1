Received: from eggs.gnu.org ([2001:4830:134:3::10]:48391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eK2Wg-0006W1-An
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:35:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eK2Wd-0003kd-50
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:35:46 -0500
Received: from mail-ve1eur01hn0222.outbound.protection.outlook.com
	([104.47.1.222]:20608
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eK2Wc-0003kT-9b
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 08:35:43 -0500
Date: Wed, 29 Nov 2017 16:35:25 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20171129133524.GA2279@rkaganb.sw.ru>
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
	<20171128211326.GV3037@localhost.localdomain>
	<5A1E43A6.1010607@huawei.com>
	<20171129104122.GY3037@localhost.localdomain>
	<5A1EA0DB.60303@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A1EA0DB.60303@huawei.com>
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Longpeng (Mike)" <longpeng2@huawei.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, Gonglei <arei.gonglei@huawei.com>, zhaoshenglong <zhaoshenglong@huawei.com>

On Wed, Nov 29, 2017 at 07:58:19PM +0800, Longpeng (Mike) wrote:
> On 2017/11/29 18:41, Eduardo Habkost wrote:
> > On Wed, Nov 29, 2017 at 01:20:38PM +0800, Longpeng (Mike) wrote:
> >> On 2017/11/29 5:13, Eduardo Habkost wrote:
> >>> On Tue, Nov 28, 2017 at 11:20:27PM +0300, Denis V. Lunev wrote:
> >>>> On 11/28/2017 10:58 PM, Eduardo Habkost wrote:
> >>>>> On Fri, Nov 24, 2017 at 04:26:50PM +0300, Denis Plotnikov wrote:
> >>>>>> Commit 14c985cffa "target-i386: present virtual L3 cache info for vcpus"
> >>>>>> introduced and set by default exposing l3 to the guest.
> >>>>>>
> >>>>>> The motivation behind it was that in the Linux scheduler, when waking up
> >>>>>> a task on a sibling CPU, the task was put onto the target CPU's runqueue
> >>>>>> directly, without sending a reschedule IPI.  Reduction in the IPI count
> >>>>>> led to performance gain.
> >>>>>>
> >>>>>> However, this isn't the whole story.  Once the task is on the target
> >>>>>> CPU's runqueue, it may have to preempt the current task on that CPU, be
> >>>>>> it the idle task putting the CPU to sleep or just another running task.
> >>>>>> For that a reschedule IPI will have to be issued, too.  Only when that
> >>>>>> other CPU is running a normal task for too little time, the fairness
> >>>>>> constraints will prevent the preemption and thus the IPI.
> >>>>>>
> >>
> >> Agree. :)
> >>
> >> Our testing VM is Suse11 guest with idle=poll at that time and now I realize
> >> that Suse11 has a BUG in its scheduler.
> >>
> >> For REHL 7.3 or upstream kernel, in ttwu_queue_remote(), a RES IPI is issued if
> >> rq->idle is not polling:
> >> '''
> >> static void ttwu_queue_remote(struct task_struct *p, int cpu)
> >> {
> >> 	struct rq *rq = cpu_rq(cpu);
> >>
> >> 	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
> >> 		if (!set_nr_if_polling(rq->idle))
> >> 			smp_send_reschedule(cpu);
> >> 		else
> >> 			trace_sched_wake_idle_without_ipi(cpu);
> >> 	}
> >> }
> >> '''
> >>
> >> But for Suse11, it does not check, it send a RES IPI unconditionally.
> > 
> > So, does that mean no Linux guest benefits from the l3-cache=on
> > default except SuSE 11 guests?
> > 
> 
> Not only that, there is another scenario:
> 
> static void ttwu_queue(...)
> {
> 	if (...two cpus NOT sharing L3-cache) {
> 		...
> 		ttwu_queue_remote(p, cpu, wake_flags);
> 		return;
> 	}
> 	...
> 	ttwu_do_activate(rq, p, wake_flags, &rf); <--*Here*
> 	...
> }
> 
> In ttwu_do_activate(), there are also some opportunities with low probability to
> do not send RES IPI even if the target cpu isn't in IDLE polling state.

Well it isn't so low actually, what you need is to keep the cpus busy
switching tasks.  In that case it's not uncommon that the task being
woken up on a remote cpu has accumulated more vruntime than the task
already running on that cpu; in that case the new task won't preempt the
current task and the IPI won't be issued.  E.g. on a RHEL 7.4 guest we
saw:

> >>>>>> This boils down to the improvement being only achievable in workloads
> >>>>>> with many actively switching tasks.  We had no access to the
> >>>>>> (proprietary?) SAP HANA benchmark the commit referred to, but the
> >>>>>> pattern is also reproduced with "perf bench sched messaging -g 1"
> >>>>>> on 1 socket, 8 cores vCPU topology, we see indeed:
> >>>>>>
> >>>>>> l3-cache	#res IPI /s	#time / 10000 loops
> >>>>>> off		560K		1.8 sec
> >>>>>> on		40K		0.9 sec

The workload where it bites is mostly idle guest, with chains of
dependent wakeups, i.e. with little parallelism:

> >>>>>> Now there's a downside: with L3 cache the Linux scheduler is more eager
> >>>>>> to wake up tasks on sibling CPUs, resulting in unnecessary cross-vCPU
> >>>>>> interactions and therefore exessive halts and IPIs.  E.g. "perf bench
> >>>>>> sched pipe -i 100000" gives
> >>>>>>
> >>>>>> l3-cache	#res IPI /s	#HLT /s		#time /100000 loops
> >>>>>> off		200 (no K)	230		0.2 sec
> >>>>>> on		400K		330K		0.5 sec
> >>>>>>
> >>
> >> I guess this issue could be resolved by disable the SD_WAKE_AFFINE.

Actually, it's SD_WAKE_AFFINE that's being effectively defeated by this
l3-cache, because the scheduler thinks that the cpus that share the
last-level cache are close enough that a dependent task can be woken up
on a sibling cpu.

> >> As Gonglei said:
> >> 1. the L3 cache relates to the user experience.
> > 
> > This is true, in a way: I have seen a fair share of user reports
> > where they incorrectly blame the L3 cache absence or the L3 cache
> > size for performance problems.
> > 
> >> 2. the glibc would get the cache info by CPUID directly, and relates to the
> >> memory performance.
> > 
> > I'm interested in numbers that demonstrate that.

Me too.  I vaguely remember debugging a memcpy degradation in the guest
(on the Parallels proprietary hypervisor), that turned out being due a
combination of l3 cache size and the cpu topology exposed to the guest,
which caused glibc to choose an inadequate buffuer size.

> Sorry I have no numbers in hand currently :(
> 
> I'll do some tests these days, please give me some time.

We'll try to get some data on this, too.

> >> What's more, the L3 cache relates to the sched_domain which is important to the
> >> (load) balancer when system is busy.
> >>
> >> All this doesn't mean the patch is insignificant, I just think we should do more
> >> research before decide. I'll do some tests, thanks. :)
> > 
> > Yes, we need more data.  But if we find out that there are no
> > cases where the l3-cache=on default actually improves
> > performance, I will be willing to apply this patch.
> > 
> 
> That's a good thing if we find the truth, it's free. :)
> 
> OTOH, I think we should notice that: Linux is designed on real hardware, maybe
> there're some other problems if QEMU lacks some related features. If we search
> 'cpus_share_cache' in the Linux kernel, we can see that it's also used by Block
> Layer.
> 
> > IMO, the long term solution is to make Linux guests not misbehave
> > when we stop lying about the L3 cache.  Maybe we could provide a
> > "IPIs are expensive, please avoid them" hint in the KVM CPUID
> > leaf?

We already have it, it's the hypervisor bit ;)  Seriously, I'm unaware
of hypervisors where IPIs aren't expensive.

> Maybe more PV features could be digged.

One problem with this is that PV features are hard to get into other
guest OSes or existing Linux guests.

Roman.
