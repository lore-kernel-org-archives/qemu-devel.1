Received: from eggs.gnu.org ([209.51.188.92]:35147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGTdR-0002s1-RT
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:20:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hGTdQ-0004fB-Rb
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 15:20:49 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190416091348.26075-1-armbru@redhat.com>
	<20190416091348.26075-3-armbru@redhat.com>
	<03ecf4b0-c665-9677-b166-4d68f50cd70b@redhat.com>
Date: Tue, 16 Apr 2019 21:20:37 +0200
In-Reply-To: <03ecf4b0-c665-9677-b166-4d68f50cd70b@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	16 Apr 2019 19:44:38 +0200")
Message-ID: <87o9553gfu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, qemu-block@nongnu.org, mreitz@redhat.com, qemu-arm@nongnu.org, lersek@redhat.com

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 4/16/19 11:13 AM, Markus Armbruster wrote:
>> Factored out of pc_system_firmware_init() so the next commit can reuse
>> it in hw/arm/virt.c.
>>=20
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/block/pflash_cfi01.c  | 28 ++++++++++++++++++++++++++++
>>  hw/i386/pc_sysfw.c       | 16 ++--------------
>>  include/hw/block/flash.h |  1 +
>>  3 files changed, 31 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>> index 16dfae14b8..333b736277 100644
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
>>=20=20
>> @@ -968,6 +971,31 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *=
fl)
>>      return &fl->mem;
>>  }
>>=20=20
>> +/*
>> + * Handle -drive if=3Dpflash for machines that use properties.
>> + * If @dinfo is null, do nothing.
>> + * Else if @fl's property "drive" is already set, fatal error.
>> + * Else set it to the BlockBackend with @dinfo.
>> + */
>> +void pflash_cfi01_legacy_drive(PFlashCFI01 *fl, DriveInfo *dinfo)
>> +{
>> +    Location loc;
>> +
>> +    if (!dinfo) {
>> +        return;
>> +    }
>> +
>> +    loc_push_none(&loc);
>> +    qemu_opts_loc_restore(dinfo->opts);
>> +    if (fl->blk) {
>> +        error_report("clashes with -machine");
>> +        exit(1);
>> +    }
>> +    qdev_prop_set_drive(DEVICE(fl), "drive",
>> +                        blk_by_legacy_dinfo(dinfo), &error_fatal);
>> +    loc_pop(&loc);
>> +}
>> +
>>  static void postload_update_cb(void *opaque, int running, RunState stat=
e)
>>  {
>>      PFlashCFI01 *pfl =3D opaque;
>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index 75925f5d3f..751fcafa12 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -269,9 +269,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
>>  {
>>      PCMachineClass *pcmc =3D PC_MACHINE_GET_CLASS(pcms);
>>      int i;
>> -    DriveInfo *pflash_drv;
>>      BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>> -    Location loc;
>>=20=20
>>      if (!pcmc->pci_enabled) {
>>          old_pc_system_rom_init(rom_memory, true);
>> @@ -280,18 +278,8 @@ void pc_system_firmware_init(PCMachineState *pcms,
>>=20=20
>>      /* Map legacy -drive if=3Dpflash to machine properties */
>>      for (i =3D 0; i < ARRAY_SIZE(pcms->flash); i++) {
>> -        pflash_drv =3D drive_get(IF_PFLASH, 0, i);
>> -        if (pflash_drv) {
>> -            loc_push_none(&loc);
>> -            qemu_opts_loc_restore(pflash_drv->opts);
>
> You can now remove the '#include "qemu/option.h"' in this file.

Nice.

> With that:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!
