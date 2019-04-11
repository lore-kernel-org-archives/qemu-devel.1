Received: from eggs.gnu.org ([209.51.188.92]:60416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEfih-0000SR-VW
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:50:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1hEfig-0003qQ-7d
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 15:50:47 -0400
From: Laszlo Ersek <lersek@redhat.com>
References: <20190411135602.21725-1-armbru@redhat.com>
	<20190411135602.21725-2-armbru@redhat.com>
	<0eea5ddb-1efb-8fdf-4a37-9bc2daf86e2b@redhat.com>
Message-ID: <03fb5b6f-7d95-3b9b-3172-e37825402036@redhat.com>
Date: Thu, 11 Apr 2019 21:50:34 +0200
MIME-Version: 1.0
In-Reply-To: <0eea5ddb-1efb-8fdf-4a37-9bc2daf86e2b@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] pflash_cfi01: New
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org, mreitz@redhat.com, qemu-arm@nongnu.org

On 04/11/19 21:35, Laszlo Ersek wrote:
> On 04/11/19 15:56, Markus Armbruster wrote:
>> Factored out of pc_system_firmware_init() so the next commit can reuse
>> it in hw/arm/virt.c.
>>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/block/pflash_cfi01.c  | 30 ++++++++++++++++++++++++++++++
>>  hw/i386/pc_sysfw.c       | 19 ++-----------------
>>  include/hw/block/flash.h |  1 +
>>  3 files changed, 33 insertions(+), 17 deletions(-)
>>
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 16dfae14b8..eba01b1447 100644
>> --- a/hw/block/pflash_cfi01.c
>> +++ b/hw/block/pflash_cfi01.c
>> @@ -44,9 +44,12 @@
>>  #include "qapi/error.h"
>>  #include "qemu/timer.h"
>>  #include "qemu/bitops.h"
>> +#include "qemu/error-report.h"
>>  #include "qemu/host-utils.h"
>>  #include "qemu/log.h"
>> +#include "qemu/option.h"
>>  #include "hw/sysbus.h"
>> +#include "sysemu/blockdev.h"
>>  #include "sysemu/sysemu.h"
>>  #include "trace.h"
>>  
>> @@ -968,6 +971,33 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
>>      return &fl->mem;
>>  }
>>  
>> +/*
>> + * Handle -drive if=pflash for machines that use machine properties.
> 
> (1) Can we improve readability with quotes? "-drive if=pflash"
> 
>> + * Map unit#i (0 < i <= @ndev) to @dev[i]'s property "drive".
> 
> (2) I think you meant (0 <= i < @ndev)
> 
>> + */
>> +void pflash_cfi01_legacy_drive(PFlashCFI01 *dev[], int ndev)
>> +{
>> +    int i;
> 
> (3) For utter pedantry, "ndev"  and "i" should have type "size_t" (in
> particular because we expect the caller to fill "ndev" with ARRAY_SIZE().
> 
> But, this would go beyond refactoring -- the original "int"s have served
> us just fine, and we're usually counting up (exclusively) to the huge
> number... two. :)
> 
>> +    DriveInfo *dinfo;
>> +    Location loc;
>> +
>> +    for (i = 0; i < ndev; i++) {
>> +        dinfo = drive_get(IF_PFLASH, 0, i);
>> +        if (!dinfo) {
>> +            continue;
>> +        }
>> +        loc_push_none(&loc);
>> +        qemu_opts_loc_restore(dinfo->opts);
>> +        if (dev[i]->blk) {
> 
> (4) Is this really identical to the code being removed? The above
> controlling expression amounts to:
> 
>   pcms->flash[i]->blk
> 
> but the original boils down to
> 
>   pflash_cfi01_get_blk(pcms->flash[i])
> 
> Hmm... looking at pflash_cfi01_get_blk(), they are the same. Is there a
> particular reason for not using the wrapper function any longer? As in:
> 
>   pflash_cfi01_get_blk(dev[i])
> 
>> +            error_report("clashes with -machine");
>> +            exit(1);
>> +        }
>> +        qdev_prop_set_drive(DEVICE(dev[i]), "drive",
>> +                            blk_by_legacy_dinfo(dinfo), &error_fatal);
>> +        loc_pop(&loc);
>> +    }
>> +}
>> +
>>  static void postload_update_cb(void *opaque, int running, RunState state)
>>  {
>>      PFlashCFI01 *pfl = opaque;
>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index c628540774..d58e47184c 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -269,32 +269,17 @@ void pc_system_firmware_init(PCMachineState *pcms,
>>  {
>>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>>      int i;
>> -    DriveInfo *pflash_drv;
>>      BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>> -    Location loc;
>>  
>>      if (!pcmc->pci_enabled) {
>>          old_pc_system_rom_init(rom_memory, true);
>>          return;
>>      }
>>  
>> -    /* Map legacy -drive if=pflash to machine properties */
>> +    pflash_cfi01_legacy_drive(pcms->flash, ARRAY_SIZE(pcms->flash));
>> +
>>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>>          pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>> -        pflash_drv = drive_get(IF_PFLASH, 0, i);
>> -        if (!pflash_drv) {
>> -            continue;
>> -        }
>> -        loc_push_none(&loc);
>> -        qemu_opts_loc_restore(pflash_drv->opts);
>> -        if (pflash_blk[i]) {
>> -            error_report("clashes with -machine");
>> -            exit(1);
>> -        }
>> -        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
>> -        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
>> -                            "drive", pflash_blk[i], &error_fatal);
>> -        loc_pop(&loc);
>>      }
> 
> (5) I think you deleted too much here. After this loop, post-patch, for
> all "i", we'll have
> 
>   pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
> 
> But pre-patch, for all "i" where the "continue" didn't fire, we'd end up
> with:
> 
>   pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
> 
> IOW the original loop both verifies and *collects*, for the gap check
> that comes just below.
> 
> IIRC, this allows for mixing "-drive if=pflash,unit=N" with the machine
> properties, as long as you have neither conflicts, nor gaps.
> 
> Post-patch however, this kind of mixing would break, because we'd report
> gaps for the legacy ("-drive if=pflash") options.
> 
> 
> In addition, it could break the "use ROM mode" branch below, which is
> based on pflash_blk[0].
> 
> I think we should extend pflash_cfi01_legacy_drive() to populate
> "pflash_blk[0..(ndev-1)]" on output (assuming pflash_blk is not NULL on
> input).
> 
> (Because, I'm assuming that qdev_prop_set_drive() -- which now occurs in
> the factored-out loop *before* the loop that we preserve here -- has no
> effect on pflash_cfi01_get_blk(pcms->flash[i]).)

Hmmm, that's likely precisely what I'm wrong about. I've now looked at
DEFINE_PROP_DRIVE / qdev_prop_drive / set_drive / parse_drive... Does
qdev_prop_set_drive() actually *turn* the legacy options into genuine
machine type properties?... The removed comment does indicate that:

  "Map legacy -drive if=pflash to machine properties"

So I guess the remaining loop is correct after all, but the new comment

  "Handle -drive if=pflash for machines that use machine properties"

is less clear to me.

Thanks,
Laszlo

> 
> Thanks,
> Laszlo
> 
>>  
>>      /* Reject gaps */
>> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
>> index a0f488732a..f6a68c2a4c 100644
>> --- a/include/hw/block/flash.h
>> +++ b/include/hw/block/flash.h
>> @@ -24,6 +24,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>>                                     int be);
>>  BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl);
>>  MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
>> +void pflash_cfi01_legacy_drive(PFlashCFI01 *dev[], int ndev);
>>  
>>  /* pflash_cfi02.c */
>>  
>>
> 
