Received: from eggs.gnu.org ([2001:4830:134:3::10]:53597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvN2p-0003lb-Vz
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dvN2j-0002vu-9D
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:26:59 -0400
Received: from 6.mo179.mail-out.ovh.net ([46.105.56.76]:52435)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dvN2j-0002vE-0g
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 08:26:53 -0400
Received: from player690.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo179.mail-out.ovh.net (Postfix) with ESMTP id 4D4AD5B3B8
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 14:26:51 +0200 (CEST)
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-8-clg@kaod.org> <20170919025747.GM27153@umbus>
	<131a8102-00e4-9621-ddca-39bc685b95cf@kaod.org>
	<20170922105805.GN4998@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <c8358619-6eb4-b534-4c2d-2523ba6ebd00@kaod.org>
Date: Fri, 22 Sep 2017 14:26:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170922105805.GN4998@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v2 07/21] ppc/xive: add MMIO handlers
 for the XIVE interrupt sources
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>

On 09/22/2017 12:58 PM, David Gibson wrote:
> On Wed, Sep 20, 2017 at 02:54:31PM +0200, C=E9dric Le Goater wrote:
>> On 09/19/2017 04:57 AM, David Gibson wrote:
>>> On Mon, Sep 11, 2017 at 07:12:21PM +0200, C=E9dric Le Goater wrote:
>>>> Each interrupt source is associated with a two bit state machine
>>>> called an Event State Buffer (ESB) which is controlled by MMIO to
>>>> trigger events. See code for more details on the states and
>>>> transitions.
>>>>
>>>> The MMIO space for the ESB translation is 512GB large on baremetal
>>>> (powernv) systems and the BAR depends on the chip id. In our model f=
or
>>>> the sPAPR machine, we choose to only map a sub memory region for the
>>>> provisionned IRQ numbers and to use the mapping address of chip 0 on=
 a
>>>> real system. The OS will get the address of the MMIO page of the ESB
>>>> entry associated with an IRQ using the H_INT_GET_SOURCE_INFO hcall.
>>>
>>> On bare metal, are the MMIOs for each irq source mapped contiguously?
>>
>> yes.=20
>> =20
>>>> For KVM support, we should think of a way to map this QEMU memory
>>>> region in the host to trigger events directly.
>>>
>>> This would rely on being able to map them without mapping those for
>>> any other VM or the host.  Does that mean allocating a contiguous (an=
d
>>> aligned) hunk of irqs for a guest?
>>
>> I think so yes, the IRQ and the memory regions are tied, and also bein=
g=20
>> able to pass the MMIO region from the host to the guest, a bit like VF=
IO=20
>> for the IOMMU regions I suppose. But I haven't dig the problem too muc=
h.=20
>>
>> This is an important part in the overall design.=20
>>
>>> We're going to need to be careful about irq allocation here.
>>> Even though GET_SOURCE_INFO allows dynamic mapping of irq numbers to
>>> MMIO addresses,=20
>>
>> GET_SOURCE_INFO only retrieves the address of the MMIO region for=20
>> a 'lisn'. it is not dynamically mapped.
>=20
> Ok... what's a "lisn"?

Logical Interrupt Source Number. This is the source number the OS guest=20
manipulates in the hcalls. The OS registers also an EISN, Effective Inter=
rupt=20
Source Number, associated with the LISN, which will be stored in the even=
t=20
queue.

C.=20

