Received: from eggs.gnu.org ([2001:4830:134:3::10]:38776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkV4W-0006t0-Ho
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:47:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkV4S-0006Q8-8K
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 08:47:48 -0400
Date: Wed, 23 Aug 2017 14:47:42 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <8fe81d01-0a39-02cc-c7d8-59437c4f94ac@free.fr>
Message-ID: <alpine.BSF.2.21.1708231422390.35800@zero.eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ab632ef70b02efb2257d9e2f08b45b097ebacb3a.1503249785.git.balaton@eik.bme.hu>
	<20170823041644.GP5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231217070.76247@zero.eik.bme.hu>
	<8fe81d01-0a39-02cc-c7d8-59437c4f94ac@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 15/15] ppc: Add aCube Sam460ex board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Fran=E7ois_Revol?= <revol@free.fr>
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>

On Wed, 23 Aug 2017, Fran=E7ois Revol wrote:
> Le 23/08/2017 =E0 13:12, BALATON Zoltan a =E9crit :
>>> What's the connection with mips_malta?
>>
>> The board's firmware wants to see SPD EEPROMs of the connected memory
>> while initialising the memory controller. This is why we need to
>> implement SDRAM controller, I2C and SPD EEPROMs. MIPS malta board had
>> already SPD EEPROM implementation so this is based on that. The commen=
t
>> just indicates where this code comes from.
>
> Indeed, and I copy-pasted from elsewhere for this.
>
>>>> +        fprintf(stderr, "qemu: Error registering flash memory.\n");
>>>
>>> Use error_report() instead, please.
>
> I guess this didn't exist back when I started writing it...

No problem, I can take care of these.

>>>> +/* Create reset TLB entries for BookE, mapping only the flash
>>>> memory.  */
>>>> +static void mmubooke_create_initial_mapping_uboot(CPUPPCState *env)
>>>> +{
>>>> +    ppcemb_tlb_t *tlb =3D &env->tlb.tlbe[0];
>>>> +
>>>> +    /* on reset the flash is mapped by a shadow TLB,
>>>> +     * but since we don't implement them we need to use
>>>> +     * the same values U-Boot will use to avoid a fault.
>>>> +     */
>>>
>>> Usually the reset state of the MMU is handled in the cpu code rather
>>> than the board code.  Is there a specific reason you need it in the
>>> board code here?
>>
>> I'm not sure, probably lack of a better place. The ppc440_bamboo board
>> this is based on has it the same way in the board code. Maybe this cou=
ld
>> be cleaned up when someone wants to QOMify the SoC models sometimes.
>
> Thing is, the code allows both booting with U-Boot and with a kernel
> directly, and the MMU mapping differ in those cases.
>
> Maybe the CPU reset should use the U-Boot setup and the kernel boot
> would just overwrite it?
>
>>>> +        env->nip =3D bi->entry;
>>>> +
>>>> +        /* Create a mapping for the kernel.  */
>>>> +        mmubooke_create_initial_mapping(env, 0, 0);
>>>> +        env->gpr[6] =3D tswap32(EPAPR_MAGIC);
>>>
>>> I'm pretty sure the tswap can't be right here.  env->gpr is in host
>>> native order and I'd expect the constant to be as well.
>>
>> I know nothing about this, maybe Francois remembers why it's there. Bu=
t
>> booting linux with -kernel works so it's probably either correct or do=
es
>> not matter.
>
> Absolutely no idea. It seems to be there from the first commit in my ow=
n
> history here.
>
> I don't recall testing booting linux at all though.
> Linux does check the magic, so it'd be weird if it booted:
>
> https://github.com/torvalds/linux/blob/master/arch/powerpc/boot/epapr.c

Is this code used on Sam460 at all? Is U-Boot ePAPR compliant firmware?=20
Isn't that only needed on OpenFirmware?

> But maybe it got added later than the version you tested?

I've tried some of these:=20
http://www.supertuxkart-amiga.de/amiga/sam.html#downloads
which also have kernel 4.5 so that's fairly recent. These kernels are=20
"u-boot legacy uImage" so maybe they don't need ePAPR magic? Are there=20
some docs on what the kernel expects on this board or it has to be dug ou=
t=20
from U-Boot?

> At least my current Haiku port ignores the magic for now.
>
>>>> +        env->gpr[7] =3D (16 << 20) - 8; /*bi->ima_size;*/
>>>
>>> So, entering the kernel directly can be useful, particularly during
>>> early development.  However, having both firmware and non-firmware
>>> entry paths can lead to confusing bugs if there's a subtle difference
>>> between the initial (to the kernel) states between the two paths.  Fo=
r
>>> that reason, the usual preferred way to implement -kernel is to still
>>> run the usual firmware, but use some way of telling it to boot
>>> immediately into the supplied kernel.
>>>
>>> I won't object to merging it this way - just a wanrning that this may
>>> bite you in the future if you're not careful.
>>
>> Warning taken, at this point until firmware cannot reliably boot thing=
s
>> having another way to test is useful to have. In the future when booti=
ng
>> via firmware works well we can figure out what to do with this.
>
> Possibly we could dig the U-Boot environment...
>
>>>> +    memory_region_init_alias(isa, NULL, "isa_mmio", get_system_io()=
,
>>>> +                             0, 0x10000);
>>>> +    memory_region_add_subregion(get_system_memory(), 0xc08000000, i=
sa);
>>>
>>> Does it really make sense to just embed the ISA IO space here, rather
>>> than actually instanting a PCI<->ISA bridge?
>>
>> I'm not sure if this is correct but I don't know how it's handled on
>> real hardware. The board does not have ISA and I don't think it has a
>> bridge but the IO space appears at this location according to the
>> datasheet (In System Memory Address Map it's listed as PCI I/O
>> 0xc08000000-0xc0800ffff) and clients expect PCI card's io registers to
>> be accessible here. If anyone knows how it's done on real hardware and
>> if there's a better way to model this please let me know.
>
> Indeed it's the PCI I/O space, maybe it's just copy-paste error.
>
> As for how to declare it, keep in mind this code is years old and I
> fixed it several times when compilation broke, without really reading
> the documentation (actually, do we have proper documentation for the
> internal API?), and it kept changing over the years.

And I've also changed it while cleaning up and getting it to work with=20
some clients. This particular mapping was at the wrong place in your firs=
t=20
commits then got removed but I found it's needed but at a different=20
address so I've added it again with the fixed address.

>>>> +    /* PCI devices */
>>>> +    pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
>>>> +    /* SoC has a single SATA port but we don't emulate that yet
>>>> +     * However, firmware and usual clients have driver for SiI311x
>>>> +     * so add one for convenience by default */
>>>> +    pci_create_simple(pci_bus, -1, "sii3112");
>>>
>>> You should probably not create this when started with -nodefaults.
>>
>> We don't emulate the on-board SATA port of the SoC and without this
>> there's no other way to connect disks (maybe over USB, but firmware ha=
s
>> a bug which prevents that too even on real hardware AFAIK, I've
>> backported a fix which made booting from USB work but that broke
>> keyboard) so while this is an external card it's pretty much unusable
>> without this so it's added by default.
>
> Maybe add a /*TODO*/ then?

I don't indent to implement that. Seems to be too complex and unnecessary=
=20
when we have sii3112 (unless you want to test drivers for it on QEMU). I'=
d=20
rather see an implementation of the network interfaces that seems to be=20
more useful to spend time on than another SATA controller. So I chose to=20
use the sii3112 by default.
