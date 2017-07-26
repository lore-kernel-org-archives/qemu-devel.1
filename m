Received: from eggs.gnu.org ([2001:4830:134:3::10]:35004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1daO7D-0004wK-Ud
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:20:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1daO79-000682-Rd
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:20:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lersek@redhat.com>) id 1daO79-00067o-BR
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 11:20:43 -0400
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<d0bd04f4-1ac4-0e3a-885f-2ceb6180f69a@redhat.com>
	<dfb9663b-c31b-2def-9df6-754fb18bb27f@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <b3936955-d84a-d2ba-e1a0-3ca90547ece7@redhat.com>
Date: Wed, 26 Jul 2017 17:20:31 +0200
MIME-Version: 1.0
In-Reply-To: <dfb9663b-c31b-2def-9df6-754fb18bb27f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH v2 0/4] Allow RedHat PCI bridges
 reserve more buses than necessary during init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, kraxel@redhat.com
Cc: seabios@seabios.org, kevin@koconnor.net, qemu-devel@nongnu.org, konrad.wilk@oracle.com, mst@redhat.com

On 07/26/17 08:48, Marcel Apfelbaum wrote:
> On 25/07/2017 18:46, Laszlo Ersek wrote:

[snip]

>> (2) Bus range reservation, and hotplugging bridges. What's the
>> motivation? Our recommendations in "docs/pcie.txt" suggest flat
>> hierarchies.
>>
> 
> It remains flat. You have one single PCIE-PCI bridge plugged
> into a PCIe Root Port, no deep nesting.
> 
> The reason is to be able to support legacy PCI devices without
> "committing" with a DMI-PCI bridge in advance. (Keep Q35 without)
> legacy hw.
> 
> The only way to support PCI devices in Q35 is to have them cold-plugged
> into the pcie.0 bus, which is good, but not enough for expanding the
> Q35 usability in order to make it eventually the default
> QEMU x86 machine (I know this is another discussion and I am in
> minority, at least for now).
> 
> The plan is:
> Start Q35 machine as usual, but one of the PCIe Root Ports includes
> hints for firmware needed t support legacy PCI devices. (IO Ports range,
> extra bus,...)
> 
> Once a pci device is needed you have 2 options:
> 1. Plug a PCIe-PCI bridge into a PCIe Root Port and the PCI device
>    in the bridge.
> 2. Hotplug a PCIe-PCI bridge into a PCIe Root Port and then hotplug
>    a PCI device into the bridge.

Thank you for the explanation, it makes the intent a lot clearer.

However, what does the hot-pluggability of the PCIe-PCI bridge buy us?
In other words, what does it buy us when we do not add the PCIe-PCI
bridge immediately at guest startup, as an integrated device?

Why is it a problem to "commit" in advance? I understand that we might
not like the DMI-PCI bridge (due to it being legacy), but what speaks
against cold-plugging the PCIe-PCI bridge either as an integrated device
in pcie.0 (assuming that is permitted), or cold-plugging the PCIe-PCI
bridge in a similarly cold-plugged PCIe root port?

I mean, in the cold-plugged case, you use up two bus numbers at the
most, one for the root port, and another for the PCIe-PCI bridge. In the
hot-plugged case, you have to start with the cold-plugged root port just
the same (so that you can communicate the bus number reservation *at
all*), and then reserve (= use up in advance) the bus number, the IO
space, and the MMIO space(s). I don't see the difference; hot-plugging
the PCIe-PCI bridge (= not committing in advance) doesn't seem to save
any resources.

I guess I would see a difference if we reserved more than one bus number
in the hotplug case, namely in order to support recursive hotplug under
the PCIe-PCI bridge. But, you confirmed that we intend to keep the flat
hierarchy (ie the exercise is only for enabling legacy PCI endpoints,
not for recursive hotplug).  The PCIe-PCI bridge isn't a device that
does anything at all on its own, so why not just coldplug it? Its
resources have to be reserved in advance anyway.

So, thus far I would say "just cold-plug the PCIe-PCI bridge at startup,
possibly even make it an integrated device, and then you don't need to
reserve bus numbers (and other apertures)".

Where am I wrong?

[snip]

