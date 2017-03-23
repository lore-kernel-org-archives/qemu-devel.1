Received: from eggs.gnu.org ([2001:4830:134:3::10]:45971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEu-0001rt-Gt
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cquEr-0005o3-6C
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 00:20:44 -0400
Date: Thu, 23 Mar 2017 15:10:10 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170323041010.GF19078@umbus.fritz.box>
References: <1489674912-21942-1-git-send-email-clg@kaod.org>
	<1489674912-21942-3-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ni93GHxFvA+th69W"
Content-Disposition: inline
In-Reply-To: <1489674912-21942-3-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 2/8] spapr: move the IRQ server number
 mapping under the machine
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


--ni93GHxFvA+th69W
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 16, 2017 at 03:35:06PM +0100, C=E9dric Le Goater wrote:
> This is the second step to abstract the IRQ 'server' number of the
> XICS layer. Now that the prereq cleanups have been done in the
> previous patch, we can move down the 'cpu_dt_id' to 'cpu_index'
> mapping in the sPAPR machine handler.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

(excepting the tiny changes that will be necessary for suggested
changes in 1/8)

> ---
>  hw/intc/xics_spapr.c    | 5 ++---
>  hw/ppc/spapr.c          | 3 ++-
>  hw/ppc/spapr_cpu_core.c | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/intc/xics_spapr.c b/hw/intc/xics_spapr.c
> index 178b3adc8af7..9574cae14944 100644
> --- a/hw/intc/xics_spapr.c
> +++ b/hw/intc/xics_spapr.c
> @@ -52,9 +52,8 @@ static target_ulong h_cppr(PowerPCCPU *cpu, sPAPRMachin=
eState *spapr,
>  static target_ulong h_ipi(PowerPCCPU *cpu, sPAPRMachineState *spapr,
>                            target_ulong opcode, target_ulong *args)
>  {
> -    target_ulong server =3D xics_get_cpu_index_by_dt_id(args[0]);
>      target_ulong mfrr =3D args[1];
> -    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), server);
> +    ICPState *icp =3D xics_icp_get(XICS_FABRIC(spapr), args[0]);
> =20
>      if (!icp) {
>          return H_PARAMETER;
> @@ -122,7 +121,7 @@ static void rtas_set_xive(PowerPCCPU *cpu, sPAPRMachi=
neState *spapr,
>      }
> =20
>      nr =3D rtas_ld(args, 0);
> -    server =3D xics_get_cpu_index_by_dt_id(rtas_ld(args, 1));
> +    server =3D rtas_ld(args, 1);
>      priority =3D rtas_ld(args, 2);
> =20
>      if (!ics_valid_irq(ics, nr) || !xics_icp_get(XICS_FABRIC(spapr), ser=
ver)
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 6ee566d658f8..396490bc5dfc 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3024,9 +3024,10 @@ static void spapr_ics_resend(XICSFabric *dev)
>      ics_resend(spapr->ics);
>  }
> =20
> -static ICPState *spapr_icp_get(XICSFabric *xi, int server)
> +static ICPState *spapr_icp_get(XICSFabric *xi, int cpu_dt_id)
>  {
>      sPAPRMachineState *spapr =3D SPAPR_MACHINE(xi);
> +    int server =3D xics_get_cpu_index_by_dt_id(cpu_dt_id);
> =20
>      return (server < spapr->nr_servers) ? &spapr->icps[server] : NULL;
>  }
> diff --git a/hw/ppc/spapr_cpu_core.c b/hw/ppc/spapr_cpu_core.c
> index 59f1cba6fba5..1d5e7fbeeb1f 100644
> --- a/hw/ppc/spapr_cpu_core.c
> +++ b/hw/ppc/spapr_cpu_core.c
> @@ -81,7 +81,7 @@ static void spapr_cpu_init(sPAPRMachineState *spapr, Po=
werPCCPU *cpu,
>          }
>      }
> =20
> -    cpu->icp =3D xics_icp_get(xi, CPU(cpu)->cpu_index);
> +    cpu->icp =3D xics_icp_get(xi, cpu->cpu_dt_id);
>      xics_cpu_setup(xi, cpu);
> =20
>      qemu_register_reset(spapr_cpu_reset, cpu);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ni93GHxFvA+th69W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY00qgAAoJEGw4ysog2bOS98IQAKb+2UTZdL219D8X2QrR8E/2
AyYjuLrgAczq62SMPGyJlBasd2SYyujHCNpx68JaNX1Suo4mNXeAnL7oppWd5D1G
R5c9zOmV7mkqL3bQaZpEoLmRtM4afe9ASjVW0L5cUYtmmzr0cPMt9AdgLix4iz/s
dOFyyDQasfa4I8DobG40glGPGWBpP9i0MkvuqfbrZBPCkTP/18yM4jypzom0px7U
Oo2ixVdGwVwSi1VLFllFyH8+vILsbSRFs9STVJqVywfMZTCTJOi9SAYKyqcCdSUF
MGI4whCAy12Lizs9+sKGRVqUYZN8vH4vNXGMG9VyJ2h/jcvW1cd5lCh3+QXUzMkF
10AQ1BAYnsDQMwMBaehcot4klVf2k7GRWwOy6Ncvd0Zy5jyKNGhK/paZhGzkwMp6
3syPxEI7WZmm2kCu7xHxyUrMid3MlfNBACGZqI0oTgjh1YtXAn+Z/tQQWKlBFqw4
inzm6dUntFSR2zFzXMAwFOy5uXbrQr+K+CqxLewahGdwHVlsSSwI5e6Rmx0OPpMm
sUua9xIgmbFEoixzL57S2TJYBIdjJgiPTT12xq+CnB1AcSp24AbjuS0jbvn+IYfR
wH/oQl405I3WVyTKbSuNN7q20ereoedrP+JKq9kXIOUKY68bnF2n21C/9hFE0aOg
KYN1MFG8yaEONiyR2wzL
=IT87
-----END PGP SIGNATURE-----

--ni93GHxFvA+th69W--
