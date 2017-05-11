Received: from eggs.gnu.org ([2001:4830:134:3::10]:57737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8dJ8-0004Tw-Si
	for qemu-devel@nongnu.org; Wed, 10 May 2017 21:54:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8dJ7-0004jW-G7
	for qemu-devel@nongnu.org; Wed, 10 May 2017 21:54:22 -0400
Date: Thu, 11 May 2017 10:41:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170511004159.GD14408@umbus.fritz.box>
References: <20170510200535.13268-1-f4bug@amsat.org>
	<20170510200535.13268-8-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7DO5AaGCk89r4vaK"
Content-Disposition: inline
In-Reply-To: <20170510200535.13268-8-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [PATCH 7/8] target/ppc: optimize various functions
 using extract op
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--7DO5AaGCk89r4vaK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 10, 2017 at 05:05:34PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Applied using Coccinelle script.
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate.c              |  9 +++------
>  target/ppc/translate/vsx-impl.inc.c | 21 +++++++--------------
>  2 files changed, 10 insertions(+), 20 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index f40b5a1abf..64ab412bf3 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -868,8 +868,7 @@ static inline void gen_op_arith_add(DisasContext *ctx=
, TCGv ret, TCGv arg1,
>              }
>              tcg_gen_xor_tl(cpu_ca, t0, t1);        /* bits changed w/ ca=
rry */
>              tcg_temp_free(t1);
> -            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);   /* extract bit 32 */
> -            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
> +            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
>              if (is_isa300(ctx)) {
>                  tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>              }
> @@ -1399,8 +1398,7 @@ static inline void gen_op_arith_subf(DisasContext *=
ctx, TCGv ret, TCGv arg1,
>              tcg_temp_free(inv1);
>              tcg_gen_xor_tl(cpu_ca, t0, t1);         /* bits changes w/ c=
arry */
>              tcg_temp_free(t1);
> -            tcg_gen_shri_tl(cpu_ca, cpu_ca, 32);    /* extract bit 32 */
> -            tcg_gen_andi_tl(cpu_ca, cpu_ca, 1);
> +            tcg_gen_extract_tl(cpu_ca, cpu_ca, 32, 1);
>              if (is_isa300(ctx)) {
>                  tcg_gen_mov_tl(cpu_ca32, cpu_ca);
>              }
> @@ -5383,8 +5381,7 @@ static void gen_mfsri(DisasContext *ctx)
>      CHK_SV;
>      t0 =3D tcg_temp_new();
>      gen_addr_reg_index(ctx, t0);
> -    tcg_gen_shri_tl(t0, t0, 28);
> -    tcg_gen_andi_tl(t0, t0, 0xF);
> +    tcg_gen_extract_tl(t0, t0, 28, 0xF);
>      gen_helper_load_sr(cpu_gpr[rd], cpu_env, t0);
>      tcg_temp_free(t0);
>      if (ra !=3D 0 && ra !=3D rd)
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index 7f12908029..354a6b113a 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1262,8 +1262,7 @@ static void gen_xsxexpqp(DisasContext *ctx)
>          gen_exception(ctx, POWERPC_EXCP_VSXU);
>          return;
>      }
> -    tcg_gen_shri_i64(xth, xbh, 48);
> -    tcg_gen_andi_i64(xth, xth, 0x7FFF);
> +    tcg_gen_extract_i64(xth, xbh, 48, 0x7FFF);
>      tcg_gen_movi_i64(xtl, 0);
>  }
> =20
> @@ -1431,10 +1430,8 @@ static void gen_xvxexpsp(DisasContext *ctx)
>          gen_exception(ctx, POWERPC_EXCP_VSXU);
>          return;
>      }
> -    tcg_gen_shri_i64(xth, xbh, 23);
> -    tcg_gen_andi_i64(xth, xth, 0xFF000000FF);
> -    tcg_gen_shri_i64(xtl, xbl, 23);
> -    tcg_gen_andi_i64(xtl, xtl, 0xFF000000FF);
> +    tcg_gen_extract_i64(xth, xbh, 23, 0xFF000000FF);
> +    tcg_gen_extract_i64(xtl, xbl, 23, 0xFF000000FF);
>  }
> =20
>  static void gen_xvxexpdp(DisasContext *ctx)
> @@ -1448,10 +1445,8 @@ static void gen_xvxexpdp(DisasContext *ctx)
>          gen_exception(ctx, POWERPC_EXCP_VSXU);
>          return;
>      }
> -    tcg_gen_shri_i64(xth, xbh, 52);
> -    tcg_gen_andi_i64(xth, xth, 0x7FF);
> -    tcg_gen_shri_i64(xtl, xbl, 52);
> -    tcg_gen_andi_i64(xtl, xtl, 0x7FF);
> +    tcg_gen_extract_i64(xth, xbh, 52, 0x7FF);
> +    tcg_gen_extract_i64(xtl, xbl, 52, 0x7FF);
>  }
> =20
>  GEN_VSX_HELPER_2(xvxsigsp, 0x00, 0x04, 0, PPC2_ISA300)
> @@ -1474,16 +1469,14 @@ static void gen_xvxsigdp(DisasContext *ctx)
>      zr =3D tcg_const_i64(0);
>      nan =3D tcg_const_i64(2047);
> =20
> -    tcg_gen_shri_i64(exp, xbh, 52);
> -    tcg_gen_andi_i64(exp, exp, 0x7FF);
> +    tcg_gen_extract_i64(exp, xbh, 52, 0x7FF);
>      tcg_gen_movi_i64(t0, 0x0010000000000000);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);
>      tcg_gen_andi_i64(xth, xbh, 0x000FFFFFFFFFFFFF);
>      tcg_gen_or_i64(xth, xth, t0);
> =20
> -    tcg_gen_shri_i64(exp, xbl, 52);
> -    tcg_gen_andi_i64(exp, exp, 0x7FF);
> +    tcg_gen_extract_i64(exp, xbl, 52, 0x7FF);
>      tcg_gen_movi_i64(t0, 0x0010000000000000);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, zr, zr, t0);
>      tcg_gen_movcond_i64(TCG_COND_EQ, t0, exp, nan, zr, t0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--7DO5AaGCk89r4vaK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZE7NVAAoJEGw4ysog2bOSEb4P/RXrcDsqUVd46HRnwWTJbBuO
5XD9frDEguIdxRXHtKvb7HGMpgpiRpge3M04qcLgcNZkaDHuhJsAV2WPLn3D15dK
NITFNAS7KozUJrWx7VVQau7NyjeIrqhhwGbR61UbEmE6IowgnhkQ12SF4EkZhs0K
ZsWgE42KDjHc3TlHQc791LEE9XgncqXIW1JhXfXHhRmVrXj0ZxGzDtoA9SNjyxw/
V75SFBnSr2dXSxh3iwWx9CD2yYHeOWD49/Azz8FLEW24EfHAub6EBBOs7oPvwnwk
oY4zFYlaK70H5VyI8JHi65U+SUR71HFbLlBtDYUeMLmg5rOKt7DfV2CEOdTaSSvV
nXfOaNFlUBpxYgE2EEO5D7iV0M9B826hFOwDqrYZCZ23uB1cgIIvEPtN/loYrh/U
CtYkCthYkNGy8qyyTiRQM6+CvuqCwb4amZO0nzmkuwfvCoxC0KwsUnzVEGUVuQe0
rvomVX/lp4wgp03IReLI+KMR4dyF5GLonNZsWPIKO8bICPosKmF7SI32i01bEdYY
bRocDPO+TfQW393Fly0qkQ7aBGnsV6lOpaJ3jFQh0oLnkHlkgMdXIlyoqRQWqUoN
QDr7Vit3dsXT/OlEwlgV85jpzqEG2lzwyjlzFANl3DziJwTUOTjUI5zXfzAX81Ra
nIa8ZTAmfXqlIjs2tebO
=V5xE
-----END PGP SIGNATURE-----

--7DO5AaGCk89r4vaK--
