Received: from eggs.gnu.org ([2001:4830:134:3::10]:52437)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ceRPb-0001eM-HA
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1ceRPY-0003Cb-Bm
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 14:08:15 -0500
From: Marcel Apfelbaum <marcel@redhat.com>
References: <20170209041634.GC14524@umbus>
	<95706652-0a80-92fc-951b-7a454d496ddf@redhat.com>
	<20170210003746.GP27610@umbus.fritz.box>
	<5ea3785c-b979-8b8c-3ab0-243d69384697@redhat.com>
	<20170213043307.GT25381@umbus>
	<45446029-e404-77d4-754e-5541a506bb7c@redhat.com>
	<20170214041532.GF2169@umbus.fritz.box>
	<c0e368b1-c89d-ef5a-d475-c92266d3eb41@redhat.com>
	<20170215014544.GC12369@umbus.fritz.box>
	<22b4c89b-bfeb-e196-73c3-927115398e5e@redhat.com>
	<20170216024842.GQ12369@umbus.fritz.box>
Message-ID: <4d6ea732-772f-f4f8-22a7-fad7bc9cdf7a@redhat.com>
Date: Thu, 16 Feb 2017 21:07:35 +0200
MIME-Version: 1.0
In-Reply-To: <20170216024842.GQ12369@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] virtio-pci: Allow PCIe virtio devices on
 root bus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Laszlo Ersek <lersek@redhat.com>, abologna@redhat.com, lvivier@redhat.com, thuth@redhat.com, mst@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, kraxel@redhat.com, Eduardo Habkost <ehabkost@redhat.com>

On 02/16/2017 04:48 AM, David Gibson wrote:
> On Wed, Feb 15, 2017 at 04:59:33PM +0200, Marcel Apfelbaum wrote:

[...]

>>>>>
>>>>> I did float the idea of having the pseries PCI bus remain plain PCI
>>>>> but with a special flag to allow PCIe devices to be attached to it
>>>>> anyway.  It wasn't greeted with much enthusiasm..
>>>>>
>>>>
>>>> Can you point me to the discussion please? It seems similar to what I proposed above.
>>>
>>> Sorry, I was misleading.  I think I just raised that idea with Andrea
>>> and a few other people internally, not on one of the lists at large.
>>>
>>>> As you properly described it, is much closer to PCI then PCIe, even the only characteristic
>>>> that makes it "a little" PCIe, the Extended Configuration Space support,
>>>> is done with an alternative interface.
>>>>
>>>> I agree the PAPR bus is not PCIe.
>>>
>>> Ok, so if we take that direction, the question becomes how do we let
>>> PCIe devices plug into this mostly-not-PCIe bus.  Maybe introduce a
>>> "pci_bus_accepts_express()" function that will replace many, but not
>>> all current uses of "pci_bus_is_express()"?
>>>
>>
>> Sounds good and I think Eduardo is already working on exactly this
>> idea, however he is on PTO now. It is better to synchronize with him.
>
> Ah, right.  Do you know when he'll be back?  This is semi-urgent for
> Power.
>

In a week or so.

>

[...]

>>>
>>> Ok.. I'm still missing something.  Are you saying that instead of the
>>> legacy/modern status determining PCIe support, that PCIe status is
>>> determining legacy/modern support by default?
>>
>> Is more a guideline. We want QEMU to behave like this *by default*.
>> The modern spec does not require virtio 1.0 devices to be PCIe.
>
> Ok.  But I'm trying to get a handle on how - even by default - the
> linkage between PCI/PCIe and modern/legacy is created:  it's not
> obvious to me.
>

There is no direct connection between modern/legacy <-> PCI/PCIe.
However the defaults work like that:
I440FX - (pc): devices are PCI, transitional
    created by: disable-legacy=auto,disable-modern=off
    - in virtio_pci_realize disable-legacy: auto => off
Q35 - on root bus - devices are PCI, transitional
     - other buses - devices are PCIe, modern
    created by: disable-legacy=auto,disable-modern=off
    - in virtio_pci_dc_realize:
         if disable-modern=off -> pcie
    - in virtio_pci_realize:
     if on pcie root port -> disable-legacy: auto => on
     otherwise ->    disable-legacy: auto => off


>>   That would actually
>>> seem to simplify things: whatever method we end up allowing PCIe
>>> virtio on PAPR, that should automatically enable modern mode, which is
>>> fine.
>>>
>>
>> Agreed.
>>
>>> Although.. I do wonder about legacy/modern for PAPR in general.
>>> Current kernels will support virtio 1.0 fine, but we have older
>>> released versions which only support legacy.
>>
>> So, do you want legacy virtio devices to be PCIe ?
>
> TBH, we probably don't care one way or another.
>
> I'm not clear here if you're making a distinction between legacy-only
> and legacy+modern virtio instances.
>

Legacy devices and the modern ones are different devices (product ID).
I think the 'transitional' ones have the ID of the modern virtio.

> I think we need to keep legacy support on for Power machines, because
> we don't have the machine type switchover to let us handle it.  But we
> certainly would like to enable modern support so that newer guests can
> exploit it.
>

"transitional" is the right way to go.

Thanks,
Marcel

>>   Unlike PC we won't (I
>>> hope) have a whole machine type switch to handle this.
>>
>> Good for you!
>>
>>   At this stage
>>> I think we want virtio devices (whatever their bus type) on PAPR to
>>> default to allowing both legacy and modern for the forseeable future.
>>> How does that affect the matrix?
>>>
>>
>> It adds a legacy virtio PCIe device to the matrix. For X86 we don't need
>> this combination because PC machines are PCI and Q35 machines are to be used
>> only on modern setups.
>>
>> Since PARP does not have separate machines for PCi and PCIe, we need to live with it.
>>
>>
>>>> XHCI being PCIe on Root Complex is an unintended exception, but we want it connected to a
>>>> Root Port anyway, we don't have anything to gain from having it as Integrated Endpoint.
>>>> We only loose a slot that can be used by 8 Root Ports assembled into one multi-function device.
>>>>
>>>> PAPR bus should not be considered PCIe and should have a different set of rules allowing PCIe
>>>> devices to be plugged into Root Complex.
>>>
>>> Alright, I can work with that.  Michael, Andrea, how does this idea
>>> seem to you?
>>>
>>
>> We should definitely get more opinions.
>> Thanks,
>> Marcel
>>
>
