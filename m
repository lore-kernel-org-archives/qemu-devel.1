Received: from eggs.gnu.org ([2001:4830:134:3::10]:57154)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRxHC-0002zW-Oi
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:41:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRxH8-00048O-04
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 05:41:02 -0500
Date: Wed, 28 Nov 2018 11:40:24 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181128104024.GD4393@caravaggio>
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-5-sameo@linux.intel.com>
	<CAFEAcA9wvrnshOTYz-jZ0n6m7SfusYY+bnB-iPnQuVNqqdg5Ww@mail.gmail.com>
	<20181127153551.GC4393@caravaggio>
	<CAFEAcA9B5DPeot26-oGtR-h+xdfg+tmUPrYpKhaneaT1tr1yqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA9B5DPeot26-oGtR-h+xdfg+tmUPrYpKhaneaT1tr1yqQ@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 04/13] target: arm: Move all interrupt and
 exception handlers into their own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, Nov 27, 2018 at 03:46:30PM +0000, Peter Maydell wrote:
> On Tue, 27 Nov 2018 at 15:36, Samuel Ortiz <sameo@linux.intel.com> wrote:
> >
> > On Tue, Nov 20, 2018 at 01:45:03PM +0000, Peter Maydell wrote:
> > > What is your plan for dealing with the way that the KVM code
> > > for injecting a breakpoint exception into the guest works
> > > by calling the do_interrupt code ?
> > > (see target/arm/kvm64.c:kvm_arm_handle_debug(),
> > > which calls cc->do_interrupt(cs).) This patch moves those
> > > functions to a file which won't be compiled and a later one
> > > in the series seems to stop cc->do_interrupt being set at all
> > > if CONFIG_TCG is not defined. That will result in QEMU crashing
> > > when it tries to inject an exception, won't it?
> > Yes, indeed.
> > So it seems we need to inject an exception back into the guest when
> > doing hardware assisted debugging and when we have not set any
> > breakpoint from QEMU. So it's essentially handling the debugging from
> > the guest case.
> > Would returning an error when that happens be an acceptable solution? So
> > when building qemu for arm64 with TCG disabled, one would basically no
> > longer be able to debug from the guest.
> 
> I don't think that's a good idea. --disable-tcg shouldn't imply
> "and you lose some features of KVM".
I see your point but as you're certainly aware, at the moment
building with --disable-tcg implies you don't get an ARM QEMU
binary at all. I felt this was an improvement over the current
situation ;)

> This code is used in both TCG
> and KVM, so needs to still be in the binary for KVM.
Given that this piece of code effectively builds a dependency to TCG
from the KVM code, I see a few solutions but I need your input here. We
could:

- Decide we don't want to support --disable-tcg for ARM. We'd then carry
  this patch serie from the NEMU code repo. Worst case scenario, at
  least for us.
- Manage to implement exception injection from userspace without TCG.
  Would it even be possible?
- Offload exception injections back to the kernel in those cases. I feel
  this would be the cleanest solution but may need kernel changes.

Any other suggestions?

Cheers,
Samuel.
