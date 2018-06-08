Received: from eggs.gnu.org ([2001:4830:134:3::10]:48381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fRLW9-0003u9-A6
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:49:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fRLW5-0002CD-Cz
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:49:41 -0400
Received: from 8.mo5.mail-out.ovh.net ([178.32.116.78]:40448)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fRLW5-0002BZ-1z
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 13:49:37 -0400
Received: from player711.ha.ovh.net (unknown [10.109.108.51])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 447491BF34D
	for <qemu-devel@nongnu.org>; Fri,  8 Jun 2018 19:49:34 +0200 (CEST)
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<8c404c8c4ee1bfd2e4d079877d481094f797df8f.1528291908.git.balaton@eik.bme.hu>
	<e66bfc59-ee49-ebfd-ea6b-eb5abb6b22d7@kaod.org>
	<alpine.BSF.2.21.1806081804370.34300@zero.eik.bme.hu>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9ea8ac25-ff88-799e-e04b-639dd5b4a6fe@kaod.org>
Date: Fri, 8 Jun 2018 19:49:27 +0200
MIME-Version: 1.0
In-Reply-To: <alpine.BSF.2.21.1806081804370.34300@zero.eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 06/08/2018 06:16 PM, BALATON Zoltan wrote:
> On Fri, 8 Jun 2018, C=C3=A9dric Le Goater wrote:
>> On 06/06/2018 03:31 PM, BALATON Zoltan wrote:
>>> Basic emulation of the M41T80 serial (I2C) RTC chip. Only getting tim=
e
>>> of day is implemented. Setting time and RTC alarm are not supported.
>>>
>>> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
>>> ---
>>> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 +
>>> =C2=A0default-configs/ppc-softmmu.mak |=C2=A0=C2=A0 1 +
>>> =C2=A0hw/timer/Makefile.objs=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
>>> =C2=A0hw/timer/m41t80.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 117 ++++++++++++++++++++++++++++++=
++++++++++
>>> =C2=A04 files changed, 120 insertions(+)
>>> =C2=A0create mode 100644 hw/timer/m41t80.c
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index 41cd373..9e13bc1 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -826,6 +826,7 @@ M: BALATON Zoltan <balaton@eik.bme.hu>
>>> =C2=A0L: qemu-ppc@nongnu.org
>>> =C2=A0S: Maintained
>>> =C2=A0F: hw/ide/sii3112.c
>>> +F: hw/timer/m41t80.c
>>>
>>> =C2=A0SH4 Machines
>>> =C2=A0------------
>>> diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-so=
ftmmu.mak
>>> index 7d0dc2f..9fbaadc 100644
>>> --- a/default-configs/ppc-softmmu.mak
>>> +++ b/default-configs/ppc-softmmu.mak
>>> @@ -27,6 +27,7 @@ CONFIG_SM501=3Dy
>>> =C2=A0CONFIG_IDE_SII3112=3Dy
>>> =C2=A0CONFIG_I2C=3Dy
>>> =C2=A0CONFIG_BITBANG_I2C=3Dy
>>> +CONFIG_M41T80=3Dy
>>>
>>> =C2=A0# For Macs
>>> =C2=A0CONFIG_MAC=3Dy
>>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>>> index 8b27a4b..e16b2b9 100644
>>> --- a/hw/timer/Makefile.objs
>>> +++ b/hw/timer/Makefile.objs
>>> @@ -6,6 +6,7 @@ common-obj-$(CONFIG_CADENCE) +=3D cadence_ttc.o
>>> =C2=A0common-obj-$(CONFIG_DS1338) +=3D ds1338.o
>>> =C2=A0common-obj-$(CONFIG_HPET) +=3D hpet.o
>>> =C2=A0common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
>>> +common-obj-$(CONFIG_M41T80) +=3D m41t80.o
>>> =C2=A0common-obj-$(CONFIG_M48T59) +=3D m48t59.o
>>> =C2=A0ifeq ($(CONFIG_ISA_BUS),y)
>>> =C2=A0common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
>>> diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
>>> new file mode 100644
>>> index 0000000..9dbdb1b
>>> --- /dev/null
>>> +++ b/hw/timer/m41t80.c
>>> @@ -0,0 +1,117 @@
>>> +/*
>>> + * M41T80 serial rtc emulation
>>> + *
>>> + * Copyright (c) 2018 BALATON Zoltan
>>> + *
>>> + * This work is licensed under the GNU GPL license version 2 or late=
r.
>>> + *
>>> + */
>>> +
>>> +#include "qemu/osdep.h"
>>> +#include "qemu/log.h"
>>> +#include "qemu/timer.h"
>>> +#include "qemu/bcd.h"
>>> +#include "hw/i2c/i2c.h"
>>> +
>>> +#define TYPE_M41T80 "m41t80"
>>> +#define M41T80(obj) OBJECT_CHECK(M41t80State, (obj), TYPE_M41T80)
>>> +
>>> +typedef struct M41t80State {
>>> +=C2=A0=C2=A0=C2=A0 I2CSlave parent_obj;
>>> +=C2=A0=C2=A0=C2=A0 int8_t addr;
>>> +} M41t80State;
>>> +
>>> +static void m41t80_realize(DeviceState *dev, Error **errp)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 M41t80State *s =3D M41T80(dev);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 s->addr =3D -1;
>>> +}
>>> +
>>> +static int m41t80_send(I2CSlave *i2c, uint8_t data)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 M41t80State *s =3D M41T80(i2c);
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (s->addr < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->addr =3D data;
>>> +=C2=A0=C2=A0=C2=A0 } else {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->addr++;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 return 0;
>>> +}
>>> +
>>> +static int m41t80_recv(I2CSlave *i2c)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0 M41t80State *s =3D M41T80(i2c);
>>> +=C2=A0=C2=A0=C2=A0 struct tm now;
>>> +=C2=A0=C2=A0=C2=A0 qemu_timeval tv;
>>> +
>>> +=C2=A0=C2=A0=C2=A0 if (s->addr < 0) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->addr =3D 0;
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 if (s->addr >=3D 1 && s->addr <=3D 7) {
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_get_timedate(&now, -=
1);
>>> +=C2=A0=C2=A0=C2=A0 }
>>> +=C2=A0=C2=A0=C2=A0 switch (s->addr++) {
>>
>> you could use some define to name the registers :
>=20
> This was also suggested by Philippe Mathieu-Daud=C3=A9 and my answer to=
 that was that I don't feel like I want to come up with names the datashe=
et does not have either. I think this device is simple enough with just 2=
0 consecutively numbered registers that appear only in these switch cases=
 by number as in the datasheet table so that I don't want to make it more=
 difficult to read by encrypting these numbers behind some arbitrary defi=
nes without a good reason. They are also so simple that it's clear from t=
he usually one line implementation what they do so that's also not a good=
 reason to name them.

OK. It's fine with me but you might get some inspiration from Linux=20
for the names :)

