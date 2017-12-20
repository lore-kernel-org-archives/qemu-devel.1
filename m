Received: from eggs.gnu.org ([2001:4830:134:3::10]:37184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRZD4-0002HW-6b
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:54:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eRZD0-0007EA-RI
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:54:38 -0500
Received: from 4.mo177.mail-out.ovh.net ([46.105.37.72]:38797)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eRZD0-0007DB-HK
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 02:54:34 -0500
Received: from player779.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id B8C3691AB8
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 08:54:32 +0100 (CET)
References: <20171209084338.29395-1-clg@kaod.org>
	<20171209084338.29395-4-clg@kaod.org>
	<20171220052225.GE5981@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b30dd81e-f09b-ffaf-450e-7a7d465a8eea@kaod.org>
Date: Wed, 20 Dec 2017 08:54:24 +0100
MIME-Version: 1.0
In-Reply-To: <20171220052225.GE5981@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 03/19] spapr: introduce the XIVE
 interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Greg Kurz <groug@kaod.org>

On 12/20/2017 06:22 AM, David Gibson wrote:
> On Sat, Dec 09, 2017 at 09:43:22AM +0100, C=E9dric Le Goater wrote:
>> Each XIVE interrupt source is associated with a two bit state machine
>> called an Event State Buffer (ESB) : the first bit "P" means that an
>> interrupt is "pending" and waiting for an EOI and the bit "Q" (queued)
>> means a new interrupt was triggered while another was still pending.
>>
>> When an event is triggered, the associated interrupt state bits are
>> fetched and modified and forwarded to the virtualization engine of the
>> controller doing the routing. These can also be controlled by MMIO, to
>> trigger events or turn off the sources for instance. See code for more
>> details on the states and transitions.
>>
>> The MMIO space for the ESBs is 512GB large on the bare-metal system
>> (PowerNV) and the BAR depends on the chip id. In our model for the
>> sPAPR machine, we choose to only map the sub-region for the
>> provisioned IRQ numbers and to use the mapping address of chip 0 of a
>> real system.
>=20
> I think we probably want a device property to make the virtualized
> base address arbitrary.  It's fine for it to default to the chip 0
> base, but that'll make it easier to adapt if we need to later on.

yes. We can add a "bar" property for this purpose like for some of=20
the pnv models

> As noted in the followup messages, I think you're going to want to
> move this stuff from the current xive object into a "block of sources"
> object.

yes. I have now a new Xive source model for the POWER9 PSIHB controller.
It should help to find common grounds. This is what I added to support
XIVE in the current PSIHB:

  +    /* P9 */
  +    MemoryRegion esb_iomem;
  +    uint8_t sbe[4]; /* enough for 13 P&Q bits */
  +    uint32_t ivt_offset;

The ESB region mapping is handled at the machine level as it depends=20
on the chip id.

The 'ivt_offset' is only used to forward the event notification to=20
the routine engine :

  +static void pnv_psi_notify(PnvPsi *psi, uint32_t lisn)
  +{
  +    uint64_t notif_port =3D
  +        psi->regs[PSIHB_REG(PSIHB9_ESB_NOTIF_ADDR)];
  +    bool valid =3D notif_port & PSIHB9_ESB_NOTIF_VALID;
  +    uint64_t notify_addr =3D notif_port & ~PSIHB9_ESB_NOTIF_VALID;
  +    uint32_t data =3D cpu_to_be32(psi->ivt_offset | lisn);
  +
  +    if (valid) {
  +        cpu_physical_memory_write(notify_addr, &data, sizeof(data));
  +    }
  +}

So It really depends on the controller type. I think that could be a=20
class handler.

Thanks,

C.=20


