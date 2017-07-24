Received: from eggs.gnu.org ([2001:4830:134:3::10]:55877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZV56-0004Km-Cc
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 00:34:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dZV54-0003XM-Iw
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 00:34:56 -0400
Date: Mon, 24 Jul 2017 14:29:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170724042956.GD17228@umbus.fritz.box>
References: <1499274819-15607-1-git-send-email-clg@kaod.org>
	<1499274819-15607-8-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+KJYzRxRHjYqLGl5"
Content-Disposition: inline
In-Reply-To: <1499274819-15607-8-git-send-email-clg@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--+KJYzRxRHjYqLGl5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 05, 2017 at 07:13:20PM +0200, C=E9dric Le Goater wrote:
> Each interrupt source is associated with a 2-bit state machine called
> an Event State Buffer (ESB). It is controlled by MMIO to trigger
> events.
>=20
> See code for more details on the states.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/xive.c        | 230 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/xive.h |   3 +
>  2 files changed, 233 insertions(+)
>=20
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 9ff14c0da595..816031b8ac81 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -32,6 +32,226 @@ static void xive_icp_irq(XiveICSState *xs, int lisn)
>  }
> =20
>  /*
> + * "magic" Event State Buffer (ESB) MMIO offsets.
> + *
> + * Each interrupt source has a 2-bit state machine called ESB
> + * which can be controlled by MMIO. It's made of 2 bits, P and
> + * Q. P indicates that an interrupt is pending (has been sent
> + * to a queue and is waiting for an EOI). Q indicates that the
> + * interrupt has been triggered while pending.
> + *
> + * This acts as a coalescing mechanism in order to guarantee
> + * that a given interrupt only occurs at most once in a queue.
> + *
> + * When doing an EOI, the Q bit will indicate if the interrupt
> + * needs to be re-triggered.
> + *
> + * The following offsets into the ESB MMIO allow to read or
> + * manipulate the PQ bits. They must be used with an 8-bytes
> + * load instruction. They all return the previous state of the
> + * interrupt (atomically).
> + *
> + * Additionally, some ESB pages support doing an EOI via a
> + * store at 0 and some ESBs support doing a trigger via a
> + * separate trigger page.
> + */
> +#define XIVE_ESB_GET            0x800
> +#define XIVE_ESB_SET_PQ_00      0xc00
> +#define XIVE_ESB_SET_PQ_01      0xd00
> +#define XIVE_ESB_SET_PQ_10      0xe00
> +#define XIVE_ESB_SET_PQ_11      0xf00
> +
> +#define XIVE_ESB_VAL_P          0x2
> +#define XIVE_ESB_VAL_Q          0x1
> +
> +#define XIVE_ESB_RESET          0x0
> +#define XIVE_ESB_PENDING        0x2
> +#define XIVE_ESB_QUEUED         0x3
> +#define XIVE_ESB_OFF            0x1
> +
> +static uint8_t xive_pq_get(XIVE *x, uint32_t lisn)
> +{
> +    uint32_t idx =3D lisn;
> +    uint32_t byte =3D idx / 4;
> +    uint32_t bit  =3D (idx % 4) * 2;
> +    uint8_t* pqs =3D (uint8_t *) x->sbe;
> +
> +    return (pqs[byte] >> bit) & 0x3;
> +}
> +
> +static void xive_pq_set(XIVE *x, uint32_t lisn, uint8_t pq)
> +{
> +    uint32_t idx =3D lisn;
> +    uint32_t byte =3D idx / 4;
> +    uint32_t bit  =3D (idx % 4) * 2;
> +    uint8_t* pqs =3D (uint8_t *) x->sbe;
> +
> +    pqs[byte] &=3D ~(0x3 << bit);
> +    pqs[byte] |=3D (pq & 0x3) << bit;

I know it probably amounts to the same thing given the context, but
I'd be more comfortable with a temporary and an obviously atomic
update than two writes to the real state variable.

> +}
> +
> +static bool xive_pq_eoi(XIVE *x, uint32_t lisn)
> +{
> +    uint8_t old_pq =3D xive_pq_get(x, lisn);
> +
> +    switch (old_pq) {
> +    case XIVE_ESB_RESET:
> +        xive_pq_set(x, lisn, XIVE_ESB_RESET);
> +        return false;
> +    case XIVE_ESB_PENDING:
> +        xive_pq_set(x, lisn, XIVE_ESB_RESET);
> +        return false;
> +    case XIVE_ESB_QUEUED:
> +        xive_pq_set(x, lisn, XIVE_ESB_PENDING);
> +        return true;
> +    case XIVE_ESB_OFF:
> +        xive_pq_set(x, lisn, XIVE_ESB_OFF);
> +        return false;
> +    default:
> +         g_assert_not_reached();
> +    }
> +}
> +
> +static bool xive_pq_trigger(XIVE *x, uint32_t lisn)
> +{
> +    uint8_t old_pq =3D xive_pq_get(x, lisn);
> +
> +    switch (old_pq) {
> +    case XIVE_ESB_RESET:
> +        xive_pq_set(x, lisn, XIVE_ESB_PENDING);
> +        return true;
> +    case XIVE_ESB_PENDING:
> +        xive_pq_set(x, lisn, XIVE_ESB_QUEUED);
> +        return true;
> +    case XIVE_ESB_QUEUED:
> +        xive_pq_set(x, lisn, XIVE_ESB_QUEUED);
> +        return true;
> +    case XIVE_ESB_OFF:
> +        xive_pq_set(x, lisn, XIVE_ESB_OFF);
> +        return false;
> +    default:
> +         g_assert_not_reached();
> +    }
> +}
> +
> +/*
> + * XIVE Interrupt Source MMIOs
> + */
> +static void xive_ics_eoi(XiveICSState *xs, uint32_t srcno)
> +{
> +    ICSIRQState *irq =3D &ICS_BASE(xs)->irqs[srcno];
> +
> +    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
> +        irq->status &=3D ~XICS_STATUS_SENT;
> +    }
> +}
> +
> +/* TODO: handle second page */

