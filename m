Received: from eggs.gnu.org ([2001:4830:134:3::10]:56912)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fT1Ul-00044q-9d
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:51:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <balaton@eik.bme.hu>) id 1fT1Ui-00050h-5f
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:51:11 -0400
Date: Wed, 13 Jun 2018 10:50:59 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
In-Reply-To: <20180613041115.GS30690@umbus.fritz.box>
Message-ID: <alpine.BSF.2.21.1806131044020.620@zero.eik.bme.hu>
References: <cover.1528291908.git.balaton@eik.bme.hu>
	<8c404c8c4ee1bfd2e4d079877d481094f797df8f.1528291908.git.balaton@eik.bme.hu>
	<6aa1bc4e-a4b0-d7be-b9eb-85dfe8c06781@amsat.org>
	<alpine.BSF.2.21.1806061920120.94568@zero.eik.bme.hu>
	<20180613041115.GS30690@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
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
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org, =?ISO-8859-15?Q?Philippe_Mathieu-Daud=E9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

On Wed, 13 Jun 2018, David Gibson wrote:
> On Wed, Jun 06, 2018 at 07:35:28PM +0200, BALATON Zoltan wrote:
>> On Wed, 6 Jun 2018, Philippe Mathieu-Daud=E9 wrote:
>>> On 06/06/2018 10:31 AM, BALATON Zoltan wrote:
>>>> Basic emulation of the M41T80 serial (I2C) RTC chip. Only getting ti=
me
>>>> of day is implemented. Setting time and RTC alarm are not supported.
>> [...]
>>>> diff --git a/hw/timer/m41t80.c b/hw/timer/m41t80.c
>>>> new file mode 100644
>>>> index 0000000..9dbdb1b
>>>> --- /dev/null
>>>> +++ b/hw/timer/m41t80.c
>>>> @@ -0,0 +1,117 @@
>>>> +/*
>>>> + * M41T80 serial rtc emulation
>>>> + *
>>>> + * Copyright (c) 2018 BALATON Zoltan
>>>> + *
>>>> + * This work is licensed under the GNU GPL license version 2 or lat=
er.
>>>> + *
>>>> + */
>>>> +
>>>> +#include "qemu/osdep.h"
>>>> +#include "qemu/log.h"
>>>> +#include "qemu/timer.h"
>>>> +#include "qemu/bcd.h"
>>>> +#include "hw/i2c/i2c.h"
>>>> +
>>>> +#define TYPE_M41T80 "m41t80"
>>>> +#define M41T80(obj) OBJECT_CHECK(M41t80State, (obj), TYPE_M41T80)
>>>> +
>>>> +typedef struct M41t80State {
>>>> +    I2CSlave parent_obj;
>>>> +    int8_t addr;
>>>> +} M41t80State;
>>>> +
>>>> +static void m41t80_realize(DeviceState *dev, Error **errp)
>>>> +{
>>>> +    M41t80State *s =3D M41T80(dev);
>>>> +
>>>> +    s->addr =3D -1;
>>>> +}
>>>> +
>>>> +static int m41t80_send(I2CSlave *i2c, uint8_t data)
>>>> +{
>>>> +    M41t80State *s =3D M41T80(i2c);
>>>> +
>>>> +    if (s->addr < 0) {
>>>> +        s->addr =3D data;
>>>> +    } else {
>>>> +        s->addr++;
>>>> +    }
>>>
>>> What about adding enum i2c_event in M41t80State and use the enum here
>>> rather than the addr < 0? Also this wrap at INT8_MAX =3D 127, is this
>>> expected?
>>
>> Thanks for the review. I guess we could add enum for device bytes and =
the
>> special case -1 meaning no register address selected yet but this is a=
 very
>> simple device with only 20 bytes and the datasheet also lists them by =
number
>> without naming them so I think we can also refer to them by number. Si=
nce
>> the device has only this 20 bytes the case with 127 should also not be=
 a
>> problem as that's invalid address anyway. Or did you mean something el=
se?
>
> So, I'm not particularly in favour of adding extra state variables.
>
> But is using addr < 0 safe here?  You're assigning the uint8_t data to
> addr - could that result in a negative value?

Why wouldn't it be safe with the expected values for register address=20
between 0-19? If the guest sends garbage values over 127 it will either=20
result in invalid register or unselected register and lead to an error=20
when trying to read/write that register so I don't see what other problem=
=20
this may cause.

The addr < 0 is to check if no address was selected before (on creating=20
the device and when sending first value from host addr is set to -1. In=20
this case first write will set register address, then subsequent=20
reads/writes increment register address as the datasheet says).

Regards,
BALATON Zoltan
