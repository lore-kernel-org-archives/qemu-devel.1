Received: from eggs.gnu.org ([209.51.188.92]:33148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2FAL-0003jj-5J
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:04:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h2FAJ-00074S-8V
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:03:56 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37447)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h2FAJ-0006bh-0X
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:03:55 -0500
Received: by mail-wr1-f65.google.com with SMTP id w6so21276427wrs.4
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 05:03:50 -0800 (PST)
References: <20190308094610.21210-1-armbru@redhat.com>
	<20190308094610.21210-11-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8acf69ab-ec1e-7fa9-1274-619d6e43efde@redhat.com>
Date: Fri, 8 Mar 2019 14:03:44 +0100
MIME-Version: 1.0
In-Reply-To: <20190308094610.21210-11-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v4 10/15] mips_malta: Delete disabled,
 broken DEBUG_BOARD_INIT code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-ppc@nongnu.org, balaton@eik.bme.hu

On 3/8/19 10:46 AM, Markus Armbruster wrote:
> The debug code under DEBUG_BOARD_INIT doesn't compile:
> 
>       hw/mips/mips_malta.c:1273:16: error: implicit declaration of function ‘blk_name’; did you mean ‘basename’? [-Werror=implicit-function-declaration]
>                     blk_name(dinfo->bdrv), fl_sectors);
>                     ^~~~~~~~
>       hw/mips/mips_malta.c:1273:16: error: nested extern declaration of ‘blk_name’ [-Werror=nested-externs]
>       hw/mips/mips_malta.c:1273:30: error: ‘DriveInfo’ {aka ‘struct DriveInfo’} has no member named ‘bdrv’
>                     blk_name(dinfo->bdrv), fl_sectors);
>                                     ^~
> 
> Delete it.
> 
> Reported-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/mips/mips_malta.c | 10 ----------
>  1 file changed, 10 deletions(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index 2827074e9b..8736d3a00e 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -58,8 +58,6 @@
>  #include "exec/semihost.h"
>  #include "hw/mips/cps.h"
>  
> -//#define DEBUG_BOARD_INIT
> -
>  #define ENVP_ADDR		0x80002000l
>  #define ENVP_NB_ENTRIES	 	16
>  #define ENVP_ENTRY_SIZE	 	256
> @@ -1265,14 +1263,6 @@ void mips_malta_init(MachineState *machine)
>  
>      /* Load firmware in flash / BIOS. */
>      dinfo = drive_get(IF_PFLASH, 0, fl_idx);
> -#ifdef DEBUG_BOARD_INIT
> -    if (dinfo) {
> -        printf("Register parallel flash %d size " TARGET_FMT_lx " at "
> -               "addr %08llx '%s' %x\n",
> -               fl_idx, bios_size, FLASH_ADDRESS,
> -               blk_name(dinfo->bdrv), fl_sectors);
> -    }
> -#endif
>      fl = pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
>                                 BIOS_SIZE,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> 
