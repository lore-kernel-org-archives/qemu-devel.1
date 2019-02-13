Received: from eggs.gnu.org ([209.51.188.92]:45575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtn6V-0008KD-PB
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:29:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gtmwX-0005Nb-Ed
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:18:49 -0500
Date: Wed, 13 Feb 2019 16:10:15 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190213051014.GP1884@umbus.fritz.box>
References: <20190128094625.4428-1-clg@kaod.org>
	<20190128094625.4428-15-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Ian02MSQ7xDzAZO2"
Content-Disposition: inline
In-Reply-To: <20190128094625.4428-15-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH 14/19] target/ppc: Add POWER9 exception
 model
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


--Ian02MSQ7xDzAZO2
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 28, 2019 at 10:46:20AM +0100, C=E9dric Le Goater wrote:
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>=20
> And use it to get the correct HILE bit in HID0
>=20
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/cpu-qom.h            |  2 ++
>  target/ppc/excp_helper.c        | 17 +++++++++++++----
>  target/ppc/translate.c          |  3 ++-
>  target/ppc/translate_init.inc.c |  2 +-
>  4 files changed, 18 insertions(+), 6 deletions(-)
>=20
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 7c54093a7122..7ff8b2d68632 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -113,6 +113,8 @@ enum powerpc_excp_t {
>      POWERPC_EXCP_POWER7,
>      /* POWER8 exception model           */
>      POWERPC_EXCP_POWER8,
> +    /* POWER9 exception model           */
> +    POWERPC_EXCP_POWER9,
>  };
> =20
>  /***********************************************************************=
******/
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 7536620a4133..37546bb0f0fe 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -147,7 +147,7 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int =
excp_model, int excp)
> =20
>      /* Exception targetting modifiers
>       *
> -     * LPES0 is supported on POWER7/8
> +     * LPES0 is supported on POWER7/8/9
>       * LPES1 is not supported (old iSeries mode)
>       *
>       * On anything else, we behave as if LPES0 is 1
> @@ -158,9 +158,10 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>       */
>  #if defined(TARGET_PPC64)
>      if (excp_model =3D=3D POWERPC_EXCP_POWER7 ||
> -        excp_model =3D=3D POWERPC_EXCP_POWER8) {
> +        excp_model =3D=3D POWERPC_EXCP_POWER8 ||
> +        excp_model =3D=3D POWERPC_EXCP_POWER9) {
>          lpes0 =3D !!(env->spr[SPR_LPCR] & LPCR_LPES0);
> -        if (excp_model =3D=3D POWERPC_EXCP_POWER8) {
> +        if (excp_model !=3D POWERPC_EXCP_POWER7) {
>              ail =3D (env->spr[SPR_LPCR] & LPCR_AIL) >> LPCR_AIL_SHIFT;
>          } else {
>              ail =3D 0;
> @@ -662,7 +663,15 @@ static inline void powerpc_excp(PowerPCCPU *cpu, int=
 excp_model, int excp)
>          }
>      } else if (excp_model =3D=3D POWERPC_EXCP_POWER8) {
>          if (new_msr & MSR_HVB) {
> -            if (env->spr[SPR_HID0] & (HID0_HILE | HID0_POWER9_HILE)) {
> +            if (env->spr[SPR_HID0] & HID0_HILE) {
> +                new_msr |=3D (target_ulong)1 << MSR_LE;
> +            }
> +        } else if (env->spr[SPR_LPCR] & LPCR_ILE) {
> +            new_msr |=3D (target_ulong)1 << MSR_LE;
> +        }
> +    } else if (excp_model =3D=3D POWERPC_EXCP_POWER9) {
> +        if (new_msr & MSR_HVB) {
> +            if (env->spr[SPR_HID0] & HID0_POWER9_HILE) {
>                  new_msr |=3D (target_ulong)1 << MSR_LE;
>              }
>          } else if (env->spr[SPR_LPCR] & LPCR_ILE) {
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 07bedbb8f1ce..62a9a57e4a65 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -7483,7 +7483,8 @@ void ppc_cpu_dump_state(CPUState *cs, FILE *f, fpri=
ntf_function cpu_fprintf,
> =20
>  #if defined(TARGET_PPC64)
>      if (env->excp_model =3D=3D POWERPC_EXCP_POWER7 ||
> -        env->excp_model =3D=3D POWERPC_EXCP_POWER8) {
> +        env->excp_model =3D=3D POWERPC_EXCP_POWER8 ||
> +        env->excp_model =3D=3D POWERPC_EXCP_POWER9)  {
>          cpu_fprintf(f, "HSRR0 " TARGET_FMT_lx " HSRR1 " TARGET_FMT_lx "\=
n",
>                      env->spr[SPR_HSRR0], env->spr[SPR_HSRR1]);
>      }
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index f235162a1f6b..c1719c46a383 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8905,7 +8905,7 @@ POWERPC_FAMILY(POWER9)(ObjectClass *oc, void *data)
>      pcc->hash64_opts =3D &ppc_hash64_opts_POWER7;
>      pcc->radix_page_info =3D &POWER9_radix_page_info;
>  #endif
> -    pcc->excp_model =3D POWERPC_EXCP_POWER8;
> +    pcc->excp_model =3D POWERPC_EXCP_POWER9;
>      pcc->bus_model =3D PPC_FLAGS_INPUT_POWER7;
>      pcc->bfd_mach =3D bfd_mach_ppc64;
>      pcc->flags =3D POWERPC_FLAG_VRE | POWERPC_FLAG_SE |

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--Ian02MSQ7xDzAZO2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxjprYACgkQbDjKyiDZ
s5KcJBAAjrGIwudY6gzG5NseHI1Lou7cakq4LF6cJsHczSICTnNqJ0UFk1eKj/Ku
NMDL0rxn0kmQw0UQCtGd2t1JnDBv/sSmbxmUGFmWmd7vU4nmFx6bLzGgvbSbv37W
qpW5a0tylbaNYzhYwf10ZmBONHrGJg6XDCTQZcCKCFgOqPyOueuHFDF4y1EtrIcO
qsRulTgOUDADlEt0gBg4MBv3pOly4cU9EQdGkuFYRfN+YdVXMRihKTp/bLWG+uZ3
+crVWABhjlSGL3XwS6aGUqIEy7ItAVuCak7K2BcPcgeYXPe4n/R556HSvncuL+Mq
PXQenekZt4wcRs+OMw0nl2BRJ5pVguayjpIs2f2i1vKlS1SvqayMh1N4mWCHMYDH
AaPi+tDh6B5Hr3+qggp4Bz94bFpzHRNcGOpq+hnKlq29w/r6aiiZcUTz5lRXWaL9
ccLy3iNa2fyjT2uSi9jnThNgrKLvqbyabXfOy+BsnIwFe0GexZ3eYrPkbZ8MOtSr
JD2ZYRu/lWPLGnHbn5XrS5CTE0ag/VOHNbpBP71KZ8K2Mo8TRKOtmI/twEBhbUzX
/bzNTW3bC/62iqeYsMdY0eEJYldU47QLqolXkr4oOxVVZPPTuET+8o2mL24cXRMu
T278Jdesfg2ZcNd1t4QFIJmYxMWnbFVztQyWvo4sOy7w34TaFEo=
=T1J3
-----END PGP SIGNATURE-----

--Ian02MSQ7xDzAZO2--
