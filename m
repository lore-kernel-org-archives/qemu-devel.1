Received: from eggs.gnu.org ([209.51.188.92]:56542)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1n2E-000522-Sm
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:01:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1n2E-0003KQ-4C
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 02:01:42 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-8-armbru@redhat.com>
	<87va15lds9.fsf@zen.linaroharston>
Date: Thu, 07 Mar 2019 08:01:35 +0100
In-Reply-To: <87va15lds9.fsf@zen.linaroharston> ("Alex =?utf-8?Q?Benn?=
	=?utf-8?Q?=C3=A9e=22's?= message of
	"Wed, 27 Feb 2019 10:35:34 +0000")
Message-ID: <87tvgfuq0g.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 07/11] ppc405_boards: Don't size flash
 memory to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com, David Gibson <david@gibson.dropbear.id.au>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Markus Armbruster <armbru@redhat.com> writes:
>
>> Machine "ref405ep" maps its flash memory at address 2^32 - image size.
>> Image size is rounded up to the next multiple of 64KiB.  Useless,
>> because pflash_cfi02_realize() fails with "failed to read the initial
>> flash content" unless the rounding is a no-op.
>>
>> If the image size exceeds 0x80000 Bytes, we overlap first SRAM, then
>> other stuff.  No idea how that would play out, but a useful outcomes
>> seem unlikely.
>>
>> Map the flash memory at fixed address 0xFFF80000 with size 512KiB,
>> regardless of image size, to match the physical hardware.
>>
>> Machine "taihu" maps its boot flash memory similarly.  The code even
>> has a comment /* XXX: should check that size is 2MB */, followed by
>> disabled code to adjust the size to 2MiB regardless of image size.
>>
>> Its code to map its application flash memory looks the same, except
>> there the XXX comment asks for 32MiB, and the code to adjust the size
>> isn't disabled.  Note that pflash_cfi02_realize() fails with "failed
>> to read the initial flash content" for images smaller than 32MiB.
>>
>> Map the boot flash memory at fixed address 0xFFE00000 with size 2MiB,
>> to match the physical hardware.  Delete dead code from application
>> flash mapping, and simplify some.
>
> It seems to me the DEBUG_BOARD_INIT code is probably out of date cruft
> that could be excised all together. But that doesn't stop this being
> useful:

David, would you like me to excise DEBUG_BOARD_INIT?

> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Thanks!
