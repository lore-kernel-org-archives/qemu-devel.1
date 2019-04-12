Received: from eggs.gnu.org ([209.51.188.92]:39222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEvG2-00032q-Ft
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEvG1-0002jY-Aw
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:26:14 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190411135602.21725-1-armbru@redhat.com>
	<20190411135602.21725-2-armbru@redhat.com>
	<0eea5ddb-1efb-8fdf-4a37-9bc2daf86e2b@redhat.com>
	<03fb5b6f-7d95-3b9b-3172-e37825402036@redhat.com>
	<8d6c1ced-1e7b-9e52-3afb-3fe1197f7a02@redhat.com>
	<87bm1br788.fsf@dusky.pond.sub.org>
Date: Fri, 12 Apr 2019 14:26:01 +0200
In-Reply-To: <87bm1br788.fsf@dusky.pond.sub.org> (Markus Armbruster's message
	of "Fri, 12 Apr 2019 09:52:07 +0200")
Message-ID: <87tvf3o1eu.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
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
To: Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Markus Armbruster <armbru@redhat.com> writes:

> Laszlo Ersek <lersek@redhat.com> writes:
[...]
>> In other words, we could have written the pre-patch (original) code like
>> this:
>>
>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>> index c6285407748e..ed6e713d0982 100644
>> --- a/hw/i386/pc_sysfw.c
>> +++ b/hw/i386/pc_sysfw.c
>> @@ -291,9 +291,10 @@ void pc_system_firmware_init(PCMachineState *pcms,
>>              error_report("clashes with -machine");
>>              exit(1);
>>          }
>> -        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
>>          qdev_prop_set_drive(DEVICE(pcms->flash[i]),
>> -                            "drive", pflash_blk[i], &error_fatal);
>> +                            "drive", blk_by_legacy_dinfo(pflash_drv),
>> +                            &error_fatal);
>> +        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>>          loc_pop(&loc);
>>      }
>>
>> and the behavior would have been identical.
>>
>> For the sake of QOM / blk dummies like me, can you please split this
>> refactoring to a separate patch, before extracting the new function?
>
> If you think a preparatory patch is called for, I'll create one.
>
> I'd have difficulties coming up with a commit message for the one you
> proposed.
>
> I append a patch I can describe.  Would it work for you?
>
>
>
> pc: Split pc_system_firmware_init()'s legacy -drive loop
>
> The loop does two things: map legacy -drive to properties, and collect
> all the backends for use after the loop.  The next patch will factor
> out the former for reuse in hw/arm/virt.c.  To make that easier, do
> each thing in its own loop.

Inserting here:

  Note that the first loop updates pcms->flash[i]->blk for -drive
  if=pflash with qdev_prop_set_drive().  The second loop gets the
  (possibly updated) value from pflash_cfi01_get_blk().

>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/i386/pc_sysfw.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index c628540774..90db9b57a4 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -269,6 +269,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  {
>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>      int i;
> +    BlockBackend *blk;
>      DriveInfo *pflash_drv;
>      BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>      Location loc;
> @@ -280,23 +281,26 @@ void pc_system_firmware_init(PCMachineState *pcms,
>  
>      /* Map legacy -drive if=pflash to machine properties */
>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> -        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
> +        blk = pflash_cfi01_get_blk(pcms->flash[i]);
>          pflash_drv = drive_get(IF_PFLASH, 0, i);
>          if (!pflash_drv) {
>              continue;
>          }
>          loc_push_none(&loc);
>          qemu_opts_loc_restore(pflash_drv->opts);
> -        if (pflash_blk[i]) {
> +        if (blk) {
>              error_report("clashes with -machine");
>              exit(1);
>          }
> -        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
> -        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
> -                            "drive", pflash_blk[i], &error_fatal);
> +        qdev_prop_set_drive(DEVICE(pcms->flash[i]), "drive",
> +                            blk_by_legacy_dinfo(pflash_drv), &error_fatal);
>          loc_pop(&loc);
>      }
>  
> +    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
> +        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);

Uh, this should be pflash_cfi01_get_blk(pcms->flash[i]) instead.

> +    }
> +
>      /* Reject gaps */
>      for (i = 1; i < ARRAY_SIZE(pcms->flash); i++) {
>          if (pflash_blk[i] && !pflash_blk[i - 1]) {
