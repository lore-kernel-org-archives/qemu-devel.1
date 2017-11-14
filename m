Received: from eggs.gnu.org ([2001:4830:134:3::10]:57192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEW0B-0004Js-SE
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:51:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1eEW07-0002tc-41
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 02:51:23 -0500
References: <cover.1510612380.git.alistair.francis@xilinx.com>
	<a09d5f8c16c55ae51867267607d7b657e279d1cb.1510612380.git.alistair.francis@xilinx.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <107707f0-68a6-df4a-cc15-79473cf3a841@redhat.com>
Date: Tue, 14 Nov 2017 08:51:13 +0100
MIME-Version: 1.0
In-Reply-To: <a09d5f8c16c55ae51867267607d7b657e279d1cb.1510612380.git.alistair.francis@xilinx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 26/29] hw/timer: Replace fprintf(stderr,
 "*\n" with error_report()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: alistair23@gmail.com, armbru@redhat.com

On 13.11.2017 23:36, Alistair Francis wrote:
> Replace a large number of the fprintf(stderr, "*\n" calls with
> error_report(). The functions were renamed with these commands and then
> compiler issues where manually fixed.
[...]
> diff --git a/hw/timer/omap_gptimer.c b/hw/timer/omap_gptimer.c
> index ae2dc99832..0f064241d3 100644
> --- a/hw/timer/omap_gptimer.c
> +++ b/hw/timer/omap_gptimer.c
> @@ -18,6 +18,7 @@
>   * with this program; if not, see <http://www.gnu.org/licenses/>.
>   */
>  #include "qemu/osdep.h"
> +#include "qemu/error-report.h"
>  #include "hw/hw.h"
>  #include "qemu/timer.h"
>  #include "hw/arm/omap.h"
> @@ -356,7 +357,7 @@ static void omap_gp_timer_write(void *opaque, hwaddr addr,
>      case 0x10:	/* TIOCP_CFG */
>          s->config = value & 0x33d;
>          if (((value >> 3) & 3) == 3)				/* IDLEMODE */
> -            fprintf(stderr, "%s: illegal IDLEMODE value in TIOCP_CFG\n",
> +            error_report("%s: illegal IDLEMODE value in TIOCP_CFG",
>                              __func__);

Wrong indentation.

>          if (value & 2)						/* SOFTRESET */
>              omap_gp_timer_reset(s);
> @@ -394,11 +395,11 @@ static void omap_gp_timer_write(void *opaque, hwaddr addr,
>          s->ar = (value >> 1) & 1;
>          s->st = (value >> 0) & 1;
>          if (s->inout && s->trigger != gpt_trigger_none)
> -            fprintf(stderr, "%s: GP timer pin must be an output "
> -                            "for this trigger mode\n", __func__);
> +            error_report("%s: GP timer pin must be an output "
> +                         "for this trigger mode", __func__);
>          if (!s->inout && s->capture != gpt_capture_none)
> -            fprintf(stderr, "%s: GP timer pin must be an input "
> -                            "for this capture mode\n", __func__);
> +            error_report("%s: GP timer pin must be an input "
> +                         "for this capture mode", __func__);
>          if (s->trigger == gpt_trigger_none)
>              omap_gp_timer_out(s, s->scpwm);
>          /* TODO: make sure this doesn't overflow 32-bits */
> diff --git a/hw/timer/twl92230.c b/hw/timer/twl92230.c
> index ef116c636c..18880884c6 100644
> --- a/hw/timer/twl92230.c
> +++ b/hw/timer/twl92230.c
> @@ -614,7 +614,7 @@ static void menelaus_write(void *opaque, uint8_t addr, uint8_t value)
>              break;
>          rtc_badness:
>          default:
> -            fprintf(stderr, "%s: bad RTC_UPDATE value %02x\n",
> +            error_report("%s: bad RTC_UPDATE value %02x",
>                              __func__, value);

Wrong indentation.

>              s->status |= 1 << 10;				/* RTCERR */
>              menelaus_update(s);
> diff --git a/hw/timer/xilinx_timer.c b/hw/timer/xilinx_timer.c
> index 59439c05be..a80bba846b 100644
> --- a/hw/timer/xilinx_timer.c
> +++ b/hw/timer/xilinx_timer.c
> @@ -127,7 +127,7 @@ timer_read(void *opaque, hwaddr addr, unsigned int size)
>              break;
>  
>      }
> -    D(fprintf(stderr, "%s timer=%d %x=%x\n", __func__, timer, addr * 4, r));
> +    D(error_report("%s timer=%d %x=%x", __func__, timer, addr * 4, r));
>      return r;
>  }
>  
> @@ -135,7 +135,7 @@ static void timer_enable(struct xlx_timer *xt)
>  {
>      uint64_t count;
>  
> -    D(fprintf(stderr, "%s timer=%d down=%d\n", __func__,
> +    D(error_report("%s timer=%d down=%d", __func__,
>                xt->nr, xt->regs[R_TCSR] & TCSR_UDT));

Wrong indentation.

>      ptimer_stop(xt->ptimer);
> @@ -160,7 +160,7 @@ timer_write(void *opaque, hwaddr addr,
>      addr >>= 2;
>      timer = timer_from_addr(addr);
>      xt = &t->timers[timer];
> -    D(fprintf(stderr, "%s addr=%x val=%x (timer=%d off=%d)\n",
> +    D(error_report("%s addr=%x val=%x (timer=%d off=%d)",
>               __func__, addr * 4, value, timer, addr & 3));
>      /* Further decoding to address a specific timers reg.  */
>      addr &= 3;
> @@ -197,7 +197,7 @@ static void timer_hit(void *opaque)
>  {
>      struct xlx_timer *xt = opaque;
>      struct timerblock *t = xt->parent;
> -    D(fprintf(stderr, "%s %d\n", __func__, xt->nr));
> +    D(error_report("%s %d", __func__, xt->nr));
>      xt->regs[R_TCSR] |= TCSR_TINT;
>  
>      if (xt->regs[R_TCSR] & TCSR_ARHT)
> 

That whole D(...) stuff is kind of ugly (the code is bit-rotting there)
and we should maybe rather replace that with a proper debug error
printing macro?

 Thomas