> Apart from that this looks pretty sound.
>=20
>> In the real world, each source may have different characteristics
>> depending on the revision of a controller or the CPU. Early systems
>> had two different MMIO pages for trigger and for EOI. We choose to use
>> the same characteristics for all sources to simplify the model. The
>> minimum CPU level for XIVE exploitation mode will be DD2.X as it has
>> full support.
>>
>> The OS will obtain the address of the MMIO page of the ESB entry
>> associated with a source and its characteristic using the
>> H_INT_GET_SOURCE_INFO hcall. This will be addressed in the patch
>> introducing the hcalls.
>>
>> The spapr_xive_irq() routine in charge of triggering the CPU interrupt
>> line will be filled later on.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>
>>  Changes since v1:
>>
>>  - merged in the same patch the qemu_irq handlers
>>  - reworked the event notification logic of the qemu_irq handlers. =20
>>  - introduced XIVE_ESB_STORE_EOI support
>>  - removed 'esb_shift' field=20
>>  - removed a useless check on the validity of the IVE in the memory
>>    region handlers.
>>  - fixed spapr_xive_pq_trigger() to return true when XIVE_ESB_QUEUED
>>    is set
>>  - removed the overall ESB memory region. We now have only one region
>>    for the provisioned sources.
>>  - improved 'info pic' output
>>
>>  hw/intc/spapr_xive.c        | 254 +++++++++++++++++++++++++++++++++++=
++++++++-
>>  hw/intc/xive-internal.h     |  10 ++
>>  include/hw/ppc/spapr_xive.h |   9 ++
>>  3 files changed, 271 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index e6e8841add17..43df6814619d 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -18,23 +18,252 @@
>> =20
>>  #include "xive-internal.h"
>> =20
>> +static void spapr_xive_irq(sPAPRXive *xive, int lisn)
>> +{
>> +
>> +}
>> +
>>  /*
>> - * Main XIVE object
>> + * XIVE Interrupt Source
>> + */
>> +
>> +/*
>> + * "magic" Event State Buffer (ESB) MMIO offsets.
>> + *
>> + * Each interrupt source has a 2-bit state machine called ESB
>> + * which can be controlled by MMIO. It's made of 2 bits, P and
>> + * Q. P indicates that an interrupt is pending (has been sent
>> + * to a queue and is waiting for an EOI). Q indicates that the
>> + * interrupt has been triggered while pending.
>> + *
>> + * This acts as a coalescing mechanism in order to guarantee
>> + * that a given interrupt only occurs at most once in a queue.
>> + *
>> + * When doing an EOI, the Q bit will indicate if the interrupt
>> + * needs to be re-triggered.
>> + *
>> + * The following offsets into the ESB MMIO allow to read or
>> + * manipulate the PQ bits. They must be used with an 8-bytes
>> + * load instruction. They all return the previous state of the
>> + * interrupt (atomically).
>> + *
>> + * Additionally, some ESB pages support doing an EOI via a
>> + * store at 0 and some ESBs support doing a trigger via a
>> + * separate trigger page.
>> + */
>> +#define XIVE_ESB_STORE_EOI      0x400 /* Store */
>> +#define XIVE_ESB_LOAD_EOI       0x000 /* Load */
>> +#define XIVE_ESB_GET            0x800 /* Load */
>> +#define XIVE_ESB_SET_PQ_00      0xc00 /* Load */
>> +#define XIVE_ESB_SET_PQ_01      0xd00 /* Load */
>> +#define XIVE_ESB_SET_PQ_10      0xe00 /* Load */
>> +#define XIVE_ESB_SET_PQ_11      0xf00 /* Load */
>> +
>> +#define XIVE_ESB_VAL_P          0x2
>> +#define XIVE_ESB_VAL_Q          0x1
>> +
>> +#define XIVE_ESB_RESET          0x0
>> +#define XIVE_ESB_PENDING        XIVE_ESB_VAL_P
>> +#define XIVE_ESB_QUEUED         (XIVE_ESB_VAL_P | XIVE_ESB_VAL_Q)
>> +#define XIVE_ESB_OFF            XIVE_ESB_VAL_Q
>> +
>> +static uint8_t spapr_xive_pq_get(sPAPRXive *xive, uint32_t lisn)
>> +{
>> +    uint32_t byte =3D lisn / 4;
>> +    uint32_t bit  =3D (lisn % 4) * 2;
>> +
>> +    assert(byte < xive->sbe_size);
>> +
>> +    return (xive->sbe[byte] >> bit) & 0x3;
>> +}
>> +
>> +static uint8_t spapr_xive_pq_set(sPAPRXive *xive, uint32_t lisn, uint=
8_t pq)
>> +{
>> +    uint32_t byte =3D lisn / 4;
>> +    uint32_t bit  =3D (lisn % 4) * 2;
>> +    uint8_t old, new;
>> +
>> +    assert(byte < xive->sbe_size);
>> +
>> +    old =3D xive->sbe[byte];
>> +
>> +    new =3D xive->sbe[byte] & ~(0x3 << bit);
>> +    new |=3D (pq & 0x3) << bit;
>> +
>> +    xive->sbe[byte] =3D new;
>> +
>> +    return (old >> bit) & 0x3;
>> +}
>> +
>> +static bool spapr_xive_pq_eoi(sPAPRXive *xive, uint32_t lisn)
>> +{
>> +    uint8_t old_pq =3D spapr_xive_pq_get(xive, lisn);
>> +
>> +    switch (old_pq) {
>> +    case XIVE_ESB_RESET:
>> +        spapr_xive_pq_set(xive, lisn, XIVE_ESB_RESET);
>> +        return false;
>> +    case XIVE_ESB_PENDING:
>> +        spapr_xive_pq_set(xive, lisn, XIVE_ESB_RESET);
>> +        return false;
>> +    case XIVE_ESB_QUEUED:
>> +        spapr_xive_pq_set(xive, lisn, XIVE_ESB_PENDING);
>> +        return true;
>> +    case XIVE_ESB_OFF:
>> +        spapr_xive_pq_set(xive, lisn, XIVE_ESB_OFF);
>> +        return false;
>> +    default:
>> +         g_assert_not_reached();
>> +    }
>> +}
>> +
>> +/*
>> + * Returns whether the event notification should be forwarded to the
>> + * IVE for routing.
>>   */
>> +static bool spapr_xive_pq_trigger(sPAPRXive *xive, uint32_t lisn)
>> +{
>> +    uint8_t old_pq =3D spapr_xive_pq_get(xive, lisn);
>> =20
>> +    switch (old_pq) {
>> +    case XIVE_ESB_RESET:
>> +        spapr_xive_pq_set(xive, lisn, XIVE_ESB_PENDING);
>> +        return true;
>> +    case XIVE_ESB_PENDING:
>> +        spapr_xive_pq_set(xive, lisn, XIVE_ESB_QUEUED);
>> +        return false;
>> +    case XIVE_ESB_QUEUED:
>> +        spapr_xive_pq_set(xive, lisn, XIVE_ESB_QUEUED);
>> +        return false;
>> +    case XIVE_ESB_OFF:
>> +        spapr_xive_pq_set(xive, lisn, XIVE_ESB_OFF);
>> +        return false;
>> +    default:
>> +         g_assert_not_reached();
>> +    }
>> +}
>> +
>> +/*
>> + * XIVE Interrupt Source MMIOs
>> + */
>> +
>> +/*
>> + * Some HW use a separate page for trigger. We only support the case
>> + * in which the trigger can be done in the same page as the EOI.
>> + */
>> +static uint64_t spapr_xive_esb_read(void *opaque, hwaddr addr, unsign=
ed size)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
>> +    uint32_t offset =3D addr & 0xF00;
>> +    uint32_t lisn =3D addr >> ESB_SHIFT;
>> +    uint64_t ret =3D -1;
>> +
>> +    switch (offset) {
>> +    case XIVE_ESB_LOAD_EOI:
>> +        /*
>> +         * EOI on load is not used anymore as we now advertise
>> +         * XIVE_ESB_STORE_EOI support for the interrupt sources
>> +         */
>> +        ret =3D spapr_xive_pq_eoi(xive, lisn);
>> +        break;
>> +
>> +    case XIVE_ESB_GET:
>> +        ret =3D spapr_xive_pq_get(xive, lisn);
>> +        break;
>> +
>> +    case XIVE_ESB_SET_PQ_00:
>> +    case XIVE_ESB_SET_PQ_01:
>> +    case XIVE_ESB_SET_PQ_10:
>> +    case XIVE_ESB_SET_PQ_11:
>> +        ret =3D spapr_xive_pq_set(xive, lisn, (offset >> 8) & 0x3);
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB addr %d\n",=
 offset);
