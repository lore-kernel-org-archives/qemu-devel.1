Received: from eggs.gnu.org ([2001:4830:134:3::10]:55241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dDFgt-0005xb-3X
	for qemu-devel@nongnu.org; Tue, 23 May 2017 15:42:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hpoussin@reactos.org>) id 1dDFgp-0000JH-4G
	for qemu-devel@nongnu.org; Tue, 23 May 2017 15:41:59 -0400
References: <20170522211205.14265-1-hpoussin@reactos.org>
	<20170522211205.14265-14-hpoussin@reactos.org>
	<75ccc442-1a32-bf36-3674-ec69ce944213@amsat.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <cf9a299e-1e02-6009-7579-3060874fc97e@reactos.org>
Date: Tue, 23 May 2017 21:41:29 +0200
MIME-Version: 1.0
In-Reply-To: <75ccc442-1a32-bf36-3674-ec69ce944213@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
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
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Hi Philippe,

Le 23/05/2017 =C3=A0 06:23, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit :
> Hi Herv=C3=A9,
>
> On 05/22/2017 06:12 PM, Herv=C3=A9 Poussineau wrote:
>> According to specification:
>> "'MSWIN4.1' is the recommanded setting, because it is the setting leas=
t likely
>> to cause compatibility problems. If you want to put something else in =
here,
>> that is your option, but the result may be that some FAT drivers might=
 not
>> recognize the volume."
>
> It also says "Typically this is some indication of what system formatte=
d
> the volume."
>
> From https://technet.microsoft.com/en-us/library/cc976796.aspx:
>
> "Following the jump instruction is the 8-byte OEM ID, a string of chara=
cters that identifies the name and version number of the operating system=
 that formatted the volume. To preserve compatibility
> with MS-DOS, Windows 2000 records "MSDOS5.0" in this field on FAT16 and=
 FAT32 disks. On NTFS disks, Windows 2000 records "NTFS."
> You may also see the OEM ID "MSWIN4.0" on disks formatted by Windows 95=
 and "MSWIN4.1" on disks formatted by Windows 95 OSR2 and Windows 98. Win=
dows 2000 does not use the OEM ID field in the boot
> sector except for verifying NTFS volumes."
>
> I'm curious which one is the most up-to-date, the specification v1.03 o=
r a Windows 2000. Do you have an idea if there is more MSDOS/W2K vs W95/9=
8 users? Hopefully W95 is a Long time no see to me.
>
> You think having "QEMU" OEM does more harm than good?

That's complicated. Indeed, OEM ID should be the name of the OS/tool whic=
h formatted the partition.
However, some FAT drivers take different paths according to OEM ID.
See for example:
https://jdebp.eu/FGA/volume-boot-block-oem-name-field.html
http://seasip.info./Misc/oemid.html

So, in my opinion, it should be better to stick to some specification for=
 the whole FAT format, so we have a reference document to know if there i=
s a bug in the code or not.
FAT specification 1.03 is dated December 6, 2000, while Windows 2000 has =
been released December 15, 1999, so both are around the same date.
FAT specification gives all details about all disk structures, so I think=
 that's better to stick to what it says.

So to answer your question, and knowing the tricks played with OEM ID, I =
think that's better to use "MSWIN4.1" than "QEMU".

Regards,

Herv=C3=A9

>
>>
>> Specification: "FAT: General overview of on-disk format" v1.03, page 9
>> Signed-off-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
>> ---
>>  block/vvfat.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/block/vvfat.c b/block/vvfat.c
>> index 53e8faa54c..1f7f46ecea 100644
>> --- a/block/vvfat.c
>> +++ b/block/vvfat.c
>> @@ -1024,7 +1024,7 @@ static int init_directories(BDRVVVFATState* s,
>>      bootsector->jump[0]=3D0xeb;
>>      bootsector->jump[1]=3D0x3e;
>>      bootsector->jump[2]=3D0x90;
>> -    memcpy(bootsector->name,"QEMU    ",8);
>> +    memcpy(bootsector->name, "MSWIN4.1", 8);
>>      bootsector->sector_size=3Dcpu_to_le16(0x200);
>>      bootsector->sectors_per_cluster=3Ds->sectors_per_cluster;
>>      bootsector->reserved_sectors=3Dcpu_to_le16(1);
>>
>
> Regards,
>
> Phil.
>
