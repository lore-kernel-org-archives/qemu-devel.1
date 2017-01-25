Received: from eggs.gnu.org ([2001:4830:134:3::10]:48498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cWQRl-00085r-82
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cWQRj-0007OE-Ue
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:29:21 -0500
Received: from 5.mo5.mail-out.ovh.net ([87.98.173.103]:32968)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cWQRj-0007Mz-L9
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:29:19 -0500
Received: from player695.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id EB1EF93837
	for <qemu-devel@nongnu.org>; Wed, 25 Jan 2017 17:29:10 +0100 (CET)
References: <1484758531-15093-1-git-send-email-clg@kaod.org>
	<1484758531-15093-2-git-send-email-clg@kaod.org>
	<CAFEAcA-nGU+4ddOGO-kJnbayvOy6cn9DA9ZXfT7w7-_grvgLVg@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <bdd36435-3e1f-1fa6-1e70-a7dbf42a3792@kaod.org>
Date: Wed, 25 Jan 2017 17:29:03 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-nGU+4ddOGO-kJnbayvOy6cn9DA9ZXfT7w7-_grvgLVg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] wdt: Add Aspeed watchdog device model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@aj.id.au>

On 01/24/2017 12:50 PM, Peter Maydell wrote:
> On 18 January 2017 at 16:55, C=C3=A9dric Le Goater <clg@kaod.org> wrote=
:
>> From: Joel Stanley <joel@jms.id.au>
>>
>> The Aspeed SoC includes a set of watchdog timers using 32-bit
>> decrement counters, which can be based either on the APB clock or
>> a 1 MHz clock.
>>
>> The watchdog timer is designed to prevent system deadlock and, in
>> general, it should be restarted before timeout. When a timeout occurs,
>> different types of signals can be generated, ARM reset, SOC reset,
>> System reset, CPU Interrupt, external signal or boot from alternate
>> block. The current model only performs the system reset function as
>> this is used by U-Boot and Linux.
>>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> [clg: - fixed compile breakage
>>       - fixed io region size
>>       - added watchdog_perform_action() on timer expiry
>>       - wrote a commit log
>>       - merged fixes from Andrew Jeffery to scale the reload value ]
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  hw/watchdog/Makefile.objs        |   1 +
>>  hw/watchdog/wdt_aspeed.c         | 214 ++++++++++++++++++++++++++++++=
+++++++++
>>  include/hw/watchdog/wdt_aspeed.h |  37 +++++++
>>  3 files changed, 252 insertions(+)
>>  create mode 100644 hw/watchdog/wdt_aspeed.c
>>  create mode 100644 include/hw/watchdog/wdt_aspeed.h
>>
>> diff --git a/hw/watchdog/Makefile.objs b/hw/watchdog/Makefile.objs
>> index 72e3ffd93c59..9589bed63a3d 100644
>> --- a/hw/watchdog/Makefile.objs
>> +++ b/hw/watchdog/Makefile.objs
>> @@ -2,3 +2,4 @@ common-obj-y +=3D watchdog.o
>>  common-obj-$(CONFIG_WDT_IB6300ESB) +=3D wdt_i6300esb.o
>>  common-obj-$(CONFIG_WDT_IB700) +=3D wdt_ib700.o
>>  common-obj-$(CONFIG_WDT_DIAG288) +=3D wdt_diag288.o
>> +common-obj-$(CONFIG_ASPEED_SOC) +=3D wdt_aspeed.o
>> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
>> new file mode 100644
>> index 000000000000..96e62c54dc04
>> --- /dev/null
>> +++ b/hw/watchdog/wdt_aspeed.c
>> @@ -0,0 +1,214 @@
>> +/*
>> + * ASPEED Watchdog Controller
>> + *
>> + * Copyright (C) 2016-2017 IBM Corp.
>> + *
>> + * This code is licensed under the GPL version 2 or later. See the
>> + * COPYING file in the top-level directory.
>> + */
>> +
>> +#include "qemu/osdep.h"
>> +#include "qemu/log.h"
>> +#include "sysemu/watchdog.h"
>> +#include "hw/sysbus.h"
>> +#include "qemu/timer.h"
>> +#include "hw/watchdog/wdt_aspeed.h"
>> +
>> +#define WDT_IO_REGION_SIZE      0x20
>> +
>> +#define WDT_STATUS              0x00
>> +#define WDT_RELOAD_VALUE        0x04
>> +#define WDT_RESTART             0x08
>> +#define WDT_CTRL                0x0C
>> +#define WDT_TIMEOUT_STATUS      0x10
>> +#define WDT_TIMEOUT_CLEAR       0x14
>> +#define WDT_RESET_WDITH         0x18
>> +
>> +#define WDT_RESTART_MAGIC       0x4755
>> +
>> +static uint64_t aspeed_wdt_read(void *opaque, hwaddr offset, unsigned=
 size)
