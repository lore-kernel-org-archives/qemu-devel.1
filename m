Received: from eggs.gnu.org ([2001:4830:134:3::10]:50713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJzo4-0007Bl-Cr
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:41:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1eJzo1-0004IL-78
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:41:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:8410)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1eJzo0-0004Hz-Sz
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:41:29 -0500
Date: Wed, 29 Nov 2017 08:41:22 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20171129104122.GY3037@localhost.localdomain>
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
	<20171128211326.GV3037@localhost.localdomain>
	<5A1E43A6.1010607@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5A1E43A6.1010607@huawei.com>
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
Cc: "Denis V. Lunev" <den@virtuozzo.com>, "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, rkagan@virtuozzo.com, Gonglei <arei.gonglei@huawei.com>, huangpeng <peter.huangpeng@huawei.com>, zhaoshenglong <zhaoshenglong@huawei.com>, herongguang.he@huawei.com

On Wed, Nov 29, 2017 at 01:20:38PM +0800, Longpeng (Mike) wrote:
> On 2017/11/29 5:13, Eduardo Habkost wrote:
> > [CCing the people who were copied in the original patch that
> > enabled l3cache]
> > 
> > On Tue, Nov 28, 2017 at 11:20:27PM +0300, Denis V. Lunev wrote:
> >> On 11/28/2017 10:58 PM, Eduardo Habkost wrote:
> >>> Hi,
> >>>
> >>> On Fri, Nov 24, 2017 at 04:26:50PM +0300, Denis Plotnikov wrote:
> >>>> Commit 14c985cffa "target-i386: present virtual L3 cache info for vcpus"
> >>>> introduced and set by default exposing l3 to the guest.
> >>>>
> >>>> The motivation behind it was that in the Linux scheduler, when waking up
> >>>> a task on a sibling CPU, the task was put onto the target CPU's runqueue
> >>>> directly, without sending a reschedule IPI.  Reduction in the IPI count
> >>>> led to performance gain.
> >>>>
> >>>> However, this isn't the whole story.  Once the task is on the target
> >>>> CPU's runqueue, it may have to preempt the current task on that CPU, be
> >>>> it the idle task putting the CPU to sleep or just another running task.
> >>>> For that a reschedule IPI will have to be issued, too.  Only when that
> >>>> other CPU is running a normal task for too little time, the fairness
> >>>> constraints will prevent the preemption and thus the IPI.
> >>>>
> 
> Agree. :)
> 
> Our testing VM is Suse11 guest with idle=poll at that time and now I realize
> that Suse11 has a BUG in its scheduler.
> 
> For REHL 7.3 or upstream kernel, in ttwu_queue_remote(), a RES IPI is issued if
> rq->idle is not polling:
> '''
> static void ttwu_queue_remote(struct task_struct *p, int cpu)
> {
> 	struct rq *rq = cpu_rq(cpu);
> 
> 	if (llist_add(&p->wake_entry, &cpu_rq(cpu)->wake_list)) {
> 		if (!set_nr_if_polling(rq->idle))
> 			smp_send_reschedule(cpu);
> 		else
> 			trace_sched_wake_idle_without_ipi(cpu);
> 	}
> }
> '''
> 
> But for Suse11, it does not check, it send a RES IPI unconditionally.

So, does that mean no Linux guest benefits from the l3-cache=on
default except SuSE 11 guests?


> 
> >>>> This boils down to the improvement being only achievable in workloads
> >>>> with many actively switching tasks.  We had no access to the
> >>>> (proprietary?) SAP HANA benchmark the commit referred to, but the
> >>>> pattern is also reproduced with "perf bench sched messaging -g 1"
> >>>> on 1 socket, 8 cores vCPU topology, we see indeed:
> >>>>
> >>>> l3-cache	#res IPI /s	#time / 10000 loops
> >>>> off		560K		1.8 sec
> >>>> on		40K		0.9 sec
> >>>>
> >>>> Now there's a downside: with L3 cache the Linux scheduler is more eager
> >>>> to wake up tasks on sibling CPUs, resulting in unnecessary cross-vCPU
> >>>> interactions and therefore exessive halts and IPIs.  E.g. "perf bench
> >>>> sched pipe -i 100000" gives
> >>>>
> >>>> l3-cache	#res IPI /s	#HLT /s		#time /100000 loops
> >>>> off		200 (no K)	230		0.2 sec
> >>>> on		400K		330K		0.5 sec
> >>>>
> 
> I guess this issue could be resolved by disable the SD_WAKE_AFFINE.
> 
> As Gonglei said:
> 1. the L3 cache relates to the user experience.

This is true, in a way: I have seen a fair share of user reports
where they incorrectly blame the L3 cache absence or the L3 cache
size for performance problems.

> 2. the glibc would get the cache info by CPUID directly, and relates to the
> memory performance.

I'm interested in numbers that demonstrate that.

> 
> What's more, the L3 cache relates to the sched_domain which is important to the
> (load) balancer when system is busy.
> 
> All this doesn't mean the patch is insignificant, I just think we should do more
> research before decide. I'll do some tests, thanks. :)

Yes, we need more data.  But if we find out that there are no
cases where the l3-cache=on default actually improves
performance, I will be willing to apply this patch.

IMO, the long term solution is to make Linux guests not misbehave
when we stop lying about the L3 cache.  Maybe we could provide a
"IPIs are expensive, please avoid them" hint in the KVM CPUID
leaf?

> 
> >>>> In a more realistic test, we observe 15% degradation in VM density
> >>>> (measured as the number of VMs, each running Drupal CMS serving 2 http
> >>>> requests per second to its main page, with 95%-percentile response
> >>>> latency under 100 ms) with l3-cache=on.
> >>>>
> >>>> We think that mostly-idle scenario is more common in cloud and personal
> >>>> usage, and should be optimized for by default; users of highly loaded
> >>>> VMs should be able to tune them up themselves.
> >>>>
> >>> There's one thing I don't understand in your test case: if you
> >>> just found out that Linux will behave worse if it assumes that
> >>> the VCPUs are sharing a L3 cache, why are you configuring a
> >>> 8-core VCPU topology explicitly?
> >>>
> >>> Do you still see a difference in the numbers if you use "-smp 8"
> >>> with no "cores" and "threads" options?
> >>>
> >> This is quite simple. A lot of software licenses are bound to the amount
> >> of CPU __sockets__. Thus it is mandatory in a lot of cases to set topology
> >> with 1 socket/xx cores to reduce the amount of money necessary to
> >> be paid for the software.
> > 
> > In this case it looks like we're talking about the expected
> > meaning of "cores=N".  My first interpretation would be that the
> > user obviously want the guest to see the multiple cores sharing a
> > L3 cache, because that's how real CPUs normally work.  But I see
> > why you have different expectations.
> > 
> > Numbers on dedicated-pCPU scenarios would be helpful to guide the
> > decision.  I wouldn't like to cause a performance regression for
> > users that fine-tuned vCPU topology and set up CPU pinning.
> > 
> 
> 
> -- 
> Regards,
> Longpeng(Mike)
> 

-- 
Eduardo