>> +    }
>> +
>> +    return ret;
>> +}
>> +
>> +static void spapr_xive_esb_write(void *opaque, hwaddr addr,
>> +                                 uint64_t value, unsigned size)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
>> +    uint32_t offset =3D addr & 0xF00;
>> +    uint32_t lisn =3D addr >> ESB_SHIFT;
>> +    bool notify =3D false;
>> +
>> +    switch (offset) {
>> +    case 0:
>> +        notify =3D spapr_xive_pq_trigger(xive, lisn);
>> +        break;
>> +    case XIVE_ESB_STORE_EOI:
>> +        /* If the Q bit is set, we should forward a new source event
>> +         * notification
>> +         */
>> +        notify =3D spapr_xive_pq_eoi(xive, lisn);
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr =
%d\n",
>> +                      offset);
>> +        return;
>> +    }
>> +
>> +    /* Forward the source event notification for routing */
>> +    if (notify) {
>> +        spapr_xive_irq(xive, lisn);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps spapr_xive_esb_ops =3D {
>> +    .read =3D spapr_xive_esb_read,
>> +    .write =3D spapr_xive_esb_write,
>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>> +    .valid =3D {
>> +        .min_access_size =3D 8,
>> +        .max_access_size =3D 8,
>> +    },
>> +    .impl =3D {
>> +        .min_access_size =3D 8,
>> +        .max_access_size =3D 8,
>> +    },
>> +};
>> +
>> +static void spapr_xive_source_set_irq(void *opaque, int lisn, int val=
)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
>> +    bool notify =3D false;
>> +
>> +    if (val) {
>> +        notify =3D spapr_xive_pq_trigger(xive, lisn);
>> +    }
>> +
>> +    /* Forward the source event notification for routing */
>> +    if (notify) {
>> +        spapr_xive_irq(xive, lisn);
>> +    }
>> +}
>> +
>> +/*
>> + * Main XIVE object
>> + */
>>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
>>  {
>>      int i;
>> =20
>>      for (i =3D 0; i < xive->nr_irqs; i++) {
>>          XiveIVE *ive =3D &xive->ivt[i];
>> +        uint8_t pq;
>> =20
>>          if (!(ive->w & IVE_VALID)) {
>>              continue;
>>          }
>> =20
>> -        monitor_printf(mon, "  %4x %s %08x %08x\n", i,
>> +        pq =3D spapr_xive_pq_get(xive, i);
>> +
>> +        monitor_printf(mon, "  %4x %s %c%c %08x %08x\n", i,
>>                         ive->w & IVE_MASKED ? "M" : " ",
>> +                       pq & XIVE_ESB_VAL_P ? 'P' : '-',
>> +                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
>>                         (int) GETFIELD(IVE_EQ_INDEX, ive->w),
>>                         (int) GETFIELD(IVE_EQ_DATA, ive->w));
>>      }
>> @@ -52,6 +281,9 @@ static void spapr_xive_reset(DeviceState *dev)
>>              ive->w |=3D IVE_MASKED;
>>          }
>>      }
>> +
>> +    /* SBEs are initialized to 0b01 which corresponds to "ints off" *=
/
>> +    memset(xive->sbe, 0x55, xive->sbe_size);
>>  }
>> =20
>>  static void spapr_xive_realize(DeviceState *dev, Error **errp)
>> @@ -65,6 +297,23 @@ static void spapr_xive_realize(DeviceState *dev, E=
rror **errp)
>> =20
>>      /* Allocate the IVT (Interrupt Virtualization Table) */
>>      xive->ivt =3D g_new0(XiveIVE, xive->nr_irqs);
>> +
>> +    /* QEMU IRQs */
>> +    xive->qirqs =3D qemu_allocate_irqs(spapr_xive_source_set_irq, xiv=
e,
>> +                                     xive->nr_irqs);
>> +
>> +    /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte=
 */
