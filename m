Received: from eggs.gnu.org ([2001:4830:134:3::10]:41799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbn-0001yn-76
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbj-0005tM-Rk
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:35 -0500
Date: Wed, 19 Dec 2018 17:32:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219063201.GP30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-21-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b5sSX5qSQrSInIHt"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-21-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 20/34] target/ppc: convert vsplt[bhw] to
 use vector operations
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


--b5sSX5qSQrSInIHt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:57PM -0800, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/helper.h                 |  3 --
>  target/ppc/int_helper.c             | 24 ---------------
>  target/ppc/translate/vmx-impl.inc.c | 45 +++++++++++++++++------------
>  3 files changed, 26 insertions(+), 46 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 2aa60e5d36..069daa9883 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -246,9 +246,6 @@ DEF_HELPER_3(vrld, void, avr, avr, avr)
>  DEF_HELPER_3(vsl, void, avr, avr, avr)
>  DEF_HELPER_3(vsr, void, avr, avr, avr)
>  DEF_HELPER_4(vsldoi, void, avr, avr, avr, i32)
> -DEF_HELPER_3(vspltb, void, avr, avr, i32)
> -DEF_HELPER_3(vsplth, void, avr, avr, i32)
> -DEF_HELPER_3(vspltw, void, avr, avr, i32)
>  DEF_HELPER_3(vextractub, void, avr, avr, i32)
>  DEF_HELPER_3(vextractuh, void, avr, avr, i32)
>  DEF_HELPER_3(vextractuw, void, avr, avr, i32)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index e44c0d90ee..3bf0fdb6c5 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -1918,30 +1918,6 @@ void helper_vslo(ppc_avr_t *r, ppc_avr_t *a, ppc_a=
vr_t *b)
>  #endif
>  }
> =20
> -/* Experimental testing shows that hardware masks the immediate.  */
> -#define _SPLAT_MASKED(element) (splat & (ARRAY_SIZE(r->element) - 1))
> -#if defined(HOST_WORDS_BIGENDIAN)
> -#define SPLAT_ELEMENT(element) _SPLAT_MASKED(element)
> -#else
> -#define SPLAT_ELEMENT(element)                                  \
> -    (ARRAY_SIZE(r->element) - 1 - _SPLAT_MASKED(element))
> -#endif
> -#define VSPLT(suffix, element)                                          \
> -    void helper_vsplt##suffix(ppc_avr_t *r, ppc_avr_t *b, uint32_t splat=
) \
> -    {                                                                   \
> -        uint32_t s =3D b->element[SPLAT_ELEMENT(element)];              =
  \
> -        int i;                                                          \
> -                                                                        \
> -        for (i =3D 0; i < ARRAY_SIZE(r->element); i++) {                =
  \
> -            r->element[i] =3D s;                                        =
  \
> -        }                                                               \
> -    }
> -VSPLT(b, u8)
> -VSPLT(h, u16)
> -VSPLT(w, u32)
> -#undef VSPLT
> -#undef SPLAT_ELEMENT
> -#undef _SPLAT_MASKED
>  #if defined(HOST_WORDS_BIGENDIAN)
>  #define VINSERT(suffix, element)                                        =
    \
>      void helper_vinsert##suffix(ppc_avr_t *r, ppc_avr_t *b, uint32_t ind=
ex) \
> diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
> index be638cdb1a..529ae0e5f5 100644
> --- a/target/ppc/translate/vmx-impl.inc.c
> +++ b/target/ppc/translate/vmx-impl.inc.c
> @@ -814,24 +814,31 @@ GEN_VXFORM_NOA(vprtybw, 1, 24);
>  GEN_VXFORM_NOA(vprtybd, 1, 24);
>  GEN_VXFORM_NOA(vprtybq, 1, 24);
> =20
> -#define GEN_VXFORM_UIMM(name, opc2, opc3)                               \
> -static void glue(gen_, name)(DisasContext *ctx)                         =
        \
