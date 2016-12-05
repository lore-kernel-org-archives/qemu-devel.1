Received: from eggs.gnu.org ([2001:4830:134:3::10]:39213)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cE3GI-00041s-MI
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 19:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cE3GH-0001Ba-Dw
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 19:05:34 -0500
Date: Tue, 6 Dec 2016 09:59:37 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20161205225937.GM32366@umbus.fritz.box>
References: <1480741206-32737-1-git-send-email-joserz@linux.vnet.ibm.com>
	<1480741206-32737-3-git-send-email-joserz@linux.vnet.ibm.com>
	<aadc15aa-9063-b549-ee5c-0c88159883a5@twiddle.net>
	<20161205015639.GB12426@umbus.fritz.box>
	<20161205093539.GA16556@pacoca>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="dp9QYJgVRVEW2bsm"
Content-Disposition: inline
In-Reply-To: <20161205093539.GA16556@pacoca>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 2/7] target-ppc: Implement
 unsigned quadword left/right shift and unit tests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: joserz@linux.vnet.ibm.com
Cc: Richard Henderson <rth@twiddle.net>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, bharata@linux.vnet.ibm.com


--dp9QYJgVRVEW2bsm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 07:35:39AM -0200, joserz@linux.vnet.ibm.com wrote:
> On Mon, Dec 05, 2016 at 12:56:39PM +1100, David Gibson wrote:
> > On Sat, Dec 03, 2016 at 05:37:27PM -0800, Richard Henderson wrote:
> > > On 12/02/2016 09:00 PM, Jose Ricardo Ziviani wrote:
> > > > +++ b/include/qemu/host-utils.h
> > > > @@ -29,6 +29,33 @@
> > > >  #include "qemu/bswap.h"
> > > >=20
> > > >  #ifdef CONFIG_INT128
> > > > +static inline void urshift(uint64_t *plow, uint64_t *phigh, uint32=
_t shift)
> > > > +{
> > > > +    __uint128_t val =3D ((__uint128_t)*phigh << 64) | *plow;
> > > > +    val >>=3D (shift & 127);
> > > > +    *phigh =3D val >> 64;
> > > > +    *plow =3D val & 0xffffffffffffffff;
> > > > +}
> > > > +
> > > > +static inline void ulshift(uint64_t *plow, uint64_t *phigh,
> > > > +                           uint32_t shift, bool *overflow)
> > > > +{
> > > > +    __uint128_t val =3D ((__uint128_t)*phigh << 64) | *plow;
> > > > +
> > > > +    if (shift =3D=3D 0) {
> > > > +        return;
> > > > +    }
> > > > +
> > > > +    if (shift > 127 || (val >> (128 - (shift & 127))) !=3D 0) {
> > > > +        *overflow =3D true;
> > > > +    }
> > > > +
> > > > +    val <<=3D (shift & 127);
> > > > +
> > > > +    *phigh =3D val >> 64;
> > > > +    *plow =3D val & 0xffffffffffffffff;
> > > > +}
> > > > +
> > >=20
> > > This belongs in qemu/int128.h, not here.  And certainly not predicate=
d on
> > > CONFIG_INT128.
> >=20
> > Is there actually any advantage to the __uint128_t based versions over
> > the 64-bit versions?
>=20
> Nothing special here. It just looks more clear (to me) to shift all 128
> bits at once than 2x64. But I agree we won't loose to have just one
> function outside CONFIG_INT128.

It is clearer, but having two different version makes things less
clear again.  We need to have the 64-bit only version for compilers
without int128_t support, so..

> So, I'll remove these two functions and keep only the other two using
> uint64_t types.
>=20
> Anyway I get a bit confused about int128.h and host-utils.h. I see
> functions like divu128 and divs128 that could be in int128.h, since
> there is no similar operation in int128.h. Is there any rule about it?
>=20
> Thank you guys for reviewing it!
>=20
> >=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--dp9QYJgVRVEW2bsm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYRfFYAAoJEGw4ysog2bOS7E8P/iCWjgMe+1rfUVnFyp/iyxkB
QJbw5QYf/TIL1ElJmE30C225wnqLXZx74kawWBBAEQcqDQsNrIM5OHK1OvJiKH5T
GQ22GjRLRCYfGMN+sNhJownjpOhKrFGBQsJ4e1gFpul+juc0ZE3uZoXHhHZbwVT+
vpgpdp671rTk3diCWEaWf1dA9Za6s8kfl4Nyi/yhY+3d+CXkBpl6UIFBoaJOcULi
m5WgcpkaXk2bdk7B2cghk/9F+567Km6WFlIRPdEWv/aVY2E0JbIi+qYjw+0ldcE2
JNPJtdRE9ls2r6jh+Si8F4yJ3RgvVpZAD7D0TuTTyg2o/l9ckLVaB3KH8zyxsGzn
sLRHqVaP9aXKf9kFHCjX/uftcI9jmG8lsXI1XqV31fG9eETMuJLRolcvnZnVGWIG
gxVI4bRor8mTn0EZtP8jFPi3j5wDXGa06X28vxBIytdjjkEihe8cv+R1EdKfTfuZ
vN4ZReB4WoeSzmcX1Jz9DXeucUEZW/TWnMJc2efU3xFoQ24nHhdrG3k4J7EYakHY
jUXXHqygG1Nw+xWFvH2WHxvIZL+bBxSFA6kyfWpBNZbwfnoLgjwSt/ISDegTF8Z/
qPPccnxLKR5sIcq83qjuEVGUhi74/3CDy3hxNX3EkcrLCPVPegWn4dAmB+eXDlHy
T+3Vgyhg4DZj960rrIoX
=OAZp
-----END PGP SIGNATURE-----

--dp9QYJgVRVEW2bsm--
