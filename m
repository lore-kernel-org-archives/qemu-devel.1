Received: from eggs.gnu.org ([2001:4830:134:3::10]:45770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT9bb-0005il-ES
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:54:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cT9bU-0003Mu-IM
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:53:59 -0500
Received: from mail-ua0-x22d.google.com ([2607:f8b0:400c:c08::22d]:35567)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cT9bU-0003Mg-4U
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 10:53:52 -0500
Received: by mail-ua0-x22d.google.com with SMTP id y9so84385727uae.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 07:53:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170105043430.3176-6-alastair@au1.ibm.com>
References: <20170105043430.3176-1-alastair@au1.ibm.com>
	<20170105043430.3176-6-alastair@au1.ibm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Jan 2017 15:53:30 +0000
Message-ID: <CAFEAcA_TeZRW57JAg7cUG6mkMsZRmxncYOyAn_=0oW+X+WB4KQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 5/7] hw/timer: Add Epson RX8900 RTC
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

On 5 January 2017 at 04:34, Alastair D'Silva <alastair@au1.ibm.com> wrote:
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
>  hw/timer/Makefile.objs          |   2 +
>  hw/timer/rx8900.c               | 914 ++++++++++++++++++++++++++++++++++=
++++++
>  hw/timer/rx8900_regs.h          | 141 +++++++
>  hw/timer/trace-events           |  31 ++
>  5 files changed, 1089 insertions(+)
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

You seem to be adding the .o file twice ?

>  obj-$(CONFIG_EXYNOS4) +=3D exynos4210_mct.o
>  obj-$(CONFIG_EXYNOS4) +=3D exynos4210_pwm.o
> diff --git a/hw/timer/rx8900.c b/hw/timer/rx8900.c
> new file mode 100644
> index 0000000..146603e
> --- /dev/null
> +++ b/hw/timer/rx8900.c
> @@ -0,0 +1,914 @@
> +/*
> + * Epson RX8900SA/CE Realtime Clock Module
> + *
> + * Copyright (c) 2016 IBM Corporation
> + * Authors:
> + *  Alastair D'Silva <alastair@d-silva.org>
> + *  Chris Smart <chris@distroguy.com>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + *
> + * Datasheet available at:
> + *  https://support.epson.biz/td/api/doc_check.php?dl=3Dapp_RX8900CE&lan=
g=3Den
> + *
> + * Not implemented:
> + *  Implement i2c timeout
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qemu-common.h"
> +#include "hw/i2c/i2c.h"
> +#include "hw/timer/rx8900_regs.h"
> +#include "hw/ptimer.h"
> +#include "qemu/main-loop.h"
> +#include "qemu/bcd.h"
> +#include "qemu/log.h"
> +#include "qapi/error.h"
> +#include "qapi/visitor.h"
> +#include "trace.h"
> +
> +#define TYPE_RX8900 "rx8900"
> +#define RX8900(obj) OBJECT_CHECK(RX8900State, (obj), TYPE_RX8900)
> +
> +typedef struct RX8900State {
> +    I2CSlave parent_obj;
> +
> +    ptimer_state *sec_timer; /* triggered once per second */
> +    ptimer_state *fout_timer;
> +    ptimer_state *countdown_timer;
> +    bool fout_state;
> +    int64_t offset;
> +#define INVALID_WEEKDAY 0xff
> +    uint8_t weekday; /* Saved for deferred offset calculation, 0-6 */
> +    uint8_t wday_offset;
> +    uint8_t nvram[RX8900_NVRAM_SIZE];
> +    int32_t nvram_offset; /* Wrapped to stay within RX8900_NVRAM_SIZE */
> +    bool addr_byte;
> +    uint8_t last_interrupt_seconds; /* The last time the second timer ti=
cked */
> +    /* the last minute the timer update interrupt was triggered (if enab=
led) */
> +    uint8_t last_update_interrupt_minutes;
> +    double supply_voltage;
> +    qemu_irq interrupt_pin;
> +    qemu_irq fout_pin;
> +    struct tm now;
> +    bool time_altered; /* True if this transaction altered the time */

You seem to be using time_altered to track state within the device
which persists between guest operations, which I think means it
needs to be in the vmstate -- consider the case of a migration
after the guest has done I2C_START_RECV but before it does
I2C_FINISH.

Alternatively: our other RTC models don't need this time_altered
flag, so why is this RTC different?

