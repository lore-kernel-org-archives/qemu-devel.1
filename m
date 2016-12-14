Received: from eggs.gnu.org ([2001:4830:134:3::10]:48807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHDtp-0000Kh-RM
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cHDtm-0008Uq-N3
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:03:29 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:36521)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cHDtm-0008Ub-FR
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 13:03:26 -0500
Received: by mail-vk0-f45.google.com with SMTP id p9so39728872vkd.3
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 10:03:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161202054617.6749-6-alastair@au1.ibm.com>
References: <20161202054617.6749-1-alastair@au1.ibm.com>
	<20161202054617.6749-6-alastair@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 14 Dec 2016 18:02:04 +0000
Message-ID: <CAFEAcA_wG+5_i76Tyw1pbih4P1wV7tsO1xV9FpzRRiWYD6Q_MA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 5/7] hw/timer: Add Epson RX8900 RTC
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alastair D'Silva <alastair@au1.ibm.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>, Alastair D'Silva <alastair@d-silva.org>, Chris Smart <chris@distroguy.com>

On 2 December 2016 at 05:46, Alastair D'Silva <alastair@au1.ibm.com> wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
>
> This patch adds support for the Epson RX8900 I2C RTC.
>
> The following chip features are implemented:
>  - RTC (wallclock based, ptimer 10x oversampling to pick up
>         wallclock transitions)
>  - Time update interrupt (per second/minute, wallclock based)
>  - Alarms (wallclock based)
>  - Temperature (set via a property)
>  - Countdown timer (emulated clock via ptimer)
>  - FOUT via GPIO (emulated clock via ptimer)
>
> The following chip features are unimplemented:
>  - Low voltage detection
>  - i2c timeout
>
> The implementation exports the following named GPIOs:
> rx8900-interrupt-out
> rx8900-fout-enable
> rx8900-fout
>
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>
> Signed-off-by: Chris Smart <chris@distroguy.com>
> ---
>  default-configs/arm-softmmu.mak |   1 +
>  hw/i2c/core.c                   |   4 +-
>  hw/timer/Makefile.objs          |   2 +
>  hw/timer/rx8900.c               | 912 ++++++++++++++++++++++++++++++++++=
++++++
>  hw/timer/rx8900_regs.h          | 141 +++++++
>  hw/timer/trace-events           |  31 ++
>  6 files changed, 1089 insertions(+), 2 deletions(-)
>  create mode 100644 hw/timer/rx8900.c
>  create mode 100644 hw/timer/rx8900_regs.h
>
> diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
> index 6de3e16..adb600e 100644
> --- a/default-configs/arm-softmmu.mak
> +++ b/default-configs/arm-softmmu.mak
> @@ -29,6 +29,7 @@ CONFIG_SMC91C111=3Dy
>  CONFIG_ALLWINNER_EMAC=3Dy
>  CONFIG_IMX_FEC=3Dy
>  CONFIG_DS1338=3Dy
> +CONFIG_RX8900=3Dy
>  CONFIG_PFLASH_CFI01=3Dy
>  CONFIG_PFLASH_CFI02=3Dy
>  CONFIG_MICRODRIVE=3Dy
> diff --git a/hw/i2c/core.c b/hw/i2c/core.c
> index ae3ca94..e40781e 100644
> --- a/hw/i2c/core.c
> +++ b/hw/i2c/core.c
> @@ -262,9 +262,9 @@ static int i2c_slave_qdev_init(DeviceState *dev)
>
>      if (sc->init) {
>          return sc->init(s);
> -    } else {
> -        return 0;
>      }
> +
> +    return 0;
>  }
>

This change shouldn't be in this patch.

