Received: from eggs.gnu.org ([209.51.188.92]:38656)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGNs9-0007d3-CZ
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:11:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hGNs8-0004OR-9i
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 09:11:37 -0400
References: <20190416091348.26075-1-armbru@redhat.com>
	<20190416091348.26075-3-armbru@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <f5ea42df-e9e0-7cbe-7a83-6a83911ee0a4@redhat.com>
Date: Tue, 16 Apr 2019 15:11:19 +0200
MIME-Version: 1.0
In-Reply-To: <20190416091348.26075-3-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, philmd@redhat.com

On 04/16/19 11:13, Markus Armbruster wrote:
> Factored out of pc_system_firmware_init() so the next commit can reuse

s/Factored/Factor/

(no need to repost, can be done in the PULL)

with that:

Reviewed-by: Laszlo Ersek <lersek@redhat.com>

Thanks!
Laszlo

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
