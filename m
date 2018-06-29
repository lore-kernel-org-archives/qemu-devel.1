Received: from eggs.gnu.org ([2001:4830:134:3::10]:49857)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYsIh-0004bU-Dc
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYsId-0001K7-7p
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 08:14:55 -0400
Date: Fri, 29 Jun 2018 14:14:49 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180629045931.GJ3422@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806291410520.18342@zero.eik.bme.hu>
References: <cover.1530225513.git.balaton@eik.bme.hu>
	<beba73ec147c790500c6a57e405d5c5f83899af1.1530225513.git.balaton@eik.bme.hu>
	<20180629044840.GH3422@umbus.fritz.box>
	<20180629045931.GJ3422@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v6 4/5] ppc440_uc: Basic
 emulation of PPC440 DMA controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Cedric Le Goater <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On Fri, 29 Jun 2018, David Gibson wrote:
> On Fri, Jun 29, 2018 at 02:48:40PM +1000, David Gibson wrote:
>> On Fri, Jun 29, 2018 at 12:38:33AM +0200, BALATON Zoltan wrote:
>>> PPC440 SoCs such as the AMCC 460EX have a DMA controller which is use=
d
>>> by AmigaOS on the sam460ex. Implement the parts used by AmigaOS so it
>>> can get further booting on the sam460ex machine.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> v6:
>>> - CamelCase type names
>>> - Check return value of cpu_physical_memory_map
>>
>> I don't really have the knowledge to review this, but since it's a new
>> device that no-one else is using, I've applied it.
>
> I take that back.  This breaks compile for me with:
>
>  CC      ppc-softmmu/hw/ppc/ppc440_uc.o
> /home/dwg/src/qemu/hw/ppc/ppc440_uc.c: In function =E2=80=98dcr_write_d=
ma=E2=80=99:
> /home/dwg/src/qemu/hw/ppc/ppc440_uc.c:907:35: error: =E2=80=98sidx=E2=80=
=99 may be used uninitialized in this function [-Werror=3Dmaybe-uninitial=
ized]
>                     int width, i, sidx, didx;
>                                   ^~~~
> /home/dwg/src/qemu/hw/ppc/ppc440_uc.c:935:25: error: =E2=80=98didx=E2=80=
=99 may be used uninitialized in this function [-Werror=3Dmaybe-uninitial=
ized]
>                         cpu_physical_memory_unmap(wptr, wlen, 1, didx);
>                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> gcc 8.1.1 on Fedora 28.

Sorry, this was introduced in v6 when trying to handle return values from=
=20
cpu_physical_memory_map. I've sent a v7 of just this patch that should fi=
x=20
this.

There was also a 5/5 in this series which is useful even by itself withou=
t=20
the OpenBIOS patch as it allows MorphOS to get further on sam460ex even i=
f=20
it's not booting yet. Just let you know, that it's not tied to the=20
OpenBIOS change in case this wasn't clear from the commit message.

Thank you,
BALATON Zoltan

