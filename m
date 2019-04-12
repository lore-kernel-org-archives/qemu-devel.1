Received: from eggs.gnu.org ([209.51.188.92]:37877)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEqz0-0008UC-Ch
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEqyy-0001X8-Dn
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 03:52:22 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190411135602.21725-1-armbru@redhat.com>
	<20190411135602.21725-2-armbru@redhat.com>
	<0eea5ddb-1efb-8fdf-4a37-9bc2daf86e2b@redhat.com>
	<03fb5b6f-7d95-3b9b-3172-e37825402036@redhat.com>
	<8d6c1ced-1e7b-9e52-3afb-3fe1197f7a02@redhat.com>
Date: Fri, 12 Apr 2019 09:52:07 +0200
In-Reply-To: <8d6c1ced-1e7b-9e52-3afb-3fe1197f7a02@redhat.com> (Laszlo Ersek's
	message of "Thu, 11 Apr 2019 22:04:53 +0200")
Message-ID: <87bm1br788.fsf@dusky.pond.sub.org>
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
To: Laszlo Ersek <lersek@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-block@nongnu.org, mreitz@redhat.com

Laszlo Ersek <lersek@redhat.com> writes:

> On 04/11/19 21:50, Laszlo Ersek wrote:
>> On 04/11/19 21:35, Laszlo Ersek wrote:
>>> On 04/11/19 15:56, Markus Armbruster wrote:
>>>> Factored out of pc_system_firmware_init() so the next commit can reuse
>>>> it in hw/arm/virt.c.
>>>>
>>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>>> ---
>>>>  hw/block/pflash_cfi01.c  | 30 ++++++++++++++++++++++++++++++
>>>>  hw/i386/pc_sysfw.c       | 19 ++-----------------
>>>>  include/hw/block/flash.h |  1 +
>>>>  3 files changed, 33 insertions(+), 17 deletions(-)
>>>>
>>>> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
>>>> index 16dfae14b8..eba01b1447 100644
>>>> --- a/hw/block/pflash_cfi01.c
>>>> +++ b/hw/block/pflash_cfi01.c
>>>> @@ -44,9 +44,12 @@
>>>>  #include "qapi/error.h"
>>>>  #include "qemu/timer.h"
>>>>  #include "qemu/bitops.h"
>>>> +#include "qemu/error-report.h"
>>>>  #include "qemu/host-utils.h"
>>>>  #include "qemu/log.h"
>>>> +#include "qemu/option.h"
>>>>  #include "hw/sysbus.h"
>>>> +#include "sysemu/blockdev.h"
>>>>  #include "sysemu/sysemu.h"
>>>>  #include "trace.h"
>>>>  
>>>> @@ -968,6 +971,33 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
>>>>      return &fl->mem;
>>>>  }
>>>>  
>>>> +/*
>>>> + * Handle -drive if=pflash for machines that use machine properties.
>>>
>>> (1) Can we improve readability with quotes? "-drive if=pflash"

Sure.

>>>> + * Map unit#i (0 < i <= @ndev) to @dev[i]'s property "drive".
>>>
>>> (2) I think you meant (0 <= i < @ndev)

You're right, of course.

>>>> + */
>>>> +void pflash_cfi01_legacy_drive(PFlashCFI01 *dev[], int ndev)
>>>> +{
>>>> +    int i;
>>>
>>> (3) For utter pedantry, "ndev"  and "i" should have type "size_t" (in
>>> particular because we expect the caller to fill "ndev" with ARRAY_SIZE().
>>>
>>> But, this would go beyond refactoring -- the original "int"s have served
>>> us just fine, and we're usually counting up (exclusively) to the huge
>>> number... two. :)

Exactly!

>>>> +    DriveInfo *dinfo;
>>>> +    Location loc;
>>>> +
>>>> +    for (i = 0; i < ndev; i++) {
>>>> +        dinfo = drive_get(IF_PFLASH, 0, i);
>>>> +        if (!dinfo) {
>>>> +            continue;
>>>> +        }
>>>> +        loc_push_none(&loc);
>>>> +        qemu_opts_loc_restore(dinfo->opts);
>>>> +        if (dev[i]->blk) {
>>>
>>> (4) Is this really identical to the code being removed? The above
>>> controlling expression amounts to:
>>>
>>>   pcms->flash[i]->blk
>>>
>>> but the original boils down to
>>>
>>>   pflash_cfi01_get_blk(pcms->flash[i])
>>>
>>> Hmm... looking at pflash_cfi01_get_blk(), they are the same. Is there a
>>> particular reason for not using the wrapper function any longer? As in:
>>>
>>>   pflash_cfi01_get_blk(dev[i])

I don't see the benefit in abstracting from the member access.

If I could have ->blk outside pflash_cfi01.c without having to expose
all of PFlashCFI01, and have it read-only, I would.  But this is C, so I
get to write yet another accessor function.

>>>> +            error_report("clashes with -machine");
>>>> +            exit(1);
>>>> +        }
>>>> +        qdev_prop_set_drive(DEVICE(dev[i]), "drive",
>>>> +                            blk_by_legacy_dinfo(dinfo), &error_fatal);
>>>> +        loc_pop(&loc);
>>>> +    }
>>>> +}
>>>> +
>>>>  static void postload_update_cb(void *opaque, int running, RunState state)
>>>>  {
>>>>      PFlashCFI01 *pfl = opaque;
>>>> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
>>>> index c628540774..d58e47184c 100644
>>>> --- a/hw/i386/pc_sysfw.c
>>>> +++ b/hw/i386/pc_sysfw.c
>>>> @@ -269,32 +269,17 @@ void pc_system_firmware_init(PCMachineState *pcms,
>>>>  {
>>>>      PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>>>>      int i;
>>>> -    DriveInfo *pflash_drv;
>>>>      BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
>>>> -    Location loc;
>>>>  
>>>>      if (!pcmc->pci_enabled) {
>>>>          old_pc_system_rom_init(rom_memory, true);
>>>>          return;
>>>>      }
>>>>  
>>>> -    /* Map legacy -drive if=pflash to machine properties */
>>>> +    pflash_cfi01_legacy_drive(pcms->flash, ARRAY_SIZE(pcms->flash));
>>>> +
>>>>      for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
>>>>          pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>>>> -        pflash_drv = drive_get(IF_PFLASH, 0, i);
>>>> -        if (!pflash_drv) {
>>>> -            continue;
>>>> -        }
>>>> -        loc_push_none(&loc);
>>>> -        qemu_opts_loc_restore(pflash_drv->opts);
>>>> -        if (pflash_blk[i]) {
>>>> -            error_report("clashes with -machine");
>>>> -            exit(1);
>>>> -        }
>>>> -        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
>>>> -        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
>>>> -                            "drive", pflash_blk[i], &error_fatal);
>>>> -        loc_pop(&loc);
>>>>      }
>>>
>>> (5) I think you deleted too much here. After this loop, post-patch, for
>>> all "i", we'll have
>>>
>>>   pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>>>
>>> But pre-patch, for all "i" where the "continue" didn't fire, we'd end up
>>> with:
>>>
>>>   pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
>>>
>>> IOW the original loop both verifies and *collects*, for the gap check
>>> that comes just below.
>>>
>>> IIRC, this allows for mixing "-drive if=pflash,unit=N" with the machine
>>> properties, as long as you have neither conflicts, nor gaps.
>>>
>>> Post-patch however, this kind of mixing would break, because we'd report
>>> gaps for the legacy ("-drive if=pflash") options.
>>>
>>>
>>> In addition, it could break the "use ROM mode" branch below, which is
>>> based on pflash_blk[0].
>>>
>>> I think we should extend pflash_cfi01_legacy_drive() to populate
>>> "pflash_blk[0..(ndev-1)]" on output (assuming pflash_blk is not NULL on
>>> input).
>>>
>>> (Because, I'm assuming that qdev_prop_set_drive() -- which now occurs in
>>> the factored-out loop *before* the loop that we preserve here -- has no
>>> effect on pflash_cfi01_get_blk(pcms->flash[i]).)
>> 
>> Hmmm, that's likely precisely what I'm wrong about. I've now looked at
>> DEFINE_PROP_DRIVE / qdev_prop_drive / set_drive / parse_drive... Does
>> qdev_prop_set_drive() actually *turn* the legacy options into genuine
>> machine type properties?... The removed comment does indicate that:
>> 
>>   "Map legacy -drive if=pflash to machine properties"
>> 
>> So I guess the remaining loop is correct after all, but the new comment
>> 
>>   "Handle -drive if=pflash for machines that use machine properties"
>> 
>> is less clear to me.

In my defense, the complete new comment is

    /*
     * Handle -drive if=pflash for machines that use machine properties.
     * Map unit#i (0 < i <= @ndev) to @dev[i]'s property "drive".
     */

> OK, OK. I'm being dense. I guess the case is that
>
>   qdev_prop_set_drive(DEVICE(dev[i]), "drive",
>                       blk_by_legacy_dinfo(dinfo), &error_fatal);
>
> in the new function basically *assigns* a non-NULL value to
>
>   dev[i]->blk
>
> which was checked to be NULL just before.

Correct!

Aside: the workings of qdev_prop_set_drive() used to be reasonably
obvious until we rebased qdev onto QOM.  Since then it involves a
conversion to string, a detour through QOM infrastructure, which (among
other things) converts the string right back.  Progress!

> ... This is incredibly non-intuitive, especially given that the
> pre-patch code performed a *similar* assignment explicitly :(

So, here's my thinking process that led to this patch.

To make ARM virt work, I gave myself permission to copy code from x86
without thinking about code duplication.  Once it worked, I checked what
I actually copied.  Just this loop:

    /* Map legacy -drive if=pflash to machine properties */
    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
        pflash_drv = drive_get(IF_PFLASH, 0, i);
        if (!pflash_drv) {
            continue;
        }
        loc_push_none(&loc);
        qemu_opts_loc_restore(pflash_drv->opts);
        if (pflash_blk[i]) {
            error_report("clashes with -machine");
            exit(1);
        }
        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
                            "drive", pflash_blk[i], &error_fatal);
        loc_pop(&loc);
    }

