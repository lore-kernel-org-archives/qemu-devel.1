Received: from eggs.gnu.org ([2001:4830:134:3::10]:34943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etwWG-0004LH-7c
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:27:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1etwWE-0006f4-5G
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:27:44 -0500
Received: from mail-ot0-x22a.google.com ([2607:f8b0:4003:c0f::22a]:41158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1etwWD-0006eg-Tu
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 09:27:42 -0500
Received: by mail-ot0-x22a.google.com with SMTP id w38so5521791ota.8
	for <qemu-devel@nongnu.org>; Thu, 08 Mar 2018 06:27:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1518893216-9983-5-git-send-email-eric.auger@redhat.com>
References: <1518893216-9983-1-git-send-email-eric.auger@redhat.com>
	<1518893216-9983-5-git-send-email-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Mar 2018 14:27:20 +0000
Message-ID: <CAFEAcA871Ju5cV8EYiXEg65Rofh=Pn2=2h8wy4-QXj-wUzoj+g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v9 04/14] hw/arm/smmuv3: Skeleton
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Prem Mallappa <prem.mallappa@gmail.com>, Alex Williamson <alex.williamson@redhat.com>, Tomasz Nowicki <tn@semihalf.com>, "Michael S. Tsirkin" <mst@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Bharat Bhushan <bharat.bhushan@nxp.com>, Jean-Philippe Brucker <jean-philippe.brucker@arm.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, linuc.decode@gmail.com, Peter Xu <peterx@redhat.com>

On 17 February 2018 at 18:46, Eric Auger <eric.auger@redhat.com> wrote:
> From: Prem Mallappa <prem.mallappa@broadcom.com>
>
> This patch implements a skeleton for the smmuv3 device.
> Datatypes and register definitions are introduced. The MMIO
> region, the interrupts and the queue are initialized.
>
> Only the MMIO read operation is implemented here.
>
> Signed-off-by: Prem Mallappa <prem.mallappa@broadcom.com>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>


I just have a few minor nits on this one...


> +static inline int smmu_enabled(SMMUv3State *s)
> +{
> +    return FIELD_EX32(s->cr[0], CR0, SMMU_ENABLE);
> +}
> +
> +typedef struct Cmd {
> +    uint32_t word[4];
> +} Cmd;
> +
> +typedef struct Evt  {
> +    uint32_t word[8];
> +} Evt;

Some one-liner comments noting what these structs are for
would be helpful.

> +
> +static inline uint64_t smmu_read64(uint64_t r, unsigned offset,
> +                                   unsigned size)

A doc comment here would help in describing what the purpose of
this utility function is.

> +{
> +    if (size =3D=3D 8 && !offset) {
> +        return r;

If you take my advice a bit further down about just checking
up front that 8-byte accesses are to definitely permitted 64
bit register offsets, you won't need the check on offset.

> +    }
> +
> +    /* 32 bit access */
> +
> +    if (offset && offset !=3D 4)  {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "SMMUv3 MMIO read: bad offset/size %u/%u\n",
> +                      offset, size);

This isn't a guest error, because the function is only ever called
with constant values for the 'offset' parameter. You should just
assert that the offset is 0 or 4.

> +        return 0;
> +    }
> +
> +    return extract64(r, offset << 3, 32);
> +}
> +
> +#endif

> +static void smmuv3_init_regs(SMMUv3State *s)
> +{
> +    /**
> +     * IDR0: stage1 only, AArch64 only, coherent access, 16b ASID,
> +     *       multi-level stream table
> +     */
> +    s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, S1P, 1); /* stage 1 suppor=
ted */
> +    s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, TTF, 2); /* AArch64 PTW on=
ly */
> +    s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, COHACC, 1); /* IO coherent=
 */
> +    s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, ASID16, 1); /* 16-bit ASID=
 */
