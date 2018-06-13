Received: from eggs.gnu.org ([2001:4830:134:3::10]:43791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2dD-0008TR-ML
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:04:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fT2d9-00077K-Dp
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 06:03:59 -0400
Date: Wed, 13 Jun 2018 20:03:39 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613100339.GK30690@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<8c404c8c4ee1bfd2e4d079877d481094f797df8f.1528291908.git.balaton@eik.bme.hu>
	<6aa1bc4e-a4b0-d7be-b9eb-85dfe8c06781@amsat.org>
	<alpine.BSF.2.21.1806061920120.94568@zero.eik.bme.hu>
	<20180613041115.GS30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131044020.620@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XkdrZ7OMnakiJ6dL"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806131044020.620@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 5/8] hw/timer: Add basic
 M41T80 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-ppc@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org


--XkdrZ7OMnakiJ6dL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 10:50:59AM +0200, BALATON Zoltan wrote:
> On Wed, 13 Jun 2018, David Gibson wrote:
> > On Wed, Jun 06, 2018 at 07:35:28PM +0200, BALATON Zoltan wrote:
> > > On Wed, 6 Jun 2018, Philippe Mathieu-Daud=E9 wrote:
> > > > On 06/06/2018 10:31 AM, BALATON Zoltan wrote:
> > > > > Basic emulation of the M41T80 serial (I2C) RTC chip. Only getting=
 time
> > > > > of day is implemented. Setting time and RTC alarm are not support=
ed.
> > > [...]
> > > > > diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
> > > > > new file mode 100644
> > > > > index 0000000..9dbdb1b
> > > > > --- /dev/null
> > > > > +++ b/hw/timer/m41t80.c
> > > > > @@ -0,0 +1,117 @@
> > > > > +/*
> > > > > + * M41T80 serial rtc emulation
> > > > > + *
> > > > > + * Copyright (c) 2018 BALATON Zoltan
> > > > > + *
> > > > > + * This work is licensed under the GNU GPL license version 2 or =
later.
> > > > > + *
> > > > > + */
> > > > > +
> > > > > +#include "qemu/osdep.h"
> > > > > +#include "qemu/log.h"
> > > > > +#include "qemu/timer.h"
> > > > > +#include "qemu/bcd.h"
> > > > > +#include "hw/i2c/i2c.h"
> > > > > +
> > > > > +#define TYPE_M41T80 "m41t80"
> > > > > +#define M41T80(obj) OBJECT_CHECK(M41t80State, (obj), TYPE_M41T80)
> > > > > +
> > > > > +typedef struct M41t80State {
> > > > > +    I2CSlave parent_obj;
> > > > > +    int8_t addr;
> > > > > +} M41t80State;
> > > > > +
> > > > > +static void m41t80_realize(DeviceState *dev, Error **errp)
> > > > > +{
> > > > > +    M41t80State *s =3D M41T80(dev);
> > > > > +
> > > > > +    s->addr =3D -1;
> > > > > +}
> > > > > +
> > > > > +static int m41t80_send(I2CSlave *i2c, uint8_t data)
> > > > > +{
> > > > > +    M41t80State *s =3D M41T80(i2c);
> > > > > +
> > > > > +    if (s->addr < 0) {
> > > > > +        s->addr =3D data;
> > > > > +    } else {
> > > > > +        s->addr++;
> > > > > +    }
> > > >=20
> > > > What about adding enum i2c_event in M41t80State and use the enum he=
re
> > > > rather than the addr < 0? Also this wrap at INT8_MAX =3D 127, is th=
is
> > > > expected?
> > >=20
> > > Thanks for the review. I guess we could add enum for device bytes and=
 the
> > > special case -1 meaning no register address selected yet but this is =
a very
> > > simple device with only 20 bytes and the datasheet also lists them by=
 number
> > > without naming them so I think we can also refer to them by number. S=
ince
> > > the device has only this 20 bytes the case with 127 should also not b=
e a
> > > problem as that's invalid address anyway. Or did you mean something e=
lse?
> >=20
> > So, I'm not particularly in favour of adding extra state variables.
> >=20
> > But is using addr < 0 safe here?  You're assigning the uint8_t data to
> > addr - could that result in a negative value?
>=20
> Why wouldn't it be safe with the expected values for register address
> between 0-19? If the guest sends garbage values over 127 it will either
> result in invalid register or unselected register and lead to an error wh=
en
> trying to read/write that register so I don't see what other problem this
> may cause.

Ok, but where is that enforced?

> The addr < 0 is to check if no address was selected before (on creating t=
he
> device and when sending first value from host addr is set to -1. In this
> case first write will set register address, then subsequent reads/writes
> increment register address as the datasheet says).
>=20
> Regards,
> BALATON Zoltan


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XkdrZ7OMnakiJ6dL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsg6/sACgkQbDjKyiDZ
s5LHWRAApKr9i1AWW0Cg1J3b17eThFnp/i4jyaJ931WvVSKeab7IIkB3ILHFc3fN
pkgeEYmmQiYTqKdv3i+Ye+qpGpi8SiNP3ENjJ/TkrXD5m2g7cNE4SmwZYyf+XWz9
3V3dVxawAROfSVFkTnaUgkh03qUt+KTmPxcicEydegmhWLvisKRH51pem92Zsqqj
CwKSn6nFYtgdOHHaxHGhbEEh/tOhrlv4rD2ze/Qco2CGn9d0oKsHSIszvEemOLgT
pRPXJUnrLLXkXMMtUd1HVrC42BMHHkeANHlQ3370FKREDhPiwCvpjGHaHQTctU6a
0HBPCbfNVeEGW6+G1afKMMoUfL598DIrg1DayKiWFqVwgaR+IDdJU2OB5AfO+bLe
DvnolgQfothDvkGmmlC0UHVFgqXv48YHea4TTsjBnfaICjAnkplvan3PXCx7Drrz
oyODsarxid5ssz9jEj8H47VMiiO7q2YlrilqQT7Eyq3v4mvQIFiewj4oX/iI158z
DZZMVQsoaR3Fr1rU4a2JPhLkR1gYPXumuPaoXb8uY3NaydzbTo7yCsZzhBWVCrc5
YlUc+tu4VNA09pbl+wbnK6eOeY4NV/lxx5idi0KD89VLOS6a6qAV5qQLyBQKiQd6
fq6f0c+tf3VwBbo6u361TI1HV7d12cEFHbLqpQ7djISv8tfG3tQ=
=Z7Iy
-----END PGP SIGNATURE-----

--XkdrZ7OMnakiJ6dL--