> +} RX8900State;
> +
> +static const VMStateDescription vmstate_rx8900 =3D {
> +    .name =3D "rx8900",
> +    .version_id =3D 1,
> +    .minimum_version_id =3D 1,
> +    .fields =3D (VMStateField[]) {
> +        VMSTATE_I2C_SLAVE(parent_obj, RX8900State),
> +        VMSTATE_PTIMER(sec_timer, RX8900State),
> +        VMSTATE_PTIMER(fout_timer, RX8900State),
> +        VMSTATE_PTIMER(countdown_timer, RX8900State),
> +        VMSTATE_BOOL(fout_state, RX8900State),
> +        VMSTATE_INT64(offset, RX8900State),
> +        VMSTATE_UINT8(weekday, RX8900State),
> +        VMSTATE_UINT8(wday_offset, RX8900State),
> +        VMSTATE_UINT8_ARRAY(nvram, RX8900State, RX8900_NVRAM_SIZE),
> +        VMSTATE_INT32(nvram_offset, RX8900State),
> +        VMSTATE_BOOL(addr_byte, RX8900State),
> +        VMSTATE_UINT8(last_interrupt_seconds, RX8900State),
> +        VMSTATE_UINT8(last_update_interrupt_minutes, RX8900State),
> +        VMSTATE_END_OF_LIST()
> +    }
> +};
> +
> +static void rx8900_reset(DeviceState *dev);
> +
> +static void capture_current_time(RX8900State *s)
> +{
> +    /* Capture the current time into the secondary registers
> +     * which will be actually read by the data transfer operation.
> +     */
> +    qemu_get_timedate(&s->now, s->offset);

I think this is going to mean we don't get the RTC's
behaviour entirely right (for instance its idea of
leap years is simply "divisible by 4" rather than
the actual leap year definition). Looking at the
mc146818rtc model for instance we only seem to look at
the host's idea of the current time on device realize.

> +    s->nvram[SECONDS] =3D to_bcd(s->now.tm_sec);
> +    s->nvram[MINUTES] =3D to_bcd(s->now.tm_min);
> +    s->nvram[HOURS] =3D to_bcd(s->now.tm_hour);
> +
> +    s->nvram[WEEKDAY] =3D 0x01 << ((s->now.tm_wday + s->wday_offset) % 7=
);
> +    s->nvram[DAY] =3D to_bcd(s->now.tm_mday);
> +    s->nvram[MONTH] =3D to_bcd(s->now.tm_mon + 1);
> +    s->nvram[YEAR] =3D to_bcd(s->now.tm_year % 100);
> +
> +    s->nvram[EXT_SECONDS] =3D s->nvram[SECONDS];
> +    s->nvram[EXT_MINUTES] =3D s->nvram[MINUTES];
> +    s->nvram[EXT_HOURS] =3D s->nvram[HOURS];
> +    s->nvram[EXT_WEEKDAY] =3D s->nvram[WEEKDAY];
> +    s->nvram[EXT_DAY] =3D s->nvram[DAY];
> +    s->nvram[EXT_MONTH] =3D s->nvram[MONTH];
> +    s->nvram[EXT_YEAR] =3D s->nvram[YEAR];

Rather than handling all these aliased registers by having to
remember to update them every time the code writes new values
into them, I think it would be better to special case the
two places in the code where we handle guest reads and writes
(rx8900_send and rx8900_recv) to do

   nvram_offset =3D s->nvram_offset;
   if ((nvram_offset >=3D 0x10 && nvram_offset <=3D 0x16) ||
       (nvram_offset >=3D 0x1B)) {
       /* registers 0x10..0x16 and 0x1B..0x1F are aliases of
        * 0x00..0x06 and 0x0B..0x0F
        */
       nvram_offset &=3D 0xf;
   }

I think that will be less error-prone overall because the
aliasing is now handled in fewer places so updates to the
code are less likely to get it wrong.

> +
> +    trace_rx8900_capture_current_time(s->now.tm_hour, s->now.tm_min,
> +            s->now.tm_sec,
> +            (s->now.tm_wday + s->wday_offset) % 7,
> +            s->now.tm_mday, s->now.tm_mon + 1, s->now.tm_year + 1900,
> +            s->nvram[HOURS], s->nvram[MINUTES], s->nvram[SECONDS],
> +            s->nvram[WEEKDAY], s->nvram[DAY], s->nvram[MONTH], s->nvram[=
YEAR],
> +            s->offset);
> +}
> +
> +/**
> + * Increment the internal register pointer, dealing with wrapping
> + * @param s the RTC to operate on
> + */
> +static void inc_regptr(RX8900State *s)
> +{
> +    /* The register pointer wraps around after 0x1F
> +     */
> +    s->nvram_offset =3D (s->nvram_offset + 1) & (RX8900_NVRAM_SIZE - 1);
> +    trace_rx8900_regptr_update(s->nvram_offset);
> +
> +    if (s->nvram_offset =3D=3D START_ADDRESS) {
> +        trace_rx8900_regptr_overflow();
> +        capture_current_time(s);
> +    }
> +}
> +
> +/**
> + * Receive an I2C Event
> + * @param i2c the i2c device instance
> + * @param event the event to handle
> + */
> +static void rx8900_event(I2CSlave *i2c, enum i2c_event event)
> +{
> +    RX8900State *s =3D RX8900(i2c);
> +
> +    switch (event) {
> +    case I2C_START_SEND:
> +        s->addr_byte =3D true;
> +        /* fall through */
> +    case I2C_START_RECV:
> +        capture_current_time(s);
> +        s->time_altered =3D false;
> +        break;
> +    case I2C_FINISH:
> +        if (s->time_altered) {
> +            s->offset =3D qemu_timedate_diff(&s->now);
> +        }
> +
> +        if (s->weekday < 7) {
> +            /* We defer the weekday calculation as it is handed to us be=
fore
> +             * the date has been updated. If we calculate the weekday of=
fset
> +             * when it is passed to us, we will incorrectly determine it
> +             * based on the current emulated date, rather than the date =
that
> +             * has been written.
> +             */
> +            struct tm now;
> +            qemu_get_timedate(&now, s->offset);
> +
> +            s->wday_offset =3D (s->weekday - now.tm_wday + 7) % 7;
> +
> +            trace_rx8900_event_weekday(s->weekday, BIT(s->weekday),
> +                    s->wday_offset);
> +
> +            s->weekday =3D INVALID_WEEKDAY;
> +        }

I don't understand the INVALID_WEEKDAY logic. We set s->weekday
to INVALID_WEEKDAY here and in device reset, but there is no
code that I can see which checks whether the weekday value is
invalid and updates it.

> +        break;
> +
> +    default:
> +        break;
> +    }
> +}
> +
> +/**
> + * Perform an i2c receive action
> + * @param i2c the i2c device instance
> + * @return the value of the current register
> + * @post the internal register pointer is incremented
> + */
> +static int rx8900_recv(I2CSlave *i2c)
> +{
> +    RX8900State *s =3D RX8900(i2c);
> +    uint8_t res =3D s->nvram[s->nvram_offset];
> +    trace_rx8900_read_register(s->nvram_offset, res);
> +    inc_regptr(s);
> +    return res;
> +}
> +
> +/**
> + * Disable the countdown timer
> + * @param s the RTC to operate on
> + */
> +static void disable_countdown_timer(RX8900State *s)
> +{
> +    trace_rx8900_disable_countdown_timer();
> +    ptimer_stop(s->countdown_timer);
> +}
> +
> +/**
> + * Enable the countdown timer
> + * @param s the RTC to operate on
> + */
> +static void enable_countdown_timer(RX8900State *s)
> +{
> +    trace_rx8900_enable_countdown_timer();
> +    ptimer_run(s->countdown_timer, 0);
> +}
> +
> +/**
> + * Tick the countdown timer
> + * @param opaque the device instance
> + */
> +static void rx8900_countdown_tick(void *opaque)
> +{
> +    RX8900State *s =3D (RX8900State *)opaque;
> +
> +    uint16_t count =3D s->nvram[TIMER_COUNTER_0] |
> +            ((s->nvram[TIMER_COUNTER_1] & 0x0F) << 8);
> +    trace_rx8900_countdown_tick(count);
> +    count--;
> +
> +    s->nvram[TIMER_COUNTER_0] =3D (uint8_t)(count & 0x00ff);
> +    s->nvram[TIMER_COUNTER_1] =3D (uint8_t)((count & 0x0f00) >> 8);
> +
> +    if (count =3D=3D 0) {
> +        trace_rx8900_countdown_elapsed();
> +
> +        disable_countdown_timer(s);
> +
> +        s->nvram[FLAG_REGISTER] |=3D FLAG_MASK_TF;
> +
> +        if (s->nvram[CONTROL_REGISTER] & CTRL_MASK_TIE) {
> +            trace_rx8900_fire_interrupt();
> +            qemu_irq_pulse(s->interrupt_pin);
> +        }
> +    }
> +}
> +
> +/**
> + * Disable the per second timer
> + * @param s the RTC to operate on
> + */
> +static void disable_timer(RX8900State *s)
> +{
> +    trace_rx8900_disable_timer();
> +    ptimer_stop(s->sec_timer);
> +}
> +
> +/**
> + * Enable the per second timer
> + * @param s the RTC to operate on
> + */
> +static void enable_timer(RX8900State *s)
> +{
> +    trace_rx8900_enable_timer();
> +    ptimer_run(s->sec_timer, 0);
> +}
> +
> +/**
> + * Tick the per second timer (can be called more frequently as it early =
exits
> + * if the wall clock has not progressed)
> + * @param opaque the RTC to tick
> + */
> +static void rx8900_timer_tick(void *opaque)

