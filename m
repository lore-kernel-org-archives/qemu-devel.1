Received: from eggs.gnu.org ([209.51.188.92]:37299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw5gr-000762-7c
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:44:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw5gq-0005Cu-BC
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 08:44:05 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-8-armbru@redhat.com>
	<816c0dd9-9213-cda9-2fa1-611c0cacf9a1@redhat.com>
Date: Tue, 19 Feb 2019 14:43:51 +0100
In-Reply-To: <816c0dd9-9213-cda9-2fa1-611c0cacf9a1@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue,
	19 Feb 2019 14:02:09 +0100")
Message-ID: <87h8czuc4o.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, qemu-block@nongnu.org, Aleksandar Rikalo <arikalo@wavecomp.com>, lersek@redhat.com, mreitz@redhat.com, qemu-ppc@nongnu.org, alex.bennee@linaro.org, Aurelien Jarno <aurelien@aurel32.net>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 2/18/19 1:56 PM, Markus Armbruster wrote:
>> pflash_cfi01_register() takes a size in bytes, a block size in bytes
>> and a number of blocks.  mips_malta_init() passes BIOS_SIZE, 65536,
>> FLASH_SIZE >> 16.  Actually consistent only because BIOS_SIZE (defined
>> in include/hw/mips/bios.h as (4 * MiB)) matches FLASH_SIZE (defined
>> locally as 0x400000).  Confusing all the same.
>>=20
>> Pass FLASH_SIZE instead of BIOS_SIZE.
>
> Your cleanup is correct.
>
>>=20
>> There are more uses of BIOS_SIZE, but I don't sufficiently understand
>> them to attempt cleanup.
>
> BIOS_SIZE is a MIPS architecture definition, incorrectly used around.
> This simply means "Top of 32bit address space - Boot Vector address".
> There is nothing wrong in plugging bigger/smaller flashes around the
> boot vector.
> (I have a series cleaning this definition, but I'm throttling my MIPS
> apports).
>
>>=20
>> Cc: Aurelien Jarno <aurelien@aurel32.net>
>> Cc: Aleksandar Rikalo <arikalo@wavecomp.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  hw/mips/mips_malta.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
>> index fff5ed19bd..65cdda4881 100644
>> --- a/hw/mips/mips_malta.c
>> +++ b/hw/mips/mips_malta.c
>> @@ -1269,12 +1269,12 @@ void mips_malta_init(MachineState *machine)
>>      if (dinfo) {
>>          printf("Register parallel flash %d size " TARGET_FMT_lx " at "
>>                 "addr %08llx '%s' %x\n",
>> -               fl_idx, bios_size, FLASH_ADDRESS,
>> +               fl_idx, FLASH_SIZE, FLASH_ADDRESS,
>>                 blk_name(dinfo->bdrv), fl_sectors);
>>      }
>>  #endif
>>      fl =3D pflash_cfi01_register(FLASH_ADDRESS, NULL, "mips_malta.bios",
>> -                               BIOS_SIZE,
>> +                               FLASH_SIZE,
>>                                 dinfo ? blk_by_legacy_dinfo(dinfo) : NUL=
L,
>>                                 65536, fl_sectors,
>>                                 4, 0x0000, 0x0000, 0x0000, 0x0000, be);
>>=20
>
> Does that mean you can remove the "hw/mips/bios.h" include now?

No, since there are more uses of BIOS_SIZE in this file.  They feel
inappropriate to me, but I don't feel confident enough to attempt
cleanup.

> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Thanks!