>> +    xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
>> +    xive->sbe =3D g_malloc0(xive->sbe_size);
>> +
>> +    /* VC BAR. Use address of chip 0 to install the ESB memory region
>> +     * for *all* interrupt sources */
>> +    xive->esb_base =3D (P9_MMIO_BASE | VC_BAR_DEFAULT);
>> +
>> +    memory_region_init_io(&xive->esb_iomem, OBJECT(xive),
>> +                          &spapr_xive_esb_ops, xive, "xive.esb",
>> +                          (1ull << ESB_SHIFT) * xive->nr_irqs);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->esb_iomem);
>>  }
>> =20
>>  static const VMStateDescription vmstate_spapr_xive_ive =3D {
>> @@ -92,6 +341,7 @@ static const VMStateDescription vmstate_spapr_xive =
=3D {
>>          VMSTATE_UINT32_EQUAL(nr_irqs, sPAPRXive, NULL),
>>          VMSTATE_STRUCT_VARRAY_UINT32(ivt, sPAPRXive, nr_irqs, 1,
>>                                       vmstate_spapr_xive_ive, XiveIVE)=
,
>> +        VMSTATE_VBUFFER_UINT32(sbe, sPAPRXive, 1, NULL, sbe_size),
>>          VMSTATE_END_OF_LIST()
>>      },
>>  };
>> diff --git a/hw/intc/xive-internal.h b/hw/intc/xive-internal.h
>> index 132b71a6daf0..872648dd96a2 100644
>> --- a/hw/intc/xive-internal.h
>> +++ b/hw/intc/xive-internal.h
>> @@ -16,6 +16,16 @@
>>  #define SETFIELD(m, v, val)                             \
>>          (((v) & ~(m)) | ((((typeof(v))(val)) << MASK_TO_LSH(m)) & (m)=
))
>> =20
>> +/*
>> + * XIVE MMIO regions
>> + */
>> +#define P9_MMIO_BASE     0x006000000000000ull
>> +
>> +/* VC BAR contains set translations for the ESBs and the EQs. */
>> +#define VC_BAR_DEFAULT   0x10000000000ull
>> +#define VC_BAR_SIZE      0x08000000000ull
>> +#define ESB_SHIFT        16 /* One 64k page. OPAL has two */
>> +
>>  /* IVE/EAS
>>   *
>>   * One per interrupt source. Targets that interrupt to a given EQ
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 5b1f78e06a1e..ecc15d889b74 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -24,8 +24,17 @@ struct sPAPRXive {
>>      /* Properties */
>>      uint32_t     nr_irqs;
>> =20
>> +    /* IRQ */
>> +    qemu_irq     *qirqs;
>> +
>>      /* XIVE internal tables */
>>      XiveIVE      *ivt;
>> +    uint8_t      *sbe;
>> +    uint32_t     sbe_size;
>> +
>> +    /* ESB memory region */
>> +    hwaddr       esb_base;
>> +    MemoryRegion esb_iomem;
>>  };
>> =20
>>  bool spapr_xive_irq_enable(sPAPRXive *xive, uint32_t lisn);
>=20
