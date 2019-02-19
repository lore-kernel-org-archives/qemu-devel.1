Received: from eggs.gnu.org ([209.51.188.92]:54836)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw52Q-0005IV-1A
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:02:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw52N-0005TN-17
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:02:17 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50893)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw52L-0005R4-5R
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:02:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id x7so2734750wmj.0
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 05:02:12 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-8-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <816c0dd9-9213-cda9-2fa1-611c0cacf9a1@redhat.com>
Date: Tue, 19 Feb 2019 14:02:09 +0100
MIME-Version: 1.0
In-Reply-To: <20190218125615.18970-8-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/10] mips_malta: Clean up definition of
 flash memory size somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>, alex.bennee@linaro.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com, Aurelien Jarno <aurelien@aurel32.net>

On 2/18/19 1:56 PM, Markus Armbruster wrote:
> pflash_cfi01_register() takes a size in bytes, a block size in bytes
> and a number of blocks.  mips_malta_init() passes BIOS_SIZE, 65536,
> FLASH_SIZE >> 16.  Actually consistent only because BIOS_SIZE (defined
> in include/hw/mips/bios.h as (4 * MiB)) matches FLASH_SIZE (defined
> locally as 0x400000).  Confusing all the same.
> 
> Pass FLASH_SIZE instead of BIOS_SIZE.

Your cleanup is correct.

> 
> There are more uses of BIOS_SIZE, but I don't sufficiently understand
> them to attempt cleanup.

BIOS_SIZE is a MIPS architecture definition, incorrectly used around.
This simply means "Top of 32bit address space - Boot Vector address".
There is nothing wrong in plugging bigger/smaller flashes around the
boot vector.
(I have a series cleaning this definition, but I'm throttling my MIPS
apports).

> 
> Cc: Aurelien Jarno <aurelien@aurel32.net>
> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/mips/mips_malta.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index fff5ed19bd..65cdda4881 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -1269,12 +1269,12 @@ void mips_malta_init(MachineState *machine)
>      if (dinfo) {
>          printf("Register parallel flash %d size " TARGET_FMT_lx " at "
>                 "addr %08llx '%s' %x\n",
> -               fl_idx, bios_size, FLASH_ADDRESS,
> +               fl_idx, FLASH_SIZE, FLASH_ADDRESS,
>                 blk_name(dinfo->bdrv), fl_sectors);
>      }
>  #endif
>      fl = pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
> -                               BIOS_SIZE,
> +                               FLASH_SIZE,
>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>                                 65536, fl_sectors,
>                                 4, 0x0000, 0x0000, 0x0000, 0x0000, be);
> 

Does that mean you can remove the "hw/mips/bios.h" include now?

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