> +    s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, TTENDIAN, 2); /* little en=
dian */
> +    s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, STALL_MODEL, 1); /* No sta=
ll */
> +    /* terminated transaction will always be aborted/error returned */
> +    s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, TERM_MODEL, 1);
> +    /* 2-level stream table supported */
> +    s->idr[0] =3D FIELD_DP32(s->idr[0], IDR0, STLEVEL, 1);
> +
> +    s->idr[1] =3D FIELD_DP32(s->idr[1], IDR1, SIDSIZE, SMMU_IDR1_SIDSIZE=
);
> +    s->idr[1] =3D FIELD_DP32(s->idr[1], IDR1, EVENTQS, 19);
> +    s->idr[1] =3D FIELD_DP32(s->idr[1], IDR1, CMDQS,   19);
> +
> +   /* 4K and 64K granule support */
> +    s->idr[5] =3D FIELD_DP32(s->idr[5], IDR5, GRAN4K, 1);
> +    s->idr[5] =3D FIELD_DP32(s->idr[5], IDR5, GRAN64K, 1);
> +    s->idr[5] =3D FIELD_DP32(s->idr[5], IDR5, OAS, SMMU_IDR5_OAS); /* 44=
 bits */
> +
> +    s->cmdq.base =3D deposit64(s->cmdq.base, 0, 5, 19); /* LOG2SIZE =3D =
19 */
> +    s->cmdq.prod =3D 0;
> +    s->cmdq.cons =3D 0;
> +    s->cmdq.entry_size =3D sizeof(struct Cmd);
> +    s->eventq.base =3D deposit64(s->eventq.base, 0, 5, 19); /* LOG2SIZE =
=3D 19 */

Have some #defines for max cmd queue and event queue size, since
we use them here and also above in filling in the IDR fields ?

> +    s->eventq.prod =3D 0;
> +    s->eventq.cons =3D 0;
> +    s->eventq.entry_size =3D sizeof(struct Evt);
> +
> +    s->features =3D 0;
> +    s->sid_split =3D 0;
> +}
> +
> +static void smmu_write_mmio(void *opaque, hwaddr addr,
> +                            uint64_t val, unsigned size)
> +{
> +    /* not yet implemented */
> +}
> +
> +static uint64_t smmu_read_mmio(void *opaque, hwaddr addr, unsigned size)
> +{
> +    SMMUState *sys =3D opaque;
> +    SMMUv3State *s =3D ARM_SMMUV3(sys);
> +    uint64_t val;
> +
> +    /* CONSTRAINED UNPREDICTABLE choice to have page0/1 be exact aliases=
 */
> +    addr &=3D ~0x10000;
> +
> +    if (size !=3D 4 && size !=3D 8) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "SMMUv3 MMIO read: bad size %u\n"=
, size);

Your MemoryRegionOps settings mean this can never happen, so you
don't need to check it at runtime.

> +        return 0;
> +    }

Consider specifically catching 8-byte accesses to non-64-bit registers?
This is CONSTRAINED UNPREDICTABLE (see spec section 6.2), and "one
of the registers is read/written and other half is RAZ/WI" is permitted
behaviour, but it does mean you need to be a little careful about not
letting the top 32 bits of val become non-zero for the 32-bit register
codepaths. Logging bad 64-bit accesses as LOG_GUEST_ERROR and making
them RAZ/WI might be nicer for guest software developers.

