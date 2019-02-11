Received: from eggs.gnu.org ([209.51.188.92]:43382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtLUD-0002Am-2s
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:59:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gtLU1-0001YO-7k
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:59:34 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36600)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gtLTt-0001ML-19
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 18:59:23 -0500
Received: by mail-wm1-f65.google.com with SMTP id j125so1096840wmj.1
	for <qemu-devel@nongnu.org>; Mon, 11 Feb 2019 15:59:16 -0800 (PST)
References: <cover.1549857716.git.balaton@eik.bme.hu>
	<4ba510e2c7771808fa5061e14526f313c1ac3817.1549857716.git.balaton@eik.bme.hu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <843d579b-9eb3-f96a-bc53-17c16b7cec65@redhat.com>
Date: Tue, 12 Feb 2019 00:59:14 +0100
MIME-Version: 1.0
In-Reply-To: <4ba510e2c7771808fa5061e14526f313c1ac3817.1549857716.git.balaton@eik.bme.hu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 2/4] mips_fulong2e: Fix bios flash size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Huacai Chen <zltjiangshi@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>

On 2/11/19 5:01 AM, BALATON Zoltan wrote:
> According to both the specifications on linux-mips.org referenced in a

This link: https://www.linux-mips.org/wiki/Fulong#Front:

> comment at the beginning of the file and the flash chip part number
> the bios size should be 512k not 1M.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/mips/mips_fulong2e.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 02549d5c7e..10e6ed585a 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/units.h"
>  #include "qapi/error.h"
> +#include "cpu.h"
>  #include "hw/hw.h"
>  #include "hw/i386/pc.h"
>  #include "hw/dma/i8257.h"
> @@ -35,7 +36,6 @@
>  #include "audio/audio.h"
>  #include "qemu/log.h"
>  #include "hw/loader.h"
> -#include "hw/mips/bios.h"
>  #include "hw/ide.h"
>  #include "elf.h"
>  #include "hw/isa/vt82c686.h"
> @@ -51,6 +51,8 @@
>  #define ENVP_NB_ENTRIES	 	16
>  #define ENVP_ENTRY_SIZE	 	256
>  
> +/* fulong 2e has a 512k flash: Winbond W39L040AP70Z */
> +#define BIOS_SIZE (512 * KiB)
>  #define MAX_IDE_BUS 2
>  
>  /*
> @@ -307,12 +309,9 @@ static void mips_fulong2e_init(MachineState *machine)
>      /* fulong 2e has 256M ram. */
>      ram_size = 256 * MiB;
>  
> -    /* fulong 2e has a 1M flash.Winbond W39L040AP70Z */
> -    bios_size = 1 * MiB;
> -
>      /* allocate RAM */
>      memory_region_allocate_system_memory(ram, NULL, "fulong2e.ram", ram_size);
> -    memory_region_init_ram(bios, NULL, "fulong2e.bios", bios_size,
> +    memory_region_init_ram(bios, NULL, "fulong2e.bios", BIOS_SIZE,
>                             &error_fatal);
>      memory_region_set_readonly(bios, true);
>  
> 