>>> +=C2=A0=C2=A0=C2=A0 case 0:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_gettimeofday(&tv);
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to_bcd(tv.tv_usec =
/ 10000);> +=C2=A0=C2=A0=C2=A0 case 1:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to_bcd(now.tm_sec)=
;
>>> +=C2=A0=C2=A0=C2=A0 case 2:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to_bcd(now.tm_min)=
;
>>> +=C2=A0=C2=A0=C2=A0 case 3:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to_bcd(now.tm_hour=
);
>>
>> There is an interesting century bit in specs.
>=20
> Which I could not figure out how should work and guests seem to be happ=
y without it so I did not try to implement it.

yes. It seems that Linux simply ignores it. Let's forget it.

Thanks,
C.

>>> +=C2=A0=C2=A0=C2=A0 case 4:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to_bcd(now.tm_wday=
);
>>> +=C2=A0=C2=A0=C2=A0 case 5:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to_bcd(now.tm_mday=
);
>>> +=C2=A0=C2=A0=C2=A0 case 6:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to_bcd(now.tm_mon =
+ 1);
>>> +=C2=A0=C2=A0=C2=A0 case 7:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return to_bcd(now.tm_year=
 % 100);
>>> +=C2=A0=C2=A0=C2=A0 case 8 ... 19:
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qemu_log_mask(LOG_UNIMP, =
"\n%s: unimplemented register: %d\n",
>>
>> is the beginning \n needed ?
>=20
> Probably not, maybe left there due to previous debug logs I've removed.=
 I'll drop the beginning \n-s in next version.
>=20
>> Thanks,
>>
>> C.
>=20
> Thanks for the review,
> BALATON Zoltan
