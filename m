Received: from eggs.gnu.org ([2001:4830:134:3::10]:47017)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eJkh2-0006u2-M3
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:33:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1eJkgy-0002AK-GX
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:33:16 -0500
Received: from 8.mo69.mail-out.ovh.net ([46.105.56.233]:50683)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1eJkgy-00029Z-7R
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 13:33:12 -0500
Received: from player738.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo69.mail-out.ovh.net (Postfix) with ESMTP id A6D0C4A415
	for <qemu-devel@nongnu.org>; Tue, 28 Nov 2017 19:33:10 +0100 (CET)
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-11-clg@kaod.org>
	<20171128063827.GP11775@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e9b1f002-671b-7ba5-2b5b-34715d63585c@kaod.org>
Date: Tue, 28 Nov 2017 18:33:06 +0000
MIME-Version: 1.0
In-Reply-To: <20171128063827.GP11775@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 10/25] spapr: add MMIO handlers for the
 XIVE interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>

On 11/28/2017 06:38 AM, David Gibson wrote:
> On Thu, Nov 23, 2017 at 02:29:40PM +0100, C=E9dric Le Goater wrote:
>> Each interrupt source is associated with a two bit state machine
>> called an Event State Buffer (ESB). The bits are named "P" (pending)
>> and "Q" (queued) and can be controlled by MMIO. It is used to trigger
>> events. See code for more details on the states and transitions.
>>
>> The MMIO space for the ESB translation is 512GB large on baremetal
>> (powernv) systems and the BAR depends on the chip id. In our model for
>> the sPAPR machine, we choose to only map a sub memory region for the
>> provisionned IRQ numbers and to use the mapping address of chip 0 on a
>> real system. The OS will get the address of the MMIO page of the ESB
>> entry associated with an IRQ using the H_INT_GET_SOURCE_INFO hcall.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/spapr_xive.c        | 268 +++++++++++++++++++++++++++++++++++=
++++++++-
>>  include/hw/ppc/spapr_xive.h |   8 ++
>>  2 files changed, 275 insertions(+), 1 deletion(-)
>>
>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>> index 66c533fb1d78..f45f50fd017e 100644
>> --- a/hw/intc/spapr_xive.c
>> +++ b/hw/intc/spapr_xive.c
>> @@ -32,6 +32,216 @@ static void spapr_xive_irq(sPAPRXive *xive, int li=
sn)
>>  }
>> =20
>>  /*
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
>> +#define XIVE_ESB_GET            0x800
>> +#define XIVE_ESB_SET_PQ_00      0xc00
>> +#define XIVE_ESB_SET_PQ_01      0xd00
>> +#define XIVE_ESB_SET_PQ_10      0xe00
>> +#define XIVE_ESB_SET_PQ_11      0xf00
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
>> +static bool spapr_xive_pq_trigger(sPAPRXive *xive, uint32_t lisn)
>> +{
>> +    uint8_t old_pq =3D spapr_xive_pq_get(xive, lisn);
>> +
>> +    switch (old_pq) {
>> +    case XIVE_ESB_RESET:
>> +        spapr_xive_pq_set(xive, lisn, XIVE_ESB_PENDING);
>> +        return true;
>> +    case XIVE_ESB_PENDING:
>> +        spapr_xive_pq_set(xive, lisn, XIVE_ESB_QUEUED);
>> +        return true;
>> +    case XIVE_ESB_QUEUED:
>> +        spapr_xive_pq_set(xive, lisn, XIVE_ESB_QUEUED);
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
>> + * XIVE Interrupt Source MMIOs
>> + */
>> +static void spapr_xive_source_eoi(sPAPRXive *xive, uint32_t lisn)
>> +{
>> +    if (spapr_xive_irq_is_lsi(xive, lisn)) {
>> +        xive->status[lisn] &=3D ~XIVE_STATUS_SENT;
>> +    }
>> +}
>> +
>> +/* TODO: handle second page
>> + *
>> + * Some HW use a separate page for trigger. We only support the case
>> + * in which the trigger can be done in the same page as the EOI.
>> + */
>> +static uint64_t spapr_xive_esb_read(void *opaque, hwaddr addr, unsign=
ed size)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
>> +    uint32_t offset =3D addr & 0xF00;
>> +    uint32_t lisn =3D addr >> xive->esb_shift;
>> +    XiveIVE *ive;
>> +    uint64_t ret =3D -1;
>> +
>> +    ive =3D spapr_xive_get_ive(xive, lisn);
>> +    if (!ive || !(ive->w & IVE_VALID))  {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lis=
n);
>> +        goto out;
>> +    }
>> +
>> +    switch (offset) {
>> +    case 0:
>> +        spapr_xive_source_eoi(xive, lisn);
>=20
> Hrm.  I don't love that you're dealing with clearing that LSI bit
> here, but setting it at a different level.
>=20
> The state machines are doing my head in a bit, is there any way
> you could derive the STATUS_SENT bit from the PQ bits?

Yes. I should.=20

I am also lacking a guest driver to exercise these LSIs so I didn't
pay a lot of attention to level interrupts. Any idea ?

>> +        /* return TRUE or FALSE depending on PQ value */
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
>> +out:
>> +    return ret;
>> +}
>> +
>> +static void spapr_xive_esb_write(void *opaque, hwaddr addr,
>> +                           uint64_t value, unsigned size)
>> +{
>> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
>> +    uint32_t offset =3D addr & 0xF00;
>> +    uint32_t lisn =3D addr >> xive->esb_shift;
>> +    XiveIVE *ive;
>> +    bool notify =3D false;
>> +
>> +    ive =3D spapr_xive_get_ive(xive, lisn);
>> +    if (!ive || !(ive->w & IVE_VALID))  {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lis=
n);
>> +        return;
>> +    }
>> +
>> +    switch (offset) {
>> +    case 0:
>> +        /* TODO: should we trigger even if the IVE is masked ? */
>> +        notify =3D spapr_xive_pq_trigger(xive, lisn);
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr =
%d\n",
>> +                      offset);
>> +        return;
>> +    }
>> +
>> +    if (notify && !(ive->w & IVE_MASKED)) {
>> +        qemu_irq_pulse(xive->qirqs[lisn]);
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
>> +/*
>>   * XIVE Interrupt Source
>>   */
>>  static void spapr_xive_source_set_irq_msi(sPAPRXive *xive, int lisn, =
int val)
>> @@ -70,6 +280,33 @@ static void spapr_xive_source_set_irq(void *opaque=
, int lisn, int val)
>>  /*
>>   * Main XIVE object
>>   */
>> +#define P9_MMIO_BASE     0x006000000000000ull
>> +
>> +/* VC BAR contains set translations for the ESBs and the EQs. */
>> +#define VC_BAR_DEFAULT   0x10000000000ull
>> +#define VC_BAR_SIZE      0x08000000000ull
>> +#define ESB_SHIFT        16 /* One 64k page. OPAL has two */
>> +
>> +static uint64_t spapr_xive_esb_default_read(void *p, hwaddr offset,
>> +                                            unsigned size)
>> +{
>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
>> +                  __func__, offset, size);
>> +    return 0;
>> +}
>> +
>> +static void spapr_xive_esb_default_write(void *opaque, hwaddr offset,
>> +                                         uint64_t value, unsigned siz=
e)
>> +{
>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 "=
 [%u]\n",
>> +                  __func__, offset, value, size);
>> +}
>> +
>> +static const MemoryRegionOps spapr_xive_esb_default_ops =3D {
>> +    .read =3D spapr_xive_esb_default_read,
>> +    .write =3D spapr_xive_esb_default_write,
>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>=20
> I think you should at least have a valid access size field here.

yes.=20

>> +};
>> =20
>>  void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon)
>>  {
>> @@ -77,14 +314,19 @@ void spapr_xive_pic_print_info(sPAPRXive *xive, M=
onitor *mon)
>> =20
>>      for (i =3D 0; i < xive->nr_irqs; i++) {
>>          XiveIVE *ive =3D &xive->ivt[i];
>> +        uint8_t pq;
>> =20
>>          if (!(ive->w & IVE_VALID)) {
>>              continue;
>>          }
>> =20
>> -        monitor_printf(mon, "  %4x %s %s %08x %08x\n", i,
>> +        pq =3D spapr_xive_pq_get(xive, i);
>> +
>> +        monitor_printf(mon, "  %4x %s %s %c%c %08x %08x\n", i,
>>                         spapr_xive_irq_is_lsi(xive, i) ? "LSI" : "MSI"=
,
>>                         ive->w & IVE_MASKED ? "M" : " ",
>> +                       pq & XIVE_ESB_VAL_P ? 'P' : '-',
>> +                       pq & XIVE_ESB_VAL_Q ? 'Q' : '-',
>>                         (int) GETFIELD(IVE_EQ_INDEX, ive->w),
>>                         (int) GETFIELD(IVE_EQ_DATA, ive->w));
>>      }
>> @@ -104,6 +346,9 @@ void spapr_xive_reset(void *dev)
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
>> @@ -123,6 +368,26 @@ static void spapr_xive_realize(DeviceState *dev, =
Error **errp)
>>      /* Allocate the IVT (Interrupt Virtualization Table) */
>>      xive->ivt =3D g_malloc0(xive->nr_irqs * sizeof(XiveIVE));
>> =20
>> +    /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte=
 */
>> +    xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
>> +    xive->sbe =3D g_malloc0(xive->sbe_size);
>> +
>> +    /* VC BAR. That's the full window but we will only map the
>> +     * subregions in use. */
>> +    xive->esb_base =3D (P9_MMIO_BASE | VC_BAR_DEFAULT);
>> +    xive->esb_shift =3D ESB_SHIFT;
>=20
> Any point to having this as a variable, if it's always the same size?

Well, it is related to the page size and we could have a HW configuration=
=20
with two pages, with one specific page for trigger. But we don't need to=20
model this, yet. =20

The 'esb_shift' field is used in different places. I would rather keep it=
.
>> +
>> +    /* Install default memory region handlers to log bogus access */
>> +    memory_region_init_io(&xive->esb_mr, NULL, &spapr_xive_esb_defaul=
t_ops,
>> +                          NULL, "xive.esb.full", VC_BAR_SIZE);
>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->esb_mr);
>> +
>> +    /* Install the ESB memory region in the overall one */
>> +    memory_region_init_io(&xive->esb_iomem, OBJECT(xive), &spapr_xive=
_esb_ops,
>> +                          xive, "xive.esb",
>> +                          (1ull << xive->esb_shift) * xive->nr_irqs);
>> +    memory_region_add_subregion(&xive->esb_mr, 0, &xive->esb_iomem);
>=20
> Is there a benegit to to having these nested regions, rather than just
> validating the lisn in the read/write functions?

No. this was to represent the full ESB space of the system but we can=20
reduce it to one region. This is not a problem I think.

>>      qemu_register_reset(spapr_xive_reset, dev);
>>  }
>> =20
>> @@ -152,6 +417,7 @@ static const VMStateDescription vmstate_spapr_xive=
 =3D {
>>          VMSTATE_STRUCT_VARRAY_UINT32_ALLOC(ivt, sPAPRXive, nr_irqs, 1=
,
>>                                             vmstate_spapr_xive_ive, Xi=
veIVE),
>>          VMSTATE_VBUFFER_UINT32(status, sPAPRXive, 1, NULL, nr_irqs),
>> +        VMSTATE_VBUFFER_UINT32(sbe, sPAPRXive, 1, NULL, sbe_size),
>>          VMSTATE_END_OF_LIST()
>>      },
>>  };
>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
>> index 6a799cdaba66..84c910e62e56 100644
>> --- a/include/hw/ppc/spapr_xive.h
>> +++ b/include/hw/ppc/spapr_xive.h
>> @@ -42,6 +42,14 @@ struct sPAPRXive {
>> =20
>>      /* XIVE internal tables */
>>      XiveIVE      *ivt;
>> +    uint8_t      *sbe;
>> +    uint32_t     sbe_size;
>=20
> sbe_size is derivable from nr_irqs, so I don't think there's a point
> to storing it separately .

I needed the value for the vmstate macros.=20

Thanks,

C.=20

=20
>> +
>> +    /* ESB memory region */
>> +    uint32_t     esb_shift;
>> +    hwaddr       esb_base;
>> +    MemoryRegion esb_mr;
>> +    MemoryRegion esb_iomem;
>>  };
>> =20
>>  static inline bool spapr_xive_irq_is_lsi(sPAPRXive *xive, int lisn)
>=20