Is this comment still relevent?

> +static uint64_t xive_esb_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    XiveICSState *xs =3D ICS_XIVE(opaque);
> +    XIVE *x =3D xs->xive;
> +    uint32_t offset =3D addr & 0xF00;
> +    uint32_t srcno =3D addr >> xs->esb_shift;
> +    uint32_t lisn =3D srcno + ICS_BASE(xs)->offset;
> +    XiveIVE *ive;
> +    uint64_t ret =3D -1;
> +
> +    ive =3D xive_get_ive(x, lisn);
> +    if (!ive || !(ive->w & IVE_VALID))  {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lisn);
> +        goto out;
> +    }
> +
> +    if (srcno >=3D ICS_BASE(xs)->nr_irqs) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "XIVE: invalid IRQ number: %d/%d lisn: %d\n",
> +                      srcno, ICS_BASE(xs)->nr_irqs, lisn);
> +        goto out;
> +    }
> +
> +    switch (offset) {
> +    case 0:
> +        xive_ics_eoi(xs, srcno);
> +
> +        /* return TRUE or FALSE depending on PQ value */
> +        ret =3D xive_pq_eoi(x, lisn);
> +        break;
> +
> +    case XIVE_ESB_GET:
> +        ret =3D xive_pq_get(x, lisn);
> +        break;
> +
> +    case XIVE_ESB_SET_PQ_00:
> +    case XIVE_ESB_SET_PQ_01:
> +    case XIVE_ESB_SET_PQ_10:
> +    case XIVE_ESB_SET_PQ_11:
> +        ret =3D xive_pq_get(x, lisn);
> +        xive_pq_set(x, lisn, (offset >> 8) & 0x3);

Again I'd prefer xive_pq_set() return the old value itself, for more
obvious atomicity.

> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB addr %d\n", of=
fset);
> +    }
> +
> +out:
> +    return ret;
> +}
> +
> +static void xive_esb_write(void *opaque, hwaddr addr,
> +                           uint64_t value, unsigned size)
> +{
> +    XiveICSState *xs =3D ICS_XIVE(opaque);
> +    XIVE *x =3D xs->xive;
> +    uint32_t offset =3D addr & 0xF00;
> +    uint32_t srcno =3D addr >> xs->esb_shift;
> +    uint32_t lisn =3D srcno + ICS_BASE(xs)->offset;
> +    XiveIVE *ive;
> +    bool notify =3D false;
> +
> +    ive =3D xive_get_ive(x, lisn);
> +    if (!ive || !(ive->w & IVE_VALID))  {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lisn);
> +        return;
> +    }

Having this code associated with the individual ICS look directly at
the IVE table in the core xive object seems a bit dubious.  This also
points out another mismatch between the re-used ICS code and the new
XIVE code: ICS gathers all the per-source-irq flags/state into the
irqstate structure, whereas xive has per-irq information in the
centralized ecb and IVE tables.  There can certainly be good reasons
for that, but using both at once is kind of clunky.

