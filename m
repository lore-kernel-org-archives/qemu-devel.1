Received: from eggs.gnu.org ([2001:4830:134:3::10]:56363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dYTCV-0002fX-PA
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:22:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1dYTCP-00082i-M4
	for qemu-devel@nongnu.org; Fri, 21 Jul 2017 04:22:19 -0400
Message-ID: <1500625291.10674.22.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 21 Jul 2017 18:21:31 +1000
In-Reply-To: <20170721075015.GE3717@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-5-git-send-email-clg@kaod.org>
	<20170719030849.GQ3140@umbus.fritz.box>
	<1500436938.3350.11.camel@kernel.crashing.org>
	<20170721075015.GE3717@umbus.fritz.box>
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

On Fri, 2017-07-21 at 17:50 +1000, David Gibson wrote:
> On Wed, Jul 19, 2017 at 02:02:18PM +1000, Benjamin Herrenschmidt wrote:
> > On Wed, 2017-07-19 at 13:08 +1000, David Gibson wrote:
> > > 
> > > I'm somewhat uncomfortable with an irq allocater here in the intc
> > > code.  As a rule, irq allocation is the responsibility of the machine,
> > > not any sub-component.  Furthermore, it should allocate in a way which
> > > is repeatable, since they need to stay stable across reboots and
> > > migrations.
> > > 
> > > And, yes, we have an allocator of sorts in XICS - it has caused a
> > > number of problems in the past.
> > 
> > So....
> > 
> > For a bare metal model (which we don't have yet) of XIVE, the IRQ
> > numbering is entirely an artifact of how the HW is configured. There
> > should thus be no interrupt numbers visible to qemu.
> 
> Uh.. I don't entirely follow.  Do you mean that during boot the guest
> programs the irq numbers into the various components?

I said a "bare metal model" but yes. Pretty much. 
> 
> In that case this allocator stuff definitely doesn't belong on the
> xive code.
> 
> > For a PAPR model things are a bit different, but if we want to
> > maximize code re-use between the two, we probably need to make sure
> > the interrupts "allocated" by the machine for XIVE can be represented
> > by the HW model.
> > 
> > That means:
> > 
> >  - Each chip has a range (high bits are the block ID, which maps to a
> > chip, low bits, around 512K to 1M interrupts is the per-chip space).
> > 
> >  - Interrupts 0...N of that range (N depends on how much backing
> > memory and MMIO space is provisioned for each chip) are "generic IPIs"
> > which are somewhat generic interrupt source that can be triggered with
> > an MMIO store and routed to any target. Those are used in PAPR for
> > things like IPIs and some type of accelerator interrupts.
> > 
> >  - Portions of that range (which may or may not overlap the 0...N
> > above, if they do they "shadow" the generic interrupts) can be
> > configured to be the HW sources from the various PCIe bridges and
> > the PSI controller.
> 
> Err.. I'm confused how this not sure this relates to spapr.  There are
> no chips or PSI there, and the PCI bridges aren't really the same
> thing.

The above is the HW model, sorry for the confusion. With a few comments
about how they are used in PAPR.

So yes, in PAPR there's an "allocator" because the hypervisor will
create a guest "virtual" (or logical to use PAPR terminology) interrupt
number space, in order to represents the various interrupts into the
guest.

Those numbers however are just tokens, they don't have to represent any
real HW concept. So they can be "allocated" in a rather fixed way, for
example, you could have something like a fixed map where you put all
the PCI interrupts at a certain number (a factor of the PHB# with room
or a fix number per PHB, maybe 16K or so, the HW does 4K max). Another
based would have a chunk of "general purpose" IPIs (for use for actual
IPIs and for other things to come). And a range for the virtual device
interrupts for example. Or you can just use an allocator.

But it's fundamentally an allocator that sits in the hypervisor, so in
our case, I would say in the spapr "component" of XIVE, rather than the
XIVE HW model itself.

Now what Cedric did, because XIVE is very complex and we need something
for PAPR quickly, is not a complete HW model, but a somewhat simplified
one that only handles what PAPR exposes. So in that case where the
allocator sits is a bit of a TBD...

Cheers,
Ben.