>> (4) Whether the reservation size should be absolute or relative (raised
>> by Gerd). IIUC, Gerd suggests that the absolute aperture size should be
>> specified (as a minimum), not the increment / reservation for hotplug
>> purposes.
>>
>> The Platform Initialization Specification, v1.6, downloadable at
>> <http://www.uefi.org/specs>, writes the following under
>>
>>    EFI_PCI_HOT_PLUG_INIT_PROTOCOL.GetResourcePadding()
>>
>> in whose implementation I will have to parse the values from the
>> capability structure, and return the appropriate representation to the
>> platform-independent PciBusDxe driver (i.e., the enumeration /
>> allocation agent):
>>
>>> The padding is returned in the form of ACPI (2.0 & 3.0) resource
>>> descriptors. The exact definition of each of the fields is the same as
>>> in the
>>> EFI_PCI_HOST_BRIDGE_RESOURCE_ALLOCATION_PROTOCOL.SubmitResources()
>>> function. See the section 10.8 for the definition of this function.
>>>
>>> The PCI bus driver is responsible for adding this resource request to
>>> the resource requests by the physical PCI devices. If Attributes is
>>> EfiPaddingPciBus, the padding takes effect at the PCI bus level. If
>>> Attributes is EfiPaddingPciRootBridge, the required padding takes
>>> effect at the root bridge level. For details, see the definition of
>>> EFI_HPC_PADDING_ATTRIBUTES in "Related Definitions" below.
>>
>> Emphasis on "*adding* this resource request to the resource requests by
>> the physical PCI devices".
>>
>> However... After checking some OVMF logs, it seems that in practice,
>> PciBusDxe does exactly what Gerd suggests.
>>
>> Currently OVMF returns a constant 2MB MMIO padding and a constant 512B
>> IO padding for all hotplug-capable bridges (including PCI Express root
>> ports), from GetResourcePadding(). For example, for the following QEMU
>> command line fragment:
>>
>>    -device
>> pxb-pcie,bus_nr=64,id=rootbr1,numa_node=1,bus=pcie.0,addr=0x3 \
>>    \
>>    -device ioh3420,id=rootbr1-port1,bus=rootbr1,addr=0x1,slot=3 \
>>    -device e1000e,bus=rootbr1-port1,netdev=net0 \
>>    \
>>    -device ioh3420,id=rootbr1-port2,bus=rootbr1,addr=0x2,slot=4 \
>>    -device e1000e,bus=rootbr1-port2,netdev=net1 \
>>
>> PciBusDxe produces the following log (extract):
>>
>>> PciBus: Resource Map for Root Bridge PciRoot(0x40)
>>> Type =   Io16; Base = 0x8000;   Length = 0x2000;        Alignment =
>>> 0xFFF
>>>     Base = 0x8000;       Length = 0x1000;        Alignment =
>>> 0xFFF;      Owner = PPB [40|02|00:**]
>>>     Base = 0x9000;       Length = 0x1000;        Alignment =
>>> 0xFFF;      Owner = PPB [40|01|00:**]
>>> Type =  Mem32; Base = 0x98600000;       Length = 0x400000;     
>>> Alignment = 0x1FFFFF
>>>     Base = 0x98600000;   Length = 0x200000;      Alignment =
>>> 0x1FFFFF;   Owner = PPB [40|02|00:**]
>>>     Base = 0x98800000;   Length = 0x200000;      Alignment =
>>> 0x1FFFFF;   Owner = PPB [40|01|00:**]
>>>
>>> PciBus: Resource Map for Bridge [40|01|00]
>>> Type =   Io16; Base = 0x9000;   Length = 0x1000;        Alignment =
>>> 0xFFF
>>>     Base = Padding;      Length = 0x200; Alignment = 0x1FF
>>>     Base = 0x9000;       Length = 0x20;  Alignment = 0x1F;      
>>> Owner = PCI [41|00|00:18]
>>> Type =  Mem32; Base = 0x98800000;       Length = 0x200000;     
>>> Alignment = 0x1FFFFF
>>>     Base = Padding;      Length = 0x200000;      Alignment = 0x1FFFFF
>>>     Base = 0x98800000;   Length = 0x20000;       Alignment =
>>> 0x1FFFF;    Owner = PCI [41|00|00:14]
>>>     Base = 0x98820000;   Length = 0x20000;       Alignment =
>>> 0x1FFFF;    Owner = PCI [41|00|00:10]
>>>     Base = 0x98840000;   Length = 0x4000;        Alignment =
>>> 0x3FFF;     Owner = PCI [41|00|00:1C]
>>>
>>> PciBus: Resource Map for Bridge [40|02|00]
>>> Type =   Io16; Base = 0x8000;   Length = 0x1000;        Alignment =
>>> 0xFFF
>>>     Base = Padding;      Length = 0x200; Alignment = 0x1FF
>>>     Base = 0x8000;       Length = 0x20;  Alignment = 0x1F;      
>>> Owner = PCI [42|00|00:18]
>>> Type =  Mem32; Base = 0x98600000;       Length = 0x200000;     
>>> Alignment = 0x1FFFFF
>>>     Base = Padding;      Length = 0x200000;      Alignment = 0x1FFFFF
>>>     Base = 0x98600000;   Length = 0x20000;       Alignment =
>>> 0x1FFFF;    Owner = PCI [42|00|00:14]
>>>     Base = 0x98620000;   Length = 0x20000;       Alignment =
>>> 0x1FFFF;    Owner = PCI [42|00|00:10]
>>>     Base = 0x98640000;   Length = 0x4000;        Alignment =
>>> 0x3FFF;     Owner = PCI [42|00|00:1C]
>>
>> This means that
>> - both ioh3420 root ports get a padding of 512B for IO and 2MB fo MMIO,
> 
> So the 512 IO will be reserved even if the IO handling is not enabled
> in the bridge? (I am asking because a similar issue I might have with
> other guest code.)

