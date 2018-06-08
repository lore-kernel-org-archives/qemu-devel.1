Received: from eggs.gnu.org ([2001:4830:134:3::10]:55168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fRK4d-0002Gp-Aj
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:17:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fRK4Z-0000Gl-BV
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 12:17:11 -0400
Date: Fri, 8 Jun 2018 18:16:57 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <e66bfc59-ee49-ebfd-ea6b-eb5abb6b22d7@kaod.org>
Message-ID: <alpine.BSF.2.21.1806081804370.34300@zero.eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<8c404c8c4ee1bfd2e4d079877d481094f797df8f.1528291908.git.balaton@eik.bme.hu>
	<e66bfc59-ee49-ebfd-ea6b-eb5abb6b22d7@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: =?ISO-8859-15?Q?C=E9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Fri, 8 Jun 2018, C=C3=A9dric Le Goater wrote:
> On 06/06/2018 03:31 PM, BALATON Zoltan wrote:
>> Basic emulation of the M41T80 serial (I2C) RTC chip. Only getting time
>> of day is implemented. Setting time and RTC alarm are not supported.
>>
>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>> ---
>>  MAINTAINERS                     |   1 +
>>  default-configs/ppc-softmmu.mak |   1 +
>>  hw/timer/Makefile.objs          |   1 +
>>  hw/timer/m41t80.c               | 117 +++++++++++++++++++++++++++++++=
+++++++++
>>  4 files changed, 120 insertions(+)
>>  create mode 100644 hw/timer/m41t80.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 41cd373..9e13bc1 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -826,6 +826,7 @@ M: BALATON Zoltan <balaton@eik.bme.hu>
>>  L: qemu-ppc@nongnu.org
>>  S: Maintained
>>  F: hw/ide/sii3112.c
>> +F: hw/timer/m41t80.c
>>
>>  SH4 Machines
>>  ------------
>> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-sof=
tmmu.mak
>> index 7d0dc2f..9fbaadc 100644
>> --- a/default-configs/ppc-softmmu.mak
>> +++ b/default-configs/ppc-softmmu.mak
>> @@ -27,6 +27,7 @@ CONFIG_SM501=3Dy
>>  CONFIG_IDE_SII3112=3Dy
>>  CONFIG_I2C=3Dy
>>  CONFIG_BITBANG_I2C=3Dy
>> +CONFIG_M41T80=3Dy
>>
>>  # For Macs
>>  CONFIG_MAC=3Dy
>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> index 8b27a4b..e16b2b9 100644
>> --- a/hw/timer/Makefile.objs
>> +++ b/hw/timer/Makefile.objs
>> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_CADENCE) +=3D cadence_ttc.o
>>  common-obj-$(CONFIG_DS1338) +=3D ds1338.o
>>  common-obj-$(CONFIG_HPET) +=3D hpet.o
>>  common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
>> +common-obj-$(CONFIG_M41T80) +=3D m41t80.o
>>  common-obj-$(CONFIG_M48T59) +=3D m48t59.o
>>  ifeq ($(CONFIG_ISA_BUS),y)
>>  common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
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
>> +    return 0;
>> +}
>> +
>> +static int m41t80_recv(I2CSlave *i2c)
>> +{
>> +    M41t80State *s =3D M41T80(i2c);
>> +    struct tm now;
>> +    qemu_timeval tv;
>> +
>> +    if (s->addr < 0) {
>> +        s->addr =3D 0;
>> +    }
>> +    if (s->addr >=3D 1 && s->addr <=3D 7) {
>> +        qemu_get_timedate(&now, -1);
>> +    }
>> +    switch (s->addr++) {
>
> you could use some define to name the registers :

This was also suggested by Philippe Mathieu-Daud=C3=A9 and my answer to t=
hat=20
was that I don't feel like I want to come up with names the datasheet doe=
s=20
not have either. I think this device is simple enough with just 20=20
consecutively numbered registers that appear only in these switch cases b=
y=20
number as in the datasheet table so that I don't want to make it more=20
difficult to read by encrypting these numbers behind some arbitrary=20
defines without a good reason. They are also so simple that it's clear=20
from the usually one line implementation what they do so that's also not =
a=20
good reason to name them.

>> +    case 0:
>> +        qemu_gettimeofday(&tv);
>> +        return to_bcd(tv.tv_usec / 10000);> +    case 1:
>> +        return to_bcd(now.tm_sec);
>> +    case 2:
>> +        return to_bcd(now.tm_min);
>> +    case 3:
>> +        return to_bcd(now.tm_hour);
>
> There is an interesting century bit in specs.

Which I could not figure out how should work and guests seem to be happy=20
without it so I did not try to implement it.

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
>
> is the beginning \n needed ?

Probably not, maybe left there due to previous debug logs I've removed.=20
I'll drop the beginning \n-s in next version.

> Thanks,
>
> C.

Thanks for the review,
BALATON Zoltan
