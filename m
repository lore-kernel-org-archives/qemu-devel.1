Received: from eggs.gnu.org ([2001:4830:134:3::10]:47368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRwyC-0004hp-3N
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:16:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRwy7-0005LJ-1b
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:16:52 -0500
Received: from 3.mo177.mail-out.ovh.net ([46.105.36.172]:54551)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eRwy6-0005EO-P4
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 04:16:46 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 895B78F7B3
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 10:16:37 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <6768575f-27e0-1277-3e7e-56ec44298e6a@kaod.org>
Date: Thu, 21 Dec 2017 10:16:32 +0100
MIME-Version: 1.0
In-Reply-To: <1513815126.2743.34.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 12/21/2017 01:12 AM, Benjamin Herrenschmidt wrote:
> On Wed, 2017-12-20 at 16:09 +1100, David Gibson wrote:
>>
>> As you've suggested in yourself, I think we might need to more
>> explicitly model the different components of the XIVE system.  As part
>> of that, I think you need to be clearer in this base skeleton about
>> exactly what component your XIVE object represents.
>>
>> If the answer is "the overall thing" I suspect that's not what you
>> want - I had one of those for XICs which proved to be a mistake
>> (eventually replaced by the XICSFabric interface).
>>
>> Changing the model later isn't impossible, but doing so without
>> breaking migration can be a real pain, so I think it's worth a
>> reasonable effort to try and get it right initially.
> 
> Note: we do need to speed things up a bit, as having exploitation mode
> in KVM will significantly help with IPI performance among other things.
> 
> I'm about ready to do the KVM bits. The one thing we need to discuss
> and figure a good design for is how we map all those interrupt control
> pages into qemu.
> 
> Each interrupt (either PCIe pass-through or the "generic XIVE IPIs"
> which are used for guest IPIs and for vio/virtio/emulated interrupts)
> comes with a "control page" (ESB page) which needs to be mapped into
> the guest, and the generic IPIs also come with a trigger page which
> needs to be mapped into the guest for guest IPIs or OpenCAPI
> interrupts, or just qemu for emulated devices.

what about the OS TIMA page ? Do we trap the accesses in QEMU and
forward them to KVM ? or do we use a similar mechanism. 

> Now that can be thousands of these critters. I certainly don't want to
> create thousands of VMAs in qemu and even less thousands of memory
> regions in KVM.

we can provision one mapping per kvmppc_xive_src_block  maybe ?  

> So we need some kind of mechanism by wich a single large VMA gets
> mmap'ed into qemu (or maybe a couple of these, but not too many) and
> the interrupt pages can be assigned to slots in there and demand
> faulted.

Frederic has started to put in place a similar mecanism for OpenCAPI.

> For the generic interrupts, this can probably be covered by KVM, adding
> some arch ioctls for allocating IPIs and mmap'ing that region etc...

The KVM device has a ioctl handler :
   
	struct kvm_device_ops {

		long (*ioctl)(struct kvm_device *dev, unsigned int ioctl,
			      unsigned long arg);
	};

So a KVM device for the XIVE interrupt controller can implement a couple 
of extra calls for its need, like getting the VMA addresses, etc

> For pass-through, it's trickier, we don't want to mmap each irqfd
> individually for the above reason, so we want to "link" them to KVM. We
> don't want to allow qemu to take control of any arbitrary interrupt in
> the system though, so it has to related to the ownership of the irqfd
> coming from vfio.
> 
> OpenCAPI I suspect will be its own can of worms...
> 
> Also, have we decided how the process of switching between XICS and
> XIVE will work vs. CAS ? 

That's how it is described in the architecture. The current choice is
to create both XICS and XIVE objects and choose at CAS which one to
use. It relies today on the capability of the pseries machine to 
allocate IRQ numbers for both interrupt controller backends. These
patches have been merged in QEMU.

A change of interrupt mode results in a reset. The device tree is 
populated accordingly and the ICPs are switched for the model in 
use. 

> And how that will interact with KVM ? 

I expect we will do the same, which is to create two KVM devices to 
be able to handle both interrupt controller backends depending on the 
mode negotiated by the guest.  


> I was
> thinking the kernel would implement a different KVM device type, ie
> the "emulated XICS" would remain KVM_DEV_TYPE_XICS and XIVE would be
> KVM_DEV_TYPE_XIVE.

yes. it makes sense. The new device will have a lot in common with the 
KVM_DEV_TYPE_XICS using kvm_xive_ops.

C.
