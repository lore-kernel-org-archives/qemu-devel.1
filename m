Received: from eggs.gnu.org ([2001:4830:134:3::10]:42244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSxC0-0001KV-4L
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fSxBy-0007AZ-TG
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 00:15:32 -0400
Date: Wed, 13 Jun 2018 14:11:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180613041115.GS30690@umbus.fritz.box>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<8c404c8c4ee1bfd2e4d079877d481094f797df8f.1528291908.git.balaton@eik.bme.hu>
	<6aa1bc4e-a4b0-d7be-b9eb-85dfe8c06781@amsat.org>
	<alpine.BSF.2.21.1806061920120.94568@zero.eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="oJFDFiWc3BlD0xT/"
Content-Disposition: inline
In-Reply-To: <alpine.BSF.2.21.1806061920120.94568@zero.eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v2 5/8] hw/timer: Add basic M41T80 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--oJFDFiWc3BlD0xT/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 06, 2018 at 07:35:28PM +0200, BALATON Zoltan wrote:
> On Wed, 6 Jun 2018, Philippe Mathieu-Daud=E9 wrote:
> > On 06/06/2018 10:31 AM, BALATON Zoltan wrote:
> > > Basic emulation of the M41T80 serial (I2C) RTC chip. Only getting time
> > > of day is implemented. Setting time and RTC alarm are not supported.
> [...]
> > > diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
> > > new file mode 100644
> > > index 0000000..9dbdb1b
> > > --- /dev/null
> > > +++ b/hw/timer/m41t80.c
> > > @@ -0,0 +1,117 @@
> > > +/*
> > > + * M41T80 serial rtc emulation
> > > + *
> > > + * Copyright (c) 2018 BALATON Zoltan
> > > + *
> > > + * This work is licensed under the GNU GPL license version 2 or late=
r.
> > > + *
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qemu/log.h"
> > > +#include "qemu/timer.h"
> > > +#include "qemu/bcd.h"
> > > +#include "hw/i2c/i2c.h"
> > > +
> > > +#define TYPE_M41T80 "m41t80"
> > > +#define M41T80(obj) OBJECT_CHECK(M41t80State, (obj), TYPE_M41T80)
> > > +
> > > +typedef struct M41t80State {
> > > +    I2CSlave parent_obj;
> > > +    int8_t addr;
> > > +} M41t80State;
> > > +
> > > +static void m41t80_realize(DeviceState *dev, Error **errp)
> > > +{
> > > +    M41t80State *s =3D M41T80(dev);
> > > +
> > > +    s->addr =3D -1;
> > > +}
> > > +
> > > +static int m41t80_send(I2CSlave *i2c, uint8_t data)
> > > +{
> > > +    M41t80State *s =3D M41T80(i2c);
> > > +
> > > +    if (s->addr < 0) {
> > > +        s->addr =3D data;
> > > +    } else {
> > > +        s->addr++;
> > > +    }
> >=20
> > What about adding enum i2c_event in M41t80State and use the enum here
> > rather than the addr < 0? Also this wrap at INT8_MAX =3D 127, is this
> > expected?
>=20
> Thanks for the review. I guess we could add enum for device bytes and the
> special case -1 meaning no register address selected yet but this is a ve=
ry
> simple device with only 20 bytes and the datasheet also lists them by num=
ber
> without naming them so I think we can also refer to them by number. Since
> the device has only this 20 bytes the case with 127 should also not be a
> problem as that's invalid address anyway. Or did you mean something else?

So, I'm not particularly in favour of adding extra state variables.

But is using addr < 0 safe here?  You're assigning the uint8_t data to
addr - could that result in a negative value?

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--oJFDFiWc3BlD0xT/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsgmV4ACgkQbDjKyiDZ
s5JBVBAAulwPfYTjkp6IdGrgnUOqR18P+fCFW7R3mzXJjB+OruUhFd5Re5/EKGoF
QBlDwxsiadSrn4PF4nheKvTCEOY83cJqh0QZbjoE+RpPDZmDGMCRY9NxmLSlosul
0hwj1vmxYeOhbi/1SM9HRUj/uC6YeVgQ8kAWnrDaDGm+ec2bLC9Fg+HpQg4UeTR7
RhD1HTsV/UnnI8bskqod6ovoLaE4pR6yYboZpQclX5GP7mk/QF3yIFx9eyBwZfl5
jkW9ASxsiwnmCcN4EovcgAhBHRTtSXYgoL+qwkrIJSohV/lwxJY28NSFZbqTxSpp
Ycqwi21gRMpNI1LUu831hc0bPrjvdU4cpshq0vuG1EKSggs79QrZxauyS3Cm6ghE
r8crBLQ887mWP368uhqoS/KFZFWQOr+EWqb1m0MG35fnFbXYmTS+PLNxj96dvptG
tunl+Mf0ZJx9VcxNJyysdqe5UKiXSQpFyqWNAOTkicKzC/LX7b/w39IA6fttdCP2
as13UB3Ry+qSop1EtVC0OfsIuihUmTWXuPQZ/ev2onNpfifZT5hKeJ4NImpxgTSN
0dEnaDeOdVoDT1kawNqE9pE1/QzgzJLR2svg1NERAcgj5AGRqBuN+BI26UpQjUS5
w/+kLXZzC99bmZ3myEBvPL15gr/92HqSjfeeOC4zMOyNIM/Pi6Q=
=jEiv
-----END PGP SIGNATURE-----

--oJFDFiWc3BlD0xT/--
