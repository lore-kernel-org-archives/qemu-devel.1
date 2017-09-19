Received: from eggs.gnu.org ([2001:4830:134:3::10]:51214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtX-0001Go-9k
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtT-0002sC-G6
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:47 -0400
Date: Tue, 19 Sep 2017 12:57:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919025747.GM27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-8-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Cqq5NadOW2RfLMJ/"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-8-clg@kaod.org>
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
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, Alexander Graf <agraf@suse.de>


--Cqq5NadOW2RfLMJ/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:21PM +0200, C=E9dric Le Goater wrote:
> Each interrupt source is associated with a two bit state machine
> called an Event State Buffer (ESB) which is controlled by MMIO to
> trigger events. See code for more details on the states and
> transitions.
>=20
> The MMIO space for the ESB translation is 512GB large on baremetal
> (powernv) systems and the BAR depends on the chip id. In our model for
> the sPAPR machine, we choose to only map a sub memory region for the
> provisionned IRQ numbers and to use the mapping address of chip 0 on a
> real system. The OS will get the address of the MMIO page of the ESB
> entry associated with an IRQ using the H_INT_GET_SOURCE_INFO hcall.

On bare metal, are the MMIOs for each irq source mapped contiguously?

> For KVM support, we should think of a way to map this QEMU memory
> region in the host to trigger events directly.

This would rely on being able to map them without mapping those for
any other VM or the host.  Does that mean allocating a contiguous (and
aligned) hunk of irqs for a guest?

We're going to need to be careful about irq allocation here.
Even though GET_SOURCE_INFO allows dynamic mapping of irq numbers to
MMIO addresses, we need the MMIO addresses to be stable and
consistent, because we can't have them change across migration.  We
need to have this consistent between in-qemu and in-KVM XIVE
implementations as well.

>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c        | 255 ++++++++++++++++++++++++++++++++++++++=
++++++
>  include/hw/ppc/spapr_xive.h |   6 ++
>  2 files changed, 261 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 1ed7b6a286e9..8a85d64efc4c 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -33,6 +33,218 @@ static void spapr_xive_irq(sPAPRXive *xive, int srcno)
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
> +#define XIVE_ESB_PENDING        XIVE_ESB_VAL_P
> +#define XIVE_ESB_QUEUED         (XIVE_ESB_VAL_P | XIVE_ESB_VAL_Q)
> +#define XIVE_ESB_OFF            XIVE_ESB_VAL_Q
> +
> +static uint8_t spapr_xive_pq_get(sPAPRXive *xive, uint32_t idx)
> +{
> +    uint32_t byte =3D idx / 4;
> +    uint32_t bit  =3D (idx % 4) * 2;
> +
> +    assert(byte < xive->sbe_size);
> +
> +    return (xive->sbe[byte] >> bit) & 0x3;
> +}
> +
> +static uint8_t spapr_xive_pq_set(sPAPRXive *xive, uint32_t idx, uint8_t =
pq)
> +{
> +    uint32_t byte =3D idx / 4;
> +    uint32_t bit  =3D (idx % 4) * 2;
> +    uint8_t old, new;
> +
> +    assert(byte < xive->sbe_size);
> +
> +    old =3D xive->sbe[byte];
> +
> +    new =3D xive->sbe[byte] & ~(0x3 << bit);
> +    new |=3D (pq & 0x3) << bit;
> +
> +    xive->sbe[byte] =3D new;
> +
> +    return (old >> bit) & 0x3;
> +}
> +
> +static bool spapr_xive_pq_eoi(sPAPRXive *xive, uint32_t srcno)
> +{
> +    uint8_t old_pq =3D spapr_xive_pq_get(xive, srcno);
> +
> +    switch (old_pq) {
> +    case XIVE_ESB_RESET:
> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_RESET);
> +        return false;
> +    case XIVE_ESB_PENDING:
> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_RESET);
> +        return false;
> +    case XIVE_ESB_QUEUED:
> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_PENDING);
> +        return true;
> +    case XIVE_ESB_OFF:
> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_OFF);
> +        return false;
> +    default:
> +         g_assert_not_reached();
> +    }
> +}
> +
> +static bool spapr_xive_pq_trigger(sPAPRXive *xive, uint32_t srcno)
> +{
> +    uint8_t old_pq =3D spapr_xive_pq_get(xive, srcno);
> +
> +    switch (old_pq) {
> +    case XIVE_ESB_RESET:
> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_PENDING);
> +        return true;
> +    case XIVE_ESB_PENDING:
> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_QUEUED);
> +        return true;
> +    case XIVE_ESB_QUEUED:
> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_QUEUED);
> +        return true;
> +    case XIVE_ESB_OFF:
> +        spapr_xive_pq_set(xive, srcno, XIVE_ESB_OFF);
> +        return false;
> +    default:
> +         g_assert_not_reached();
> +    }
> +}
> +
> +/*
> + * XIVE Interrupt Source MMIOs
> + */
> +static void spapr_xive_source_eoi(sPAPRXive *xive, uint32_t srcno)
> +{
> +    ICSIRQState *irq =3D &xive->ics->irqs[srcno];
> +
> +    if (irq->flags & XICS_FLAGS_IRQ_LSI) {
> +        irq->status &=3D ~XICS_STATUS_SENT;
> +    }
> +}
> +
> +/* TODO: handle second page
> + *
> + * Some HW use a separate page for trigger. We only support the case
> + * in which the trigger can be done in the same page as the EOI.
> + */
> +static uint64_t spapr_xive_esb_read(void *opaque, hwaddr addr, unsigned =
size)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
> +    uint32_t offset =3D addr & 0xF00;
> +    uint32_t srcno =3D addr >> xive->esb_shift;
> +    XiveIVE *ive;
> +    uint64_t ret =3D -1;
> +
> +    ive =3D spapr_xive_get_ive(xive, srcno);
> +    if (!ive || !(ive->w & IVE_VALID))  {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", srcno);
> +        goto out;

Since there's a whole (4k) page for each source, I wonder if we should
actually map each one as a separate MMIO region to allow us to tweak
the mappings more flexibly.

> +    }
> +
> +    switch (offset) {
> +    case 0:
> +        spapr_xive_source_eoi(xive, srcno);
> +
> +        /* return TRUE or FALSE depending on PQ value */
> +        ret =3D spapr_xive_pq_eoi(xive, srcno);
> +        break;
> +
> +    case XIVE_ESB_GET:
> +        ret =3D spapr_xive_pq_get(xive, srcno);
> +        break;
> +
> +    case XIVE_ESB_SET_PQ_00:
> +    case XIVE_ESB_SET_PQ_01:
> +    case XIVE_ESB_SET_PQ_10:
> +    case XIVE_ESB_SET_PQ_11:
> +        ret =3D spapr_xive_pq_set(xive, srcno, (offset >> 8) & 0x3);
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
> +static void spapr_xive_esb_write(void *opaque, hwaddr addr,
> +                           uint64_t value, unsigned size)
> +{
> +    sPAPRXive *xive =3D SPAPR_XIVE(opaque);
> +    uint32_t offset =3D addr & 0xF00;
> +    uint32_t srcno =3D addr >> xive->esb_shift;
> +    XiveIVE *ive;
> +    bool notify =3D false;
> +
> +    ive =3D spapr_xive_get_ive(xive, srcno);
> +    if (!ive || !(ive->w & IVE_VALID))  {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", srcno);
> +        return;
> +    }
> +
> +    switch (offset) {
> +    case 0:
> +        /* TODO: should we trigger even if the IVE is masked ? */
> +        notify =3D spapr_xive_pq_trigger(xive, srcno);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid ESB write addr %d\=
n",
> +                      offset);
> +        return;
> +    }
> +
> +    if (notify && !(ive->w & IVE_MASKED)) {
> +        qemu_irq_pulse(xive->qirqs[srcno]);
> +    }
> +}
> +
> +static const MemoryRegionOps spapr_xive_esb_ops =3D {
> +    .read =3D spapr_xive_esb_read,
> +    .write =3D spapr_xive_esb_write,
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
>  static void spapr_xive_source_set_irq_msi(sPAPRXive *xive, int srcno, in=
t val)
> @@ -74,6 +286,33 @@ static void spapr_xive_source_set_irq(void *opaque, i=
nt srcno, int val)
>  /*
>   * Main XIVE object
>   */
> +#define P9_MMIO_BASE     0x006000000000000ull
> +
> +/* VC BAR contains set translations for the ESBs and the EQs. */
> +#define VC_BAR_DEFAULT   0x10000000000ull
> +#define VC_BAR_SIZE      0x08000000000ull
> +#define ESB_SHIFT        16 /* One 64k page. OPAL has two */
> +
> +static uint64_t spapr_xive_esb_default_read(void *p, hwaddr offset,
> +                                            unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " [%u]\n",
> +                  __func__, offset, size);
> +    return 0;
> +}
> +
> +static void spapr_xive_esb_default_write(void *opaque, hwaddr offset,
> +                                         uint64_t value, unsigned size)
> +{
> +    qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx " <- 0x%" PRIx64 " [%=
u]\n",
> +                  __func__, offset, value, size);
> +}
> +
> +static const MemoryRegionOps spapr_xive_esb_default_ops =3D {
> +    .read =3D spapr_xive_esb_default_read,
> +    .write =3D spapr_xive_esb_default_write,
> +    .endianness =3D DEVICE_BIG_ENDIAN,
> +};
> =20
>  void spapr_xive_reset(void *dev)
>  {
> @@ -144,6 +383,22 @@ static void spapr_xive_realize(DeviceState *dev, Err=
or **errp)
>      xive->nr_eqs =3D xive->nr_targets * XIVE_EQ_PRIORITY_COUNT;
>      xive->eqt =3D g_malloc0(xive->nr_eqs * sizeof(XiveEQ));
> =20
> +    /* VC BAR. That's the full window but we will only map the
> +     * subregions in use. */
> +    xive->esb_base =3D (P9_MMIO_BASE | VC_BAR_DEFAULT);
> +    xive->esb_shift =3D ESB_SHIFT;
> +
> +    /* Install default memory region handlers to log bogus access */
> +    memory_region_init_io(&xive->esb_mr, NULL, &spapr_xive_esb_default_o=
ps,
> +                          NULL, "xive.esb.full", VC_BAR_SIZE);
> +    sysbus_init_mmio(SYS_BUS_DEVICE(dev), &xive->esb_mr);
> +
> +    /* Install the ESB memory region in the overall one */
> +    memory_region_init_io(&xive->esb_iomem, OBJECT(xive), &spapr_xive_es=
b_ops,
> +                          xive, "xive.esb",
> +                          (1ull << xive->esb_shift) * xive->nr_irqs);
> +    memory_region_add_subregion(&xive->esb_mr, 0, &xive->esb_iomem);
> +
>      qemu_register_reset(spapr_xive_reset, dev);
>  }
> =20
> diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
> index eab92c4c1bb8..0f516534d76a 100644
> --- a/include/hw/ppc/spapr_xive.h
> +++ b/include/hw/ppc/spapr_xive.h
> @@ -46,6 +46,12 @@ struct sPAPRXive {
>      XiveIVE      *ivt;
>      XiveEQ       *eqt;
>      uint32_t     nr_eqs;
> +
> +    /* ESB memory region */
> +    uint32_t     esb_shift;
> +    hwaddr       esb_base;
> +    MemoryRegion esb_mr;
> +    MemoryRegion esb_iomem;
>  };
> =20
>  #endif /* PPC_SPAPR_XIVE_H */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Cqq5NadOW2RfLMJ/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAh6sACgkQbDjKyiDZ
s5KWhhAAk5yI2vUf6rJ003uXpHwneX/lVwCOkzZWjTpHXbs6/CvtFpPgDGg8e+uY
Y4SO3Ht2+9lWOCH+XXouB8rRoPUdT3PxMEuJYJvQ/K6d0ozVcKGayZRVFnhWX6zz
yKhqzzCzfrGNFjfbQ0SpqgH8eGxtfTD8PdFZELzR1iMuDyCyL9hJrntBIQVvpG5x
iTHvZN9vVwcaK0dS76NAgP5LM8jZGJLS8vIxGnF6EQyiFqfSiuQxhKjGF6mHR2BD
72L1/SMzBFFOvm3tZOi7xemmXXWL8D4OVV4xy0jwMW8mZb2JNalnRW72JE4DIOM7
dzuJQYnRm+RvFEZGFmlXu5+Ymv7ZrKS4C7cGAPoYcnb1c4wJrW6kKqRhXsjTrmvV
yVWE4DAlWEGsHAjk/PRZgWK57mr+2CrqC5WQaPLZ0tGQBZX6dJJSqg6wFr3rtX1M
qyegLG8jY+KqM5NJLkkpO5oTGkf2DBo+4OWlm3UZJPJXXBOkJC2IAy4hWmyQmjGZ
CH5Pu0NKJZse6b1pwwSchCGYBBQBLPKuZXPk1soDWSGDwbj5jIs12LimRB2p98wD
1xypo7RaEXHfHn3J3KYJHgmgYWPzPzFWoKFrIEyvlY0gw2BTrk03aCfv6U5HCQzI
xpf4Zyp2p98lBuvltzRuQvKDLa6QfHArBVuDKKVl5hDq+5g/fUU=
=3ceD
-----END PGP SIGNATURE-----

--Cqq5NadOW2RfLMJ/--
