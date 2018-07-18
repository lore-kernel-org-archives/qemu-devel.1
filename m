Received: from eggs.gnu.org ([2001:4830:134:3::10]:56918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ffc6h-0008Aq-KR
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 22:22:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ffc6g-0007MQ-Fb
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 22:22:23 -0400
Date: Wed, 18 Jul 2018 12:22:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180718022202.GC2102@umbus.fritz.box>
References: <1531767792-17705-1-git-send-email-yasmins@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="96YOpH+ONegL0A3E"
Content-Disposition: inline
In-Reply-To: <1531767792-17705-1-git-send-email-yasmins@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: bcdsub fix sign when result is
 zero
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yasmin Beatriz <yasmins@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, rth@twiddle.net


--96YOpH+ONegL0A3E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 16, 2018 at 07:03:12PM +0000, Yasmin Beatriz wrote:
> When the result of bcdsub is equal to zero, the result sign may be
> set to negative in some cases, and this does not follow the Power ISA
> specifications as to decimal integer arithmetic instructions.
>=20
> Signed-off-by: Yasmin Beatriz <yasmins@linux.ibm.com>

The fix looks correct, but since this has been broken forever and
we're in hard freeze I'm going to apply for 3.1, not 3.0.

Fwiw, I think the surrounding logic can probably be simplified a
little as well - I think this is now the only case with a zero result,
so I think the 'zero' local can probably be removed.

> ---
>  target/ppc/int_helper.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> index 03d37da..fa18e6e 100644
> --- a/target/ppc/int_helper.c
> +++ b/target/ppc/int_helper.c
> @@ -2747,6 +2747,9 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a,=
 ppc_avr_t *b, uint32_t ps)
>              result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgna, ps);
>              zero =3D bcd_sub_mag(&result, a, b, &invalid, &overflow);
>              cr =3D (sgna > 0) ? CRF_GT : CRF_LT;
> +        } else if (bcd_cmp_mag(a, b) =3D=3D 0) {
> +            result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(0, ps);
> +            zero =3D bcd_sub_mag(&result, b, a, &invalid, &overflow);
>          } else {
>              result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgnb, ps);
>              zero =3D bcd_sub_mag(&result, b, a, &invalid, &overflow);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--96YOpH+ONegL0A3E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltOpEgACgkQbDjKyiDZ
s5J8IBAArdfYMVMIJM8bcxLajOnc2UDPPid++W9cFXPy/FuhAUszJ0tQi98rhjiA
0V1U8k0IrqOk7EQ99ba9jjCz+iYv0ZosukwhynWnwRf11uc6jtff2oTvYSTKO9+U
QiSJj694Fu49ZSLq8PZlrjKvmvivm9QaQswOzBbE07BmAHeKZV8KeQWLU1GPZSxM
7s84HWLEQLUObigthmU8U5z4Q2Wpt630xVK3Uf/Aahns4aNhGSHUbcA3LQnNGarm
vu67lNWu8LcBqPTs9Oyh9AZ0DBepjmcYpCHJprDYo6A0/ekFxAJDWpkBbl/vpUu/
2p7G/Rm2AfsaDvHOQ7l4XLzPQ9Qqyakeg/0gZBvfuiEh2lQ3bxdbvBxqyqulFIG3
ChRGmsyXj7eg8ivLr612iSH6ykSrh7Q94Tfzoh4ZTLdus4qHx+gWF1Vb8OFPZ9C2
W3Bc7OHaFX8fmyB/8FWANogjG5n4aEIjz37j6C1i1MD7VKGiFBnknjlYyHW0Q59Y
Q/YMdRDCSeN/psOLqOsURmPajjPimg5K0F7QxsgX7W4vZAILRxRGnwA9TmNpMJ1s
VK3HTruIl4AgbMcp4/6M/E/44tziMDFPnIZubVQ4c8vcXDOK2o1t/RYrxoMmrKdA
fzOxArHAB1tkfHy6o9xkkaKFGyk96JowrQnf1QmgsrqxQ4X2XtQ=
=xmWX
-----END PGP SIGNATURE-----

--96YOpH+ONegL0A3E--
