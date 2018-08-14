Received: from eggs.gnu.org ([2001:4830:134:3::10]:33540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fpOFg-0005Ov-Pw
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:36:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fpOFd-0001X7-HN
	for qemu-devel@nongnu.org; Mon, 13 Aug 2018 21:36:04 -0400
Date: Tue, 14 Aug 2018 11:11:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180814011109.GC27378@umbus>
References: <20180813163859.17964-1-cota@braap.org>
	<20180813163859.17964-3-cota@braap.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+xNpyl7Qekk2NvDX"
Content-Disposition: inline
In-Reply-To: <20180813163859.17964-3-cota@braap.org>
Subject: Re: [Qemu-devel] [PATCH 2/3] spapr: do not use CPU_FOREACH_REVERSE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org


--+xNpyl7Qekk2NvDX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 13, 2018 at 12:38:58PM -0400, Emilio G. Cota wrote:
> This paves the way for implementing the CPU list with an RCU QLIST,
> which cannot be traversed in reverse order.
>=20
> Note that this is the only caller of CPU_FOREACH_REVERSE.
>=20
> Signed-off-by: Emilio G. Cota <cota@braap.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 421b2dd09b..2ef5be2790 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -622,9 +622,12 @@ static void spapr_populate_cpu_dt(CPUState *cs, void=
 *fdt, int offset,
> =20
>  static void spapr_populate_cpus_dt_node(void *fdt, sPAPRMachineState *sp=
apr)
>  {
> +    CPUState **rev;
>      CPUState *cs;
> +    int n_cpus;
>      int cpus_offset;
>      char *nodename;
> +    int i;
> =20
>      cpus_offset =3D fdt_add_subnode(fdt, 0, "cpus");
>      _FDT(cpus_offset);
> @@ -635,8 +638,19 @@ static void spapr_populate_cpus_dt_node(void *fdt, s=
PAPRMachineState *spapr)
>       * We walk the CPUs in reverse order to ensure that CPU DT nodes
>       * created by fdt_add_subnode() end up in the right order in FDT
>       * for the guest kernel the enumerate the CPUs correctly.
> +     *
> +     * The CPU list cannot be traversed in reverse order, so we need
> +     * to do extra work.
>       */
> -    CPU_FOREACH_REVERSE(cs) {
> +    n_cpus =3D 0;
> +    rev =3D NULL;
> +    CPU_FOREACH(cs) {
> +        rev =3D g_renew(CPUState *, rev, n_cpus + 1);
> +        rev[n_cpus++] =3D cs;
> +    }
> +
> +    for (i =3D n_cpus - 1; i >=3D 0; i--) {
> +        CPUState *cs =3D rev[i];
>          PowerPCCPU *cpu =3D POWERPC_CPU(cs);
>          int index =3D spapr_get_vcpu_id(cpu);
>          DeviceClass *dc =3D DEVICE_GET_CLASS(cs);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+xNpyl7Qekk2NvDX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltyLCoACgkQbDjKyiDZ
s5LdYA//ZiU52FdRBCouILb+fwBxQEuruiPaasN59KsdZsNq6lpSf/VgGEPKKjQe
Ki4WSk+gUAtgDzd3IRhGJcJYEQyq69qc/5pdKQiuBIkE1D6bvENiIWe0zNOAKVBp
VBPWaxYqdJ8wAS9b+4bDDp76+VRxZkwytQe4kteNlRygl0Mj7dlPGfYNpjBDeh2y
ZjUKxdzotSVpsTa4C5rM9h1IK+ODk/uJthQOrkPQcOyCXF5oTkw2lvhGKYfIubFY
8APswXVMV6LQvRHxPXWwliG9JUaEOI0BDIlP6RrMua6dmfhLnACzh4SQ+YKfhosS
rX9RkhIcTg4jt0X0dB5emenr/DOVkETyjWmYWRFggfWExadzOpyIXXPBZrMJO+DZ
0rLAfQ7qnMQatfHaez3oRUMjj5JlzDx8cqOiGIUsVC9D2nMPxhoURKHRFieS01YQ
OyGRrqHb4gpIUfzFXG+vY3q9zok9jMCIVPEi83/0uargzSizlbkw3EOuAtV60UrV
E1R9gmJlWP9Tn1dca9OcuMmUzIn36bHUF/4yVcsU0LQk80W/5NrEzXD/TyzmbWV9
GFA/RFk8S2+54Yg3ejfn3YHWLfWRU4q1rTP6bCcL3qRqVd/GmL5Vec6z6G019rtJ
ya4X8K+qFqlly4vpqo3ZiIAmFIAYh2lpacEYjslvkbwXN0qhxhw=
=85BU
-----END PGP SIGNATURE-----

--+xNpyl7Qekk2NvDX--
