Received: from eggs.gnu.org ([2001:4830:134:3::10]:54294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dSoXU-0000ty-F7
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dSoXT-0008FY-5F
	for qemu-devel@nongnu.org; Wed, 05 Jul 2017 13:56:36 -0400
MIME-Version: 1.0
In-Reply-To: <1499057115-6773-2-git-send-email-sundeep.lkml@gmail.com>
References: <1499057115-6773-1-git-send-email-sundeep.lkml@gmail.com>
	<1499057115-6773-2-git-send-email-sundeep.lkml@gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 5 Jul 2017 10:56:02 -0700
Message-ID: <CAKmqyKOyaJQKOmGK=+jgUOJ5vKeUXJH2OEQmxU-qsD8ftC-25Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu devel v6 PATCH 1/5] msf2: Add Smartfusion2
 System timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Subbaraya Sundeep <sundeep.lkml@gmail.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Sun, Jul 2, 2017 at 9:45 PM, Subbaraya Sundeep
<sundeep.lkml@gmail.com> wrote:
> Modelled System Timer in Microsemi's Smartfusion2 Soc.
> Timer has two 32bit down counters and two interrupts.
>
> Signed-off-by: Subbaraya Sundeep <sundeep.lkml@gmail.com>
> ---
>  hw/timer/Makefile.objs       |   1 +
>  hw/timer/mss-timer.c         | 261 +++++++++++++++++++++++++++++++++++++++++++
>  include/hw/timer/mss-timer.h |  67 +++++++++++
>  3 files changed, 329 insertions(+)
>  create mode 100644 hw/timer/mss-timer.c
>  create mode 100644 include/hw/timer/mss-timer.h
>
> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index dd6f27e..fc4d2da 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -41,3 +41,4 @@ common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
>  common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
>
>  common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
> +common-obj-$(CONFIG_MSF2) += mss-timer.o
> diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
> new file mode 100644
> index 0000000..e46d118
> --- /dev/null
> +++ b/hw/timer/mss-timer.c
> @@ -0,0 +1,261 @@
> +/*
> + * Block model of System timer present in
> + * Microsemi's SmartFusion2 and SmartFusion SoCs.
> + *
> + * Copyright (c) 2017 Subbaraya Sundeep <sundeep.lkml@gmail.com>.
> + *
> + * Permission is hereby granted, free of charge, to any person obtaining a copy
> + * of this software and associated documentation files (the "Software"), to deal
> + * in the Software without restriction, including without limitation the rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
> + * copies of the Software, and to permit persons to whom the Software is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be included in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "hw/timer/mss-timer.h"
> +
> +#ifndef MSS_TIMER_ERR_DEBUG
> +#define MSS_TIMER_ERR_DEBUG  0
> +#endif
> +
> +#define DB_PRINT_L(lvl, fmt, args...) do { \
> +    if (MSS_TIMER_ERR_DEBUG >= lvl) { \
> +        qemu_log("%s: " fmt "\n", __func__, ## args); \
> +    } \
> +} while (0);
> +
> +#define DB_PRINT(fmt, args...) DB_PRINT_L(1, fmt, ## args)
> +
> +#define R_TIM_VAL         0
> +#define R_TIM_LOADVAL     1
> +#define R_TIM_BGLOADVAL   2
> +#define R_TIM_CTRL        3
> +#define R_TIM_RIS         4
> +#define R_TIM_MIS         5
> +
> +#define TIMER_CTRL_ENBL     (1 << 0)
> +#define TIMER_CTRL_ONESHOT  (1 << 1)
> +#define TIMER_CTRL_INTR     (1 << 2)
> +#define TIMER_RIS_ACK       (1 << 0)
> +#define TIMER_RST_CLR       (1 << 6)
> +#define TIMER_MODE          (1 << 0)
> +
> +static void timer_update_irq(struct Msf2Timer *st)
> +{
> +    bool isr, ier;
> +
> +    isr = !!(st->regs[R_TIM_RIS] & TIMER_RIS_ACK);
> +    ier = !!(st->regs[R_TIM_CTRL] & TIMER_CTRL_INTR);
> +    qemu_set_irq(st->irq, (ier && isr));
> +}
> +
> +static void timer_update(struct Msf2Timer *st)
> +{
> +    uint64_t count;
> +
> +    if (!(st->regs[R_TIM_CTRL] & TIMER_CTRL_ENBL)) {
> +        ptimer_stop(st->ptimer);
> +        return;
> +    }
> +
> +    count = st->regs[R_TIM_LOADVAL];
> +    ptimer_set_limit(st->ptimer, count, 1);
> +    ptimer_run(st->ptimer, 1);
> +}
> +
> +static uint64_t
> +timer_read(void *opaque, hwaddr offset, unsigned int size)
> +{
> +    MSSTimerState *t = opaque;
> +    hwaddr addr;
> +    struct Msf2Timer *st;
> +    uint32_t ret = 0;
> +    int timer = 0;
> +    int isr;
> +    int ier;
> +
> +    addr = offset >> 2;
> +    /*
> +     * Two independent timers has same base address.
> +     * Based on address passed figure out which timer is being used.
> +     */
> +    if ((addr >= R_TIM1_MAX) && (addr < NUM_TIMERS * R_TIM1_MAX)) {
> +        timer = 1;
> +        addr -= R_TIM1_MAX;
> +    }
> +
> +    st = &t->timers[timer];
> +
> +    switch (addr) {
> +    case R_TIM_VAL:
> +        ret = ptimer_get_count(st->ptimer);
> +        break;
> +
> +    case R_TIM_MIS:
> +        isr = !!(st->regs[R_TIM_RIS] & TIMER_RIS_ACK);
> +        ier = !!(st->regs[R_TIM_CTRL] & TIMER_CTRL_INTR);
> +        ret = ier & isr;
> +        break;
> +
> +    default:
> +        if (addr < NUM_TIMERS * R_TIM1_MAX) {

Shouldn't this just be: addr < R_TIM1_MAX?

At this point you have already subjected the offset for multiple timers.

> +            ret = st->regs[addr];
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                        TYPE_MSS_TIMER": 64-bit mode not supported\n");

Maybe add a return here so you don't print the other debug message after this.

> +        }
> +        break;
> +    }
> +
> +    DB_PRINT("timer=%d 0x%" HWADDR_PRIx "=0x%" PRIx32, timer, offset,
> +            ret);
> +    return ret;
> +}
> +
> +static void
> +timer_write(void *opaque, hwaddr offset,
> +            uint64_t val64, unsigned int size)
> +{
> +    MSSTimerState *t = opaque;
> +    hwaddr addr;
> +    struct Msf2Timer *st;
> +    int timer = 0;
> +    uint32_t value = val64;
> +
> +    addr = offset >> 2;
> +    /*
> +     * Two independent timers has same base address.
> +     * Based on addr passed figure out which timer is being used.
> +     */
> +    if ((addr >= R_TIM1_MAX) && (addr < NUM_TIMERS * R_TIM1_MAX)) {
> +        timer = 1;
> +        addr -= R_TIM1_MAX;
> +    }
> +
> +    st = &t->timers[timer];
> +
> +    DB_PRINT("addr=0x%" HWADDR_PRIx " val=0x%" PRIx32 " (timer=%d)", offset,
> +            value, timer);
> +
> +    switch (addr) {
> +    case R_TIM_CTRL:
> +        st->regs[R_TIM_CTRL] = value;
> +        timer_update(st);
> +        break;
> +
> +    case R_TIM_RIS:
> +        if (value & TIMER_RIS_ACK) {
> +            st->regs[R_TIM_RIS] &= ~TIMER_RIS_ACK;
> +        }
> +        break;
> +
> +    case R_TIM_LOADVAL:
> +        st->regs[R_TIM_LOADVAL] = value;
> +        if (st->regs[R_TIM_CTRL] & TIMER_CTRL_ENBL) {
> +            timer_update(st);
> +        }
> +        break;
> +
> +    case R_TIM_BGLOADVAL:
> +        st->regs[R_TIM_BGLOADVAL] = value;
> +        st->regs[R_TIM_LOADVAL] = value;
> +        break;
> +
> +    case R_TIM_VAL:
> +    case R_TIM_MIS:
> +        break;
> +
> +    default:
> +        if (addr < NUM_TIMERS * R_TIM1_MAX) {

Same comment as above.

> +            st->regs[addr] = value;
> +        } else {
> +            qemu_log_mask(LOG_GUEST_ERROR,
> +                        TYPE_MSS_TIMER": 64-bit mode not supported\n");
> +            return;
> +        }
> +        break;
> +    }
> +    timer_update_irq(st);
> +}

Once those comments above are addressed:

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks,
Alistair