>
>>
>>>
>>>  hw/ppc/ppc440.h    |   1 +
>>>  hw/ppc/ppc440_uc.c | 221 +++++++++++++++++++++++++++++++++++++++++++=
++++++++++
>>>  hw/ppc/sam460ex.c  |   3 +
>>>  3 files changed, 225 insertions(+)
>>>
>>> diff --git a/hw/ppc/ppc440.h b/hw/ppc/ppc440.h
>>> index ad27db1..7cef936 100644
>>> --- a/hw/ppc/ppc440.h
>>> +++ b/hw/ppc/ppc440.h
>>> @@ -21,6 +21,7 @@ void ppc440_sdram_init(CPUPPCState *env, int nbanks=
,
>>>                         hwaddr *ram_bases, hwaddr *ram_sizes,
>>>                         int do_init);
>>>  void ppc4xx_ahb_init(CPUPPCState *env);
>>> +void ppc4xx_dma_init(CPUPPCState *env, int dcr_base);
>>>  void ppc460ex_pcie_init(CPUPPCState *env);
>>>
>>>  #endif /* PPC440_H */
>>> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
>>> index 123f4ac..97808ce 100644
>>> --- a/hw/ppc/ppc440_uc.c
>>> +++ b/hw/ppc/ppc440_uc.c
>>> @@ -13,6 +13,7 @@
>>>  #include "qemu/cutils.h"
>>>  #include "qemu/error-report.h"
>>>  #include "qapi/error.h"
>>> +#include "qemu/log.h"
>>>  #include "cpu.h"
>>>  #include "hw/hw.h"
>>>  #include "exec/address-spaces.h"
>>> @@ -803,6 +804,226 @@ void ppc4xx_ahb_init(CPUPPCState *env)
>>>  }
>>>
>>>  /*******************************************************************=
**********/
>>> +/* DMA controller */
>>> +
>>> +#define DMA0_CR_CE  (1 << 31)
>>> +#define DMA0_CR_PW  (1 << 26 | 1 << 25)
>>> +#define DMA0_CR_DAI (1 << 24)
>>> +#define DMA0_CR_SAI (1 << 23)
>>> +#define DMA0_CR_DEC (1 << 2)
>>> +
>>> +enum {
>>> +    DMA0_CR  =3D 0x00,
>>> +    DMA0_CT,
>>> +    DMA0_SAH,
>>> +    DMA0_SAL,
>>> +    DMA0_DAH,
>>> +    DMA0_DAL,
>>> +    DMA0_SGH,
>>> +    DMA0_SGL,
>>> +
>>> +    DMA0_SR  =3D 0x20,
>>> +    DMA0_SGC =3D 0x23,
>>> +    DMA0_SLP =3D 0x25,
>>> +    DMA0_POL =3D 0x26,
>>> +};
>>> +
>>> +typedef struct {
>>> +    uint32_t cr;
>>> +    uint32_t ct;
>>> +    uint64_t sa;
>>> +    uint64_t da;
>>> +    uint64_t sg;
>>> +} PPC4xxDmaChnl;
>>> +
>>> +typedef struct {
>>> +    int base;
>>> +    PPC4xxDmaChnl ch[4];
>>> +    uint32_t sr;
>>> +} PPC4xxDmaState;
>>> +
>>> +static uint32_t dcr_read_dma(void *opaque, int dcrn)
>>> +{
>>> +    PPC4xxDmaState *dma =3D opaque;
>>> +    uint32_t val =3D 0;
>>> +    int addr =3D dcrn - dma->base;
>>> +    int chnl =3D addr / 8;
>>> +
>>> +    switch (addr) {
>>> +    case 0x00 ... 0x1f:
>>> +        switch (addr % 8) {
>>> +        case DMA0_CR:
>>> +            val =3D dma->ch[chnl].cr;
>>> +            break;
>>> +        case DMA0_CT:
>>> +            val =3D dma->ch[chnl].ct;
>>> +            break;
>>> +        case DMA0_SAH:
>>> +            val =3D dma->ch[chnl].sa >> 32;
>>> +            break;
>>> +        case DMA0_SAL:
>>> +            val =3D dma->ch[chnl].sa;
>>> +            break;
>>> +        case DMA0_DAH:
>>> +            val =3D dma->ch[chnl].da >> 32;
>>> +            break;
>>> +        case DMA0_DAL:
>>> +            val =3D dma->ch[chnl].da;
>>> +            break;
>>> +        case DMA0_SGH:
>>> +            val =3D dma->ch[chnl].sg >> 32;
>>> +            break;
>>> +        case DMA0_SGL:
>>> +            val =3D dma->ch[chnl].sg;
>>> +            break;
>>> +        }
>>> +        break;
>>> +    case DMA0_SR:
>>> +        val =3D dma->sr;
>>> +        break;
>>> +    default:
>>> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented register %x (%d,=
 %x)\n",
>>> +                      __func__, dcrn, chnl, addr);
>>> +    }
>>> +
>>> +    return val;
>>> +}
>>> +
>>> +static void dcr_write_dma(void *opaque, int dcrn, uint32_t val)
>>> +{
>>> +    PPC4xxDmaState *dma =3D opaque;
>>> +    int addr =3D dcrn - dma->base;
>>> +    int chnl =3D addr / 8;
>>> +
>>> +    switch (addr) {
>>> +    case 0x00 ... 0x1f:
>>> +        switch (addr % 8) {
>>> +        case DMA0_CR:
>>> +            dma->ch[chnl].cr =3D val;
>>> +            if (val & DMA0_CR_CE) {
>>> +                int count =3D dma->ch[chnl].ct & 0xffff;
>>> +
>>> +                if (count) {
>>> +                    int width, i, sidx, didx;
>>> +                    uint8_t *rptr, *wptr;
>>> +                    hwaddr rlen, wlen;
>>> +
>>> +                    width =3D 1 << ((val & DMA0_CR_PW) >> 25);
>>> +                    rptr =3D cpu_physical_memory_map(dma->ch[chnl].s=
a, &rlen, 0);
>>> +                    wptr =3D cpu_physical_memory_map(dma->ch[chnl].d=
a, &wlen, 1);
>>> +                    if (rptr && wptr) {
>>> +                        if (!(val & DMA0_CR_DEC) &&
>>> +                            val & DMA0_CR_SAI && val & DMA0_CR_DAI) =
{
>>> +                            /* optimise common case */
>>> +                            memmove(wptr, rptr, count * width);
>>> +                            sidx =3D didx =3D count * width;
>>> +                        } else {
>>> +                            /* do it the slow way */
>>> +                            for (sidx =3D didx =3D i =3D 0; i < coun=
t; i++) {
>>> +                                uint64_t v =3D ldn_le_p(rptr + sidx,=
 width);
>>> +                                stn_le_p(wptr + didx, width, v);
>>> +                                if (val & DMA0_CR_SAI) {
>>> +                                    sidx +=3D width;
>>> +                                }
>>> +                                if (val & DMA0_CR_DAI) {
>>> +                                    didx +=3D width;
>>> +                                }
>>> +                            }
>>> +                        }
>>> +                    }
>>> +                    if (wptr) {
>>> +                        cpu_physical_memory_unmap(wptr, wlen, 1, did=
x);
>>> +                    }
>>> +                    if (wptr) {
>>> +                        cpu_physical_memory_unmap(rptr, rlen, 0, sid=
x);
>>> +                    }
>>> +                }
>>> +            }
>>> +            break;
>>> +        case DMA0_CT:
>>> +            dma->ch[chnl].ct =3D val;
>>> +            break;
>>> +        case DMA0_SAH:
>>> +            dma->ch[chnl].sa &=3D 0xffffffffULL;
>>> +            dma->ch[chnl].sa |=3D (uint64_t)val << 32;
>>> +            break;
>>> +        case DMA0_SAL:
>>> +            dma->ch[chnl].sa &=3D 0xffffffff00000000ULL;
>>> +            dma->ch[chnl].sa |=3D val;
>>> +            break;
>>> +        case DMA0_DAH:
>>> +            dma->ch[chnl].da &=3D 0xffffffffULL;
>>> +            dma->ch[chnl].da |=3D (uint64_t)val << 32;
>>> +            break;
>>> +        case DMA0_DAL:
>>> +            dma->ch[chnl].da &=3D 0xffffffff00000000ULL;
>>> +            dma->ch[chnl].da |=3D val;
>>> +            break;
>>> +        case DMA0_SGH:
>>> +            dma->ch[chnl].sg &=3D 0xffffffffULL;
>>> +            dma->ch[chnl].sg |=3D (uint64_t)val << 32;
>>> +            break;
>>> +        case DMA0_SGL:
>>> +            dma->ch[chnl].sg &=3D 0xffffffff00000000ULL;
>>> +            dma->ch[chnl].sg |=3D val;
>>> +            break;
>>> +        }
>>> +        break;
>>> +    case DMA0_SR:
>>> +        dma->sr &=3D ~val;
>>> +        break;
>>> +    default:
>>> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented register %x (%d,=
 %x)\n",
>>> +                      __func__, dcrn, chnl, addr);
>>> +    }
>>> +}
>>> +
>>> +static void ppc4xx_dma_reset(void *opaque)
>>> +{
>>> +    PPC4xxDmaState *dma =3D opaque;
>>> +    int dma_base =3D dma->base;
>>> +
>>> +    memset(dma, 0, sizeof(*dma));
>>> +    dma->base =3D dma_base;
>>> +}
>>> +
>>> +void ppc4xx_dma_init(CPUPPCState *env, int dcr_base)
>>> +{
>>> +    PPC4xxDmaState *dma;
>>> +    int i;
>>> +
>>> +    dma =3D g_malloc0(sizeof(*dma));
>>> +    dma->base =3D dcr_base;
>>> +    qemu_register_reset(&ppc4xx_dma_reset, dma);
>>> +    for (i =3D 0; i < 4; i++) {
>>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_CR,
>>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_CT,
>>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SAH,
>>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SAL,
>>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_DAH,
>>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_DAL,
>>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SGH,
>>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SGL,
>>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>>> +    }
>>> +    ppc_dcr_register(env, dcr_base + DMA0_SR,
>>> +                     dma, &dcr_read_dma, &dcr_write_dma);
>>> +    ppc_dcr_register(env, dcr_base + DMA0_SGC,
>>> +                     dma, &dcr_read_dma, &dcr_write_dma);
>>> +    ppc_dcr_register(env, dcr_base + DMA0_SLP,
>>> +                     dma, &dcr_read_dma, &dcr_write_dma);
>>> +    ppc_dcr_register(env, dcr_base + DMA0_POL,
>>> +                     dma, &dcr_read_dma, &dcr_write_dma);
>>> +}
>>> +
>>> +/*******************************************************************=
**********/
>>>  /* PCI Express controller */
>>>  /* FIXME: This is not complete and does not work, only implemented p=
artially
>>>   * to allow firmware and guests to find an empty bus. Cards should u=
se PCI.
>>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>>> index dc730cc..4f9248e 100644
>>> --- a/hw/ppc/sam460ex.c
>>> +++ b/hw/ppc/sam460ex.c
>>> @@ -477,6 +477,9 @@ static void sam460ex_init(MachineState *machine)
>>>      /* MAL */
>>>      ppc4xx_mal_init(env, 4, 16, &uic[2][3]);
>>>
>>> +    /* DMA */
>>> +    ppc4xx_dma_init(env, 0x200);
>>> +
>>>      /* 256K of L2 cache as memory */
>>>      ppc4xx_l2sram_init(env);
>>>      /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.c=
? */
>>
>
>
>
>
