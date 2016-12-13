Received: from eggs.gnu.org ([2001:4830:134:3::10]:52655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cGm9e-0006Ye-VH
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:26:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1cGm9Y-0002aL-9g
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 07:25:58 -0500
References: <20161031025314.GJ18226@umbus.fritz.box>
	<ee1d7da4-373c-4be0-7e67-897a1c90042f@ozlabs.ru>
	<20161101024634.GA14860@umbus.fritz.box>
	<1479218565.3319.18.camel@redhat.com>
	<3353ecef-2308-13e3-025d-df41b2e89945@ozlabs.ru>
	<1479457042.1391.11.camel@redhat.com>
	<20161123050049.GD17795@umbus.fritz.box>
	<1480081581.4367.65.camel@redhat.com>
	<20161202041835.GF10089@umbus.fritz.box>
	<1481045447.6553.36.camel@redhat.com>
	<20161207041121.GB12489@umbus.fritz.box>
	<1481128923.3620.1.camel@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <491c0ca6-c559-441b-7a14-3656bfc0abfc@redhat.com>
Date: Tue, 13 Dec 2016 14:25:44 +0200
MIME-Version: 1.0
In-Reply-To: <1481128923.3620.1.camel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-ppc] [RFC PATCH qemu] spapr_pci: Create
 PCI-express root bus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Greg Kurz <groug@kaod.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, libvir-list@redhat.com, Michael Roth <mdroth@linux.vnet.ibm.com>, benh@kernel.crashing.org, Marcel Apfelbaum <mapfelba@redhat.com>

On 12/07/2016 06:42 PM, Andrea Bolognani wrote:
> [Added Marcel to CC]
>


Hi,

Sorry for the late reply.

> On Wed, 2016-12-07 at 15:11 +1100, David Gibson wrote:
>>> Is the difference between q35 and pseries guests with
>>> respect to PCIe only relevant when it comes to assigned
>>> devices, or in general? I'm asking this because you seem to
>>> focus entirely on assigned devices.
>>
>> Well, in a sense that's up to us.  The only existing model we have is
>> PowerVM, and PowerVM only does device passthrough, no emulated
>> devices.  PAPR doesn't really distinguish one way or the other, but
>> it's written from the perspective of assuming that all PCI devices
>> correspond to physical devices on the host
>
> Okay, that makes sense.
>
>>>> On q35,
>>>> you'd generally expect physically separate (different slot) devices to
>>>> appear under separate root complexes.
>>>
>>> This part I don't get at all, so please bear with me.
>>>
>>> The way I read it you're claiming that eg. a SCSI controller
>>> and a network adapter, being physically separate and assigned
>>> to separate PCI slots, should have a dedicated PCIe Root
>>> Complex each on a q35 guest.
>>

Not a PCIe Root Complex, but a PCIe Root port.

>> Right, my understanding was that if the devices were slotted, rather
>> than integrated, each one would sit under a separate root complex, the
>> root complex being a pseudo PCI to PCI bridge.
>
> I assume "slotted" means "plugged into a slot that's not one
> of those provided by pcie.0" or something along those lines.
>
> More on the root complex bit later.
>
>>> That doesn't match with my experience, where you would simply
>>> assign them to separate slots of the default PCIe Root Bus
>>> (pcie.0), eg. 00:01.0 and 00:02.0.
>>
>> The qemu default, or the libvirt default?
>
> I'm talking about the libvirt default, which is supposed to
> follows Marcel's PCIe Guidelines.
>
>> I think this represents
>> treating the devices as though they were integrated devices in the
>> host bridge.  I believe on q35 they would not be hotpluggable
>

Correct. Please have a look to the new document
regarding pcie: docs/pcie.txt and the corresponding presentations.


> Yeah, that's indeed not quite what libvirt would do by
> default: in reality, there would be a ioh3420 between the
> pcie.0 slots and each device exactly to enable hotplug.
>
>> but on
>> pseries they would be (because we don't use the standard hot plug
>> controller).
>
> We can account for that in libvirt and avoid adding the
> extra ioh3420s (or rather the upcoming generic PCIe Root
> Ports) for pseries guests.
>
>>> Maybe you're referring to the fact that you might want to
>>> create multiple PCIe Root Complexes in order to assign the
>>> host devices to separate guest NUMA nodes? How is creating
>>> multiple PCIe Root Complexes on q35 using pxb-pcie different
>>> than creating multiple PHBs using spapr-pci-host-bridge on
>>> pseries?
>>
>> Uh.. AIUI the root complex is the PCI to PCI bridge under which PCI-E
>> slots appear.  PXB is something different - essentially different host
>> bridges as you say (though with some weird hacks to access config
>> space, which make it dependent on the primary bus in a way which spapr
>> PHBs are not).
>>
>> I'll admit I'm pretty confused myself about the exact distinction
>> between root complex, root port and upstream and downstream ports.
>
> I think we both need to get our terminology straight :)
> I'm sure Marcel will be happy to point us in the right
> direction.
>
> My understanding is that the PCIe Root Complex is the piece
> of hardware that exposes a PCIe Root Bus (pcie.0 in QEMU);

