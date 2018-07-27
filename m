Received: from eggs.gnu.org ([2001:4830:134:3::10]:36385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fiqvx-0005Bf-Qp
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 20:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fiqvu-00050Z-OG
	for qemu-devel@nongnu.org; Thu, 26 Jul 2018 20:48:41 -0400
Date: Fri, 27 Jul 2018 10:48:26 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180727004826.GA3694@umbus.fritz.box>
References: <1532434384-12355-1-git-send-email-yasmins@linux.ibm.com>
	<20180726014020.GJ6830@umbus.fritz.box>
	<20180726194443.dnw75xlfjjtzcarm@yasmins-ThinkPad-T460>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20180726194443.dnw75xlfjjtzcarm@yasmins-ThinkPad-T460>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: simplify bcdadd/sub functions
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


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 26, 2018 at 04:44:43PM -0300, Yasmin Beatriz wrote:
> On Thu, Jul 26, 2018 at 11:40:20AM +1000, David Gibson wrote:
> > On Tue, Jul 24, 2018 at 12:13:04PM +0000, Yasmin Beatriz wrote:
> > > After solving a corner case in bcdsub, this patch simplifies the logic
> > > of both bcdadd/sub instructions by removing some unnecessary local fl=
ags.
> > >=20
> > > Signed-off-by: Yasmin Beatriz <yasmins@linux.ibm.com>
> > > ---
> > >  target/ppc/int_helper.c | 33 +++++++++------------------------
> > >  1 file changed, 9 insertions(+), 24 deletions(-)
> > >=20
> > > diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
> > > index fa18e6e..b8ac4bb 100644
> > > --- a/target/ppc/int_helper.c
> > > +++ b/target/ppc/int_helper.c
> > > @@ -2671,16 +2671,14 @@ static int bcd_cmp_mag(ppc_avr_t *a, ppc_avr_=
t *b)
> > >      return 0;
> > >  }
> > > =20
> > > -static int bcd_add_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int=
 *invalid,
> > > +static void bcd_add_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, in=
t *invalid,
> > >                         int *overflow)
> > >  {
> > >      int carry =3D 0;
> > >      int i;
> > > -    int is_zero =3D 1;
> > >      for (i =3D 1; i <=3D 31; i++) {
> > >          uint8_t digit =3D bcd_get_digit(a, i, invalid) +
> > >                          bcd_get_digit(b, i, invalid) + carry;
> > > -        is_zero &=3D (digit =3D=3D 0);
> > >          if (digit > 9) {
> > >              carry =3D 1;
> > >              digit -=3D 10;
> > > @@ -2689,26 +2687,20 @@ static int bcd_add_mag(ppc_avr_t *t, ppc_avr_=
t *a, ppc_avr_t *b, int *invalid,
> > >          }
> > > =20
> > >          bcd_put_digit(t, digit, i);
> > > -
> > > -        if (unlikely(*invalid)) {
> > > -            return -1;
> > > -        }
> > >      }
> > > =20
> > >      *overflow =3D carry;
> > > -    return is_zero;
> > >  }
> > > =20
> > > -static int bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, int=
 *invalid,
> > > +static void bcd_sub_mag(ppc_avr_t *t, ppc_avr_t *a, ppc_avr_t *b, in=
t *invalid,
> > >                         int *overflow)
> > >  {
> > >      int carry =3D 0;
> > >      int i;
> > > -    int is_zero =3D 1;
> > > +
> > >      for (i =3D 1; i <=3D 31; i++) {
> > >          uint8_t digit =3D bcd_get_digit(a, i, invalid) -
> > >                          bcd_get_digit(b, i, invalid) + carry;
> > > -        is_zero &=3D (digit =3D=3D 0);
> > >          if (digit & 0x80) {
> > >              carry =3D -1;
> > >              digit +=3D 10;
> > > @@ -2717,14 +2709,9 @@ static int bcd_sub_mag(ppc_avr_t *t, ppc_avr_t=
 *a, ppc_avr_t *b, int *invalid,
> > >          }
> > > =20
> > >          bcd_put_digit(t, digit, i);
> > > -
> > > -        if (unlikely(*invalid)) {
> > > -            return -1;
> > > -        }
> > >      }
> > > =20
> > >      *overflow =3D carry;
> > > -    return is_zero;
> > >  }
> > > =20
> > >  uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t *a, ppc_avr_t *b, ui=
nt32_t ps)
> > > @@ -2734,25 +2721,25 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr=
_t *a, ppc_avr_t *b, uint32_t ps)
> > >      int sgnb =3D bcd_get_sgn(b);
> > >      int invalid =3D (sgna =3D=3D 0) || (sgnb =3D=3D 0);
> > >      int overflow =3D 0;
> > > -    int zero =3D 0;
> > >      uint32_t cr =3D 0;
> > >      ppc_avr_t result =3D { .u64 =3D { 0, 0 } };
> > > =20
> > >      if (!invalid) {
> > >          if (sgna =3D=3D sgnb) {
> > >              result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgna, p=
s);
> > > -            zero =3D bcd_add_mag(&result, a, b, &invalid, &overflow);
> > > -            cr =3D (sgna > 0) ? CRF_GT : CRF_LT;
> > > +            bcd_add_mag(&result, a, b, &invalid, &overflow);
> > > +            cr =3D bcd_cmp_zero(&result);
> > >          } else if (bcd_cmp_mag(a, b) > 0) {
> > >              result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgna, p=
s);
> > > -            zero =3D bcd_sub_mag(&result, a, b, &invalid, &overflow);
> > > +            bcd_sub_mag(&result, a, b, &invalid, &overflow);
> > >              cr =3D (sgna > 0) ? CRF_GT : CRF_LT;
> > >          } else if (bcd_cmp_mag(a, b) =3D=3D 0) {
> > >              result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(0, ps);
> > > -            zero =3D bcd_sub_mag(&result, b, a, &invalid, &overflow);
> > > +            bcd_sub_mag(&result, b, a, &invalid, &overflow);
> >=20
> > I don't think you actually need the sub here, since you know the
> > result is going to be zero.
>=20
> Right. Will fix this in v2.
>=20
> > Although.. in all of the different-sign cases aren't we effectively
> > doing the subtraction twice - once in bcd_cmp_mag() then again in
> > bcd_sub_mag()?
>=20
> Actually no, bcd_cmp_mag() compares the magnitude between 'a' and 'b'
> starting from the most significant digit and returns as soon as it finds
> a difference between the two of them. It helps to decide whether we're
> going to perform a - b or b - a.

Ah, good point.

> Anyway, I think the following code can make it easier to understand:
>=20
> int magnitude;
> if (sgna =3D=3D sgnb) {
>     // same thing
> } else {
>     magnitude =3D bdc_cmp_mag(a, b);
>     if (magnitude > 0) {
>         // do a - b
>     } else if (magnitude < 0) {
>         // do b - a
>     } else {
>         // 0
>     }
> }

Yes, I think that's a good idea.

>=20
> > > +            cr =3D CRF_EQ;
> > >          } else {
> > >              result.u8[BCD_DIG_BYTE(0)] =3D bcd_preferred_sgn(sgnb, p=
s);
> > > -            zero =3D bcd_sub_mag(&result, b, a, &invalid, &overflow);
> > > +            bcd_sub_mag(&result, b, a, &invalid, &overflow);
> > >              cr =3D (sgnb > 0) ? CRF_GT : CRF_LT;
> > >          }
> > >      }
> > > @@ -2762,8 +2749,6 @@ uint32_t helper_bcdadd(ppc_avr_t *r,  ppc_avr_t=
 *a, ppc_avr_t *b, uint32_t ps)
