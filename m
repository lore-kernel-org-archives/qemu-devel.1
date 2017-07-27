Received: from eggs.gnu.org ([2001:4830:134:3::10]:37284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daa2I-00057x-FT
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 00:04:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daa2E-0006WD-Eh
	for qemu-devel@nongnu.org; Thu, 27 Jul 2017 00:04:30 -0400
Date: Thu, 27 Jul 2017 13:43:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170727034304.GJ8978@umbus.fritz.box>
References: <20170727024224.22900-1-f4bug@amsat.org>
	<20170727024224.22900-19-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="IdGNrZu1oYcejyEu"
Content-Disposition: inline
In-Reply-To: <20170727024224.22900-19-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH for 2.10 v2 19/20] spapr_vio: fix overflow
 of qdevs in spapr_dt_vdevice()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org


--IdGNrZu1oYcejyEu
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 26, 2017 at 11:42:23PM -0300, Philippe Mathieu-Daud=E9 wrote:
> sizeof(ptr) was used instead of sizeof(struct)...
>=20
> also use g_malloc_n() which take care of possible type overflow.
>=20
> hw/ppc/spapr_vio.c:641:22: warning: The code calls sizeof() on a pointer =
type. This can produce an unexpected result
>     qdevs =3D g_malloc(sizeof(qdev) * num);
>                      ^     ~~~~~~
> hw/ppc/spapr_vio.c:648:23: warning: The code calls sizeof() on a pointer =
type. This can produce an unexpected result
>     qsort(qdevs, num, sizeof(qdev), compare_reg);
>                       ^     ~~~~~~
>=20
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Nack.

Have a closer look, what's going in the array really is pointers, not
structures.  This is a false warning from clang, we need to find a
different way to suppress it.

> ---
>  hw/ppc/spapr_vio.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_vio.c b/hw/ppc/spapr_vio.c
> index ea3bc8bd9e..9991b44c9f 100644
> --- a/hw/ppc/spapr_vio.c
> +++ b/hw/ppc/spapr_vio.c
> @@ -638,14 +638,14 @@ void spapr_dt_vdevice(VIOsPAPRBus *bus, void *fdt)
>      }
> =20
>      /* Copy out into an array of pointers */
> -    qdevs =3D g_malloc(sizeof(qdev) * num);
> +    qdevs =3D g_malloc_n(num, sizeof(*qdev));
>      num =3D 0;
>      QTAILQ_FOREACH(kid, &bus->bus.children, sibling) {
>          qdevs[num++] =3D kid->child;
>      }
> =20
>      /* Sort the array */
> -    qsort(qdevs, num, sizeof(qdev), compare_reg);
> +    qsort(qdevs, num, sizeof(*qdev), compare_reg);
> =20
>      /* Hack alert. Give the devices to libfdt in reverse order, we happen
>       * to know that will mean they are in forward order in the tree. */

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--IdGNrZu1oYcejyEu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll5YUUACgkQbDjKyiDZ
s5KdqA/+Me5dX6ibxNQB//oGlcHoOmebpds2r6kFoa4RmZ62BCVknjEOIZlbfdIP
Nhch9u7dSNalGOkaI2FhrooEAxegKif7lHh5y0q7ZvEuhj9HLkuzP7Oz9MAkxTT9
mfvGBembblTO9HU1geCopg5O14JEWvSTPRnrZJtHVo5QfoLcl6WAiEBCUjffg3Y+
pk0HQ4gcHC/H+13BVtr5YxoPHQSDy9c/YMhYMzp+A5ntiXkoWNLrL764RhN7n0Eq
YluCQwAA9xTFXPx9kGgqHsx+sbZ6uAdS7lyzJme1zRNaNfWvxPJDiim7WdfWe/yK
8QiJwD9IFnvbQ5j7Cn/Sy6c1M+a/DrfHixx7X+CPKGcoFpXmMLtnmLTeuPHaiwnu
mXYXFZoNbPSpvEAUV/spzwANyOROEwK2dlEOO2dVM9CqFXtLEK6FZAckzGBfy2Kf
K+4zTUGc/cSB9Z4siBOH1+vMpToPyKW97AIHkYBBwYUHW0t1/6hdRXIp05rsuzvq
qviDnK/TIKY9TChgKKu7+rtv24dimamzLzpPcO7YozLHw2Ejf/w6H7WIDCQj0Da0
KC7BpgpLOynkyh9KrFEbTBGa4wulPE0Ly3ScEObF+vLGR+ReWKuo//A5GWhA1SlV
8FyPWFb635p2W+e0bwmz9/rlzxQGIUpTiUFGD34CwbA76SmO+Lc=
=5mGs
-----END PGP SIGNATURE-----

--IdGNrZu1oYcejyEu--
