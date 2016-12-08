Received: from eggs.gnu.org ([2001:4830:134:3::10]:60691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xn-0005HC-Jf
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xk-0002TJ-HF
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:03 -0500
Date: Fri, 9 Dec 2016 09:32:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161208223221.GE13139@umbus.fritz.box>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481135102-20011-6-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dgjlcl3Tl+kb3YDk"
Content-Disposition: inline
In-Reply-To: <1481135102-20011-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 5/9] target-ppc: implement xxextractuw
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


--dgjlcl3Tl+kb3YDk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2016 at 11:54:58PM +0530, Nikunj A Dadhania wrote:
> xxextractuw: VSX Vector Extract Unsigned Word
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target-ppc/helper.h                 |  1 +
>  target-ppc/int_helper.c             | 31 +++++++++++++++++++++++++++++++
>  target-ppc/translate/vsx-impl.inc.c | 27 +++++++++++++++++++++++++++
>  target-ppc/translate/vsx-ops.inc.c  |  5 +++++
>  4 files changed, 64 insertions(+)
>=20
> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> index 91bdfc3..940f81c 100644
> --- a/target-ppc/helper.h
> +++ b/target-ppc/helper.h
> @@ -536,6 +536,7 @@ DEF_HELPER_2(xvrspic, void, env, i32)
>  DEF_HELPER_2(xvrspim, void, env, i32)
>  DEF_HELPER_2(xvrspip, void, env, i32)
>  DEF_HELPER_2(xvrspiz, void, env, i32)
> +DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
> =20
>  DEF_HELPER_2(efscfsi, i32, env, i32)
>  DEF_HELPER_2(efscfui, i32, env, i32)
> diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
> index 7030f61..093c5ec 100644
> --- a/target-ppc/int_helper.c
> +++ b/target-ppc/int_helper.c
> @@ -2033,6 +2033,37 @@ VEXTRACT(uw, u32)
>  VEXTRACT(d, u64)
>  #undef VEXTRACT
> =20
> +#if defined(HOST_WORDS_BIGENDIAN)
> +#define XXEXTRACT(name, element)                                        \
> +void helper_##name(CPUPPCState *env, target_ulong xtn,                  \
> +                   target_ulong xbn, uint32_t index)                    \

You're already breaking out to a helper.  Why not just pass the
element size in as a parameter.  As a bonus that means you can
restrict the ifdef HOST_WORDS_BIGENDIAN to a couple of lines, instead
of the whole helper.
> +{                                                                       \
> +    ppc_vsr_t xt, xb;                                                   \
> +    uint32_t es =3D sizeof(xt.element[0]);                              =
  \

Also, strictly speaking, this should be a size_t.

> +    getVSR(xbn, &xb, env);                                              \
> +    memset(&xt, 0, sizeof(xt));                                         \
> +    memcpy(&xt.u8[8 - es], &xb.u8[index], es);                          \
> +    putVSR(xtn, &xt, env);                                              \
> +}
> +#else
> +#define XXEXTRACT(name, element)                                        \
> +void helper_##name(CPUPPCState *env, target_ulong xtn,                  \
> +                   target_ulong xbn, uint32_t index)                    \
> +{                                                                       \
> +    ppc_vsr_t xt, xb;                                                   \
> +    uint32_t es =3D sizeof(xt.element[0]);                              =
  \
> +    uint32_t s =3D (16 - index) - es;                                   =
  \
> +                                                                        \
> +    getVSR(xbn, &xb, env);                                              \
> +    memset(&xt, 0, sizeof(xt));                                         \
> +    memcpy(&xt.u8[8], &xb.u8[s], es);                                   \
> +    putVSR(xtn, &xt, env);                                              \
> +}
> +#endif
> +XXEXTRACT(xxextractuw, u32)
> +#undef XXEXTRACT
> +
>  #define VEXT_SIGNED(name, element, mask, cast, recast)              \
>  void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
>  {                                                                   \
> diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
> index c691141..a9c07c9 100644
> --- a/target-ppc/translate/vsx-impl.inc.c
> +++ b/target-ppc/translate/vsx-impl.inc.c
> @@ -1162,6 +1162,33 @@ static void gen_xxsldwi(DisasContext *ctx)
>      tcg_temp_free_i64(xtl);
>  }
> =20
> +#define VSX_EXTRACT(name)                                       \
> +static void gen_##name(DisasContext *ctx)                       \
> +{                                                               \
> +    TCGv xt, xb;                                                \
> +    TCGv_i32 t0 =3D tcg_temp_new_i32();                           \
> +    uint8_t uimm =3D UIMM4(ctx->opcode);                          \
> +                                                                \
> +    if (unlikely(!ctx->vsx_enabled)) {                          \
> +        gen_exception(ctx, POWERPC_EXCP_VSXU);                  \
> +        return;                                                 \
> +    }                                                           \
> +    if (uimm > 12) {                                            \
> +        tcg_gen_movi_i64(cpu_vsrh(xT(ctx->opcode)), 0);         \
> +        tcg_gen_movi_i64(cpu_vsrl(xT(ctx->opcode)), 0);         \
> +        return;                                                 \
> +    }                                                           \
> +    xt =3D tcg_const_tl(xT(ctx->opcode));                         \
> +    xb =3D tcg_const_tl(xB(ctx->opcode));                         \
> +    tcg_gen_movi_i32(t0, uimm);                                 \
> +    gen_helper_##name(cpu_env, xt, xb, t0);                     \
> +    tcg_temp_free(xb);                                          \
> +    tcg_temp_free(xt);                                          \
> +    tcg_temp_free_i32(t0);                                      \
> +}
> +
> +VSX_EXTRACT(xxextractuw)
> +
>  #undef GEN_XX2FORM
>  #undef GEN_XX3FORM
>  #undef GEN_XX2IFORM
> diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vs=
x-ops.inc.c
> index be446ae..3ce657d 100644
> --- a/target-ppc/translate/vsx-ops.inc.c
> +++ b/target-ppc/translate/vsx-ops.inc.c
> @@ -45,6 +45,10 @@ GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0, P=
PC_NONE, fl2)
>  GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0, opc3, 0, PPC_NONE, fl2), \
>  GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0, PPC_NONE, fl2)
> =20
> +#define GEN_XX2FORM_EXT(name, opc2, opc3, fl2)                          \
> +GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 0, opc3, 0x00100000, PPC_NONE, =
fl2), \
> +GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0x00100000, PPC_NONE, =
fl2)
> +
>  #define GEN_XX2FORM_EO(name, opc2, opc3, opc4, fl2)                     =
     \
