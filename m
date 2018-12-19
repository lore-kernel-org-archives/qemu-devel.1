Received: from eggs.gnu.org ([2001:4830:134:3::10]:41796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbn-0001ym-5z
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbk-0005tl-5Z
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:35 -0500
Date: Wed, 19 Dec 2018 17:37:08 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219063707.GV30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-27-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="xVUAO+xN0VJlKSe3"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-27-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 26/34] target/ppc: Pass integer to
 helper_mtvscr
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


--xVUAO+xN0VJlKSe3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:39:03PM -0800, Richard Henderson wrote:
> We can re-use this helper elsewhere if we're not passing
> in an entire vector register.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/helper.h                 |  2 +-
>  target/ppc/int_helper.c             | 10 +++-------
>  target/ppc/translate/vmx-impl.inc.c | 17 +++++++++++++----
>  3 files changed, 17 insertions(+), 12 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 069daa9883..b3ffe28103 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -294,7 +294,7 @@ DEF_HELPER_5(vmsumuhs, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumshm, void, env, avr, avr, avr, avr)
>  DEF_HELPER_5(vmsumshs, void, env, avr, avr, avr, avr)
>  DEF_HELPER_4(vmladduhm, void, avr, avr, avr, avr)
> -DEF_HELPER_2(mtvscr, void, env, avr)
> +DEF_HELPER_FLAGS_2(mtvscr, TCG_CALL_NO_RWG, void, env, i32)
>  DEF_HELPER_3(lvebx, void, env, avr, tl)
>  DEF_HELPER_3(lvehx, void, env, avr, tl)
>  DEF_HELPER_3(lvewx, void, env, avr, tl)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 3bf0fdb6c5..0443f33cd2 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -469,14 +469,10 @@ void helper_lvsr(ppc_avr_t *r, target_ulong sh)
>      }
>  }
> =20
> -void helper_mtvscr(CPUPPCState *env, ppc_avr_t *r)
> +void helper_mtvscr(CPUPPCState *env, uint32_t vscr)
>  {
> -#if defined(HOST_WORDS_BIGENDIAN)
> -    env->vscr =3D r->u32[3];
> -#else
> -    env->vscr =3D r->u32[0];
> -#endif
> -    set_flush_to_zero(vscr_nj, &env->vec_status);
> +    env->vscr =3D vscr;
> +    set_flush_to_zero((vscr >> VSCR_NJ) & 1, &env->vec_status);
>  }
> =20
>  void helper_vaddcuw(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index 329131d30b..ab6da3aa55 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -196,14 +196,23 @@ static void gen_mfvscr(DisasContext *ctx)
> =20
>  static void gen_mtvscr(DisasContext *ctx)
>  {
> -    TCGv_ptr p;
> +    TCGv_i32 val;
> +    int bofs;
> +
>      if (unlikely(!ctx->altivec_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_VPU);
>          return;
>      }
> -    p =3D gen_avr_ptr(rB(ctx->opcode));
> -    gen_helper_mtvscr(cpu_env, p);
> -    tcg_temp_free_ptr(p);
> +
> +    val =3D tcg_temp_new_i32();
> +    bofs =3D avr64_offset(rB(ctx->opcode), true);
> +#ifdef HOST_WORDS_BIGENDIAN
> +    bofs +=3D 3 * 4;
> +#endif
> +
> +    tcg_gen_ld_i32(val, cpu_env, bofs);
> +    gen_helper_mtvscr(cpu_env, val);
> +    tcg_temp_free_i32(val);
>  }
> =20
>  #define GEN_VX_VMUL10(name, add_cin, ret_carry)                         \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--xVUAO+xN0VJlKSe3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ5xMACgkQbDjKyiDZ
s5K1Vg/+OZAar1stag/g1/jCdxme0jDMGVRXtlF68Z3MO19LWI0TblhL6tpgGw4A
XCjv4syYp9pxHg8Chs3UilKmlpZUTNbLEmofiUxPKCMm9TlGO5f2Cj2D+j5bPmeb
DkYm+rUHdSnWwuKUMQw//TnlgynAs44EUaPIinq8+1hodVQZyM5Ts2GpZ+k1TmxO
yGH9+JZNE9Mkskx98x1ubs4Y04pZjvL/CB7VVuJkfCPy2Z/DQ5QpHYIl7HxlfYDJ
eOP05pMzSrHSYi3mE2Az9pLi7GZegrgcFG8vCxgQeS2aNlI/3ux8hZ2qtpiluD4q
iC5QbJQm9TPZIFvjvg2IX3mPwweaBdrcGjlAHPMmdB+5hEd2YayHBWYnqT1dGj0A
5c+BqlbNakujNZR75eypuYxjX0wcED5b8z5AWcsAfAglchOkTqiYG/8ts7fU0YR8
sshn6JRJCyG5GvhzgE6li/IFMNfqTucU9/D1dAB3vC71vaB60aVIjdreIo9ZXsZf
IztU72fofmyinMgkkW54kBxC2+WElILzpt02H0CnosHlDs8mfpj24Oz85hrmP5yt
oKTD+3hPDAv3LS+EFcbYTiAJ1YEWBE4FAxPh1SgoV2em54Im+jbqPv5l3YpJrIBe
4ivzb2beOwggcNp+R70wRAOtYubXDz8c1oza++4ArRd8bossOy8=
=1QL+
-----END PGP SIGNATURE-----

--xVUAO+xN0VJlKSe3--
