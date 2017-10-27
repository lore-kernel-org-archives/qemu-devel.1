Received: from eggs.gnu.org ([2001:4830:134:3::10]:57939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e8CcH-00029X-R4
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 17:56:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e8CcG-0001zs-JW
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 17:56:37 -0400
Date: Fri, 27 Oct 2017 23:45:42 +0200
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171027214542.GG7115@umbus>
References: <20171027165814.29122-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="gvF4niNJ+uBMJnEh"
Content-Disposition: inline
In-Reply-To: <20171027165814.29122-1-richard.henderson@linaro.org>
Subject: Re: [Qemu-devel] [PATCH v2] target/ppc: Use
 tcg_gen_lookup_and_goto_ptr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Richard Henderson <rth@twiddle.net>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 27, 2017 at 06:58:14PM +0200, Richard Henderson wrote:
> From: Richard Henderson <rth@twiddle.net>
>=20
> Signed-off-by: Richard Henderson <rth@twiddle.net>

Applied,thanks.

> ---
> Rebased and updated for changes to tcg_gen_lookup_and_goto_ptr.
>=20
> ---
>  target/ppc/translate.c | 23 ++++++++---------------
>  1 file changed, 8 insertions(+), 15 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 998fbed848..4075fc8589 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -3419,7 +3419,7 @@ static inline bool use_goto_tb(DisasContext *ctx, t=
arget_ulong dest)
>  }
> =20
>  /***                                Branch                              =
   ***/
> -static inline void gen_goto_tb(DisasContext *ctx, int n, target_ulong de=
st)
> +static void gen_goto_tb(DisasContext *ctx, int n, target_ulong dest)
>  {
>      if (NARROW_MODE(ctx)) {
>          dest =3D (uint32_t) dest;
> @@ -3441,7 +3441,7 @@ static inline void gen_goto_tb(DisasContext *ctx, i=
nt n, target_ulong dest)
>                  gen_debug_exception(ctx);
>              }
>          }
> -        tcg_gen_exit_tb(0);
> +        tcg_gen_lookup_and_goto_ptr();
>      }
>  }
> =20
> @@ -3479,7 +3479,7 @@ static void gen_b(DisasContext *ctx)
>  #define BCOND_CTR 2
>  #define BCOND_TAR 3
> =20
> -static inline void gen_bcond(DisasContext *ctx, int type)
> +static void gen_bcond(DisasContext *ctx, int type)
>  {
>      uint32_t bo =3D BO(ctx->opcode);
>      TCGLabel *l1;
> @@ -3543,26 +3543,19 @@ static inline void gen_bcond(DisasContext *ctx, i=
nt type)
>          } else {
>              gen_goto_tb(ctx, 0, li);
>          }
> -        if ((bo & 0x14) !=3D 0x14) {
> -            gen_set_label(l1);
> -            gen_goto_tb(ctx, 1, ctx->nip);
> -        }
>      } else {
>          if (NARROW_MODE(ctx)) {
>              tcg_gen_andi_tl(cpu_nip, target, (uint32_t)~3);
>          } else {
>              tcg_gen_andi_tl(cpu_nip, target, ~3);
>          }
> -        tcg_gen_exit_tb(0);
> -        if ((bo & 0x14) !=3D 0x14) {
> -            gen_set_label(l1);
> -            gen_update_nip(ctx, ctx->nip);
> -            tcg_gen_exit_tb(0);
> -        }
> -    }
> -    if (type =3D=3D BCOND_LR || type =3D=3D BCOND_CTR || type =3D=3D BCO=
ND_TAR) {
> +        tcg_gen_lookup_and_goto_ptr();
>          tcg_temp_free(target);
>      }
> +    if ((bo & 0x14) !=3D 0x14) {
> +        gen_set_label(l1);
> +        gen_goto_tb(ctx, 1, ctx->nip);
> +    }
>  }
> =20
>  static void gen_bc(DisasContext *ctx)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnzqQMACgkQbDjKyiDZ
s5KhihAAiA7DQ2ru6yyQzuvYX+fSAI8D4F1cTOln3ET9A/k1+w++axsnvEZ0/wiL
zXdB1I+cIV9G9Sw/kynp7eZmfsMLRgUUhjHoa/k3EpnBaxmTHsaItt0fMTSpc2Jd
mt4wbEHSzRqh0eiBPpb9/RDKQngFFWye2RDKo0pepO3wLmGngW6zirD2iVq5m9Bs
CKAbTQX8OHh4MxKdijn6GmQct3/fb/G4zRhhFjV1cFXH7MbgTtC56lZCAcrsh1Xa
ZGS6ItH304k1+tbMDZvZIwbAufOk6Gh5TYfONWYrX+Gdlfrd8BRjNpBuBdWueYhn
97RkP/vjq9XyUvLFZJpfUjtv6PigiHocfebbHdJOb7vmzd+lfUks+BZL6CPWnjg6
a/bWYYNX7oNOWCh4Ba43uhIjEiG3qebtDCrTzB4Qi3vgYgaY018iwg+R080bvEhx
TB30XLBr+CSD7vsL7QE/4ZWqxUOa0R2LOKe0Z9KAlnmY7ZiUlTOBIHkzLSnksSE7
zGE7yY38h9pq+7xZ9yk47ZvEZ2Ax3hGg1QEiNflCgKXSmcmuWlev7bOsJkoLVz8y
spo7GLaXE1l/96wkw+P8mrnMKSukMrvIOTFcngqZ/daQRA+m1X/fjB2xNOfMAoFS
owYccfSsv/d0IkP0AXp7cMiv+RzzZPL9Z4I/jozb+LgQMDJSurc=
=S86k
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
