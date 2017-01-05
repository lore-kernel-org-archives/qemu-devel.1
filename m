Received: from eggs.gnu.org ([2001:4830:134:3::10]:34286)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPGVM-0007oP-Aw
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:27:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cPGVJ-0000as-9Y
	for qemu-devel@nongnu.org; Thu, 05 Jan 2017 17:27:28 -0500
Date: Fri, 6 Jan 2017 08:57:04 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170105215704.GD13763@umbus.fritz.box>
References: <1483615579-17618-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1483615579-17618-3-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
In-Reply-To: <1483615579-17618-3-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH 02/14] target-ppc: Add xxinsertw instruction
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


--tEFtbjk+mNEviIIX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 04:56:07PM +0530, Nikunj A Dadhania wrote:
> xxinsertw: VSX Vector Insert Word

I think this still has problems with out of bounds values.

>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> ---
>  target-ppc/helper.h                 |  1 +
>  target-ppc/int_helper.c             | 25 +++++++++++++++++++++++++
>  target-ppc/translate/vsx-impl.inc.c |  5 +++--
>  target-ppc/translate/vsx-ops.inc.c  |  1 +
>  4 files changed, 30 insertions(+), 2 deletions(-)
>=20
> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> index 8b30420..6c5b194 100644
> --- a/target-ppc/helper.h
> +++ b/target-ppc/helper.h
> @@ -541,6 +541,7 @@ DEF_HELPER_2(xvrspiz, void, env, i32)
>  DEF_HELPER_2(xxperm, void, env, i32)
>  DEF_HELPER_2(xxpermr, void, env, i32)
>  DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
> +DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
> =20
>  DEF_HELPER_2(efscfsi, i32, env, i32)
>  DEF_HELPER_2(efscfui, i32, env, i32)
> diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
> index 63ba0e3..24e5964 100644
> --- a/target-ppc/int_helper.c
> +++ b/target-ppc/int_helper.c
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

Unlike extract, you don't mod the ins_index here.  Which IIUC, means
for UIMM > 12 you will overwrite data beyond xt, which sounds like a
very bad thing.

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
> diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
> index 7977f24..c9ba0f5 100644
> --- a/target-ppc/translate/vsx-impl.inc.c
> +++ b/target-ppc/translate/vsx-impl.inc.c
> @@ -1180,7 +1180,7 @@ static void gen_xxsldwi(DisasContext *ctx)
>      tcg_temp_free_i64(xtl);
>  }
> =20
> -#define VSX_EXTRACT(name)                                       \
> +#define VSX_EXTRACT_INSERT(name)                                \

Plus for UIMM > 15, this macro will set the target to 0.  That seems
right for extract, but doesn't really seem right for insert (although
*maybe* it's what the hardware does).

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
> diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vs=
x-ops.inc.c
> index 473d925..096d358 100644
> --- a/target-ppc/translate/vsx-ops.inc.c
> +++ b/target-ppc/translate/vsx-ops.inc.c
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

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYbsEuAAoJEGw4ysog2bOScXQP/0udo8X9stJD3xi6i/fMKPIq
MMe4yinZuGUwfthqunkxYL2v7s2k80MLqoUpIY0ATl+AIhtL3KoxBNrVFwo5zVFa
IXaOyy0/5PXt9cIXgehhBh5BTZk5I24X+2uvTphJxbnSGA5MErhxC6NWBUpgZHjo
gp8b29Qy0+fll948yV0c5ngDNz69AK9RBIbMdU37OyiIaQRoHOYvdWKXXeNoAaYQ
KB9ojIUfSLdaS/T4HbGCZIixXRrWOKoYfTn0xeLh8o27URR1rNJPXErZF4s/rQsj
E3ha5PIh7lnnq8A0FmCTE9L6bL1B90tyJ90E2IlvbDQH2Iu3oevRjtcrVD2Cp5jJ
qkKWqoBMCPmurTQFZCRfdpWKzrWDJiczpTzGdXNLS1eOLwIobsZN4z5L9TBC3JmQ
2dCsuccj+ri1Ivvq2PSvq9xYv7qHB5rs+pM1P3RSaF9bdy3WHUiCVB1aK26raTne
s0K05QkIOSsZBMUEdcA0ufGy0y1LvYYyLPxp8Hqm0dky+9+Xo5JzMG607W8aCE3x
O3eXpnpdHDQvDhYJzWblXNzV8bZ4M8KytZc1UY3wVfyBuoOB97tPQWpPexJ3SwYr
jAmkG7AVe2P5dOn0ODtDC9ZY00wr9hk4alzVJuopVB/4qcPqybbKaW7c2B5NoVRh
pnspbgKJveOlaqNVlzOP
=VzUt
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
