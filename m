Received: from eggs.gnu.org ([2001:4830:134:3::10]:47382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWqye-00043p-4L
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:53:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1eWqyd-00074Y-Cs
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 16:53:36 -0500
MIME-Version: 1.0
Sender: alistair23@gmail.com
In-Reply-To: <20180103164117.11850-2-f4bug@amsat.org>
References: <20180103164117.11850-1-f4bug@amsat.org>
	<20180103164117.11850-2-f4bug@amsat.org>
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Wed, 3 Jan 2018 13:53:01 -0800
Message-ID: <CAKmqyKM8mmx3g+6Qonr8NQTBi=YLk7KoGyAvzO_46j5VkZEBVA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/timer/pxa2xx_timer: replace
 hw_error() -> qemu_log_mask()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrzej Zaborowski <balrogg@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

On Wed, Jan 3, 2018 at 8:41 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g> wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/timer/pxa2xx_timer.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/hw/timer/pxa2xx_timer.c b/hw/timer/pxa2xx_timer.c
> index 68ba5a70b3..cfea0a5e22 100644
> --- a/hw/timer/pxa2xx_timer.c
> +++ b/hw/timer/pxa2xx_timer.c
> @@ -13,6 +13,7 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/arm/pxa.h"
>  #include "hw/sysbus.h"
> +#include "qemu/log.h"
>
>  #define OSMR0  0x00
>  #define OSMR1  0x04
> @@ -252,8 +253,12 @@ static uint64_t pxa2xx_timer_read(void *opaque, hwad=
dr offset,
>      case OSNR:
>          return s->snapshot;
>      default:
> +        qemu_log_mask(LOG_UNIMP, "%s: unknown reg 0x%02" HWADDR_PRIx
> +                      "\n", __func__, offset);
> +        break;
>      badreg:
> -        hw_error("pxa2xx_timer_read: Bad offset " REG_FMT "\n", offset);
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: incorrect reg 0x%02" HWADDR_=
PRIx
> +                      "\n", __func__, offset);

It might just be my email display, but if these lines don't line up
can you fix them?

Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>

Alistair

>      }
>
>      return 0;
> @@ -377,8 +382,12 @@ static void pxa2xx_timer_write(void *opaque, hwaddr =
offset,
>          }
>          break;
>      default:
> +        qemu_log_mask(LOG_UNIMP, "%s: unknown reg 0x%02" HWADDR_PRIx " "
> +                      "(value 0x%08" PRIx64 ")\n", __func__, offset, val=
ue);
> +        break;
>      badreg:
> -        hw_error("pxa2xx_timer_write: Bad offset " REG_FMT "\n", offset)=
;
> +        qemu_log_mask(LOG_GUEST_ERROR, "%s: incorrect reg 0x%02" HWADDR_=
PRIx " "
> +                      "(value 0x%08" PRIx64 ")\n", __func__, offset, val=
ue);
>      }
>  }
>
> --
> 2.15.1
>
>
