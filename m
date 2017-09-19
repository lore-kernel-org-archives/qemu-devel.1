Received: from eggs.gnu.org ([2001:4830:134:3::10]:51113)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtU-0001Du-Hl
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtS-0002qX-PH
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:44 -0400
Date: Tue, 19 Sep 2017 17:55:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919075506.GR27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-15-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="6eUvXotnMb6+obQB"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-15-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 14/21] ppc/xive: add support for the
 SET_OS_PENDING command
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


--6eUvXotnMb6+obQB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:28PM +0200, C=E9dric Le Goater wrote:
> Adjusting the Interrupt Pending Buffer for the O/S would allow a CPU
> to process event queues of other priorities during one physical
> interrupt cycle. This is not currently used by the XIVE support for
> sPAPR in Linux but it is by the hypervisor.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>
> ---
>  hw/intc/spapr_xive.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index ad3ff91b13ea..ad3f03e37401 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -162,7 +162,14 @@ static bool spapr_xive_tm_is_readonly(uint8_t index)
>  static void spapr_xive_tm_write_special(ICPState *icp, hwaddr offset,
>                                    uint64_t value, unsigned size)
>  {
> -    /* TODO: support TM_SPC_SET_OS_PENDING */
> +    if (offset =3D=3D TM_SPC_SET_OS_PENDING && size =3D=3D 1) {
> +        icp->tima_os[TM_IPB] |=3D priority_to_ipb(value & 0xff);
> +        icp->tima_os[TM_PIPR] =3D ipb_to_pipr(icp->tima_os[TM_IPB]);

This only lets the cpu raise bits in the IPB, never clear them.  Is
that right?  I don't see how you'd implement the handling of multiple
priorities without being able to clear bits here.

> +        spapr_xive_icp_notify(icp);
> +    } else {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid TIMA write @%"
> +                      HWADDR_PRIx" size %d\n", offset, size);
> +    }
> =20
>      /* TODO: support TM_SPC_ACK_OS_EL */
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--6eUvXotnMb6+obQB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAzVoACgkQbDjKyiDZ
s5JyMQ//ZgPXghj7QqndY8xv/axtRwJHv7aXoAIae+zYqYgjaj+0MKmLSngOxTCG
h6JiIF8hQzSBa9IYSUmuqP+C6wilPxRgi3Vw2yySHZLjRkppZ+jI6qXrzXHYZPvC
YV2keqoiylrZdbJeTUn9yD40sjTuAnT/R/boVOSF0XsQXXWc1vcg5wHglFWPbQM/
/yR7bdS5IBQYGAOPDQIX+v677iO5iDG/cMnQFYsroBjYzVgFuMVc0FIEhnJQjF6E
xpD23DURcE/3wMoTfNUSb1Ihqnv3iTx+wNQSQ71WIICYX2bMj2gMR6jOKkJpqw7F
jl85baUpm7GrDomfrQcmjyEMtgS0OqdK7gzKpC2wsS9nfMQTAt52Nbl+CGyPdpoa
k+Lrl2VD5lgwDI+BGSa6IEYOSnxUgnPMvllrzhsDedTaKOoq1u3cvLxRSLHymT0d
ETqlC172d0nVwNNL24H7wyj8hmZmOn2liNivGflpRwltaI6WK1AVrZQd2q0JGaN3
QJLHJUPIQ39JhJohB2IN0bu6/EyuNlC7aUKJ/hfnvs8tZqvTf4Rtq155d1q6AKAa
7/PRy+t/8+f4b0Cv87qvymuMTnnlB5SvZoBV0suZ9Q2e4H36fFG7NfpCBfCjnBnZ
4u6e239BXBtTX224K1/mYYKqPBanQRHcSTqndOWqc2h/3dfugGI=
=dDOI
-----END PGP SIGNATURE-----

--6eUvXotnMb6+obQB--