>=20
>=20
>> In the KVM case, the initial
>> information on the address would come from OPAL and then the host=20
>> kernel would translate this information for the guest.
>>
>>> we need the MMIO addresses to be stable and consistent, because=20
>>> we can't have them change across migration. =20
>>
>> yes. I will catch my XIVE guru next week in Paris to clarify that
>> part.=20
>>
>>> We need to have this consistent between in-qemu and in-KVM XIVE
>>> implementations as well.
>>
>> yes.
>>
>> C.
>>
>>>>
>>>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>>>> ---
>>>>  hw/intc/spapr_xive.c        | 255 +++++++++++++++++++++++++++++++++=
+++++++++++
>>>>  include/hw/ppc/spapr_xive.h |   6 ++
>>>>  2 files changed, 261 insertions(+)
>>>>
>>>> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
>>>> index 1ed7b6a286e9..8a85d64efc4c 100644
>>>> --- a/hw/intc/spapr_xive.c
>>>> +++ b/hw/intc/spapr_xive.c
>>>> @@ -33,6 +33,218 @@ static void spapr_xive_irq(sPAPRXive *xive, int =
srcno)
>>>>  }
>>>> =20
>>>>  /*
>>>> + * "magic" Event State Buffer (ESB) MMIO offsets.
>>>> + *
>>>> + * Each interrupt source has a 2-bit state machine called ESB
>>>> + * which can be controlled by MMIO. It's made of 2 bits, P and
>>>> + * Q. P indicates that an interrupt is pending (has been sent
>>>> + * to a queue and is waiting for an EOI). Q indicates that the
>>>> + * interrupt has been triggered while pending.
>>>> + *
>>>> + * This acts as a coalescing mechanism in order to guarantee
>>>> + * that a given interrupt only occurs at most once in a queue.
>>>> + *
>>>> + * When doing an EOI, the Q bit will indicate if the interrupt
>>>> + * needs to be re-triggered.
>>>> + *
>>>> + * The following offsets into the ESB MMIO allow to read or
>>>> + * manipulate the PQ bits. They must be used with an 8-bytes
>>>> + * load instruction. They all return the previous state of the
>>>> + * interrupt (atomically).
>>>> + *
>>>> + * Additionally, some ESB pages support doing an EOI via a
>>>> + * store at 0 and some ESBs support doing a trigger via a
>>>> + * separate trigger page.
>>>> + */
>>>> +#define XIVE_ESB_GET            0x800
>>>> +#define XIVE_ESB_SET_PQ_00      0xc00
>>>> +#define XIVE_ESB_SET_PQ_01      0xd00
>>>> +#define XIVE_ESB_SET_PQ_10      0xe00
>>>> +#define XIVE_ESB_SET_PQ_11      0xf00
>>>> +
>>>> +#define XIVE_ESB_VAL_P          0x2
>>>> +#define XIVE_ESB_VAL_Q          0x1
>>>> +
>>>> +#define XIVE_ESB_RESET          0x0
>>>> +#define XIVE_ESB_PENDING        XIVE_ESB_VAL_P
>>>> +#define XIVE_ESB_QUEUED         (XIVE_ESB_VAL_P | XIVE_ESB_VAL_Q)
>>>> +#define XIVE_ESB_OFF            XIVE_ESB_VAL_Q
>>>> +
>>>> +static uint8_t spapr_xive_pq_get(sPAPRXive *xive, uint32_t idx)
>>>> +{
>>>> +    uint32_t byte =3D idx / 4;
>>>> +    uint32_t bit  =3D (idx % 4) * 2;
>>>> +
>>>> +    assert(byte < xive->sbe_size);
>>>> +
>>>> +    return (xive->sbe[byte] >> bit) & 0x3;
>>>> +}
>>>> +
>>>> +static uint8_t spapr_xive_pq_set(sPAPRXive *xive, uint32_t idx, uin=
t8_t pq)
>>>> +{
>>>> +    uint32_t byte =3D idx / 4;
>>>> +    uint32_t bit  =3D (idx % 4) * 2;
>>>> +    uint8_t old, new;
>>>> +
>>>> +    assert(byte < xive->sbe_size);
>>>> +
>>>> +    old =3D xive->sbe[byte];
>>>> +
>>>> +    new =3D xive->sbe[byte] & ~(0x3 << bit);
>>>> +    new |=3D (pq & 0x3) << bit;
>>>> +
>>>> +    xive->sbe[byte] =3D new;
>>>> +
>>>> +    return (old >> bit) & 0x3;
>>>> +}
>>>> +
>>>> +static bool spapr_xive_pq_eoi(sPAPRXive *xive, uint32_t srcno)
>>>> +{
>>>> +    uint8_t old_pq =3D spapr_xive_pq_get(xive, srcno);
>>>> +
>>>> +    switch (old_pq) {
>>>> +    case XIVE_ESB_RESET:
>>>> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_RESET);
>>>> +        return false;
>>>> +    case XIVE_ESB_PENDING:
>>>> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_RESET);
>>>> +        return false;
>>>> +    case XIVE_ESB_QUEUED:
>>>> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_PENDING);
>>>> +        return true;
>>>> +    case XIVE_ESB_OFF:
>>>> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_OFF);
>>>> +        return false;
>>>> +    default:
>>>> +         g_assert_not_reached();
>>>> +    }
>>>> +}
>>>> +
>>>> +static bool spapr_xive_pq_trigger(sPAPRXive *xive, uint32_t srcno)
>>>> +{
>>>> +    uint8_t old_pq =3D spapr_xive_pq_get(xive, srcno);
>>>> +
>>>> +    switch (old_pq) {
>>>> +    case XIVE_ESB_RESET:
>>>> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_PENDING);
>>>> +        return true;
>>>> +    case XIVE_ESB_PENDING:
>>>> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_QUEUED);
>>>> +        return true;
>>>> +    case XIVE_ESB_QUEUED:
>>>> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_QUEUED);
>>>> +        return true;
>>>> +    case XIVE_ESB_OFF:
>>>> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_OFF);
>>>> +        return false;
>>>> +    default:
>>>> +         g_assert_not_reached();
>>>> +    }
>>>> +}
>>>> +
>>>> +/*
>>>> + * XIVE Interrupt Source MMIOs
>>>> + */
>>>> +static void spapr_xive_source_eoi(sPAPRXive *xive, uint32_t srcno)
>>>> +{
>>>> +    ICSIRQState *irq =3D &xive->ics->irqs[srcno];
>>>> +
>>>> +    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
>>>> +        irq->status &=3D ~XICS_STATUS_SENT;
>>>> +    }
>>>> +}
>>>> +
>>>> +/* TODO: handle second page
>>>> + *
>>>> + * Some HW use a separate page for trigger. We only support the cas=
e
>>>> + * in which the trigger can be done in the same page as the EOI.
>>>> + */
>>>> +static uint64_t spapr_xive_esb_read(void *opaque, hwaddr addr, unsi=
gned size)
>>>> +{
>>>> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
>>>> +    uint32_t offset =3D addr & 0xF00;
>>>> +    uint32_t srcno =3D addr >> xive->esb_shift;
>>>> +    XiveIVE *ive;
>>>> +    uint64_t ret =3D -1;
>>>> +
>>>> +    ive =3D spapr_xive_get_ive(xive, srcno);
>>>> +    if (!ive || !(ive->w & IVE_VALID))  {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", s=
rcno);
>>>> +        goto out;
>>>
>>> Since there's a whole (4k) page for each source, I wonder if we shoul=
d
>>> actually map each one as a separate MMIO region to allow us to tweak
>>> the mappings more flexibly.
>>>
>>>> +    }
>>>> +
>>>> +    switch (offset) {
>>>> +    case 0:
>>>> +        spapr_xive_source_eoi(xive, srcno);
>>>> +
>>>> +        /* return TRUE or FALSE depending on PQ value */
>>>> +        ret =3D spapr_xive_pq_eoi(xive, srcno);
>>>> +        break;
>>>> +
>>>> +    case XIVE_ESB_GET:
>>>> +        ret =3D spapr_xive_pq_get(xive, srcno);
>>>> +        break;
>>>> +
>>>> +    case XIVE_ESB_SET_PQ_00:
>>>> +    case XIVE_ESB_SET_PQ_01:
>>>> +    case XIVE_ESB_SET_PQ_10:
>>>> +    case XIVE_ESB_SET_PQ_11:
>>>> +        ret =3D spapr_xive_pq_set(xive, srcno, (offset >> 8) & 0x3)=
;
>>>> +        break;
>>>> +    default:
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB addr %d\n=
", offset);
>>>> +    }
>>>> +
>>>> +out:
>>>> +    return ret;
>>>> +}
>>>> +
>>>> +static void spapr_xive_esb_write(void *opaque, hwaddr addr,
>>>> +                           uint64_t value, unsigned size)
>>>> +{
>>>> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
>>>> +    uint32_t offset =3D addr & 0xF00;
>>>> +    uint32_t srcno =3D addr >> xive->esb_shift;
>>>> +    XiveIVE *ive;
>>>> +    bool notify =3D false;
>>>> +
>>>> +    ive =3D spapr_xive_get_ive(xive, srcno);
>>>> +    if (!ive || !(ive->w & IVE_VALID))  {
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", s=
rcno);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    switch (offset) {
>>>> +    case 0:
>>>> +        /* TODO: should we trigger even if the IVE is masked ? */
>>>> +        notify =3D spapr_xive_pq_trigger(xive, srcno);
>>>> +        break;
>>>> +    default:
>>>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write add=
r %d\n",
>>>> +                      offset);
>>>> +        return;
>>>> +    }
>>>> +
>>>> +    if (notify && !(ive->w & IVE_MASKED)) {
>>>> +        qemu_irq_pulse(xive->qirqs[srcno]);
>>>> +    }
>>>> +}
>>>> +
>>>> +static const MemoryRegionOps spapr_xive_esb_ops =3D {
>>>> +    .read =3D spapr_xive_esb_read,
>>>> +    .write =3D spapr_xive_esb_write,
>>>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>>>> +    .valid =3D {
>>>> +        .min_access_size =3D 8,
>>>> +        .max_access_size =3D 8,
>>>> +    },
>>>> +    .impl =3D {
>>>> +        .min_access_size =3D 8,
>>>> +        .max_access_size =3D 8,
>>>> +    },
>>>> +};
>>>> +
>>>> +/*
>>>>   * XIVE Interrupt Source
>>>>   */
>>>>  static void spapr_xive_source_set_irq_msi(sPAPRXive *xive, int srcn=
o, int val)
>>>> @@ -74,6 +286,33 @@ static void spapr_xive_source_set_irq(void *opaq=
ue, int srcno, int val)
>>>>  /*
>>>>   * Main XIVE object
>>>>   */
>>>> +#define P9_MMIO_BASE     0x006000000000000ull
>>>> +
>>>> +/* VC BAR contains set translations for the ESBs and the EQs. */
>>>> +#define VC_BAR_DEFAULT   0x10000000000ull
>>>> +#define VC_BAR_SIZE      0x08000000000ull
>>>> +#define ESB_SHIFT        16 /* One 64k page. OPAL has two */
>>>> +
>>>> +static uint64_t spapr_xive_esb_default_read(void *p, hwaddr offset,
>>>> +                                            unsigned size)
>>>> +{
>>>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
>>>> +                  __func__, offset, size);
>>>> +    return 0;
>>>> +}
>>>> +
>>>> +static void spapr_xive_esb_default_write(void *opaque, hwaddr offse=
t,
>>>> +                                         uint64_t value, unsigned s=
ize)
>>>> +{
>>>> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64=
 " [%u]\n",
>>>> +                  __func__, offset, value, size);
>>>> +}
>>>> +
>>>> +static const MemoryRegionOps spapr_xive_esb_default_ops =3D {
>>>> +    .read =3D spapr_xive_esb_default_read,
>>>> +    .write =3D spapr_xive_esb_default_write,
>>>> +    .endianness =3D DEVICE_BIG_ENDIAN,
>>>> +};
>>>> =20
>>>>  void spapr_xive_reset(void *dev)
>>>>  {
>>>> @@ -144,6 +383,22 @@ static void spapr_xive_realize(DeviceState *dev=
, Error **errp)
>>>>      xive->nr_eqs =3D xive->nr_targets * XIVE_EQ_PRIORITY_COUNT;
>>>>      xive->eqt =3D g_malloc0(xive->nr_eqs * sizeof(XiveEQ));
>>>> =20
>>>> +    /* VC BAR. That's the full window but we will only map the
>>>> +     * subregions in use. */
>>>> +    xive->esb_base =3D (P9_MMIO_BASE | VC_BAR_DEFAULT);
>>>> +    xive->esb_shift =3D ESB_SHIFT;
>>>> +
>>>> +    /* Install default memory region handlers to log bogus access *=
/
>>>> +    memory_region_init_io(&xive->esb_mr, NULL, &spapr_xive_esb_defa=
ult_ops,
>>>> +                          NULL, "xive.esb.full", VC_BAR_SIZE);
>>>> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->esb_mr);
>>>> +
>>>> +    /* Install the ESB memory region in the overall one */
>>>> +    memory_region_init_io(&xive->esb_iomem, OBJECT(xive), &spapr_xi=
ve_esb_ops,
>>>> +                          xive, "xive.esb",
>>>> +                          (1ull << xive->esb_shift) * xive->nr_irqs=
);
>>>> +    memory_region_add_subregion(&xive->esb_mr, 0, &xive->esb_iomem)=
;
>>>> +
>>>>      qemu_register_reset(spapr_xive_reset, dev);
>>>>  }
>>>> =20
>>>> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive=
.h
>>>> index eab92c4c1bb8..0f516534d76a 100644
>>>> --- a/include/hw/ppc/spapr_xive.h
>>>> +++ b/include/hw/ppc/spapr_xive.h
>>>> @@ -46,6 +46,12 @@ struct sPAPRXive {
>>>>      XiveIVE      *ivt;
>>>>      XiveEQ       *eqt;
>>>>      uint32_t     nr_eqs;
>>>> +
>>>> +    /* ESB memory region */
>>>> +    uint32_t     esb_shift;
>>>> +    hwaddr       esb_base;
>>>> +    MemoryRegion esb_mr;
>>>> +    MemoryRegion esb_iomem;
>>>>  };
>>>> =20
>>>>  #endif /* PPC_SPAPR_XIVE_H */
>>>
>>
>=20
