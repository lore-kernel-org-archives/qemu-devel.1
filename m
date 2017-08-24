Received: from eggs.gnu.org ([2001:4830:134:3::10]:58592)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dl0MO-0002Uw-GY
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:12:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1dl0ML-0000Nd-4p
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 18:12:20 -0400
Date: Fri, 25 Aug 2017 00:12:14 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <7e49b073-a7fe-96d0-17c0-93042fb9d805@amsat.org>
Message-ID: <alpine.BSF.2.21.1708242358100.96438@zero.eik.bme.hu>
References: <cover.1503249785.git.balaton@eik.bme.hu>
	<d9d735634eb1c6af360bf0aca2131a2822606c40.1503249785.git.balaton@eik.bme.hu>
	<7e49b073-a7fe-96d0-17c0-93042fb9d805@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/15] ppc440: Add emulation of plb-pcix
 controller found in some 440 SoCs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Francois Revol <revol@free.fr>, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Sun, 20 Aug 2017, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Zoltan,

Hello,

Thanks for the review and comments.

> On 08/20/2017 02:23 PM, BALATON Zoltan wrote:
>> This is the PCIX controller found in newer 440 core SoCs e.g. the AMMC
>> 460EX. The device tree refers to this as plb-pcix compared to the
>> plb-pci controller in older 440 SoCs.
>>=20
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>   hw/ppc/Makefile.objs |   2 +-
>>   hw/ppc/ppc440_pcix.c | 516=20
>> +++++++++++++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 517 insertions(+), 1 deletion(-)
>>   create mode 100644 hw/ppc/ppc440_pcix.c
>>=20
>> diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
>> index 7efc686..fc39fe4 100644
>> --- a/hw/ppc/Makefile.objs
>> +++ b/hw/ppc/Makefile.objs
>> @@ -13,7 +13,7 @@ endif
>>   obj-$(CONFIG_PSERIES) +=3D spapr_rtas_ddw.o
>>   # PowerPC 4xx boards
>>   obj-y +=3D ppc405_boards.o ppc4xx_devs.o ppc405_uc.o ppc440_bamboo.o
>> -obj-y +=3D ppc4xx_pci.o
>> +obj-y +=3D ppc4xx_pci.o ppc440_pcix.o
>>   # PReP
>>   obj-$(CONFIG_PREP) +=3D prep.o
>>   obj-$(CONFIG_PREP) +=3D prep_systemio.o
>> diff --git a/hw/ppc/ppc440_pcix.c b/hw/ppc/ppc440_pcix.c
>> new file mode 100644
>> index 0000000..5c2ceec
>> --- /dev/null
>> +++ b/hw/ppc/ppc440_pcix.c
>> @@ -0,0 +1,516 @@
>> +/*
>> + * Emulation of the ibm,plb-pcix PCI controller
>> + * This is found in some 440 SoCs e.g. the 460EX.
>> + *
>> + * Copyright (c) 2016 BALATON Zoltan
>> + *
>> + * Derived from ppc4xx_pci.c and pci-host/ppce500.c
>> + *
>> + * This program is free software; you can redistribute it and/or modi=
fy
>> + * it under the terms of the GNU General Public License, version 2, a=
s
>> + * published by the Free Software Foundation.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, see <http://www.gnu.org/licenses/=
>.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/error-report.h"
>> +#include "hw/hw.h"
>> +#include "hw/ppc/ppc.h"
>> +#include "hw/ppc/ppc4xx.h"
>> +#include "hw/pci/pci.h"
>> +#include "hw/pci/pci_host.h"
>> +#include "exec/address-spaces.h"
>> +
>> +/*#define DEBUG_PCI*/
>> +
>> +#ifdef DEBUG_PCI
>> +#define DPRINTF(fmt, ...) fprintf(stderr, fmt, ## __VA_ARGS__);
>> +#else
>> +#define DPRINTF(fmt, ...)
>> +#endif /* DEBUG */
>> +
>> +struct PLBOutMap {
>> +    uint64_t la;
>> +    uint64_t pcia;
>> +    uint32_t sa;
>> +    MemoryRegion mr;
>> +};
>> +
>> +struct PLBInMap {
>> +    uint64_t sa;
>> +    uint64_t la;
>> +    MemoryRegion mr;
>> +};
>> +
>> +#define TYPE_PPC440_PCIX_HOST_BRIDGE "ppc440-pcix-host"
>> +#define PPC440_PCIX_HOST_BRIDGE(obj) \
>> +    OBJECT_CHECK(PPC440PCIXState, (obj), TYPE_PPC440_PCIX_HOST_BRIDGE=
)
>> +
>> +#define PPC440_PCIX_NR_POMS 3
>> +#define PPC440_PCIX_NR_PIMS 3
>> +
>> +typedef struct PPC440PCIXState {
>> +    PCIHostState parent_obj;
>> +
>> +    PCIDevice *dev;
>> +    struct PLBOutMap pom[PPC440_PCIX_NR_POMS];
>> +    struct PLBInMap pim[PPC440_PCIX_NR_PIMS];
>> +    uint32_t sts;
>> +    qemu_irq irq[PCI_NUM_PINS];
>> +    AddressSpace bm_as;
>> +    MemoryRegion bm;
>> +
>> +    MemoryRegion container;
>> +    MemoryRegion iomem;
>> +    MemoryRegion busmem;
>> +} PPC440PCIXState;
>> +
>> +#define PPC440_REG_BASE     0x80000
>> +#define PPC440_REG_SIZE     0xff
>> +
>> +#define PCIC0_CFGADDR       0x0
>> +#define PCIC0_CFGDATA       0x4
>> +
>> +#define PCIX0_POM0LAL       0x68
>> +#define PCIX0_POM0LAH       0x6c
>> +#define PCIX0_POM0SA        0x70
>> +#define PCIX0_POM0PCIAL     0x74
>> +#define PCIX0_POM0PCIAH     0x78
>> +#define PCIX0_POM1LAL       0x7c
>> +#define PCIX0_POM1LAH       0x80
>> +#define PCIX0_POM1SA        0x84
>> +#define PCIX0_POM1PCIAL     0x88
>> +#define PCIX0_POM1PCIAH     0x8c
>> +#define PCIX0_POM2SA        0x90
>> +
>> +#define PCIX0_PIM0SAL       0x98
>> +#define PCIX0_PIM0LAL       0x9c
>> +#define PCIX0_PIM0LAH       0xa0
>> +#define PCIX0_PIM1SA        0xa4
>> +#define PCIX0_PIM1LAL       0xa8
>> +#define PCIX0_PIM1LAH       0xac
>> +#define PCIX0_PIM2SAL       0xb0
>> +#define PCIX0_PIM2LAL       0xb4
>> +#define PCIX0_PIM2LAH       0xb8
>> +#define PCIX0_PIM0SAH       0xf8
>> +#define PCIX0_PIM2SAH       0xfc
>> +
>> +#define PCIX0_STS           0xe0
>> +
>> +#define PCI_ALL_SIZE        (PPC440_REG_BASE + PPC440_REG_SIZE)
>> +
>> +static void ppc440_pcix_clear_region(MemoryRegion *parent,
>> +                                     MemoryRegion *mem)
>> +{
>> +    if (memory_region_is_mapped(mem)) {
>> +        memory_region_del_subregion(parent, mem);
>> +        object_unparent(OBJECT(mem));
>> +    }
>> +}
>> +
>> +/* DMA mapping */
>> +static void ppc440_pcix_update_pim(PPC440PCIXState *s, int idx)
>> +{
>> +    MemoryRegion *mem =3D &s->pim[idx].mr;
>> +    char *name;
>> +    uint64_t size;
>> +
>> +    /* Before we modify anything, unmap and destroy the region */
>> +    ppc440_pcix_clear_region(&s->bm, mem);
>> +
>> +    if (!(s->pim[idx].sa & 1)) {
>> +        /* Not enabled, nothing to do */
>> +        return;
>> +    }
>> +
>> +    name =3D g_strdup_printf("PCI Inbound Window %d", idx);
>> +    size =3D ~(s->pim[idx].sa & ~7ULL) + 1;
>> +    memory_region_init_alias(mem, OBJECT(s), name, get_system_memory(=
),
>> +                             s->pim[idx].la, size);
>> +    memory_region_add_subregion_overlap(&s->bm, 0, mem, -1);
>> +    g_free(name);
>> +
>> +    DPRINTF("%s: Added window %d of size=3D%#"PRIx64" to CPU=3D%#"PRI=
x64"\n",
>> +            __func__, idx, size, s->pim[idx].la);
>> +}
>> +
>> +/* BAR mapping */
>> +static void ppc440_pcix_update_pom(PPC440PCIXState *s, int idx)
>> +{
>> +    MemoryRegion *mem =3D &s->pom[idx].mr;
>> +    MemoryRegion *address_space_mem =3D get_system_memory();
>> +    char *name;
>> +    uint32_t size;
>> +
>> +    /* Before we modify anything, unmap and destroy the region */
>> +    ppc440_pcix_clear_region(address_space_mem, mem);
>> +
>> +    if (!(s->pom[idx].sa & 1)) {
>> +        /* Not enabled, nothing to do */
>> +        return;
>> +    }
>> +
>> +    name =3D g_strdup_printf("PCI Outbound Window %d", idx);
>> +    size =3D ~(s->pom[idx].sa & 0xfffffffe) + 1;
>> +    if (!size) {
>> +        size =3D 0xffffffff;
>> +    }
>> +    memory_region_init_alias(mem, OBJECT(s), name, &s->busmem,
>> +                             s->pom[idx].pcia, size);
>> +    memory_region_add_subregion(address_space_mem, s->pom[idx].la, me=
m);
>> +    g_free(name);
>> +
>> +    DPRINTF("%s: Added window %d of size=3D%#x from CPU=3D%#"PRIx64
>> +            " to PCI=3D%#"PRIx64"\n", __func__, idx, size, s->pom[idx=
].la,
>> +            s->pom[idx].pcia);
>> +}
>> +
>> +static void ppc440_pcix_reg_write4(void *opaque, hwaddr addr,
>> +                                   uint64_t val, unsigned size)
>> +{
>> +    struct PPC440PCIXState *s =3D opaque;
>> +
>> +    DPRINTF("%s: addr 0x%"PRIx64 " =3D %"PRIx64 "\n", __func__, addr,=
 val);
>> +    switch (addr) {
>> +    case PCI_VENDOR_ID ... PCI_MAX_LAT:
>> +        stl_le_p(s->dev->config + addr, val);
>> +        break;
>> +
>> +    case PCIX0_POM0LAL:
>
> Those lines ...
>
>> +        s->pom[0].la &=3D 0xffffffff00000000ULL;
>> +        s->pom[0].la |=3D val;
>
> equivs to:
>
> 	   s->pom[0].la =3D deposit64(s->pom[0].la, 0, 32, val);
>
>> +        ppc440_pcix_update_pom(s, 0);
>> +        break;
>> +    case PCIX0_POM0LAH:
>
> Those
>
>> +        s->pom[0].la &=3D 0xffffffffULL;
>> +        s->pom[0].la |=3D val << 32;
>
> to:
>
> 	   s->pom[0].la =3D deposit64(s->pom[0].la, 32, 32, val);

Except that deposit64 also seems to call an (in this case) unnecessary=20
assert. Not sure how much overhead is that and I don't think this is=20
performance critical as these regs are probably not accessed too=20
frequently but why not avoid an unneded call for such simple operation?=20
The deposit and extract functions are not currently used in most other=20
device models as it seems so I'm happy with the current way unless there'=
s=20
a good reason to change it other than one line instead of two. But the=20
current version could also be written as one I line just found this easie=
r=20
to read but it's personal taste I guess so everyone can have different=20
view on this what's more readable to them. If less lines is preferred I=20
would rather make them one line without calling deposit here. But that=20
would increase the number of paranthesis. Maybe I could define some macro=
s=20
for this and use those instead.

>> +        ppc440_pcix_update_pom(s, 0);
>> +        break;
>> +    case PCIX0_POM0SA:
>> +        s->pom[0].sa =3D val;
>> +        ppc440_pcix_update_pom(s, 0);
>> +        break;
>> +    case PCIX0_POM0PCIAL:
>> +        s->pom[0].pcia &=3D 0xffffffff00000000ULL;
>> +        s->pom[0].pcia |=3D val;
>
> and so on
>
>> +        ppc440_pcix_update_pom(s, 0);
>> +        break;
>> +    case PCIX0_POM0PCIAH:
>> +        s->pom[0].pcia &=3D 0xffffffffULL;
>> +        s->pom[0].pcia |=3D val << 32;
>> +        ppc440_pcix_update_pom(s, 0);
>> +        break;
>> +    case PCIX0_POM1LAL:
>> +        s->pom[1].la &=3D 0xffffffff00000000ULL;
>> +        s->pom[1].la |=3D val;
>> +        ppc440_pcix_update_pom(s, 1);
>> +        break;
>> +    case PCIX0_POM1LAH:
>> +        s->pom[1].la &=3D 0xffffffffULL;
>> +        s->pom[1].la |=3D val << 32;
>> +        ppc440_pcix_update_pom(s, 1);
>> +        break;
>> +    case PCIX0_POM1SA:
>> +        s->pom[1].sa =3D val;
>> +        ppc440_pcix_update_pom(s, 1);
>> +        break;
>> +    case PCIX0_POM1PCIAL:
>> +        s->pom[1].pcia &=3D 0xffffffff00000000ULL;
>> +        s->pom[1].pcia |=3D val;
>> +        ppc440_pcix_update_pom(s, 1);
>> +        break;
>> +    case PCIX0_POM1PCIAH:
>> +        s->pom[1].pcia &=3D 0xffffffffULL;
>> +        s->pom[1].pcia |=3D val << 32;
>> +        ppc440_pcix_update_pom(s, 1);
>> +        break;
>> +    case PCIX0_POM2SA:
>> +        s->pom[2].sa =3D val;
>> +        break;
>> +
>> +    case PCIX0_PIM0SAL:
>> +        s->pim[0].sa &=3D 0xffffffff00000000ULL;
>> +        s->pim[0].sa |=3D val;
>> +        ppc440_pcix_update_pim(s, 0);
>> +        break;
>> +    case PCIX0_PIM0LAL:
>> +        s->pim[0].la &=3D 0xffffffff00000000ULL;
>> +        s->pim[0].la |=3D val;
>> +        ppc440_pcix_update_pim(s, 0);
>> +        break;
>> +    case PCIX0_PIM0LAH:
>> +        s->pim[0].la &=3D 0xffffffffULL;
>> +        s->pim[0].la |=3D val << 32;
>> +        ppc440_pcix_update_pim(s, 0);
>> +        break;
>> +    case PCIX0_PIM1SA:
>> +        s->pim[1].sa =3D val;
>> +        ppc440_pcix_update_pim(s, 1);
>> +        break;
>> +    case PCIX0_PIM1LAL:
>> +        s->pim[1].la &=3D 0xffffffff00000000ULL;
>> +        s->pim[1].la |=3D val;
>> +        ppc440_pcix_update_pim(s, 1);
>> +        break;
>> +    case PCIX0_PIM1LAH:
>> +        s->pim[1].la &=3D 0xffffffffULL;
>> +        s->pim[1].la |=3D val << 32;
>> +        ppc440_pcix_update_pim(s, 1);
>> +        break;
>> +    case PCIX0_PIM2SAL:
>> +        s->pim[2].sa &=3D 0xffffffff00000000ULL;
>> +        s->pim[2].sa =3D val;
>> +        ppc440_pcix_update_pim(s, 2);
>> +        break;
>> +    case PCIX0_PIM2LAL:
>> +        s->pim[2].la &=3D 0xffffffff00000000ULL;
>> +        s->pim[2].la |=3D val;
>> +        ppc440_pcix_update_pim(s, 2);
>> +        break;
>> +    case PCIX0_PIM2LAH:
>> +        s->pim[2].la &=3D 0xffffffffULL;
>> +        s->pim[2].la |=3D val << 32;
>> +        ppc440_pcix_update_pim(s, 2);
>> +        break;
>> +
>> +    case PCIX0_STS:
>> +        s->sts =3D val;
>> +        break;
>> +
>> +    case PCIX0_PIM0SAH:
>> +        s->pim[0].sa &=3D 0xffffffffULL;
>> +        s->pim[0].sa |=3D val << 32;
>> +        ppc440_pcix_update_pim(s, 0);
>> +        break;
>> +    case PCIX0_PIM2SAH:
>> +        s->pim[2].sa &=3D 0xffffffffULL;
>> +        s->pim[2].sa |=3D val << 32;
>> +        ppc440_pcix_update_pim(s, 2);
>> +        break;
>> +
>> +    default:
>> +        printf("%s: unhandled PCI internal register 0x%lx\n", __func_=
_,
>> +               (unsigned long)addr);
>> +        break;
>> +    }
>> +}
>> +
>> +static uint64_t ppc440_pcix_reg_read4(void *opaque, hwaddr addr,
>> +                                     unsigned size)
>> +{
>> +    struct PPC440PCIXState *s =3D opaque;
>> +    uint32_t val;
>> +
>> +    switch (addr) {
>> +    case PCI_VENDOR_ID ... PCI_MAX_LAT:
>> +        val =3D ldl_le_p(s->dev->config + addr);
>> +        break;
>> +
>> +    case PCIX0_POM0LAL:
>> +        val =3D s->pom[0].la;
>
> This should be
>
>           val =3D s->pom[0].la & 0xffffffffULL;

Since val is uint32_t the value should be automatically truncated to 32=20
bit, shouldn't it? Is there a reason explicit masks are needed here? Is=20
this truncation not well defined and some compilers may do it differently=
?

Thank you,
BALATON Zoltan

> or:
>
>           val =3D extract64(s->pom[0].la, 0, 32);
>
>> +        break;
>> +    case PCIX0_POM0LAH:
>> +        val =3D s->pom[0].la >> 32;
>
> or to be consistent:
>
>           val =3D extract64(s->pom[0].la, 32, 32);
>
>> +        break;
>> +    case PCIX0_POM0SA:
>> +        val =3D s->pom[0].sa;
>> +        break;
>> +    case PCIX0_POM0PCIAL:
>> +        val =3D s->pom[0].pcia;
>
> also 32-bit masked
>
>> +        break;
>> +    case PCIX0_POM0PCIAH:
>> +        val =3D s->pom[0].pcia >> 32;
>> +        break;
>> +    case PCIX0_POM1LAL:
>> +        val =3D s->pom[1].la;
>
> also 32-bit masked
>
>> +        break;
>> +    case PCIX0_POM1LAH:
>> +        val =3D s->pom[1].la >> 32;
>> +        break;
>> +    case PCIX0_POM1SA:
>> +        val =3D s->pom[1].sa;
>
> also 32-bit masked, etc...
>
>> +        break;
>> +    case PCIX0_POM1PCIAL:
>> +        val =3D s->pom[1].pcia;
>> +        break;
>> +    case PCIX0_POM1PCIAH:
>> +        val =3D s->pom[1].pcia >> 32;
>> +        break;
>> +    case PCIX0_POM2SA:
>> +        val =3D s->pom[2].sa;
>> +        break;
>> +
>> +    case PCIX0_PIM0SAL:
>> +        val =3D s->pim[0].sa;
>> +        break;
>> +    case PCIX0_PIM0LAL:
>> +        val =3D s->pim[0].la;
>> +        break;
>> +    case PCIX0_PIM0LAH:
>> +        val =3D s->pim[0].la >> 32;
>> +        break;
>> +    case PCIX0_PIM1SA:
>> +        val =3D s->pim[1].sa;
>> +        break;
>> +    case PCIX0_PIM1LAL:
>> +        val =3D s->pim[1].la;
>> +        break;
>> +    case PCIX0_PIM1LAH:
>> +        val =3D s->pim[1].la >> 32;
>> +        break;
>> +    case PCIX0_PIM2SAL:
>> +        val =3D s->pim[2].sa;
>> +        break;
>> +    case PCIX0_PIM2LAL:
>> +        val =3D s->pim[2].la;
>> +        break;
>> +    case PCIX0_PIM2LAH:
>> +        val =3D s->pim[2].la >> 32;
>> +        break;
>> +
>> +    case PCIX0_STS:
>> +        val =3D s->sts;
>> +        break;
>> +
>> +    case PCIX0_PIM0SAH:
>> +        val =3D s->pim[0].sa  >> 32;
>> +        break;
>> +    case PCIX0_PIM2SAH:
>> +        val =3D s->pim[2].sa  >> 32;
>> +        break;
>> +
>> +    default:
>> +        printf("%s: invalid PCI internal register 0x%lx\n", __func__,
>> +               (unsigned long)addr);
>> +        val =3D 0;
>> +    }
>> +
>> +    DPRINTF("%s: addr 0x%"PRIx64 " =3D %"PRIx32 "\n", __func__, addr,=
 val);
>> +    return val;
>> +}
>> +
>> +static const MemoryRegionOps pci_reg_ops =3D {
>> +    .read =3D ppc440_pcix_reg_read4,
>> +    .write =3D ppc440_pcix_reg_write4,
>> +    .endianness =3D DEVICE_LITTLE_ENDIAN,
>> +};
>> +
>> +static void ppc440_pcix_reset(DeviceState *dev)
>> +{
>> +    struct PPC440PCIXState *s =3D PPC440_PCIX_HOST_BRIDGE(dev);
>> +    int i;
>> +
>> +    for (i =3D 0; i < PPC440_PCIX_NR_POMS; i++) {
>> +        ppc440_pcix_clear_region(get_system_memory(), &s->pom[i].mr);
>> +    }
>> +    for (i =3D 0; i < PPC440_PCIX_NR_PIMS; i++) {
>> +        ppc440_pcix_clear_region(&s->bm, &s->pim[i].mr);
>> +    }
>> +    memset(s->pom, 0, sizeof(s->pom));
>> +    memset(s->pim, 0, sizeof(s->pim));
>> +    for (i =3D 0; i < PPC440_PCIX_NR_PIMS; i++) {
>> +        s->pim[i].sa =3D 0xffffffff00000000ULL;
>> +    }
>> +    s->sts =3D 0;
>> +}
>> +
>> +/* All pins from each slot are tied to a single board IRQ.
>> + * This may need further refactoring for other boards. */
>> +static int ppc440_pcix_map_irq(PCIDevice *pci_dev, int irq_num)
>> +{
>> +    int slot =3D pci_dev->devfn >> 3;
>> +
>> +    DPRINTF("%s: devfn %x irq %d -> %d\n", __func__,
>> +            pci_dev->devfn, irq_num, slot);
>> +
>> +    return slot - 1;
>> +}
>> +
>> +static void ppc440_pcix_set_irq(void *opaque, int irq_num, int level)
>> +{
>> +    qemu_irq *pci_irqs =3D opaque;
>> +
>> +    DPRINTF("%s: PCI irq %d\n", __func__, irq_num);
>> +    if (irq_num < 0) {
>> +        error_report("%s: PCI irq %d", __func__, irq_num);
>> +        return;
>> +    }
>> +    qemu_set_irq(pci_irqs[irq_num], level);
>> +}
>> +
>> +static AddressSpace *ppc440_pcix_set_iommu(PCIBus *b, void *opaque, i=
nt=20
>> devfn)
>> +{
>> +    PPC440PCIXState *s =3D opaque;
>> +
>> +    return &s->bm_as;
>> +}
>> +
>> +static int ppc440_pcix_initfn(SysBusDevice *dev)
>> +{
>> +    PPC440PCIXState *s;
>> +    PCIHostState *h;
>> +    int i;
>> +
>> +    h =3D PCI_HOST_BRIDGE(dev);
>> +    s =3D PPC440_PCIX_HOST_BRIDGE(dev);
>> +
>> +    for (i =3D 0; i < ARRAY_SIZE(s->irq); i++) {
>> +        sysbus_init_irq(dev, &s->irq[i]);
>> +    }
>> +
>> +    memory_region_init(&s->busmem, OBJECT(dev), "pci bus memory",=20
>> UINT64_MAX);
>> +    h->bus =3D pci_register_bus(DEVICE(dev), NULL, ppc440_pcix_set_ir=
q,
>> +                         ppc440_pcix_map_irq, s->irq, &s->busmem,
>> +                         get_system_io(), PCI_DEVFN(0, 0), 4,=20
>> TYPE_PCI_BUS);
>> +
>> +    s->dev =3D pci_create_simple(h->bus, PCI_DEVFN(0, 0),=20
>> "ppc4xx-host-bridge");
>> +
>> +    memory_region_init(&s->bm, OBJECT(s), "bm-ppc440-pcix", UINT64_MA=
X);
>> +    memory_region_add_subregion(&s->bm, 0x0, &s->busmem);
>> +    address_space_init(&s->bm_as, &s->bm, "pci-bm");
>> +    pci_setup_iommu(h->bus, ppc440_pcix_set_iommu, s);
>> +
>> +    memory_region_init(&s->container, OBJECT(s), "pci-container",=20
>> PCI_ALL_SIZE);
>> +    memory_region_init_io(&h->conf_mem, OBJECT(s), &pci_host_conf_le_=
ops,=20
>> h,
>> +                          "pci-conf-idx", 4);
>> +    memory_region_init_io(&h->data_mem, OBJECT(s), &pci_host_data_le_=
ops,=20
>> h,
>> +                          "pci-conf-data", 4);
>> +    memory_region_init_io(&s->iomem, OBJECT(s), &pci_reg_ops, s,
>> +                          "pci.reg", PPC440_REG_SIZE);
>> +    memory_region_add_subregion(&s->container, PCIC0_CFGADDR,=20
>> &h->conf_mem);
>> +    memory_region_add_subregion(&s->container, PCIC0_CFGDATA,=20
>> &h->data_mem);
>> +    memory_region_add_subregion(&s->container, PPC440_REG_BASE,=20
>> &s->iomem);
>> +    sysbus_init_mmio(dev, &s->container);
>> +
>> +    return 0;
>> +}
>> +
>> +static void ppc440_pcix_class_init(ObjectClass *klass, void *data)
>> +{
>> +    SysBusDeviceClass *k =3D SYS_BUS_DEVICE_CLASS(klass);
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    k->init =3D ppc440_pcix_initfn;
>> +    dc->reset =3D ppc440_pcix_reset;
>> +}
>> +
>> +static const TypeInfo ppc440_pcix_info =3D {
>> +    .name          =3D TYPE_PPC440_PCIX_HOST_BRIDGE,
>> +    .parent        =3D TYPE_PCI_HOST_BRIDGE,
>> +    .instance_size =3D sizeof(PPC440PCIXState),
>> +    .class_init    =3D ppc440_pcix_class_init,
>> +};
>> +
>> +static void ppc440_pcix_register_types(void)
>> +{
>> +    type_register_static(&ppc440_pcix_info);
>> +}
>> +
>> +type_init(ppc440_pcix_register_types)
>>=20
>
>
