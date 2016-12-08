Received: from eggs.gnu.org ([2001:4830:134:3::10]:60724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xo-0005HZ-JU
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cF7Xn-0002U0-9o
	for qemu-devel@nongnu.org; Thu, 08 Dec 2016 17:52:04 -0500
Date: Fri, 9 Dec 2016 09:51:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161208225103.GH13139@umbus.fritz.box>
References: <1481135102-20011-1-git-send-email-nikunj@linux.vnet.ibm.com>
	<1481135102-20011-9-git-send-email-nikunj@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pe+tqlI1iYzVj1X/"
Content-Disposition: inline
In-Reply-To: <1481135102-20011-9-git-send-email-nikunj@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 8/9] target-ppc: implement xscpsgnqp
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


--pe+tqlI1iYzVj1X/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2016 at 11:55:01PM +0530, Nikunj A Dadhania wrote:
> xscpsgnqp: VSX Scalar Copy Sign Quad-Precision
>=20
> Signed-off-by: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Reviewed-by: Richard Henderson <rth@twiddle.net>

Merged to ppc-for-2.9

> ---
>  target-ppc/translate/vsx-impl.inc.c | 12 +++++++++++-
>  target-ppc/translate/vsx-ops.inc.c  |  1 +
>  2 files changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/target-ppc/translate/vsx-impl.inc.c b/target-ppc/translate/v=
sx-impl.inc.c
> index 01b95df..8321134 100644
> --- a/target-ppc/translate/vsx-impl.inc.c
> +++ b/target-ppc/translate/vsx-impl.inc.c
> @@ -642,9 +642,10 @@ VSX_SCALAR_MOVE(xscpsgndp, OP_CPSGN, SGN_MASK_DP)
>  #define VSX_SCALAR_MOVE_QP(name, op, sgn_mask)                    \
>  static void glue(gen_, name)(DisasContext *ctx)                   \
>  {                                                                 \
> +    int xa;                                                       \
>      int xt =3D rD(ctx->opcode) + 32;                                \
>      int xb =3D rB(ctx->opcode) + 32;                                \
> -    TCGv_i64 xbh, xbl, sgm;                                       \
> +    TCGv_i64 xah, xbh, xbl, sgm;                                  \
>                                                                    \
>      if (unlikely(!ctx->vsx_enabled)) {                            \
>          gen_exception(ctx, POWERPC_EXCP_VSXU);                    \
> @@ -666,6 +667,14 @@ static void glue(gen_, name)(DisasContext *ctx)     =
              \
>      case OP_NEG:                                                  \
>          tcg_gen_xor_i64(xbh, xbh, sgm);                           \
>          break;                                                    \
> +    case OP_CPSGN:                                                \
> +        xah =3D tcg_temp_new_i64();                                 \
> +        xa =3D rA(ctx->opcode) + 32;                                \
> +        tcg_gen_and_i64(xah, cpu_vsrh(xa), sgm);                  \
> +        tcg_gen_andc_i64(xbh, xbh, sgm);                          \
> +        tcg_gen_or_i64(xbh, xbh, xah);                            \
> +        tcg_temp_free_i64(xah);                                   \
> +        break;                                                    \
>      }                                                             \
>      tcg_gen_mov_i64(cpu_vsrh(xt), xbh);                           \
>      tcg_gen_mov_i64(cpu_vsrl(xt), xbl);                           \
> @@ -677,6 +686,7 @@ static void glue(gen_, name)(DisasContext *ctx)      =
             \
>  VSX_SCALAR_MOVE_QP(xsabsqp, OP_ABS, SGN_MASK_DP)
>  VSX_SCALAR_MOVE_QP(xsnabsqp, OP_NABS, SGN_MASK_DP)
>  VSX_SCALAR_MOVE_QP(xsnegqp, OP_NEG, SGN_MASK_DP)
> +VSX_SCALAR_MOVE_QP(xscpsgnqp, OP_CPSGN, SGN_MASK_DP)
> =20
>  #define VSX_VECTOR_MOVE(name, op, sgn_mask)                      \
>  static void glue(gen_, name)(DisasContext * ctx)                 \
> diff --git a/target-ppc/translate/vsx-ops.inc.c b/target-ppc/translate/vs=
x-ops.inc.c
> index d798edb..42e83d2 100644
> --- a/target-ppc/translate/vsx-ops.inc.c
> +++ b/target-ppc/translate/vsx-ops.inc.c
> @@ -107,6 +107,7 @@ GEN_XX3FORM(xscpsgndp, 0x00, 0x16, PPC2_VSX),
>  GEN_VSX_XFORM_300_EO(xsabsqp, 0x04, 0x19, 0x00, 0x00000001),
>  GEN_VSX_XFORM_300_EO(xsnabsqp, 0x04, 0x19, 0x08, 0x00000001),
>  GEN_VSX_XFORM_300_EO(xsnegqp, 0x04, 0x19, 0x10, 0x00000001),
> +GEN_VSX_XFORM_300(xscpsgnqp, 0x04, 0x03, 0x00000001),
> =20
>  GEN_XX2FORM(xvabsdp, 0x12, 0x1D, PPC2_VSX),
>  GEN_XX2FORM(xvnabsdp, 0x12, 0x1E, PPC2_VSX),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pe+tqlI1iYzVj1X/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYSePXAAoJEGw4ysog2bOSVocP/jBpXtdlha/9pGNwwBR/nbR3
2mai1EezkQFY14xHV2izLMfqU+MbZlNySJlg9mRo6AblAlpfSC8fxLZC7XKB4w8n
DMtBUaSAbUMePAW0NR2l+Mqwf8Pun/y2DECC7FBseq4t/vzk2ZrS9wgpkeP9H8qo
DplcOpzPholtJyRGef9PGbQEoXFLGGZ4vJUF5nSfNcQuWlCbsJcK9SsXusw6L6ZL
DmdUG52ypFdSw/7+K3AJQZm2eEb9qRLlxY7n3D+6uG/2wjKolGm+RPwl7CL3Yiwc
87zcoO+c08/bHGUDcaEOs63+6Exq7AjJ46tgOl121R/tCeRcJMCk0Bzt3gnQHoxF
jZqLPg7LUDFFyGsLgpRPRxqJJJnaoZAkdZnBYDtJLTTObTRUhw9TncCeykDqm1dn
HLbq+Ck51RGpKm0zC/snt1mEwOqlt6th3EcoNQ1eNjgrmFikn1/kUjEx67AGVFqF
luDIGb6t5i0jAQGG6Hr0NW7LU/PcYNJrrjR+dDbuMRrBli72WJTt9XovKzb+/P37
yi33EzkJS0658atpqyg3p3Wc8Lx1DpIJNyHBPUqX5b9Q288eW75YXhaHLCBKCbTQ
pfEjXgEUGhO5eDCCYlfqU51h/2xHfHYoOMnO84HLctI/6uRvnlgudXX79yxqDXnd
8mJGzAROHu1fckIFQvtc
=USyV
-----END PGP SIGNATURE-----

--pe+tqlI1iYzVj1X/--
