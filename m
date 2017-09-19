Received: from eggs.gnu.org ([2001:4830:134:3::10]:51132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtV-0001EM-2n
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1duFtS-0002rG-Vw
	for qemu-devel@nongnu.org; Tue, 19 Sep 2017 06:36:45 -0400
Date: Tue, 19 Sep 2017 12:45:44 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170919024544.GK27153@umbus>
References: <20170911171235.29331-1-clg@kaod.org>
	<20170911171235.29331-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="n83H03bbH672hrlY"
Content-Disposition: inline
In-Reply-To: <20170911171235.29331-6-clg@kaod.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 05/21] ppc/xive: allocate IRQ
 numbers for the IPIs
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


--n83H03bbH672hrlY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 11, 2017 at 07:12:19PM +0200, C=E9dric Le Goater wrote:
> The number of IPIs is deduced from the max number of CPUs the guest
> supports and the IRQ numbers for the IPIs are allocated from the top
> of the IRQ number space to reduce conflict with other IRQ numbers
> allocated by the devices.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

This is more ick associated with implementing XIVE in terms of XICS.
We shouldn't need to "allocate" IRQs for the IPIs - they should just
be a fixed set.  And we certainly shouldn't need to set the XICS irq
type for XIVE irqs.

> ---
>  hw/intc/spapr_xive.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index 1681affb0848..52c32f588d6d 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -58,6 +58,7 @@ static void spapr_xive_realize(DeviceState *dev, Error =
**errp)
>      sPAPRXive *xive =3D SPAPR_XIVE(dev);
>      Object *obj;
>      Error *err =3D NULL;
> +    int i;
> =20
>      if (!xive->nr_targets) {
>          error_setg(errp, "Number of interrupt targets needs to be greate=
r 0");
> @@ -80,6 +81,11 @@ static void spapr_xive_realize(DeviceState *dev, Error=
 **errp)
> =20
>      xive->ics =3D ICS_BASE(obj);
> =20
> +    /* Allocate the last IRQ numbers for the IPIs */
> +    for (i =3D xive->nr_irqs - xive->nr_targets; i < xive->nr_irqs; i++)=
 {
> +        ics_set_irq_type(xive->ics, i, false);
> +    }
> +
>      /* Allocate SBEs (State Bit Entry). 2 bits, so 4 entries per byte */
>      xive->sbe_size =3D DIV_ROUND_UP(xive->nr_irqs, 4);
>      xive->sbe =3D g_malloc0(xive->sbe_size);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--n83H03bbH672hrlY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnAhNgACgkQbDjKyiDZ
s5Iv8RAA0AKAChb1zGFSqbo8f/hoEwBv3T7TtewumbA1MTuBUQy3g7J0As6bGNtJ
g0adWUacmicb63V1sPiHd9ado/mixZb0sZsb6oLFyhuSTFhKqaDNK+JVl+QKFmyA
/iyJAnBj3V9lyLy0h2PE049rdKHYv2wUwxti0dVsUUGSGXfTyLpfuTKD+16bEUNo
TYWHDNYoZK/QUhk3tyryH2bdW8X9FE/dRpb3fUo1iMoUf+jWzsRWLI3nriEjl2Cu
SUJSdfV4U5n+fB8zUdfQVk11TsQ+hofJ78JhWV7hMqoMOOuYpswsd8+ukCfrHnUk
UgfgpSyhmLh2PEL8X7Y57CecKnaa5Ilts0A8Nn0hNSdOqcftdqygH1OFQ76ZIbmE
imWJN2WaCkeTgaFh9ZjqOvk/3F8kmgmb+ylm59srcHLlJ8BD5hY8mkgfu79wgUQp
fT0b8XMcWsMBRPt4yToi62CgV5MvTJRmVgskq+R5vZFRExtH/S8H7Is49BzPg8xg
9u8nblayaCwi0+Y05ZAlR4r+vOh/0LaycfPvSzjdIfg7U1sBaNFHaETHtE0EGohj
mSE9Q78cpVjPCnFcZzYKapPLUZGBg3Uo3BVglrXnV9b0Q0cU1eY3OlFhtMsRTCFr
Sq8RF7BKMD/gWAGXhrWNHN8omuMUIq54kUxIgMjnbWofFogf/OA=
=Yxls
-----END PGP SIGNATURE-----

--n83H03bbH672hrlY--
