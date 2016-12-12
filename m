Received: from eggs.gnu.org ([2001:4830:134:3::10]:57995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGQYd-0000ze-MV
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:22:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1cGQYX-0003vP-Qh
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:22:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53232)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <drjones@redhat.com>) id 1cGQYX-0003vE-In
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 08:22:13 -0500
Date: Mon, 12 Dec 2016 14:22:09 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20161212132209.ryh4uojsz7uev2a6@kamzik.brq.redhat.com>
References: <CAFEAcA9_E=uPX5GqryrF4kyrXNYbH-8Oiv1mgbJM6VshnQe-kw@mail.gmail.com>
	<20161102135933.h6clwz4ahsgchwgv@hawk.localdomain>
	<CAFEAcA9hb1M25AYnBDY0OYTMGvGe5VVR0SLg=T5MR_k1U_S=fw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9hb1M25AYnBDY0OYTMGvGe5VVR0SLg=T5MR_k1U_S=fw@mail.gmail.com>
Subject: Re: [Qemu-devel] when we add EL2 to QEMU TCG ARM emulation and the
 virt board, should it default on or off?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On Mon, Dec 12, 2016 at 12:48:14PM +0000, Peter Maydell wrote:
> On 2 November 2016 at 13:59, Andrew Jones <drjones@redhat.com> wrote:
> > On Tue, Nov 01, 2016 at 05:16:59PM +0000, Peter Maydell wrote:
> >>  (2) directly user-set cpu property, or board property ?
> >
> > So this is why I was rambling above about the two precedents.
> > IMO, we should choose a cpu property when it's a purely cpu
> > feature, like the PMU, and board (without a user-settable cpu
> > property) otherwise. Does this feature require board changes?
> > I'm aware of switching the psci method from hvc to smc, but
> > I'd shrug that one off. Is there anything else? If not, then
> > I vote cpu property only.
> 
> So the things that the board needs to support EL2:
>  * PSCI method change
>  * need to wire up some interrupt lines (GICv3 maintenance
>    interrupt, and VIRQ and VFIQ)
>  * for GICv2 you would need also to set a property on
>    the GIC to tell it to implement the virt extensions
>    (for GICv3 this isn't necessary as the virt extensions
>    only affect the CPU interface, which is strictly part
>    of the CPU and which in my patches is configured via
>    a back-door connection between the CPU proper and the
>    GIC cpuif code)
> 
> You can do all the interrupt wiring unconditionally,
> because if the CPU doesn't have EL2 then the extra
> irq lines are just unused.

Sounds good.

> And of course you can drive
> the board changes off a CPU property value if you want...

Fair point. What do we typically do? I think it'd be nice to be
consistent here. Do cpu properties typically [silently] drive
board changes? Or do board properties, depending on cpu properties,
simply fail when those cpu properties aren't selected by the user,
or do they silently enable them?

> 
> The other reason I made EL3 have both a CPU property and a
> board property is that it allowed us to have the board
> property default to false (for back-compat) but the
> CPU property default to true (so that any future boards
> would get EL3 support by default, like the h/w -- you
> can't get a real Cortex-A57 without EL2 and EL3).

This makes sense to me. A good goal is to keep the processor model
as close as possible to real hardware. I guess that pretty much
just leaves one option: creating a board property that enables the
there-by-default (but still special) cpu feature use.

So, EL2 cpu property on by default, but EL2 board property off
by default. And with EL2 board property off, El2 cpu property
automatically turned off?

Thanks,
drew

> 
> thanks
> -- PMM
