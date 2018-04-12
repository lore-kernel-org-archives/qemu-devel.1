Received: from eggs.gnu.org ([2001:4830:134:3::10]:51667)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6Xap-00018Z-4v
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:28:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1f6Xak-0004xE-4M
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:28:31 -0400
Received: from 7.mo173.mail-out.ovh.net ([46.105.44.159]:46930)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1f6Xaj-0004wN-T3
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 04:28:26 -0400
Received: from player773.ha.ovh.net (unknown [10.109.122.16])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id 41FA1BD6A2
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 10:28:24 +0200 (CEST)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-3-clg@kaod.org>
	<20171220050947.GC5981@umbus.fritz.box>
	<1513815126.2743.34.camel@kernel.crashing.org>
	<20180412050821.GL9425@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <72b8e1f7-8b69-78c9-3abf-165eca5c42d3@kaod.org>
Date: Thu, 12 Apr 2018 10:28:19 +0200
MIME-Version: 1.0
In-Reply-To: <20180412050821.GL9425@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
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
To: David Gibson <david@gibson.dropbear.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>

On 04/12/2018 07:08 AM, David Gibson wrote:
> On Thu, Dec 21, 2017 at 11:12:06AM +1100, Benjamin Herrenschmidt wrote:
>> On Wed, 2017-12-20 at 16:09 +1100, David Gibson wrote:
>>>
>>> As you've suggested in yourself, I think we might need to more
>>> explicitly model the different components of the XIVE system.  As part
>>> of that, I think you need to be clearer in this base skeleton about
>>> exactly what component your XIVE object represents.
>>>
>>> If the answer is "the overall thing" I suspect that's not what you
>>> want - I had one of those for XICs which proved to be a mistake
>>> (eventually replaced by the XICSFabric interface).
>>>
>>> Changing the model later isn't impossible, but doing so without
>>> breaking migration can be a real pain, so I think it's worth a
>>> reasonable effort to try and get it right initially.
>>
>> Note: we do need to speed things up a bit, as having exploitation mode
>> in KVM will significantly help with IPI performance among other things.
>>
>> I'm about ready to do the KVM bits. The one thing we need to discuss
>> and figure a good design for is how we map all those interrupt control
>> pages into qemu.
>>
>> Each interrupt (either PCIe pass-through or the "generic XIVE IPIs"
>> which are used for guest IPIs and for vio/virtio/emulated interrupts)
>> comes with a "control page" (ESB page) which needs to be mapped into
>> the guest, and the generic IPIs also come with a trigger page which
>> needs to be mapped into the guest for guest IPIs or OpenCAPI
>> interrupts, or just qemu for emulated devices.
>>
>> Now that can be thousands of these critters. I certainly don't want to
>> create thousands of VMAs in qemu and even less thousands of memory
>> regions in KVM.
>>
>> So we need some kind of mechanism by wich a single large VMA gets
>> mmap'ed into qemu (or maybe a couple of these, but not too many) and
>> the interrupt pages can be assigned to slots in there and demand
>> faulted.
> 
> Ok, I see your point.  We'll definitely need to be able to map things
> in as a block, rather than one by one.

So, the approach taken is to use a mmap() exposed in a single ram_device 
memory region to the guest. The size is the irq number space size. 
This is hardcoded to 4096 (IPIs) + 1024 (virtual device interrupts) in 
QEMU. We can change that, but the 4K split is important for XICS 
compatibility. The kvm xive device should self adapt.

C. 


>> For the generic interrupts, this can probably be covered by KVM, adding
>> some arch ioctls for allocating IPIs and mmap'ing that region etc...
>>
>> For pass-through, it's trickier, we don't want to mmap each irqfd
>> individually for the above reason, so we want to "link" them to KVM. We
>> don't want to allow qemu to take control of any arbitrary interrupt in
>> the system though, so it has to related to the ownership of the irqfd
>> coming from vfio.
>>
>> OpenCAPI I suspect will be its own can of worms...
>>
>> Also, have we decided how the process of switching between XICS and
>> XIVE will work vs. CAS ? And how that will interact with KVM ? I was
>> thinking the kernel would implement a different KVM device type, ie
>> the "emulated XICS" would remain KVM_DEV_TYPE_XICS and XIVE would be
>> KVM_DEV_TYPE_XIVE.
>>
> 