> -    {                                                                   \
> -        TCGv_ptr rb, rd;                                                \
> -        TCGv_i32 uimm;                                                  \
> -        if (unlikely(!ctx->altivec_enabled)) {                          \
> -            gen_exception(ctx, POWERPC_EXCP_VPU);                       \
> -            return;                                                     \
> -        }                                                               \
> -        uimm =3D tcg_const_i32(UIMM5(ctx->opcode));                     =
  \
> -        rb =3D gen_avr_ptr(rB(ctx->opcode));                            =
  \
> -        rd =3D gen_avr_ptr(rD(ctx->opcode));                            =
  \
> -        gen_helper_##name (rd, rb, uimm);                               \
> -        tcg_temp_free_i32(uimm);                                        \
> -        tcg_temp_free_ptr(rb);                                          \
> -        tcg_temp_free_ptr(rd);                                          \
> +static void gen_vsplt(DisasContext *ctx, int vece)
> +{
> +    int uimm, dofs, bofs;
> +
> +    if (unlikely(!ctx->altivec_enabled)) {
> +        gen_exception(ctx, POWERPC_EXCP_VPU);
> +        return;
>      }
> =20
> +    uimm =3D UIMM5(ctx->opcode);
> +    bofs =3D avr64_offset(rB(ctx->opcode), true);
> +    dofs =3D avr64_offset(rD(ctx->opcode), true);
> +
> +    /* Experimental testing shows that hardware masks the immediate.  */
> +    bofs +=3D (uimm << vece) & 15;
> +#ifndef HOST_WORDS_BIGENDIAN
> +    bofs ^=3D 15;
> +#endif
> +
> +    tcg_gen_gvec_dup_mem(vece, dofs, bofs, 16, 16);
> +}
> +
> +#define GEN_VXFORM_VSPLT(name, vece, opc2, opc3) \
> +static void glue(gen_, name)(DisasContext *ctx) { gen_vsplt(ctx, vece); }
> +
>  #define GEN_VXFORM_UIMM_ENV(name, opc2, opc3)                           \
>  static void glue(gen_, name)(DisasContext *ctx)                         \
>      {                                                                   \
> @@ -873,9 +880,9 @@ static void glue(gen_, name)(DisasContext *ctx)      =
                   \
>          tcg_temp_free_ptr(rd);                                          \
>      }
> =20
> -GEN_VXFORM_UIMM(vspltb, 6, 8);
> -GEN_VXFORM_UIMM(vsplth, 6, 9);
> -GEN_VXFORM_UIMM(vspltw, 6, 10);
> +GEN_VXFORM_VSPLT(vspltb, MO_8, 6, 8);
> +GEN_VXFORM_VSPLT(vsplth, MO_16, 6, 9);
> +GEN_VXFORM_VSPLT(vspltw, MO_32, 6, 10);
>  GEN_VXFORM_UIMM_SPLAT(vextractub, 6, 8, 15);
>  GEN_VXFORM_UIMM_SPLAT(vextractuh, 6, 9, 14);
>  GEN_VXFORM_UIMM_SPLAT(vextractuw, 6, 10, 12);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--b5sSX5qSQrSInIHt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ5eEACgkQbDjKyiDZ
s5LHzBAA5OCjvi/UuAi4cu9harvWEQZgb7vQQ4oF699QhQ3HRFBZ/bkSChz0FNZ0
ItLdciZ87QuydhTYjO2X8S4TtJfNEaa0Bccu9QMlnzuWvxAU674O/n6oyAOHR+7x
IFiKY6gPgJwZ92aTzlM8NIhZEr602xnXQJwoSu1igZJuVUMILczzZnQY8A5zP6X8
StOoJcS6p9yGsKLGQNH7572XYuOOFzte5skKeeDUZG45ObINQ8YYOHYgkg7Xx2V8
GZGqcb5yhlYf4nfKIpEOMoZ/v84ClVv3XM+Qz8lmueN3t998k8xuA2VS2WIXUhnJ
erHAQ5BFSPOhTiI8gXrVu53bQlgguWWUiqTy+FlCSAlGPVuEIwy+75c1RDI9Effp
Ne+RQIEI60vYKQG8E16giy4eOcxrK1l0kucFklpCL8BPOoeSTsG6ENpM2RDW7ezN
xY9aNCpURBUEFP/HTsmRoPdiA6s9NNxKlVG9cAWv92Lc8w3QctoKTISaZB7FPZPT
EcYofbRqnZQuPks9HCiqcVix6ihLdv4uZFplBNgfJjfChf4zFTo3SeF9033nRgMn
3mY+3kEWXma8F6yMD/FEASfjCm7zaVDACQn+5SIVIjdRfQBwOobHvxWjqzzgYv1C
ZhwjnuNPBdCCdkKW4zHzrdtkJ1P3FJ0Lwz4kApwm9dNLlXgHxwo=
=9ZN7
-----END PGP SIGNATURE-----

--b5sSX5qSQrSInIHt--
