Received: from eggs.gnu.org ([2001:4830:134:3::10]:53598)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dcRUe-0003Y6-2w
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:21:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1dcRUa-0000QP-Qt
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:21:28 -0400
Received: from 10.mo178.mail-out.ovh.net ([46.105.76.150]:34598)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1dcRUa-0000Mx-Gd
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 03:21:24 -0400
Received: from player715.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id CD2E84B060
	for <qemu-devel@nongnu.org>; Tue,  1 Aug 2017 09:21:14 +0200 (CEST)
References: <20170801010425.25778-1-andrew@aj.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <855a154a-4cdf-b29a-6440-5deadbeed12e@kaod.org>
Date: Tue, 1 Aug 2017 09:21:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170801010425.25778-1-andrew@aj.id.au>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] watchdog: wdt_aspeed: Add support for the
 reset width register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jeffery <andrew@aj.id.au>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, joel@jms.id.au, openbmc@lists.ozlabs.org

On 08/01/2017 03:04 AM, Andrew Jeffery wrote:
> The reset width register controls how the pulse on the SoC's WDTRST{1,2}
> pins behaves. A pulse is emitted if the external reset bit is set in
> WDT_CTRL. WDT_RESET_WIDTH requires magic bit patterns to configure both
> push-pull/open-drain and active-high/active-low behaviours and thus
> needs some special handling in the write path.
> 
> Signed-off-by: Andrew Jeffery <andrew@aj.id.au>
> ---
> I understand that we're in stabilisation mode, but I thought I'd send this out
> to provoke any feedback. Happy to resend after the 2.10 release if required.
> 
>  hw/watchdog/wdt_aspeed.c | 47 +++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 37 insertions(+), 10 deletions(-)
> 
> diff --git a/hw/watchdog/wdt_aspeed.c b/hw/watchdog/wdt_aspeed.c
> index 8bbe579b6b66..4ef1412e99fc 100644
> --- a/hw/watchdog/wdt_aspeed.c
> +++ b/hw/watchdog/wdt_aspeed.c
> @@ -14,10 +14,10 @@
>  #include "qemu/timer.h"
>  #include "hw/watchdog/wdt_aspeed.h"
>  
> -#define WDT_STATUS              (0x00 / 4)
> -#define WDT_RELOAD_VALUE        (0x04 / 4)
> -#define WDT_RESTART             (0x08 / 4)
> -#define WDT_CTRL                (0x0C / 4)
> +#define WDT_STATUS                      (0x00 / 4)
> +#define WDT_RELOAD_VALUE                (0x04 / 4)
> +#define WDT_RESTART                     (0x08 / 4)
> +#define WDT_CTRL                        (0x0C / 4)
>  #define   WDT_CTRL_RESET_MODE_SOC       (0x00 << 5)
>  #define   WDT_CTRL_RESET_MODE_FULL_CHIP (0x01 << 5)
>  #define   WDT_CTRL_1MHZ_CLK             BIT(4)
> @@ -25,12 +25,21 @@
>  #define   WDT_CTRL_WDT_INTR             BIT(2)
>  #define   WDT_CTRL_RESET_SYSTEM         BIT(1)
>  #define   WDT_CTRL_ENABLE               BIT(0)
> +#define WDT_RESET_WIDTH                 (0x18 / 4)
> +#define   WDT_RESET_WIDTH_ACTIVE_HIGH   BIT(31)
> +#define     WDT_POLARITY_MASK           (0xFF << 24)
> +#define     WDT_ACTIVE_HIGH_MAGIC       (0xA5 << 24)
> +#define     WDT_ACTIVE_LOW_MAGIC        (0x5A << 24)
> +#define   WDT_RESET_WIDTH_PUSH_PULL     BIT(30)
> +#define     WDT_DRIVE_TYPE_MASK         (0xFF << 24)
> +#define     WDT_PUSH_PULL_MAGIC         (0xA8 << 24)
> +#define     WDT_OPEN_DRAIN_MAGIC        (0x8A << 24)
> +#define   WDT_RESET_WIDTH_DURATION      0xFFF;

I would call this define WDT_RESET_WIDTH_DEFAULT (0xFF) and 
use it also in the aspeed_wdt_reset()

I have checked the specs and the bits definitions are correct.
What else could we model ? Would the pulse be interesting ? 

C.


>  
> -#define WDT_TIMEOUT_STATUS      (0x10 / 4)
> -#define WDT_TIMEOUT_CLEAR       (0x14 / 4)
> -#define WDT_RESET_WDITH         (0x18 / 4)
> +#define WDT_TIMEOUT_STATUS              (0x10 / 4)
> +#define WDT_TIMEOUT_CLEAR               (0x14 / 4)
>  
> -#define WDT_RESTART_MAGIC       0x4755
> +#define WDT_RESTART_MAGIC               0x4755
>  
>  static bool aspeed_wdt_is_enabled(const AspeedWDTState *s)
>  {
> @@ -55,9 +64,10 @@ static uint64_t aspeed_wdt_read(void *opaque, hwaddr offset, unsigned size)
>          return 0;
>      case WDT_CTRL:
>          return s->regs[WDT_CTRL];
> +    case WDT_RESET_WIDTH:
> +        return s->regs[WDT_RESET_WIDTH];
>      case WDT_TIMEOUT_STATUS:
>      case WDT_TIMEOUT_CLEAR:
> -    case WDT_RESET_WDITH:
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: uninmplemented read at offset 0x%" HWADDR_PRIx "\n",
>                        __func__, offset);
> @@ -119,9 +129,25 @@ static void aspeed_wdt_write(void *opaque, hwaddr offset, uint64_t data,
>              timer_del(s->timer);
>          }
>          break;
> +    case WDT_RESET_WIDTH:
> +    {
> +        uint32_t property = data & WDT_POLARITY_MASK;
> +
> +        if (property == WDT_ACTIVE_HIGH_MAGIC) {
> +            s->regs[WDT_RESET_WIDTH] |= WDT_RESET_WIDTH_ACTIVE_HIGH;
> +        } else if (property == WDT_ACTIVE_LOW_MAGIC) {
> +            s->regs[WDT_RESET_WIDTH] &= ~WDT_RESET_WIDTH_ACTIVE_HIGH;
> +        } else if (property == WDT_PUSH_PULL_MAGIC) {
> +            s->regs[WDT_RESET_WIDTH] |= WDT_RESET_WIDTH_PUSH_PULL;
> +        } else if (property == WDT_OPEN_DRAIN_MAGIC) {
> +            s->regs[WDT_RESET_WIDTH] &= ~WDT_RESET_WIDTH_PUSH_PULL;
> +        }
> +        s->regs[WDT_RESET_WIDTH] &= ~WDT_RESET_WIDTH_DURATION;
> +        s->regs[WDT_RESET_WIDTH] |= data & WDT_RESET_WIDTH_DURATION;
> +        break;
> +    }
>      case WDT_TIMEOUT_STATUS:
>      case WDT_TIMEOUT_CLEAR:
> -    case WDT_RESET_WDITH:
>          qemu_log_mask(LOG_UNIMP,
>                        "%s: uninmplemented write at offset 0x%" HWADDR_PRIx "\n",
>                        __func__, offset);
> @@ -167,6 +193,7 @@ static void aspeed_wdt_reset(DeviceState *dev)
>      s->regs[WDT_RELOAD_VALUE] = 0x03EF1480;
>      s->regs[WDT_RESTART] = 0;
>      s->regs[WDT_CTRL] = 0;
> +    s->regs[WDT_RESET_WIDTH] = 0XFF;
>  
>      timer_del(s->timer);
>  }
> 