right

> PXBs can be connected to slots in pcie.0 to create more buses
> that behave, for the most part, like pcie.0 and are mostly
> useful to bind devices to specific NUMA nodes.

right

  Same applies
> to legacy PCI with the pxb (instead of pxb-pcie) device.
>

pxb should not be used for PCIe machines, only for legacy PCI ones.

> In a similar fashion, PHBs are the hardware thingies that
> expose a PCI Root Bus (pci.0 and so on), the main difference
> being that they are truly independent: so a q35 guest will
> always have a "primary" PCIe Root Bus and (optionally) a
> bunch of "secondary" ones, but the same will not be the case
> for pseries guests.
>

OK

> I don't think the difference is that important though, at
> least from libvirt's point of view: whether you're creating
> a pseries guest with two PHBs, or a q35 guest with its
> built-in PCIe Root Complex and an extra PCIe Expander Bus,
> you will end up with two "top level" buses that you can plug
> more devices into.

I agree

  If we had spapr-pcie-host-bridge, we
> could treat them mostly the same - with caveats such as the
> one described above, of course.
>
>>>> Whereas on pseries they'll
>>>> appear as siblings on a virtual bus (which makes no physical sense for
>>>> point-to-point PCI-E).
>>>
>>> What is the virtual bus in question? Why would it matter
>>> that they're siblings?
>>
>> On pseries it won't.  But my understanding is that libvirt won't
>> create them that way on q35 - instead it will insert the RCs / P2P
>> bridges to allow them to be hotplugged.  Inserting that bridge may
>> confuse pseries guests which aren't expecting it.
>
> libvirt will automatically add PCIe Root Ports to make the
> devices hotpluggable on q35 guests, yes. But, as mentioned
> above, we can teach it not to.
>
>>> I'm possibly missing the point entirely, but so far it
>>> looks to me like there are different configurations you
>>> might want to use depending on your goal, and both q35
>>> and pseries give you comparable tools to achieve such
>>> configurations.
>>>>
>>>> I suppose we could try treating all devices on pseries as though they
>>>> were chipset builtin devices on q35, which will appear on the root
>>>> PCI-E bus without root complex.

Actually the root PCIe bus is part of a root complex.

  But I suspect that's likely to cause
>>>> trouble with hotplug, and it will certainly need different address
>>>> allocation from libvirt.
>>>
>>> PCIe Integrated Endpoint Devices are not hotpluggable on
>>> q35, that's why libvirt will follow QEMU's PCIe topology
>>> recommendations and place a PCIe Root Port between them;
>>> I assume the same could be done for pseries guests as
>>> soon as QEMU grows support for generic PCIe Root Ports,
>>> something Marcel has already posted patches for.
>>
>> Here you've hit on it.  No, we should not do that for pseries,
>> AFAICT.  PAPR doesn't really have the concept of integrated endpoint
>> devices, and all devices can be hotplugged via the PAPR mechanisms
>> (and none can via the PCI-E standard hotplug mechanism).
>

This seems to be interfering with the PCIe spec:
   1. No PCIe root ports ? those are part of the spec.
   2. Only integrated devices ? hotplug is not PCIe native?

> Cool, I get it now.
>
>>> Again, sorry for clearly misunderstanding your explanation,
>>> but I'm still not seeing the issue here. I'm sure it's very
>>> clear in your mind, but I'm afraid you're going to have to
>>> walk me through it :(
>>
>> I wish it were entirely clear in my mind.  Like I say I'm still pretty
>> confused by exactly the root complex entails.
>
> Same here, but this back-and-forth is helping! :)
>
> [...]
>>> What about virtio devices, which present themselves either
>>> as legacy PCI or PCIe depending on the kind of slot they
>>> are plugged into? Would they show up as PCIe or legacy PCI
>>> on a PCIe-enabled pseries guest?
>>
>> That we'd have to address on the qemu side with some
>
> Unfinished sentence?
>
> [...]
>>> Is the Root Complex not currently exposed? The Root Bus
>>> certainly is,
>>
>> Like I say, I'm fairly confused myself, but I'm pretty sure that Root
>> Complex != Root Bus.  The RC sits under the root bus IIRC.. or
>> possibly it consists of the root bus plus something under it as well.
>>

