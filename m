Received: from eggs.gnu.org ([209.51.188.92]:48909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4hJ-0000tz-3V
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:40:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw4hB-0002zf-DA
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:40:23 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:40165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw4h7-0002yK-QV
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 07:40:19 -0500
Received: by mail-wm1-f66.google.com with SMTP id t15so2604912wmi.5
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 04:40:17 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2340eb1c-d8d8-3d92-bbb5-b541bb44dcba@redhat.com>
Date: Tue, 19 Feb 2019 13:40:15 +0100
MIME-Version: 1.0
In-Reply-To: <20190218125615.18970-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 02/10] pflash: Macro PFLASH_BUG() is used
 just once, expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, alex.bennee@linaro.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

On 2/18/19 1:56 PM, Markus Armbruster wrote:
> PFLASH_BUG()'s lone use has a suspicious smell: it prints "Possible
> BUG", which sounds like a warning, then calls exit(1), followed by
> unreachable goto reset_flash.  All this commit does is expanding the
> macro, so the smell becomes more poignant, and the macro can be
> deleted.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/block/pflash_cfi01.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 9efa7aa9af..f73c30a3ee 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -49,12 +49,6 @@
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
>  
> -#define PFLASH_BUG(fmt, ...) \
> -do { \
> -    fprintf(stderr, "PFLASH: Possible BUG - " fmt, ## __VA_ARGS__); \
> -    exit(1); \
> -} while(0)
> -
>  /* #define PFLASH_DEBUG */
>  #ifdef PFLASH_DEBUG
>  #define DPRINTF(fmt, ...)                                   \
> @@ -624,8 +618,8 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>                  pfl->status |= 0x80;
>              } else {
>                  DPRINTF("%s: unknown command for \"write block\"\n", __func__);
> -                PFLASH_BUG("Write block confirm");
> -                goto reset_flash;
> +                fprintf(stderr, "PFLASH: Possible BUG - Write block confirm");
> +                exit(1);

Don't you want to use hw_error here?

      hw_error("PFLASH: Possible BUG - Write block confirm");

>              }
>              break;
>          default:
> 
