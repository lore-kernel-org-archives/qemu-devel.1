Received: from eggs.gnu.org ([2001:4830:134:3::10]:45647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcOQV-00073G-2s
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 01:09:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fcOQR-0000lP-2a
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 01:09:31 -0400
Received: from ozlabs.org ([203.11.71.1]:49803)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1fcOQP-0000kB-NY
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 01:09:27 -0400
Date: Mon, 9 Jul 2018 15:09:00 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180709050900.GF22363@umbus.fritz.box>
References: <20180705182001.16537-1-mdavidsaver@gmail.com>
	<20180705182001.16537-4-mdavidsaver@gmail.com>
	<20180706033942.GN3450@umbus.fritz.box>
	<b7dfce5a-ee0e-b796-fbb6-236c8cf5ee9b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <b7dfce5a-ee0e-b796-fbb6-236c8cf5ee9b@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 03/14] timer: ds1338 persist 12-hour mode
 selection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Antoine Mathys <barsamin@gmail.com>, qemu-devel@nongnu.org


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 05, 2018 at 09:35:50PM -0700, Michael Davidsaver wrote:
> On 07/05/2018 08:39 PM, David Gibson wrote:
> > On Thu, Jul 05, 2018 at 11:19:50AM -0700, Michael Davidsaver wrote:
> > 11;rgb:ffff/ffff/ffff> Need to save HOUR[HOUR12] bit to keep
> >> track of guest selection of 12-hour mode.
> >> Write through current time registers to
> >> achieve this.  Will be overwritten
> >> by the next read/latch.
> >>
> >> This was only being done in two of three
> >> arms of this conditional block.
> >>
> >> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>
> >=20
> > This looks dubious to me, or at least the explanation of it does.  The
> > other branch of the conditional is covering different registers in the
> > device, which are part of the RTC component, rather than the NVRAM
> > area.  I wouldn't necessarily expect them to persist data as a rule
> > the way the rest of the block does, even if this specific bit does
> > need to be preserved.
>=20
> The fact that the above capture_current_time() included the line
>=20
> >     if (s->nvram[2] & HOURS_12) {
>=20
> was enough to convince me that the original author intended to persist
> the 12/24 hour mode in this way.  There are certainly other ways to
> accomplish this, but they would involved adding to the vmstate,
> which I've tried to avoid in this iteration.

Ah, yes, I see your point.  I was more unsure about whether it was
safe to also persist the other early bytes of the region, which this
patch also does.  But I can't really see how it would do any harm, so:

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

>=20
>=20
> Also, I though I had test coverage of this bug.  That's actually how I
> noticed it to begin with.  But it seems my later change to allow for a
> slow test runner also stopped testing readback of the 12/24 hour mode bit.
> It just silently uses whichever it reads.  I'll be re-issuing an updated
> version which restores this check.  Then you will be able to easily
> see the effect of reverting 'timer: ds1338 persist 12-hour mode selection=
'.
>=20
>=20
>=20
> >> ---
> >>  hw/timer/ds1338.c | 4 +---
> >>  1 file changed, 1 insertion(+), 3 deletions(-)
> >>
> >> diff --git a/hw/timer/ds1338.c b/hw/timer/ds1338.c
> >> index 7298c5af43..b56db5852e 100644
> >> --- a/hw/timer/ds1338.c
> >> +++ b/hw/timer/ds1338.c
> >> @@ -220,10 +220,8 @@ static int ds1338_send(I2CSlave *i2c, uint8_t dat=
a)
> >>             value unchanged. */
> >>          data =3D (data & ~CTRL_OSF) | (data & s->nvram[s->ptr] & CTRL=
_OSF);
> >> =20
> >> -        s->nvram[s->ptr] =3D data;
> >> -    } else {
> >> -        s->nvram[s->ptr] =3D data;
> >>      }
> >> +    s->nvram[s->ptr] =3D data;
> >>      inc_regptr(s);
> >>      return 0;
> >>  }
> >=20
>=20
>=20




--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltC7ewACgkQbDjKyiDZ
s5Lqkw/9HvfgPS53CZ2Ew8FkgY0cqnLm5rl6T258TD7YnQqsS3hSwQfYNyu/gKEL
R51f6W8HDRbNi491v7lPxlMgxw1bze+kJWYph/fqnionSZWKz8LNPiCyt/IXyKxX
W9f03qKMeyOqOIhB0F6wwapn/98U6NuXaIrqLZuLGpKZMKxCswcd/eS9JDUSVl6G
6lcanEdlGWNGO4C6albJS6dmFNWGH/Pgv8GcP5pCnQ/kL6y34bapIncRybZqbBdR
C5L4fou6p8LjSCL6MiJJRDE7lbJgfy9EVOoAe0uKY9hvbdXD57Op7WnY8kJ2j92F
ZLN8vCkHXBkCrYoxOea5f0Lt0l+FmiTo4RAE1ape15X2R9ZhKucox8PCI+miOt7a
5kWM69BjBK1+5E6nkn6iza9nygZmQT4p7GOKYhdLLD8nwzXAnL+XHVyG+m8qJJ3Y
8WRgihvC0Sn3ErR9OK1TbAxv7vDJDKCsbtFUVFUuCSwEqD03uG/80vlN+HF9ly6y
LMF0gUX33O0g692uKrzn7dgQ9cEkJ2bMFe4Fc3fNTG3hhypc2y+U7hjIS6PnJKwn
SqRFetkmeydPaoNMN0om/4zCqWtYgwzlN4v+7BAtzPM11hMumXmcOgLxztJXfEzd
uJIsWmwTvb3J8zmUroklF/6uq82p157BS4uDjWaRixaa/Ks5WM8=
=f+pR
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
