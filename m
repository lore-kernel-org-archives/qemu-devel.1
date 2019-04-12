Received: from eggs.gnu.org ([209.51.188.92]:42069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEvOv-0003a6-Rb
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:35:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hEvOu-0001OQ-T2
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 08:35:25 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20190411135602.21725-1-armbru@redhat.com>
	<20190411135602.21725-3-armbru@redhat.com>
	<95f2e6d2-5bd0-a9dc-ab4b-dc172e7f1ad1@redhat.com>
Date: Fri, 12 Apr 2019 14:35:12 +0200
In-Reply-To: <95f2e6d2-5bd0-a9dc-ab4b-dc172e7f1ad1@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Thu,
	11 Apr 2019 16:35:13 +0200")
Message-ID: <87mukvo0zj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/arm/virt: Support firmware
 configuration with -blockdev
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

> On 4/11/19 3:56 PM, Markus Armbruster wrote:
>> The ARM virt machines put firmware in flash memory.  To configure it,
>> you use -drive if=3Dpflash,unit=3D0,... and optionally -drive
>> if=3Dpflash,unit=3D1,...
>>=20
>> Why two -drive?  This permits setting up one part of the flash memory
>> read-only, and the other part read/write.  It also makes upgrading
>> firmware on the host easier.  Below the hood, we get two separate
>> flash devices, because we were too lazy to improve our flash device
>> models to support sector protection.
>>=20
>> The problem at hand is to do the same with -blockdev somehow, as one
>> more step towards deprecating -drive.
>>=20
>> We recently solved this problem for x86 PC machines, in commit
>> ebc29e1beab.  See the commit message for design rationale.
>>=20
>> This commit solves it for ARM virt basically the same way: new machine
>> properties pflash0, pflash1 forward to the onboard flash devices'
>> properties.  Requires creating the onboard devices in the
>> .instance_init() method virt_instance_init().  The existing code to
>> pick up drives defined with -drive if=3Dpflash is replaced by code to
>> desugar into the machine properties.
>>=20
>> There are a few behavioral differences, though:
>>=20
>> * The flash devices are always present (x86: only present if
>>   configured)
>>=20
>> * Flash base addresses and sizes are fixed (x86: sizes depend on
>>   images, mapped back to back below a fixed address)
>>=20
>> * -bios configures contents of first pflash (x86: -bios configures ROM
>>    contents)
>>=20
>> * -bios is rejected when first pflash is also configured with -machine
>>    pflash0=3D... (x86: bios is silently ignored then)
>
> Can we start deprecating the -bios command line option?
>
> Maybe on a per-architecture basis first.

I have no idea.

Perhaps we want to keep it as syntactic sugar for convenience.  Right
now it's something else: an ugly special case.

Of course, the name -bios is a bit PC-centric.  And even there it makes
less sense than it used to.

[...]
