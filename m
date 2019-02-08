Received: from eggs.gnu.org ([209.51.188.92]:42341)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grzT1-0003BR-M9
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:16:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grzSz-0004yq-RW
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:16:51 -0500
Date: Fri, 8 Feb 2019 16:34:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190208053417.GB12810@umbus.fritz.box>
References: <20190126150102.7AABC74569F@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline
In-Reply-To: <20190126150102.7AABC74569F@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Fix msync to do what hardware
 does
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 26, 2019 at 03:50:28PM +0100, BALATON Zoltan wrote:
> According to BookE docs, invalid bits (while undefined behaviour) should
> not raise exception but be ignored. This seems to be implementation
> dependent though and QEMU currently does what e500 CPUs do and raise
> exception for invalid bits. Unfortunately some versions of libstdc++
> (and so all programs compiled with it) have lwsync on PPC440 which is
> invalid but on real hardware it's just executed as msync ignoring the
> invalid bits (maybe that's why it got undetected) but they fail on QEMU.
> This patch changes invalid mask of msync to allow these programs to run
> but keep generating exception on e500 cores to follow what hardware does.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Applied to ppc-for-4.0, thanks.

> ---
>  target/ppc/translate.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index e169c43643..5429ceb1ab 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -6476,7 +6476,12 @@ static void gen_mbar(DisasContext *ctx)
>  /* msync replaces sync on 440 */
>  static void gen_msync_4xx(DisasContext *ctx)
>  {
> -    /* interpreted as no-op */
> +    /* Only e500 seems to treat reserved bits as invalid */
> +    if ((ctx->insns_flags2 & PPC2_BOOKE206) &&
> +        (ctx->opcode & 0x03FFF801)) {
> +        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);
> +    }
> +    /* otherwise interpreted as no-op */
>  }
> =20
>  /* icbt */
> @@ -7054,11 +7059,11 @@ GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01,=
 PPC_WRTEE),
>  GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
>  GEN_HANDLER_E(mbar, 0x1F, 0x16, 0x1a, 0x001FF801,
>                PPC_BOOKE, PPC2_BOOKE206),
> -GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x03FFF801, PPC_BOOKE),
> +GEN_HANDLER(msync_4xx, 0x1F, 0x16, 0x12, 0x039FF801, PPC_BOOKE),
>  GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
>                 PPC_BOOKE, PPC2_BOOKE206),
>  GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
> -               PPC_440_SPEC),
> +             PPC_440_SPEC),
>  GEN_HANDLER(lvsl, 0x1f, 0x06, 0x00, 0x00000001, PPC_ALTIVEC),
>  GEN_HANDLER(lvsr, 0x1f, 0x06, 0x01, 0x00000001, PPC_ALTIVEC),
>  GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BwCQnh7xodEAoBMC
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxdFNkACgkQbDjKyiDZ
s5Lf0RAAnkC+da40G8+wVrf07kdbnviRc36x+6aXOLOQxUh/h9rCmsQpDrwIzIB9
iCGE6cd8uK2jNBHQiy2a7me9WYSEYOIgQ5hXdh2r//gKY248NwxYkopYvhdljsJ0
52l3mqjsfq4yQrdBwIHx+aZxX0Xype46EqTMLAAOaqfBjstvYRLaTKYfFu4mq6pb
JuASYUhsOfRoi8CzKOg9+PvfuYD2TorNVuRhx9Vjnw6ShBmRJlnxK9YiGcenoyLG
RNlIDY7m0aKESDNTfR4/r75dureNqpvMsLvXSL4wMtzKn7yEBKJG6YehQwaIFE05
jnwdanR8VwaBsMX7TDPEoiISfTmhf/6/nW44OL3y0D857/oqVN6YhHxJLd7zW3Ht
wL+QGtiLrLKB4ievflwlGZND7o0VbVC2r63ZddmomER4EcN9HKdQfCWjcBdiiP6W
tU7d/79IjWwIkvjxgqqgvBAPSOT9ddu21M9UrbnZDdnNcjkvuYfndcsbzxVI+Ny4
zoD9rk0OQPIBRQjLXDUyaYpCKiA7AKTlJDWP/BBqc+4IzoQZPliLtyLW8MZm3O25
c4pU/Yr9HmxeL4R2qB/oQ/SNobZPkD8MXYiDd0Bf/ccaC0DCy88EApzzDwsvl6MM
IqCIJGa1BWNWmM+lVXDxLccE9Fw6dG2eZwIIAewVhqg/DDUYswk=
=W8nt
-----END PGP SIGNATURE-----

--BwCQnh7xodEAoBMC--