The easy de-dupe is to put it in a fuction like this (just for
illustration, not even compile-tested):

    void pflash_cfi01_legacy_drive(PFlashCFI01 *dev[], int ndev,
                                   BlockBackend blk[])
    {
        int i;
        DriveInfo *dinfo;
        Location loc;

        // the original loop with pcms->flash replaced by dev,
        // pflash_blk by blk, pflash_cfi01_get_blk(dev[i]) by
        // dev[i]->blk, and (for good measure) pflash_drv by
        // dinfo:
        for (i = 0; i < ndev; i++) {
            blk[i] = dev[i]->blk;
            dinfo = drive_get(IF_PFLASH, 0, i);
            if (!dinfo) {
                continue;
            }
            loc_push_none(&loc);
            qemu_opts_loc_restore(dinfo->opts);
            if (blk[i]) {
                error_report("clashes with -machine");
                exit(1);
            }
            blk[i] = blk_by_legacy_dinfo(dinfo);
            qdev_prop_set_drive(DEVICE(dev[i]),
                                "drive", blk[i], &error_fatal);
            loc_pop(&loc);
        }
    }

Called like

        pflash_cfi01_legacy_drive(pcms->flash, ARRAY_SIZE(pcms->flash),
                                  pflash_blk);

The last parameter is awkward.  If you doubt me, try writing a contract.
Further evidence: the ARM virt caller only ever uses blk[0].

