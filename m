Received: from eggs.gnu.org ([2001:4830:134:3::10]:57005)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <justsendmailnothingelse@gmail.com>)
	id 1cDybG-000615-Kx
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 14:06:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <justsendmailnothingelse@gmail.com>)
	id 1cDybE-0002LD-8U
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 14:06:54 -0500
Sender: sendmail <justsendmailnothingelse@gmail.com>
References: <1477641400-23292-1-git-send-email-aik@ozlabs.ru>
	<20161028120712.4a911866@bahia>
	<20161031025314.GJ18226@umbus.fritz.box>
	<ee1d7da4-373c-4be0-7e67-897a1c90042f@ozlabs.ru>
	<20161101024634.GA14860@umbus.fritz.box>
	<1479218565.3319.18.camel@redhat.com>
	<3353ecef-2308-13e3-025d-df41b2e89945@ozlabs.ru>
	<1479457042.1391.11.camel@redhat.com>
	<20161123050049.GD17795@umbus.fritz.box>
	<1480081581.4367.65.camel@redhat.com>
	<20161202041835.GF10089@umbus.fritz.box>
From: Laine Stump <laine@laine.org>
Message-ID: <cbd089a4-3ccb-e9ab-64f9-85ef47c3151f@laine.org>
Date: Mon, 5 Dec 2016 14:06:43 -0500
MIME-Version: 1.0
In-Reply-To: <20161202041835.GF10089@umbus.fritz.box>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [libvirt] [Qemu-ppc] [RFC PATCH qemu] spapr_pci:
 Create PCI-express root bus by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, Andrea Bolognani <abologna@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, benh@kernel.crashing.org, Greg Kurz <groug@kaod.org>, qemu-devel@nongnu.org, libvir-list@redhat.com, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Jaroslav Suchanek <jsuchane@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

On 12/01/2016 11:18 PM, David Gibson wrote:
> On Fri, Nov 25, 2016 at 02:46:21PM +0100, Andrea Bolognani wrote:
>> On Wed, 2016-11-23 at 16:00 +1100, David Gibson wrote:
>>>> Existing libvirt versions assume that pseries guests have
>>>> a legacy PCI root bus, and will base their PCI address
>>>> allocation / PCI topology decisions on that fact: they
>>>> will, for example, use legacy PCI bridges.
>>>   
>>> Um.. yeah.. trouble is libvirt's PCI-E address allocation probably
>>> won't work for spapr PCI-E either, because of the weird PCI-E without
>>> root complex presentation we get in PAPR.
>> So, would the PCIe Root Bus in a pseries guest behave
>> differently than the one in a q35 or mach-virt guest?
> Yes.  I had a long discussion with BenH and got a somewhat better idea
> about this.
>
> If only a single host PE (== iommu group) is passed through and there
> are no emulated devices, the difference isn't too bad: basically on
> pseries you'll see the subtree that would be below the root complex on
> q35.
>
> But if you pass through multiple groups, things get weird.  On q35,
> you'd generally expect physically separate (different slot) devices to
> appear under separate root complexes.  Whereas on pseries they'll
> appear as siblings on a virtual bus (which makes no physical sense for
> point-to-point PCI-E).
>
> I suppose we could try treating all devices on pseries as though they
> were chipset builtin devices on q35, which will appear on the root
> PCI-E bus without root complex.  But I suspect that's likely to cause
> trouble with hotplug, and it will certainly need different address
> allocation from libvirt.
>
>> Does it have a different number of slots, do we have to
>> plug different controllers into them, ...?
>>
>> Regardless of how we decide to move forward with the
>> PCIe-enabled pseries machine type, libvirt will have to
>> know about this so it can behave appropriately.
> So there are kind of two extremes of how to address this.  There are a
> variety of options in between, but I suspect they're going to be even
> more muddled and hideous than the extremes.
>
> 1) Give up.  You said there's already a flag that says a PCI-E bus is
> able to accept vanilla-PCI devices.  We add a hack flag that says a
> vanilla-PCI bus is able to accept PCI-E devices.  We keep address
> allocation as it is now - the pseries topology really does resemble
> vanilla-PCI much better than it does PCI-E. But, we allow PCI-E
> devices, and PAPR has mechanisms for accessing the extended config
> space.  PCI-E standard hotplug and error reporting will never work,
> but PAPR provides its own mechanisms for those, so that should be ok.
>
> 2) Start exposing the PCI-E heirarchy for pseries guests much more
> like q35, root complexes and all.  It's not clear that PAPR actually
> *forbids* exposing the root complex, it just doesn't require it and
> that's not what PowerVM does.  But.. there are big questions about
> whether existing guests will cope with this or not.  When you start
> adding in multiple passed through devices and particularly virtual
> functions as well, things could get very ugly - we might need to
> construct multiple emulated virtual root complexes or other messes.
>
> In the short to medium term, I'm thinking option (1) seems pretty
> compelling.
>
>>>>> I believe after we introduced the very first
>>>>> pseries-pcie-X.Y, we will just stop adding new pseries-X.Y.
>>>>   
>>>> Isn't i440fx still being updated despite the fact that q35
>>>> exists? Granted, there are a lot more differences between
>>>> those two machine types than just the root bus type.
>>>   
>>> Right, there are heaps of differences between i440fx and q35, and
>>> reasons to keep both updated.  For pseries we have neither the impetus
>>> nor the resources to maintain two different machine type variant,
>>> where the only difference is between legacy PCI and weirdly presented
>>> PCI-E.
>> Calling the PCIe machine type either pseries-2.8 or
>> pseries-pcie-2.8 would result in the very same amount of
>> work, and in both cases it would be understood that the
>> legacy PCI machine type is no longer going to be updated,
>> but can still be used to run existing guests.
> So, I'm not sure if the idea of a new machine type has legs or not,
> but let's think it through a bit further.  Suppose we have a new
> machine type, let's call it 'papr'.  I'm thinking it would be (at
> least with -nodefaults) basically a super-minimal version of pseries:
> so each PHB would have to be explicitly created, the VIO bridge would
> have to be explicitly created, likewise the NVRAM.  Not sure about the
> "devices" which really represent firmware features - the RTC, RNG,
> hypervisor event source and so forth.
>
> Might have some advantages.  Then again, it doesn't really solve the
> specific problem here.  It means libvirt (or the user) has to
> explicitly choose a PCI or PCI-E PHB to put things on, but libvirt's
> PCI-E address allocation will still be wrong in all probability.

