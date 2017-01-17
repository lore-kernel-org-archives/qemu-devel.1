Received: from eggs.gnu.org ([2001:4830:134:3::10]:38369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cTOUH-0000hY-BD
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 02:47:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ard.biesheuvel@linaro.org>) id 1cTOUF-0004cS-CR
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 02:47:25 -0500
Received: from mail-io0-x22e.google.com ([2607:f8b0:4001:c06::22e]:34110)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ard.biesheuvel@linaro.org>)
	id 1cTOUF-0004cB-2V
	for qemu-devel@nongnu.org; Tue, 17 Jan 2017 02:47:23 -0500
Received: by mail-io0-x22e.google.com with SMTP id l66so108962183ioi.1
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 23:47:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5c6571da-34a7-9a23-e229-88883302d4e9@redhat.com>
References: <1484328738-21149-1-git-send-email-ard.biesheuvel@linaro.org>
	<CAFEAcA-s4To6BCgFzUG6Bs_rpeVupatXpHm45b=26QmLJAwy8A@mail.gmail.com>
	<CAKv+Gu-hAzng0ff4=r2JZF5p=nEhhv12-kwg7wz+m7Uj4w42DA@mail.gmail.com>
	<CAFEAcA8n5grNz+z1ZcNcX9Er9s=uXRPgV-b1-3tkrzWEv-=1Uw@mail.gmail.com>
	<CAKv+Gu_+O-_x-CwQdiTf4efWAMue6LdXK3Afo9YW8Xz+6BFyzw@mail.gmail.com>
	<b6362d69-a544-1b78-fc48-1020e5d0efef@redhat.com>
	<CAKv+Gu_2srdbQhK4LjjsdoOkm_S4hkEFVdtUHmcvAnVZCVErbA@mail.gmail.com>
	<5c6571da-34a7-9a23-e229-88883302d4e9@redhat.com>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date: Tue, 17 Jan 2017 07:47:21 +0000
Message-ID: <CAKv+Gu_Rap-_gnXqF6cRYS+CUvm2QMzxKWnSRNyJ7-wqJcdNGA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] hw/arm/virt-acpi - reserve ECAM space
 as PNP0C02 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Andrew Jones <drjones@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Graeme Gregory <graeme.gregory@linaro.org>, Al Stone <al.stone@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 16 January 2017 at 22:35, Laszlo Ersek <lersek@redhat.com> wrote:
