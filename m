Received: from eggs.gnu.org ([2001:4830:134:3::10]:38727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTISY-0000W9-3A
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:58:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fTISW-0004WA-KL
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 22:58:02 -0400
Date: Thu, 14 Jun 2018 11:36:28 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180614013628.GG3042@umbus.fritz.box>
References: <cover.1528935420.git.balaton@eik.bme.hu>
	<05a82ed894d046e64e94dc2218543199c11fa498.1528935420.git.balaton@eik.bme.hu>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="APlYHCtpeOhspHkB"
Content-Disposition: inline
In-Reply-To: <05a82ed894d046e64e94dc2218543199c11fa498.1528935420.git.balaton@eik.bme.hu>
Subject: Re: [Qemu-devel] [PATCH v3 4/9] hw/timer: Add basic M41T80 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>


--APlYHCtpeOhspHkB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 02:17:00AM +0200, BALATON Zoltan wrote:
> Basic emulation of the M41T80 serial (I2C) RTC chip. Only getting time
> of day is implemented. Setting time and RTC alarm are not supported.
>=20
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>=20
> Notes:
>     v3: Fixed \n-s in log messages
>=20
>  MAINTAINERS                     |   1 +
>  default-configs/ppc-softmmu.mak |   1 +
>  hw/timer/Makefile.objs          |   1 +
>  hw/timer/m41t80.c               | 117 ++++++++++++++++++++++++++++++++++=
++++++
>  4 files changed, 120 insertions(+)
>  create mode 100644 hw/timer/m41t80.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a94517..74ae589 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -829,6 +829,7 @@ M: BALATON Zoltan <balaton@eik.bme.hu>
>  L: qemu-ppc@nongnu.org
>  S: Maintained
>  F: hw/ide/sii3112.c
> +F: hw/timer/m41t80.c
> =20
>  SH4 Machines
>  ------------
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index 7d0dc2f..9fbaadc 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -27,6 +27,7 @@ CONFIG_SM501=3Dy
>  CONFIG_IDE_SII3112=3Dy
>  CONFIG_I2C=3Dy
>  CONFIG_BITBANG_I2C=3Dy
> +CONFIG_M41T80=3Dy
> =20
>  # For Macs
>  CONFIG_MAC=3Dy
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 8b27a4b..e16b2b9 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_CADENCE) +=3D cadence_ttc.o
>  common-obj-$(CONFIG_DS1338) +=3D ds1338.o
>  common-obj-$(CONFIG_HPET) +=3D hpet.o
>  common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
> +common-obj-$(CONFIG_M41T80) +=3D m41t80.o
>  common-obj-$(CONFIG_M48T59) +=3D m48t59.o
>  ifeq ($(CONFIG_ISA_BUS),y)
>  common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
> diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
> new file mode 100644
> index 0000000..734d7d9
> --- /dev/null
> +++ b/hw/timer/m41t80.c
> @@ -0,0 +1,117 @@
> +/*
> + * M41T80 serial rtc emulation
> + *
> + * Copyright (c) 2018 BALATON Zoltan
> + *
> + * This work is licensed under the GNU GPL license version 2 or later.
> + *
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu/log.h"
> +#include "qemu/timer.h"
> +#include "qemu/bcd.h"
> +#include "hw/i2c/i2c.h"
> +
> +#define TYPE_M41T80 "m41t80"
> +#define M41T80(obj) OBJECT_CHECK(M41t80State, (obj), TYPE_M41T80)
> +
> +typedef struct M41t80State {
> +    I2CSlave parent_obj;
> +    int8_t addr;
> +} M41t80State;
> +
> +static void m41t80_realize(DeviceState *dev, Error **errp)
> +{
> +    M41t80State *s =3D M41T80(dev);
> +
> +    s->addr =3D -1;
> +}
> +
> +static int m41t80_send(I2CSlave *i2c, uint8_t data)
> +{
> +    M41t80State *s =3D M41T80(i2c);
> +
> +    if (s->addr < 0) {
> +        s->addr =3D data;
> +    } else {
> +        s->addr++;
> +    }
> +    return 0;
> +}
> +
> +static int m41t80_recv(I2CSlave *i2c)
> +{
> +    M41t80State *s =3D M41T80(i2c);
> +    struct tm now;
> +    qemu_timeval tv;
> +
> +    if (s->addr < 0) {
> +        s->addr =3D 0;
> +    }
> +    if (s->addr >=3D 1 && s->addr <=3D 7) {
> +        qemu_get_timedate(&now, -1);
> +    }
> +    switch (s->addr++) {
> +    case 0:
> +        qemu_gettimeofday(&tv);
> +        return to_bcd(tv.tv_usec / 10000);
> +    case 1:
> +        return to_bcd(now.tm_sec);
> +    case 2:
> +        return to_bcd(now.tm_min);
> +    case 3:
> +        return to_bcd(now.tm_hour);
> +    case 4:
> +        return to_bcd(now.tm_wday);
> +    case 5:
> +        return to_bcd(now.tm_mday);
> +    case 6:
> +        return to_bcd(now.tm_mon + 1);
> +    case 7:
> +        return to_bcd(now.tm_year % 100);
> +    case 8 ... 19:
> +        qemu_log_mask(LOG_UNIMP, "%s: unimplemented register: %d\n",
> +                      __func__, s->addr - 1);
> +        return 0;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid register: %d\n",
> +                      __func__, s->addr - 1);
> +        return 0;
> +    }
> +}
> +
> +static int m41t80_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    M41t80State *s =3D M41T80(i2c);
> +
> +    if (event =3D=3D I2C_START_SEND) {
> +        s->addr =3D -1;
> +    }
> +    return 0;
> +}
> +
> +static void m41t80_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    I2CSlaveClass *sc =3D I2C_SLAVE_CLASS(klass);
> +
> +    dc->realize =3D m41t80_realize;
> +    sc->send =3D m41t80_send;
> +    sc->recv =3D m41t80_recv;
> +    sc->event =3D m41t80_event;
> +}
> +
> +static const TypeInfo m41t80_info =3D {
> +    .name          =3D TYPE_M41T80,
> +    .parent        =3D TYPE_I2C_SLAVE,
> +    .instance_size =3D sizeof(M41t80State),
> +    .class_init    =3D m41t80_class_init,
> +};
> +
> +static void m41t80_register_types(void)
> +{
> +    type_register_static(&m41t80_info);
> +}
> +
> +type_init(m41t80_register_types)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--APlYHCtpeOhspHkB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlshxpwACgkQbDjKyiDZ
s5IAehAA3DHtg8OZo4H+CPZ8pEC1ECQ5s4HIzk6XSTftT1d293ObDeuY3a0wH+5G
9Uli00naxL1+goeJaFRgAyqkmvV9sA2RJfRK0fC3/d/KS9A8LGEV3wWyyTkW36O1
Ed30aEewIuCIhTFVkv0+S7i8cYactGwQuLQ1wiRC/nE5H2pr7Ac7rEGuX2iht9rN
eKZ6m/l1wKbPCk8SkCvrJueNoWyhnWCxvYzwuYMG+vCtA0RwHlzrOLP6qMo9AvZS
fJm5q6HNo/+2vIaHa8bUY0R1h3zbB478HMmbxh6HxFzGUqvbxwLrbk7PaUcvvDc/
cMBOhRXoH5p7Ey4GJSAkcNoogxEZeJbt3weB6JXs2MUpqUYwVr7E/qagYZKpB6tB
O2byT7F/jzcoHnbNU6zb1o44n5KOKTfQGDbYGjOQIyu2k6q9aBKUnb+mcrskd84o
rUpUKriUpVH0V7EtL7JX7S7LVI3Wt8POwWluLtb48GpieSjput1VPyd1WIArou5D
/pMMVgNTbTGz1VcsVIrohkli8WZyj+ccDbSsPZm1U5MptQQOO4ehjLfi+4Zv5qQ6
NVqJIJd8LMQahKm6sbbpCKHKyXaCOsgDENeMxF+GxZSR3/A3Zkh/1zPm+PxqJWHM
GtiN9XUsgU//hM5kKfYEicC7UO0OPS5uNZlmFRBHW/5Vb+uSZUI=
=3fko
-----END PGP SIGNATURE-----

--APlYHCtpeOhspHkB--
