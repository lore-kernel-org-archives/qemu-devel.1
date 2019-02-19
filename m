Received: from eggs.gnu.org ([209.51.188.92]:39443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw7jn-0001wV-LY
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:55:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gw7jm-0000XQ-TC
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 10:55:15 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-6-armbru@redhat.com>
	<alpine.BSF.2.21.9999.1902191623570.24309@zero.eik.bme.hu>
Date: Tue, 19 Feb 2019 16:55:01 +0100
In-Reply-To: <alpine.BSF.2.21.9999.1902191623570.24309@zero.eik.bme.hu>
	(BALATON Zoltan's message of "Tue, 19 Feb 2019 16:28:04 +0100 (CET)")
Message-ID: <87tvgzrcx6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH 05/10] ppc405_boards: Don't size
 flash memory to match backing image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, lersek@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, qemu-ppc@nongnu.org, alex.bennee@linaro.org, David Gibson <david@gibson.dropbear.id.au>

BALATON Zoltan <balaton@eik.bme.hu> writes:

> On Mon, 18 Feb 2019, Markus Armbruster wrote:
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
>
> If PPC405 behaves the same as PPC440 and starts at 0xfffffffc then
> this won't boot. It's maybe better to keep 2^32 - image_size but
> assert image is not bigger than 512kB. But I don't know anything about
> these boards so just sharing this comment for your consideration. I'm
> fine with any decision you take.

If the image is smaller than 512KiB, pflash_cfi02_realize() fails with
"failed to read the initial flash content".

Alex Benn=C3=A9e has a patch that'll make it fail for any size mismatch, wi=
th
a much nicer error message.  I like it; silently truncating firmware
images is unlikely to be useful.

For what it's worth, my patch brings this board into line with most
other boards: create flash memory of fixed size at a fixed address,
matching the physical machine we emulate.
