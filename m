Received: from eggs.gnu.org ([2001:4830:134:3::10]:42963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYXrI-00053c-Vz
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:25:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fYXrE-00045A-Uq
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 10:25:16 -0400
Date: Thu, 28 Jun 2018 16:25:03 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <329752f5-b669-6463-19b4-fe2f05844b7c@kaod.org>
Message-ID: <alpine.BSF.2.21.1806281614480.26695@zero.eik.bme.hu>
References: <cover.1529839203.git.balaton@eik.bme.hu>
	<c6aeb6ab4bea16b3ad4d4f213fe8f79f61717cb7.1529839203.git.balaton@eik.bme.hu>
	<329752f5-b669-6463-19b4-fe2f05844b7c@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v5 4/4] ppc440_uc: Basic
 emulation of PPC440 DMA controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Thu, 28 Jun 2018, C=C3=A9dric Le Goater wrote:
> On 06/24/2018 01:20 PM, BALATON Zoltan wrote:
>> PPC440 SoCs such as the AMCC 460EX have a DMA controller which is used
>> by AmigaOS on the sam460ex. Implement the parts used by AmigaOS so it
>> can get further booting on the sam460ex machine.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  hw/ppc/ppc440.h    |   1 +
>>  hw/ppc/ppc440_uc.c | 215 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  hw/ppc/sam460ex.c  |   3 +
>>  3 files changed, 219 insertions(+)
>>
>> diff --git a/hw/ppc/ppc440.h b/hw/ppc/ppc440.h
>> index ad27db1..7cef936 100644
>> --- a/hw/ppc/ppc440.h
>> +++ b/hw/ppc/ppc440.h
>> @@ -21,6 +21,7 @@ void ppc440_sdram_init(CPUPPCState *env, int nbanks,
>>                         hwaddr *ram_bases, hwaddr *ram_sizes,
>>                         int do_init);
>>  void ppc4xx_ahb_init(CPUPPCState *env);
>> +void ppc4xx_dma_init(CPUPPCState *env, int dcr_base);
>>  void ppc460ex_pcie_init(CPUPPCState *env);
>>
>>  #endif /* PPC440_H */
>> diff --git a/hw/ppc/ppc440_uc.c b/hw/ppc/ppc440_uc.c
>> index 123f4ac..38aadd9 100644
>> --- a/hw/ppc/ppc440_uc.c
>> +++ b/hw/ppc/ppc440_uc.c
>> @@ -13,6 +13,7 @@
>>  #include "qemu/cutils.h"
>>  #include "qemu/error-report.h"
>>  #include "qapi/error.h"
>> +#include "qemu/log.h"
>>  #include "cpu.h"
>>  #include "hw/hw.h"
>>  #include "exec/address-spaces.h"
>> @@ -803,6 +804,220 @@ void ppc4xx_ahb_init(CPUPPCState *env)
>>  }
>>
>>  /********************************************************************=
*********/
>> +/* DMA controller */
>> +
>> +#define DMA0_CR_CE  (1 << 31)
>> +#define DMA0_CR_PW  (1 << 26 | 1 << 25)
>> +#define DMA0_CR_DAI (1 << 24)
>> +#define DMA0_CR_SAI (1 << 23)
>> +#define DMA0_CR_DEC (1 << 2)
>> +
>> +enum {
>> +    DMA0_CR  =3D 0x00,
>> +    DMA0_CT,
>> +    DMA0_SAH,
>> +    DMA0_SAL,
>> +    DMA0_DAH,
>> +    DMA0_DAL,
>> +    DMA0_SGH,
>> +    DMA0_SGL,
>> +
>> +    DMA0_SR  =3D 0x20,
>> +    DMA0_SGC =3D 0x23,
>> +    DMA0_SLP =3D 0x25,
>> +    DMA0_POL =3D 0x26,
>> +};
>> +
>> +typedef struct {
>> +    uint32_t cr;
>> +    uint32_t ct;
>> +    uint64_t sa;
>> +    uint64_t da;
>> +    uint64_t sg;
>> +} ppc4xx_dma_ch_t;
>
> You need to use CamelCase for the type names.

OK.

>> +typedef struct {
>> +    int base;
>> +    ppc4xx_dma_ch_t ch[4];
>> +    uint32_t sr;
>> +} ppc4xx_dma_t;
>
>
> Can't you QOM'ify the model ?

