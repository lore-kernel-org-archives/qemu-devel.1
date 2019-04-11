Received: from eggs.gnu.org ([209.51.188.92]:49848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEbei-0001fg-8Q
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:30:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1hEbeg-0001zp-58
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:30:24 -0400
Received: from 17.mo7.mail-out.ovh.net ([188.165.35.227]:56503)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1hEbeZ-0001uG-2i
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 11:30:17 -0400
Received: from player792.ha.ovh.net (unknown [10.109.160.76])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id 8A25C10D670
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 17:30:12 +0200 (CEST)
References: <20190328062222.8409-1-joel@jms.id.au>
	<20190328062222.8409-2-joel@jms.id.au>
	<CAFEAcA_K1Rv1G-s=ndVYX6i_BvWME6ToShL6ZBpB4gnE3zdZdA@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <89438392-9a54-7f43-5dff-6ceeffaf9f3e@kaod.org>
Date: Thu, 11 Apr 2019 17:30:04 +0200
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_K1Rv1G-s=ndVYX6i_BvWME6ToShL6ZBpB4gnE3zdZdA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw: timer: Add ASPEED RTC device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>
Cc: Andrew Jeffery <andrew@aj.id.au>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 4/11/19 5:25 PM, Peter Maydell wrote:
> On Thu, 28 Mar 2019 at 06:22, Joel Stanley <joel@jms.id.au> wrote:
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/timer/Makefile.objs        |   2 +-
>>  hw/timer/aspeed_rtc.c         | 157 +++++++++++++++++++++++++++++++++=
+
>>  hw/timer/trace-events         |   4 +
>>  include/hw/timer/aspeed_rtc.h |  31 +++++++
>>  4 files changed, 193 insertions(+), 1 deletion(-)
>>  create mode 100644 hw/timer/aspeed_rtc.c
>>  create mode 100644 include/hw/timer/aspeed_rtc.h
>>
>> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
>> index 0e9a4530f848..123d92c9692c 100644
>> --- a/hw/timer/Makefile.objs
>> +++ b/hw/timer/Makefile.objs
>> @@ -41,7 +41,7 @@ obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
>>  obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a10-pit.o
>>
>>  common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
>> -common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o
>> +common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o aspeed_rtc.o
>>
>>  common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
>>  common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
>> diff --git a/hw/timer/aspeed_rtc.c b/hw/timer/aspeed_rtc.c
>> new file mode 100644
>> index 000000000000..daccf00eccdc
>> --- /dev/null
>> +++ b/hw/timer/aspeed_rtc.c
>> @@ -0,0 +1,157 @@
>> +/*
>> + * ASPEED Real Time Clock
>> + * Joel Stanley <joel@jms.id.au>
>> + *
>> + * Copyright 2019 IBM Corp
>> + * SPDX-License-Identifier: GPL-2.0-or-later
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu-common.h"
>> +#include "hw/timer/aspeed_rtc.h"
>> +#include "qemu/log.h"
>> +#include "qemu/timer.h"
>> +
>> +#include "trace.h"
>> +
>> +#define COUNTER1        (0x00 / 4)
>> +#define COUNTER2        (0x04 / 4)
>> +#define ALARM           (0x08 / 4)
>> +#define CONTROL         (0x10 / 4)
>> +#define ALARM_STATUS    (0x14 / 4)
>=20
> Not mandatory, but you might like the REG32() macro in
> hw/registerfields.h which defines A_FOO and R_FOO
> constants for you for the addresses and the indexes.

Yes. May be we should start using these macros in all our models.

>=20
>> +
>> +#define RTC_UNLOCKED    BIT(1)
>> +#define RTC_ENABLED     BIT(0)
>> +
>> +static void aspeed_rtc_calc_offset(AspeedRtcState *rtc)
>> +{
>> +    struct tm tm;
>> +    uint32_t year, cent;
>> +    uint32_t reg1 =3D rtc->reg[COUNTER1];
>> +    uint32_t reg2 =3D rtc->reg[COUNTER2];
>> +
>> +    tm.tm_mday =3D (reg1 >> 24) & 0x1f;
>> +    tm.tm_hour =3D (reg1 >> 16) & 0x1f;
>> +    tm.tm_min =3D (reg1 >> 8) & 0x3f;
>> +    tm.tm_sec =3D (reg1 >> 0) & 0x3f;
>=20
> Shift by zero ?
>=20
> Consider using extract32() rather than by-hand shift and mask.

What about the FIELD*() macros in hw/registerfields.h ?

Thanks,

C.

>=20
>> +
>> +    cent =3D (reg2 >> 16) & 0x1f;
>> +    year =3D (reg2 >> 8) & 0x7f;
>> +    tm.tm_mon =3D ((reg2 >>  0) & 0x0f) - 1;
>> +    tm.tm_year =3D year + (cent * 100) - 1900;
>> +
>> +    rtc->offset =3D qemu_timedate_diff(&tm);
>> +}
>> +
>> +static uint32_t aspeed_rtc_get_counter(AspeedRtcState *rtc, int r)
>> +{
>> +    uint32_t year, cent;
>> +    struct tm now;
>> +
>> +    qemu_get_timedate(&now, rtc->offset);
>> +
>> +    switch (r) {
>> +    case COUNTER1:
>> +        return (now.tm_mday << 24) | (now.tm_hour << 16) |
>> +            (now.tm_min << 8) | now.tm_sec;
>> +    case COUNTER2:
>> +        cent =3D (now.tm_year + 1900) / 100;
>> +        year =3D now.tm_year % 100;
>> +        return ((cent & 0x1f) << 16) | ((year & 0x7f) << 8) |
>> +            ((now.tm_mon + 1) & 0xf);
>> +    default:
>> +        abort();
>=20
> More usually written g_assert_not_reached().
>=20
>> +    }
>> +}
>> +
>> +static uint64_t aspeed_rtc_read(void *opaque, hwaddr addr,
>> +                                unsigned size)
>> +{
>> +    AspeedRtcState *rtc =3D opaque;
>> +    uint64_t val;
>> +    uint32_t r =3D addr >> 2;
>> +
>> +    switch (r) {
>> +    case COUNTER1:
>> +    case COUNTER2:
>> +        if (rtc->reg[CONTROL] & RTC_ENABLED) {
>> +            rtc->reg[r] =3D aspeed_rtc_get_counter(rtc, r);
>> +        }
>=20
> If this is deliberately going to fall through to the next
> case then it should have a /* fall through */ comment
> (ditto in the write fn).
>=20
>> +    case ALARM:
>> +    case CONTROL:
>> +    case ALARM_STATUS:
>> +        val =3D rtc->reg[r];
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_UNIMP, "%s: 0x%" HWADDR_PRIx "\n", __func__=
, addr);
>> +        return 0;
>> +    }
>> +
>> +    trace_aspeed_rtc_read(addr, val);
>> +
>> +    return val;
>> +}
>=20
>> +static void aspeed_rtc_class_init(ObjectClass *klass, void *data)
>> +{
>> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
>> +
>> +    dc->realize =3D aspeed_rtc_realize;
>=20
> This is missing a reset function and vmstate.
>=20
> thanks
> -- PMM
>=20
