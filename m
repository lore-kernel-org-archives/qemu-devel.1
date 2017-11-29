Received: from eggs.gnu.org ([2001:4830:134:3::10]:45422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJvLj-0006nd-HF
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 00:56:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1eJvLf-0002TR-6g
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 00:55:59 -0500
Received: from mail-eopbgr00139.outbound.protection.outlook.com
	([40.107.0.139]:41010
	helo=EUR02-AM5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1eJvLe-0002Sy-RS
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 00:55:55 -0500
Date: Wed, 29 Nov 2017 08:55:46 +0300
From: "rkagan@virtuozzo.com" <rkagan@virtuozzo.com>
Message-ID: <20171129055545.GC2374@rkaganip.lan>
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
	<20171128211326.GV3037@localhost.localdomain>
	<33183CC9F5247A488A2544077AF19020DA4A8D0F@DGGEMA505-MBS.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA4A8D0F@DGGEMA505-MBS.china.huawei.com>
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, longpeng <longpeng2@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, huangpeng <peter.huangpeng@huawei.com>, Zhaoshenglong <zhaoshenglong@huawei.com>

On Wed, Nov 29, 2017 at 01:57:14AM +0000, Gonglei (Arei) wrote:
> > On Tue, Nov 28, 2017 at 11:20:27PM +0300, Denis V. Lunev wrote:
> > > On 11/28/2017 10:58 PM, Eduardo Habkost wrote:
> > > > On Fri, Nov 24, 2017 at 04:26:50PM +0300, Denis Plotnikov wrote:
> > > >> Commit 14c985cffa "target-i386: present virtual L3 cache info for vcpus"
> > > >> introduced and set by default exposing l3 to the guest.
> > > >>
> > > >> The motivation behind it was that in the Linux scheduler, when waking up
> > > >> a task on a sibling CPU, the task was put onto the target CPU's runqueue
> > > >> directly, without sending a reschedule IPI.  Reduction in the IPI count
> > > >> led to performance gain.
> > > >>
> 
> Yes, that's one thing.
> 
> The other reason for enabling L3 cache is the performance of accessing memory.

I guess you're talking about the super-smart buffer size tuning glibc
does in its memcpy and friends.  We try to control that with an atomic
test for memcpy, and we didn't notice a difference.  We'll need to
double-check...

> We tested it by Stream benchmark, the performance is better with L3-cache=on.

This one: https://www.cs.virginia.edu/stream/ ?  Thanks, we'll have a
look, too.

> > > >> However, this isn't the whole story.  Once the task is on the target
> > > >> CPU's runqueue, it may have to preempt the current task on that CPU, be
> > > >> it the idle task putting the CPU to sleep or just another running task.
> > > >> For that a reschedule IPI will have to be issued, too.  Only when that
> > > >> other CPU is running a normal task for too little time, the fairness
> > > >> constraints will prevent the preemption and thus the IPI.
> > > >>
> > > >> This boils down to the improvement being only achievable in workloads
> > > >> with many actively switching tasks.  We had no access to the
> > > >> (proprietary?) SAP HANA benchmark the commit referred to, but the
> > > >> pattern is also reproduced with "perf bench sched messaging -g 1"
> > > >> on 1 socket, 8 cores vCPU topology, we see indeed:
> > > >>
> > > >> l3-cache	#res IPI /s	#time / 10000 loops
> > > >> off		560K		1.8 sec
> > > >> on		40K		0.9 sec
> > > >>
> > > >> Now there's a downside: with L3 cache the Linux scheduler is more eager
> > > >> to wake up tasks on sibling CPUs, resulting in unnecessary cross-vCPU
> > > >> interactions and therefore exessive halts and IPIs.  E.g. "perf bench
> > > >> sched pipe -i 100000" gives
> > > >>
> > > >> l3-cache	#res IPI /s	#HLT /s		#time /100000 loops
> > > >> off		200 (no K)	230		0.2 sec
> > > >> on		400K		330K		0.5 sec
> > > >>
> > > >> In a more realistic test, we observe 15% degradation in VM density
> > > >> (measured as the number of VMs, each running Drupal CMS serving 2 http
> > > >> requests per second to its main page, with 95%-percentile response
> > > >> latency under 100 ms) with l3-cache=on.
> > > >>
> > > >> We think that mostly-idle scenario is more common in cloud and personal
> > > >> usage, and should be optimized for by default; users of highly loaded
> > > >> VMs should be able to tune them up themselves.
> > > >>
> 
> For currently public cloud providers, they usually provide different instances,
> Including sharing instances and dedicated instances. 
> 
> And the public cloud tenants usually want the L3 cache, even bigger is better.
> 
> Basically all performance tuning target to specific scenarios, 
> we only need to ensure benefit in most scenes.

There's no doubt the ability to configure l3-cache is useful.  The
question is what the default value should be.

Thanks,
Roman.
