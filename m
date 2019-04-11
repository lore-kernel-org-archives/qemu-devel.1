Received: from eggs.gnu.org ([209.51.188.92]:36687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEeEF-0002eX-EK
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:15:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hEeEE-0002hH-LC
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 14:15:15 -0400
References: <20190311102712.8572-1-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <bb6dd5eb-09d7-89bb-62f7-ecaed849cb79@vivier.eu>
Date: Thu, 11 Apr 2019 20:14:41 +0200
MIME-Version: 1.0
In-Reply-To: <20190311102712.8572-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH] hw/net/pcnet: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>

On 11/03/2019 11:27, Philippe Mathieu-Daudé wrote:
> Avoid to clutter stdout until explicitly requested
> (with -d guest_errors):
> 
>   $ qemu-system-mips -M malta -m 512 -kernel vmlinux-3.2.0-4-4kc-malta
>   Bad SWSTYLE=0x04
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Helge patch "pcnet: Avoid warning when switching back to 16bit mode"
> remembered me I had this one somewhere.
> ---
>  hw/net/pcnet.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
> index d9ba04bdfc..16683091c9 100644
> --- a/hw/net/pcnet.c
> +++ b/hw/net/pcnet.c
> @@ -36,6 +36,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> +#include "qemu/log.h"
>  #include "hw/qdev.h"
>  #include "net/net.h"
>  #include "net/eth.h"
> @@ -1501,7 +1502,8 @@ static void pcnet_bcr_writew(PCNetState *s, uint32_t rap, uint32_t val)
>              val |= 0x0300;
>              break;
>          default:
> -            printf("Bad SWSTYLE=0x%02x\n", val & 0xff);
> +            qemu_log_mask(LOG_GUEST_ERROR, "pcnet: Bad SWSTYLE=0x%02x\n",
> +                          val & 0xff);
>              val = 0x0200;
>              break;
>          }
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
