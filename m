Received: from eggs.gnu.org ([2001:4830:134:3::10]:54062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV6GU-0003mQ-HX
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 22:21:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fV6GR-0006Kr-Dv
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 22:21:02 -0400
Date: Tue, 19 Jun 2018 12:20:49 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180619022049.GA11674@umbus.fritz.box>
References: <20180618155024.1942-1-programmingkidx@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20180618155024.1942-1-programmingkidx@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2] fpu_helper.c: fix helper_fpscr_clrbit()
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Arbuckle <programmingkidx@gmail.com>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org, aurelien@aurel32.net, qemu-ppc@nongnu.org, agraf@suse.de


--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 18, 2018 at 11:50:24AM -0400, John Arbuckle wrote:
> Fix the helper_fpscr_clrbit() function so it correctly
> sets the FEX and VX bits.
>=20
> Determining the value for the Floating Point Status and Control
> Register's (FPSCR) FEX bit is suppose to be done like this:
>=20
> FEX =3D (VX & VE) | (OX & OE) | (UX & UE) | (ZX & ZE) | (XX & XE))
>=20
> It is described as "the logical OR of all the floating-point exception bi=
ts
> masked by their respective enable bits". It was not implemented correctly=
=2E The value of FEX would stay on even when all other bits were set to off.
>=20
> The VX bit is described as "the logical OR of all of the invalid operatio=
n exceptions". This bit was also not implemented correctly. It too would st=
ay
> on when all the other bits were set to off.
>=20
> My main source of information is an IBM document called:=20
>=20
> PowerPC Microprocessor Family:
> The Programming Environments for 32-Bit Microprocessors
>=20
> Page 62 is where the FPSCR information is located.
>=20
> This is an older copy than the one I use but it is still very useful:
> https://www.pdfdrive.net/powerpc-microprocessor-family-the-programming-en=
vironments-for-32-e3087633.html
>=20
> I use a G3 and G5 iMac to compare bit values with QEMU. This patch fixed =
all the problems I was having with these bits.
>=20
> Signed-off-by: John Arbuckle <programmingkidx@gmail.com>
> ---
> v2 changes:
> - Removed the FPSCR_VX case because it is not a bit that can be set direc=
tly.
> - Replaced previous code with predefined macros fpscr_ix and
> fpscr_eex.

Thanks for the updated version, this is much easier to review.

This is definitely better than what we have, and I've applied it to
ppc-for-3.0.  The existing code is pretty eye-watering, and longer
term I do wonder if it would be better to just compute the VX and FEX
bits when we actually read the fpscr, rather than incrementally.

I think there's also one case you've missed..

>=20
>  target/ppc/fpu_helper.c | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>=20
> diff --git a/target/ppc/fpu_helper.c b/target/ppc/fpu_helper.c
> index d31a933cbb..7714bfe0f9 100644
> --- a/target/ppc/fpu_helper.c
> +++ b/target/ppc/fpu_helper.c
> @@ -325,6 +325,34 @@ void helper_fpscr_clrbit(CPUPPCState *env, uint32_t =
bit)
>          case FPSCR_RN:
>              fpscr_set_rounding_mode(env);
>              break;
> +        case FPSCR_VXSNAN:
> +        case FPSCR_VXISI:
> +        case FPSCR_VXIDI:
> +        case FPSCR_VXZDZ:
> +        case FPSCR_VXIMZ:
> +        case FPSCR_VXVC:
> +        case FPSCR_VXSOFT:
> +        case FPSCR_VXSQRT:
> +        case FPSCR_VXCVI:
> +            if (!fpscr_ix) {
> +                /* Set VX bit to zero */
> +                env->fpscr &=3D ~(1 << FPSCR_VX);
> +            }

This can clear the VX bit, which could affect the expected value of
the FEX bit, but you won't actually recompute it in that case.

> +            break;
> +        case FPSCR_OX:
> +        case FPSCR_UX:
> +        case FPSCR_ZX:
> +        case FPSCR_XX:
> +        case FPSCR_VE:
> +        case FPSCR_OE:
> +        case FPSCR_UE:
> +        case FPSCR_ZE:
> +        case FPSCR_XE:
> +            if (!fpscr_eex) {
> +                /* Set the FEX bit */
> +                env->fpscr &=3D ~(1 << FPSCR_FEX);
> +            }
> +            break;
>          default:
>              break;
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2oS5YaxWCcQjTEyO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsoaH8ACgkQbDjKyiDZ
s5I7tA/8DFfFP75FnwWdFGkGnI/QZ/FcYImmbfknaGRrzq8RzeCiKDZ5mIEaxjct
XJ/rHqo2hK80Zxung8qTUa/7erkLUc92U6l6ehB5ma5ZZWDZJLE4XTYhwRsjq7xU
NSXNeE+knc/EtcOGwBdEptpze++3HnUzun0XCIucpHPIQO9MEXik1GikpclE+MeK
wwMcTiw4kimRoStDy8q/h9lk1gG9/Ua2mdMvneClNEsV9JcP9LKmdztr+bAzVHYv
NMs1oinJX6VaCtVpesfhKgJcl6/9PDGHTPCGqpGldMlnCn5kmTZm6u9+V/+9o7hX
lh2O576AbXvuchRBnjMQ3QWgd5DV7cAxIy4Yo6qeQON2zYSM2kJctig+vCZSArY0
GSC2YwObpmRfDm40idZj+OaP5UHv2KGaWn6qlhraTLjISM5uvQUvhuShwGivBZzK
irTIzvqUvXTizxBlXzqorzdS8HD2amx8w8iuxl5sewKpDiw5MsPcwmyd1gEaCWz8
fouyzgVs0tlvsvRIddN9xw1HeruFOWAUx0AIEjV0fm2RIOX9gciwotL5xlHEw4y3
uFuc7GUF6C491zc8MkI6SY6D0r3sYLv5/nLsQNzwX81IBk6eJl3vlXvb8H9E/jih
nnI1g3U7Jkap8dsxeLPweHW3Azw7iGg7ztqzEC38Gf+DxbDcLgs=
=6Egs
-----END PGP SIGNATURE-----

--2oS5YaxWCcQjTEyO--
