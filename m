Received: from eggs.gnu.org ([2001:4830:134:3::10]:52345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1daG7x-0007nK-0G
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1daG7t-0001uG-RN
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:49:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1daG7t-0001tk-Ha
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 02:48:57 -0400
References: <1500761510-1556-1-git-send-email-zuban32s@gmail.com>
	<d0bd04f4-1ac4-0e3a-885f-2ceb6180f69a@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <dfb9663b-c31b-2def-9df6-754fb18bb27f@redhat.com>
Date: Wed, 26 Jul 2017 09:48:48 +0300
MIME-Version: 1.0
In-Reply-To: <d0bd04f4-1ac4-0e3a-885f-2ceb6180f69a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
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
To: Laszlo Ersek <lersek@redhat.com>, Aleksandr Bezzubikov <zuban32s@gmail.com>, kraxel@redhat.com
Cc: seabios@seabios.org, kevin@koconnor.net, qemu-devel@nongnu.org, konrad.wilk@oracle.com, mst@redhat.com

On 25/07/2017 18:46, Laszlo Ersek wrote:
> On 07/23/17 00:11, Aleksandr Bezzubikov wrote:
>> Now PCI bridges get a bus range number on a system init, basing on
>> currently plugged devices. That's why when one wants to hotplug
>> another bridge, it needs his child bus, which the parent is unable to
>> provide (speaking about virtual device). The suggested workaround is
>> to have vendor-specific capability in Red Hat PCI bridges that
>> contains number of additional bus to reserve on BIOS PCI init. So this
>> capability is intented only for pure QEMU->SeaBIOS usage.
>>
>> Considering all aforesaid, this series is directly connected with
>> QEMU RFC series (v2) "Generic PCIE-PCI Bridge".
>>
>> Although the new PCI capability is supposed to contain various limits
>> along with bus number to reserve, now only its full layout is
>> proposed, but only bus_reserve field is used in QEMU and BIOS. Limits
>> usage is still a subject for implementation as now the main goal of
>> this series to provide necessary support from the  firmware side to
>> PCIE-PCI bridge hotplug.
>>
>> Changes v1->v2:
>> 1. New #define for Red Hat vendor added (addresses Konrad's comment).
>> 2. Refactored pci_find_capability function (addresses Marcel's
>>     comment).
>> 3. Capability reworked:
>> 	- data type added;
>> 	- reserve space in a structure for IO, memory and
>> 	  prefetchable memory limits.
>>
>>
>> Aleksandr Bezzubikov (4):
>>    pci: refactor pci_find_capapibilty to get bdf as the first argument
>>      instead of the whole pci_device
>>    pci: add RedHat vendor ID
>>    pci: add QEMU-specific PCI capability structure
>>    pci: enable RedHat PCI bridges to reserve additional buses on PCI
>>      init
>>
>>   src/fw/pciinit.c    | 18 ++++++++++++++----
>>   src/hw/pci_cap.h    | 23 +++++++++++++++++++++++
>>   src/hw/pci_ids.h    |  2 ++
>>   src/hw/pcidevice.c  | 12 ++++++------
>>   src/hw/pcidevice.h  |  2 +-
>>   src/hw/virtio-pci.c |  4 ++--
>>   6 files changed, 48 insertions(+), 13 deletions(-)
>>   create mode 100644 src/hw/pci_cap.h
>>
> 
> Coming back from PTO, it's hard for me to follow up on all the comments
> that have been made across the v1 and v2 of this RFC series, so I'll
> just provide a brain dump here:
> 

Hi Laszlo,
Thanks for the review.

> (1) Mentioned by Michael: documentation. That's the most important part.
> I haven't seen the QEMU patches, so perhaps they already include
> documentation. If not, please start this work with adding a detailed
> description do QEMU's docs/ or docs/specs/.
> 

I agree is time. Aleksandr, please be sure to document the
PCIE-PCI bridge in docs/pcie.txt

> There are a number of preexistent documents that might be related, just
> search docs/ for filenames with "pci" in them.
> 
> 
> (2) Bus range reservation, and hotplugging bridges. What's the
> motivation? Our recommendations in "docs/pcie.txt" suggest flat
> hierarchies.
> 

It remains flat. You have one single PCIE-PCI bridge plugged
into a PCIe Root Port, no deep nesting.

The reason is to be able to support legacy PCI devices without
"committing" with a DMI-PCI bridge in advance. (Keep Q35 without)
legacy hw.

The only way to support PCI devices in Q35 is to have them cold-plugged
into the pcie.0 bus, which is good, but not enough for expanding the
Q35 usability in order to make it eventually the default
QEMU x86 machine (I know this is another discussion and I am in
minority, at least for now).

The plan is:
Start Q35 machine as usual, but one of the PCIe Root Ports includes
hints for firmware needed t support legacy PCI devices. (IO Ports range,
extra bus,...)

Once a pci device is needed you have 2 options:
1. Plug a PCIe-PCI bridge into a PCIe Root Port and the PCI device
    in the bridge.
2. Hotplug a PCIe-PCI bridge into a PCIe Root Port and then hotplug
    a PCI device into the bridge.



> If this use case is really necessary, I think it should be covered in
> "docs/pcie.txt". In particular it has a consequence for PXB as well
> (search "pcie.txt" for "bus_nr") -- if users employ extra root buses,
> then the bus number partitions that they specify must account for any
> bridges that they plan to hot-plug (and for the bus range reservations
> on the cold-plugged bridges behind those extra root buses).
> 

Agreed about the doc.

> 
> (3) Regarding the contents and the format of the capability structure, I
> wrote up my thoughts earlier in
> 
>    https://bugzilla.redhat.com/show_bug.cgi?id=1434747#c8
> 
> Let me quote it here for ease of commenting:
> 
>> (In reply to Gerd Hoffmann from comment #7)
>>> So, now that the generic ports are there we can go on figure how to
>>> handle this best.  I still think the best way to communicate window
>>> size hints would be to use a vendor specific pci capability (instead
>>> of setting the desired size on reset).  The information will always
>>> be available then and we don't run into initialization order issues.
>>
>> This seems good to me -- I can't promise 100% without actually trying,
>> but I think I should be able to parse the capability list in config
>> space for this hint, in the GetResourcePadding() callback.
>>
>> I propose that we try to handle this issue "holistically", together
>> with bug 1434740. We need a method that provides controls for both IO
>> and MMIO:
>>
>> - For IO, we need a mechanism that can prevent *both* firmware *and*
>>    Linux from reserving IO for PCI Express ports. I think Marcel's
>>    approach in bug 1344299 is sufficient, i.e., set the IO base/limit
>>    registers of the bridge to 0 for disabling IO support. And, if not
>>    disabled, just go with the default 4KB IO reservation (for both PCI
>>    Express ports and legacy PCI bridges, as the latter is documented in
>>    the guidelines).
>>

I have some patches on this, however I remember guests miss-behaving,
but maybe is a bug on my part... .
However we can use the IO hint to reserve less than 4KB IO windows.

>> - For MMIO, the vendor specific capability structure should work
>>    something like this:
>>      - if the capability is missing, reserve 2MB, 32-bit,
>>        non-prefetchable,
>>
>>      - otherwise, the capability structure should consist of 3 fields
>>        (reservation sizes):
>>          - uint32_t non_prefetchable_32,
>>          - uint32_t prefetchable_32,
>>          - uint64_t prefetchable_64,
>>
>>      - of prefetchable_32 and prefetchable_64, at most one may be
>>        nonzero (they are mutually exclusive, and they can be both
>>        zero),
>>
>>      - whenever a field is 0, that kind of reservation is not needed.
> 
> This would now have to be extended with bus range reservation.
> 

Agreed, please be aware that as part of Alexander's project he will
prepare the capability, but implement only the bus-numbers reservation
part.

> 
> (4) Whether the reservation size should be absolute or relative (raised
> by Gerd). IIUC, Gerd suggests that the absolute aperture size should be
> specified (as a minimum), not the increment / reservation for hotplug
> purposes.
> 
> The Platform Initialization Specification, v1.6, downloadable at
> <http://www.uefi.org/specs>, writes the following under
> 
>    EFI_PCI_HOT_PLUG_INIT_PROTOCOL.GetResourcePadding()
> 
> in whose implementation I will have to parse the values from the
> capability structure, and return the appropriate representation to the
> platform-independent PciBusDxe driver (i.e., the enumeration /
> allocation agent):
> 
>> The padding is returned in the form of ACPI (2.0 & 3.0) resource
>> descriptors. The exact definition of each of the fields is the same as
>> in the
>> EFI_PCI_HOST_BRIDGE_RESOURCE_ALLOCATION_PROTOCOL.SubmitResources()
>> function. See the section 10.8 for the definition of this function.
>>
>> The PCI bus driver is responsible for adding this resource request to
>> the resource requests by the physical PCI devices. If Attributes is
>> EfiPaddingPciBus, the padding takes effect at the PCI bus level. If
>> Attributes is EfiPaddingPciRootBridge, the required padding takes
>> effect at the root bridge level. For details, see the definition of
>> EFI_HPC_PADDING_ATTRIBUTES in "Related Definitions" below.
> 
> Emphasis on "*adding* this resource request to the resource requests by
> the physical PCI devices".
> 
> However... After checking some OVMF logs, it seems that in practice,
> PciBusDxe does exactly what Gerd suggests.
> 
> Currently OVMF returns a constant 2MB MMIO padding and a constant 512B
> IO padding for all hotplug-capable bridges (including PCI Express root
> ports), from GetResourcePadding(). For example, for the following QEMU
> command line fragment:
> 
>    -device pxb-pcie,bus_nr=64,id=rootbr1,numa_node=1,bus=pcie.0,addr=0x3 \
>    \
>    -device ioh3420,id=rootbr1-port1,bus=rootbr1,addr=0x1,slot=3 \
>    -device e1000e,bus=rootbr1-port1,netdev=net0 \
>    \
>    -device ioh3420,id=rootbr1-port2,bus=rootbr1,addr=0x2,slot=4 \
>    -device e1000e,bus=rootbr1-port2,netdev=net1 \
> 
> PciBusDxe produces the following log (extract):
> 
>> PciBus: Resource Map for Root Bridge PciRoot(0x40)
>> Type =   Io16; Base = 0x8000;   Length = 0x2000;        Alignment = 0xFFF
>>     Base = 0x8000;       Length = 0x1000;        Alignment = 0xFFF;      Owner = PPB [40|02|00:**]
>>     Base = 0x9000;       Length = 0x1000;        Alignment = 0xFFF;      Owner = PPB [40|01|00:**]
>> Type =  Mem32; Base = 0x98600000;       Length = 0x400000;      Alignment = 0x1FFFFF
>>     Base = 0x98600000;   Length = 0x200000;      Alignment = 0x1FFFFF;   Owner = PPB [40|02|00:**]
>>     Base = 0x98800000;   Length = 0x200000;      Alignment = 0x1FFFFF;   Owner = PPB [40|01|00:**]
>>
>> PciBus: Resource Map for Bridge [40|01|00]
>> Type =   Io16; Base = 0x9000;   Length = 0x1000;        Alignment = 0xFFF
>>     Base = Padding;      Length = 0x200; Alignment = 0x1FF
>>     Base = 0x9000;       Length = 0x20;  Alignment = 0x1F;       Owner = PCI [41|00|00:18]
>> Type =  Mem32; Base = 0x98800000;       Length = 0x200000;      Alignment = 0x1FFFFF
>>     Base = Padding;      Length = 0x200000;      Alignment = 0x1FFFFF
>>     Base = 0x98800000;   Length = 0x20000;       Alignment = 0x1FFFF;    Owner = PCI [41|00|00:14]
>>     Base = 0x98820000;   Length = 0x20000;       Alignment = 0x1FFFF;    Owner = PCI [41|00|00:10]
>>     Base = 0x98840000;   Length = 0x4000;        Alignment = 0x3FFF;     Owner = PCI [41|00|00:1C]
>>
>> PciBus: Resource Map for Bridge [40|02|00]
>> Type =   Io16; Base = 0x8000;   Length = 0x1000;        Alignment = 0xFFF
>>     Base = Padding;      Length = 0x200; Alignment = 0x1FF
>>     Base = 0x8000;       Length = 0x20;  Alignment = 0x1F;       Owner = PCI [42|00|00:18]
>> Type =  Mem32; Base = 0x98600000;       Length = 0x200000;      Alignment = 0x1FFFFF
>>     Base = Padding;      Length = 0x200000;      Alignment = 0x1FFFFF
>>     Base = 0x98600000;   Length = 0x20000;       Alignment = 0x1FFFF;    Owner = PCI [42|00|00:14]
>>     Base = 0x98620000;   Length = 0x20000;       Alignment = 0x1FFFF;    Owner = PCI [42|00|00:10]
>>     Base = 0x98640000;   Length = 0x4000;        Alignment = 0x3FFF;     Owner = PCI [42|00|00:1C]
> 
> This means that
> - both ioh3420 root ports get a padding of 512B for IO and 2MB fo MMIO,

So the 512 IO will be reserved even if the IO handling is not enabled
in the bridge? (I am asking because a similar issue I might have with
other guest code.)

> - the actual resources for each e1000e NIC on the respective ioh3420
>    root port are allocated *within* the padding,
> - because each MMIO padding is larger than the actual resource needs of
>    the respective e1000e NIC, it is the MMIO paddings that are ultimately
>    considered on the root bridge,
> - additionally, the 0x200 IO paddings are rounded up to 0x1000 on the
>    root bridge.
> 
> So, it seems that PciBusDxe
> - conflicts with the Platform Initialization spec, but
> - at the same time it seems to do what Gerd is suggesting.
> 
> 
> (5) Returning to bus range reservation... This looks problematic with
> edk2.
> 
> * Some background first:
> 
> In the Platform Init spec, two kinds of hotplug controllers are
> distinguished: "root" and "non-root". This naming is confusing because
> in this context, "root" simply means
> 
>    cannot be found by normal enumeration, or needs special initialization
>    when found before recursing it
> 
> whereas "non-root" means
> 
>    can be found by normal enumeration and needs no special initialization
>    before recursing it
> 
> In this context, QEMU does not provide any "root" hotplug controllers,
> because all the controllers that support hotplug -- i.e., can *accept* a
> hot-plugged device -- *can* be found with enumeration, and need no
> platform-specific initialization callback:
> - PCI Express root ports
> - PCI Express downstream ports
> - PCI-PCI Bridges
> 
> Now, if a platform provides "root" (in the above context) hotplug
> controllers, then the platform's
> 
>    EFI_PCI_HOT_PLUG_INIT_PROTOCOL.GetRootHpcList()
> 
> method has to return them. (Importantly, this function has to return the
> list of "root HPCs" *without* accessing PCI config space, using
> "apriori" knowledge.) Accordingly to the QEMU situation, OVMF returns an
> empty list here.
> 
> * Why this is a problem:
> 
> For "non-root" (in the above sense) hotplug controllers, PciBusDxe
> considers the IO and MMIO paddings, but it does *not* consider bus
> number paddings, even if
> EFI_PCI_HOT_PLUG_INIT_PROTOCOL.GetResourcePadding() returns some. (As
> far as I can see from the source -- I have never tested it, obviously.)
> For QEMU, this means all of the hotplug controllers.
> 
> For "root" (in the above sense) hotplug controllers, PciBusDxe considers
> bus number paddings. However, on QEMU, this set of controllers is empty.
> 
> The PI spec says,
> 
>> [...] For all the root HPCs and the nonroot HPCs, call
>> EFI_PCI_HOT_PLUG_INIT_PROTOCOL.GetResourcePadding() to obtain the
>> amount of overallocation and add that amount to the requests from the
>> physical devices. Reprogram the bus numbers by taking into account the
>> bus resource padding information. [...]
> 
> However, according to my interpretation of the source code, PciBusDxe
> does not consider bus number padding for non-root HPCs (which are "all"
> HPCs on QEMU).
> 

Theoretically speaking, it is possible to change the  behavior, right?

> So, I agree that we can add a bus number range field to the capability,
> but I'm fairly sure it won't work with edk2's PciBusDxe without major
> surgery. (Given that we haven't ever considered hot-plugging entire
> bridges until now, i.e., anything that would require bus number
> reservation, I think we can live with such a limitation when using OVMF,
> for an indefinite time to come.)
> 

Since the OVMF will still support cold-plug, I think is OK for now.
Once the feature gets in SeaBIOS I will open a BZ for tracking.

Thanks,
Marcel


> Thanks
> Laszlo
> 
