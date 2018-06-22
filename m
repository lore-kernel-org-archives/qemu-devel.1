Received: from eggs.gnu.org ([2001:4830:134:3::10]:38259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fWASw-0003bQ-VN
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:02:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1fWASv-00088E-QJ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 21:02:19 -0400
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180621223946.20738-4-clg@kaod.org>
References: <20180621223946.20738-1-clg@kaod.org>
	<20180621223946.20738-4-clg@kaod.org>
From: Joel Stanley <joel@jms.id.au>
Date: Fri, 22 Jun 2018 10:31:56 +0930
Message-ID: <CACPK8Xdpnyz=wTBuWyh_ZQTqd7r+RVZertN+a-wrX1QqtYQU0A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>

On 22 June 2018 at 08:09, C=C3=A9dric Le Goater <clg@kaod.org> wrote:
> The timer controller can be driven by either an external 1MHz clock or
> by the APB clock. Today, the model makes this assumption that the APB
> frequency is 24MHz but this is incorrect on the AST2400 SoC. palmetto
> machines use a 48MHz input clock source.

So this fixes it to use a apb frequency from the scu for all platform,
not just the 2400?

Can you put something in the commit message about the change in guest
behaviour - the output of Linux's clk_summary or similar - so we know
what bug this fixed?

The code looks good though.

Reviewed-by: Joel Stanley <joel@jms.id.au>

> Use the SCU object to get the APB frequency and drive the timers with
> the configured freq for the SoC.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/timer/aspeed_timer.h |  4 ++++
>  hw/arm/aspeed_soc.c             |  2 ++
>  hw/timer/aspeed_timer.c         | 19 +++++++++++++++----
>  3 files changed, 21 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_ti=
mer.h
> index bd6c1a7f9609..040a08873432 100644
> --- a/include/hw/timer/aspeed_timer.h
> +++ b/include/hw/timer/aspeed_timer.h
> @@ -24,6 +24,8 @@
>
>  #include "qemu/timer.h"
>
> +typedef struct AspeedSCUState AspeedSCUState;
> +
>  #define ASPEED_TIMER(obj) \
>      OBJECT_CHECK(AspeedTimerCtrlState, (obj), TYPE_ASPEED_TIMER);
>  #define TYPE_ASPEED_TIMER "aspeed.timer"
> @@ -55,6 +57,8 @@ typedef struct AspeedTimerCtrlState {
>      uint32_t ctrl;
>      uint32_t ctrl2;
>      AspeedTimer timers[ASPEED_TIMER_NR_TIMERS];
> +
> +    AspeedSCUState *scu;
>  } AspeedTimerCtrlState;
>
>  #endif /* ASPEED_TIMER_H */
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 7cc05ee27ea4..e68911af0f90 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -127,6 +127,8 @@ static void aspeed_soc_init(Object *obj)
>
>      object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEED_T=
IMER);
>      object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl), N=
ULL);
> +    object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
> +                                   OBJECT(&s->scu), &error_abort);
>      qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());
>
>      object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
> index 1e31e22b6f1f..5e3f51b66b43 100644
> --- a/hw/timer/aspeed_timer.c
> +++ b/hw/timer/aspeed_timer.c
> @@ -10,8 +10,10 @@
>   */
>
>  #include "qemu/osdep.h"
> +#include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "hw/timer/aspeed_timer.h"
> +#include "hw/misc/aspeed_scu.h"
>  #include "qemu-common.h"
>  #include "qemu/bitops.h"
>  #include "qemu/timer.h"
> @@ -26,7 +28,6 @@
>  #define TIMER_CLOCK_USE_EXT true
>  #define TIMER_CLOCK_EXT_HZ 1000000
>  #define TIMER_CLOCK_USE_APB false
> -#define TIMER_CLOCK_APB_HZ 24000000
>
>  #define TIMER_REG_STATUS 0
>  #define TIMER_REG_RELOAD 1
> @@ -80,11 +81,11 @@ static inline bool timer_external_clock(AspeedTimer *=
t)
>      return timer_ctrl_status(t, op_external_clock);
>  }
>
> -static uint32_t clock_rates[] =3D { TIMER_CLOCK_APB_HZ, TIMER_CLOCK_EXT_=
HZ };
> -
>  static inline uint32_t calculate_rate(struct AspeedTimer *t)
>  {
> -    return clock_rates[timer_external_clock(t)];
> +    AspeedTimerCtrlState *s =3D timer_to_ctrl(t);
> +
> +    return timer_external_clock(t) ? TIMER_CLOCK_EXT_HZ : s->scu->apb_fr=
eq;
>  }
>
>  static inline uint32_t calculate_ticks(struct AspeedTimer *t, uint64_t n=
ow_ns)
> @@ -449,6 +450,16 @@ static void aspeed_timer_realize(DeviceState *dev, E=
rror **errp)
>      int i;
>      SysBusDevice *sbd =3D SYS_BUS_DEVICE(dev);
>      AspeedTimerCtrlState *s =3D ASPEED_TIMER(dev);
> +    Object *obj;
> +    Error *err =3D NULL;
> +
> +    obj =3D object_property_get_link(OBJECT(dev), "scu", &err);
> +    if (!obj) {
> +        error_propagate(errp, err);
> +        error_prepend(errp, "required link 'scu' not found: ");
> +        return;
> +    }
> +    s->scu =3D ASPEED_SCU(obj);
>
>      for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
>          aspeed_init_one_timer(s, i);
> --
> 2.13.6
>
