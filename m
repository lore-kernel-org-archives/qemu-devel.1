Received: from eggs.gnu.org ([209.51.188.92]:43441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw7yJ-0004uN-1y
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:10:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw7yG-0001Gt-Mu
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:10:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:33413)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw7yG-0001Be-ET
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 11:10:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id h22so2614160wmb.0
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 08:10:10 -0800 (PST)
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-8-armbru@redhat.com>
	<816c0dd9-9213-cda9-2fa1-611c0cacf9a1@redhat.com>
	<87h8czuc4o.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5ad8a795-0db7-4fe6-d30f-01776475f0c5@redhat.com>
Date: Tue, 19 Feb 2019 17:10:07 +0100
MIME-Version: 1.0
In-Reply-To: <87h8czuc4o.fsf@dusky.pond.sub.org>
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
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>, lersek@redhat.com, mreitz@redhat.com, qemu-ppc@nongnu.org, alex.bennee@linaro.org, Aurelien Jarno <aurelien@aurel32.net>

On 2/19/19 2:43 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daudé <philmd@redhat.com> writes:
> 
>> On 2/18/19 1:56 PM, Markus Armbruster wrote:
>>> pflash_cfi01_register() takes a size in bytes, a block size in bytes
>>> and a number of blocks.  mips_malta_init() passes BIOS_SIZE, 65536,
>>> FLASH_SIZE >> 16.  Actually consistent only because BIOS_SIZE (defined
>>> in include/hw/mips/bios.h as (4 * MiB)) matches FLASH_SIZE (defined
>>> locally as 0x400000).  Confusing all the same.
>>>
>>> Pass FLASH_SIZE instead of BIOS_SIZE.
>>
>> Your cleanup is correct.
>>
>>>
>>> There are more uses of BIOS_SIZE, but I don't sufficiently understand
>>> them to attempt cleanup.
>>
>> BIOS_SIZE is a MIPS architecture definition, incorrectly used around.
>> This simply means "Top of 32bit address space - Boot Vector address".
>> There is nothing wrong in plugging bigger/smaller flashes around the
>> boot vector.
>> (I have a series cleaning this definition, but I'm throttling my MIPS
>> apports).
>>
>>>
>>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>>> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
>>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>>> ---
>>>  hw/mips/mips_malta.c | 4 ++--
>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>>> index fff5ed19bd..65cdda4881 100644
>>> --- a/hw/mips/mips_malta.c
>>> +++ b/hw/mips/mips_malta.c
>>> @@ -1269,12 +1269,12 @@ void mips_malta_init(MachineState *machine)
>>>      if (dinfo) {
>>>          printf("Register parallel flash %d size " TARGET_FMT_lx " at "
>>>                 "addr %08llx '%s' %x\n",
>>> -               fl_idx, bios_size, FLASH_ADDRESS,
>>> +               fl_idx, FLASH_SIZE, FLASH_ADDRESS,
>>>                 blk_name(dinfo->bdrv), fl_sectors);
>>>      }
>>>  #endif
>>>      fl = pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
>>> -                               BIOS_SIZE,
>>> +                               FLASH_SIZE,
>>>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>>>                                 65536, fl_sectors,
>>>                                 4, 0x0000, 0x0000, 0x0000, 0x0000, be);
>>>
>>
>> Does that mean you can remove the "hw/mips/bios.h" include now?
> 
> No, since there are more uses of BIOS_SIZE in this file.  They feel
> inappropriate to me, but I don't feel confident enough to attempt
> cleanup.

OK, since I already did it twice, I'll do it once your work get merged.

> 
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> 
> Thanks!
> 
