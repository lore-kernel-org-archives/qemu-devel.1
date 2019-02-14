Received: from eggs.gnu.org ([209.51.188.92]:39262)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDrt-00024B-Rt
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:03:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1guDqS-0005DU-Oo
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 05:02:21 -0500
References: <20190212145322.30974-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <3490f4fd-3e91-8494-8580-97a005174507@vivier.eu>
Date: Thu, 14 Feb 2019 11:02:03 +0100
MIME-Version: 1.0
In-Reply-To: <20190212145322.30974-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw/dma/i8257: Use
 qemu_log_mask(UNIMP) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>

On 12/02/2019 15:53, Philippe Mathieu-Daudé wrote:
> Avoid to clutter stdout until explicitly requested (with -d unimp):
> 
>   $ qemu-system-mips64el -M fulong2e -bios pmon_2e.bin
>   dma: command df not supported
>   dma: command df not supported
>   dma: command df not supported
>   dma: command df not supported
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/dma/i8257.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
> index 52675e97c9..3e1f13a4aa 100644
> --- a/hw/dma/i8257.c
> +++ b/hw/dma/i8257.c
> @@ -26,6 +26,7 @@
>  #include "hw/isa/isa.h"
>  #include "hw/dma/i8257.h"
>  #include "qemu/main-loop.h"
> +#include "qemu/log.h"
>  #include "trace.h"
>  
>  #define I8257(obj) \
> @@ -185,7 +186,8 @@ static void i8257_write_cont(void *opaque, hwaddr nport, uint64_t data,
>      switch (iport) {
>      case 0x00:                  /* command */
>          if ((data != 0) && (data & CMD_NOT_SUPPORTED)) {
> -            dolog("command %"PRIx64" not supported\n", data);
> +            qemu_log_mask(LOG_UNIMP, "%s: cmd 0x%02"PRIx64" not supported\n",
> +                          __func__, data);
>              return;
>          }
>          d->command = data;
> 


Applied to my trivial-patches branch.

Thanks,
Laurent