>  DeviceState *i2c_create_slave(I2CBus *bus, const char *name, uint8_t add=
r)
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 7ba8c23..fa028ac 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -3,6 +3,7 @@ common-obj-$(CONFIG_ARM_MPTIMER) +=3D arm_mptimer.o
>  common-obj-$(CONFIG_A9_GTIMER) +=3D a9gtimer.o
>  common-obj-$(CONFIG_CADENCE) +=3D cadence_ttc.o
>  common-obj-$(CONFIG_DS1338) +=3D ds1338.o
> +common-obj-$(CONFIG_RX8900) +=3D rx8900.o
>  common-obj-$(CONFIG_HPET) +=3D hpet.o
>  common-obj-$(CONFIG_I8254) +=3D i8254_common.o i8254.o
>  common-obj-$(CONFIG_M48T59) +=3D m48t59.o
> @@ -17,6 +18,7 @@ common-obj-$(CONFIG_IMX) +=3D imx_epit.o
>  common-obj-$(CONFIG_IMX) +=3D imx_gpt.o
>  common-obj-$(CONFIG_LM32) +=3D lm32_timer.o
>  common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-sysctl.o
> +common-obj-$(CONFIG_RX8900) +=3D rx8900.o
>
>  obj-$(CONFIG_EXYNOS4) +=3D exynos4210_mct.o
>  obj-$(CONFIG_EXYNOS4) +=3D exynos4210_pwm.o

