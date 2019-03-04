Received: from eggs.gnu.org ([209.51.188.92]:52468)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <magnus.damm@gmail.com>) id 1h0ffe-0005pW-Cv
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 23:57:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <magnus.damm@gmail.com>) id 1h0ffd-0001Pa-B4
	for qemu-devel@nongnu.org; Sun, 03 Mar 2019 23:57:46 -0500
MIME-Version: 1.0
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-7-armbru@redhat.com>
	<CAFEAcA_OLYno=YNS6bHOemwEp0gnc3fwRn8Rjvmo9v-i89xrMA@mail.gmail.com>
	<87d0nnsrx0.fsf@dusky.pond.sub.org>
	<c6d4c021-8d62-ada0-d152-b1d4f2b7aff2@redhat.com>
	<87ftsjptxk.fsf@dusky.pond.sub.org>
In-Reply-To: <87ftsjptxk.fsf@dusky.pond.sub.org>
From: Magnus Damm <magnus.damm@gmail.com>
Date: Mon, 4 Mar 2019 13:57:29 +0900
Message-ID: <CANqRtoSOF8uvh-9-_CgsuhB_N18NhSiS=DPsY1+3+ff4NzgE+w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 06/10] r2d: Flash memory creation is
 confused about size, mark FIXME
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>

Hi guys,

On Wed, Feb 20, 2019 at 2:31 AM Markus Armbruster <armbru@redhat.com> wrote=
:
>
> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>
> > On 2/19/19 4:45 PM, Markus Armbruster wrote:
> >> Peter Maydell <peter.maydell@linaro.org> writes:
> >>
> >>> On Mon, 18 Feb 2019 at 13:07, Markus Armbruster <armbru@redhat.com> w=
rote:
> >>>>
> >>>> pflash_cfi02_register() takes a size in bytes, a block size in bytes
> >>>> and a number of blocks.  r2d_init() passes FLASH_SIZE, 16 * KiB,
> >>>> FLASH_SIZE >> 16.  Does not compute: size doesn't match block size *
> >>>> number of blocks.  The latter happens to win.  I tried to find
> >>>> documentation on the physcial hardware, no luck.
> >
> > "physical"
>
> Thanks, will fix.
>
> >>>>
> >>>> For now, adjust the byte size passed to match the actual size create=
d,
> >>>> and add a FIXME comment.
> >>>
> >>> I'm pretty sure that FLASH_SIZE here is supposed to be a
> >>> byte count of the size of the pflash. That matches what
> >>> Linux has in arch/sh/boards/mach-r2d/setup.c where it
> >>> sets up the flash_resource struct.
> >>
> >> Okay, that's some evidence for size 0x02000000 (32MiB).
> >>
> >> However, we've created size (16 * KiB) * (FLASH_SIZE >> 16), i.e. 8MiB=
,
> >> since at least commit 368a354f02b (v1.3.0), possibly since forever.
> >>
> >>> The r2dplus board is also I think known as RTS7751R2D. That
> >>> takes us to https://elinux.org/RTS7751R2D_Handling_Manual
> >>> (sadly the link to the "hardware manual" is broken).
> >>
> >> Quote section Flash ROM Mapping:
> >>
> >>     Currently, MTD device mapping on Flash ROM is set as below.
> >>     0x00000000-0x00020000    "bootloader"
> >>     0x00020000-0x00320000    "mtdblock1"     XIP kernel
> >>     0x00320000-0x00520000    "mtdblock2"
> >>     0x00520000-0x01000000    "mtdblock3"
> >>
> >> Suggests a size of 0x01000000 (16MiB).  Now we have three candidates.
> >>
> >> Pick one, any one, and I'll adjust my patch.  All I really care about =
is
> >> getting argument @size consistent with arguments @sector_len and
> >> @nb_blocs, so I can ditch @nb_blocs in PATCH 09.
> >>
> >>> No idea what the block size would be.
> >>
> >> As long as that's the case, inertia wins by default.
> >
> > There is also a paper [*]:
> >
> >   The Renesas Technology R0P751RLC001RL (R2DPLUS) board was used
> >   as our target device.
> >   This board is often used to evaluate software for CE devices.
> >   The specification is shown below.
> >     CPU: SH7751R(SH4) 240Mhz
> >     RAM: 64Mbyte
> >     Compact flash: 512Mbyte
> >     Flash ROM: 64Mbyte (32Mbyte available for root file system)
>
> Candidate #4: 64MiB.  Bring 'em on!
>
> >
> > Let's use at least 16MB to be able to run the elinux cited kernel.
> >
> > [*] https://www.kernel.org/doc/ols/2008/ols2008v2-pages-125-134.pdf
>
> That's a vote for changing the status quo (8 MiB).
>
> Perhaps Magnus, who maintains the machine, can pick a new value for us.

According to the old board user document in Japanese (under NDA) what
is referred to as FROM (Area0) is connected via a 32-bit bus and CS0
to CN8. The docs mention s29pl127j60tfi130 but since I don't have the
board handy ATM I don't know how the chips are connected.

Hope this helps,

/ magnus
