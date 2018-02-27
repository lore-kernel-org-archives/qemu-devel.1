Received: from eggs.gnu.org ([2001:4830:134:3::10]:60814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqiFH-0008Vx-3U
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:36:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqiFF-0000kI-U6
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:36:51 -0500
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:37181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqiFF-0000k5-OG
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 11:36:49 -0500
Received: by mail-oi0-x244.google.com with SMTP id f186so13312176oig.4
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 08:36:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0f4e15f8aafe82a7b36318c0689f49c974b3402a.1519406423.git.alistair.francis@xilinx.com>
References: <cover.1519406423.git.alistair.francis@xilinx.com>
	<0f4e15f8aafe82a7b36318c0689f49c974b3402a.1519406423.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 16:36:28 +0000
Message-ID: <CAFEAcA_U98jy+v0qKDKvYqh4LidHE-hdzNz=FdGBRKSdeexPoA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 2/3] xlnx-zynqmp-rtc: Add basic time
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistair23@gmail.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 23 February 2018 at 17:21, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Allow the guest to determine the time set from the QEMU command line.
>
> This includes adding a trace event to debug the new time.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>

Thanks for reworking this -- I think it looks simpler this way.

> diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zynqmp-rtc.h
> index 87649836cc..2867563bdd 100644
> --- a/include/hw/timer/xlnx-zynqmp-rtc.h
> +++ b/include/hw/timer/xlnx-zynqmp-rtc.h
> @@ -79,6 +79,9 @@ typedef struct XlnxZynqMPRTC {
>      qemu_irq irq_rtc_int;
>      qemu_irq irq_addr_error_int;
>
> +    struct tm current_tm;
> +    uint32_t tick_offset;
> +

Do we need current_tm to be a struct field now?

> @@ -143,6 +164,10 @@ static void rtc_reset(DeviceState *dev)
>          register_reset(&s->regs_info[i]);
>      }
>
> +    trace_xlnx_zynqmp_rtc_gettime(s->current_tm.tm_year, s->current_tm.tm_mon,
> +                                  s->current_tm.tm_mday, s->current_tm.tm_hour,
> +                                  s->current_tm.tm_min, s->current_tm.tm_sec);
> +

...this trace is in reset, and is the only place we read
current_tm, except for...

>      rtc_int_update_irq(s);
>      addr_error_int_update_irq(s);
>  }
> @@ -178,14 +203,46 @@ static void rtc_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->iomem);
>      sysbus_init_irq(sbd, &s->irq_rtc_int);
>      sysbus_init_irq(sbd, &s->irq_addr_error_int);
> +
> +    qemu_get_timedate(&s->current_tm, 0);
> +    s->tick_offset = mktimegm(&s->current_tm) -
> +        qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;

...this code in init, which could just use a local variable
instead, since the trace in reset isn't really reporting
interesting information any more (the value never changes, so
you could trace it in init instead).

> +}
>

thanks
-- PMM
