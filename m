Received: from eggs.gnu.org ([2001:4830:134:3::10]:47062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQcLP-0006eo-R2
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:35:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fQcLK-0002Jw-SL
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 13:35:35 -0400
Date: Wed, 6 Jun 2018 19:35:28 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <6aa1bc4e-a4b0-d7be-b9eb-85dfe8c06781@amsat.org>
Message-ID: <alpine.BSF.2.21.1806061920120.94568@zero.eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<8c404c8c4ee1bfd2e4d079877d481094f797df8f.1528291908.git.balaton@eik.bme.hu>
	<6aa1bc4e-a4b0-d7be-b9eb-85dfe8c06781@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/8] hw/timer: Add basic M41T80 emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Alexander Graf <agraf@suse.de>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 6 Jun 2018, Philippe Mathieu-Daud=C3=A9 wrote:
> On 06/06/2018 10:31 AM, BALATON Zoltan wrote:
>> Basic emulation of the M41T80 serial (I2C) RTC chip. Only getting time
>> of day is implemented. Setting time and RTC alarm are not supported.
[...]
>> diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
>> new file mode 100644
>> index 0000000..9dbdb1b
>> --- /dev/null
>> +++ b/hw/timer/m41t80.c
>> @@ -0,0 +1,117 @@
>> +/*
>> + * M41T80 serial rtc emulation
>> + *
>> + * Copyright (c) 2018 BALATON Zoltan
>> + *
>> + * This work is licensed under the GNU GPL license version 2 or later=
.
>> + *
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "qemu/timer.h"
>> +#include "qemu/bcd.h"
>> +#include "hw/i2c/i2c.h"
>> +
>> +#define TYPE_M41T80 "m41t80"
>> +#define M41T80(obj) OBJECT_CHECK(M41t80State, (obj), TYPE_M41T80)
>> +
>> +typedef struct M41t80State {
>> +    I2CSlave parent_obj;
>> +    int8_t addr;
>> +} M41t80State;
>> +
>> +static void m41t80_realize(DeviceState *dev, Error **errp)
>> +{
>> +    M41t80State *s =3D M41T80(dev);
>> +
>> +    s->addr =3D -1;
>> +}
>> +
>> +static int m41t80_send(I2CSlave *i2c, uint8_t data)
>> +{
>> +    M41t80State *s =3D M41T80(i2c);
>> +
>> +    if (s->addr < 0) {
>> +        s->addr =3D data;
>> +    } else {
>> +        s->addr++;
>> +    }
>
> What about adding enum i2c_event in M41t80State and use the enum here
> rather than the addr < 0? Also this wrap at INT8_MAX =3D 127, is this
> expected?

Thanks for the review. I guess we could add enum for device bytes and the=
=20
special case -1 meaning no register address selected yet but this is a=20
very simple device with only 20 bytes and the datasheet also lists them b=
y=20
number without naming them so I think we can also refer to them by number=
.=20
Since the device has only this 20 bytes the case with 127 should also not=
=20
be a problem as that's invalid address anyway. Or did you mean something=20
else?

>> +    return 0;
>> +}
>> +
>> +static int m41t80_recv(I2CSlave *i2c)
>> +{
>> +    M41t80State *s =3D M41T80(i2c);
>> +    struct tm now;
>> +    qemu_timeval tv;
>
>       int8_t addr;
>
>> +
>> +    if (s->addr < 0) {
>> +        s->addr =3D 0;
>> +    }
>
>       addr =3D s->addr++;
>
> So you can simply use 'addr' bellow.

But that would mean numbers in switch cases below would be +1 compared to=
=20
how they are listed in the register map in the datasheet but now they=20
match so I'd leave it like this. (In case someone wants to check this wit=
h=20
the datasheet, the one I could find on-line says the range of register=20
number 4 (holding day of week) is 1-7 but U-Boot and clients expect 0-6 s=
o=20
I think it's a bug in the datasheet and clients were tested on hardware.)

Regards,
BALATON Zoltan

>> +    if (s->addr >=3D 1 && s->addr <=3D 7) {
>> +        qemu_get_timedate(&now, -1);
>> +    }
>> +    switch (s->addr++) {
>> +    case 0:
>> +        qemu_gettimeofday(&tv);
>> +        return to_bcd(tv.tv_usec / 10000);
>> +    case 1:
>> +        return to_bcd(now.tm_sec);
>> +    case 2:
>> +        return to_bcd(now.tm_min);
>> +    case 3:
>> +        return to_bcd(now.tm_hour);
>> +    case 4:
>> +        return to_bcd(now.tm_wday);
>> +    case 5:
>> +        return to_bcd(now.tm_mday);
>> +    case 6:
>> +        return to_bcd(now.tm_mon + 1);
>> +    case 7:
>> +        return to_bcd(now.tm_year % 100);
>> +    case 8 ... 19:
>> +        qemu_log_mask(LOG_UNIMP, "\n%s: unimplemented register: %d\n"=
,
>> +                      __func__, s->addr - 1);
>> +        return 0;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR, "\n%s: invalid register: %d",
>> +                      __func__, s->addr - 1);
>> +        return 0;
>> +    }
>> +}
>> +
>> +static int m41t80_event(I2CSlave *i2c, enum i2c_event event)
>> +{
>> +    M41t80State *s =3D M41T80(i2c);
>> +
>> +    if (event =3D=3D I2C_START_SEND) {
>> +        s->addr =3D -1;
>> +    }
>> +    return 0;
>> +}
>> +
>> +static void m41t80_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +    I2CSlaveClass *sc =3D I2C_SLAVE_CLASS(klass);
>> +
>> +    dc->realize =3D m41t80_realize;
>> +    sc->send =3D m41t80_send;
>> +    sc->recv =3D m41t80_recv;
>> +    sc->event =3D m41t80_event;
>> +}
>> +
>> +static const TypeInfo m41t80_info =3D {
>> +    .name          =3D TYPE_M41T80,
>> +    .parent        =3D TYPE_I2C_SLAVE,
>> +    .instance_size =3D sizeof(M41t80State),
>> +    .class_init    =3D m41t80_class_init,
>> +};
>> +
>> +static void m41t80_register_types(void)
>> +{
>> +    type_register_static(&m41t80_info);
>> +}
>> +
>> +type_init(m41t80_register_types)
>>
>
>