> On 01/16/17 22:23, Ard Biesheuvel wrote:
>> On 16 January 2017 at 21:13, Laszlo Ersek <lersek@redhat.com> wrote:
>>> On 01/16/17 20:31, Ard Biesheuvel wrote:
>>>> On 16 January 2017 at 18:20, Peter Maydell <peter.maydell@linaro.org> =
wrote:
>>>>> On 16 January 2017 at 17:30, Ard Biesheuvel <ard.biesheuvel@linaro.or=
g> wrote:
>>>>>> On 16 January 2017 at 17:25, Peter Maydell <peter.maydell@linaro.org=
> wrote:
>>>>>>> On 13 January 2017 at 17:32, Ard Biesheuvel <ard.biesheuvel@linaro.=
org> wrote:
>>>>>>>> Linux for arm64 v4.10 and later will complain if the ECAM config s=
pace is
>>>>>>>> not reserved in the ACPI namespace:
>>>>>>>>
>>>>>>>>   acpi PNP0A08:00: [Firmware Bug]: ECAM area [mem 0x3f000000-0x3ff=
fffff] not reserved in ACPI namespace
>>>>>>>>
>>>>>>>> The rationale is that OSes that don't consume the MCFG table shoul=
d still
>>>>>>>> be able to infer that the PCI config space MMIO region is occupied=
.
>>>>>>>>
>>>>>>>> So update the ACPI table generation routine to add this reservatio=
n.
>>>>>>>>
>>>>>>>> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>>>>>>>> ---
>>>>>>>>  hw/arm/virt-acpi-build.c | 7 +++++++
>>>>>>>>  1 file changed, 7 insertions(+)
>>>>>>>>
>>>>>>>> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
>>>>>>>> index 085a61117378..50d52f685f68 100644
>>>>>>>> --- a/hw/arm/virt-acpi-build.c
>>>>>>>> +++ b/hw/arm/virt-acpi-build.c
>>>>>>>> @@ -310,6 +310,13 @@ static void acpi_dsdt_add_pci(Aml *scope, con=
st MemMapEntry *memmap,
>>>>>>>>      Aml *dev_rp0 =3D aml_device("%s", "RP0");
>>>>>>>>      aml_append(dev_rp0, aml_name_decl("_ADR", aml_int(0)));
>>>>>>>>      aml_append(dev, dev_rp0);
>>>>>>>> +
>>>>>>>> +    Aml *dev_res0 =3D aml_device("%s", "RES0");
>>>>>>>> +    aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C0=
2")));
>>>>>>>> +    crs =3D aml_resource_template();
>>>>>>>> +    aml_append(crs, aml_memory32_fixed(base_ecam, size_ecam, AML_=
READ_WRITE));
>>>>>>>> +    aml_append(dev_res0, aml_name_decl("_CRS", crs));
>>>>>>>> +    aml_append(dev, dev_res0);
>>>>>>>>      aml_append(scope, dev);
>>>>>>>>  }
>>>>>>>
>>>>>>> This needs to be controlled via the machine class back-compat
>>>>>>> machinery in hw/arm/virt.c so that it only happens for virt-2.9
>>>>>>> and later.
>>>>>>>
>>>>>>
>>>>>> Why exactly?
>>>>>
>>>>> Because the "virt-2.8" machine has to present to the guest
>>>>> exactly what "virt" did as of the QEMU 2.8 release, including
>>>>> any bugs or missing things we happened to have in our ACPI
>>>>> tables. This allows cross-version compatibility (including
>>>>> VM migration). Drew will have a more detailed explanation
>>>>> if you need it.
>>>>>
>>>>
>>>> I suspected as much.
>>>>
>>>> But in this case, I am not sure if it is worth the trouble: the
>>>> generated data is only consumed at boot time by the firmware, and I
>>>> suppose migration involves freezing a VM, including whatever resident
>>>> firmware image was used to boot the OS, and so this is unlikely to
>>>> affect migration.
>>>>
>>>> But I will let Drew explain ...
>>>
>>> The PCI Firmware Specification (rev 3.1) says in 4.1.2. "MCFG Table
>>> Description": "The resources can *optionally* be returned in [...]
>>> EFIGetMemoryMap as reserved memory [...]". (Emphasis mine.) Linux seems
>>> to *insist* on this kind of reservation however.
>>>
>>
>> No, not at the UEFI level but at the ACPI level. Reservations in the
>> UEFI memory map describe memory not MMIO space
>>
>>> PNP0C02 is "General ID for reserving resources required by PnP
>>> motherboard registers. (Not device specific.)", according to
>>> <http://www.plasma-online.de/english/identify/serial/pnp_id_pnp.html>.
>>> So what this patch does is reserve a memory area through ACPI,
>>> practically as an unspecified "platform resource".
>>>
>>
>> This has been discussed at great length on the linux mailing lists
>>
>> https://patchwork.kernel.org/patch/9453149/
>>
>>> There's an alternative that's contained entirely in the firmware. You
>>> can cover the MMCONFIG area in ArmVirtQemu with an EfiReservedMemoryTyp=
e
>>> memory map entry (by producing an appropriate memalloc HOB in PEI, or b=
y
>>> calling the appropriate gDS memory space map functions in DXE). OVMF
>>> does the former (memalloc HOB).
>>>
>>> In ArmVirtQemu, we grab the MMCONFIG range from "pci-host-ecam-generic"=
,
>>> from QEMU's DTB. If you don't dislike the idea, we could cover the rang=
e
>>> as well, right in "ArmVirtPkg/Library/FdtPciPcdProducerLib". That lib
>>> instance already sets the base address PCD, and makes sure that the
>>> relevant code is executed only once (in whatever driver module the
>>> library instance was built into). You could call the gDS functions
>>> mentioned above from that spot. (The library instance is already
>>> restricted to DXE_DRIVER and UEFI_DRIVER modules.)
>>>
>>
>> In general, I think describing MMIO in the UEFI memory map is not very
>> useful, and counter to the spec, which mentions that the memory map
>> describes memory ("however it is used"), not memory *space* (unless
>> UEFI itself needs to access it to implement runtime services)
>>
>
> The UEFI memory map will reflect allocations from the GCD memory space,
> for the Reserved and MMIO types. See "Figure 2. GCD Memory State
> Transitions" in "7.2.2 GCD Memory Resources", Vol2 of the PI spec.
>
> See also "9.7.1 UEFI Boot Services Dependencies" in the same,
>
>   9.7.1.8 GetMemoryMap()
>
>   The GetMemoryMap() implementation must include into the UEFI memory
>   map all GCD map entries of types EfiGcdMemoryTypeReserved and
>   EfiPersistentMemory, and all GCD map entries of type
>   EfiGcdMemoryTypeMemoryMappedIo that have EFI_MEMORY_RUNTIME attribute
>   set.
>
> (Note that I wrote Reserved earlier, not MMIO.)
>

What the PI spec stipulates is irrelevant: the contract between the
firmware and the OS is in the UEFI and ACPI specifications, not in the
PI spec.

> However, you are right that *just* the UEFI memmap entry is not
> sufficient, according to the PCI firmware spec. (Regardless of the fact
> that in practice, just the memmap entry does keep Linux happy. Or is it
> about to change?)
>

The kernel uses the UEFI memory map for two purposes:
- finding out where memory is, and which parts are usable (i.e., non-reserv=
ed)
- setting up page tables to allow UEFI runtime services calls, which
may include MMIO mappings

This means that MMIO regions in the UEFI memory map are *not*
considered reservations. This is in line with the wording of the UEFI
spec, which mentions that the memory map describes memory, not MMIO
(with the exception of MMIO peripherals that the firmware needs to
access to implement the runtime services)

> Namely, looking again at the spot I quoted above (and it's also quoted
> in the kernel docs patch that you linked above, under ref [6]), we find
>
>     If the operating system does not natively comprehend reserving the
>     MMCFG region, the MMCFG region must be reserved by firmware. The
>     address range reported in the MCFG table or by _CBA method (see
>     Section 4.1.3) must be reserved by declaring a motherboard resource.
>     For most systems, the motherboard resource would appear at the root
>     of the ACPI namespace (under \_SB) in a node with a _HID of EISAID
>     (PNP0C02), and the resources in this case should not be claimed in
>     the root PCI bus=E2=80=99s _CRS. The resources can optionally be retu=
rned in
>     Int15 E820 or EFIGetMemoryMap as reserved memory but must always be
>     reported through ACPI as a motherboard resource.
>
> Therefore I agree that reserving the MMCONFIG area via a PNP0C02 object
> in QEMU's ACPI payload improves spec conformance.
>

Good.

> (Actually, the argument can be made for x86/Q35 as well. Adding Marcel
> and MST.)
>
> ... Beyond the machine-type dependency raised by Peter (which I gather
> is still being discussed), I suggest that the commit message of this
> patch quote the relevant passage from the PCI fw spec in full (see
> above, or in the kernel docs patch).
>

I will expand the commit message in the next respin

Thanks (and apologies for not cc'ing you in the first place),
Ard.
