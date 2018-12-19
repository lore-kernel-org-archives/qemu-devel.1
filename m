Received: from eggs.gnu.org ([2001:4830:134:3::10]:42231)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWcG-0002UB-K2
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:50:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWcE-0006K2-Ss
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:50:04 -0500
Date: Wed, 19 Dec 2018 17:41:35 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219064135.GB30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-33-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vWfgMjdKllQeoPX8"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-33-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 32/34] target/ppc: Split out VSCR_SAT to a
 vector field
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-ppc@nongnu.org


--vWfgMjdKllQeoPX8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:39:09PM -0800, Richard Henderson wrote:
> Change the representation of VSCR_SAT such that it is easy
> to set from vector code.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/cpu.h        |  4 +++-
>  target/ppc/int_helper.c | 11 ++++++++---
>  2 files changed, 11 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index a2fe6058b1..26d2e16720 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1063,10 +1063,12 @@ struct CPUPPCState {
>      /* Special purpose registers */
>      target_ulong spr[1024];
>      ppc_spr_t spr_cb[1024];
> -    /* Vector status and control register */
> +    /* Vector status and control register, minus VSCR_SAT.  */
>      uint32_t vscr;
>      /* VSX registers (including FP and AVR) */
>      ppc_vsr_t vsr[64] QEMU_ALIGNED(16);
> +    /* Non-zero if and only if VSCR_SAT should be set.  */
> +    ppc_vsr_t vscr_sat;
>      /* SPE registers */
>      uint64_t spe_acc;
>      uint32_t spe_fscr;
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 38aa3e85a6..9dbcbcd87a 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -471,18 +471,23 @@ void helper_lvsr(ppc_avr_t *r, target_ulong sh)
> =20
>  void helper_mtvscr(CPUPPCState *env, uint32_t vscr)
>  {
> -    env->vscr =3D vscr;
> +    env->vscr =3D vscr & ~(1u << VSCR_SAT);
> +    /* Which bit we set is completely arbitrary, but clear the rest.  */
> +    env->vscr_sat.u64[0] =3D vscr & (1u << VSCR_SAT);
> +    env->vscr_sat.u64[1] =3D 0;
>      set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
>  }
> =20
>  uint32_t helper_mfvscr(CPUPPCState *env)
>  {
> -    return env->vscr;
> +    uint32_t sat =3D (env->vscr_sat.u64[0] | env->vscr_sat.u64[1]) !=3D =
0;
> +    return env->vscr | (sat << VSCR_SAT);
>  }
> =20
>  static inline void set_vscr_sat(CPUPPCState *env)
>  {
> -    env->vscr |=3D 1 << VSCR_SAT;
> +    /* The choice of non-zero value is arbitrary.  */
> +    env->vscr_sat.u32[0] =3D 1;
>  }
> =20
>  void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vWfgMjdKllQeoPX8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ6B4ACgkQbDjKyiDZ
s5Ji8RAAvBkNoOd6wotK3yIK+akegGpnTvNaRK6yJ1D50pyfVkZLFnkgNvztRdil
5RugDcYKEi9AKGqMwtHohSSIadr72iACecyXIRdMTP1S+uVAdSCNsnKvkukheVeo
SJP8SMbHDnay0oR8CU+aolYrlrc86ju2A5hvIZ7S9ouLUj4f0qw/NQc2scVcQjNR
zPkwD3ZTlOohDc9cfwoxaATmaFv88KicPP9wPuxMl5mXFX7t5fG3HeseVXM/Paff
63lBaR3KJvdU8pO8SvA0cXF/t0DotcDOsGFsG4H5cb+PLeV54y2j68vBhAlhc+XS
IgYZ0kf2eSWLM5O39Ax6satfaeiyymvH7akn3YTK2RRvjYT958AdrUlhYTAsp4Pt
byDJJ8v6hNt/7r/b0DiE0O/w2nXFCmMQF2MlwI3RlkhfBq9QEcM7GUjCukQl/rWw
tlIdrSWmH3lo6rsk/g73zqG/lyMiHd5P/x5YTd/R4NdULOSF8q8c0VEtFjaqwEqg
PR2CSJZTRWf78NU3fYaILIUlxQQvx1Ak8VB8LA86Wu9FI/O89GVkZKlGpDr7lZN6
+HN2m6UHa/esY3+CN/cRg22pWW244CeNdApJTVKlLq5f2SUlFtRuAzcIRfePEbRR
M0unvC+pKWOUZfl/lGNkU7i5bVNxpeZSZjXbW+HVs10CSNQb+no=
=lOFR
-----END PGP SIGNATURE-----

--vWfgMjdKllQeoPX8--
