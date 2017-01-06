Received: from eggs.gnu.org ([2001:4830:134:3::10]:38354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPPRs-00008r-Ow
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:00:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPPRo-0002Ml-Mf
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 03:00:28 -0500
Date: Fri, 6 Jan 2017 18:54:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170106075407.GO13763@umbus.fritz.box>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1483683296-32568-3-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="yUmmepPgoWmUqRhm"
Content-Disposition: inline
In-Reply-To: <1483683296-32568-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 02/14] target-ppc: Add xxinsertw
 instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
Cc: qemu-ppc@nongnu.org, rth@twiddle.net, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--yUmmepPgoWmUqRhm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2017 at 11:44:44AM +0530, Nikunj A Dadhania wrote:
> xxinsertw: VSX Vector Insert Word
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

The comments I had about out of bounds shifts don't seem to have been
addressed here.

> ---
>  target/ppc/helper.h                 |  1 +
>  target/ppc/int_helper.c             | 25 +++++++++++++++++++++++++
>  target/ppc/translate/vsx-impl.inc.c |  5 +++--
>  target/ppc/translate/vsx-ops.inc.c  |  1 +
>  4 files changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/helper.h b/target/ppc/helper.h
> index 8b30420..6c5b194 100644
> --- a/target/ppc/helper.h
> +++ b/target/ppc/helper.h
> @@ -541,6 +541,7 @@ DEF_HELPER_2(xvrspiz, void, env, i32)
>  DEF_HELPER_2(xxperm, void, env, i32)
>  DEF_HELPER_2(xxpermr, void, env, i32)
>  DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
> +DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
> =20
>  DEF_HELPER_2(efscfsi, i32, env, i32)
>  DEF_HELPER_2(efscfui, i32, env, i32)
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 63ba0e3..24e5964 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -2059,6 +2059,31 @@ void helper_xxextractuw(CPUPPCState *env, target_u=
long xtn,
>      putVSR(xtn, &xt, env);
>  }
> =20
> +void helper_xxinsertw(CPUPPCState *env, target_ulong xtn,
> +                      target_ulong xbn, uint32_t index)
> +{
> +    ppc_vsr_t xt, xb;
> +    size_t es =3D sizeof(uint32_t);
> +    int ins_index, i =3D 0;
> +
> +    getVSR(xbn, &xb, env);
> +    getVSR(xtn, &xt, env);
> +
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    ins_index =3D index;
> +    for (i =3D 0; i < es && ins_index < 16; i++, ins_index++) {
> +        xt.u8[ins_index] =3D xb.u8[8 - es + i];
> +    }
> +#else
> +    ins_index =3D 15 - index;
> +    for (i =3D es - 1; i >=3D 0 && ins_index >=3D 0; i--, ins_index--) {
> +        xt.u8[ins_index] =3D xb.u8[8 + i];
> +    }
> +#endif
> +
> +    putVSR(xtn, &xt, env);
> +}
> +
>  #define VEXT_SIGNED(name, element, mask, cast, recast)              \
>  void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
>  {                                                                   \
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 7977f24..c9ba0f5 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1180,7 +1180,7 @@ static void gen_xxsldwi(DisasContext *ctx)
>      tcg_temp_free_i64(xtl);
>  }
> =20
> -#define VSX_EXTRACT(name)                                       \
> +#define VSX_EXTRACT_INSERT(name)                                \
>  static void gen_##name(DisasContext *ctx)                       \
>  {                                                               \
>      TCGv xt, xb;                                                \
> @@ -1208,7 +1208,8 @@ static void gen_##name(DisasContext *ctx)          =
             \
>      tcg_temp_free_i32(t0);                                      \
>  }
> =20
> -VSX_EXTRACT(xxextractuw)
> +VSX_EXTRACT_INSERT(xxextractuw)
> +VSX_EXTRACT_INSERT(xxinsertw)
> =20
>  #undef GEN_XX2FORM
>  #undef GEN_XX3FORM
> diff --git a/target/ppc/translate/vsx-ops.inc.c b/target/ppc/translate/vs=
x-ops.inc.c
> index 473d925..096d358 100644
> --- a/target/ppc/translate/vsx-ops.inc.c
> +++ b/target/ppc/translate/vsx-ops.inc.c
> @@ -285,6 +285,7 @@ GEN_XX2FORM(xxspltw, 0x08, 0x0A, PPC2_VSX),
>  GEN_XX1FORM(xxspltib, 0x08, 0x0B, PPC2_ISA300),
>  GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),
>  GEN_XX2FORM_EXT(xxextractuw, 0x0A, 0x0A, PPC2_ISA300),
> +GEN_XX2FORM_EXT(xxinsertw, 0x0A, 0x0B, PPC2_ISA300),
> =20
>  #define GEN_XXSEL_ROW(opc3) \
>  GEN_HANDLER2_E(xxsel, "xxsel", 0x3C, 0x18, opc3, 0, PPC_NONE, PPC2_VSX),=
 \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--yUmmepPgoWmUqRhm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYb00fAAoJEGw4ysog2bOSGEQQAOTANgy7Ex4P6AEnHsZQsCwY
3G6vgA1oVjZwP8m2BAOAW2frUoefmQyJoMYFVHG/st3uBWx+n3pDLVQdNpU5yE4u
peBoZXaZs/F8qBqM5CBT5dh0fugF9bZZ/mGcHVtCUZ3G32Dfu5HSoN49y4JAN9Qp
V9cIrIi1E77Egz9mC6aGXit9CMI2jOawYQehNPndz2xpEIDH/eOKI8T/lXDBWqON
cX/+1Psfjjy/8e38UMDArdTrgxLQMX5Gk06bI0++yaOU7A6zgK180zNrJU+H2bqu
fL7tIYX/EynT9Pw86JGGNeNAN6AEnlY+qWf2rD7r94TdQOUNJYaAk97qHNxyYd12
pQf2lpKBmuN1xAoeL00jvN/jR2lHjW/CHm0YmF3c0AHU/2ZZUG4Ve+aXfOxCWTow
dHv68v3gCxnSAeERFPVMuo8ovKcX0XoOoMI67kfYHVty2FmIzD0YfxnUDI/5JpM7
gnieHTiEKM04Ib0b5EnDv5JcS3IzUAi/JtDO8D+b0pUzAqsxT8NDFAVe8F+JLu8u
nqf3j467TV4WXBMdjm6fFj1CmClV/652Eo0w2gOMFnKCIcciQFALp3z5oHPKmDVd
dq/Me4y/xvm9ICLYtSho955+MXILHchpZA7ycM7iYQT9XljvEeqMY900rn5rBObf
CnwjM62pQYDR6drenYt5
=FAil
-----END PGP SIGNATURE-----

--yUmmepPgoWmUqRhm--
