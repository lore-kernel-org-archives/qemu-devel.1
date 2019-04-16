Received: from eggs.gnu.org ([209.51.188.92]:40664)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGS8R-00017C-Qn
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:44:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1hGS8P-0000IR-R9
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:44:43 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:54131)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hGS8P-0000HV-HO
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 13:44:41 -0400
Received: by mail-wm1-f68.google.com with SMTP id q16so80408wmj.3
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 10:44:41 -0700 (PDT)
References: <20190416091348.26075-1-armbru@redhat.com>
	<20190416091348.26075-3-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <03ecf4b0-c665-9677-b166-4d68f50cd70b@redhat.com>
Date: Tue, 16 Apr 2019 19:44:38 +0200
MIME-Version: 1.0
In-Reply-To: <20190416091348.26075-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 2/3] pflash_cfi01: New
 pflash_cfi01_legacy_drive()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: lersek@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

On 4/16/19 11:13 AM, Markus Armbruster wrote:
> Factored out of pc_system_firmware_init() so the next commit can reuse
> it in hw/arm/virt.c.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/block/pflash_cfi01.c  | 28 ++++++++++++++++++++++++++++
>  hw/i386/pc_sysfw.c       | 16 ++--------------
>  include/hw/block/flash.h |  1 +
>  3 files changed, 31 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index 16dfae14b8..333b736277 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -44,9 +44,12 @@
>  #include "qapi/error.h"
>  #include "qemu/timer.h"
>  #include "qemu/bitops.h"
> +#include "qemu/error-report.h"
>  #include "qemu/host-utils.h"
>  #include "qemu/log.h"
> +#include "qemu/option.h"
>  #include "hw/sysbus.h"
> +#include "sysemu/blockdev.h"
>  #include "sysemu/sysemu.h"
>  #include "trace.h"
>  
> @@ -968,6 +971,31 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
>      return &fl->mem;
>  }
>  
> +/*
> + * Handle -drive if=pflash for machines that use properties.
> + * If @dinfo is null, do nothing.
> + * Else if @fl's property "drive" is already set, fatal error.
> + * Else set it to the BlockBackend with @dinfo.
> + */
> +void pflash_cfi01_legacy_drive(PFlashCFI01 *fl, DriveInfo *dinfo)
> +{
> +    Location loc;
> +
> +    if (!dinfo) {
> +        return;
> +    }
> +
> +    loc_push_none(&loc);
> +    qemu_opts_loc_restore(dinfo->opts);
> +    if (fl->blk) {
> +        error_report("clashes with -machine");
> +        exit(1);
> +    }
> +    qdev_prop_set_drive(DEVICE(fl), "drive",
> +                        blk_by_legacy_dinfo(dinfo), &error_fatal);
> +    loc_pop(&loc);
> +}
> +
>  static void postload_update_cb(void *opaque, int running, RunState state)
>  {
>      PFlashCFI01 *pfl = opaque;
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index 75925f5d3f..751fcafa12 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -269,9 +269,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  {
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>      int i;
> -    DriveInfo *pflash_drv;
>      BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
> -    Location loc;
>  
>      if (!pcmc->pci_enabled) {
>          old_pc_system_rom_init(rom_memory, true);
> @@ -280,18 +278,8 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  
>      /* Map legacy -drive if=pflash to machine properties */
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> -        pflash_drv = drive_get(IF_PFLASH, 0, i);
> -        if (pflash_drv) {
> -            loc_push_none(&loc);
> -            qemu_opts_loc_restore(pflash_drv->opts);

You can now remove the '#include "qemu/option.h"' in this file.

With that:
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> -            if (pflash_cfi01_get_blk(pcms->flash[i])) {
> -                error_report("clashes with -machine");
> -                exit(1);
> -            }
> -            qdev_prop_set_drive(DEVICE(pcms->flash[i]), "drive",
> -                                blk_by_legacy_dinfo(pflash_drv), &error_fatal);
> -            loc_pop(&loc);
> -        }
> +        pflash_cfi01_legacy_drive(pcms->flash[i],
> +                                  drive_get(IF_PFLASH, 0, i));
>          pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>      }
>  
> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
> index a0f488732a..1acaf7de80 100644
> --- a/include/hw/block/flash.h
> +++ b/include/hw/block/flash.h
> @@ -24,6 +24,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>                                     int be);
>  BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl);
>  MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
> +void pflash_cfi01_legacy_drive(PFlashCFI01 *dev, DriveInfo *dinfo);
>  
>  /* pflash_cfi02.c */
>  
> 
