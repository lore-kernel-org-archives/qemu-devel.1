Received: from eggs.gnu.org ([2001:4830:134:3::10]:49184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb4vQ-000303-KN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:35:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb4vP-0006Io-JH
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:35:44 -0500
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb4vP-0006Id-Dx
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 08:35:43 -0500
Received: by mail-oi0-x241.google.com with SMTP id y141so8290057oia.0
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 05:35:43 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9443d0cbb39ca4173d40b4116655c0309cc05983.1515796549.git.alistair.francis@xilinx.com>
References: <cover.1515796549.git.alistair.francis@xilinx.com>
	<9443d0cbb39ca4173d40b4116655c0309cc05983.1515796549.git.alistair.francis@xilinx.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 13:35:22 +0000
Message-ID: <CAFEAcA-4vkZEJDaNfPLavKK3=_JBfi9u1o=-0kGb0ui26SV3VA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 2/3] xlnx-zynqmp-rtc: Add basic time
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

On 12 January 2018 at 22:37, Alistair Francis
<alistair.francis@xilinx.com> wrote:
> Allow the guest to determine the time set from the QEMU command line.
>
> This includes adding a trace event to debug the new time.
>
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
>  - Convert DB_PRINT() macro to trace
>
>  hw/timer/trace-events              |  3 +++
>  hw/timer/xlnx-zynqmp-rtc.c         | 23 +++++++++++++++++++++++
>  include/hw/timer/xlnx-zynqmp-rtc.h |  3 +++
>  3 files changed, 29 insertions(+)
>
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 640722b5d1..e6e042fddb 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -60,3 +60,6 @@ systick_write(uint64_t addr, uint32_t value, unsigned size) "systick write addr
>  cmsdk_apb_timer_read(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer read: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_timer_write(uint64_t offset, uint64_t data, unsigned size) "CMSDK APB timer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size %u"
>  cmsdk_apb_timer_reset(void) "CMSDK APB timer: reset"
> +
> +# hw/timer/xlnx-zynqmp-rtc.c
> +xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
> diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
> index ead40fc42d..4adcc4701a 100644
> --- a/hw/timer/xlnx-zynqmp-rtc.c
> +++ b/hw/timer/xlnx-zynqmp-rtc.c
> @@ -29,6 +29,7 @@
>  #include "hw/register.h"
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
> +#include "hw/ptimer.h"
>  #include "hw/timer/xlnx-zynqmp-rtc.h"
>
>  #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
> @@ -47,6 +48,13 @@ static void addr_error_int_update_irq(XlnxZynqMPRTC *s)
>      qemu_set_irq(s->irq_addr_error_int, pending);
>  }
>
> +static uint64_t current_time_postr(RegisterInfo *reg, uint64_t val64)
> +{
> +    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
> +
> +    return mktime(&s->current_tm);

No other timer device calls mktime(), so I suspect this is the wrong
approach. (You may want something involving the QEMU mktimegm() utility
function.)

Also, looking at mc146818rtc.c it has logic for tracking what the
guest thinks the RTC is, which might be at an offset from what the
host's idea of the RTC is. I don't see anything like that here, which
makes me think this patch is missing something.

> +}
> +
>  static void rtc_int_status_postw(RegisterInfo *reg, uint64_t val64)
>  {
>      XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
> @@ -103,11 +111,13 @@ static const RegisterAccessInfo rtc_regs_info[] = {
>      {   .name = "SET_TIME_WRITE",  .addr = A_SET_TIME_WRITE,
>      },{ .name = "SET_TIME_READ",  .addr = A_SET_TIME_READ,
>          .ro = 0xffffffff,
> +        .post_read = current_time_postr,
>      },{ .name = "CALIB_WRITE",  .addr = A_CALIB_WRITE,
>      },{ .name = "CALIB_READ",  .addr = A_CALIB_READ,
>          .ro = 0x1fffff,
>      },{ .name = "CURRENT_TIME",  .addr = A_CURRENT_TIME,
>          .ro = 0xffffffff,
> +        .post_read = current_time_postr,
>      },{ .name = "CURRENT_TICK",  .addr = A_CURRENT_TICK,
>          .ro = 0xffff,
>      },{ .name = "ALARM",  .addr = A_ALARM,
> @@ -147,6 +157,12 @@ static void rtc_reset(DeviceState *dev)
>          register_reset(&s->regs_info[i]);
>      }
>
> +    qemu_get_timedate(&s->current_tm, 0);
> +
> +    trace_xlnx_zynqmp_rtc_gettime(s->current_tm.tm_year, s->current_tm.tm_mon,
> +                                  s->current_tm.tm_mday, s->current_tm.tm_hour,
> +                                  s->current_tm.tm_min, s->current_tm.tm_sec);
> +
>      rtc_int_update_irq(s);
>      addr_error_int_update_irq(s);
>  }
> @@ -190,6 +206,13 @@ static const VMStateDescription vmstate_rtc = {
>      .minimum_version_id = 1,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPRTC, XLNX_ZYNQMP_RTC_R_MAX),
> +        VMSTATE_INT32(current_tm.tm_sec, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_min, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_hour, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_wday, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_mday, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_mon, XlnxZynqMPRTC),
> +        VMSTATE_INT32(current_tm.tm_year, XlnxZynqMPRTC),

Presumably the timer device has an internal representation of the
current time (in registers or something). I think it would make more
sense to have the migration state representation be whatever the
hardware does. (Compare eg mc146818rtc.c where we interpret a
struct tm into the various cmos_data[] fields, and then migration
works with those.)

>          VMSTATE_END_OF_LIST(),
>      }
>  };
> diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zynqmp-rtc.h
> index 87649836cc..daecb646f0 100644
> --- a/include/hw/timer/xlnx-zynqmp-rtc.h
> +++ b/include/hw/timer/xlnx-zynqmp-rtc.h
> @@ -25,6 +25,7 @@
>   */
>
>  #include "hw/register.h"
> +#include "trace.h"

I think this include should be in the .c file.

>
>  #define TYPE_XLNX_ZYNQMP_RTC "xlnx-zynmp.rtc"
>
> @@ -79,6 +80,8 @@ typedef struct XlnxZynqMPRTC {
>      qemu_irq irq_rtc_int;
>      qemu_irq irq_addr_error_int;
>
> +    struct tm current_tm;
> +
>      uint32_t regs[XLNX_ZYNQMP_RTC_R_MAX];
>      RegisterInfo regs_info[XLNX_ZYNQMP_RTC_R_MAX];
>  } XlnxZynqMPRTC;
> --
> 2.14.1

thanks
-- PMM
