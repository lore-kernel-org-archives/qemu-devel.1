Received: from eggs.gnu.org ([2001:4830:134:3::10]:41904)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJrcw-0007u4-KC
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:57:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1eJrct-0005B8-J8
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:57:30 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2358 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <arei.gonglei@huawei.com>)
	id 1eJrct-000597-0I
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 20:57:27 -0500
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 29 Nov 2017 01:57:14 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA4A8D0F@DGGEMA505-MBS.china.huawei.com>
References: <1511530010-511740-1-git-send-email-dplotnikov@virtuozzo.com>
	<20171128195817.GA29077@localhost.localdomain>
	<2cd31202-27c3-983f-85a9-6814ff504706@virtuozzo.com>
	<20171128211326.GV3037@localhost.localdomain>
In-Reply-To: <20171128211326.GV3037@localhost.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Denis V. Lunev" <den@virtuozzo.com>, longpeng <longpeng2@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Denis Plotnikov <dplotnikov@virtuozzo.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "rth@twiddle.net" <rth@twiddle.net>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "rkagan@virtuozzo.com" <rkagan@virtuozzo.com>, huangpeng <peter.huangpeng@huawei.com>, Zhaoshenglong <zhaoshenglong@huawei.com>


> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Wednesday, November 29, 2017 5:13 AM
> To: Denis V. Lunev; longpeng; Michael S. Tsirkin
> Cc: Denis Plotnikov; pbonzini@redhat.com; rth@twiddle.net;
> qemu-devel@nongnu.org; rkagan@virtuozzo.com; Gonglei (Arei); huangpeng;
> Zhaoshenglong; herongguang.he@huawei.com
> Subject: Re: [Qemu-devel] [PATCH] i386: turn off l3-cache property by def=
ault
>=20
> [CCing the people who were copied in the original patch that
> enabled l3cache]
>=20
Thanks for Ccing.

> On Tue, Nov 28, 2017 at 11:20:27PM +0300, Denis V. Lunev wrote:
> > On 11/28/2017 10:58 PM, Eduardo Habkost wrote:
> > > Hi,
> > >
> > > On Fri, Nov 24, 2017 at 04:26:50PM +0300, Denis Plotnikov wrote:
> > >> Commit 14c985cffa "target-i386: present virtual L3 cache info for vc=
pus"
> > >> introduced and set by default exposing l3 to the guest.
> > >>
> > >> The motivation behind it was that in the Linux scheduler, when wakin=
g up
> > >> a task on a sibling CPU, the task was put onto the target CPU's runq=
ueue
> > >> directly, without sending a reschedule IPI.  Reduction in the IPI co=
unt
> > >> led to performance gain.
> > >>

Yes, that's one thing.

The other reason for enabling L3 cache is the performance of accessing memo=
ry.
We tested it by Stream benchmark, the performance is better with L3-cache=
=3Don.

> > >> However, this isn't the whole story.  Once the task is on the target
> > >> CPU's runqueue, it may have to preempt the current task on that CPU,=
 be
> > >> it the idle task putting the CPU to sleep or just another running ta=
sk.
> > >> For that a reschedule IPI will have to be issued, too.  Only when th=
at
> > >> other CPU is running a normal task for too little time, the fairness
> > >> constraints will prevent the preemption and thus the IPI.
> > >>
> > >> This boils down to the improvement being only achievable in workload=
s
> > >> with many actively switching tasks.  We had no access to the
> > >> (proprietary?) SAP HANA benchmark the commit referred to, but the
> > >> pattern is also reproduced with "perf bench sched messaging -g 1"
> > >> on 1 socket, 8 cores vCPU topology, we see indeed:
> > >>
> > >> l3-cache	#res IPI /s	#time / 10000 loops
> > >> off		560K		1.8 sec
> > >> on		40K		0.9 sec
> > >>
> > >> Now there's a downside: with L3 cache the Linux scheduler is more ea=
ger
> > >> to wake up tasks on sibling CPUs, resulting in unnecessary cross-vCP=
U
> > >> interactions and therefore exessive halts and IPIs.  E.g. "perf benc=
h
> > >> sched pipe -i 100000" gives
> > >>
> > >> l3-cache	#res IPI /s	#HLT /s		#time /100000 loops
> > >> off		200 (no K)	230		0.2 sec
> > >> on		400K		330K		0.5 sec
> > >>
> > >> In a more realistic test, we observe 15% degradation in VM density
> > >> (measured as the number of VMs, each running Drupal CMS serving 2 ht=
tp
> > >> requests per second to its main page, with 95%-percentile response
> > >> latency under 100 ms) with l3-cache=3Don.
> > >>
> > >> We think that mostly-idle scenario is more common in cloud and perso=
nal
> > >> usage, and should be optimized for by default; users of highly loade=
d
> > >> VMs should be able to tune them up themselves.
> > >>

For currently public cloud providers, they usually provide different instan=
ces,
Including sharing instances and dedicated instances.=20

And the public cloud tenants usually want the L3 cache, even bigger is bett=
er.

Basically all performance tuning target to specific scenarios,=20
we only need to ensure benefit in most scenes.

Thanks,
-Gonglei

> > > There's one thing I don't understand in your test case: if you
> > > just found out that Linux will behave worse if it assumes that
> > > the VCPUs are sharing a L3 cache, why are you configuring a
> > > 8-core VCPU topology explicitly?
> > >
> > > Do you still see a difference in the numbers if you use "-smp 8"
> > > with no "cores" and "threads" options?
> > >
> > This is quite simple. A lot of software licenses are bound to the amoun=
t
> > of CPU __sockets__. Thus it is mandatory in a lot of cases to set topol=
ogy
> > with 1 socket/xx cores to reduce the amount of money necessary to
> > be paid for the software.
>=20
> In this case it looks like we're talking about the expected
> meaning of "cores=3DN".  My first interpretation would be that the
> user obviously want the guest to see the multiple cores sharing a
> L3 cache, because that's how real CPUs normally work.  But I see
> why you have different expectations.
>=20
> Numbers on dedicated-pCPU scenarios would be helpful to guide the
> decision.  I wouldn't like to cause a performance regression for
> users that fine-tuned vCPU topology and set up CPU pinning.
>=20
> --
> Eduardo