The Root complex includes the PCI bus, some configuration registers if
needed, provides access to the configuration space, translates relevant CPU
reads/writes to PCI(e) transactions...

>> Now... from what Laine was saying it sounds like more of the
>> differences between PCI-E placement and PCI placement may be
>> implemented by libvirt than qemu than I realized.  So possibly we do
>> want to make the bus be PCI-E on the qemu side, but have libvirt use
>> the vanilla-PCI placement guidelines rather than PCI-E for pseries.
>
> Basically the special casing I was mentioning earlier.

That looks complicated.. I wish I would no more about the pseries
PCIe stuff, does any one know where I can get the info ? (besides 'google it'...)

>
> [...]
>>> Maybe I just don't quite get the relationship between Root
>>> Complexes and Root Buses, but I guess my question is: what
>>> is preventing us from simply doing whatever a
>>> spapr-pci-host-bridge is doing in order to expose a legacy
>>> PCI Root Bus (pci.*) to the guest, and create a new
>>> spapr-pcie-host-bridge that exposes a PCIe Root Bus (pcie.*)
>>> instead?
>>
>> Hrm, the suggestion of providing both a vanilla-PCI and PCI-E host
>> bridge came up before.  I think one of us spotted a problem with that,
>> but I don't recall what it was now.  I guess one is how libvirt would
>> map it's stupid-fake-domain-numbers to which root bus to use.
>

This would be a weird configuration, I never heard of something like that
on a bare metal machine, but I never worked on pseries, who knows...


> That issue is relevant whether or nor we have different PHB
> flavors, isn't it? As soon as multiple PHBs are present in
> a pseries guest, multiple PCI domains will be there as well,
> and we need to handle that somehow.
>
> On q35, on the other hand, I haven't been able to find a way
> to create extra PCI domains: adding a pxb-pcie certainly
> didn't work the same as adding an extra spapr-pci-host-bridge
> in that regard.
>

Indeed, all the pxb-pcie devices "share" the same domain.

> [...]
>>> Maybe we should have a different model, specific to
>>> pseries guests, instead, so that all PHBs would look the
>>> same in the guest XML, something like
>>>
>>>    <controller type='pci' model='phb-pcie'/>
>>>
>>> It would require shuffling libvirt's PCI address allocation
>>> code around quite a bit, but it should be doable. And if it
>>> makes life easier for our users, then it's worth it.
>>
>> Hrm.  So my first inclination would be to stick with the generic
>> names, and map those to creating new pseries host bridges on pseries
>> guests.  I would have thought that would be the easier option for
>> users.  But I may not have realized all the implications yet.
>
> You're probably right, but I can't immediately see how we
> would make the user aware of which PHB is which. Maybe we
> could add some sub-element or extra attribute...
>
> Anyway, we should not focus too much on this specific bit
> at the moment, deciding on a specific XML is mostly
> bikeshedding :)
>
> [...]
>>> * Eduardo's work, which you mentioned, is going to be very
>>>    beneficial in the long run; in the short run, Marcel's
>>>    PCIe device placement guidelines, a document that has seen
>>>    contributions from QEMU, OVMF and libvirt developers, have
>>>    been invaluable to improve libvirt's PCI address allocation
>>>    logic. So we're already doing better, and more improvements
>>>    are on the way :)
>>
>> Right.. so here's the thing, I strongly suspect that Marcel's
>> guidelines will not be correct for pseries.

We should make the document stick for all PCIe archs, if we need
to modify it, let's do it.

   I'm not sure if they'll
>> be definitively wrong, or just different enough from PowerVM that it
>> might confuse guests, but either way.
>

I really need to understand how it would confuse the guests,
it does not deviate from the PCIe spec, it only adds some restrictions.

> Those guidelines have been developed with q35/mach-virt in
> mind[1], so I wouldn't at all be surprised if they didn't
> apply to pseries guests. And in fact, we just found out
> that they don't!
>
> My point is that we could easily create a similar document
> for pseries guests, and then libvirt will be able to pick
> up whatever recommendations we come up with just like it
> did for q35/mach-virt.
>
>> Can you send me a link to that
>> document though, which might help me figure this out.
>
> It's docs/pcie.txt in QEMU's git repository.
>
>
> [1] Even though I now realize that this is not immediately
>     clear by looking at the document itself


I kind of miss the core issue, what is the main problem?

Thanks,
Marcel

> --
> Andrea Bolognani / Red Hat / Virtualization
>