You really don't want to model this like this. The hardware
may work by "every second (or more often) see if we need
to update something", but that makes for poor performance
in an emulator. What you should do is calculate in advance
the next time when you need to fire an interrupt, and
set up a timer to fire at that point. Then only actually
update your internal state when the timer fires, or if the
guest asks to read or write a register.

> +{
> +    RX8900State *s =3D (RX8900State *)opaque;
> +    struct tm now;
> +    bool fire_interrupt =3D false;
> +    bool alarm_week_day_matches;
> +
> +    qemu_get_timedate(&now, s->offset);
> +
> +    if (now.tm_sec =3D=3D s->last_interrupt_seconds) {
> +        return;
> +    }
> +
> +    s->last_interrupt_seconds =3D now.tm_sec;
> +
> +    trace_rx8900_tick();
> +
> +    /* Update timer interrupt */
> +    if (s->nvram[CONTROL_REGISTER] & CTRL_MASK_UIE) {
> +        if ((s->nvram[EXTENSION_REGISTER] & EXT_MASK_USEL) &&
> +                now.tm_min !=3D s->last_update_interrupt_minutes) {
> +            s->last_update_interrupt_minutes =3D now.tm_min;
> +            s->nvram[FLAG_REGISTER] |=3D FLAG_MASK_UF;
> +            fire_interrupt =3D true;
> +        } else if (!(s->nvram[EXTENSION_REGISTER] & EXT_MASK_USEL)) {
> +            /* per second update interrupt */
> +            s->nvram[FLAG_REGISTER] |=3D FLAG_MASK_UF;
> +            fire_interrupt =3D true;
> +        }
> +    }
> +
> +    /* Alarm interrupt */
> +    if ((s->nvram[EXTENSION_REGISTER] & EXT_MASK_WADA)) {
> +        alarm_week_day_matches =3D
> +            s->nvram[ALARM_WEEK_DAY] =3D=3D to_bcd(now.tm_mday);
> +    } else {
> +        alarm_week_day_matches =3D
> +            s->nvram[ALARM_WEEK_DAY] =3D=3D
> +                0x01 << ((now.tm_wday + s->wday_offset) % 7);
> +    }
> +
> +    if ((s->nvram[CONTROL_REGISTER] & CTRL_MASK_AIE) && now.tm_sec =3D=
=3D 0 &&
> +            s->nvram[ALARM_MINUTE] =3D=3D to_bcd(now.tm_min) &&
> +            s->nvram[ALARM_HOUR] =3D=3D to_bcd(now.tm_hour) &&
> +            alarm_week_day_matches) {
> +        trace_rx8900_trigger_alarm();
> +        s->nvram[FLAG_REGISTER] |=3D FLAG_MASK_AF;
> +        fire_interrupt =3D true;
> +    }
> +
> +    if (fire_interrupt) {
> +        trace_rx8900_fire_interrupt();
> +        qemu_irq_pulse(s->interrupt_pin);
> +    }
> +}
> +
> +
> +#define COUNTDOWN_TIMER_FREQ 4096
> +
> +/**
> + * Validate the extension register and perform actions based on the bits
> + * @param s the RTC to operate on
> + * @param data the new data for the extension register
> + */
> +static void update_extension_register(RX8900State *s, uint8_t data)
> +{
> +    if (data & EXT_MASK_TEST) {
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                "Test bit is enabled but is forbidden by the manufacture=
r");
> +    }
> +
> +    if ((data ^ s->nvram[EXTENSION_REGISTER]) &
> +            (EXT_MASK_FSEL0 | EXT_MASK_FSEL1)) {
> +        /* FSELx has changed */
> +
> +        switch (data & (EXT_MASK_FSEL0 | EXT_MASK_FSEL1)) {
> +        case EXT_MASK_FSEL0:
> +            trace_rx8900_set_fout(1024);
> +            ptimer_set_limit(s->fout_timer, 32, 1);
> +            break;
> +        case EXT_MASK_FSEL1:
> +            trace_rx8900_set_fout(1);
> +            ptimer_set_limit(s->fout_timer, 32768, 1);
> +            break;
> +        case 0:
> +        case (EXT_MASK_FSEL0 | EXT_MASK_FSEL1):
> +            trace_rx8900_set_fout(32768);
> +            ptimer_set_limit(s->fout_timer, 1, 1);
> +            break;
> +        }
> +    }
> +
> +    if ((data ^ s->nvram[EXTENSION_REGISTER]) &
> +            (EXT_MASK_TSEL0 | EXT_MASK_TSEL1)) {
> +        /* TSELx has changed */
> +        switch (data & (EXT_MASK_TSEL0 | EXT_MASK_TSEL1)) {
> +        case 0:
> +            trace_rx8900_set_countdown_timer(64);
> +            ptimer_set_limit(s->countdown_timer, COUNTDOWN_TIMER_FREQ / =
64, 1);
> +            break;
> +        case EXT_MASK_TSEL0:
> +            trace_rx8900_set_countdown_timer(1);
> +            ptimer_set_limit(s->countdown_timer, COUNTDOWN_TIMER_FREQ, 1=
);
> +            break;
> +        case EXT_MASK_TSEL1:
> +            trace_rx8900_set_countdown_timer_per_minute();
> +            ptimer_set_limit(s->countdown_timer, COUNTDOWN_TIMER_FREQ * =
60, 1);
> +            break;
> +        case (EXT_MASK_TSEL0 | EXT_MASK_TSEL1):
> +            trace_rx8900_set_countdown_timer(COUNTDOWN_TIMER_FREQ);
> +            ptimer_set_limit(s->countdown_timer, 1, 1);
> +            break;
> +        }
> +    }
> +
> +    if (data & EXT_MASK_TE) {
> +        enable_countdown_timer(s);
> +    }
> +
> +    s->nvram[EXTENSION_REGISTER] =3D data;
> +    s->nvram[EXT_EXTENSION_REGISTER] =3D data;
> +
> +}
> +/**
> + * Validate the control register and perform actions based on the bits
> + * @param s the RTC to operate on
> + * @param data the new value for the control register
> + */
> +
> +static void update_control_register(RX8900State *s, uint8_t data)
> +{
> +    uint8_t diffmask =3D ~s->nvram[CONTROL_REGISTER] & data;
> +
> +    if (diffmask & CTRL_MASK_WP0) {
> +        data &=3D ~CTRL_MASK_WP0;
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "Attempt to write to write protected bit %d in control regis=
ter",
> +            CTRL_REG_WP0);
> +    }
> +
> +    if (diffmask & CTRL_MASK_WP1) {
> +        data &=3D ~CTRL_MASK_WP1;
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "Attempt to write to write protected bit %d in control regis=
ter",
> +            CTRL_REG_WP1);
> +    }
> +
> +    if (data & CTRL_MASK_RESET) {
> +        data &=3D ~CTRL_MASK_RESET;
> +        rx8900_reset(DEVICE(s));
> +    }
> +
> +    if (diffmask & CTRL_MASK_UIE) {
> +        /* Update interrupts were off and are now on */
> +        struct tm now;
> +
> +        trace_rx8900_enable_update_timer();
> +
> +        qemu_get_timedate(&now, s->offset);
> +
> +        s->last_update_interrupt_minutes =3D now.tm_min;
> +        s->last_interrupt_seconds =3D now.tm_sec;
> +        enable_timer(s);
> +    }
> +
> +    if (diffmask & CTRL_MASK_AIE) {
> +        /* Alarm interrupts were off and are now on */
> +        struct tm now;
> +
> +        trace_rx8900_enable_alarm();
> +
> +        qemu_get_timedate(&now, s->offset);
> +
> +        s->last_interrupt_seconds =3D now.tm_sec;
> +        enable_timer(s);
> +    }
> +
> +    if (!(data & (CTRL_MASK_UIE | CTRL_MASK_AIE))) {
> +        disable_timer(s);
> +    }
> +
> +    s->nvram[CONTROL_REGISTER] =3D data;
> +    s->nvram[EXT_CONTROL_REGISTER] =3D data;
> +}
> +
> +/**
> + * Validate the flag register
> + * @param s the RTC to operate on
> + * @param data the new value for the flag register
> + */
> +static void validate_flag_register(RX8900State *s, uint8_t *data)
> +{
> +    uint8_t diffmask =3D ~s->nvram[FLAG_REGISTER] & *data;
> +
> +    if (diffmask & FLAG_MASK_VDET) {
> +        *data &=3D ~FLAG_MASK_VDET;
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "Only 0 can be written to VDET bit %d in the flag register",
> +            FLAG_REG_VDET);
> +    }
> +
> +    if (diffmask & FLAG_MASK_VLF) {
> +        *data &=3D ~FLAG_MASK_VLF;
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "Only 0 can be written to VLF bit %d in the flag register",
> +            FLAG_REG_VLF);
> +    }
> +
> +    if (diffmask & FLAG_MASK_UNUSED_2) {
> +        *data &=3D ~FLAG_MASK_UNUSED_2;
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "Only 0 can be written to unused bit %d in the flag register=
",
> +            FLAG_REG_UNUSED_2);
> +    }
> +
> +    if (diffmask & FLAG_MASK_UNUSED_6) {
> +        *data &=3D ~FLAG_MASK_UNUSED_6;
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "Only 0 can be written to unused bit %d in the flag register=
",
> +            FLAG_REG_UNUSED_6);
> +    }
> +
> +    if (diffmask & FLAG_MASK_UNUSED_7) {
> +        *data &=3D ~FLAG_MASK_UNUSED_7;
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +            "Only 0 can be written to unused bit %d in the flag register=
",
> +            FLAG_REG_UNUSED_7);
> +    }
> +}
> +
> +/**
> + * Handle FOUT_ENABLE (FOE) line
> + * Enables/disables the FOUT line
> + * @param opaque the device instance
> + * @param n the IRQ number
> + * @param level true if the line has been raised
> + */
> +static void rx8900_fout_enable_handler(void *opaque, int n, int level)
> +{
> +    RX8900State *s =3D RX8900(opaque);
> +
> +    if (level) {
> +        trace_rx8900_enable_fout();
> +        ptimer_run(s->fout_timer, 0);
> +    } else {
> +        /* disable fout */
> +        trace_rx8900_disable_fout();
> +        ptimer_stop(s->fout_timer);
> +    }
> +}
> +
> +/**
> + * Tick the FOUT timer
> + * @param opaque the device instance
> + */
> +static void rx8900_fout_tick(void *opaque)
> +{
> +    RX8900State *s =3D (RX8900State *)opaque;
> +
> +    trace_rx8900_fout_toggle();
> +    s->fout_state =3D !s->fout_state;
> +
> +    qemu_set_irq(s->fout_pin, s->fout_state ? 1 : 0);
> +}

