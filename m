Received: from eggs.gnu.org ([2001:4830:134:3::10]:38021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eRoTT-00073G-SW
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 19:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@kernel.crashing.org>) id 1eRoTP-0006L3-Tf
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 19:12:35 -0500
Message-ID: <1513815126.2743.34.camel@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Thu, 21 Dec 2017 11:12:06 +1100
In-Reply-To: <20171220050947.GC5981@umbus.fritz.box>
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 02/19] spapr: introduce a skeleton for
 the XIVE interrupt controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On Wed, 2017-12-20 at 16:09 +1100, David Gibson wrote:
> 
> As you've suggested in yourself, I think we might need to more
> explicitly model the different components of the XIVE system.  As part
> of that, I think you need to be clearer in this base skeleton about
> exactly what component your XIVE object represents.
> 
> If the answer is "the overall thing" I suspect that's not what you
> want - I had one of those for XICs which proved to be a mistake
> (eventually replaced by the XICSFabric interface).
> 
> Changing the model later isn't impossible, but doing so without
> breaking migration can be a real pain, so I think it's worth a
> reasonable effort to try and get it right initially.

Note: we do need to speed things up a bit, as having exploitation mode
in KVM will significantly help with IPI performance among other things.

I'm about ready to do the KVM bits. The one thing we need to discuss
and figure a good design for is how we map all those interrupt control
pages into qemu.

Each interrupt (either PCIe pass-through or the "generic XIVE IPIs"
which are used for guest IPIs and for vio/virtio/emulated interrupts)
comes with a "control page" (ESB page) which needs to be mapped into
the guest, and the generic IPIs also come with a trigger page which
needs to be mapped into the guest for guest IPIs or OpenCAPI
interrupts, or just qemu for emulated devices.

Now that can be thousands of these critters. I certainly don't want to
create thousands of VMAs in qemu and even less thousands of memory
regions in KVM.

So we need some kind of mechanism by wich a single large VMA gets
mmap'ed into qemu (or maybe a couple of these, but not too many) and
the interrupt pages can be assigned to slots in there and demand
faulted.

For the generic interrupts, this can probably be covered by KVM, adding
some arch ioctls for allocating IPIs and mmap'ing that region etc...

For pass-through, it's trickier, we don't want to mmap each irqfd
individually for the above reason, so we want to "link" them to KVM. We
don't want to allow qemu to take control of any arbitrary interrupt in
the system though, so it has to related to the ownership of the irqfd
coming from vfio.

OpenCAPI I suspect will be its own can of worms...

Also, have we decided how the process of switching between XICS and
XIVE will work vs. CAS ? And how that will interact with KVM ? I was
thinking the kernel would implement a different KVM device type, ie
the "emulated XICS" would remain KVM_DEV_TYPE_XICS and XIVE would be
KVM_DEV_TYPE_XIVE.

Cheers,
Ben.
