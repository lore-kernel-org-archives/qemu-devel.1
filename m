Received: from eggs.gnu.org ([2001:4830:134:3::10]:53346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPTD8-0000zH-Ks
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:01:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPTD7-00036o-KC
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:01:30 -0500
Received: from mail-ua0-x22a.google.com ([2607:f8b0:400c:c08::22a]:34925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPTD7-00036c-Hb
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 07:01:29 -0500
Received: by mail-ua0-x22a.google.com with SMTP id y9so73847707uae.2
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 04:01:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b9c61e0c893b6215531ea210e566c9057d28c792.1482265908.git.alistair.francis@xilinx.com>
References: <cover.1482265908.git.alistair.francis@xilinx.com>
	<b9c61e0c893b6215531ea210e566c9057d28c792.1482265908.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 12:01:08 +0000
Message-ID: <CAFEAcA-p0MYiiDO-h88fKkueNDzx28wH2Ef6bPFV+MZ65GH_bg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v3 2/3] arm_generic_timer: Add support for
 the ReadBase memory map
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

On 20 December 2016 at 22:42, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Add support for the read only regions in the ReadBase memory map.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>
>  hw/timer/arm_generic_timer.c         | 27 +++++++++++++++++++++++++++
>  include/hw/timer/arm_generic_timer.h | 12 ++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/hw/timer/arm_generic_timer.c b/hw/timer/arm_generic_timer.c
> index da434a7..5392657 100644
> --- a/hw/timer/arm_generic_timer.c
> +++ b/hw/timer/arm_generic_timer.c
> @@ -100,6 +100,17 @@ static RegisterAccessInfo arm_gen_timer_regs_info[] = {
>      /* We don't model the CounterID registers either */
>  };
>
> +static RegisterAccessInfo arm_gen_timer_read_regs_info[] = {
> +    {   .name = "CNTCV_READ_LOWER",
> +        .addr = A_CNTCV_READ_LOWER, .ro = 0xFFFF,
> +        .post_read = counter_low_value_postr,
> +    },{ .name = "CNTCV_READ_UPPER",
> +        .addr = A_CNTCV_READ_UPPER, .ro = 0xFFFF,
> +        .post_read = counter_high_value_postr,
> +    }

Needs to support 64-bit reads too.

> +    /* We don't model the CounterID registers */

(same query about ID regs as in patch 1)

> +};
> +
>  static void arm_gen_timer_reset(DeviceState *dev)
>  {
>      ARMGenTimer *s = ARM_GEN_TIMER(dev);
> @@ -166,6 +177,7 @@ static void arm_gen_timer_init(Object *obj)
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>      RegisterInfoArray *reg_array;
>
> +    /* Create the ControlBase memory region */
>      memory_region_init_io(&s->iomem, obj, &arm_gen_timer_ops, s,
>                            TYPE_ARM_GEN_TIMER, R_ARM_GEN_TIMER_MAX * 4);
>      reg_array =
> @@ -179,6 +191,21 @@ static void arm_gen_timer_init(Object *obj)
>                                  A_CNTCR,
>                                  &reg_array->mem);
>      sysbus_init_mmio(sbd, &s->iomem);
> +
> +    /* Create the ReadBase memory region */
> +    memory_region_init_io(&s->iomem_read, obj, &arm_gen_timer_ops, s,
> +                          TYPE_ARM_GEN_TIMER "-read", R_ARM_GEN_TIMER_READ_MAX * 4);

checkpatch.pl complains that this line needs wrapping.

> +    reg_array =
> +        register_init_block32(DEVICE(obj), arm_gen_timer_read_regs_info,
> +                              ARRAY_SIZE(arm_gen_timer_read_regs_info),
> +                              s->regs_read_info, s->regs_read,
> +                              &arm_gen_timer_ops,
> +                              ARM_GEN_TIMER_ERR_DEBUG,
> +                              R_ARM_GEN_TIMER_READ_MAX * 4);
> +    memory_region_add_subregion(&s->iomem_read,
> +                                R_CNTCV_READ_LOWER,
> +                                &reg_array->mem);
> +    sysbus_init_mmio(sbd, &s->iomem_read);
>  }

Otherwise this looks good.

thanks
-- PMM
