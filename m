Received: from eggs.gnu.org ([2001:4830:134:3::10]:36500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZfi6-0006P2-2I
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:55:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dZfi2-0005ZD-4C
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:55:54 -0400
Received: from 3.mo3.mail-out.ovh.net ([46.105.44.175]:46075)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dZfi1-0005Yz-QV
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 11:55:50 -0400
Received: from player732.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 27947123B5A
	for <qemu-devel@nongnu.org>; Mon, 24 Jul 2017 17:55:48 +0200 (CEST)
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-8-git-send-email-clg@kaod.org>
	<20170724042956.GD17228@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <006293c9-b396-82f9-19ba-d57301934ffe@kaod.org>
Date: Mon, 24 Jul 2017 17:55:42 +0200
MIME-Version: 1.0
In-Reply-To: <20170724042956.GD17228@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH 07/26] ppc/xive: add MMIO handlers to
 the XIVE interrupt source
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org

On 07/24/2017 06:29 AM, David Gibson wrote:
> On Wed, Jul 05, 2017 at 07:13:20PM +0200, C=E9dric Le Goater wrote:
>> Each interrupt source is associated with a 2-bit state machine called
>> an Event State Buffer (ESB). It is controlled by MMIO to trigger
>> events.
>>
>> See code for more details on the states.
>>
>> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/intc/xive.c        | 230 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/ppc/xive.h |   3 +
>>  2 files changed, 233 insertions(+)
>>
>> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
>> index 9ff14c0da595..816031b8ac81 100644
>> --- a/hw/intc/xive.c
>> +++ b/hw/intc/xive.c
>> @@ -32,6 +32,226 @@ static void xive_icp_irq(XiveICSState *xs, int lis=
n)
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
>> +#define XIVE_ESB_PENDING        0x2
>> +#define XIVE_ESB_QUEUED         0x3
>> +#define XIVE_ESB_OFF            0x1
>> +
>> +static uint8_t xive_pq_get(XIVE *x, uint32_t lisn)
>> +{
>> +    uint32_t idx =3D lisn;
>> +    uint32_t byte =3D idx / 4;
>> +    uint32_t bit  =3D (idx % 4) * 2;
>> +    uint8_t* pqs =3D (uint8_t *) x->sbe;
>> +
>> +    return (pqs[byte] >> bit) & 0x3;
>> +}
>> +
>> +static void xive_pq_set(XIVE *x, uint32_t lisn, uint8_t pq)
>> +{
>> +    uint32_t idx =3D lisn;
>> +    uint32_t byte =3D idx / 4;
>> +    uint32_t bit  =3D (idx % 4) * 2;
>> +    uint8_t* pqs =3D (uint8_t *) x->sbe;
>> +
>> +    pqs[byte] &=3D ~(0x3 << bit);
>> +    pqs[byte] |=3D (pq & 0x3) << bit;
>=20
> I know it probably amounts to the same thing given the context, but
> I'd be more comfortable with a temporary and an obviously atomic
> update than two writes to the real state variable.

yes. I will look better.

>> +}
>> +
>> +static bool xive_pq_eoi(XIVE *x, uint32_t lisn)
>> +{
>> +    uint8_t old_pq =3D xive_pq_get(x, lisn);
>> +
>> +    switch (old_pq) {
>> +    case XIVE_ESB_RESET:
>> +        xive_pq_set(x, lisn, XIVE_ESB_RESET);
>> +        return false;
>> +    case XIVE_ESB_PENDING:
>> +        xive_pq_set(x, lisn, XIVE_ESB_RESET);
>> +        return false;
>> +    case XIVE_ESB_QUEUED:
>> +        xive_pq_set(x, lisn, XIVE_ESB_PENDING);
>> +        return true;
>> +    case XIVE_ESB_OFF:
>> +        xive_pq_set(x, lisn, XIVE_ESB_OFF);
>> +        return false;
>> +    default:
>> +         g_assert_not_reached();
>> +    }
>> +}
>> +
>> +static bool xive_pq_trigger(XIVE *x, uint32_t lisn)
>> +{
>> +    uint8_t old_pq =3D xive_pq_get(x, lisn);
>> +
>> +    switch (old_pq) {
>> +    case XIVE_ESB_RESET:
>> +        xive_pq_set(x, lisn, XIVE_ESB_PENDING);
>> +        return true;
>> +    case XIVE_ESB_PENDING:
>> +        xive_pq_set(x, lisn, XIVE_ESB_QUEUED);
>> +        return true;
>> +    case XIVE_ESB_QUEUED:
>> +        xive_pq_set(x, lisn, XIVE_ESB_QUEUED);
>> +        return true;
>> +    case XIVE_ESB_OFF:
>> +        xive_pq_set(x, lisn, XIVE_ESB_OFF);
>> +        return false;
>> +    default:
>> +         g_assert_not_reached();
>> +    }
>> +}
>> +
>> +/*
>> + * XIVE Interrupt Source MMIOs
>> + */
>> +static void xive_ics_eoi(XiveICSState *xs, uint32_t srcno)
>> +{
>> +    ICSIRQState *irq =3D &ICS_BASE(xs)->irqs[srcno];
>> +
>> +    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
>> +        irq->status &=3D ~XICS_STATUS_SENT;
>> +    }
>> +}
>> +
>> +/* TODO: handle second page */
>=20
> Is this comment still relevent?