The awkwardness is cause by the original loop doing two things: map
legacy -drive to properties, and collect all the BlockBackends for use
after the loop.

Better factor just the former out of the loop:

        pflash_cfi01_legacy_drive(pcms->flash, ARRAY_SIZE(pcms->flash));

        for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
            pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
        }

Now transform pflash_cfi01_legacy_drive().  First step: replace the last
parameter by a local variable:

        BlockBackend *blk[ndev];

Variable length array, no good.  But since its only use is blk[i] in the
loop, we can collapse it to just

        BlockBackend *blk;

used like this:

        for (i = 0; i < ndev; i++) {
            blk = dev[i]->blk;
            dinfo = drive_get(IF_PFLASH, 0, i);
            if (!dinfo) {
                continue;
            }
            loc_push_none(&loc);
            qemu_opts_loc_restore(dinfo->opts);
            if (blk) {
                error_report("clashes with -machine");
                exit(1);
            }
            blk = blk_by_legacy_dinfo(dinfo);
            qdev_prop_set_drive(DEVICE(dev[i]),
                                "drive", blk, &error_fatal);
            loc_pop(&loc);
        }

Note that each of the two assignments to blk is used just once.  Meh.
Eliminate the variable:

        for (i = 0; i < ndev; i++) {
            dinfo = drive_get(IF_PFLASH, 0, i);
            if (!dinfo) {
                continue;
            }
            loc_push_none(&loc);
            qemu_opts_loc_restore(dinfo->opts);
            if (dev[i]->blk) {
                error_report("clashes with -machine");
                exit(1);
            }
            qdev_prop_set_drive(DEVICE(dev[i]), "drive",
                                blk_by_legacy_dinfo(dinfo), &error_fatal);
            loc_pop(&loc);
        }

