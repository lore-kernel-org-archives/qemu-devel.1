Received: from eggs.gnu.org ([209.51.188.92]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1D0o-000228-Mo
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:33:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h1D0n-0008A7-OS
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:33:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41706)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h1D0n-000889-G8
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 11:33:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id n2so10178072wrw.8
	for <qemu-devel@nongnu.org>; Tue, 05 Mar 2019 08:33:48 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-10-armbru@redhat.com>
	<87pnrdlbc6.fsf@zen.linaroharston>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <41974cb8-00e5-8ec0-eba9-74d7c06af340@redhat.com>
Date: Tue, 5 Mar 2019 17:33:46 +0100
MIME-Version: 1.0
In-Reply-To: <87pnrdlbc6.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/11] mips_malta: Clean up definition
 of flash memory size somewhat
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com, Aurelien Jarno <aurelien@aurel32.net>

On 2/27/19 12:28 PM, Alex Bennée wrote:
> Markus Armbruster <armbru@redhat.com> writes:
> 
>> pflash_cfi01_register() takes a size in bytes, a block size in bytes
>> and a number of blocks.  mips_malta_init() passes BIOS_SIZE, 65536,
>> FLASH_SIZE >> 16.  Actually consistent only because BIOS_SIZE (defined
>> in include/hw/mips/bios.h as (4 * MiB)) matches FLASH_SIZE (defined
>> locally as 0x400000).  Confusing all the same.
>>
>> Pass FLASH_SIZE instead of BIOS_SIZE.
>>
>> There are more uses of BIOS_SIZE, but I don't sufficiently understand
>> them to attempt cleanup.
>>
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/mips/mips_malta.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>> index 172ee033af..c2a5c65a24 100644
>> --- a/hw/mips/mips_malta.c
>> +++ b/hw/mips/mips_malta.c
>> @@ -1269,12 +1269,12 @@ void mips_malta_init(MachineState *machine)
>>      if (dinfo) {
>>          printf("Register parallel flash %d size " TARGET_FMT_lx " at "
>>                 "addr %08llx '%s' %x\n",
>> -               fl_idx, bios_size, FLASH_ADDRESS,
>> +               fl_idx, FLASH_SIZE, FLASH_ADDRESS,
> 
> bios_size == FLASH_SIZE at this point, but is then overwritten later in
> the function *if* the flash is loaded (and not already set via a dinfo).
> I'd say you could move bios_size down to were it's used but then you
> confused the byte swapping machinery which expects something to be set.
> 
> All that said these changes so far are not wrong:
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>

I reworked Markus patch and sent as a new series:
https://lists.gnu.org/archive/html/qemu-devel/2019-03/msg01149.html
but forgot to Cc you, and forgot your R-b :/

> 
> 
>>                 blk_name(dinfo->bdrv), fl_sectors);
>>      }
>>  #endif
>>      fl = pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
>> -                               BIOS_SIZE,
>> +                               FLASH_SIZE,
>>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
>>                                 65536, fl_sectors,
>>                                 4, 0x0000, 0x0000, 0x0000, 0x0000, be);
> 
> 
> --
> Alex Bennée
> 