> +/**
> + * Get the device temperature in Celcius as a property

It's spelt "Celsius" -- please fix through the whole file.

> + * @param obj the device
> + * @param v
> + * @param name the property name
> + * @param opaque
> + * @param errp an error object to populate on failure
> + */
> +static void rx8900_get_temperature(Object *obj, Visitor *v, const char *=
name,
> +                                   void *opaque, Error **errp)
> +{
> +    RX8900State *s =3D RX8900(obj);
> +    double value =3D (s->nvram[TEMPERATURE] * 2.0f - 187.1f) / 3.218f;

Why use 'double' for the variable when you're doing all your
arithmetic at 'float' precision because of those 'f' suffixes?
Unless there's a good reason I'd suggest dropping the 'f's and
just doing all the arithmetic at double precision.

> +static void rx8900_set_temperature(Object *obj, Visitor *v, const char *=
name,
> +                                   void *opaque, Error **errp)
> +{
> +    RX8900State *s =3D RX8900(obj);
> +    Error *local_err =3D NULL;
> +    double temp; /* degrees Celcius */
> +    visit_type_number(v, name, &temp, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    if (temp >=3D 100 || temp < -58) {
> +        error_setg(errp, "value %f=C2=B0C is out of range", temp);

Not sure that UTF-8 characters directly in error strings
is a great idea. I'd stick to ASCII.

> +        return;
> +    }
> +
> +    s->nvram[TEMPERATURE] =3D encode_temperature(temp);
> +
> +    trace_rx8900_set_temperature(s->nvram[TEMPERATURE], temp);
> +}
> +
> +/**
> + * Get the device supply voltage as a property
> + * @param obj the device
> + * @param v
> + * @param name the property name
> + * @param opaque
> + * @param errp an error object to populate on failure
> + */
> +static void rx8900_get_voltage(Object *obj, Visitor *v, const char *name=
,
> +                                   void *opaque, Error **errp)
> +{
> +    RX8900State *s =3D RX8900(obj);
> +
> +    visit_type_number(v, name, &s->supply_voltage, errp);
> +}
> +
> +/**
> + * Set the device supply voltage as a property
> + * @param obj the device
> + * @param v
> + * @param name the property name
> + * @param opaque
> + * @param errp an error object to populate on failure
> + */
> +static void rx8900_set_voltage(Object *obj, Visitor *v, const char *name=
,
> +                                   void *opaque, Error **errp)
> +{
> +    RX8900State *s =3D RX8900(obj);
> +    Error *local_err =3D NULL;
> +    double temp;
> +    visit_type_number(v, name, &temp, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    s->supply_voltage =3D temp;
> +    trace_rx8900_set_voltage(s->supply_voltage);
> +
> +    check_voltage(s);
> +}
> +
> +
> +/**
> + * Configure device properties
> + * @param obj the device
> + */
> +static void rx8900_initfn(Object *obj)
> +{
> +    object_property_add(obj, "temperature", "number",
> +                        rx8900_get_temperature,
> +                        rx8900_set_temperature, NULL, NULL, NULL);
> +
> +    object_property_add(obj, "voltage", "number",
> +                        rx8900_get_voltage,
> +                        rx8900_set_voltage, NULL, NULL, NULL);
> +}
> +
> +/**
> + * Reset the device
> + * @param dev the RX8900 device to reset
> + */
> +static void rx8900_reset(DeviceState *dev)
> +{
> +    RX8900State *s =3D RX8900(dev);
> +
> +    trace_rx8900_reset();
> +
> +    /* The clock is running and synchronized with the host */
> +    s->offset =3D 0;
> +    s->weekday =3D 7; /* Set to an invalid value */
> +
> +    s->nvram[EXTENSION_REGISTER] =3D EXT_MASK_TSEL1;
> +    s->nvram[CONTROL_REGISTER] =3D CTRL_MASK_CSEL0;
> +    s->nvram[FLAG_REGISTER] &=3D FLAG_MASK_VDET | FLAG_MASK_VLF;
> +
> +    s->nvram_offset =3D 0;
> +
> +    trace_rx8900_regptr_update(s->nvram_offset);
> +
> +    s->addr_byte =3D false;
> +}
> +
> +/**
> + * Realize an RX8900 device instance
> + * Set up timers
> + * Configure GPIO lines
> + * @param dev the device instance to realize
> + * @param errp an error object to populate on error
> + */
> +static void rx8900_realize(DeviceState *dev, Error **errp)
> +{
> +    RX8900State *s =3D RX8900(dev);
> +    I2CSlave *i2c =3D I2C_SLAVE(dev);
> +    QEMUBH *bh;
> +    char name[64];
> +
> +    s->fout_state =3D false;
> +
> +    memset(s->nvram, 0, RX8900_NVRAM_SIZE);

This looks like something you should be doing in reset.

> +    /* Set the initial state to 25 degrees Celcius */
> +    s->nvram[TEMPERATURE] =3D encode_temperature(25.0f);

...and this.

> +
> +    /* Set up timers */
> +    bh =3D qemu_bh_new(rx8900_timer_tick, s);
> +    s->sec_timer =3D ptimer_init(bh, PTIMER_POLICY_DEFAULT);
> +    /* we trigger the timer at 10Hz and check for rollover, as the qemu
> +     * clock does not advance in realtime in the test environment,
> +     * leading to unstable test results
> +     */
> +    ptimer_set_freq(s->sec_timer, 10);
> +    ptimer_set_limit(s->sec_timer, 1, 1);
> +
> +    bh =3D qemu_bh_new(rx8900_fout_tick, s);
> +    s->fout_timer =3D ptimer_init(bh, PTIMER_POLICY_DEFAULT);
> +    /* frequency doubled to generate 50% duty cycle square wave */
> +    ptimer_set_freq(s->fout_timer, 32768 * 2);
> +    ptimer_set_limit(s->fout_timer, 1, 1);
> +
> +    bh =3D qemu_bh_new(rx8900_countdown_tick, s);
> +    s->countdown_timer =3D ptimer_init(bh, PTIMER_POLICY_DEFAULT);
> +    ptimer_set_freq(s->countdown_timer, COUNTDOWN_TIMER_FREQ);
> +    ptimer_set_limit(s->countdown_timer, COUNTDOWN_TIMER_FREQ, 1);
> +
> +
> +    /* set up GPIO */
> +    snprintf(name, sizeof(name), "rx8900-interrupt-out");
> +    qdev_init_gpio_out_named(&i2c->qdev, &s->interrupt_pin, name, 1);
> +    trace_rx8900_pin_name("Interrupt", name);
> +
> +    snprintf(name, sizeof(name), "rx8900-fout-enable");
> +    qdev_init_gpio_in_named(&i2c->qdev, rx8900_fout_enable_handler, name=
, 1);
> +    trace_rx8900_pin_name("Fout-enable", name);
> +
> +    snprintf(name, sizeof(name), "rx8900-fout");
> +    qdev_init_gpio_out_named(&i2c->qdev, &s->fout_pin, name, 1);
> +    trace_rx8900_pin_name("Fout", name);
> +
> +    /* Set up default voltage */
> +    s->supply_voltage =3D 3.3f;
> +    trace_rx8900_set_voltage(s->supply_voltage);
> +}

> +rx8900_get_temperature(uint8_t raw, double val) "0x%x =3D %f=C2=B0C"
> +rx8900_set_temperature(uint8_t raw, double val) "0x%x =3D %f=C2=B0C"

Stick to ASCII here too.

thanks
-- PMM
