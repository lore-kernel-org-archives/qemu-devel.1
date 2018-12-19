Received: from eggs.gnu.org ([2001:4830:134:3::10]:41677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbj-0001wN-0N
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbg-0005pU-Pb
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:30 -0500
Date: Wed, 19 Dec 2018 17:29:57 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219062957.GN30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-19-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U6leaJ20qZQc29iB"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-19-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 18/34] target/ppc: convert vaddu[b, h, w,
 d] and vsubu[b, h, w, d] over to use vector operations
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


--U6leaJ20qZQc29iB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:55PM -0800, Richard Henderson wrote:
> From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> Message-Id: <20181217122405.18732-10-mark.cave-ayland@ilande.co.uk>
> ---
>  target/ppc/helper.h                 |  8 --------
>  target/ppc/int_helper.c             |  7 -------
>  target/ppc/translate/vmx-impl.inc.c | 16 ++++++++--------
>  3 files changed, 8 insertions(+), 23 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index c7de04e068..553ff500c8 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -108,14 +108,6 @@ DEF_HELPER_FLAGS_1(ftsqrt, TCG_CALL_NO_RWG_SE, i32, =
i64)
>  #define dh_ctype_avr ppc_avr_t *
>  #define dh_is_signed_avr dh_is_signed_ptr
> =20
> -DEF_HELPER_3(vaddubm, void, avr, avr, avr)
> -DEF_HELPER_3(vadduhm, void, avr, avr, avr)
> -DEF_HELPER_3(vadduwm, void, avr, avr, avr)
> -DEF_HELPER_3(vaddudm, void, avr, avr, avr)
> -DEF_HELPER_3(vsububm, void, avr, avr, avr)
> -DEF_HELPER_3(vsubuhm, void, avr, avr, avr)
> -DEF_HELPER_3(vsubuwm, void, avr, avr, avr)
> -DEF_HELPER_3(vsubudm, void, avr, avr, avr)
>  DEF_HELPER_3(vavgub, void, avr, avr, avr)
>  DEF_HELPER_3(vavguh, void, avr, avr, avr)
>  DEF_HELPER_3(vavguw, void, avr, avr, avr)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 9d715be25c..4547453ef1 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -531,13 +531,6 @@ void helper_vprtybq(ppc_avr_t *r, ppc_avr_t *b)
>              r->element[i] =3D a->element[i] op b->element[i];           =
  \
>          }                                                               \
>      }
> -#define VARITH(suffix, element)                 \
> -    VARITH_DO(add##suffix, +, element)          \
> -    VARITH_DO(sub##suffix, -, element)
> -VARITH(ubm, u8)
> -VARITH(uhm, u16)
> -VARITH(uwm, u32)
> -VARITH(udm, u64)
>  VARITH_DO(muluwm, *, u32)
>  #undef VARITH_DO
>  #undef VARITH
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index c13828a09d..e353d3f174 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -411,18 +411,18 @@ static void glue(gen_, name)(DisasContext *ctx)    =
                     \
>      tcg_temp_free_ptr(rb);                                              \
>  }
> =20
> -GEN_VXFORM(vaddubm, 0, 0);
> +GEN_VXFORM_V(vaddubm, MO_8, tcg_gen_gvec_add, 0, 0);
>  GEN_VXFORM_DUAL_EXT(vaddubm, PPC_ALTIVEC, PPC_NONE, 0,       \
>                      vmul10cuq, PPC_NONE, PPC2_ISA300, 0x0000F800)
> -GEN_VXFORM(vadduhm, 0, 1);
> +GEN_VXFORM_V(vadduhm, MO_16, tcg_gen_gvec_add, 0, 1);
>  GEN_VXFORM_DUAL(vadduhm, PPC_ALTIVEC, PPC_NONE,  \
>                  vmul10ecuq, PPC_NONE, PPC2_ISA300)
> -GEN_VXFORM(vadduwm, 0, 2);
> -GEN_VXFORM(vaddudm, 0, 3);
> -GEN_VXFORM(vsububm, 0, 16);
> -GEN_VXFORM(vsubuhm, 0, 17);
> -GEN_VXFORM(vsubuwm, 0, 18);
> -GEN_VXFORM(vsubudm, 0, 19);
> +GEN_VXFORM_V(vadduwm, MO_32, tcg_gen_gvec_add, 0, 2);
> +GEN_VXFORM_V(vaddudm, MO_64, tcg_gen_gvec_add, 0, 3);
> +GEN_VXFORM_V(vsububm, MO_8, tcg_gen_gvec_sub, 0, 16);
> +GEN_VXFORM_V(vsubuhm, MO_16, tcg_gen_gvec_sub, 0, 17);
> +GEN_VXFORM_V(vsubuwm, MO_32, tcg_gen_gvec_sub, 0, 18);
> +GEN_VXFORM_V(vsubudm, MO_64, tcg_gen_gvec_sub, 0, 19);
>  GEN_VXFORM(vmaxub, 1, 0);
>  GEN_VXFORM(vmaxuh, 1, 1);
>  GEN_VXFORM(vmaxuw, 1, 2);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U6leaJ20qZQc29iB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ5WUACgkQbDjKyiDZ
s5IT7BAAmrO8FKt7xgUxGH+XguCGbOgaL4ARCVDSECCSQHKMD+nbXEtf/8Jl+R/0
CYukQuKDl+LXbl2DzYO18h1zWnjQvKLjjRZz2NxwJBX58UR48BICuPVRWsRULk7N
dar05gwNz9tLr+HELfiRZBaGCqnaDVn4I/NTJDq/x1ve0pXyMvvuXCQzfz8vTW/D
gOeBkvtGs30kWU1bABYQw+saS3AEF8txkEgekQ58OtGQ267N+MP2VeP+IOy9I8Hf
JWG8v6OUIZZUDp50NFUQ970Lnc5sz85GneOvXF+WnOGmbfKXSJuhkFd257+KpMle
L9WYPq419A/LAv+a7KXi3QJwGJdLeNga/RwfJFlKLTtUpHooBnCn56T7DrhjHKcB
4KFTvgvVyd5dsRs5TFbG0hqKghX4+uOA3K1ZrQ1Dgl+ukJZlJ/refrPfrKXERi2+
rsEDOth3hPLApN29Gt9NAjv8A7bTs+YZxfwLWRdiQJdRUWaPSwIPVgP8J0lPjChG
esOCSpkgKhoYo0YNShFLFKKO3o8Klfyecq25AUiWM83SHuJ0rm6osKEsWvh9T8To
vzhdGBT/FMcrv9LO515r3a1Ao/fGBw3T2cudRM3jjDuOb4WA3jBUDcQ900i7IlGy
jzsy5MUCA0Wpi6jyAuP9SOINNHTKY0ZzznRi0U4utV0KXXXXGck=
=G/0+
-----END PGP SIGNATURE-----

--U6leaJ20qZQc29iB--
