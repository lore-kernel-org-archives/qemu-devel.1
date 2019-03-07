Received: from eggs.gnu.org ([209.51.188.92]:53764)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1jaw-0008Hh-UX
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:21:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h1jav-0006yq-1k
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 22:21:18 -0500
Date: Thu, 7 Mar 2019 12:36:18 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190307013618.GE25123@umbus.fritz.box>
References: <20190306085032.15744-1-clg@kaod.org>
	<20190306085032.15744-6-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KuLpqunXa7jZSBt+"
Content-Disposition: inline
In-Reply-To: <20190306085032.15744-6-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 05/27] ppc/pnv: change the CPU machine_data
 presenter type to Object *
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--KuLpqunXa7jZSBt+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 06, 2019 at 09:50:10AM +0100, C=E9dric Le Goater wrote:
> The POWER9 PowerNV machine will use a XIVE interrupt presenter type.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied patches 2..5.

> ---
>  include/hw/ppc/pnv_core.h | 2 +-
>  hw/ppc/pnv.c              | 6 +++---
>  hw/ppc/pnv_core.c         | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_core.h b/include/hw/ppc/pnv_core.h
> index 9961ea3a92cd..6874bb847a01 100644
> --- a/include/hw/ppc/pnv_core.h
> +++ b/include/hw/ppc/pnv_core.h
> @@ -48,7 +48,7 @@ typedef struct PnvCoreClass {
>  #define PNV_CORE_TYPE_NAME(cpu_model) cpu_model PNV_CORE_TYPE_SUFFIX
> =20
>  typedef struct PnvCPUState {
> -    struct ICPState *icp;
> +    Object *intc;
>  } PnvCPUState;
> =20
>  static inline PnvCPUState *pnv_cpu_state(PowerPCCPU *cpu)
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 9aa81c7f09c2..b90d03711a05 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -684,7 +684,7 @@ static void pnv_chip_power8_intc_create(PnvChip *chip=
, PowerPCCPU *cpu,
>          return;
>      }
> =20
> -    pnv_cpu->icp =3D ICP(obj);
> +    pnv_cpu->intc =3D obj;
>  }
> =20
>  /*
> @@ -1086,7 +1086,7 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int pi=
r)
>  {
>      PowerPCCPU *cpu =3D ppc_get_vcpu_by_pir(pir);
> =20
> -    return cpu ? pnv_cpu_state(cpu)->icp : NULL;
> +    return cpu ? ICP(pnv_cpu_state(cpu)->intc) : NULL;
>  }
> =20
>  static void pnv_pic_print_info(InterruptStatsProvider *obj,
> @@ -1099,7 +1099,7 @@ static void pnv_pic_print_info(InterruptStatsProvid=
er *obj,
>      CPU_FOREACH(cs) {
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> =20
> -        icp_pic_print_info(pnv_cpu_state(cpu)->icp, mon);
> +        icp_pic_print_info(ICP(pnv_cpu_state(cpu)->intc), mon);
>      }
> =20
>      for (i =3D 0; i < pnv->num_chips; i++) {
> diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
> index 7c806da720c6..38179cdc53dc 100644
> --- a/hw/ppc/pnv_core.c
> +++ b/hw/ppc/pnv_core.c
> @@ -198,7 +198,7 @@ static void pnv_unrealize_vcpu(PowerPCCPU *cpu)
>      PnvCPUState *pnv_cpu =3D pnv_cpu_state(cpu);
> =20
>      qemu_unregister_reset(pnv_cpu_reset, cpu);
> -    object_unparent(OBJECT(pnv_cpu_state(cpu)->icp));
> +    object_unparent(OBJECT(pnv_cpu_state(cpu)->intc));
>      cpu_remove_sync(CPU(cpu));
>      cpu->machine_data =3D NULL;
>      g_free(pnv_cpu);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KuLpqunXa7jZSBt+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyAdY8ACgkQbDjKyiDZ
s5IE1A/+LQc05M5ckae2K5BPY9WLDOXKsyHTg7dDtAWJ6oIlAYRZVBi+GFqNaH6w
R6JUlZDY++EqWFzBAHwuikugiAz7qhImQLjZhfpxJIdLKcQJYWYovSz3vZI6SreL
EdIYtWse4blcMqH7TljSBzUZmgNJDeceCdb+rLX3OCN5U0Gp6WNIcdoAC7dMY+vk
Xuc5Am8che6qhnyTnrBkUa/f/aMmG2eOMQ77DzfBkEqKpTNn9VCKQbuktCZvbR+P
Muy02tFZgrwr4ocKTveioJXriSBgLEr0xLyay+ND89JtqIW01Dq2FQYVr9z/ByKb
OUNIa1/7H12okgGVtsBzBpy+TEfuw3jXXcCkQpqVd4GNWz+9rgEyluQsp0eRcZ/U
MzsUwHRFtjgM5xGURnfJtbbG2cBmHScjwy6yvnIBA4rYUpbM6MIC2fxjcplNh8ub
hGw1sc4lmpDa3MZoFk1p7U2RE1gnwpk5ONVgWGlihR192ud3eCvDgcnO/uObHGEP
YpQYlGdkOs1M9zB3cyqv+goeI0QD8f6evJ/MrbzLShS+GRxpLcvvjav08VtxiwnX
m3hLE3bVTyFCPQ1AiOPLR+K+zQizBzAYUKi29vHO7lA33OgjajtWEMzNDS1JXF8S
ttSeoGvxwGKu+hV/+wB0cDnq02B4llwE4B4Pg61DO7/rGDPxrTo=
=5kzQ
-----END PGP SIGNATURE-----

--KuLpqunXa7jZSBt+--
