Received: from eggs.gnu.org ([2001:4830:134:3::10]:60860)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7YK-00066z-BN
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7YH-0002ae-9T
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:36 -0500
Date: Fri, 9 Dec 2016 09:34:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161208223419.GF13139@umbus.fritz.box>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481135102-20011-7-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9Iq5ULCa7nGtWwZS"
Content-Disposition: inline
In-Reply-To: <1481135102-20011-7-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 6/9] target-ppc: implement xxinsertw
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


--9Iq5ULCa7nGtWwZS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2016 at 11:54:59PM +0530, Nikunj A Dadhania wrote:
> xxinsertw: VSX Vector Insert Word
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Reviewed-by: Richard Henderson <rth@twiddle.net>
> ---
>  target-ppc/helper.h                 |  1 +
>  target-ppc/int_helper.c             | 30 ++++++++++++++++++++++++++++++
>  target-ppc/translate/vsx-impl.inc.c |  5 +++--
>  target-ppc/translate/vsx-ops.inc.c  |  1 +
>  4 files changed, 35 insertions(+), 2 deletions(-)
>=20
> diff --git a/target-ppc/helper.h b/target-ppc/helper.h
> index 940f81c..9f812c8 100644
> --- a/target-ppc/helper.h
> +++ b/target-ppc/helper.h
> @@ -537,6 +537,7 @@ DEF_HELPER_2(xvrspim, void, env, i32)
>  DEF_HELPER_2(xvrspip, void, env, i32)
>  DEF_HELPER_2(xvrspiz, void, env, i32)
>  DEF_HELPER_4(xxextractuw, void, env, tl, tl, i32)
> +DEF_HELPER_4(xxinsertw, void, env, tl, tl, i32)
> =20
>  DEF_HELPER_2(efscfsi, i32, env, i32)
>  DEF_HELPER_2(efscfui, i32, env, i32)
> diff --git a/target-ppc/int_helper.c b/target-ppc/int_helper.c
> index 093c5ec..b6e8c37 100644
> --- a/target-ppc/int_helper.c
> +++ b/target-ppc/int_helper.c
> @@ -2064,6 +2064,36 @@ void helper_##name(CPUPPCState *env, target_ulong =
xtn,                  \
>  XXEXTRACT(xxextractuw, u32)
>  #undef XXEXTRACT
> =20
> +#if defined(HOST_WORDS_BIGENDIAN)
> +#define XXINSERT(name, element)                                         \
> +void helper_##name(CPUPPCState *env, target_ulong xtn,                  \
> +                   target_ulong xbn, uint32_t index)                    \

Again, you should be able to use an element size parameter, rather
than generating multiple helpers.

> +{                                                                       \
> +    ppc_vsr_t xt, xb;                                                   \
> +                                                                        \
> +    getVSR(xbn, &xb, env);                                              \
> +    getVSR(xtn, &xt, env);                                              \
> +    memmove(&xt.u8[index], &xb.u8[8 - sizeof(xt.element)],              \
> +            sizeof(xt.element[0]));
> \

You've already copied into the xt and xb temporaries, so memcpy()
should be safe here.

> +    putVSR(xtn, &xt, env);                                              \
> +}
> +#else
> +#define XXINSERT(name, element)                                         \
> +void helper_##name(CPUPPCState *env, target_ulong xtn,                  \
> +                   target_ulong xbn, uint32_t index)                    \
> +{                                                                       \
> +    ppc_vsr_t xt, xb;                                                   \
> +    uint32_t d =3D (16 - index) - sizeof(xt.element[0]);                =
  \
> +                                                                        \
> +    getVSR(xbn, &xb, env);                                              \
> +    getVSR(xtn, &xt, env);                                              \
> +    memmove(&xt.u8[d], &xb.u8[8], sizeof(xt.element[0]));               \
> +    putVSR(xtn, &xt, env);                                              \
> +}
> +#endif
> +XXINSERT(xxinsertw, u32)
> +#undef XXINSERT
> +
>  #define VEXT_SIGNED(name, element, mask, cast, recast)              \
>  void helper_##name(ppc_avr_t *r, ppc_avr_t *b)                      \
>  {                                                                   \
> diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
> index a9c07c9..6a81b2e 100644
> --- a/target-ppc/translate/vsx-impl.inc.c
> +++ b/target-ppc/translate/vsx-impl.inc.c
> @@ -1162,7 +1162,7 @@ static void gen_xxsldwi(DisasContext *ctx)
>      tcg_temp_free_i64(xtl);
>  }
> =20
> -#define VSX_EXTRACT(name)                                       \
> +#define VSX_EXTRACT_INSERT(name)                                \
>  static void gen_##name(DisasContext *ctx)                       \
>  {                                                               \
>      TCGv xt, xb;                                                \
> @@ -1187,7 +1187,8 @@ static void gen_##name(DisasContext *ctx)          =
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
> index 3ce657d..0216efe 100644
> --- a/target-ppc/translate/vsx-ops.inc.c
> +++ b/target-ppc/translate/vsx-ops.inc.c
> @@ -277,6 +277,7 @@ GEN_XX2FORM(xxspltw, 0x08, 0x0A, PPC2_VSX),
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

--9Iq5ULCa7nGtWwZS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSd/rAAoJEGw4ysog2bOSjl0P/A0jrDVYIujmUoLLd6Km37xu
oye3V2KwkyB4eLrX0T/HFpcANVfJZVRZNrOyNR19kYrVF/K0Tqjgowyw9MUtr5j6
BpEMpdZT/JvwSAxku4Vdl3O3vjcG1ppfaJSWRQMGXD6TrmwljkqYX5/ODa09PBx0
GEyaR1Qe5/69HrIPW30op3wrcLwxXtwzcUl8m6VFfxadUPXimmGcXGVDagp5vZrq
dSzjF4pD7R9QZz7HNJdByOJUUrdAI9uPvdg2Jp+IcYuUgz4wm5WNxyqG1GT1x6oc
4iZqSuPRpZ+obPNWDrOP6T6Ot4sszI47vilUNF4v30WQnHAPIA4TN2s71JgcNjrg
QYDMT1ar8JWxW8PCkexirXu+NuamAvymfd/K58j9RsOLKZ9NJ95IpjJcbNBOdcAL
Mq4Op0yRpj2mzu0DifxaePUZ9yBKCXKKuyWnroITQyJCnQxXV0YdlncVWwSKr1HH
I9PVrs7SdxFNuhjJYd/yRzt7nGB7xCisZXIfkQUwSu+GqzaYgL4MoTNIGZNS2Ysr
N6sX329kzN8aqY9zYw53TT/NBle5ZBU9rmuuPhUQkP6JrUCAkbXxaB9uTLLeVhFY
481IlcvT+xui97DwNiaWSdrs32ZWxV/ZBAKnYjo4/7VR0mT1uNM1Rc96iRnEiSqW
ba3wVAzqDWXm/IwKHBG4
=BhGu
-----END PGP SIGNATURE-----

--9Iq5ULCa7nGtWwZS--
