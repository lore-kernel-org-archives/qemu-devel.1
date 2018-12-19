Received: from eggs.gnu.org ([2001:4830:134:3::10]:41802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbn-0001yp-BH
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZWbk-0005uN-Aq
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 02:49:35 -0500
Date: Wed, 19 Dec 2018 17:35:58 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219063558.GU30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-26-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kSOhxpxUsM1s2qz/"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-26-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 25/34] target/ppc: convert xxsel to vector
 operations
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


--kSOhxpxUsM1s2qz/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:39:02PM -0800, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/translate/vsx-impl.inc.c | 55 ++++++++++++++---------------
>  1 file changed, 27 insertions(+), 28 deletions(-)
>=20
> diff --git a/target/ppc/translate/vsx-impl.inc.c b/target/ppc/translate/v=
sx-impl.inc.c
> index a040038ed4..dc32471cd7 100644
> --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -1280,40 +1280,39 @@ static void glue(gen_, name)(DisasContext * ctx) =
           \
>  VSX_XXMRG(xxmrghw, 1)
>  VSX_XXMRG(xxmrglw, 0)
> =20
> +static void xxsel_i64(TCGv_i64 t, TCGv_i64 a, TCGv_i64 b, TCGv_i64 c)
> +{
> +    tcg_gen_and_i64(b, b, c);
> +    tcg_gen_andc_i64(a, a, c);
> +    tcg_gen_or_i64(t, a, b);
> +}
> +
> +static void xxsel_vec(unsigned vece, TCGv_vec t, TCGv_vec a,
> +                      TCGv_vec b, TCGv_vec c)
> +{
> +    tcg_gen_and_vec(vece, b, b, c);
> +    tcg_gen_andc_vec(vece, a, a, c);
> +    tcg_gen_or_vec(vece, t, a, b);
> +}
> +
>  static void gen_xxsel(DisasContext * ctx)
>  {
> -    TCGv_i64 a, b, c, tmp;
> +    static const GVecGen4 g =3D {
> +        .fni8 =3D xxsel_i64,
> +        .fniv =3D xxsel_vec,
> +        .vece =3D MO_64,
> +    };
> +    int rt =3D xT(ctx->opcode);
> +    int ra =3D xA(ctx->opcode);
> +    int rb =3D xB(ctx->opcode);
> +    int rc =3D xC(ctx->opcode);
> +
>      if (unlikely(!ctx->vsx_enabled)) {
>          gen_exception(ctx, POWERPC_EXCP_VSXU);
>          return;
>      }
> -    a =3D tcg_temp_new_i64();
> -    b =3D tcg_temp_new_i64();
> -    c =3D tcg_temp_new_i64();
> -    tmp =3D tcg_temp_new_i64();
> -
> -    get_cpu_vsrh(a, xA(ctx->opcode));
> -    get_cpu_vsrh(b, xB(ctx->opcode));
> -    get_cpu_vsrh(c, xC(ctx->opcode));
> -
> -    tcg_gen_and_i64(b, b, c);
> -    tcg_gen_andc_i64(a, a, c);
> -    tcg_gen_or_i64(tmp, a, b);
> -    set_cpu_vsrh(xT(ctx->opcode), tmp);
> -
> -    get_cpu_vsrl(a, xA(ctx->opcode));
> -    get_cpu_vsrl(b, xB(ctx->opcode));
> -    get_cpu_vsrl(c, xC(ctx->opcode));
> -
> -    tcg_gen_and_i64(b, b, c);
> -    tcg_gen_andc_i64(a, a, c);
> -    tcg_gen_or_i64(tmp, a, b);
> -    set_cpu_vsrl(xT(ctx->opcode), tmp);
> -
> -    tcg_temp_free_i64(a);
> -    tcg_temp_free_i64(b);
> -    tcg_temp_free_i64(c);
> -    tcg_temp_free_i64(tmp);
> +    tcg_gen_gvec_4(vsr_full_offset(rt), vsr_full_offset(ra),
> +                   vsr_full_offset(rb), vsr_full_offset(rc), 16, 16, &g);
>  }
> =20
>  static void gen_xxspltw(DisasContext *ctx)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kSOhxpxUsM1s2qz/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ5s0ACgkQbDjKyiDZ
s5IbbBAAqRbhNqy6OM6xuGc4ZSS7PmEEPUMd/yNV3o/AzGUiQBXOBBkxAKptadZG
57tooCdRdanT1c+w7MqiqT3z6WbWXkKfUQyVw2nLfrDMFxnHzYgu+Y+yhCChy2jH
vE5rJKhofWZcUBQmdhVR/f9paz8gvIsxO0cExpacUEO9tVl/ZNxMrRUTZ2p25VUs
4yoVwQez3ZXzjJQUF5NKODG7YmV3RKzTlJEjNBcbDwJGkg0puFlWvjZ8elAt3bTa
n2k4JnMWbVIMm5iNZptqT9h55WWZrEP3vaCZu3vIDO+tEbvSBPaFTCSVEpX1I38H
XokEpz6bXbjGHdP7xionB5WyXDqin53AYPMEGkAtUi4qGBIGQYtVzKSkeavqEF4x
kIWnOJHpxrjkIzv2GgZFgDFosBvHoFSqCRfdUKn/ELbVznxSBeynkfrUNlDitOKc
azv9tXLW7Yc9vynXzf6NY2UGj29ODQUi5wyVWddqNHOZEchc1Wn2zL4FwT23gM/S
0jI6g0uNAjb3JW0kAQzMyIaf1XF4bExqE+ojkUAb3X861nqTPYgIapDCtg0anpN4
c/A4cjdacrd4i/poqrNHJ3F9c5VYCxmUHu8EFugOW1YFKhvu9yTq9xOMxg2iQQk+
UzZ+4k05oj8Kt+MdnYdD9GipA7IQqcri8LQ4IMiMqrhSIiccT4M=
=+HyR
-----END PGP SIGNATURE-----

--kSOhxpxUsM1s2qz/--