That's a broad statement. Why? If qemu reports the default devices and 
characteristics of the devices properly (and libvirt uses that 
information) there's no reason for it to make the wrong decision.

>
> Guh.
>
>
> As an aside, here's a RANT.
>
> libvirt address allocation.  Seriously, W. T. F!
>
> libvirt insists on owning address allocation.  That's so it can
> recreate the exact same machine at the far end of a migration.  So far
> so good, except it insists on recording that information in the domain
> XML in kinda-sorta-but-not-really back end independent form.

Explain "kinda-sorta-but-not-really". If there's a deficiency in the 
model maybe it can be fixed.


>   But the
> thing is libvirt fundamentally CAN NOT get this right.

True, but not for the reasons you think. If qemu is able to respond to 
queries with adequate details about the devices available for a 
machinetype (and what buses are in place by default), there's no reason 
that libvirt can't add devices addressed such that all the connections 
are legal; what libvirt *can't* get right is the policy requested in the 
next higher layer of management (and ultimately of the user) - does this 
device need to be hotpluggable? Does the user want to keep all devices 
on the root complex to avoid extra PCI controllers?

And qemu fundamentally CAN NOT get it right either. qemu knows what is 
possible and what is allowed, but it doesn't know what the user *wants* 
(beyond "they want device X", which is only 1/2 the story), and has no 
way of being told what the user wants other than with a PCI address.

To back up for a minute, some background info: once a device has been 
added to a domain, at *any* time in the future (not just during a 
migration, but forever more until the end of time) that device must 
always have the same PCI address as it had that first time. In order to 
guarantee that, libvirt needs to either:

a) keep track of the order the devices were added and always put the 
devices in the same order on the commandline (assuming that qemu 
guarantees that it actually assigns addresses based on the order of the 
devices' appearance on the commandline, which has never been stated 
anywhere as an API guarantee of qemu),

or

b) remember the address of each device as it is added and specify that 
on the commandline in the future. libvirt chooses (b). And where is the 
logical place to store that address? In the config.

So we've established that the PCI address of a device needs to be stored 
in the config. So why does libvirt need to choose it the first time?

1) Because qemu doesn't have (and CAN NOT have) all the information 
about what are the user's plans for that device:

   a) It has no idea if the user wants that device to be hotpluggable 
(on a root-port)
       or not (on root complex as an integrated device)

   b) it doesn't know if the user wants the device to be placed on an 
expander bus
       so that its NUMA status can be discovered by the guest OS.

If there is a choice, there must be a way to make that choice. The way 
that qemu provides to make the choice is by specifying an address. So 
libvirt must specify an address in its config.

