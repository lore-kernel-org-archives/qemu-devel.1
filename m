Received: from eggs.gnu.org ([2001:4830:134:3::10]:36603)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmtQ-0004a7-AU
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:13:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGmtN-00079h-5b
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:13:16 -0500
Received: from mail-vk0-f51.google.com ([209.85.213.51]:36829)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGmtM-00079T-VQ
	for qemu-devel@nongnu.org; Tue, 13 Dec 2016 08:13:13 -0500
Received: by mail-vk0-f51.google.com with SMTP id p9so60211116vkd.3
	for <qemu-devel@nongnu.org>; Tue, 13 Dec 2016 05:13:12 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <71bc12badf4f3125765146c21b4976b1d07dce46.1478566669.git.alistair.francis@xilinx.com>
References: <cover.1478566669.git.alistair.francis@xilinx.com>
	<71bc12badf4f3125765146c21b4976b1d07dce46.1478566669.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Dec 2016 13:11:51 +0000
Message-ID: <CAFEAcA9vrhPyHbpWqxjS167f_aG-NRf7EVms=dg6ULah_fwmgw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2 1/2] arm_generic_timer: Add the ARM
 Generic Timer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, =?UTF-8?B?S09OUkFEIEZyw6lkw6lyaWM=?= <fred.konrad@greensocs.com>, Alistair Francis <alistair23@gmail.com>

On 8 November 2016 at 00:58, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Add the ARM generic timer. This allows the guest to poll the timer for
> values and also supports secure writes only.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V2:
>  - Fix couter/counter typo
>
>  hw/timer/Makefile.objs               |   1 +
>  hw/timer/arm_generic_timer.c         | 216 +++++++++++++++++++++++++++++++++++
>  include/hw/timer/arm_generic_timer.h |  60 ++++++++++
>  3 files changed, 277 insertions(+)
>  create mode 100644 hw/timer/arm_generic_timer.c
>  create mode 100644 include/hw/timer/arm_generic_timer.h

I can't quite seem to make this line up with the spec in the v8
ARM ARM (chapter 11 "System Level Implementation of the Generic
Timer"). The generic timer documented there looks quite like this,
but has extra ID registers at 0xFD0..0xFFC which this code doesn't
implement, and also has the "CNTReadBase" memory map (which
exposes just the count value and ID registers) as well as the
"CNTControlBase" map that looks like what you have here.
(The register names here differ from the conventions in the
ARM ARM too.)

Is this code trying to implement that Generic Timer, or something
else with a similar name?

> diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
> index 7ba8c23..f88c468 100644
> --- a/hw/timer/Makefile.objs
> +++ b/hw/timer/Makefile.objs
> @@ -17,6 +17,7 @@ common-obj-$(CONFIG_IMX) += imx_epit.o
>  common-obj-$(CONFIG_IMX) += imx_gpt.o
>  common-obj-$(CONFIG_LM32) += lm32_timer.o
>  common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
> +common-obj-$(CONFIG_XLNX_ZYNQMP) += arm_generic_timer.o

If this is really generic I think it ought to have its own
CONFIG_foo rather than using the XLNX_ZYNQMP symbol.

>
>  obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
>  obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o

> +static uint64_t counter_low_value_postr(RegisterInfo *reg, uint64_t val64)
> +{
> +    ARMGenTimer *s = ARM_GEN_TIMER(reg->opaque);
> +    uint64_t current_ticks, total_ticks;
> +    uint32_t low_ticks;
> +
> +    if (s->enabled) {
> +        current_ticks = muldiv64(qemu_clock_get_us(QEMU_CLOCK_VIRTUAL),
> +                                 NANOSECONDS_PER_SECOND, 1000000);
> +        total_ticks = current_ticks - s->tick_offset;
> +        low_ticks = (uint32_t) total_ticks;
> +    } else {
> +        /* Timer is disabled, return the time when it was disabled */
> +        low_ticks = (uint32_t) s->tick_offset;
> +    }
> +
> +    return low_ticks;
> +}
> +
> +static uint64_t counter_high_value_postr(RegisterInfo *reg, uint64_t val64)
> +{
> +    ARMGenTimer *s = ARM_GEN_TIMER(reg->opaque);
> +    uint64_t current_ticks, total_ticks;
> +    uint32_t high_ticks;
> +
> +    if (s->enabled) {
> +        current_ticks = muldiv64(qemu_clock_get_us(QEMU_CLOCK_VIRTUAL),
> +                                 NANOSECONDS_PER_SECOND, 1000000);
> +        total_ticks = current_ticks - s->tick_offset;
> +        high_ticks = (uint32_t) (total_ticks >> 32);
> +    } else {
> +        /* Timer is disabled, return the time when it was disabled */
> +        high_ticks = (uint32_t) (s->tick_offset >> 32);
> +    }
> +
> +    return high_ticks;

These two functions are very similar and would benefit from
being refactored to call a utility function that just returned
the 64-bit count.

thanks
-- PMM