>> +{
>> +    AspeedWDTState *s =3D ASPEED_WDT(opaque);
>> +
>> +    switch (offset) {
>> +    case WDT_STATUS:
>> +        return s->reg_status;
>> +    case WDT_RELOAD_VALUE:
>> +        return s->reg_reload_value;
>> +    case WDT_RESTART:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: read from write-only reg at offset 0x%"
>> +                      HWADDR_PRIx "\n", __func__, offset);
>> +        return 0;
>> +    case WDT_CTRL:
>> +        return s->reg_ctrl;
>> +    case WDT_TIMEOUT_STATUS:
>> +    case WDT_TIMEOUT_CLEAR:
>> +    case WDT_RESET_WDITH:
>> +        qemu_log_mask(LOG_UNIMP,
>> +                      "%s: uninmplemented read at offset 0x%" HWADDR_=
PRIx "\n",
>> +                      __func__, offset);
>> +        return 0;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Out-of-bounds read at offset 0x%" HWADDR_P=
RIx "\n",
>> +                      __func__, offset);
>> +        return 0;
>> +    }
>> +
>> +}
>> +
>> +#define PCLK_HZ 24000000
>> +
>> +static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t da=
ta,
>> +                             unsigned size)
>> +{
>> +    AspeedWDTState *s =3D ASPEED_WDT(opaque);
>> +    bool en =3D data & BIT(0);
>> +    bool pclk =3D !(data & BIT(4));
>=20
> These are only valid for WDT_CTRL, right? That being so,
> initialising them up here is a bit odd.

Well, pclk is for the WDT_RESTART reg also. But, yes, it=20
can be improved.

>> +
>> +    switch (offset) {
>> +    case WDT_STATUS:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: write to read-only reg at offset 0x%"
>> +                      HWADDR_PRIx "\n", __func__, offset);
>> +        break;
>> +    case WDT_RELOAD_VALUE:
>> +        s->reg_reload_value =3D data;
>> +        break;
>> +    case WDT_RESTART:
>> +        if ((data & 0xFFFF) =3D=3D 0x4755) {
>> +            uint32_t reload;
>> +
>> +            s->reg_status =3D s->reg_reload_value;
>> +
>> +            if (pclk) {
>> +                reload =3D muldiv64(s->reg_reload_value, NANOSECONDS_=
PER_SECOND,
>> +                                  PCLK_HZ) ;
>> +            } else {
>> +                reload =3D s->reg_reload_value * 1000;
>> +            }
>> +
>> +            if (s->enabled) {
>> +                timer_mod(s->timer,
>> +                          qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + rel=
oad);
>> +            }
>> +        }
>> +        break;
>> +    case WDT_CTRL:
>> +        if (en && !s->enabled) {
>> +            uint32_t reload;
>> +
>> +            if (pclk) {
>> +                reload =3D muldiv64(s->reg_reload_value, NANOSECONDS_=
PER_SECOND,
>> +                                  PCLK_HZ);
>> +            } else {
>> +                reload =3D s->reg_reload_value * 1000;
>> +            }
>> +
>> +            s->enabled =3D true;
>> +            timer_mod(s->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL)=
 + reload);
>> +        } else if (!en && s->enabled) {
>> +            s->enabled =3D false;
>> +            timer_del(s->timer);
>> +        }
>> +        break;
>=20
> Shouldn't this write to s->reg_ctrl ?
>=20
> s->enabled seems to duplicate state also in s->reg_ctrl.

yes clearly. I will use a regs array in next version,=20
it should be cleaner and also migration friendly.=20
I completely left out that part.=20

Thanks,

C. =20


>> +    case WDT_TIMEOUT_STATUS:
>> +    case WDT_TIMEOUT_CLEAR:
>> +    case WDT_RESET_WDITH:
>> +        qemu_log_mask(LOG_UNIMP,
>> +                      "%s: uninmplemented write at offset 0x%" HWADDR=
_PRIx "\n",
>> +                      __func__, offset);
>> +        break;
>> +    default:
>> +        qemu_log_mask(LOG_GUEST_ERROR,
>> +                      "%s: Out-of-bounds write at offset 0x%" HWADDR_=
PRIx "\n",
>> +                      __func__, offset);
>> +    }
>> +    return;
>> +}
>> +
>> +static WatchdogTimerModel model =3D {
>> +    .wdt_name =3D TYPE_ASPEED_WDT,
>> +    .wdt_description =3D "aspeed watchdog device",
>> +};
>> +
>> +static const VMStateDescription vmstate_aspeed_wdt =3D {
>> +    .name =3D "vmstate_aspeed_wdt",
>> +    .version_id =3D 0,
>> +    .minimum_version_id =3D 0,
>> +    .fields =3D (VMStateField[]) {
>> +        VMSTATE_TIMER_PTR(timer, AspeedWDTState),
>> +        VMSTATE_BOOL(enabled, AspeedWDTState),
>=20
> This doesn't seem to have fields for most of the register state.
>=20
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>=20
> thanks
> -- PMM
>=20
