Received: from eggs.gnu.org ([2001:4830:134:3::10]:47560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dXS57-0004s3-Kv
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:58:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1dXS56-00042q-Nr
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 08:58:29 -0400
Date: Tue, 18 Jul 2017 14:58:17 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20170718125817.bf4u5ml7idjftlw3@kamzik.brq.redhat.com>
References: <1498927637-14496-1-git-send-email-drjones@redhat.com>
	<1498927637-14496-3-git-send-email-drjones@redhat.com>
	<CAFEAcA-CQm1FuF7eyveSbSchRD1PkB-PDVNyMQhVny+bmWWAvg@mail.gmail.com>
	<20170718123845.c2g3t4m4pyqofk2l@kamzik.brq.redhat.com>
	<CAFEAcA_6XronVOOCbWgJXctx6bp+nYys+cCsjUmtCiuaBjUb-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA_6XronVOOCbWgJXctx6bp+nYys+cCsjUmtCiuaBjUb-g@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] target/arm/kvm: split pmu init from
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>

On Tue, Jul 18, 2017 at 01:44:34PM +0100, Peter Maydell wrote:
> On 18 July 2017 at 13:38, Andrew Jones <drjones@redhat.com> wrote:
> > On Mon, Jul 10, 2017 at 04:27:35PM +0100, Peter Maydell wrote:
> >> On 1 July 2017 at 17:47, Andrew Jones <drjones@redhat.com> wrote:
> >> > When adding a PMU with a userspace irqchip we only do the INIT
> >> > stage of the device creation.
> >>
> >> Can you explain why? My assumption would be that either
> >> (a) we don't need the kernel's PMU, in which case don't
> >> create it at all, or
> >> (b) we do need the kernel's PMU, so we should both create
> >> and INIT it.
> >>
> >> If we do one but not the other then we've left a half
> >> created and unusable PMU device in the kernel, haven't we?
> >>
> >
> > I should have renamed the 'create' function to 'set_irq', then
> > it would make sense, because after the split done by this patch
> > 'create' only sets the irq, which can only be done with an
> > in-kernel irqchip. Both irqchip types still require INIT though,
> > see kernel doc Documentation/virtual/kvm/devices/vcpu.txt.
> 
> Oh, I see, I read the commit message as "we only do the
> INIT stage when adding a PMU with a userspace irqchip",
> which isn't the same meaning as what you actually wrote.
> (perhaps "When adding a PMU with a userspace irqchip we
> skip the set-irq stage of device creation" would be clearer?)
> 
> > I'll send a v2 that renames the create function. But, before I do,
> > assuming the rename, do you have another comments on this or the
> > next patch? We might as well batch all the changes :-)
> 
> I think they looked mostly OK. A minor nit:
> 
> +        if (kvm_enabled() &&
> +            !kvm_arm_pmu_create(cpu, PPI(VIRTUAL_PMU_IRQ))) {
> +            return;
> +        }
> +        if (kvm_enabled() && !kvm_arm_pmu_init(cpu)) {
>              return;
>          }
> 
> might be better as
>        if (kvm_enabled()) {
>            if (!kvm_arm_pmu_create(...)) {
>                /* error handling */
>            }
>            if (!kvm_arm_pmu_init(...)) {
>                /* error handling */
>            }
>        }

With the top version I was setting things up for a one-liner
change in the next patch, as only the first condition needs
to have s/kvm_enabled/kvm_irqchip_in_kernel/ done to it.

> 
> (and I'm not sure "silently return" is really the right error
> handling, but that is what we do currently, so whatever.)

I'll give the error handling a bit of thought before respinning.

Thanks,
drew