> +    if (srcno >=3D ICS_BASE(xs)->nr_irqs) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "XIVE: invalid IRQ number: %d/%d lisn: %d\n",
> +                      srcno, ICS_BASE(xs)->nr_irqs, lisn);
> +        return;
> +    }
> +
> +    switch (offset) {
> +    case 0:
> +        /* TODO: should we trigger even if the IVE is masked ? */
> +        notify =3D xive_pq_trigger(x, lisn);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr %d\=
n",
> +                      offset);
> +        return;
> +    }
> +
> +    if (notify && !(ive->w & IVE_MASKED)) {
> +        qemu_irq_pulse(ICS_BASE(xs)->qirqs[srcno]);
> +    }
> +}
> +
> +static const MemoryRegionOps xive_esb_ops =3D {
> +    .read =3D xive_esb_read,
> +    .write =3D xive_esb_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +    .valid =3D {
> +        .min_access_size =3D 8,
> +        .max_access_size =3D 8,
> +    },
> +    .impl =3D {
> +        .min_access_size =3D 8,
> +        .max_access_size =3D 8,
> +    },
> +};
> +
> +/*
>   * XIVE Interrupt Source
>   */
>  static void xive_ics_set_irq_msi(XiveICSState *xs, int srcno, int val)
> @@ -106,15 +326,25 @@ static void xive_ics_realize(ICSState *ics, Error *=
*errp)
>          return;
>      }
> =20
> +    if (!xs->esb_shift) {
> +        error_setg(errp, "ESB page size needs to be greater 0");
> +        return;
> +    }
> +
>      ics->irqs =3D g_malloc0(ics->nr_irqs * sizeof(ICSIRQState));
>      ics->qirqs =3D qemu_allocate_irqs(xive_ics_set_irq, xs, ics->nr_irqs=
);
> =20
> +    memory_region_init_io(&xs->esb_iomem, OBJECT(xs), &xive_esb_ops, xs,
> +                          "xive.esb",
> +                          (1ull << xs->esb_shift) * ICS_BASE(xs)->nr_irq=
s);
> +
>      qemu_register_reset(xive_ics_reset, xs);
>  }
> =20
>  static Property xive_ics_properties[] =3D {
>      DEFINE_PROP_UINT32("nr-irqs", ICSState, nr_irqs, 0),
>      DEFINE_PROP_UINT32("irq-base", ICSState, offset, 0),
> +    DEFINE_PROP_UINT32("shift", XiveICSState, esb_shift, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
> =20
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 544cc6e0c796..5303d96f5f59 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -33,6 +33,9 @@ typedef struct XiveICSState XiveICSState;
>  struct XiveICSState {
>      ICSState parent_obj;
> =20
> +    uint32_t     esb_shift;
> +    MemoryRegion esb_iomem;
> +
>      XIVE         *xive;
>  };
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+KJYzRxRHjYqLGl5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll1d74ACgkQbDjKyiDZ
s5J/1hAAi5T1TW6xFaev/6xMc2ou82xpOX37BtTXHNPYchEyzb6aA2FGElJ9Ze5E
r4PjL8jzfT/Axh3sIAtxyY3+w1i6APFOXJCCDc96JHAypbfdtRujK9WaS9nbYBdl
lX4/xKUcuwqSr55KMqzcoMXusqMF8LVeSKKHHbBe9HJIC0zPBlTZxdihNKhr0PuA
RR/4BI8ivWxu3Z93DmjokXlor0FZZvu72Too0s1dtHVqSdDBEHnxEkRRV8tUPbiD
l8znLqac3evKWTYQgT+exrydR514LlQS/cCTRvB41U9QHla9sQH0XvZxpEVg02v6
ZLxgKZs1H+zNpECeXICKZ/+DaRHQlmzXoTvf298yWdoyz4smmDfsiuevO38np+5B
QoecvFVvE+4ee2i6knz4QP2A2ZBaJyQn6/2Z6wD9Wn1rXH+5XsLyft+DREyul4eM
vkk/dFcEVUhPoSaDLOLhvABy2rVRlpI3jsSGVtA8MT9o6l0zsTAcgF482dUaq9Q/
PdItzKh8F//mE5jAiuE9q2g2TUWacHTJTsCLCOHWfgKgdYp621CfvTlcX9FvVHeZ
DmH2pmzC+zd0LtMSOYXYMAxlQRdWNaW06h42KcFYAPnOEJNtKyKOEBT8CSCsNkbs
w5177YRIcv7w3LKatXgjzXfNZLSLR8wKHuh9UK/rRP6cRcCSQwQ=
=/P1t
-----END PGP SIGNATURE-----

--+KJYzRxRHjYqLGl5--