Some HW have a second page to trigger the event. I am not sure we need=20
to model it though. I will make some inquiries.=20

>> +static uint64_t xive_esb_read(void *opaque, hwaddr addr, unsigned siz=
e)
>> +{
>> +    XiveICSState *xs =3D ICS_XIVE(opaque);
>> +    XIVE *x =3D xs->xive;
>> +    uint32_t offset =3D addr & 0xF00;
>> +    uint32_t srcno =3D addr >> xs->esb_shift;
>> +    uint32_t lisn =3D srcno + ICS_BASE(xs)->offset;
>> +    XiveIVE *ive;
>> +    uint64_t ret =3D -1;
>> +
>> +    ive =3D xive_get_ive(x, lisn);
>> +    if (!ive || !(ive->w & IVE_VALID))  {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lis=
n);
>> +        goto out;
>> +    }
>> +
>> +    if (srcno >=3D ICS_BASE(xs)->nr_irqs) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "XIVE: invalid IRQ number: %d/%d lisn: %d\n",
>> +                      srcno, ICS_BASE(xs)->nr_irqs, lisn);
>> +        goto out;
>> +    }
>> +
>> +    switch (offset) {
>> +    case 0:
>> +        xive_ics_eoi(xs, srcno);
>> +
>> +        /* return TRUE or FALSE depending on PQ value */
>> +        ret =3D xive_pq_eoi(x, lisn);
>> +        break;
>> +
>> +    case XIVE_ESB_GET:
>> +        ret =3D xive_pq_get(x, lisn);
>> +        break;
>> +
>> +    case XIVE_ESB_SET_PQ_00:
>> +    case XIVE_ESB_SET_PQ_01:
>> +    case XIVE_ESB_SET_PQ_10:
>> +    case XIVE_ESB_SET_PQ_11:
>> +        ret =3D xive_pq_get(x, lisn);
>> +        xive_pq_set(x, lisn, (offset >> 8) & 0x3);
>=20
> Again I'd prefer xive_pq_set() return the old value itself, for more
> obvious atomicity.

yes. ok.

>=20
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
>> +static void xive_esb_write(void *opaque, hwaddr addr,
>> +                           uint64_t value, unsigned size)
>> +{
>> +    XiveICSState *xs =3D ICS_XIVE(opaque);
>> +    XIVE *x =3D xs->xive;
>> +    uint32_t offset =3D addr & 0xF00;
>> +    uint32_t srcno =3D addr >> xs->esb_shift;
>> +    uint32_t lisn =3D srcno + ICS_BASE(xs)->offset;
>> +    XiveIVE *ive;
>> +    bool notify =3D false;
>> +
>> +    ive =3D xive_get_ive(x, lisn);
>> +    if (!ive || !(ive->w & IVE_VALID))  {
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lis=
n);
>> +        return;
>> +    }
>=20
> Having this code associated with the individual ICS look directly at
> the IVE table in the core xive object seems a bit dubious.

The IVE table holds the validity and mask status of the interrupt=20
entries, so we need that lookup. However, (continues below) ...

> This also
> points out another mismatch between the re-used ICS code and the new
> XIVE code: ICS gathers all the per-source-irq flags/state into the
> irqstate structure, whereas xive has per-irq information in the
> centralized ecb and IVE tables.  There can certainly be good reasons
> for that, but using both at once is kind of clunky.

I understand that you would rather put the esbs in the source they=20
belong to. That is the case on real HW but it makes the modeling a=20
bit more difficult. We would need to choose a MMIO address to give=20
to the guest OS. I had some issues with the allocator (I need=20
to look at this problem closer).

It might also be an "issue" for KVM. Ben talked about maintaining=20
all the esbs of a guest under a single memory region to be able to=20
map the pages in the host.

Any how, I agree this is another point to discuss in the sPAPR=20
model.

Thanks,

C.=20


>> +    if (srcno >=3D ICS_BASE(xs)->nr_irqs) {
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "XIVE: invalid IRQ number: %d/%d lisn: %d\n",
>> +                      srcno, ICS_BASE(xs)->nr_irqs, lisn);
>> +        return;
>> +    }
>> +
>> +    switch (offset) {
>> +    case 0:
>> +        /* TODO: should we trigger even if the IVE is masked ? */
>> +        notify =3D xive_pq_trigger(x, lisn);
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr =
%d\n",
>> +                      offset);
>> +        return;
>> +    }
>> +
>> +    if (notify && !(ive->w & IVE_MASKED)) {
>> +        qemu_irq_pulse(ICS_BASE(xs)->qirqs[srcno]);
>> +    }
>> +}
>> +
>> +static const MemoryRegionOps xive_esb_ops =3D {
>> +    .read =3D xive_esb_read,
>> +    .write =3D xive_esb_write,
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
>>  static void xive_ics_set_irq_msi(XiveICSState *xs, int srcno, int val=
)
>> @@ -106,15 +326,25 @@ static void xive_ics_realize(ICSState *ics, Erro=
r **errp)
>>          return;
>>      }
>> =20
>> +    if (!xs->esb_shift) {
>> +        error_setg(errp, "ESB page size needs to be greater 0");
>> +        return;
>> +    }
>> +
>>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>>      ics->qirqs =3D qemu_allocate_irqs(xive_ics_set_irq, xs, ics->nr_i=
rqs);
>> =20
>> +    memory_region_init_io(&xs->esb_iomem, OBJECT(xs), &xive_esb_ops, =
xs,
>> +                          "xive.esb",
>> +                          (1ull << xs->esb_shift) * ICS_BASE(xs)->nr_=
irqs);
>> +
>>      qemu_register_reset(xive_ics_reset, xs);
>>  }
>> =20
>>  static Property xive_ics_properties[] =3D {
>>      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
>>      DEFINE_PROP_UINT32("irq-base", ICSState, offset, 0),
>> +    DEFINE_PROP_UINT32("shift", XiveICSState, esb_shift, 0),
>>      DEFINE_PROP_END_OF_LIST(),
>>  };
>> =20
>> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
>> index 544cc6e0c796..5303d96f5f59 100644
>> --- a/include/hw/ppc/xive.h
>> +++ b/include/hw/ppc/xive.h
>> @@ -33,6 +33,9 @@ typedef struct XiveICSState XiveICSState;
>>  struct XiveICSState {
>>      ICSState parent_obj;
>> =20
>> +    uint32_t     esb_shift;
>> +    MemoryRegion esb_iomem;
>> +
>>      XIVE         *xive;
>>  };
>> =20
>=20
