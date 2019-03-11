Received: from eggs.gnu.org ([209.51.188.92]:37236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3IEU-0001Tw-0g
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:32:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3IET-0002jw-Bk
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:32:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46227)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h3IET-0002jK-3k
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:32:33 -0400
Received: by mail-wr1-f68.google.com with SMTP id i16so4426724wrs.13
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 03:32:33 -0700 (PDT)
References: <20190311102712.8572-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <ccf4af1c-8435-8698-b584-456a7e4782dc@redhat.com>
Date: Mon, 11 Mar 2019 11:32:19 +0100
MIME-Version: 1.0
In-Reply-To: <20190311102712.8572-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/net/pcnet: Use
 qemu_log_mask(GUEST_ERROR) instead of fprintf
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Helge Deller <deller@gmx.de>, Aleksandar Rikalo <arikalo@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

Oops 'fprintf' -> 'printf' in patch subject.

On 3/11/19 11:27 AM, Philippe Mathieu-Daudé wrote:
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
