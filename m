Received: from eggs.gnu.org ([2001:4830:134:3::10]:51392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZhfi-0006TE-Aq
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:33:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZhfe-00036W-2v
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:33:50 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:44576)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZhfd-000363-UQ
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 13:33:46 -0500
Received: by mail-qk0-x244.google.com with SMTP id u76so5479518qku.11
	for <qemu-devel@nongnu.org>; Thu, 11 Jan 2018 10:33:45 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <b799d9d21170a492c54fb2c4eaf8326b06e0bdf6.1515523657.git.alistair.francis@xilinx.com>
	<ed917e0eb352563c4598e367d363fc90e9bc020a.1515523657.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9e747c53-bd60-9ec8-4df4-7fd43fbd3dc4@amsat.org>
Date: Thu, 11 Jan 2018 15:33:40 -0300
MIME-Version: 1.0
In-Reply-To: <ed917e0eb352563c4598e367d363fc90e9bc020a.1515523657.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 2/3] xlnx-zynqmp-rtc: Add basic time
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: edgar.iglesias@xilinx.com, alistair23@gmail.com, edgar.iglesias@gmail.com

On 01/09/2018 03:50 PM, Alistair Francis wrote:
> Allow the guest to determine the time set from the QEMU command line.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> 
>  hw/timer/xlnx-zynqmp-rtc.c         | 24 ++++++++++++++++++++++++
>  include/hw/timer/xlnx-zynqmp-rtc.h |  2 ++
>  2 files changed, 26 insertions(+)
> 
> diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/timer/xlnx-zynqmp-rtc.c
> index 40533220fc..eed17805ac 100644
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
> @@ -55,6 +56,13 @@ static void addr_error_int_update_irq(XlnxZynqMPRTC *s)
>      qemu_set_irq(s->irq_addr_error_int, pending);
>  }
>  
> +static uint64_t current_time_postr(RegisterInfo *reg, uint64_t val64)
> +{
> +    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
> +
> +    return mktime(&s->current_tm);
> +}
> +
>  static void rtc_int_status_postw(RegisterInfo *reg, uint64_t val64)
>  {
>      XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
> @@ -111,11 +119,13 @@ static const RegisterAccessInfo rtc_regs_info[] = {
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
> @@ -155,6 +165,13 @@ static void rtc_reset(DeviceState *dev)
>          register_reset(&s->regs_info[i]);
>      }
>  
> +    qemu_get_timedate(&s->current_tm, 0);
> +
> +    DB_PRINT("Get time from host: %d-%d-%d %2d:%02d:%02d\n",
> +             s->current_tm.tm_year, s->current_tm.tm_mon,
> +             s->current_tm.tm_mday, s->current_tm.tm_hour,
> +             s->current_tm.tm_min, s->current_tm.tm_sec);

Oh DB_PRINT() used. Can you use a trace event instead?

> +
>      rtc_int_update_irq(s);
>      addr_error_int_update_irq(s);
>  }
> @@ -203,6 +220,13 @@ static const VMStateDescription vmstate_rtc = {
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

Worth adding a VMSTATE_STRUCT_TM() in migration/vmstate.h?

>          VMSTATE_END_OF_LIST(),
>      }
>  };
> diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zynqmp-rtc.h
> index 87649836cc..51a49094ad 100644
> --- a/include/hw/timer/xlnx-zynqmp-rtc.h
> +++ b/include/hw/timer/xlnx-zynqmp-rtc.h
> @@ -79,6 +79,8 @@ typedef struct XlnxZynqMPRTC {
>      qemu_irq irq_rtc_int;
>      qemu_irq irq_addr_error_int;
>  
> +    struct tm current_tm;
> +
>      uint32_t regs[XLNX_ZYNQMP_RTC_R_MAX];
>      RegisterInfo regs_info[XLNX_ZYNQMP_RTC_R_MAX];
>  } XlnxZynqMPRTC;
> 
