Received: from eggs.gnu.org ([2001:4830:134:3::10]:41318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZUrs-0002IL-2H
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 00:58:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gZUro-0007M0-Rl
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 00:58:03 -0500
Date: Wed, 19 Dec 2018 16:37:07 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20181219053707.GE30570@umbus.fritz.box>
References: <20181218063911.2112-1-richard.henderson@linaro.org>
	<20181218063911.2112-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="nHwqXXcoX0o6fKCv"
Content-Disposition: inline
In-Reply-To: <20181218063911.2112-3-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH 02/34] target/arm: Rely on optimization
 within tcg_gen_gvec_or
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


--nHwqXXcoX0o6fKCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 17, 2018 at 10:38:39PM -0800, Richard Henderson wrote:
> Since we're now handling a =3D=3D b generically, we no longer need
> to do it by hand within target/arm/.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/arm/translate-a64.c |  6 +-----
>  target/arm/translate-sve.c |  6 +-----
>  target/arm/translate.c     | 12 +++---------
>  3 files changed, 5 insertions(+), 19 deletions(-)
>=20
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index e1da1e4d6f..2d6f8c1b4f 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -10152,11 +10152,7 @@ static void disas_simd_3same_logic(DisasContext =
*s, uint32_t insn)
>          gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_andc, 0);
>          return;
>      case 2: /* ORR */
> -        if (rn =3D=3D rm) { /* MOV */
> -            gen_gvec_fn2(s, is_q, rd, rn, tcg_gen_gvec_mov, 0);
> -        } else {
> -            gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_or, 0);
> -        }
> +        gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_or, 0);
>          return;
>      case 3: /* ORN */
>          gen_gvec_fn3(s, is_q, rd, rn, rm, tcg_gen_gvec_orc, 0);
> diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
> index b15b615ceb..3a2eb51566 100644
> --- a/target/arm/translate-sve.c
> +++ b/target/arm/translate-sve.c
> @@ -280,11 +280,7 @@ static bool trans_AND_zzz(DisasContext *s, arg_rrr_e=
sz *a)
> =20
>  static bool trans_ORR_zzz(DisasContext *s, arg_rrr_esz *a)
>  {
> -    if (a->rn =3D=3D a->rm) { /* MOV */
> -        return do_mov_z(s, a->rd, a->rn);
> -    } else {
> -        return do_vector3_z(s, tcg_gen_gvec_or, 0, a->rd, a->rn, a->rm);
> -    }
> +    return do_vector3_z(s, tcg_gen_gvec_or, 0, a->rd, a->rn, a->rm);
>  }
> =20
>  static bool trans_EOR_zzz(DisasContext *s, arg_rrr_esz *a)
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index 7c4675ffd8..33b1860148 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -6294,15 +6294,9 @@ static int disas_neon_data_insn(DisasContext *s, u=
int32_t insn)
>                  tcg_gen_gvec_andc(0, rd_ofs, rn_ofs, rm_ofs,
>                                    vec_size, vec_size);
>                  break;
> -            case 2:
> -                if (rn =3D=3D rm) {
> -                    /* VMOV */
> -                    tcg_gen_gvec_mov(0, rd_ofs, rn_ofs, vec_size, vec_si=
ze);
> -                } else {
> -                    /* VORR */
> -                    tcg_gen_gvec_or(0, rd_ofs, rn_ofs, rm_ofs,
> -                                    vec_size, vec_size);
> -                }
> +            case 2: /* VORR */
> +                tcg_gen_gvec_or(0, rd_ofs, rn_ofs, rm_ofs,
> +                                vec_size, vec_size);
>                  break;
>              case 3: /* VORN */
>                  tcg_gen_gvec_orc(0, rd_ofs, rn_ofs, rm_ofs,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--nHwqXXcoX0o6fKCv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlwZ2QMACgkQbDjKyiDZ
s5Ipxg//TgsfStEQoBC7NVK32bPTeN+RU4S2wvT01zPR+6vCeYYiKA/KEf70g2GY
PUHqU2rujVeZckynCuAeQElcX91yTt0pn/Y+rbh2YUc9tDw+AHz4hYXL1yv1/qf+
qdy6hByO3423fDxCxHktggxzgMA0/Prw+Mlx3YJknBJHXWixfl5Y+yUULloOLqIa
uhbXXhpVc6N9uoJb+zhw8SBeOF8M6j7qzGHSJW6E30ZrM5pbqb1GU51uzJpE369x
amAzRZVzcBf+ZU+6OgjlXHoQg44775asq7UB8ctysXNqKij2CxdgEs+ukO3J/ZW8
0MNZ1XVGOuNHnG7Fk3LcugvEVczhLPoiLB/FRmkeK/xWL1PHosp4PKFlM9DV8GFt
/6Hk91EByOo8wHx4juJdaDaL+CqlqBEEYqTAf8POqgKFC1GieCSo84Y76tMzjvbu
eBZuolwtO9Ye2ajXb3ixWK06MwrCoO84oFgfwawVLcujOcUDwsAg8I2uM8TD2Isl
UqYWsVesfTCU23G9N0hII94EhAibEvdYkUm+2wM32UNaycWfJlxWDq/e133OyQWC
DksrrIgewZJVMAqPB9xbY6Lw26AtcYNogMUAFfOzoSoPSgd8ao03w3B9d/jiqIzv
SrcY5D9zIR4Z/4ErGa06yUjRTZ03Zuopi24MgoA35lz6jxjqgwI=
=UCj1
-----END PGP SIGNATURE-----

--nHwqXXcoX0o6fKCv--