Directly modelling a 32kHz output pin by actually trying
to toggle a qemu IRQ at 32kHz is also going to really
hurt performance. The simple approach is not to bother
modelling this: do you really need it?. Otherwise you're
going to want to model something which actually tells
the other end "this is a clock signal at frequency f
which is currently enabled/disabled", and allow the
other end to sort itself out accordingly. The stuff that
Fred Konrad posted recently about clock tree modelling
may be relevant here.

> +
> +/**
> + * Verify the current voltage and raise flags if it is low
> + * @param s the RTC to operate on
> + */
> +static void check_voltage(RX8900State *s)
> +{
> +    if (!(s->nvram[BACKUP_FUNCTION] & BACKUP_MASK_VDETOFF)) {
> +        if (s->supply_voltage < 2.0) {
> +            s->nvram[FLAG_REGISTER] |=3D FLAG_MASK_VDET;
> +        }
> +
> +        if (s->supply_voltage < 1.6) {
> +            s->nvram[FLAG_REGISTER] |=3D FLAG_MASK_VLF;
> +        }
> +    }
> +}
> +
> +/**
> + * Determine if we have a valid weekday mask
> + * @return true if the weekday is valid
> + */
> +static bool weekday_is_valid(uint8_t weekday)
> +{
> +    if (ctpop8(weekday) =3D=3D 1 && weekday <=3D 0x40) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
> +/**
> + * Receive a byte of data from i2c
> + * @param i2c the i2c device that is receiving data
> + * @param data the data that was received
> + */
> +static int rx8900_send(I2CSlave *i2c, uint8_t data)
> +{
> +    RX8900State *s =3D RX8900(i2c);
> +
> +    trace_rx8900_i2c_data_receive(data);
> +
> +    if (s->addr_byte) {
> +        s->nvram_offset =3D data & (RX8900_NVRAM_SIZE - 1);
> +        trace_rx8900_regptr_update(s->nvram_offset);
> +        s->addr_byte =3D false;
> +        return 0;
> +    }
> +
> +    trace_rx8900_set_register(s->nvram_offset, data);
> +
> +    switch (s->nvram_offset) {
> +    case SECONDS:
> +    case EXT_SECONDS:
> +        s->time_altered =3D true;
> +        s->now.tm_sec =3D from_bcd(data & 0x7f);
> +        if (s->now.tm_sec > 59) { /* RX8900 does not support leap second=
s */
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "RX8900 - second data '%x' is out of range, "
> +                    "undefined behavior will result", data);
> +        }
> +        break;
> +
> +    case MINUTES:
> +    case EXT_MINUTES:
> +        s->time_altered =3D true;
> +        s->now.tm_min =3D from_bcd(data & 0x7f);
> +        if (s->now.tm_min > 59) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "RX8900 - minute data '%x' is out of range, "
> +                    "undefined behavior will result", data);
> +        }
> +        break;
> +
> +    case HOURS:
> +    case EXT_HOURS:
> +        s->time_altered =3D true;
> +        s->now.tm_hour =3D from_bcd(data & 0x3f);
> +        if (s->now.tm_hour > 24) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "RX8900 - hour data '%x' is out of range, "
> +                    "undefined behavior will result", data);
> +        }
> +        break;
> +
> +    case WEEKDAY:
> +    case EXT_WEEKDAY: {
> +        int user_wday =3D ctz32(data);
> +        /* The day field is supposed to contain a value in
> +         * with only 1 of bits 0-6 set. Otherwise behavior is undefined.
> +         */
> +        if (!weekday_is_valid(data)) {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                "RX8900 - weekday data '%x' is out of range, "
> +                        "undefined behavior will result", data);
> +        }
> +        s->weekday =3D user_wday;
> +        break;
> +    }
> +
> +    case DAY:
> +    case EXT_DAY:
> +        s->time_altered =3D true;
> +        s->now.tm_mday =3D from_bcd(data & 0x3f);
> +        break;
> +
> +    case MONTH:
> +    case EXT_MONTH:
> +        s->time_altered =3D true;
> +        s->now.tm_mon =3D from_bcd(data & 0x1f) - 1;
> +        break;
> +
> +    case YEAR:
> +    case EXT_YEAR:
> +        s->time_altered =3D true;
> +        s->now.tm_year =3D from_bcd(data) + 100;
> +        break;
> +
> +    case EXTENSION_REGISTER:
> +    case EXT_EXTENSION_REGISTER:
> +        update_extension_register(s, data);
> +        break;
> +
> +    case FLAG_REGISTER:
> +    case EXT_FLAG_REGISTER:
> +        validate_flag_register(s, &data);
> +
> +        s->nvram[FLAG_REGISTER] =3D data;
> +        s->nvram[EXT_FLAG_REGISTER] =3D data;
> +
> +        check_voltage(s);
> +        break;
> +
> +    case CONTROL_REGISTER:
> +    case EXT_CONTROL_REGISTER:
> +        update_control_register(s, data);
> +        break;
> +
> +    default:
> +        s->nvram[s->nvram_offset] =3D data;
> +    }
> +
> +    inc_regptr(s);
> +    return 0;
> +}
> +
> +/**
> + * Get the device temperature in Celsius as a property
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
> +    double value =3D (s->nvram[TEMPERATURE] * 2.0 - 187.1) / 3.218;
> +
> +    trace_rx8900_get_temperature(s->nvram[TEMPERATURE], value);
> +
> +    visit_type_number(v, name, &value, errp);
> +}
> +
> +/**
> + * Encode a temperature in Celsius
> + * @param celsius the temperature
> + * @return the encoded temperature
> + */
> +static inline uint8_t encode_temperature(double celsius)
> +{
> +    return (uint8_t) ((celsius * 3.218 + 187.19) / 2);
> +}
> +
> +/**
> + * Set the device temperature in Celsius as a property
> + * @param obj the device
> + * @param v
> + * @param name the property name
> + * @param opaque
> + * @param errp an error object to populate on failure
> + */
> +static void rx8900_set_temperature(Object *obj, Visitor *v, const char *=
name,
> +                                   void *opaque, Error **errp)
> +{
> +    RX8900State *s =3D RX8900(obj);
> +    Error *local_err =3D NULL;
> +    double temp; /* degrees Celsius */
> +    visit_type_number(v, name, &temp, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +    if (temp >=3D 100 || temp < -58) {
> +        error_setg(errp, "value %fC is out of range", temp);
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
> +    double voltage;
> +    visit_type_number(v, name, &voltage, &local_err);
> +    if (local_err) {
> +        error_propagate(errp, local_err);
> +        return;
> +    }
> +
> +    s->supply_voltage =3D voltage;
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
> +    s->weekday =3D INVALID_WEEKDAY;
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
> +    const char *name;
> +
> +    s->fout_state =3D false;
> +
> +    memset(s->nvram, 0, RX8900_NVRAM_SIZE);
> +    /* Set the initial state to 25 degrees Celsius */
> +    s->nvram[TEMPERATURE] =3D encode_temperature(25.0);
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
> +    name =3D "rx8900-interrupt-out";
> +    qdev_init_gpio_out_named(&i2c->qdev, &s->interrupt_pin, name, 1);
> +    trace_rx8900_pin_name("Interrupt", name);
> +
> +    name =3D "rx8900-fout-enable";
> +    qdev_init_gpio_in_named(&i2c->qdev, rx8900_fout_enable_handler, name=
, 1);
> +    trace_rx8900_pin_name("Fout-enable", name);
> +
> +    name =3D "rx8900-fout";
> +    qdev_init_gpio_out_named(&i2c->qdev, &s->fout_pin, name, 1);
> +    trace_rx8900_pin_name("Fout", name);
> +
> +    /* Set up default voltage */
> +    s->supply_voltage =3D 3.3f;
> +    trace_rx8900_set_voltage(s->supply_voltage);
> +
> +    s->time_altered =3D false;
> +}
> +
> +/**
> + * Set up the device callbacks
> + * @param klass the device class
> + * @param data
> + */
> +static void rx8900_class_init(ObjectClass *klass, void *data)
> +{
> +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> +    I2CSlaveClass *k =3D I2C_SLAVE_CLASS(klass);
> +
> +    k->event =3D rx8900_event;
> +    k->recv =3D rx8900_recv;
> +    k->send =3D rx8900_send;
> +    dc->realize =3D rx8900_realize;
> +    dc->reset =3D rx8900_reset;
> +    dc->vmsd =3D &vmstate_rx8900;
> +}
> +
> +static const TypeInfo rx8900_info =3D {
> +    .name =3D TYPE_RX8900,
> +    .parent =3D TYPE_I2C_SLAVE,
> +    .instance_size =3D sizeof(RX8900State),
> +    .instance_init =3D rx8900_initfn,
> +    .class_init =3D rx8900_class_init,
> +};
> +
> +/**
> + * Register the device with QEMU
> + */
> +static void rx8900_register_types(void)
> +{
> +    type_register_static(&rx8900_info);
> +}
> +
> +type_init(rx8900_register_types)
> diff --git a/hw/timer/rx8900_regs.h b/hw/timer/rx8900_regs.h
> new file mode 100644
> index 0000000..0aaa9a3
> --- /dev/null
> +++ b/hw/timer/rx8900_regs.h
> @@ -0,0 +1,141 @@
> +/*
> + * Epson RX8900SA/CE Realtime Clock Module
> + *
> + * Copyright (c) 2016 IBM Corporation
> + * Authors:
> + *  Alastair D'Silva <alastair@d-silva.org>
> + *
> + * This code is licensed under the GPL version 2 or later.  See
> + * the COPYING file in the top-level directory.
> + *
> + * Datasheet available at:
> + *  https://support.epson.biz/td/api/doc_check.php?dl=3Dapp_RX8900CE&lan=
g=3Den
> + *
> + */
> +
> +#ifndef RX8900_REGS_H
> +#define RX8900_REGS_H
> +
> +#include "qemu/bitops.h"
> +
> +#define RX8900_NVRAM_SIZE 0x20
> +
> +typedef enum RX8900Addresses {
> +    START_ADDRESS =3D 0x00,
> +    SECONDS =3D 0x00,
> +    MINUTES =3D 0x01,
> +    HOURS =3D 0x02,
> +    WEEKDAY =3D 0x03, /* a walking bit with bit 0 set for Sunday, 1 for =
Monday...
> +                       6 for Saturday, see the datasheet for details */
> +    DAY =3D 0x04,
> +    MONTH =3D 0x05,
> +    YEAR =3D 0x06,
> +    RAM =3D 0x07,
> +    ALARM_MINUTE =3D 0x08,
> +    ALARM_HOUR =3D 0x09,
> +    ALARM_WEEK_DAY =3D 0x0A,
> +    TIMER_COUNTER_0 =3D 0x0B,
> +    TIMER_COUNTER_1 =3D 0x0C,
> +    EXTENSION_REGISTER =3D 0x0D,
> +    FLAG_REGISTER =3D 0X0E,
> +    CONTROL_REGISTER =3D 0X0F,
> +    EXT_SECONDS =3D 0x010, /* Alias of SECONDS */
> +    EXT_MINUTES =3D 0x11, /* Alias of MINUTES */
> +    EXT_HOURS =3D 0x12, /* Alias of HOURS */
> +    EXT_WEEKDAY =3D 0x13, /* Alias of WEEKDAY */
> +    EXT_DAY =3D 0x14, /* Alias of DAY */
> +    EXT_MONTH =3D 0x15, /* Alias of MONTH */
> +    EXT_YEAR =3D 0x16, /* Alias of YEAR */
> +    TEMPERATURE =3D 0x17,
> +    BACKUP_FUNCTION =3D 0x18,
> +    NO_USE_1 =3D 0x19,
> +    NO_USE_2 =3D 0x1A,
> +    EXT_TIMER_COUNTER_0 =3D 0x1B, /* Alias of TIMER_COUNTER_0 */
> +    EXT_TIMER_COUNTER_1 =3D 0x1C, /* Alias of TIMER_COUNTER_1 */
> +    EXT_EXTENSION_REGISTER =3D 0x1D, /* Alias of EXTENSION_REGISTER */
> +    EXT_FLAG_REGISTER =3D 0X1E, /* Alias of FLAG_REGISTER */
> +    EXT_CONTROL_REGISTER =3D 0X1F /* Alias of CONTROL_REGISTER */
> +} RX8900Addresses;
> +
> +typedef enum ExtRegBits {
> +    EXT_REG_TSEL0 =3D 0,
> +    EXT_REG_TSEL1 =3D 1,
> +    EXT_REG_FSEL0 =3D 2,
> +    EXT_REG_FSEL1 =3D 3,
> +    EXT_REG_TE =3D 4,
> +    EXT_REG_USEL =3D 5,
> +    EXT_REG_WADA =3D 6,
> +    EXT_REG_TEST =3D 7
> +} ExtRegBits;
> +
> +typedef enum ExtRegMasks {
> +    EXT_MASK_TSEL0 =3D BIT(0),
> +    EXT_MASK_TSEL1 =3D BIT(1),
> +    EXT_MASK_FSEL0 =3D BIT(2),
> +    EXT_MASK_FSEL1 =3D BIT(3),
> +    EXT_MASK_TE =3D BIT(4),
> +    EXT_MASK_USEL =3D BIT(5),
> +    EXT_MASK_WADA =3D BIT(6),
> +    EXT_MASK_TEST =3D BIT(7)
> +} ExtRegMasks;
> +
> +typedef enum CtrlRegBits {
> +    CTRL_REG_RESET =3D 0,
> +    CTRL_REG_WP0 =3D 1,
> +    CTRL_REG_WP1 =3D 2,
> +    CTRL_REG_AIE =3D 3,
> +    CTRL_REG_TIE =3D 4,
> +    CTRL_REG_UIE =3D 5,
> +    CTRL_REG_CSEL0 =3D 6,
> +    CTRL_REG_CSEL1 =3D 7
> +} CtrlRegBits;
> +
> +typedef enum CtrlRegMask {
> +    CTRL_MASK_RESET =3D BIT(0),
> +    CTRL_MASK_WP0 =3D BIT(1),
> +    CTRL_MASK_WP1 =3D BIT(2),
> +    CTRL_MASK_AIE =3D BIT(3),
> +    CTRL_MASK_TIE =3D BIT(4),
> +    CTRL_MASK_UIE =3D BIT(5),
> +    CTRL_MASK_CSEL0 =3D BIT(6),
> +    CTRL_MASK_CSEL1 =3D BIT(7)
> +} CtrlRegMask;
> +
> +typedef enum FlagRegBits {
> +    FLAG_REG_VDET =3D 0,
> +    FLAG_REG_VLF =3D 1,
> +    FLAG_REG_UNUSED_2 =3D 2,
> +    FLAG_REG_AF =3D 3,
> +    FLAG_REG_TF =3D 4,
> +    FLAG_REG_UF =3D 5,
> +    FLAG_REG_UNUSED_6 =3D 6,
> +    FLAG_REG_UNUSED_7 =3D 7
> +} FlagRegBits;
> +
> +#define RX8900_INTERRUPT_SOURCES 6
> +typedef enum FlagRegMask {
> +    FLAG_MASK_VDET =3D BIT(0),
> +    FLAG_MASK_VLF =3D BIT(1),
> +    FLAG_MASK_UNUSED_2 =3D BIT(2),
> +    FLAG_MASK_AF =3D BIT(3),
> +    FLAG_MASK_TF =3D BIT(4),
> +    FLAG_MASK_UF =3D BIT(5),
> +    FLAG_MASK_UNUSED_6 =3D BIT(6),
> +    FLAG_MASK_UNUSED_7 =3D BIT(7)
> +} FlagRegMask;
> +
> +typedef enum BackupRegBits {
> +    BACKUP_REG_BKSMP0 =3D 0,
> +    BACKUP_REG_BKSMP1 =3D 1,
> +    BACKUP_REG_SWOFF =3D 2,
> +    BACKUP_REG_VDETOFF =3D 3
> +} BackupRegBits;
> +
> +typedef enum BackupRegMask {
> +    BACKUP_MASK_BKSMP0 =3D BIT(0),
> +    BACKUP_MASK_BKSMP1 =3D BIT(1),
> +    BACKUP_MASK_SWOFF =3D BIT(2),
> +    BACKUP_MASK_VDETOFF =3D BIT(3)
> +} BackupRegMask;
> +
> +#endif
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 3495c41..45d992f 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -49,3 +49,34 @@ aspeed_timer_ctrl_pulse_enable(uint8_t i, bool enable)=
 "Timer %" PRIu8 ": %d"
>  aspeed_timer_set_ctrl2(uint32_t value) "Value: 0x%" PRIx32
>  aspeed_timer_set_value(int timer, int reg, uint32_t value) "Timer %d reg=
ister %d: 0x%" PRIx32
>  aspeed_timer_read(uint64_t offset, unsigned size, uint64_t value) "From =
0x%" PRIx64 ": of size %u: 0x%" PRIx64
> +
> +# hw/timer/rx8900.c
> +rx8900_capture_current_time(int hour, int minute, int second, int weekda=
y, int mday, int month, int year, int raw_hours, int raw_minutes, int raw_s=
econds, int raw_weekday, int raw_day, int raw_month, int raw_year, long off=
set) "Update current time to %02d:%02d:%02d %d %d/%d/%d (0x%02x%02x%02x%02x=
%02x%02x%02x), offset=3D%ld"
> +rx8900_regptr_update(uint32_t ptr) "Operating on register 0x%02x"
> +rx8900_regptr_overflow(void) "Register pointer has overflowed, wrapping =
to 0"
> +rx8900_event_weekday(int weekday, int weekmask, int weekday_offset) "Set=
 weekday to %d (0x%02x), wday_offset=3D%d"
> +rx8900_read_register(int address, int val) "Read register 0x%x =3D 0x%x"
> +rx8900_set_fout(int hz) "Setting fout to %dHz"
> +rx8900_set_countdown_timer(int hz) "Setting countdown timer to %d Hz"
> +rx8900_set_countdown_timer_per_minute(void) "Setting countdown timer to =
per minute updates"
> +rx8900_enable_update_timer(void) ""
> +rx8900_enable_alarm(void) ""
> +rx8900_trigger_alarm(void) ""
> +rx8900_tick(void) ""
> +rx8900_fire_interrupt(void) ""
> +rx8900_disable_timer(void) ""
> +rx8900_enable_timer(void) ""
> +rx8900_disable_fout(void) ""
> +rx8900_enable_fout(void) ""
> +rx8900_fout_toggle(void) ""
> +rx8900_disable_countdown_timer(void) ""
> +rx8900_enable_countdown_timer(void) ""
> +rx8900_countdown_tick(int count) "Countdown tick, count=3D%d"
> +rx8900_countdown_elapsed(void) ""
> +rx8900_i2c_data_receive(uint8_t data) "Received I2C data 0x%02x"
> +rx8900_set_register(uint32_t addr, uint8_t data) "Set data 0x%02x=3D0x%0=
2x"
> +rx8900_get_temperature(uint8_t raw, double val) "0x%x =3D %fC"
> +rx8900_set_temperature(uint8_t raw, double val) "0x%x =3D %fC"
> +rx8900_reset(void) ""
> +rx8900_pin_name(const char *type, const char *name) "'%s' pin is '%s'"
> +rx8900_set_voltage(double voltage) "Device voltage set to %f"
> --
> 2.9.3
>

thanks
-- PMM
