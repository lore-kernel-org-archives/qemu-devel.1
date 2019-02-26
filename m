Received: from eggs.gnu.org ([209.51.188.92]:38916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gymdn-0003ND-UF
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 19:00:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gymdg-00016F-5s
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:59:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34398)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gymdY-0000zU-Ac
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:59:50 -0500
Received: by mail-wm1-f68.google.com with SMTP id o10so3232462wmc.1
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 15:59:45 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <917ac89b-df14-05a5-325b-05cfa9aeabaa@redhat.com>
Date: Wed, 27 Feb 2019 00:59:43 +0100
MIME-Version: 1.0
In-Reply-To: <20190226193408.23862-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 02/11] pflash_cfi01: Do not exit() on
 guest aborting "write to buffer"
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

On 2/26/19 8:33 PM, Markus Armbruster wrote:
> When a guest tries to abort "write to buffer" (command 0xE8), we print
> "PFLASH: Possible BUG - Write block confirm", then exit(1).  Letting
> the guest terminate QEMU is not a good idea.  Instead, LOG_UNIMP we
> screwed up, then reset the device.
> 
> Macro PFLASH_BUG() is now unused; delete it.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/block/pflash_cfi01.c | 13 +++++--------
>  1 file changed, 5 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index a51ac9f399..e6d933a06d 100644
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
> @@ -623,8 +617,11 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>                  pfl->wcycle = 0;
>                  pfl->status |= 0x80;
>              } else {
> -                DPRINTF("%s: unknown command for \"write block\"\n", __func__);
> -                PFLASH_BUG("Write block confirm");
> +                qemu_log_mask(LOG_UNIMP,
> +                    "%s: Aborting write to buffer not implemented,"
> +                    " the data is already written to storage!\n"
> +                    "Flash device reset into READ mode.\n",
> +                    __func__);
>                  goto reset_flash;
>              }
>              break;
> 
