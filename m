Received: from eggs.gnu.org ([2001:4830:134:3::10]:53421)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fWF3F-0003N4-DN
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 01:56:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1fWF3B-0005Oh-Gh
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 01:56:05 -0400
Received: from 19.mo3.mail-out.ovh.net ([178.32.98.231]:54589)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1fWF3B-0005Mi-5o
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 01:56:01 -0400
Received: from player726.ha.ovh.net (unknown [10.109.120.111])
	by mo3.mail-out.ovh.net (Postfix) with ESMTP id 0D83C1BEA2D
	for <qemu-devel@nongnu.org>; Fri, 22 Jun 2018 07:55:58 +0200 (CEST)
References: <20180621223946.20738-1-clg@kaod.org>
	<20180621223946.20738-4-clg@kaod.org>
	<CACPK8Xdpnyz=wTBuWyh_ZQTqd7r+RVZertN+a-wrX1QqtYQU0A@mail.gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <62217a65-982c-0179-fc8b-b38a682d02f4@kaod.org>
Date: Fri, 22 Jun 2018 07:55:49 +0200
MIME-Version: 1.0
In-Reply-To: <CACPK8Xdpnyz=wTBuWyh_ZQTqd7r+RVZertN+a-wrX1QqtYQU0A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] aspeed/timer: use the APB frequency
 from the SCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Joel Stanley <joel@jms.id.au>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>

On 06/22/2018 03:01 AM, Joel Stanley wrote:
> On 22 June 2018 at 08:09, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>> The timer controller can be driven by either an external 1MHz clock or
>> by the APB clock. Today, the model makes this assumption that the APB
>> frequency is 24MHz but this is incorrect on the AST2400 SoC. palmetto
>> machines use a 48MHz input clock source.
>=20
> So this fixes it to use a apb frequency from the scu for all platform,
> not just the 2400?

Yes. This is true all, platforms are impacted. The AST2500 settings=20
are still using the default 24MHz freq emulated by QEMU. So they seem
not impacted but they are. I will update the commit log.

> Can you put something in the commit message about the change in guest
> behaviour - the output of Linux's clk_summary or similar - so we know
> what bug this fixed?

Ah ! the command 'sleep 1' does now effectively last one second and=20
not two. Difficult to show in an email :)=20

> The code looks good though.
>=20
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Thanks,

C.
=20
>> Use the SCU object to get the APB frequency and drive the timers with
>> the configured freq for the SoC.
>>
>> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
>> ---
>>  include/hw/timer/aspeed_timer.h |  4 ++++
>>  hw/arm/aspeed_soc.c             |  2 ++
>>  hw/timer/aspeed_timer.c         | 19 +++++++++++++++----
>>  3 files changed, 21 insertions(+), 4 deletions(-)
>>
>> diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed=
_timer.h
>> index bd6c1a7f9609..040a08873432 100644
>> --- a/include/hw/timer/aspeed_timer.h
>> +++ b/include/hw/timer/aspeed_timer.h
>> @@ -24,6 +24,8 @@
>>
>>  #include "qemu/timer.h"
>>
>> +typedef struct AspeedSCUState AspeedSCUState;
>> +
>>  #define ASPEED_TIMER(obj) \
>>      OBJECT_CHECK(AspeedTimerCtrlState, (obj), TYPE_ASPEED_TIMER);
>>  #define TYPE_ASPEED_TIMER "aspeed.timer"
>> @@ -55,6 +57,8 @@ typedef struct AspeedTimerCtrlState {
>>      uint32_t ctrl;
>>      uint32_t ctrl2;
>>      AspeedTimer timers[ASPEED_TIMER_NR_TIMERS];
>> +
>> +    AspeedSCUState *scu;
>>  } AspeedTimerCtrlState;
>>
>>  #endif /* ASPEED_TIMER_H */
>> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
>> index 7cc05ee27ea4..e68911af0f90 100644
>> --- a/hw/arm/aspeed_soc.c
>> +++ b/hw/arm/aspeed_soc.c
>> @@ -127,6 +127,8 @@ static void aspeed_soc_init(Object *obj)
>>
>>      object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEE=
D_TIMER);
>>      object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl)=
, NULL);
>> +    object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
>> +                                   OBJECT(&s->scu), &error_abort);
>>      qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());
>>
>>      object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
>> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
>> index 1e31e22b6f1f..5e3f51b66b43 100644
>> --- a/hw/timer/aspeed_timer.c
>> +++ b/hw/timer/aspeed_timer.c
>> @@ -10,8 +10,10 @@
>>   */
>>
>>  #include "qemu/osdep.h"
>> +#include "qapi/error.h"
>>  #include "hw/sysbus.h"
>>  #include "hw/timer/aspeed_timer.h"
>> +#include "hw/misc/aspeed_scu.h"
>>  #include "qemu-common.h"
>>  #include "qemu/bitops.h"
>>  #include "qemu/timer.h"
>> @@ -26,7 +28,6 @@
>>  #define TIMER_CLOCK_USE_EXT true
>>  #define TIMER_CLOCK_EXT_HZ 1000000
>>  #define TIMER_CLOCK_USE_APB false
>> -#define TIMER_CLOCK_APB_HZ 24000000
>>
>>  #define TIMER_REG_STATUS 0
>>  #define TIMER_REG_RELOAD 1
>> @@ -80,11 +81,11 @@ static inline bool timer_external_clock(AspeedTime=
r *t)
>>      return timer_ctrl_status(t, op_external_clock);
>>  }
>>
>> -static uint32_t clock_rates[] =3D { TIMER_CLOCK_APB_HZ, TIMER_CLOCK_E=
XT_HZ };
>> -
>>  static inline uint32_t calculate_rate(struct AspeedTimer *t)
>>  {
>> -    return clock_rates[timer_external_clock(t)];
>> +    AspeedTimerCtrlState *s =3D timer_to_ctrl(t);
>> +
>> +    return timer_external_clock(t) ? TIMER_CLOCK_EXT_HZ : s->scu->apb=
_freq;
>>  }
>>
>>  static inline uint32_t calculate_ticks(struct AspeedTimer *t, uint64_=
t now_ns)
>> @@ -449,6 +450,16 @@ static void aspeed_timer_realize(DeviceState *dev=
, Error **errp)
>>      int i;
>>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>>      AspeedTimerCtrlState *s =3D ASPEED_TIMER(dev);
>> +    Object *obj;
>> +    Error *err =3D NULL;
>> +
>> +    obj =3D object_property_get_link(OBJECT(dev), "scu", &err);
>> +    if (!obj) {
>> +        error_propagate(errp, err);
>> +        error_prepend(errp, "required link 'scu' not found: ");
>> +        return;
>> +    }
>> +    s->scu =3D ASPEED_SCU(obj);
>>
>>      for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
>>          aspeed_init_one_timer(s, i);
>> --
>> 2.13.6
>>
