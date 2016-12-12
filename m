Received: from eggs.gnu.org ([2001:4830:134:3::10]:36121)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGEWr-00038r-EE
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 19:31:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cGEWn-0004M4-7H
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 19:31:41 -0500
Date: Mon, 12 Dec 2016 11:30:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161212003055.GC12127@umbus.fritz.box>
References: <1481285845-16415-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481285845-16415-6-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KDt/GgjP6HVcx58l"
Content-Disposition: inline
In-Reply-To: <1481285845-16415-6-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v2 5/6] target-ppc: implement xxextractuw
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


--KDt/GgjP6HVcx58l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 09, 2016 at 05:47:24PM +0530, Nikunj A Dadhania wrote:
> xxextractuw: VSX Vector Extract Unsigned Word
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target-ppc/helper.h                 |  1 +
>  target-ppc/int_helper.c             | 21 +++++++++++++++++++++
>  target-ppc/translate/vsx-impl.inc.c | 27 +++++++++++++++++++++++++++
>  target-ppc/translate/vsx-ops.inc.c  |  5 +++++
>  4 files changed, 54 insertions(+)
>=20
> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> index 4707db4..8b30420 100644
> --- a/target-ppc/helper.h
> +++ b/target-ppc/helper.h
> @@ -540,6 +540,7 @@ DEF_HELPER_2(xvrspip, void, env, i32)
>  DEF_HELPER_2(xvrspiz, void, env, i32)
>  DEF_HELPER_2(xxperm, void, env, i32)
>  DEF_HELPER_2(xxpermr, void, env, i32)
> +DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
> =20
>  DEF_HELPER_2(efscfsi, i32, env, i32)
>  DEF_HELPER_2(efscfui, i32, env, i32)
> diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
> index 7989b1f..e3f66ac 100644
> --- a/target-ppc/int_helper.c
> +++ b/target-ppc/int_helper.c
> @@ -2033,6 +2033,27 @@ VEXTRACT(uw, u32)
>  VEXTRACT(d, u64)
>  #undef VEXTRACT
> =20
> +void helper_xxextractuw(CPUPPCState *env, target_ulong xtn,
> +                        target_ulong xbn, uint32_t index)
> +{
> +    ppc_vsr_t xt, xb;
> +    size_t es =3D sizeof(uint32_t);
> +    uint32_t ext_index;
> +
> +    getVSR(xbn, &xb, env);
> +    memset(&xt, 0, sizeof(xt));
> +
> +#if defined(HOST_WORDS_BIGENDIAN)
> +    ext_index =3D index;
> +    memcpy(&xt.u8[8 - es], &xb.u8[ext_index], es);
> +#else
> +    ext_index =3D (16 - index) - es;
> +    memcpy(&xt.u8[8], &xb.u8[ext_index], es);

Hm.  So, IIUC, ext_index is the byte element - in IBM numbering - to
start copying from.  But I thought that when we have an LE host, the
IBM byte element ordering is reversed from the actual order in host
memory, so we'd need &xb.u8[16 - ext_index - es]

> +#endif
> +
> +    putVSR(xtn, &xt, env);
> +}
> +
>  #define VEXT_SIGNED(name, element, mask, cast, recast)              \
>  void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
>  {                                                                   \
> diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
> index 2a17c35..1c40a35 100644
> --- a/target-ppc/translate/vsx-impl.inc.c
> +++ b/target-ppc/translate/vsx-impl.inc.c
> @@ -1180,6 +1180,33 @@ static void gen_xxsldwi(DisasContext *ctx)
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

Throughout the helper you use es =3D=3D sizeof(uint32_t), but here you
hardcode the assumption of 4 bytes, seems a bit inconsistent.

> +        tcg_gen_movi_i64(cpu_vsrh(xT(ctx->opcode)), 0);         \
> +        tcg_gen_movi_i64(cpu_vsrl(xT(ctx->opcode)), 0);         \
> +        return;                                                 \

So, I know the architecture says it is undefined.  But since you're
testing for the bogus case anyway, why not turn this into an
exception.  That seems like it would be more helpful for debugging the
guest than just setting the result to zero.  Or is this done to match
actual hardware behaviour?

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
> index 46b95e3..473d925 100644
> --- a/target-ppc/translate/vsx-ops.inc.c
> +++ b/target-ppc/translate/vsx-ops.inc.c
> @@ -49,6 +49,10 @@ GEN_HANDLER2_E(name, #name, 0x3C, opc2 | 1, opc3, 0, P=
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
> @@ -280,6 +284,7 @@ GEN_XX3FORM(xxpermr, 0x08, 0x07, PPC2_ISA300),
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

--KDt/GgjP6HVcx58l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYTe+8AAoJEGw4ysog2bOSVM8QAML3pzf0ifgGMAEA1HHkVU5t
gMwppL7JGAuLpfYjrnmdfHGp1O1OednnoRGTMJpadnEXfvAMUayo5r+nrswtAN5Y
FDOn2yzUca6vEbfLvCpFshtRRUTNaKOfg7kYjQ+vJMyhtEClcn8pCgx4cxi2XwA/
QH2zrVqyF4bpZl/oiosmVF8Qt+pkVvE6WYOFEgi9pR4KEdHP/7mZNH15l+j3PeIr
cWOcwUrW3smicr0L2O9qB1ot6yFtz7P28BswhJbftnNn0VqSTuhTV+DcC1YHSoXo
e4EzOWJZao+BTPjO7cOkIIO9galBqGx7FplH725C11/Qzr2GxgHkRAAIJf33M/jE
b43TufA/RwCyhd48NO1fgs22+8/NGj5G1s8zdGAvzibAKvpxiC07DLDu87Ufu6BA
DCHQspnc9wq99OBbbJ7bHVNCnk1U+8WSrHo9zpEW55oaqTmTyCn/7ZtiVE7Fr2yv
Vf7r/BGEjYvvcf2QRdKD31oUCtxpMMRwKcvP7+vqw2d5G3yhdpudFM8jRfPAbtjS
ucS+XS5k+q0z2DKBE/Pa8JNkkZ9rhGyknFo+3KXgvRrEkCh2IkFljS19ljumrpdA
zOsjDEwipoWxmzrNS70CeQ3HCciL2GawOPHeoPo/q7e4pd5htNw8gz8WHcE/w+AH
MaUoh/v+WdfoChskberW
=hZj1
-----END PGP SIGNATURE-----

--KDt/GgjP6HVcx58l--