> > >          cr =3D CRF_SO;
> > >      } else if (overflow) {
> > >          cr |=3D CRF_SO;
> > > -    } else if (zero) {
> > > -        cr =3D CRF_EQ;
> > >      }
> > > =20
> > >      *r =3D result;
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltaa9oACgkQbDjKyiDZ
s5IhIA/+PS7XwUHnRwrV3nA8tw+2pVvfsOk2NhEuIYIW0O8HeTiE4PDju9fe9YaU
07murf5RrqJ1t576Orvr/e4XBew/dFH/O8z8LvyP+mHdiHvwrzhsCHMsXozNsVGy
bXZczM8Wu3bG9UG84/Zzw6fdGwQJoogbXjWtI6sS/xQq7BneEaeM6tx7of0CLd8I
2tgECgCu2aa5AMlrtREMbKY6z/JtJYbZxik2ddQQft01KwiVuXNCMFrajDBIA9ZV
VilQLjwqy5g9bqbfYVypcTw8LbEqjWzGBvKcRsrkUdRWz/Ml4+y8HH67ySyrFYrg
mAR7Pjs1FRfRxRCaEHGV1nINtXQr7mViam0qDZduRtQEibjsM2iCYcBy5u/8DKpx
Bu44u+Yi/lzLoVHiSCeEAjMYJl2+psO69TwzjTJqn9tI3CZ0KxqUHbJJxqIh0buT
3/yeMfeUhdo/k0xU6GHy44CtQQutvbKAtm91KQBog9/elFIpoPTP0v0EgVj5Vnko
tf9kpdSLMmQ6Kv05MPZY3Et6af0XWUI/YBE7s8+g3Uq++KLi2HsdlOv0gmvmIZYd
lSWPVix2pby2QzAw8DdbWtgwx1G3mrl3G65dDF4iTShBgDxxKb5OMOC+RgW1E2Yw
GXQ1AlL+UPAx2YUaW+3Jk+otuTHeIqquw7uTlqYXH6ws2bDfylc=
=tUeN
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
