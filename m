Received: from eggs.gnu.org ([2001:4830:134:3::10]:44033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXRCw-0007Yv-Ce
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:34:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXRCv-0007GJ-GX
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 07:34:46 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180103162400.10396-1-f4bug@amsat.org>
	<20180103162400.10396-2-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5ffb2419-86a9-6954-0e35-31da0cc97d61@amsat.org>
Date: Fri, 5 Jan 2018 09:34:35 -0300
MIME-Version: 1.0
In-Reply-To: <20180103162400.10396-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/6] hw/sd/milkymist-memcard: use
 qemu_log_mask()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

I'm too comfortable with the 'log' trace backend and again forgot to add
the "qemu/log.h" dependency ...

/home/travis/build/philmd/qemu/hw/sd/milkymist-memcard.c:141:17: error:
implicit declaration of function ‘qemu_log_mask’
[-Werror=implicit-function-declaration]
                 qemu_log_mask(LOG_GUEST_ERROR, "milkymist_memcard: "
                 ^
hw/sd/milkymist-memcard.c:141:31: error: ‘LOG_GUEST_ERROR’ undeclared
(first use in this function)
                 qemu_log_mask(LOG_GUEST_ERROR, "milkymist_memcard: "
                               ^
hw/sd/milkymist-memcard.c:166:23: error: ‘LOG_UNIMP’ undeclared (first
use in this function)
         qemu_log_mask(LOG_UNIMP, "milkymist_memcard: "
                       ^

On 01/03/2018 01:23 PM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/sd/milkymist-memcard.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
> index 4008c81002..5de3e00e2f 100644
> --- a/hw/sd/milkymist-memcard.c
> +++ b/hw/sd/milkymist-memcard.c
> @@ -26,7 +26,7 @@
>  #include "hw/sysbus.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
> -#include "qemu/error-report.h"
> +#include "include/qapi/error.h"
>  #include "sysemu/block-backend.h"
>  #include "sysemu/blockdev.h"
>  #include "hw/sd/sd.h"
> @@ -138,8 +138,8 @@ static uint64_t memcard_read(void *opaque, hwaddr addr,
>          } else {
>              r = s->response[s->response_read_ptr++];
>              if (s->response_read_ptr > s->response_len) {
> -                error_report("milkymist_memcard: "
> -                        "read more cmd bytes than available. Clipping.");
> +                qemu_log_mask(LOG_GUEST_ERROR, "milkymist_memcard: "
> +                              "read more cmd bytes than available. Clipping.");
>                  s->response_read_ptr = 0;
>              }
>          }
> @@ -163,8 +163,9 @@ static uint64_t memcard_read(void *opaque, hwaddr addr,
>          break;
>  
>      default:
> -        error_report("milkymist_memcard: read access to unknown register 0x"
> -                TARGET_FMT_plx, addr << 2);
> +        qemu_log_mask(LOG_UNIMP, "milkymist_memcard: "
> +                      "read access to unknown register 0x%" HWADDR_PRIx "\n",
> +                      addr << 2);
>          break;
>      }
>  
> @@ -220,8 +221,9 @@ static void memcard_write(void *opaque, hwaddr addr, uint64_t value,
>          break;
>  
>      default:
> -        error_report("milkymist_memcard: write access to unknown register 0x"
> -                TARGET_FMT_plx, addr << 2);
> +        qemu_log_mask(LOG_UNIMP, "milkymist_memcard: "
> +                      "write access to unknown register 0x%" HWADDR_PRIx " "
> +                      "(value 0x%" PRIx64 ")\n", addr << 2, value);
>          break;
>      }
>  }
> 
