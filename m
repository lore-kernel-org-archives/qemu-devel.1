Received: from eggs.gnu.org ([2001:4830:134:3::10]:35436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqrWR-0000Iv-20
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 21:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dqrWQ-0002O9-0e
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 21:58:55 -0400
Date: Sun, 10 Sep 2017 11:58:14 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170910015814.GW2735@umbus.fritz.box>
References: <150456160452.17000.3290192176290246589.stgit@bahia.lan>
	<150456161545.17000.9223127644314285105.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eLx2Oic5rP1+EtIt"
Content-Disposition: inline
In-Reply-To: <150456161545.17000.9223127644314285105.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 1/4] spapr: only update SDR1 once per-cpu
 during CAS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>, Thomas Huth <thuth@redhat.com>


--eLx2Oic5rP1+EtIt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 04, 2017 at 11:46:55PM +0200, Greg Kurz wrote:
> Commit b55d295e3ec9 added the possibility to support HPT resizing with KV=
M.
> In the case of PR, we need to pass the userspace address of the HPT to KVM
> using the SDR1 slot.
> This is handled by kvmppc_update_sdr1() which uses CPU_FOREACH() to update
> all CPUs. It is hence not needed to call kvmppc_update_sdr1() for each CP=
U.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.

> ---
>  hw/ppc/spapr_hcall.c |   14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> index 8b3c0e17e75c..6ab8c188f381 100644
> --- a/hw/ppc/spapr_hcall.c
> +++ b/hw/ppc/spapr_hcall.c
> @@ -1559,20 +1559,16 @@ static target_ulong h_client_architecture_support=
(PowerPCCPU *cpu,
>          }
> =20
>          if (spapr->htab_shift < maxshift) {
> -            CPUState *cs;
> -
>              /* Guest doesn't know about HPT resizing, so we
>               * pre-emptively resize for the maximum permitted RAM.  At
>               * the point this is called, nothing should have been
>               * entered into the existing HPT */
>              spapr_reallocate_hpt(spapr, maxshift, &error_fatal);
> -            CPU_FOREACH(cs) {
> -                if (kvm_enabled()) {
> -                    /* For KVM PR, update the HPT pointer */
> -                    target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr=
->htab
> -                        | (spapr->htab_shift - 18);
> -                    kvmppc_update_sdr1(sdr1);
> -                }
> +            if (kvm_enabled()) {
> +                /* For KVM PR, update the HPT pointer */
> +                target_ulong sdr1 =3D (target_ulong)(uintptr_t)spapr->ht=
ab
> +                    | (spapr->htab_shift - 18);
> +                kvmppc_update_sdr1(sdr1);
>              }
>          }
>      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eLx2Oic5rP1+EtIt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm0nDIACgkQbDjKyiDZ
s5I1fxAAj/71qyd559Efimik9N/f1NKc1Soi+bBAnHzAthj+6c0CfJ2rt807iJ2/
XiJfv+b4KSaMAJWKbe19a7jCxAGxmoY8WGm9G7hXoln0X0wDslWKhkzj3SCF9z/V
0xI2Q+z7vy46Iu1X4G4cPf2GAfipB7NikiSKkGjr6PJQp8CGNq2vsfeX0u62+9SY
FUInZ0ORihLladDLwEsPlLatY/yM4ehySQKI0sHr22Lw5TuVNKApHYrRRS0NOfJc
g7El69N8qDdReSdTxE5yYQYN8AxfwL57M03HWUHY9Nz5VZr0TesXEwazDeGGBghl
ctzDAfrcKm8+6JaVG74FUCDbCIDOmyzrrg3OldJ3N0Nr/WPqKm4EYsCHBfmAUIu9
sl1jP6YeJE88Gs6fI200dmiXNWy5tepPbHqzyN44f112qBRsFvqm2QHJsHAjHOL0
YTObIuS2QH/eryaQycv1AmYcmBQXQ8Eaq/+/mbo95cVsW270wBtFxN61gLIzeZwA
mm1WnP8juT1cksTDUEZ8NTLIHQtD1gQ7shls0d5xO6PYnyXPQWPOHLVZOvDaQClj
U+7GEl/O3ZnHksKiKQGRR2CsNR1dYJ6eD/z0QJJXUooNilV+gDE3MbLKmOY+CU5c
e9cn0Fzahk85nfqk3lFfeNZrizncTerM8O5USjFC4B8jCNOttC0=
=o82K
-----END PGP SIGNATURE-----

--eLx2Oic5rP1+EtIt--
