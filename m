Received: from eggs.gnu.org ([209.51.188.92]:47147)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1sIc-0006pW-MJ
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:38:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1sIZ-0001yg-7i
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 07:38:57 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190227111347.15063-1-alex.bennee@linaro.org>
	<87r2bl5oah.fsf@dusky.pond.sub.org>
	<1a4d4fa0-3fd5-32ae-fcc3-dcd0376d0c28@redhat.com>
	<87sgvzezov.fsf@zen.linaroharston>
Date: Thu, 07 Mar 2019 13:38:31 +0100
In-Reply-To: <87sgvzezov.fsf@zen.linaroharston> ("Alex =?utf-8?Q?Benn?=
	=?utf-8?Q?=C3=A9e=22's?= message of
	"Thu, 07 Mar 2019 10:39:12 +0000")
Message-ID: <87ftrysvug.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5] hw/block: better reporting on pflash
 backing file mismatch
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:

> Laszlo Ersek <lersek@redhat.com> writes:
>
>> On 03/05/19 16:33, Markus Armbruster wrote:
>>> You neglected to cc: the maintainers of hw/block, I fixed that for you.
>>>
>>> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>>>
>>>> It looks like there was going to be code to check we had some sort of
>>>> alignment so lets replace it with an actual check. This is a bit more
>>>> useful than the enigmatic "failed to read the initial flash content"
>>>> when we attempt to read the number of bytes the device should have.
>>>>
>>>> This is a potential confusing stumbling block when you move from using
>>>> -bios to using -drive if=3Dpflash,file=3Dblob,format=3Draw,readonly for
>>>> loading your firmware code. To mitigate that we automatically pad in
>>>> the read-only case and warn the user when we have performed magic to
>>>> enable things to Just Work (tm).
>>>>
>>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>>>
>>> Philippe and I talked about various pflash issues last night.  He
>>> explained to me how physical flash memory works and is used.  This
>>> brought back my doubts on the wisdom of automatic padding.
>>>
>>> Errors in my recounting of his explanations are almost certainly
>>> entirely mine.  Please correct them.
>>>
>>> We're talking about NOR flash.  NAND flash works differently.
>>>
>>> You can:
>>>
>>> * Read a cell.
>>>
>>> * Write a cell: change it from 1 to 0.
>>>
>>> * Erase a whole sector (block): change all cells to 1.  This is slow,
>>>   burns power, and you can do it only so often before the flash wears
>>>   out
>>>
>>> Say your physical machine has 1 MiB of NOR flash in 16 sectors of 64 KiB
>>> each (unrealistic, as Philippe has pointed out elsewhere, but it'll do
>>> here).  You compile your firmware, and the build process spits out a
>>> flat image of 200000 bytes.  Here are a few distinct ways to deploy it
>>> to your freshly erased flash memory:
>>>
>>> (1) You write your image to the flash.  Everything after byte 200000
>>> remains writable.  This is nice for development.  With a bit of
>>> ingenuity, you can come up with a patching scheme that lets you avoid
>>> rewriting the whole flash for every little fix, saving flash wear.
>>>
>>> (2) You zero-pad your image to the full flash size, and write that to
>>> the flash.  Everything after byte 200000 becomes unwritable.  You can't
>>> erase the first 4 blocks (they hold your firmware), but you can still
>>> erase the remaining 12.
>>>
>>> (3) You zero-pad your image to the next sector boundary, and write that
>>> to the flash.  The remainder of block 4 becomes unwritable (and you
>>> can't erase the block without destroying your firmware).  The remaining
>>> 12 blocks remain writable.  This is commonly done for production,
>>> because it reduces the ways a sector holding code can be corrupted,
>>> making its checksum invalid.
>>>
>>> My point is: in the physical world, there is no single true way to pad.
>>>
>>> Back to your patch.  I think it conflates three changes:
>>>
>>> * We reject an undersized image with a sub-optimal error message.
>>>   Improve that message.
>>>
>>> * We silently ignore an oversized image's tail.  Warn instead.
>>>
>>> * As a convenience feature, don't reject undersized read-only image, but
>>>   pad it with 0xff instead, to simulate (1) above.
>>>
>>> Squashing the first two under a "better reporting on pflash backing file
>>> mismatch" heading seems fine to me.  The last one is not about "better
>>> reporting", and should therefore be a separate patch.
>>>
>>> I'm willing to do the split in the respin of my pflash fixes series.
>>>
>>> For the record, I'd summarily reject oversized images,
>>
>> Rejection is not a bad idea IMO; I don't remember any use case where the
>> user benefits from the acceptance of an oversized image (with or without
>> warning).
>
> Fair enough, I can just error out here.

Happy to do that for you if I should end up respinning this patch.

>>> and I'd drop the
>>> convenience feature, but I'm not the maintainer here.  It's up to Kevin
>>> and Max.
>>
>> Auto-padding can save some space wherever a raw image is provided, even
>> when QEMU is used through libvirt. It's not hugely important IMO but
>> nice to have. (Especially if we decide *not* to describe pflash block
>> count and size traits in the firmware descriptor files.)
>
> It's a potential point of confusion but we can just error out with a
> more useful error message. However we provide the convenience for -bios
> so why not on a read-only bios image?

I consider it a bad idea for -bios, too.

Perhaps more seriously, the block layer interferes with this patch's
padding.  -bios doesn't go through the block layer.  For details, please
see

    Subject: Re: [RFC PATCH v6 2/4] hw/block: Pad undersized read-only imag=
es with 0xFF
    Message-ID: <87h8cft2x6.fsf@dusky.pond.sub.org>

[...]