> +
> +    /* Primecell/Corelink ID registers */
> +    switch (addr) {
> +    case A_CIDR0:
> +        val =3D 0x0D;
> +        break;
> +    case A_CIDR1:
> +        val =3D 0xF0;
> +        break;
> +    case A_CIDR2:
> +        val =3D 0x05;
> +        break;
> +    case A_CIDR3:
> +        val =3D 0xB1;
> +        break;
> +    case A_PIDR0:
> +        val =3D 0x84; /* Part Number */
> +        break;
> +    case A_PIDR1:
> +        val =3D 0xB4; /* JEP106 ID code[3:0] for Arm and Part numver[11:=
8] */
> +        break;
> +    case A_PIDR3:
> +        val =3D 0x10; /* MMU600 p1 */
> +        break;
> +    case A_PIDR4:
> +        val =3D 0x4; /* 4KB region count, JEP106 continuation code for A=
rm */
> +        break;
> +    case 0xFD4 ... 0xFDC: /* SMMU_PDIR 5-7 */
> +        val =3D 0;
> +        break;

I usually put all the const CIDR/PIDR values in a const array, since
there are always 12 of them next to each other, but since you already
have this code it's fine.

> +    case A_IDR0 ... A_IDR5:
> +        val =3D s->idr[(addr - A_IDR0) / 4];
> +        break;
> +    case A_IIDR:
> +        val =3D s->iidr;
> +        break;
> +    case A_CR0:
> +        val =3D s->cr[0];
> +        break;
> +    case A_CR0ACK:
> +        val =3D s->cr0ack;
> +        break;
> +    case A_CR1:
> +        val =3D s->cr[1];
> +        break;
> +    case A_CR2:
> +        val =3D s->cr[2];
> +        break;
> +    case A_STATUSR:
> +        val =3D s->statusr;
> +        break;
> +    case A_IRQ_CTRL:
> +        val =3D s->irq_ctrl;
> +        break;
> +    case A_IRQ_CTRL_ACK:
> +        val =3D s->irq_ctrl_ack;
> +        break;
> +    case A_GERROR:
> +        val =3D s->gerror;
> +        break;
> +    case A_GERRORN:
> +        val =3D s->gerrorn;
> +        break;
> +    case A_GERROR_IRQ_CFG0: /* 64b */
> +        val =3D smmu_read64(s->gerror_irq_cfg0, 0, size);
> +        break;
> +    case A_GERROR_IRQ_CFG0 + 4:
> +        val =3D smmu_read64(s->gerror_irq_cfg0, 4, size);
> +        break;
> +    case A_GERROR_IRQ_CFG1:
> +        val =3D s->gerror_irq_cfg1;
> +        break;
> +    case A_GERROR_IRQ_CFG2:
> +        val =3D s->gerror_irq_cfg2;
> +        break;
> +    case A_STRTAB_BASE: /* 64b */
> +        val =3D smmu_read64(s->strtab_base, 0, size);
> +        break;
> +    case A_STRTAB_BASE + 4: /* 64b */
> +        val =3D smmu_read64(s->strtab_base, 4, size);
> +        break;
> +    case A_STRTAB_BASE_CFG:
> +        val =3D s->strtab_base_cfg;
> +        break;
> +    case A_CMDQ_BASE: /* 64b */
> +        val =3D smmu_read64(s->cmdq.base, 0, size);
> +        break;
> +    case A_CMDQ_BASE + 4:
> +        val =3D smmu_read64(s->cmdq.base, 4, size);
> +        break;
> +    case A_CMDQ_PROD:
> +        val =3D s->cmdq.prod;
> +        break;
> +    case A_CMDQ_CONS:
> +        val =3D s->cmdq.cons;
> +        break;
> +    case A_EVENTQ_BASE: /* 64b */
> +        val =3D smmu_read64(s->eventq.base, 0, size);
> +        break;
> +    case A_EVENTQ_BASE + 4: /* 64b */
> +        val =3D smmu_read64(s->eventq.base, 4, size);
> +        break;
> +    case A_EVENTQ_PROD:
> +        val =3D s->eventq.prod;
> +        break;
> +    case A_EVENTQ_CONS:
> +        val =3D s->eventq.cons;
> +        break;
> +    default:
> +        error_report("%s unhandled access at 0x%"PRIx64, __func__, addr)=
;

This should be a LOG_GUEST_ERROR (if there are registers we don't
implement, you can define the A_* constants for them and have those
do a LOG_UNIMP.)

> +        break;
> +    }
> +
> +    trace_smmuv3_read_mmio(addr, val, size);
> +    return val;
> +}
> +

