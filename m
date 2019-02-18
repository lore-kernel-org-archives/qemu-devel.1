Received: from eggs.gnu.org ([209.51.188.92]:58706)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvrBF-0005eE-Fr
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 17:14:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gvqwE-0004oG-9z
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:58:59 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:35236)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gvqwC-0004bS-7m
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 16:58:58 -0500
Received: by mail-wr1-f66.google.com with SMTP id t18so20059802wrx.2
	for <qemu-devel@nongnu.org>; Mon, 18 Feb 2019 13:58:46 -0800 (PST)
References: <20190214125107.22178-1-peter.maydell@linaro.org>
	<20190214125107.22178-5-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e0cac3ef-d2b9-5b2c-cb24-599a63695663@redhat.com>
Date: Mon, 18 Feb 2019 22:58:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190214125107.22178-5-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 04/14] hw/timer/pl031: Convert to using
 trace events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 2/14/19 1:50 PM, Peter Maydell wrote:
> Convert the debug printing in the PL031 device to use trace events,
> and augment it to cover the interesting parts of device operation.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/timer/pl031.c      | 55 +++++++++++++++++++++++--------------------
>  hw/timer/trace-events |  6 +++++
>  2 files changed, 36 insertions(+), 25 deletions(-)
> 
> diff --git a/hw/timer/pl031.c b/hw/timer/pl031.c
> index f774dcd5223..274ad47a33a 100644
> --- a/hw/timer/pl031.c
> +++ b/hw/timer/pl031.c
> @@ -18,15 +18,7 @@
>  #include "sysemu/sysemu.h"
>  #include "qemu/cutils.h"
>  #include "qemu/log.h"
> -
> -//#define DEBUG_PL031
> -
> -#ifdef DEBUG_PL031
> -#define DPRINTF(fmt, ...) \
> -do { printf("pl031: " fmt , ## __VA_ARGS__); } while (0)
> -#else
> -#define DPRINTF(fmt, ...) do {} while(0)
> -#endif
> +#include "trace.h"
>  
>  #define RTC_DR      0x00    /* Data read register */
>  #define RTC_MR      0x04    /* Match register */
> @@ -44,7 +36,10 @@ static const unsigned char pl031_id[] = {
>  
>  static void pl031_update(PL031State *s)
>  {
> -    qemu_set_irq(s->irq, s->is & s->im);
> +    uint32_t flags = s->is & s->im;
> +
> +    trace_pl031_irq_state(flags);
> +    qemu_set_irq(s->irq, flags);
>  }
>  
>  static void pl031_interrupt(void * opaque)
> @@ -52,7 +47,7 @@ static void pl031_interrupt(void * opaque)
>      PL031State *s = (PL031State *)opaque;
>  
>      s->is = 1;
> -    DPRINTF("Alarm raised\n");
> +    trace_pl031_alarm_raised();
>      pl031_update(s);
>  }
>  
> @@ -69,7 +64,7 @@ static void pl031_set_alarm(PL031State *s)
>      /* The timer wraps around.  This subtraction also wraps in the same way,
>         and gives correct results when alarm < now_ticks.  */
>      ticks = s->mr - pl031_get_count(s);
> -    DPRINTF("Alarm set in %ud ticks\n", ticks);
> +    trace_pl031_set_alarm(ticks);
>      if (ticks == 0) {
>          timer_del(s->timer);
>          pl031_interrupt(s);
> @@ -83,38 +78,49 @@ static uint64_t pl031_read(void *opaque, hwaddr offset,
>                             unsigned size)
>  {
>      PL031State *s = (PL031State *)opaque;
> -
> -    if (offset >= 0xfe0  &&  offset < 0x1000)
> -        return pl031_id[(offset - 0xfe0) >> 2];
> +    uint64_t r;
>  
>      switch (offset) {
>      case RTC_DR:
> -        return pl031_get_count(s);
> +        r = pl031_get_count(s);
> +        break;
>      case RTC_MR:
> -        return s->mr;
> +        r = s->mr;
> +        break;
>      case RTC_IMSC:
> -        return s->im;
> +        r = s->im;
> +        break;
>      case RTC_RIS:
> -        return s->is;
> +        r = s->is;
> +        break;
>      case RTC_LR:
> -        return s->lr;
> +        r = s->lr;
> +        break;
>      case RTC_CR:
>          /* RTC is permanently enabled.  */
> -        return 1;
> +        r = 1;
> +        break;
>      case RTC_MIS:
> -        return s->is & s->im;
> +        r = s->is & s->im;
> +        break;
> +    case 0xfe0 ... 0xfff:
> +        r = pl031_id[(offset - 0xfe0) >> 2];

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> +        break;
>      case RTC_ICR:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "pl031: read of write-only register at offset 0x%x\n",
>                        (int)offset);
> +        r = 0;
>          break;
>      default:
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "pl031_read: Bad offset 0x%x\n", (int)offset);
> +        r = 0;
>          break;
>      }
>  
> -    return 0;
> +    trace_pl031_read(offset, r);
> +    return r;
>  }
>  
>  static void pl031_write(void * opaque, hwaddr offset,
> @@ -122,6 +128,7 @@ static void pl031_write(void * opaque, hwaddr offset,
>  {
>      PL031State *s = (PL031State *)opaque;
>  
> +    trace_pl031_write(offset, value);
>  
>      switch (offset) {
>      case RTC_LR:
> @@ -134,7 +141,6 @@ static void pl031_write(void * opaque, hwaddr offset,
>          break;
>      case RTC_IMSC:
>          s->im = value & 1;
> -        DPRINTF("Interrupt mask %d\n", s->im);
>          pl031_update(s);
>          break;
>      case RTC_ICR:
> @@ -142,7 +148,6 @@ static void pl031_write(void * opaque, hwaddr offset,
>             cleared when bit 0 of the written value is set.  However the
>             arm926e documentation (DDI0287B) states that the interrupt is
>             cleared when any value is written.  */
> -        DPRINTF("Interrupt cleared");
>          s->is = 0;
>          pl031_update(s);
>          break;
> diff --git a/hw/timer/trace-events b/hw/timer/trace-events
> index 0144a68951c..12eb505fee7 100644
> --- a/hw/timer/trace-events
> +++ b/hw/timer/trace-events
> @@ -77,3 +77,9 @@ xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min, int sec
>  nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write addr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
>  
> +# hw/timer/pl031.c
> +pl031_irq_state(int level) "irq state %d"
> +pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
> +pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
> +pl031_alarm_raised(void) "alarm raised"
> +pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
> 