Maybe I could but none of these SoC models are QOMified yet so maybe it=20
would be better to do that as separate patch after thinking about how to=20
model this correctly. So now this just follows the existing way which I=20
prefer versus mixing QOM and old style devices models in a single SoC=20
without clear plan to QOMify everything. Hope this won't block this patch=
=20
and then QOMification could be done as separate cleanup series. (These So=
C=20
models will need to be cleaned up eventually but for now getting it work=20
was my priority.)

>> +static uint32_t dcr_read_dma(void *opaque, int dcrn)
>> +{
>> +    ppc4xx_dma_t *dma =3D opaque;
>> +    uint32_t val =3D 0;
>> +    int addr =3D dcrn - dma->base;
>> +    int chnl =3D addr / 8;
>> +
>> +    switch (addr) {
>> +    case 0x00 ... 0x1f:
>> +        switch (addr % 8) {
>> +        case DMA0_CR:
>> +            val =3D dma->ch[chnl].cr;
>> +            break;
>> +        case DMA0_CT:
>> +            val =3D dma->ch[chnl].ct;
>> +            break;
>> +        case DMA0_SAH:
>> +            val =3D dma->ch[chnl].sa >> 32;
>> +            break;
>> +        case DMA0_SAL:
>> +            val =3D dma->ch[chnl].sa;
>> +            break;
>> +        case DMA0_DAH:
>> +            val =3D dma->ch[chnl].da >> 32;
>> +            break;
>> +        case DMA0_DAL:
>> +            val =3D dma->ch[chnl].da;
>> +            break;
>> +        case DMA0_SGH:
>> +            val =3D dma->ch[chnl].sg >> 32;
>> +            break;
>> +        case DMA0_SGL:
>> +            val =3D dma->ch[chnl].sg;
>> +            break;
>> +        }
>> +        break;
>> +    case DMA0_SR:
>> +        val =3D dma->sr;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented register %x (%d, =
%x)\n",
>> +                      __func__, dcrn, chnl, addr);
>> +    }
>> +
>> +    return val;
>> +}
>> +
>> +static void dcr_write_dma(void *opaque, int dcrn, uint32_t val)
>> +{
>> +    ppc4xx_dma_t *dma =3D opaque;
>> +    int addr =3D dcrn - dma->base;
>> +    int chnl =3D addr / 8;
>> +
>> +    switch (addr) {
>> +    case 0x00 ... 0x1f:
>> +        switch (addr % 8) {
>> +        case DMA0_CR:
>> +            dma->ch[chnl].cr =3D val;
>> +            if (val & DMA0_CR_CE) {
>> +                int count =3D dma->ch[chnl].ct & 0xffff;
>> +
>> +                if (count) {
>> +                    int width, i, sidx, didx;
>> +                    uint8_t *rptr, *wptr;
>> +                    hwaddr rlen, wlen;
>> +
>> +                    width =3D 1 << ((val & DMA0_CR_PW) >> 25);
>> +                    rptr =3D cpu_physical_memory_map(dma->ch[chnl].sa=
, &rlen, 0);
>> +                    wptr =3D cpu_physical_memory_map(dma->ch[chnl].da=
, &wlen, 1);
>
> you don't need necessarily to map. You could just use cpu_physical_memo=
ry_rw

Would that also update dirty bitmap as unmap does? Also this way I can us=
e=20
memmove to optimise common case so this looked better but I'm not sure=20
about which is the best way to implement this.

>
>> +                    if (!(val & DMA0_CR_DEC) &&
>> +                        val & DMA0_CR_SAI && val & DMA0_CR_DAI) {
>
> some extra () would help reading the if.

This is personal taste I guess, I've seen other reviewers ask for less ()=
=20
in the past. I don't mind either way, David what do you prefer as=20
maintainer?

>> +                        /* optimise common case */
>> +                        memmove(wptr, rptr, count * width);
>> +                        sidx =3D didx =3D count * width;
>> +                    } else {
>> +                        /* do it the slow way */
>> +                        for (sidx =3D didx =3D i =3D 0; i < count; i+=
+) {
>> +                            uint64_t v =3D ldn_le_p(rptr + sidx, widt=
h);
>> +                            stn_le_p(wptr + didx, width, v);
>> +                            if (val & DMA0_CR_SAI) {
>> +                                sidx +=3D width;
>> +                            }
>> +                            if (val & DMA0_CR_DAI) {
>> +                                didx +=3D width;
>> +                            }
>> +                        }
>> +                    }
>> +                    cpu_physical_memory_unmap(wptr, wlen, 1, didx);
>> +                    cpu_physical_memory_unmap(rptr, rlen, 0, sidx);
>> +                }
>> +            }
>
> I would put all this code doing the dma in its own routine.

I could do that but it's pretty simple so maybe does not worth splitting=20
out yet. Maybe when model is ever improved to handle more exotic cases an=
d=20
this gets mode complex, if a guest actually using those found.

Thank you for the review,
BALATON Zoltan

>> +            break;
>> +        case DMA0_CT:
>> +            dma->ch[chnl].ct =3D val;
>> +            break;
>> +        case DMA0_SAH:
>> +            dma->ch[chnl].sa &=3D 0xffffffffULL;
>> +            dma->ch[chnl].sa |=3D (uint64_t)val << 32;
>> +            break;
>> +        case DMA0_SAL:
>> +            dma->ch[chnl].sa &=3D 0xffffffff00000000ULL;
>> +            dma->ch[chnl].sa |=3D val;
>> +            break;
>> +        case DMA0_DAH:
>> +            dma->ch[chnl].da &=3D 0xffffffffULL;
>> +            dma->ch[chnl].da |=3D (uint64_t)val << 32;
>> +            break;
>> +        case DMA0_DAL:
>> +            dma->ch[chnl].da &=3D 0xffffffff00000000ULL;
>> +            dma->ch[chnl].da |=3D val;
>> +            break;
>> +        case DMA0_SGH:
>> +            dma->ch[chnl].sg &=3D 0xffffffffULL;
>> +            dma->ch[chnl].sg |=3D (uint64_t)val << 32;
>> +            break;
>> +        case DMA0_SGL:
>> +            dma->ch[chnl].sg &=3D 0xffffffff00000000ULL;
>> +            dma->ch[chnl].sg |=3D val;
>> +            break;
>> +        }
>> +        break;
>> +    case DMA0_SR:
>> +        dma->sr &=3D ~val;
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented register %x (%d, =
%x)\n",
>> +                      __func__, dcrn, chnl, addr);
>> +    }
>> +}
>> +
>> +static void ppc4xx_dma_reset(void *opaque)
>> +{
>> +    ppc4xx_dma_t *dma =3D opaque;
>> +    int dma_base =3D dma->base;
>> +
>> +    memset(dma, 0, sizeof(*dma));
>> +    dma->base =3D dma_base;
>> +}
>> +
>> +void ppc4xx_dma_init(CPUPPCState *env, int dcr_base)
>> +{
>> +    ppc4xx_dma_t *dma;
>> +    int i;
>> +
>> +    dma =3D g_malloc0(sizeof(*dma));
>
> Can't you QOM'ify the model ? A part from that it looks correct.
>
> Thanks,
>
> C.
>
>> +    dma->base =3D dcr_base;
>> +    qemu_register_reset(&ppc4xx_dma_reset, dma);
>> +    for (i =3D 0; i < 4; i++) {
>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_CR,
>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_CT,
>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SAH,
>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SAL,
>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_DAH,
>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_DAL,
>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SGH,
>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>> +        ppc_dcr_register(env, dcr_base + i * 8 + DMA0_SGL,
>> +                         dma, &dcr_read_dma, &dcr_write_dma);
>> +    }
>> +    ppc_dcr_register(env, dcr_base + DMA0_SR,
>> +                     dma, &dcr_read_dma, &dcr_write_dma);
>> +    ppc_dcr_register(env, dcr_base + DMA0_SGC,
>> +                     dma, &dcr_read_dma, &dcr_write_dma);
>> +    ppc_dcr_register(env, dcr_base + DMA0_SLP,
>> +                     dma, &dcr_read_dma, &dcr_write_dma);
>> +    ppc_dcr_register(env, dcr_base + DMA0_POL,
>> +                     dma, &dcr_read_dma, &dcr_write_dma);
>> +}
>> +
>> +/********************************************************************=
*********/
>>  /* PCI Express controller */
>>  /* FIXME: This is not complete and does not work, only implemented pa=
rtially
>>   * to allow firmware and guests to find an empty bus. Cards should us=
e PCI.
>> diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
>> index dc730cc..4f9248e 100644
>> --- a/hw/ppc/sam460ex.c
>> +++ b/hw/ppc/sam460ex.c
>> @@ -477,6 +477,9 @@ static void sam460ex_init(MachineState *machine)
>>      /* MAL */
>>      ppc4xx_mal_init(env, 4, 16, &uic[2][3]);
>>
>> +    /* DMA */
>> +    ppc4xx_dma_init(env, 0x200);
>> +
>>      /* 256K of L2 cache as memory */
>>      ppc4xx_l2sram_init(env);
>>      /* FIXME: remove this after fixing l2sram mapping in ppc440_uc.c?=
 */
>>
>
>