And this is exactly what's in my patch.

> In other words, we could have written the pre-patch (original) code like
> this:
>
> diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
> index c6285407748e..ed6e713d0982 100644
> --- a/hw/i386/pc_sysfw.c
> +++ b/hw/i386/pc_sysfw.c
> @@ -291,9 +291,10 @@ void pc_system_firmware_init(PCMachineState *pcms,
>              error_report("clashes with -machine");
>              exit(1);
>          }
> -        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
>          qdev_prop_set_drive(DEVICE(pcms->flash[i]),
> -                            "drive", pflash_blk[i], &error_fatal);
> +                            "drive", blk_by_legacy_dinfo(pflash_drv),
> +                            &error_fatal);
> +        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
>          loc_pop(&loc);
>      }
>
> and the behavior would have been identical.
>
> For the sake of QOM / blk dummies like me, can you please split this
> refactoring to a separate patch, before extracting the new function?

If you think a preparatory patch is called for, I'll create one.

I'd have difficulties coming up with a commit message for the one you
proposed.

I append a patch I can describe.  Would it work for you?



pc: Split pc_system_firmware_init()'s legacy -drive loop

The loop does two things: map legacy -drive to properties, and collect
all the backends for use after the loop.  The next patch will factor
out the former for reuse in hw/arm/virt.c.  To make that easier, do
each thing in its own loop.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/i386/pc_sysfw.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/i386/pc_sysfw.c b/hw/i386/pc_sysfw.c
index c628540774..90db9b57a4 100644
--- a/hw/i386/pc_sysfw.c
+++ b/hw/i386/pc_sysfw.c
@@ -269,6 +269,7 @@ void pc_system_firmware_init(PCMachineState *pcms,
 {
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
     int i;
+    BlockBackend *blk;
     DriveInfo *pflash_drv;
     BlockBackend *pflash_blk[ARRAY_SIZE(pcms->flash)];
     Location loc;
@@ -280,23 +281,26 @@ void pc_system_firmware_init(PCMachineState *pcms,
 
     /* Map legacy -drive if=pflash to machine properties */
     for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
-        pflash_blk[i] = pflash_cfi01_get_blk(pcms->flash[i]);
+        blk = pflash_cfi01_get_blk(pcms->flash[i]);
         pflash_drv = drive_get(IF_PFLASH, 0, i);
         if (!pflash_drv) {
             continue;
         }
         loc_push_none(&loc);
         qemu_opts_loc_restore(pflash_drv->opts);
-        if (pflash_blk[i]) {
+        if (blk) {
             error_report("clashes with -machine");
             exit(1);
         }
-        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
-        qdev_prop_set_drive(DEVICE(pcms->flash[i]),
-                            "drive", pflash_blk[i], &error_fatal);
+        qdev_prop_set_drive(DEVICE(pcms->flash[i]), "drive",
+                            blk_by_legacy_dinfo(pflash_drv), &error_fatal);
         loc_pop(&loc);
     }
 
+    for (i = 0; i < ARRAY_SIZE(pcms->flash); i++) {
+        pflash_blk[i] = blk_by_legacy_dinfo(pflash_drv);
+    }
+
     /* Reject gaps */
     for (i = 1; i < ARRAY_SIZE(pcms->flash); i++) {
         if (pflash_blk[i] && !pflash_blk[i - 1]) {
-- 
2.17.2
