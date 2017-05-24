Received: from eggs.gnu.org ([2001:4830:134:3::10]:47329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDNtc-0002T1-7w
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dDNta-0002KR-Ud
	for qemu-devel@nongnu.org; Wed, 24 May 2017 00:27:40 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170522211205.14265-14-hpoussin@reactos.org>
	<75ccc442-1a32-bf36-3674-ec69ce944213@amsat.org>
	<cf9a299e-1e02-6009-7579-3060874fc97e@reactos.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ba708af1-3532-fd98-55a9-399e419ef9e6@amsat.org>
Date: Wed, 24 May 2017 01:27:30 -0300
MIME-Version: 1.0
In-Reply-To: <cf9a299e-1e02-6009-7579-3060874fc97e@reactos.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 13/13] vvfat: change OEM name to
 'MSWIN4.1'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 05/23/2017 04:41 PM, Hervé Poussineau wrote:
> Hi Philippe,
>
> Le 23/05/2017 à 06:23, Philippe Mathieu-Daudé a écrit :
>> Hi Hervé,
>>
>> On 05/22/2017 06:12 PM, Hervé Poussineau wrote:
>>> According to specification:
>>> "'MSWIN4.1' is the recommanded setting, because it is the setting
>>> least likely
>>> to cause compatibility problems. If you want to put something else in
>>> here,
>>> that is your option, but the result may be that some FAT drivers
>>> might not
>>> recognize the volume."
>>
>> It also says "Typically this is some indication of what system formatted
>> the volume."
>>
>> From https://technet.microsoft.com/en-us/library/cc976796.aspx:
>>
>> "Following the jump instruction is the 8-byte OEM ID, a string of
>> characters that identifies the name and version number of the
>> operating system that formatted the volume. To preserve compatibility
>> with MS-DOS, Windows 2000 records "MSDOS5.0" in this field on FAT16
>> and FAT32 disks. On NTFS disks, Windows 2000 records "NTFS."
>> You may also see the OEM ID "MSWIN4.0" on disks formatted by Windows
>> 95 and "MSWIN4.1" on disks formatted by Windows 95 OSR2 and Windows
>> 98. Windows 2000 does not use the OEM ID field in the boot
>> sector except for verifying NTFS volumes."
>>
>> I'm curious which one is the most up-to-date, the specification v1.03
>> or a Windows 2000. Do you have an idea if there is more MSDOS/W2K vs
>> W95/98 users? Hopefully W95 is a Long time no see to me.
>>
>> You think having "QEMU" OEM does more harm than good?
>
> That's complicated. Indeed, OEM ID should be the name of the OS/tool
> which formatted the partition.
> However, some FAT drivers take different paths according to OEM ID.
> See for example:
> https://jdebp.eu/FGA/volume-boot-block-oem-name-field.html

"Linux (util-linux up to at least version 2.12) ... [first characters 
are QEMU] Treat the volume as unformatted" :facepalm:

> http://seasip.info./Misc/oemid.html
>
> So, in my opinion, it should be better to stick to some specification
> for the whole FAT format, so we have a reference document to know if
> there is a bug in the code or not.

Once explained, that's fine :) Can you add those references in the code? 
Eventually add a #define VOLUME_BOOT_BLOCKS_OEM_NAME with a fast 
explanation and those urls.

With that:
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> FAT specification 1.03 is dated December 6, 2000, while Windows 2000 has
> been released December 15, 1999, so both are around the same date.
> FAT specification gives all details about all disk structures, so I
> think that's better to stick to what it says.
>
> So to answer your question, and knowing the tricks played with OEM ID, I
> think that's better to use "MSWIN4.1" than "QEMU".
>
> Regards,
>
> Hervé
>
>>
>>>
>>> Specification: "FAT: General overview of on-disk format" v1.03, page 9
>>> Signed-off-by: Hervé Poussineau <hpoussin@reactos.org>
>>> ---
>>>  block/vvfat.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/block/vvfat.c b/block/vvfat.c
>>> index 53e8faa54c..1f7f46ecea 100644
>>> --- a/block/vvfat.c
>>> +++ b/block/vvfat.c
>>> @@ -1024,7 +1024,7 @@ static int init_directories(BDRVVVFATState* s,
>>>      bootsector->jump[0]=0xeb;
>>>      bootsector->jump[1]=0x3e;
>>>      bootsector->jump[2]=0x90;
>>> -    memcpy(bootsector->name,"QEMU    ",8);
>>> +    memcpy(bootsector->name, "MSWIN4.1", 8);
>>>      bootsector->sector_size=cpu_to_le16(0x200);
>>>      bootsector->sectors_per_cluster=s->sectors_per_cluster;
>>>      bootsector->reserved_sectors=cpu_to_le16(1);
>>>
>>
>> Regards,
>>
>> Phil.
>>
>
