Received: from eggs.gnu.org ([2001:4830:134:3::10]:51183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtW-0001G0-Dy
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtT-0002tF-Un
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:46 -0400
Date: Tue, 19 Sep 2017 17:45:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919074556.GO27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-12-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="i7KxW38SoMauyveo"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-12-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 11/21] ppc/xive: push the EQ data in
 OS event queue
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


--i7KxW38SoMauyveo
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:25PM +0200, C=E9dric Le Goater wrote:
> If a triggered event is let through, the Event Queue data defined in
> the associated IVE is pushed in the in-memory event queue. The latter
> is a circular buffer provided by the OS using the H_INT_SET_QUEUE_CONFIG
> hcall, one per target and priority couple. It is composed of Event
> Queue entries which are 4 bytes long, the first bit being a
> 'generation' bit and the 31 following bits the EQ Data field.
>=20
> The EQ Data field provides a way to set an invariant logical event
> source number for an IRQ. It is set with the H_INT_SET_SOURCE_CONFIG
> hcall.
>=20
> Notification of the CPU will be done in the following patch.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 67 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 557a7e2535b5..4bc61cfda67a 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -175,9 +175,76 @@ static const MemoryRegionOps spapr_xive_tm_ops =3D {
>      },
>  };
> =20
> +static void spapr_xive_eq_push(XiveEQ *eq, uint32_t data)
> +{
> +    uint64_t qaddr_base =3D (((uint64_t)(eq->w2 & 0x0fffffff)) << 32) | =
eq->w3;
> +    uint32_t qsize =3D GETFIELD(EQ_W0_QSIZE, eq->w0);
> +    uint32_t qindex =3D GETFIELD(EQ_W1_PAGE_OFF, eq->w1);
> +    uint32_t qgen =3D GETFIELD(EQ_W1_GENERATION, eq->w1);
> +
> +    uint64_t qaddr =3D qaddr_base + (qindex << 2);
> +    uint32_t qdata =3D cpu_to_be32((qgen << 31) | (data & 0x7fffffff));
> +    uint32_t qentries =3D 1 << (qsize + 10);
> +
> +    if (dma_memory_write(&address_space_memory, qaddr, &qdata, sizeof(qd=
ata))) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: failed to write EQ data @0x%"
> +                      HWADDR_PRIx "\n", __func__, qaddr);
> +        return;
> +    }
> +
> +    qindex =3D (qindex + 1) % qentries;
> +    if (qindex =3D=3D 0) {
> +        qgen ^=3D 1;
> +        eq->w1 =3D SETFIELD(EQ_W1_GENERATION, eq->w1, qgen);
> +    }
> +    eq->w1 =3D SETFIELD(EQ_W1_PAGE_OFF, eq->w1, qindex);
> +}
> +
>  static void spapr_xive_irq(sPAPRXive *xive, int srcno)
>  {
> +    XiveIVE *ive;
> +    XiveEQ *eq;
> +    uint32_t eq_idx;
> +    uint32_t priority;
> +
> +    ive =3D spapr_xive_get_ive(xive, srcno);
> +    if (!ive || !(ive->w & IVE_VALID)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", srcno);
> +        return;
> +    }
> +
> +    if (ive->w & IVE_MASKED) {
> +        return;
> +    }
> +
> +    /* Find our XiveEQ */
> +    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
> +    eq =3D spapr_xive_get_eq(xive, eq_idx);
> +    if (!eq) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ for LISN %d\n", srcn=
o);
> +        return;
> +    }
> +
> +    if (eq->w0 & EQ_W0_ENQUEUE) {
> +        spapr_xive_eq_push(eq, GETFIELD(IVE_EQ_DATA, ive->w));
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "XIVE: !ENQUEUE not implemented\n");
> +    }
> +
> +    if (!(eq->w0 & EQ_W0_UCOND_NOTIFY)) {
> +        qemu_log_mask(LOG_UNIMP, "XIVE: !UCOND_NOTIFY not implemented\n"=
);
> +    }
> +
> +    if (GETFIELD(EQ_W6_FORMAT_BIT, eq->w6) =3D=3D 0) {
> +        priority =3D GETFIELD(EQ_W7_F0_PRIORITY, eq->w7);
> =20
> +        /* The EQ is masked. Can this happen ?  */
> +        if (priority =3D=3D 0xff) {
> +            return;

How does the 8-bit priority field here interact with the 3-bit
priority which selects which EQ to use?

> +        }
> +    } else {
> +        qemu_log_mask(LOG_UNIMP, "XIVE: w7 format1 not implemented\n");
> +    }
>  }
> =20
>  /*

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--i7KxW38SoMauyveo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAyzQACgkQbDjKyiDZ
s5LDyQ/9EoJd5fsJliNAG7JBeNLy6ZDAwyWyA32l/xwdqJA80O1NKj6kesWSFUUs
a/zFm+HatbZB5OiA7rtQFAIv8TlZ+FhdGFVhnERtSZKkDeQe3RwqyYct16pTh+cY
xBg1Fr7t5tsSSv02gFZmxN33vBWrqrLBuRI0keeu/u8eL5UGOgGdwhEwUgPS3qN0
4d0K9rDpi5dKrzpeULaEI9ZdFrRa0J7z5E93Yv4+yf8zlbEdqMZ+KeqsfbiIW8iQ
m4XrfISaHmizJQQ2xqzCSj2GnBhV4CwIq8CVZGjTAnt6f0Z7e9FwT1cSqPbL8juG
lSwjlwvZBpgHCeCTd6frQrDgb4ifaSv5nF2zsp1f9bEN121nKZsR9FLQZT5bjGNU
7rPkiA3I/qSXBcjr0xd02czY+X7j/3ZgoTRcssEvf87wgat1qi8BXLhh4hOXHp+B
xttMwp0RjHgcnIxhpdortPM6PfIMkd59eTXr+ZPlJF5ytrA1gS9vX9DldKo4RCxX
Z5l855u4bmIzFxDm21c5XI4nSQpcRL/Cz91DrTEfClBri4o77i1hdm5X7dsNzVrf
4YSHYrNgFf+4YCnD+ZI9XjbNqFksdhFMjNUEbTKbiG3ugtUT5YPh76a8MRsmOLW5
1bTpu+5hjttjPdmKIIqwOvFmXSdJf93b6q93oqLiSAja7Gk5wyY=
=XskW
-----END PGP SIGNATURE-----

--i7KxW38SoMauyveo--
