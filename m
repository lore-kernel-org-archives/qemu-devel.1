Received: from eggs.gnu.org ([2001:4830:134:3::10]:53643)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOo-0002i5-Qe
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHMOn-0002Xa-1k
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 23:12:34 -0500
Date: Wed, 22 Nov 2017 15:11:26 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122041126.GO2380@umbus.fritz.box>
References: <20171120032420.9134-1-mdavidsaver@gmail.com>
	<20171120032420.9134-11-mdavidsaver@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="PtLnLSExlPr13a2X"
Content-Disposition: inline
In-Reply-To: <20171120032420.9134-11-mdavidsaver@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 10/12] timer: add ds1375 RTC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Davidsaver <mdavidsaver@gmail.com>
Cc: Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--PtLnLSExlPr13a2X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 19, 2017 at 09:24:18PM -0600, Michael Davidsaver wrote:
> only basic functionality implemented (read time and sram).
> no set time or alarms.
>=20
> Signed-off-by: Michael Davidsaver <mdavidsaver@gmail.com>

I know there about a zillion different Dallas/Maxim sram/rtc chips,
many of which have a lot of similarities.  Is it possible to share any
code with the existing hw/timer/ds1338.c?

> ---
>  default-configs/ppc-softmmu.mak |   1 +
>  hw/timer/Makefile.objs          |   1 +
>  hw/timer/ds1375-i2c.c           | 293 ++++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 295 insertions(+)
>  create mode 100644 hw/timer/ds1375-i2c.c
>=20
> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmm=
u.mak
> index bb225c6e46..04bfa79154 100644
> --- a/default-configs/ppc-softmmu.mak
> +++ b/default-configs/ppc-softmmu.mak
> @@ -52,3 +52,4 @@ CONFIG_SERIAL_ISA=3Dy
>  CONFIG_MC146818RTC=3Dy
>  CONFIG_ISA_TESTDEV=3Dy
>  CONFIG_RS6000_MC=3Dy
> +CONFIG_DS1375=3Dy
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 8c19eac3b6..6521d47367 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -4,6 +4,7 @@ common-obj-$(CONFIG_ARM_V7M) +=3D armv7m_systick.o
>  common-obj-$(CONFIG_A9_GTIMER) +=3D a9gtimer.o
>  common-obj-$(CONFIG_CADENCE) +=3D cadence_ttc.o
>  common-obj-$(CONFIG_DS1338) +=3D ds1338.o
> +common-obj-$(CONFIG_DS1375) +=3D ds1375-i2c.o
>  common-obj-$(CONFIG_HPET) +=3D hpet.o
>  common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
>  common-obj-$(CONFIG_M48T59) +=3D m48t59.o
> diff --git a/hw/timer/ds1375-i2c.c b/hw/timer/ds1375-i2c.c
> new file mode 100644
> index 0000000000..dba9cc05c4
> --- /dev/null
> +++ b/hw/timer/ds1375-i2c.c
> @@ -0,0 +1,293 @@
> +/*
> + * Dallas/Maxim ds1375 I2C RTC w/ SRAM
> + *
> + * Copyright (c) 2017 Michael Davidsaver
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2.  See
> + * the LICENSE file in the top-level directory.
> + *
> + * Only basic functionality is modeled (time and user SRAM).
> + * Alarms not modeled.
> + */
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "qemu/log.h"
> +#include "qemu/timer.h"
> +#include "qemu/bcd.h"
> +#include "hw/hw.h"
> +#include "hw/registerfields.h"
> +#include "hw/i2c/i2c.h"
> +
> +#define DEBUG_DS1375
> +
> +#ifdef DEBUG_DS1375
> +#define DPRINTK(FMT, ...) printf(TYPE_DS1375 " : " FMT, ## __VA_ARGS__)
> +#else
> +#define DPRINTK(FMT, ...) do {} while (0)
> +#endif
> +
> +#define LOG(MSK, FMT, ...) qemu_log_mask(MSK, TYPE_DS1375 " : " FMT, \
> +                            ## __VA_ARGS__)
> +
> +#define TYPE_DS1375 "ds1375"
> +#define DS1375(obj) OBJECT_CHECK(DS1375State, (obj), TYPE_DS1375)
> +
> +#define DS1375_REGSIZE 0x20
> +
> +#define R_SEC   (0x0)
> +#define R_MIN   (0x1)
> +#define R_HOUR  (0x2)
> +#define R_WDAY  (0x3)
> +#define R_DATE  (0x4)
> +#define R_MONTH (0x5)
> +#define R_YEAR  (0x6)
> +#define R_A1SEC   (0x7)
> +#define R_A1MIN   (0x8)
> +#define R_A1HOUR  (0x9)
> +#define R_A1DAY   (0xa)
> +#define R_A2SEC   (0xb)
> +#define R_A2MIN   (0xc)
> +#define R_A2HOUR  (0xd)
> +#define R_CTRL  (0xe)
> +#define R_STS   (0xf)
> +
> +FIELD(HOUR, SET12, 6, 1)
> +FIELD(HOUR, HOUR24, 0, 6)
> +FIELD(HOUR, AMPM, 5, 1)
> +FIELD(HOUR, HOUR12, 0, 5)
> +
> +FIELD(MONTH, MONTH, 0, 5)
> +FIELD(MONTH, CENTURY, 7, 1)
> +
> +FIELD(CTRL, ECLK, 7, 1)
> +FIELD(CTRL, CLKSEL, 5, 2)
> +FIELD(CTRL, RS, 3, 2)
> +FIELD(CTRL, INTCN, 2, 1)
> +FIELD(CTRL, A2IE, 1, 1)
> +FIELD(CTRL, A1IE, 0, 1)
> +
> +typedef struct DS1375State {
> +    I2CSlave parent_obj;
> +
> +    /* register address counter */
> +    uint8_t addr;
> +    /* when writing, whether the address has been sent */
> +    bool addrd;
> +
> +    int time_offset;
> +
> +    uint8_t regs[DS1375_REGSIZE];
> +} DS1375State;
> +
> +/* update current time register if clock enabled */
> +static
> +void ds1375_latch(DS1375State *ds)
> +{
> +    struct tm now;
> +
> +    if (!ARRAY_FIELD_EX32(ds->regs, CTRL, ECLK)) {
> +        return;
> +    }
> +
> +    qemu_get_timedate(&now, ds->time_offset);
> +
> +    DPRINTK("Current Time %3u/%2u/%u %2u:%2u:%2u (wday %u)\n",
> +            now.tm_year, now.tm_mon, now.tm_mday,
> +            now.tm_hour, now.tm_min, now.tm_sec,
> +            now.tm_wday);
> +
> +    /* ensure unused bits are zero */
> +    memset(ds->regs, 0, R_YEAR + 1);
> +
> +    ds->regs[R_SEC] =3D to_bcd(now.tm_sec);
> +    ds->regs[R_MIN] =3D to_bcd(now.tm_min);
> +
> +    if (ARRAY_FIELD_EX32(ds->regs, HOUR, SET12) =3D=3D 0) {
> +        /* 24 hour */
> +        ARRAY_FIELD_DP32(ds->regs, HOUR, HOUR24, to_bcd(now.tm_hour));
> +    } else {
> +        /* 12 hour am/pm */
> +        ARRAY_FIELD_DP32(ds->regs, HOUR, AMPM, now.tm_hour >=3D 12);
> +        ARRAY_FIELD_DP32(ds->regs, HOUR, HOUR12, to_bcd(now.tm_hour % 12=
u));
> +    }
> +
> +    ds->regs[R_WDAY] =3D now.tm_wday; /* day of the week */
> +    ds->regs[R_DATE] =3D to_bcd(now.tm_mday);
> +
> +    ARRAY_FIELD_DP32(ds->regs, MONTH, MONTH, to_bcd(now.tm_mon + 1));
> +    ARRAY_FIELD_DP32(ds->regs, MONTH, CENTURY, now.tm_year > 99);
> +
> +    ds->regs[R_YEAR] =3D to_bcd(now.tm_year % 100u);
> +
> +    DPRINTK("Latched time\n");
> +}
> +
> +static
> +void ds1375_update(DS1375State *ds)
> +{
> +    struct tm now;
> +
> +    now.tm_sec =3D from_bcd(ds->regs[R_SEC]);
> +    now.tm_min =3D from_bcd(ds->regs[R_MIN]);
> +
> +    if (ARRAY_FIELD_EX32(ds->regs, HOUR, SET12)) {
> +        now.tm_hour =3D from_bcd(ARRAY_FIELD_EX32(ds->regs, HOUR, HOUR12=
));
> +        if (ARRAY_FIELD_EX32(ds->regs, HOUR, AMPM)) {
> +            now.tm_hour +=3D 12;
> +        }
> +
> +    } else {
> +        now.tm_hour =3D from_bcd(ARRAY_FIELD_EX32(ds->regs, HOUR, HOUR24=
));
> +    }
> +
> +    now.tm_wday =3D from_bcd(ds->regs[R_WDAY]);
> +    now.tm_mday =3D from_bcd(ds->regs[R_DATE]);
> +    now.tm_mon =3D from_bcd(ARRAY_FIELD_EX32(ds->regs, MONTH, MONTH)) - =
1;
> +
> +    now.tm_year =3D from_bcd(ds->regs[R_YEAR]) % 100u;
> +    if (ARRAY_FIELD_EX32(ds->regs, MONTH, CENTURY)) {
> +        now.tm_year +=3D 100;
> +    }
> +
> +    DPRINTK("New Time %3u/%2u/%u %2u:%2u:%2u (wday %u)\n",
> +            now.tm_year, now.tm_mon, now.tm_mday,
> +            now.tm_hour, now.tm_min, now.tm_sec,
> +            now.tm_wday);
> +
> +    ds->time_offset =3D qemu_timedate_diff(&now);
> +    DPRINTK("Update offset =3D %d\n", ds->time_offset);
> +}
> +
> +static
> +int ds1375_event(I2CSlave *s, enum i2c_event event)
> +{
> +    DS1375State *ds =3D container_of(s, DS1375State, parent_obj);
> +
> +    switch (event) {
> +    case I2C_START_SEND:
> +        ds->addrd =3D false;
> +    case I2C_START_RECV:
> +        ds1375_latch(ds);
> +    case I2C_FINISH:
> +        DPRINTK("Event %d\n", (int)event);
> +    case I2C_NACK:
> +        break;
> +    }
> +    return 0;
> +}
> +
> +static
> +int ds1375_recv(I2CSlave *s)
> +{
> +    DS1375State *ds =3D container_of(s, DS1375State, parent_obj);
> +    int ret =3D 0;
> +
> +    switch (ds->addr) {
> +    case R_SEC ... R_YEAR:
> +    case R_CTRL:
> +    case R_STS:
> +    case 0x10 ... 0x1f:
> +        ret =3D ds->regs[ds->addr];
> +        break;
> +    default:
> +        LOG(LOG_UNIMP, "Read from unimplemented (%02x) %02x\n", ds->addr=
, ret);
> +    }
> +
> +    DPRINTK("Recv (%02x) %02x\n", ds->addr, ret);
> +
> +    ds->addr++;
> +    ds->addr &=3D 0x1f;
> +    if (ds->addr =3D=3D 0) {
> +        ds1375_latch(ds);
> +    }
> +
> +    return ret;
> +}
> +
> +static
> +int ds1375_send(I2CSlave *s, uint8_t data)
> +{
> +    DS1375State *ds =3D container_of(s, DS1375State, parent_obj);
> +
> +    if (!ds->addrd) {
> +        data &=3D 0x1f;
> +        ds->addr =3D data;
> +        DPRINTK("Set address pointer %02x\n", data);
> +        ds->addrd =3D true;
> +        return 0;
> +
> +    } else {
> +        DPRINTK("Send (%02x) %02x\n", ds->addr, data);
> +        switch (ds->addr) {
> +        case R_SEC ... R_YEAR:
> +            ds->regs[ds->addr] =3D data;
> +            ds1375_update(ds);
> +            break;
> +        case R_CTRL:
> +            if (data & 0x7) {
> +                LOG(LOG_UNIMP, "Alarm interrupt/output not modeled\n");
> +            }
> +            ds->regs[ds->addr] =3D data;
> +            break;
> +        case 0x10 ... 0x1f:
> +            ds->regs[ds->addr] =3D data;
> +            break;
> +        default:
> +            LOG(LOG_UNIMP, "Write to unimplemented (%02x) %02x\n",
> +                ds->addr, data);
> +        }
> +
> +        ds->addr++;
> +        ds->addr &=3D 0x1f;
> +        if (ds->addr =3D=3D 0) {
> +            ds1375_latch(ds);
> +        }
> +
> +        return 0;
> +    }
> +}
> +
> +static
> +void ds1375_reset(DeviceState *device)
> +{
> +    DS1375State *ds =3D DS1375(device);
> +
> +    memset(ds->regs, 0, sizeof(ds->regs));
> +    /* TODO: not clear SRAM? */
> +
> +    /* Default to 12-hour mode */
> +    ARRAY_FIELD_DP32(ds->regs, CTRL, ECLK, 1);
> +
> +    ds->addr =3D 0;
> +
> +    /* do not re-zero time offset */
> +}
> +
> +static
> +void ds1375_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +
> +    k->event =3D &ds1375_event;
> +    k->recv =3D &ds1375_recv;
> +    k->send =3D &ds1375_send;
> +
> +    dc->reset =3D &ds1375_reset;
> +}
> +
> +static
> +const TypeInfo ds1375_type =3D {
> +    .name =3D TYPE_DS1375,
> +    .parent =3D TYPE_I2C_SLAVE,
> +    .instance_size =3D sizeof(DS1375State),
> +    .class_size =3D sizeof(I2CSlaveClass),
> +    .class_init =3D ds1375_class_init,
> +};
> +
> +static void ds1375_register(void)
> +{
> +    type_register_static(&ds1375_type);
> +}
> +
> +type_init(ds1375_register)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--PtLnLSExlPr13a2X
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloU+O4ACgkQbDjKyiDZ
s5Lv2RAA0OPQz4UMrrZuwOcIHqzoi3ijdWR+9NUAQQLhMlo/WmNmBugAkPTDXMUe
adMTuxTNvLNo0RiCQ2IOVWn9u1tv2J9jmWgyK5tbnLLpBt9GIDqKlpZ/krGo+vDg
Znn0LY3xbYygMFtZH+dZU/fAcQBTHMl0BUxISYUj3gjMM/WKz95i3D2R9xQHtVJG
Yi7rZuVsbPo6oNLKfuq9Cx2UMN/rcPhNxPNA3YCScwQMwBfiipU9HOuvgWXzMben
kYu86oxLlRuKGyFcafaLK4KOOLYixzINvOxFS3vosOd+SpD8L2A++XXLVje8UcmE
dJq7DXYrmQEo6GACLrF8duUAup6f+uAo75sjVn0ICZIZSEuMNaijcIDcY6mzuUt8
tZy0b23i0FlfncG4d8iielHa7XoSt19MAEqCKfCcxvVIiDzQ2gD5NrEP7kSKEHki
eeuXzJjEW0Aw0GfJNxshyzSsxeQJ+GSbkXzwbBu0H7tq8RmQtrBAPGJBXbQm12gn
edgoYW4ugdTFiYBPGuIGRUo6rk9zc9u0VzBUx6Bd+KKvJRS0l8orI1p1qfuXyHDe
hSMj3PG4OVYqJWVhIDkTq3TUQRmmYPzIg+81l7nsCO9AkD1b+2qSw8AKnmyw5WP4
cbzIA1bMzXgoO2MxKVw9Pc4nKSBEGI68cG+lV2TRfiKXqHfFA18=
=QOUZ
-----END PGP SIGNATURE-----

--PtLnLSExlPr13a2X--