I apologize for being unclear about the "distribution of work" between
edk2's generic PciBusDxe driver and OVMF's platform-specific
PciHotPlugInitDxe driver (which provides the
EFI_PCI_HOT_PLUG_INIT_PROTOCOL, of which GetResourcePadding() is a
member function).

Basically, PciBusDxe is a platform-independent, universal driver, that
calls into "hooks", optionally provided by the platform, at specific
points in the enumeration / allocation.

EFI_PCI_HOT_PLUG_INIT_PROTOCOL.GetResourcePadding() is such a platform
specific hook, and OVMF is "reasonably free" to provide PciBusDxe with
reservation hints from it, as OVMF sees fit, for any specific hotplug
controller. (Of course OVMF's freedom is limited by two factors: first
by the information that QEMU exposes to firmware, and second by the
"imperative" that in GetResourcePadding() we really shouldn't look at
any *other* PCI(e) controllers than the exact hotplug controller that
PciBusDxe is asking about.)

With that in mind:

*Currently*, OVMF advises PciBusDxe to "reserve 512B of IO space" for
*any* hotplug controller. (From the above log, we can see that on the
root bridge, this 512B are then rounded up to 4KB.)

*In the future*, OVMF should replace the constant 512B with the
following logic: consult the IO base/limit registers of the subject
hotplug controller, and if they are zero, then return "reserve no IO
space for this hotplug controller" to PciBusDxe. If the base/limit
registers are nonzero, OVMF would say "reserve 4KB IO space", or even
propagate the value from the capability.

[snip]

>> The PI spec says,
>>
>>> [...] For all the root HPCs and the nonroot HPCs, call
>>> EFI_PCI_HOT_PLUG_INIT_PROTOCOL.GetResourcePadding() to obtain the
>>> amount of overallocation and add that amount to the requests from the
>>> physical devices. Reprogram the bus numbers by taking into account the
>>> bus resource padding information. [...]
>>
>> However, according to my interpretation of the source code, PciBusDxe
>> does not consider bus number padding for non-root HPCs (which are "all"
>> HPCs on QEMU).
>>
> 
> Theoretically speaking, it is possible to change the  behavior, right?

Not just theoretically; in the past I have changed PciBusDxe -- it
wouldn't identify QEMU's hotplug controllers (root port, downstream port
etc) appropriately, and I managed to get some patches in. It's just that
the less we understand the current code and the more intrusive/extensive
the change is, the harder it is to sell the *idea*. PciBusDxe is
platform-independent and shipped on many a physical system too.

>> So, I agree that we can add a bus number range field to the capability,
>> but I'm fairly sure it won't work with edk2's PciBusDxe without major
>> surgery. (Given that we haven't ever considered hot-plugging entire
>> bridges until now, i.e., anything that would require bus number
>> reservation, I think we can live with such a limitation when using OVMF,
>> for an indefinite time to come.)
>>
> 
> Since the OVMF will still support cold-plug, I think is OK for now.
> Once the feature gets in SeaBIOS I will open a BZ for tracking.

Please do that (at that time); it will certainly need a dedicated
discussion on edk2-devel.

(Also, your statement about cold-plug being viable for at least a while
is consistent with my questions / implications near the top: what does
the hot-pluggability of the PCIe-PCI bridge buy us ultimately?)

Thanks!
Laszlo
