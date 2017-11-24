Received: from eggs.gnu.org ([2001:4830:134:3::10]:40102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI4QE-0004vv-H5
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 22:12:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eI4QD-0005lv-AO
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 22:12:58 -0500
Date: Fri, 24 Nov 2017 13:57:51 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171124025751.GB28000@umbus.fritz.box>
References: <20171123132955.1261-1-clg@kaod.org>
	<20171123132955.1261-3-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="VrqPEDrXMn8OVzN4"
Content-Disposition: inline
In-Reply-To: <20171123132955.1261-3-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 02/25] ppc/xics: assign of the CPU 'intc'
 pointer under the core
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


--VrqPEDrXMn8OVzN4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 23, 2017 at 02:29:32PM +0100, C=E9dric Le Goater wrote:
> The 'intc' pointer of the CPU references the interrupt presenter in
> the XICS interrupt mode. When the XIVE interrupt mode is available and
> activated, the machine will need to reassign this pointer to reflect
> the change.
>=20
> Moving this assignment under the realize routine of the CPU will ease
> the process when the interrupt mode is toggled.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/xics.c          | 1 -
>  hw/ppc/pnv_core.c       | 2 +-
>  hw/ppc/spapr_cpu_core.c | 2 +-
>  3 files changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index e4ccdff8f577..0f2e7273bc8f 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -334,7 +334,6 @@ static void icp_realize(DeviceState *dev, Error **err=
p)
>      }
> =20
>      cpu =3D POWERPC_CPU(obj);
> -    cpu->intc =3D OBJECT(icp);
>      icp->cs =3D CPU(obj);
> =20
>      env =3D &cpu->env;
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index a066736846f8..90acaac45889 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -133,7 +133,7 @@ static void pnv_core_realize_child(Object *child, XIC=
SFabric *xi, Error **errp)
>          return;
>      }
> =20
> -    icp_create(cs, TYPE_PNV_ICP, xi, &local_err);
> +    cpu->intc =3D icp_create(cs, TYPE_PNV_ICP, xi, &local_err);
>      if (local_err) {
>          error_propagate(errp, local_err);
>          return;
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index f8a520a2fa2d..f7cc74512481 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -122,7 +122,7 @@ static void spapr_cpu_core_realize_child(Object *chil=
d,
>          goto error;
>      }
> =20
> -    icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &local_err);
> +    cpu->intc =3D icp_create(cs, spapr->icp_type, XICS_FABRIC(spapr), &l=
ocal_err);
>      if (local_err) {
>          goto error;
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--VrqPEDrXMn8OVzN4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloXiq8ACgkQbDjKyiDZ
s5JeIA//YlFnzaIMuVvbVU/O6RNGYNFmjI3walRdi2xqQA1reAKfODESpT5GqJT+
eCAyL4G/cjnfYf2aH3w0kcNo/Lplo5P8FLaFoMhkJgoBjMtk0fzcwpsHNs2zkRZT
CZngIwtPhEwXMta297xk88uI58wHlyotfXQVtqzOlzlImaBOvJ+QwuZXi2DZ9w38
3utvRF3BZlXzRZn2sRWteaRBupvBw2lCD6nnZ7mFbV2h7cNKO721GK7zTDXN+5XG
4n0b4LPK2FB9Lyjt0BDZfmee5HyxzKyd7CTnAHIyoh7UAYCTcVkGxOr1Oe9GDUU+
kLxla0+1K50ngrPxV5+aR8msRODIneoLy1SoRg9tdAC6Rqzq+6hNF51jFDfHFcjF
dQSzvEQ1rzdGWwD8TNnwJCD0YU+9mbcyqs6j9IyL+IDtSSiDG3K7AtPv+AC434W4
ynhO4SdJgdF78MXa5okvQdjfIw2abTMKBqvVCyFyEwfQBwunteINY9NLFKNvtueH
vkCmCPiiIzoVVgyqGXrk2h23DJ0kbiuRGR6/za8FNklSw9ako6hXYjiBoz0V/L5v
ynHYbK7jKRWQGu87E4ucOBDlfKb/4qLdOZpBZZFyZyU4t2qdkEuqMOxPEgo5EdjS
8kZKC6ujoygZHnFKWB9mMcGstrPDfy6rdaV/heF3yHAiorKc3X8=
=Ks9l
-----END PGP SIGNATURE-----

--VrqPEDrXMn8OVzN4--