> +static void smmu_realize(DeviceState *d, Error **errp)
> +{
> +    SMMUState *sys =3D ARM_SMMU(d);
> +    SMMUv3State *s =3D ARM_SMMUV3(sys);
> +    SMMUv3Class *c =3D ARM_SMMUV3_GET_CLASS(s);
> +    SysBusDevice *dev =3D SYS_BUS_DEVICE(d);
> +    Error *local_err =3D NULL;
> +
> +    c->parent_realize(d, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    memory_region_init_io(&sys->iomem, OBJECT(s),
> +                          &smmu_mem_ops, sys, TYPE_ARM_SMMUV3, 0x20000);
> +
> +    sys->mrtypename =3D g_strdup(TYPE_SMMUV3_IOMMU_MEMORY_REGION);

Nothing ever modifies this later, so I don't think you nede to
do the g_strdup() ?  (The declaration of the struct field should
probably have a 'const'.)

> +
> +    sysbus_init_mmio(dev, &sys->iomem);
> +
> +    smmu_init_irq(s, dev);
> +}
> +
> +static const VMStateDescription vmstate_smmuv3 =3D {
> +    .name =3D "smmuv3",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_UINT32(features, SMMUv3State),
> +        VMSTATE_UINT8(sid_size, SMMUv3State),
> +        VMSTATE_UINT8(sid_split, SMMUv3State),
> +
> +        VMSTATE_UINT32_ARRAY(idr, SMMUv3State, 6),

These are constant ID registers, right? You don't need to
migrate anything that's a fixed value set when the device
is created and never modified.

> +        VMSTATE_UINT32(iidr, SMMUv3State),
> +        VMSTATE_UINT32_ARRAY(cr, SMMUv3State, 3),
> +        VMSTATE_UINT32(cr0ack, SMMUv3State),
> +        VMSTATE_UINT32(statusr, SMMUv3State),
> +        VMSTATE_UINT32(irq_ctrl, SMMUv3State),
> +        VMSTATE_UINT32(irq_ctrl_ack, SMMUv3State),
> +        VMSTATE_UINT32(gerror, SMMUv3State),
> +        VMSTATE_UINT32(gerrorn, SMMUv3State),
> +        VMSTATE_UINT64(gerror_irq_cfg0, SMMUv3State),
> +        VMSTATE_UINT32(gerror_irq_cfg1, SMMUv3State),
> +        VMSTATE_UINT32(gerror_irq_cfg2, SMMUv3State),
> +        VMSTATE_UINT64(strtab_base, SMMUv3State),
> +        VMSTATE_UINT32(strtab_base_cfg, SMMUv3State),
> +        VMSTATE_UINT64(eventq_irq_cfg0, SMMUv3State),
> +        VMSTATE_UINT32(eventq_irq_cfg1, SMMUv3State),
> +        VMSTATE_UINT32(eventq_irq_cfg2, SMMUv3State),
> +
> +        VMSTATE_UINT64(cmdq.base, SMMUv3State),
> +        VMSTATE_UINT32(cmdq.prod, SMMUv3State),
> +        VMSTATE_UINT32(cmdq.cons, SMMUv3State),
> +        VMSTATE_UINT8(cmdq.entry_size, SMMUv3State),
> +        VMSTATE_UINT64(eventq.base, SMMUv3State),
> +        VMSTATE_UINT32(eventq.prod, SMMUv3State),
> +        VMSTATE_UINT32(eventq.cons, SMMUv3State),
> +        VMSTATE_UINT8(eventq.entry_size, SMMUv3State),

It's a little neater to define a separate VMStateDescription
for the SMMUQueue struct and then just use it twice here with
VMSTATE_STRUCT. (Example in hw/dma/pl330.c for vmstate_pl330_chan.)

Also, isn't the entry_size constant and fixed at device creation?
If so, you don't need to migrate it.

> +
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
> +static void smmuv3_instance_init(Object *obj)
> +{
> +    /* Nothing much to do here as of now */
> +}
> +
> +static void smmuv3_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    SMMUv3Class *c =3D ARM_SMMUV3_CLASS(klass);
> +
> +    dc->vmsd    =3D &vmstate_smmuv3;

It would be nice to go through the patchset and remove these
unnecessary extra spaces in various assignments and declarations.

> +    device_class_set_parent_reset(dc, smmu_reset, &c->parent_reset);
> +    c->parent_realize =3D dc->realize;
> +    dc->realize =3D smmu_realize;
> +}


> +type_init(smmuv3_register_types)
> +

Stray blank line at end of file.

> diff --git a/hw/arm/trace-events b/hw/arm/trace-events
> index 3584974..64d2b9b 100644
> --- a/hw/arm/trace-events
> +++ b/hw/arm/trace-events
> @@ -12,3 +12,6 @@ smmu_ptw_invalid_pte(int stage, int level, uint64_t bas=
eaddr, uint64_t pteaddr,
>  smmu_ptw_page_pte(int stage, int level,  uint64_t iova, uint64_t baseadd=
r, uint64_t pteaddr, uint64_t pte, uint64_t address) "stage=3D%d level=3D%d=
 iova=3D0x%"PRIx64" base@=3D0x%"PRIx64" pte@=3D0x%"PRIx64" pte=3D0x%"PRIx64=
" page address =3D 0x%"PRIx64
>  smmu_ptw_block_pte(int stage, int level, uint64_t baseaddr, uint64_t pte=
addr, uint64_t pte, uint64_t iova, uint64_t gpa, int bsize_mb) "stage=3D%d =
level=3D%d base@=3D0x%"PRIx64" pte@=3D0x%"PRIx64" pte=3D0x%"PRIx64" iova=3D=
0x%"PRIx64" block address =3D 0x%"PRIx64" block size =3D %d MiB"
>  smmu_get_pte(uint64_t baseaddr, int index, uint64_t pteaddr, uint64_t pt=
e) "baseaddr=3D0x%"PRIx64" index=3D0x%x, pteaddr=3D0x%"PRIx64", pte=3D0x%"P=
RIx64
> +
> +#hw/arm/smmuv3.c
> +smmuv3_read_mmio(hwaddr addr, uint64_t val, unsigned size) "addr: 0x%"PR=
Ix64" val:0x%"PRIx64" size: 0x%x"

"hwaddr" isn't valid as a type for trace event parameters. This should
be uint64_t; otherwise trace backends like 'ust' won't build. (There's a
patch on list to tracetool that will make this mistake a compile error
for all backends, so it's easier to catch.)


> +#ifndef HW_ARM_SMMUV3_H
> +#define HW_ARM_SMMUV3_H
> +
> +#include "hw/arm/smmu-common.h"
> +#include "hw/registerfields.h"
> +
> +#define TYPE_SMMUV3_IOMMU_MEMORY_REGION "smmuv3-iommu-memory-region"
> +
> +#define SMMU_NREGS            0x200
> +
> +typedef struct SMMUQueue {
> +     hwaddr base;
> +     uint32_t prod;
> +     uint32_t cons;
> +     uint8_t entry_size;
> +} SMMUQueue;
> +
> +typedef struct SMMUv3State {
> +    SMMUState     smmu_state;
> +
> +    /* Local cache of most-frequently used registers */
> +#define SMMU_FEATURE_2LVL_STE (1 << 0)

Minor thing, I think it would be better for this define to
not be in the middle of the struct definition.

> +    uint32_t features;
> +    uint8_t sid_size;
> +    uint8_t sid_split;
> +
> +    uint32_t idr[6];
> +    uint32_t iidr;
> +    uint32_t cr[3];
> +    uint32_t cr0ack;
> +    uint32_t statusr;
> +    uint32_t irq_ctrl;
> +    uint32_t irq_ctrl_ack;
> +    uint32_t gerror;
> +    uint32_t gerrorn;
> +    uint64_t gerror_irq_cfg0;
> +    uint32_t gerror_irq_cfg1;
> +    uint32_t gerror_irq_cfg2;
> +    uint64_t strtab_base;
> +    uint32_t strtab_base_cfg;
> +    uint64_t eventq_irq_cfg0;
> +    uint32_t eventq_irq_cfg1;
> +    uint32_t eventq_irq_cfg2;
> +
> +    SMMUQueue eventq, cmdq;
> +
> +    qemu_irq     irq[4];
> +} SMMUv3State;
> +
> +typedef enum {
> +    SMMU_IRQ_EVTQ,
> +    SMMU_IRQ_PRIQ,
> +    SMMU_IRQ_CMD_SYNC,
> +    SMMU_IRQ_GERROR,
> +} SMMUIrq;
> +
> +typedef struct {
> +    /*< private >*/
> +    SMMUBaseClass smmu_base_class;
> +    /*< public >*/
> +
> +    DeviceRealize parent_realize;
> +    DeviceReset   parent_reset;
> +} SMMUv3Class;
> +
> +#define TYPE_ARM_SMMUV3   "arm-smmuv3"
> +#define ARM_SMMUV3(obj) OBJECT_CHECK(SMMUv3State, (obj), TYPE_ARM_SMMUV3=
)
> +#define ARM_SMMUV3_CLASS(klass)                              \
> +    OBJECT_CLASS_CHECK(SMMUv3Class, (klass), TYPE_ARM_SMMUV3)
> +#define ARM_SMMUV3_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(SMMUv3Class, (obj), TYPE_ARM_SMMUV3)
> +
> +#endif

thanks
-- PMM
