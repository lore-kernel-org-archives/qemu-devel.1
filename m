Received: from eggs.gnu.org ([2001:4830:134:3::10]:52668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkzoT-0008JX-Uf
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 17:37:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dkzoP-0007gO-1H
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 17:37:17 -0400
Date: Thu, 24 Aug 2017 23:37:09 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20170824024438.GZ5379@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1708242241030.96438@zero.eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<ab632ef70b02efb2257d9e2f08b45b097ebacb3a.1503249785.git.balaton@eik.bme.hu>
	<20170823041644.GP5379@umbus.fritz.box>
	<alpine.BSF.2.21.1708231217070.76247@zero.eik.bme.hu>
	<20170824024438.GZ5379@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, Francois Revol <revol@free.fr>

On Thu, 24 Aug 2017, David Gibson wrote:
> On Wed, Aug 23, 2017 at 01:12:06PM +0200, BALATON Zoltan wrote:
>> On Wed, 23 Aug 2017, David Gibson wrote:
>>> On Sun, Aug 20, 2017 at 07:23:05PM +0200, BALATON Zoltan wrote:
>>>> Add emulation of aCube Sam460ex board based on AMCC 460EX embedded S=
oC.
>>>> This is not a full implementation yet with a lot of components still
>>>> missing but enough to start a Linux kernel and the U-Boot firmware.
>>>>
>>>> Signed-off-by: Fran=E7ois Revol <revol@free.fr>
>>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>>
>>> As usual, only fairly superficial review here.
>>>
>>>> ---
>>>>  default-configs/ppcemb-softmmu.mak |   3 +
>>>>  hw/ppc/Makefile.objs               |   2 +
>>>>  hw/ppc/sam460ex.c                  | 611 ++++++++++++++++++++++++++=
+++++++++++
>>>>  3 files changed, 616 insertions(+)
>>>>  create mode 100644 hw/ppc/sam460ex.c
>>>>
>>>> diff --git a/default-configs/ppcemb-softmmu.mak b/default-configs/pp=
cemb-softmmu.mak
>>>> index 635923a..90b42f0 100644
>>>> --- a/default-configs/ppcemb-softmmu.mak
>>>> +++ b/default-configs/ppcemb-softmmu.mak
>> [...]
>>>> +/******************************************************************=
***********/
>>>> +/* SPD eeprom content from mips_malta.c */
>>>
>>> What's the connection with mips_malta?
>>
>> The board's firmware wants to see SPD EEPROMs of the connected memory =
while
>> initialising the memory controller. This is why we need to implement S=
DRAM
>> controller, I2C and SPD EEPROMs. MIPS malta board had already SPD EEPR=
OM
>> implementation so this is based on that. The comment just indicates wh=
ere
>> this code comes from.
>
> Ok.
>
> [snip]
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
es not
>> matter.
>
> Have you attempted it on both BE and LE hosts though?

No, I don't have a BE host, only tried on LE. I'm guessing this may come=20
from hw/ppc/virtex_ml507.c where EPAPR_MAGIC is also swapped. The only=20
other place this magic number appears is in e500 where it's not swapped=20
though so I don't really know what should be correct here. In u-boot=20
sources (arch/powerpc/lib/bootm.c) it seems to use this magic if=20
CONFIG_OF_LIBFDT is defined which seems to be set for this board so that=20
means we likely need this (but maybe not for the legacy uImages I've=20
tried). Since CPU is big endian and constant is defined on the host this=20
probably should be cpu_to_be32(EPAPR_MAGIC). Does that sound better?

[...]
>>>> +    /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.=
c? */
>>>> +    memory_region_init_ram(l2cache_ram, NULL, "ppc440.l2cache_ram",=
 256 << 10,
>>>> +                           &error_abort);
>>>> +    memory_region_add_subregion(address_space_mem, 0x400000000LL, l=
2cache_ram);
>>>> +
>>>> +    /* USB */
>>>> +    sysbus_create_simple(TYPE_PPC4xx_EHCI, 0x4bffd0400, uic[2][29])=
;
>>>> +    dev =3D qdev_create(NULL, "sysbus-ohci");
>>>> +    qdev_prop_set_string(dev, "masterbus", "usb-bus.0");
>>>> +    qdev_prop_set_uint32(dev, "num-ports", 6);
>>>> +    qdev_init_nofail(dev);
>>>> +    sbdev =3D SYS_BUS_DEVICE(dev);
>>>> +    sysbus_mmio_map(sbdev, 0, 0x4bffd0000);
>>>> +    sysbus_connect_irq(sbdev, 0, uic[2][30]);
>>>> +    usb_create_simple(usb_bus_find(-1), "usb-kbd");
>>>> +    usb_create_simple(usb_bus_find(-1), "usb-mouse");
>>>> +
>>>> +    /* PCI bus */
>>>> +    ppc460ex_pcie_init(env);
>>>> +    /*XXX: FIXME: is this correct? */
>>>> +    dev =3D sysbus_create_varargs("ppc440-pcix-host", 0xc0ec00000,
>>>> +                                uic[1][0], uic[1][20], uic[1][21], =
uic[1][22],
>>>> +                                NULL);
>>>> +    pci_bus =3D (PCIBus *)qdev_get_child_bus(dev, "pci.0");
>>>> +    if (!pci_bus) {
>>>> +        fprintf(stderr, "couldn't create PCI controller!\n");
>>>> +        exit(1);
>>>> +    }
>>>> +    memory_region_init_alias(isa, NULL, "isa_mmio", get_system_io()=
,
>>>> +                             0, 0x10000);
>>>> +    memory_region_add_subregion(get_system_memory(), 0xc08000000, i=
sa);
>>>
>>> Does it really make sense to just embed the ISA IO space here, rather
>>> than actually instanting a PCI<->ISA bridge?
>>
>> I'm not sure if this is correct but I don't know how it's handled on r=
eal
>> hardware. The board does not have ISA and I don't think it has a bridg=
e but
>> the IO space appears at this location according to the datasheet (In S=
ystem
>> Memory Address Map it's listed as PCI I/O 0xc08000000-0xc0800ffff) and
>> clients expect PCI card's io registers to be accessible here. If anyon=
e
>> knows how it's done on real hardware and if there's a better way to mo=
del
>> this please let me know.
>
> Ah, ok.  I think the confusion here is that you can have PCI I/O space
> without ISA or a system IO space.  In fact that's pretty standard on
> things without a CPU level IO space (which means just about everything
> except x86).
>
> But in that case I'd expect the PCI host bridge to map its IO memory
> regions directly into address_space_memory rather than involving the
> global address_space_io (what get_system_io()) returns.  The only
> reason I can see that you'd need to involve get_system_io() is if you
> have devices registering themselves directly into the global IO space,
> which should only happen for legacy ISA devices, which it sounds like
> you don't have.
>
> Possibly this is an error in the PCI bridge implementation that your
> code here is essentially a workaround for, though.

So in my understanding, there's a system_io space created automatically=20
which appears in the memory tree anyway but would otherwise be unused and=
=20
this was just reused here for the pci io space so it does not need anothe=
r=20
memory region for this. If it's not acceptable this way (although=20
ppc440_bamboo.c and ppc4xx_pci.c also does it the exact same way) an=20
alternative may be to change it to add another mem region for io to=20
ppc440_pcix.c (although it already has iomem for pci.reg so this might be=
=20
more confusing than using system_io here) but I think pcix device can't=20
map this to address_space_memory itself because this device could appear=20
in different SoCs where the memory areas might be at different addresses=20
so this new region should then be registered as a sysbus mmio space and b=
e=20
mapped from the board code with sysbus_mmio_map()? I find that much more=20
confusing than how it's done now which is also more consistent with=20
existing code modelling similar devices.

>>>> +    /* PCI devices */
>>>> +    pci_create_simple(pci_bus, PCI_DEVFN(6, 0), "sm501");
>>>> +    /* SoC has a single SATA port but we don't emulate that yet
>>>> +     * However, firmware and usual clients have driver for SiI311x
>>>> +     * so add one for convenience by default */
>>>> +    pci_create_simple(pci_bus, -1, "sii3112");
>>>
>>> You should probably not create this when started with -nodefaults.
>>
>> We don't emulate the on-board SATA port of the SoC and without this th=
ere's
>> no other way to connect disks (maybe over USB, but firmware has a bug =
which
>> prevents that too even on real hardware AFAIK, I've backported a fix w=
hich
>> made booting from USB work but that broke keyboard) so while this is a=
n
>> external card it's pretty much unusable without this so it's added by
>> default.
>
> Yes, but you're not just adding it by default, you're adding it
> *always*.  -nodefaults should turn that off (and the user will need to
> manually instantiate it - or another disk controller, I guess).

OK I got it now. I still don't see when -nodefaults could be useful to=20
cripple the board and make it easier to create non-working configurations=
=20
but I can easily add this conditional around this line and hope users sta=
y=20
away from this switch and won't complain when it does not boot when they=20
use it. (Well, it does not really boot most of the time without this=20
switch either so I don't think it matters much at the moment :-) )
