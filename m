Received: from eggs.gnu.org ([209.51.188.92]:54725)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gwrdK-000444-D5
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:55:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1gwrdI-0004SR-IC
	for qemu-devel@nongnu.org; Thu, 21 Feb 2019 11:55:37 -0500
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-3-armbru@redhat.com>
	<2340eb1c-d8d8-3d92-bbb5-b541bb44dcba@redhat.com>
	<CAFEAcA9Pe3D=7r+3csriAZO8gkVkwypOBncZzkYTOCAujpKOsA@mail.gmail.com>
	<875ztfuc0j.fsf@dusky.pond.sub.org> <87sgwh5wef.fsf@dusky.pond.sub.org>
	<CAFEAcA8gHp-VD05x9Q1V3_K29wsMeZD1SdM+PDteOXcAE3QHwg@mail.gmail.com>
	<83b8edf2-8a4b-3d1b-bdde-63738ffb6479@redhat.com>
	<CAFEAcA_AnnNY9FcP0KOSy0VfobH3pMZkW-=qRy=MCQdC53yXQg@mail.gmail.com>
	<0d6a16d6-18c1-0a19-ea18-5c156fee717d@redhat.com>
	<967ce9a9-e970-7b24-d3d4-5862b1042166@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <dca693f6-dd82-2053-b495-e7ee2b0e9202@redhat.com>
Date: Thu, 21 Feb 2019 17:55:18 +0100
MIME-Version: 1.0
In-Reply-To: <967ce9a9-e970-7b24-d3d4-5862b1042166@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/10] pflash: Macro PFLASH_BUG() is used
 just once, expand
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Stefano Garzarella <sgarzare@redhat.com>

On 02/21/19 17:39, Philippe Mathieu-Daud=C3=A9 wrote:
> On 2/21/19 1:46 PM, Laszlo Ersek wrote:
>> On 02/21/19 13:38, Peter Maydell wrote:
>>> On Thu, 21 Feb 2019 at 12:07, Laszlo Ersek <lersek@redhat.com> wrote:
>>>> since we're talking "reset_flash", I'll note that there is no actual
>>>> reset handler for cfi.pflash01. I found out recently, via:
>>>>
>>>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1678713
>>>
>>> Yes; this isn't uncommon for some of the really old
>>> device models. It should definitely have one added.
>>>
>>> You are correct also that the timer in the pflash_cfi01
>>> model is dead code -- it has always been so, since the
>>> device was added in 2007. The reason it is there is that
>>> pflash_cfi01 was created as a copy-and-hack of the
>>> cfi02 device. In cfi02 we do use the timer, as a way
>>> of simulating "make full-chip and sector erases take a
>>> guest-visible amount of time rather than completing
>>> instantaneously". cfi01 doesn't do that (and I think
>>> may not implement anything other than block erase),
>=20
> This time is flash-device specific and is currently hardcoded.
>=20
> The guest learn from the CFI table how long it should wait
> before polling/accessing the flash, or take measures in case
> of timeout.
>=20
> We set these values in _realize():
>=20
>     ...
>     /* Typical timeout for block erase (512 ms) */
>     pfl->cfi_table[0x21] =3D 0x09;
>     /* Typical timeout for full chip erase (4096 ms) */
>     pfl->cfi_table[0x22] =3D 0x0C;
>     ...
>     /* Max timeout for block erase */
>     pfl->cfi_table[0x25] =3D 0x0A;
>     /* Max timeout for chip erase */
>     pfl->cfi_table[0x26] =3D 0x0D;
>=20
> The timer is triggered in _write(), where we use other hardcoded
> values (which are luckily in range with the CFI announced ones):
>=20
>         /* Let's wait 5 seconds before chip erase is done */
>         timer_mod(pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>                   (NANOSECONDS_PER_SECOND * 5));
>=20
>         /* Let's wait 1/2 second before sector erase is done */
>         timer_mod(pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>                   (NANOSECONDS_PER_SECOND / 2));
>=20
> When emulating embedded devices, it is very desirable to have those
> timers working, and I'd prefer we fix that on CFI01 rather than simply
> removing the unused timer.
>=20
> Now for the case of "Virt" machines, it is probably pointless to add
> flash delay and we should remove the timer use.

If the timer logic can be completed in such a way that existent OVMF
code sees no change at all, on the machine types that it currently runs
on (that is, on *unversioned* i440fx and q35), I'm OK with the idea.

Thanks,
Laszlo

>=20
>>> but the timer initialization code was left in rather
>>> than being deleted as part of the copy-and-hack.
>>
>> Thank you, I've linked this back into the RHBZ.
>>
>> Laszlo
>>
