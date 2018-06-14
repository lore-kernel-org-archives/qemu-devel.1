Received: from eggs.gnu.org ([2001:4830:134:3::10]:50943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTH3k-0007jE-Gd
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTH3j-0006Ug-80
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 21:28:20 -0400
Date: Thu, 14 Jun 2018 11:27:54 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614012754.GB3042@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<8c404c8c4ee1bfd2e4d079877d481094f797df8f.1528291908.git.balaton@eik.bme.hu>
	<6aa1bc4e-a4b0-d7be-b9eb-85dfe8c06781@amsat.org>
	<alpine.BSF.2.21.1806061920120.94568@zero.eik.bme.hu>
	<20180613041115.GS30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131044020.620@zero.eik.bme.hu>
	<20180613100339.GK30690@umbus.fritz.box>
	<alpine.BSF.2.21.1806131603270.90524@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806131603270.90524@zero.eik.bme.hu>
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


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 13, 2018 at 04:13:57PM +0200, BALATON Zoltan wrote:
> On Wed, 13 Jun 2018, David Gibson wrote:
> > On Wed, Jun 13, 2018 at 10:50:59AM +0200, BALATON Zoltan wrote:
> > > On Wed, 13 Jun 2018, David Gibson wrote:
> > > > On Wed, Jun 06, 2018 at 07:35:28PM +0200, BALATON Zoltan wrote:
> > > > > On Wed, 6 Jun 2018, Philippe Mathieu-Daud=E9 wrote:
> > > > > > On 06/06/2018 10:31 AM, BALATON Zoltan wrote:
> > > > > > > Basic emulation of the M41T80 serial (I2C) RTC chip. Only get=
ting time
> > > > > > > of day is implemented. Setting time and RTC alarm are not sup=
ported.
> > > > > [...]
> > > > > > > diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
> > > > > > > new file mode 100644
> > > > > > > index 0000000..9dbdb1b
> > > > > > > --- /dev/null
> > > > > > > +++ b/hw/timer/m41t80.c
> > > > > > > @@ -0,0 +1,117 @@
> > > > > > > +/*
> > > > > > > + * M41T80 serial rtc emulation
> > > > > > > + *
> > > > > > > + * Copyright (c) 2018 BALATON Zoltan
> > > > > > > + *
> > > > > > > + * This work is licensed under the GNU GPL license version 2=
 or later.
> > > > > > > + *
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include "qemu/osdep.h"
> > > > > > > +#include "qemu/log.h"
> > > > > > > +#include "qemu/timer.h"
> > > > > > > +#include "qemu/bcd.h"
> > > > > > > +#include "hw/i2c/i2c.h"
> > > > > > > +
> > > > > > > +#define TYPE_M41T80 "m41t80"
> > > > > > > +#define M41T80(obj) OBJECT_CHECK(M41t80State, (obj), TYPE_M4=
1T80)
> > > > > > > +
> > > > > > > +typedef struct M41t80State {
> > > > > > > +    I2CSlave parent_obj;
> > > > > > > +    int8_t addr;
> > > > > > > +} M41t80State;
> > > > > > > +
> > > > > > > +static void m41t80_realize(DeviceState *dev, Error **errp)
> > > > > > > +{
> > > > > > > +    M41t80State *s =3D M41T80(dev);
> > > > > > > +
> > > > > > > +    s->addr =3D -1;
> > > > > > > +}
> > > > > > > +
> > > > > > > +static int m41t80_send(I2CSlave *i2c, uint8_t data)
> > > > > > > +{
> > > > > > > +    M41t80State *s =3D M41T80(i2c);
> > > > > > > +
> > > > > > > +    if (s->addr < 0) {
> > > > > > > +        s->addr =3D data;
> > > > > > > +    } else {
> > > > > > > +        s->addr++;
> > > > > > > +    }
> > > > > >=20
> > > > > > What about adding enum i2c_event in M41t80State and use the enu=
m here
> > > > > > rather than the addr < 0? Also this wrap at INT8_MAX =3D 127, i=
s this
> > > > > > expected?
> > > > >=20
> > > > > Thanks for the review. I guess we could add enum for device bytes=
 and the
> > > > > special case -1 meaning no register address selected yet but this=
 is a very
> > > > > simple device with only 20 bytes and the datasheet also lists the=
m by number
> > > > > without naming them so I think we can also refer to them by numbe=
r. Since
> > > > > the device has only this 20 bytes the case with 127 should also n=
ot be a
> > > > > problem as that's invalid address anyway. Or did you mean somethi=
ng else?
> > > >=20
> > > > So, I'm not particularly in favour of adding extra state variables.
> > > >=20
> > > > But is using addr < 0 safe here?  You're assigning the uint8_t data=
 to
> > > > addr - could that result in a negative value?
> > >=20
> > > Why wouldn't it be safe with the expected values for register address
> > > between 0-19? If the guest sends garbage values over 127 it will eith=
er
> > > result in invalid register or unselected register and lead to an erro=
r when
> > > trying to read/write that register so I don't see what other problem =
this
> > > may cause.
> >=20
> > Ok, but where is that enforced?
>=20
> I don't see the problem. The addr register selects the register to read or
> write. It is set by the first write when the device is accessed the first
> time (this is denoted by addr =3D=3D -1 (or really any negative value). T=
he
> device has 20 registers and trying to read any register outside addr betw=
een
> 0-19 will result in returning 0 and logging a warning about invalid regis=
ter
> in m41t80_recv. What could fail here when guest sends garbage? It will set
> addr to invalid value and try to read non-exitent register and get an err=
or
> just like for any other nonexistent value of addr (or start to read from
> register 0 if it manages to set a negative value). All writes of registers
> are ignored currently (except setting addr by the first write). What shou=
ld
> be enforced here?

Ah, I see your point.  I mean strictly we should match the hardware
behaviour if you write garbage addresses here, but really I don't
think it matters much.

Ok, it should be fine.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshxJoACgkQbDjKyiDZ
s5KjhBAAsciaExIvLyv2PyyDnrZdES78iv91vyK+ofFGqDYxkwVAVQWOvB5oUzi5
Vktify8/vKiAl3QCyPnuz6s9X0c+aTDYyfcfwwevpCGZ5L9I9h+5HVzd0+f6+yAC
cVyJwqxITlQwvKyloNAz6M6OMZvc2WxM0JYP0fRAIdMq97R+Kw8CO9fLjJDxmvHz
XiLKcDliwk4ZJqDKMK/WaaYTwG2GQ6gVtHTZrbfKm4HgdO7F1w03FkFlWDarqU0b
DVfvyOOj08aPPaBlV+AMulsvLxoz1TCsj66KWvjbkwxWQTPvtxc3t2SIm3gmScV+
fQewbUb85HyxpJE3zjLu1O+SkYQao4o71Rii+dlaPyKVXh4sDb8yhz7hwddNv9ox
TG9bSoSbqyGjn5cRl0c2hPvH6XvkHLEnEmgMuKt+eGUGqs1Ky1wiYCj8uN/+uVRO
Xe6mFG8ao5/odyqVny779c34igudyGfbKStufC4yrEFDVWnjky8RLTQWMu7dDMiG
y4PNptiV1HKIr23ScBSk15cz5DL3b6LYT+4lDbRsltzyelntZKIxYnZ5ZzrpgQrw
A2q3Z2EQpBQ0mBRhas77X3h6manAjDAS1Wp+ClpCD5YDLcziKn2IfgL5bggn7Wl7
46KZWs9T69u1H7FYv6tBWLr0ux83GY0lb4VcRKIsrRiWePwP57U=
=xDlZ
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
