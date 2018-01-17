Received: from eggs.gnu.org ([2001:4830:134:3::10]:46596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebud1-0005uW-RS
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:48:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebucz-0003EM-3f
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:48:11 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:40459)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ebucy-0003Db-Ux
	for qemu-devel@nongnu.org; Wed, 17 Jan 2018 15:48:09 -0500
Received: by mail-qt0-x243.google.com with SMTP id s39so7854163qth.7
	for <qemu-devel@nongnu.org>; Wed, 17 Jan 2018 12:48:08 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <cover.1516209965.git.alistair.francis@xilinx.com>
	<2ff1ab5fb9719ac578873bd9edbcb2f3b9a9c3cc.1516209965.git.alistair.francis@xilinx.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <364f2afa-8f22-13ce-50a5-d81fe5b3916b@amsat.org>
Date: Wed, 17 Jan 2018 17:48:04 -0300
MIME-Version: 1.0
In-Reply-To: <2ff1ab5fb9719ac578873bd9edbcb2f3b9a9c3cc.1516209965.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 2/3] xlnx-zynqmp-rtc: Add basic time
 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, alistair23@gmail.com, edgar.iglesias@xilinx.com, edgar.iglesias@gmail.com

On 01/17/2018 02:27 PM, Alistair Francis wrote:
> Allow the guest to determine the time set from the QEMU command line.
> 
> This includes adding a trace event to debug the new time.
> 
> The migration logic was copied from the PL031 migration logic.
> 
> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> ---
> V3:
>  - Store an offset value
>  - Use mktimegm()
>  - Log unimplemented writes
> V2:
>  - Convert DB_PRINT() macro to trace
> 
>  hw/timer/trace-events              |  3 ++
>  hw/timer/xlnx-zynqmp-rtc.c         | 64 ++++++++++++++++++++++++++++++++++++++
>  include/hw/timer/xlnx-zynqmp-rtc.h |  4 +++
>  3 files changed, 71 insertions(+)
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
> index ead40fc42d..76c1af1afe 100644
> --- a/hw/timer/xlnx-zynqmp-rtc.c
> +++ b/hw/timer/xlnx-zynqmp-rtc.c
> @@ -29,6 +29,10 @@
>  #include "hw/register.h"
>  #include "qemu/bitops.h"
>  #include "qemu/log.h"
> +#include "hw/ptimer.h"
> +#include "qemu/cutils.h"
> +#include "sysemu/sysemu.h"
> +#include "trace.h"
>  #include "hw/timer/xlnx-zynqmp-rtc.h"
> 
>  #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
> @@ -47,6 +51,19 @@ static void addr_error_int_update_irq(XlnxZynqMPRTC *s)
>      qemu_set_irq(s->irq_addr_error_int, pending);
>  }
> 
> +static uint32_t rtc_get_count(XlnxZynqMPRTC *s)
> +{
> +    int64_t now = qemu_clock_get_ns(rtc_clock);
> +    return s->tick_offset + now / NANOSECONDS_PER_SECOND;
> +}
> +
> +static uint64_t current_time_postr(RegisterInfo *reg, uint64_t val64)
> +{
> +    XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
> +
> +    return rtc_get_count(s);
> +}
> +
>  static void rtc_int_status_postw(RegisterInfo *reg, uint64_t val64)
>  {
>      XlnxZynqMPRTC *s = XLNX_ZYNQMP_RTC(reg->opaque);
> @@ -99,15 +116,25 @@ static uint64_t addr_error_int_dis_prew(RegisterInfo *reg, uint64_t val64)
>      return 0;
>  }
> 
> +static void unimp_postw(RegisterInfo *reg, uint64_t val64)
> +{
> +    qemu_log_mask(LOG_UNIMP, "The time setting functionality is not "
> +                  "implemented\n");
> +}
> +
>  static const RegisterAccessInfo rtc_regs_info[] = {
>      {   .name = "SET_TIME_WRITE",  .addr = A_SET_TIME_WRITE,
> +        .post_write = unimp_postw,

Why bother adding this function? Rather use ".unimp = ~0" which log
register name accessed.

>      },{ .name = "SET_TIME_READ",  .addr = A_SET_TIME_READ,
>          .ro = 0xffffffff,
> +        .post_read = current_time_postr,
>      },{ .name = "CALIB_WRITE",  .addr = A_CALIB_WRITE,
> +        .post_write = unimp_postw,

Ditto.

>      },{ .name = "CALIB_READ",  .addr = A_CALIB_READ,
>          .ro = 0x1fffff,
>      },{ .name = "CURRENT_TIME",  .addr = A_CURRENT_TIME,
>          .ro = 0xffffffff,
> +        .post_read = current_time_postr,
>      },{ .name = "CURRENT_TICK",  .addr = A_CURRENT_TICK,
>          .ro = 0xffff,
>      },{ .name = "ALARM",  .addr = A_ALARM,
> @@ -147,6 +174,10 @@ static void rtc_reset(DeviceState *dev)
>          register_reset(&s->regs_info[i]);
>      }
> 
> +    trace_xlnx_zynqmp_rtc_gettime(s->current_tm.tm_year, s->current_tm.tm_mon,
> +                                  s->current_tm.tm_mday, s->current_tm.tm_hour,
> +                                  s->current_tm.tm_min, s->current_tm.tm_sec);
> +
>      rtc_int_update_irq(s);
>      addr_error_int_update_irq(s);
>  }
> @@ -182,14 +213,47 @@ static void rtc_init(Object *obj)
>      sysbus_init_mmio(sbd, &s->iomem);
>      sysbus_init_irq(sbd, &s->irq_rtc_int);
>      sysbus_init_irq(sbd, &s->irq_addr_error_int);
> +
> +    qemu_get_timedate(&s->current_tm, 0);
> +    s->tick_offset = mktimegm(&s->current_tm) -
> +        qemu_clock_get_ns(rtc_clock) / NANOSECONDS_PER_SECOND;
> +}
> +
> +static int rtc_pre_save(void *opaque)
> +{
> +    XlnxZynqMPRTC *s = opaque;
> +
> +    /* tick_offset is base_time - rtc_clock base time.  Instead, we want to
> +     * store the base time relative to the QEMU_CLOCK_VIRTUAL for
> +     * backwards-compatibility.
> +     */
> +    int64_t delta = qemu_clock_get_ns(rtc_clock) -
> +                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    s->tick_offset_vmstate = s->tick_offset + delta / NANOSECONDS_PER_SECOND;
> +
> +    return 0;
> +}
> +
> +static int rtc_post_load(void *opaque, int version_id)
> +{
> +    XlnxZynqMPRTC *s = opaque;
> +
> +    int64_t delta = qemu_clock_get_ns(rtc_clock) -
> +                        qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +    s->tick_offset = s->tick_offset_vmstate - delta / NANOSECONDS_PER_SECOND;
> +
> +    return 0;
>  }
> 
>  static const VMStateDescription vmstate_rtc = {
>      .name = TYPE_XLNX_ZYNQMP_RTC,
>      .version_id = 1,
>      .minimum_version_id = 1,
> +    .pre_save = rtc_pre_save,
> +    .post_load = rtc_post_load,
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32_ARRAY(regs, XlnxZynqMPRTC, XLNX_ZYNQMP_RTC_R_MAX),
> +        VMSTATE_UINT32(tick_offset_vmstate, XlnxZynqMPRTC),
>          VMSTATE_END_OF_LIST(),
>      }
>  };
> diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/timer/xlnx-zynqmp-rtc.h
> index 87649836cc..b0f54e00c1 100644
> --- a/include/hw/timer/xlnx-zynqmp-rtc.h
> +++ b/include/hw/timer/xlnx-zynqmp-rtc.h
> @@ -79,6 +79,10 @@ typedef struct XlnxZynqMPRTC {
>      qemu_irq irq_rtc_int;
>      qemu_irq irq_addr_error_int;
> 
> +    struct tm current_tm;
> +    uint32_t tick_offset_vmstate;
> +    uint32_t tick_offset;
> +
>      uint32_t regs[XLNX_ZYNQMP_RTC_R_MAX];
>      RegisterInfo regs_info[XLNX_ZYNQMP_RTC_R_MAX];
>  } XlnxZynqMPRTC;
> --
> 2.14.1

removing unimp_postw():
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