>  GEN_HANDLER2_E_2(name, #name, 0x3C, opc2 | 0, opc3, opc4, 0, PPC_NONE, f=
l2), \
>  GEN_HANDLER2_E_2(name, #name, 0x3C, opc2 | 1, opc3, opc4, 0, PPC_NONE, f=
l2)
> @@ -272,6 +276,7 @@ GEN_XX3FORM(xxmrglw, 0x08, 0x06, PPC2_VSX),
>  GEN_XX2FORM(xxspltw, 0x08, 0x0A, PPC2_VSX),
>  GEN_XX1FORM(xxspltib, 0x08, 0x0B, PPC2_ISA300),
>  GEN_XX3FORM_DM(xxsldwi, 0x08, 0x00),
> +GEN_XX2FORM_EXT(xxextractuw, 0x0A, 0x0A, PPC2_ISA300),
> =20
>  #define GEN_XXSEL_ROW(opc3) \
>  GEN_HANDLER2_E(xxsel, "xxsel", 0x3C, 0x18, opc3, 0, PPC_NONE, PPC2_VSX),=
 \

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dgjlcl3Tl+kb3YDk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSd91AAoJEGw4ysog2bOSBxEP/jfK9IJRKocAm2Xl3yydgAcJ
OSaRnwEZFYqo3QLaqKFTmhPhDXEsTlf7w8gPXfw7YRaqg/ya+LK69bjjgQOMjXLd
H3OD4oWbnYA2A9zmrBwg6SX+CIRXPxoUj9DymCPLowqJKJ0uzBcA/xmPwxDyhVou
GNLAT8o5ncAPwO1RKazh7tjeFt5pRS3NnGZ2Gaqk9UR6399N+nSPnYQeWjMgWy9p
froWAWCMmd4YXO3ciLKmbixtSuAcvYeGoCtLlruujpTvgsRb5uHKSJYkmAgocJ87
KSwryA77xUuqJX9wc7kNe8wISu6fWV0tkx98mmlYvy2zVmnEM/9bY5vvddLul0sU
K3pKbsaG5XHow1Wx9SfTiH/kzu3uPCypz8TpHzs2/T6JMrcbuB9tdRdhyAa/SCWt
2E2+vtaapJJdjbEKLaxCrNY/dO4enOTr2J/a9GmgcbEYLH48b4jrVSMiWcwqFG2u
L0jniyMhbILI95DbLBHeevhY9SAoKq7AkGbnGISrVjUVxH1z7do9KqIK8mEIYGRF
XB9yaIzvX+eSBJWtSoCoRI8qXJqQqImlxvkIfpbo9rLb6wS7wXzDtmtWEWZg3aHV
6Fh4v1c5W5nHTVRzrlrUoAsn7I54LrJjbesp38gTYO26ms0+ChKZEo4Mgv7SzZk3
F9XhVDxw3CPrucrkHy+F
=bvqH
-----END PGP SIGNATURE-----

--dgjlcl3Tl+kb3YDk--
