Received: from eggs.gnu.org ([209.51.188.92]:45993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1Pec-0005BR-Hd
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:03:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h1Peb-00020J-I7
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 01:03:46 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190218125615.18970-1-armbru@redhat.com>
	<20190218125615.18970-7-armbru@redhat.com>
	<CAFEAcA_OLYno=YNS6bHOemwEp0gnc3fwRn8Rjvmo9v-i89xrMA@mail.gmail.com>
	<87d0nnsrx0.fsf@dusky.pond.sub.org>
	<c6d4c021-8d62-ada0-d152-b1d4f2b7aff2@redhat.com>
	<87ftsjptxk.fsf@dusky.pond.sub.org>
	<CANqRtoSOF8uvh-9-_CgsuhB_N18NhSiS=DPsY1+3+ff4NzgE+w@mail.gmail.com>
	<87mumbcd8k.fsf@dusky.pond.sub.org>
	<f2c8f20d-17ad-b72b-28fb-c835d6b97c10@redhat.com>
	<87k1he1wnz.fsf@dusky.pond.sub.org>
	<e8b000bc-d457-7c5a-b7d2-4e3ff63d0c73@redhat.com>
	<CAFEAcA-9U_D=UWTUH69mBBuC+a=FgXBC5kSawoCxDM4nB_FPZw@mail.gmail.com>
	<90123914-f0c1-ea2e-f8e0-44fee62bb870@redhat.com>
Date: Wed, 06 Mar 2019 07:03:31 +0100
In-Reply-To: <90123914-f0c1-ea2e-f8e0-44fee62bb870@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Tue, 5 Mar 2019 22:50:45
	+0100")
Message-ID: <87pnr41qvg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cleber Rosa <crosa@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>, Laszlo Ersek <lersek@redhat.com>, Magnus Damm <magnus.damm@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>, Max Reitz <mreitz@redhat.com>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 3/5/19 6:25 PM, Peter Maydell wrote:
>> On Tue, 5 Mar 2019 at 17:21, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.=
com> wrote:
>>> But I'd recommend changing/fixing the sector size during the next dev
>>> cycle, so we have more time for testing.
>>=20
>> Nobody in the upstream dev community is using or testing this board.
>
> Well I submitted a Avocado test last year:
> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg02749.html
>
> And I rebase/run it from time to time.
>
>> The only way we'll find out if there's a problem with changing the
>> sector size is to put the change in and get it into a release.
>> I would vote for just making the change now.
>
> I'm happy with this vote, and am sure Markus will be too :)
>
> Markus: the last field I wasn't sure about without double checking the
> code is the @width one. I find it misleading, is that the size of the
> data bus or the size of the flash words? Answer: this is the size of the
> words in byte. NOR flash devices can not write less data than their word
> boundary.
>
> The S29PL127J60TFI130 only support 16bit words, so using @width=3D2 is
> correct.
>
> And the winner is.... ta-da!
>
>     pflash_cfi02_register(0x0, NULL, "r2d.flash", FLASH_SIZE,
>                           dinfo ? blk_by_legacy_dinfo(dinfo) : NULL,
> -                         16 * KiB, FLASH_SIZE >> 16,
> -                         1, 4, 0x0000, 0x0000, 0x0000, 0x0000,
> +                         64 * KiB, FLASH_SIZE >> 16 /* will get removed
> later */,
> +                         1, 2, 0x0001, 0x227e, 0x2220, 0x2200
>                           0x555, 0x2aa, 0);

Sold!

[...]
