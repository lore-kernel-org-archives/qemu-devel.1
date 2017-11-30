Received: from eggs.gnu.org ([2001:4830:134:3::10]:50692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKH1A-0005PF-5k
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:04:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eKH17-0005b0-AU
	for qemu-devel@nongnu.org; Thu, 30 Nov 2017 00:04:12 -0500
Date: Thu, 30 Nov 2017 15:49:22 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171130044922.GC3023@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-15-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VcZjVMblxkg0/8Ur"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-15-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 14/25] spapr: push the XIVE EQ data in OS
 event queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--VcZjVMblxkg0/8Ur
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:44PM +0100, C=E9dric Le Goater wrote:
> If a triggered event is let through, the Event Queue data defined in the
> associated IVE is pushed in the in-memory event queue. The latter is a
> circular buffer provided by the OS using the H_INT_SET_QUEUE_CONFIG hcall,
> one per server and priority couple. It is composed of Event Queue entries
> which are 4 bytes long, the first bit being a 'generation' bit and the 31
> following bits the EQ Data field.
>=20
> The EQ Data field provides a way to set an invariant logical event source
> number for an IRQ. It is set with the H_INT_SET_SOURCE_CONFIG hcall.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c | 67 ++++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 67 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 983317a6b3f6..df14c5a88275 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -193,9 +193,76 @@ static sPAPRXiveICP *spapr_xive_icp_get(sPAPRXive *x=
ive, int server)
>      return cpu ? SPAPR_XIVE_ICP(cpu->intc) : NULL;
>  }
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

This suggests that uint32_t data contains guest endian data, which it
generally shouldn't.  Better to use stl_be_dma() (or whatever is
appropriate for the endianness of the data field.

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
>  static void spapr_xive_irq(sPAPRXive *xive, int lisn)
>  {
> +    XiveIVE *ive;
> +    XiveEQ *eq;
> +    uint32_t eq_idx;
> +    uint8_t priority;
> +
> +    ive =3D spapr_xive_get_ive(xive, lisn);
> +    if (!ive || !(ive->w & IVE_VALID)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid LISN %d\n", lisn);

As mentioned on other patches, I'm a little concerned by these
guest-triggerable logs.  I guess the LOG_GUEST_ERROR mask will save
us, though.

> +        return;
> +    }
> =20
> +    if (ive->w & IVE_MASKED) {
> +        return;
> +    }
> +
> +    /* Find our XiveEQ */
> +    eq_idx =3D GETFIELD(IVE_EQ_INDEX, ive->w);
> +    eq =3D spapr_xive_get_eq(xive, eq_idx);
> +    if (!eq) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No EQ for LISN %d\n", lisn=
);
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
> +
> +        /* The EQ is masked. Can this happen ?  */
> +        if (priority =3D=3D 0xff) {
> +            g_assert_not_reached();
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

--VcZjVMblxkg0/8Ur
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlofjc8ACgkQbDjKyiDZ
s5L5rQ//ZFdw44hCqkxtxeFcpYBNVJzl+FHWkSHurG6msHy/YX50859o8QRBKksr
oaWz/qCxgGkGv//AeGs7fK8pK6JjV2KJ9lhh7HaDXTN0bd9L/JzCE5AKf1O3dVkn
z/qi4lzYY5DGciaK4vgAMxLnM7BpaxG78naUF4pMQjNwhTAp8kjvUuEqvEqnD2ml
OafdxFaBp7LJyGJ3PpNAFDT6xlRQKFHe5wN6wQmpzRHyPCPTZzbietL78CP4sC7k
am2v7OWgDDwQdo0SsqNxXJy5BA9/lHOXiCWbYF/Axbxg3wjMx4fuqEvee/wHq39k
PJeDuCoj6mXdLINP7pkBRreCmc0L2PeZzmH3FmxesHawMg/fOD4ag8TzfNk/A/Bt
zER4w+U/fReiEB4+gvLlOgLEtlg3i2cLXWMnXWi6nzJoTPbF/uYN+2NbiBYjJGuL
TcfX9tiAUs5gA0HPea9ZSR8h/gFRRnOju0nUkvvEymNXPvERMTX8Ln9ZFFEfCznz
s1GgZjQa1GmAD7GMxPGvu8cTFYCkZnS8BjyYsPXVdK6gu04rht0RWcCk6kC+Q/1B
JsOBmtC4Zlp01IenPJwVeFqhOFMWdXOLK0cfdk/Up/8qr9lBdvC6qw1FMU821FT5
Th3XJEaWBo9o0i4bDrPDoy3DnO/pwBYM/IDFEiYQA5pM7a7TQC4=
=MxaK
-----END PGP SIGNATURE-----

--VcZjVMblxkg0/8Ur--
