Received: from eggs.gnu.org ([2001:4830:134:3::10]:45541)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fXFqs-0006IN-FZ
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:59:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew@aj.id.au>) id 1fXFqr-00046a-C3
	for qemu-devel@nongnu.org; Sun, 24 Jun 2018 20:59:30 -0400
Message-Id: <1529888362.2194836.1418938448.349CB4FA@webmail.messagingengine.com>
From: Andrew Jeffery <andrew@aj.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
References: <20180622075700.5923-1-clg@kaod.org>
	<20180622075700.5923-4-clg@kaod.org>
Date: Mon, 25 Jun 2018 10:29:22 +0930
In-Reply-To: <20180622075700.5923-4-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] aspeed/timer: use the APB frequency
 from the SCU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>

On Fri, 22 Jun 2018, at 17:27, C=C3=A9dric Le Goater wrote:
> The timer controller can be driven by either an external 1MHz clock or
> by the APB clock. Today, the model makes the assumption that the APB
> frequency is always set to 24MHz but this is incorrect.
>=20
> The AST2400 SoC on the palmetto machines uses a 48MHz input clock
> source and the APB can be set to 48MHz. The consequence is a general
> system slowdown. The QEMU machines using the AST2500 SoC do not seem
> impacted today because the APB frequency is still set to 24MHz.
>=20
> We fix the timer frequency for all SoCs by linking the Timer model to
> the SCU model. The APB frequency driving the timers is now the one
> configured for the SoC.
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> Reviewed-by: Joel Stanley <joel@jms.id.au>

Reviewed-by: Andrew Jeffery <andrew@aj.id.au>

> ---
>  include/hw/timer/aspeed_timer.h |  4 ++++
>  hw/arm/aspeed_soc.c             |  2 ++
>  hw/timer/aspeed_timer.c         | 19 +++++++++++++++----
>  3 files changed, 21 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_ti=
mer.h
> index bd6c1a7f9609..040a08873432 100644
> --- a/include/hw/timer/aspeed_timer.h
> +++ b/include/hw/timer/aspeed_timer.h
> @@ -24,6 +24,8 @@
>=20=20
>  #include "qemu/timer.h"
>=20=20
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
>=20=20
>  #endif /* ASPEED_TIMER_H */
> diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
> index 7cc05ee27ea4..e68911af0f90 100644
> --- a/hw/arm/aspeed_soc.c
> +++ b/hw/arm/aspeed_soc.c
> @@ -127,6 +127,8 @@ static void aspeed_soc_init(Object *obj)
>=20=20
>      object_initialize(&s->timerctrl, sizeof(s->timerctrl), TYPE_ASPEED_T=
IMER);
>      object_property_add_child(obj, "timerctrl", OBJECT(&s->timerctrl), N=
ULL);
> +    object_property_add_const_link(OBJECT(&s->timerctrl), "scu",
> +                                   OBJECT(&s->scu), &error_abort);
>      qdev_set_parent_bus(DEVICE(&s->timerctrl), sysbus_get_default());
>=20=20
>      object_initialize(&s->i2c, sizeof(s->i2c), TYPE_ASPEED_I2C);
> diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
> index 1e31e22b6f1f..5e3f51b66b43 100644
> --- a/hw/timer/aspeed_timer.c
> +++ b/hw/timer/aspeed_timer.c
> @@ -10,8 +10,10 @@
>   */
>=20=20
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
>=20=20
>  #define TIMER_REG_STATUS 0
>  #define TIMER_REG_RELOAD 1
> @@ -80,11 +81,11 @@ static inline bool timer_external_clock(AspeedTimer *=
t)
>      return timer_ctrl_status(t, op_external_clock);
>  }
>=20=20
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
>=20=20
>  static inline uint32_t calculate_ticks(struct AspeedTimer *t, uint64_t=20
> now_ns)
> @@ -449,6 +450,16 @@ static void aspeed_timer_realize(DeviceState *dev,=20
> Error **errp)
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
>=20=20
>      for (i =3D 0; i < ASPEED_TIMER_NR_TIMERS; i++) {
>          aspeed_init_one_timer(s, i);
> --=20
> 2.13.6
>=20