2) Because qemu is unable/unwilling to automatically add PCIe root ports 
when necessary, it's *not even possible* (on PCIe machinetypes) for it 
to place a device on a hotpluggable port without libvirt specifying a 
PCI address the very first time the device is added (and also adding in 
a root-port), but libvirt's default policy is that (almost) all devices 
should be hotpluggable. If we were to follow your recommendation 
("libvirt never specifies PCI addresses, but instead allows qemu to 
assign them"), hotplug on PCIe-based machinetypes would not be possible, 
though.

There have even been mentions that even libvirt is too *low* in the 
stack to be specifying the PCI address of devices (i.e. that all PCI 
address decisions should be up to higher level management applications) 
- I had posted a patch that would allow specifying 
"hotpluggable='yes|no'" in the XML rather than forcing the call to 
specify an address, and this was NACKed because it was seen as libvirt 
dictating policy. (In the end, libvirt *does* dictate a default policy, 
(it's just that the only way to modify that policy is by manually 
specifying addresses) - libvirt's default PCI address policy is that 
(almost) all devices will be assigned an address that makes them 
hotpluggable, and will not be placed on a non-0 NUMA node.

So, in spite of libvirt's effort, in the end we *still* need to expose 
address configuration to higher level management applications, since 
they may want to force all devices onto the root complex (e.g. 
libguestfs, which does it to reduce PCI controller count, and thus 
startup time) or force certain devices to be on a non-0 NUMA node (e.g. 
OpenStack when it wants to place a VFIO assigned device on the same NUMA 
node in the guest as it is in the host).

With all of that, I fail to see how it would be at all viable to simply 
leave PCI address assignment up to qemu.


> There are all
> sorts of possible machine specific address allocation constraints that
> can exist - from simply which devices are already created by default
> (for varying values of "default") to complicated constraints depending
> on details of board wiring.  The back end has to know about these - it
> implements them.

And since qemu knows about them, it should be able to report them. Which 
is what Eduardo's work is doing. And then libvirt will know about all 
the constraints in an programmatic manner (rather than the horrible 
(tedious, error prone) hardcoding of all those details that we've had to 
suffer with until now).

>   The ONLY way libvirt can get this (temporarily)
> right is by duplicating a huge chunk of the back end's allocation
> logic, which will inevitably get out of date causing problems just
> like this.
>
> Basically the back end will *always* have better information about how
> to place devices than libvirt can.

And since no matter how hard qemu might try to come up with a policy for 
address assignment that will satisfy the needs of 100% of the users 100% 
of the time, it will fail (because different users have different 
needs). Because qemu will be unable to properly place all devices all 
the time, libvirt (and higher level management) will still need to do 
it. Even in the basic case qemu doesn't provide what libvirt requires as 
default - that devices be hotpluggable.

>    So, libvirt should be allowing the
> back end to do the allocation, then snapshotting that in a back end
> specific format which can be used for creating migration
> destinations. But that breaks libvirt's the-domain-XML-is-everything
> model.

No, that doesn't work because qemu would in many situations place the 
devices at the wrong address / on the wrong controller, because there 
are many possible topologies that are legal, and the user may (for 
perfectly valid reasons) want something different from what qemu would 
have chosen.

(An example of two differing (and valid) policies - libguestfs needs 
guests to startup as quickly as possible, and thus wants as few PCI 
controllers as possible (this makes a noticeable difference in Linux 
boot time), so it wants all devices to be integrated on the root 
complex. On the other hand, a generic guest in libvirt should make all 
devices hotpluggable just in case the user wants to unplug them, so by 
default it tries to place all devices on a pcie-root-port. You can't 
support both of these if addressing is all left up to qemu)

>
> In this regard libvirt doesn't just have a design flaw, it has design
> flaws which breed more design flaws like pestilent cancer.


It may make you feel good to say that, but the facts don't back it up. 
Any project makes design mistakes, but in the specific case you're 
discussing here, I think you haven't looked from a wide enough viewpoint 
to see the necessity of what libvirt is doing and why it can't be done 
by qemu (certainly not all the time anyway).


>    And what's
> worse the consequences of those design flaws are now making sane
> design decisions increasingly difficult in adjacent projects like
> qemu.

libvirt has always done the best that could be done with the information 
provided by qemu. The problem isn't that libvirt is creating new 
problems for qemu out of thin air, it's that qemu is unable to 
automatically address PCI devices for all possible situations and user 
policy preferences, so higher levels need to make the decisions about 
addressing to satisfy their policies (ie what they *want*, eg 
hotpluggable, integrated on root complex), and qemu hasn't (until 
Eduardo's patches) been able to provide adequate information about what 
is *legal* (e.g which devices can be plugged into which model of pci 
controller, what slots are available on each type of controller, whether 
those slots are hotpluggable) in a programmatic way, so libvirt has had 
to hardcode rules about bus-device compatibility and capabilities, slot 
ranges, etc in order to make proper decisions itself when possible, and 
to sanity-check decisions about addresses made by higher level 
management when not. I don't think that's a design flaw. I think that's 
making the best of a "less than ideal" situation.


> I'd feel better about this if there seemed to be some recognition of
> it, and some necessarily long term plan to improve it, but if there is
> I haven't heard of it.  Or at least the closest thing seems to be
> coming from the qemu side (witness Eduardo's talk at the last KVM
> forum, and mine at the one before).

Eduardo's work isn't being done to make up for some mythical design flaw 
in libvirt. It is being done in order to give libvirt the (previously 
unavailable) information it needs to do a necessary job, and is being 
done at least partly at the request of libvirt (we've certainly been 
demanding some of that stuff for a long time!)

The summary is that it's impossible for qemu to correctly decide where 
to put new devices, especially in a PCIe hierarchy for a few reasons (at 
least); because of this, libvirt (and higher level management) needs to 
be able to assign addresses to devices, and in order for us/them to be 
able to do that properly, qemu needs to provide detailed and accurate 
information about what buses/controllers/devices are in each 
machinetype, what controllers/devices are available to add, and what are 
the legal ways of connecting those devices and controllers.
