Received: from eggs.gnu.org ([2001:4830:134:3::10]:58081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZVXi-00013B-6M
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dZVXe-0005uh-SA
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:04:30 -0400
Message-ID: <1500872645.10674.52.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 24 Jul 2017 15:04:05 +1000
In-Reply-To: <20170724032853.GB17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<1500436938.3350.11.camel@kernel.crashing.org>
	<20170721075015.GE3717@umbus.fritz.box>
	<1500625291.10674.22.camel@kernel.crashing.org>
	<20170724032853.GB17228@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 04/26] ppc/xive: introduce a skeleton
 for the XIVE interrupt controller model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Mon, 2017-07-24 at 13:28 +1000, David Gibson wrote:
> > So yes, in PAPR there's an "allocator" because the hypervisor will
> > create a guest "virtual" (or logical to use PAPR terminology) interrupt
> > number space, in order to represents the various interrupts into the
> > guest.
> 
> Ok, but are each of those logical irqs bound to a specific device/PHB
> line/whatever, or can they be configured by the guest?

So for clarity, let's first establish the terminology :-)

 - HW number is a HW interrupt number on a "bare metal" system or
powernv guest. For now we will ignore those, they are effectively a
side effect of how skiboot configure the XIVE and qemu per-se doesn't
allocate them.

 - A logical number is a "guest physical" interrupt number for a PAPR
guest. These fall into roughly 2 categories at the moment:

    * "interrupts" (or related) properties in the DT, typically
interrupts for a PCI device, ranges of MSIs etc... that correspond to
HW sources from a PHB.

    * "generic IPIs". Those are ranges of "generic" interrupts that the
hypervisor gives the guest. On a real system, they correspond to chunks
allocated off a HW facility for generic interrupts. Generic interrupts
are the same as normal interrupts from the prespective of
managing/receiving them, but are "triggered" by an MMIO to a certain HW
page. There's a DT property telling the guest the interrupt number
ranges for these guys.

So that logical number above is what a PAPR guest obtains from the DT
and uses for the various H-call used to manage and configure interrupt
sources.

In addition, the XIVE supports renumbering the interrupt number that
you obtain in the queues. Both bare metal linux, KVM and guests make
use of this. This only changes the number you observe in a queue when
you receive an interrupt, it has no effect on the HW number or logical
number used for the various management calls.

This is used by Linux so that:

  - On bare metal systems or PAPR guest with "exploitation mode" (ie,
PAPR guest directly using the XIVE), we put the linux interrupt number
in there as to avoid the reverse-mapping done by linux otherwise when
receiving an interrupt.

  - On PARP guests using the legacy hcalls, KVM configures the logical
number there.

> > Those numbers however are just tokens, they don't have to represent any
> > real HW concept. So they can be "allocated" in a rather fixed way, for
> > example, you could have something like a fixed map where you put all
> > the PCI interrupts at a certain number (a factor of the PHB# with room
> > or a fix number per PHB, maybe 16K or so, the HW does 4K max). Another
> > based would have a chunk of "general purpose" IPIs (for use for actual
> > IPIs and for other things to come). And a range for the virtual device
> > interrupts for example. Or you can just use an allocator.
> 
> Hm.  So what I'm meaning by an "allocator" is something at least
> partially dynamic.  Something you say "give me an irq" and it gives
> you the next available or similar.  As opposed to any mapping from
> devices to (logical) irqs, which the machine will need to supply one
> way or another.

For the sake of repeatability/migration etc... I think a mapping is
better than an allocator.  IE, a fixed number scheme so that the range
of interrupts for PHB#x is always a fixed function of x.

We can fix the number of "generic" interrupts given to a guest. The
only requirements from a PAPR perspective is that there should be at
least as many as there are possible threads in the guest so they can be
used as IPIs.

But we may need more for other things. We can make this a machine
parameter with a default value of something like 4096. If we call N
that number of extra generic interrupts, then the number of generic
interrutps would be #possible-vcpu's + N, or something like that.

> > But it's fundamentally an allocator that sits in the hypervisor, so in
> > our case, I would say in the spapr "component" of XIVE, rather than the
> > XIVE HW model itself.
> 
> Maybe..

You are right in that a mapping is a better term than an allocator
here.

> > Now what Cedric did, because XIVE is very complex and we need something
> > for PAPR quickly, is not a complete HW model, but a somewhat simplified
> > one that only handles what PAPR exposes. So in that case where the
> > allocator sits is a bit of a TBD...
> 
> Hm, ok.  My concern here is that "dynamic" allocation of irqs at the
> machine type level needs extreme caution, or the irqs may not be
> stable which will generally break migration.

Yes you are right. We should probably create a more "static" scheme.

Cheers,
Ben.
