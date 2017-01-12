Received: from eggs.gnu.org ([2001:4830:134:3::10]:40100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1cRjZD-0003pP-9d
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:53:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laine@redhat.com>) id 1cRjZ8-0006tB-DL
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:53:39 -0500
References: <20170105054618.GA12106@umbus.fritz.box>
	<1483724069.4199.80.camel@redhat.com>
	<20170108234621.GB12515@umbus.fritz.box>
	<1484217095.7948.1.camel@redhat.com>
	<bdc8e732-f2e9-ff08-9a0b-30ac16cbd9c2@redhat.com>
	<148423893781.24341.140388976706291486@loki>
From: Laine Stump <laine@redhat.com>
Message-ID: <75e2809a-dab3-15f8-d125-3d2def5ebeeb@redhat.com>
Date: Thu, 12 Jan 2017 12:53:28 -0500
MIME-Version: 1.0
In-Reply-To: <148423893781.24341.140388976706291486@loki>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Proposal PCI/PCIe device placement on PAPR guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: libvir-list@redhat.com
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>, Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, thuth@redhat.com, lvivier@redhat.com, benh@kernel.crashing.org, marcel@redhat.com, aik@ozlabs.ru, groug@kaod.org, ehabkost@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alex Williamson <Alex.Williamson@redhat.com>Marcel Apfelbaum <marcel@redhat.com>

On 01/12/2017 11:35 AM, Michael Roth wrote:
> Quoting Laine Stump (2017-01-12 08:52:10)
>> On 01/12/2017 05:31 AM, Andrea Bolognani wrote:
>>> On Mon, 2017-01-09 at 10:46 +1100, David Gibson wrote:
>>>>>>     * To allow for hotplugged devices, libvirt should also add a number
>>>>>>       of additional, empty vPHBs (the PAPR spec allows for hotplug of
>>>>>>       PHBs, but this is not yet implemented in qemu).
>>>>>
>>>>> "A number" here will have to mean "one", same number of
>>>>> empty PCIe Root Ports libvirt will add to a newly-defined
>>>>> q35 guest.
>>>>
>>>> Umm.. why?
>>>
>>> Because some applications using libvirt would inevitably
>>> start relying on the fact that such spare PHBs are
>>> available, locking us into providing at least the same
>>> number forever. In other words, increasing the amount at
>>> a later time is always possible, but decreasing it isn't.
>>> We did the same when we started automatically adding PCIe
>>> Root Ports to q35 machines.
>>>
>>> The rationale is that having a single spare hotpluggable
>>> slot is extremely convenient for basic usage, eg. a simple
>>> guest created by someone who's not necessarily very
>>> familiar with virtualization; on the other hand, if you
>>> are actually deploying in production you ought to conduct
>>> proper capacity planning and figure out in advance how
>>> many devices you're likely to need to hotplug throughout
>>> the guest's life.
>>
>> And of course the reason we don't want to add "too many" extra
>> controllers by default is so that we don't end up with *all* guests
>> burdened with extra hardware they don't need or want. The libguestfs
>> appliance is one example of a libvirt consumer that definitely doesn't
>> want extra baggage in its guests - guest startup time is very important
>> to libguestfs, so any addition to the hardware list is looked upon with
>> disappointment.
>>
>>>
>>> Of course this all will be moot once we can hotplug PHBs :)
>>
>> Will the guest OSes handle that properly? I remember being told that
>
> I believe on pseries we *do* scan for devices on the PHB as part of
> bringing the PHB online in the hotplug path. But I'm not sure that
> matters (see below).
>
>> Linux, for example, doesn't scan the new bus for devices when a new
>> controller is added, making it pointless to hotplug a PCI controller (as
>> usual, it could be that I'm remembering incorrectly...)
>>
>
> Wouldn't that only be an issue if we hotplugged a PHB that already had
> PCI devices on the bus?


Yeah you're right, I'm probably remembering the wrong problem and wrong 
reason for the problem. I just remember there was *some* issue about 
hotplugging new PCI controllers. Possibly the internal representation of 
the bus hierarchy wasn't updated unless you forced a rescan of all the 
devices or something? My memory of it is vague, I just remember being 
told it wasn't just a case of the controller itself being initialized.

Alex or Marcel - since whatever it was I likely heard it from one of you 
(or imagined it in a dream), can you straighten me out?

> That only seems possible if we had a way to
> signal phb hotplug *after* we've hotplugged some PCI devices on the bus,
> which means we'd need some interface to trigger hotplug  beyond the
> standard 'device_add' calls, e.g.:
>
>   device_add spapr-pci-host-bridge,hotplug-deferred=true,id=phb2,index=2
>   device_add virtio-net-pci,bus=phb2.0,...,hotplug-deferred=true
>   device_signal_hotplug phb2
>
> That's actually akin to how it's normally done on pHyp (not only for PHB
> hotplug, but for PCI hotplug in general, which is why this could be
> reasonably expected to work on pseries guests), but it seems quite a bit
> different from how we'd normally handle this on kvm, which I think would
> be something more like:
>
>   device_add spapr-pci-host-bridge,id=phb2,index=2
>   <wait for hotplug completion event>
>   device_add virtio-net-pci,bus=phb2.0,...
>
> In which case it doesn't really matter if the guest scans the bus at
> hotplug time or not. Is there some other scenario where this might
> arise?
>
