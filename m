Received: from eggs.gnu.org ([2001:4830:134:3::10]:55428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPlo6-0005oQ-3L
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 02:52:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPlo3-0006HO-0V
	for qemu-devel@nongnu.org; Sat, 07 Jan 2017 02:52:54 -0500
Date: Sat, 7 Jan 2017 12:03:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170107010309.GQ13763@umbus.fritz.box>
References: <1483683296-32568-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1483683296-32568-3-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="LqInKle6vr1NBc7W"
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


--LqInKle6vr1NBc7W
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 06, 2017 at 11:44:44AM +0530, Nikunj A Dadhania wrote:
> xxinsertw: VSX Vector Insert Word
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>

Applied to ppc-for-2.9.

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

--LqInKle6vr1NBc7W
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYcD5NAAoJEGw4ysog2bOSgy8QAN2l6oKFxKeRz7VU0S1GgaDm
px04jNRTJM0n2AzRPN/eMB0bFvb4X6EhU0+u0OgbNf3p0SaJGmkPJ5RlJPr7o7Ay
KWvRUfdNqNxmwFVAIuLyvPpTNjt50wJeBuG7j+kdiAAJVwkw+NGEJ5Y8xHYfqogh
Rserq5F702Xm+RqY40LDUnWOEizitbFT9XG1P75MxHh1UWGELIE53Zm/O7W3gtgB
oqay2QMlLekcNfF1ohf/gjyop64kXL9UylRimS1sjCar0az0O0qBnjgj/4vvAaF+
qVy18VokR8SpQxAZL0+ByBojgy4999/ZU1jJu4IJPAx77EkeZunPEGzhJPjBwFAj
h0Y8LlaxhueVjaYiYJ+Hlupc2lJjh/+g+yQQu/mURui1UC6oWe2VEih7R4c11Ygg
/BgGGBxdALIT7dn2b1lIBkqqPOyuj7x/EQYEDTpg4DbIGFHB/83CTOCfa0HnMX/k
38NXqveYpAG8qqmnvhN5ElxkXgPs/aCQpnw4bTtgzpzlo8o7W3GfKi5S1ZzoV/jR
58gL03S6j7VIPCkfJGxa0gw2F55/uo3CaOpo0oMoyQHKqNPIG86yjp9X33vAHlU6
1qwokW8BFXMGe7n8fF6ir/zqjxJ3RCA43jBxSxNWgzKY5Y3B1HSB2pdHn6AaOCVw
vJi1damY724tcx3nrmzy
=nXFN
-----END PGP SIGNATURE-----

--LqInKle6vr1NBc7W--
