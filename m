Received: from eggs.gnu.org ([209.51.188.92]:34647)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0pbc-0003JR-VY
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:34:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h0pbb-00050S-EU
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 10:34:16 -0500
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
Date: Mon, 04 Mar 2019 16:33:52 +0100
In-Reply-To: <f2c8f20d-17ad-b72b-28fb-c835d6b97c10@redhat.com> ("Philippe
	=?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Mon, 4 Mar 2019 12:43:10
	+0100")
Message-ID: <87k1he1wnz.fsf@dusky.pond.sub.org>
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
Cc: Magnus Damm <magnus.damm@gmail.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Qemu-block <qemu-block@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>, qemu-ppc <qemu-ppc@nongnu.org>, Laszlo Ersek <lersek@redhat.com>

Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> On 3/4/19 8:25 AM, Markus Armbruster wrote:
>> Magnus Damm <magnus.damm@gmail.com> writes:
>>> On Wed, Feb 20, 2019 at 2:31 AM Markus Armbruster <armbru@redhat.com> w=
rote:
>>>> Perhaps Magnus, who maintains the machine, can pick a new value for us.
>>>
>>> According to the old board user document in Japanese (under NDA) what
>>> is referred to as FROM (Area0) is connected via a 32-bit bus and CS0
>>> to CN8. The docs mention s29pl127j60tfi130 but since I don't have the
>>> board handy ATM I don't know how the chips are connected.
>>>
>>> Hope this helps,
>>=20
>> If you want me to change our emulated flash memory's size, please give
>> me a number.
>
> datasheet "S29PL-J 002-00615 Rev. *E":
> https://www.cypress.com/file/207091/download
>
> The S29PL127J60TFI130 is a 128Mbit NOR pflash addressable in words of 16b=
it.
>
> 128Mbit =3D 16 MiB
>
> At least it matches the "RTS7751R2D Handling Manual"!
> https://elinux.org/RTS7751R2D_Handling_Manual#Kernel_start_from_FROM_exte=
nsion_card_.28Kernel_space_XIP.29
>
> PL127J:
> - 4 Banks
>   -> we don't model banks.
> - sectors of 4Kw and 32Kw
>   -> we don't model different sector size and only use the
>      biggest available
>
> sector_size =3D 32Kw =3D 64KiB // sector_len
> (naive) sector_count =3D 256 // nb_blocs
>
> ManufID:  0001h
> DeviceID: 227Eh 2220h 2200h
>
> I understand "connected via a 32-bit bus and CS0 to CN8" as the full
> device wordsize is addressable, so this device
>
> So in pflash_cfi02_register() format:
>
> - name =3D "FROM (Area0)"
> - size =3D 16 * MiB
> - sector_len =3D 64 * KiB
> - nb_blocs =3D 256
> - nb_mappings =3D 1? /* Machine specific... */
> - width =3D 2
> - id0 =3D 0x0001
> - id1 =3D 0x227e
> - id2 =3D 0x2220
> - id3 =3D 0x2200
> - unlock_addr0 =3D 0x555,
> - unlock_addr1 =3D 0x2aa
> - be =3D 0 /* Arch specific... */
>
> Which hopefully is very similar to what we currently use :)

'fraid not:

    $ qemu-system-sh4 -M r2d -display none -S -monitor stdio
    QEMU 3.1.50 monitor - type 'help' for more information
    (qemu) info qtree
    [...]
      dev: cfi.pflash02, id ""
        drive =3D ""
        num-blocks =3D 512 (0x200)        <--- instead of 256
        sector-length =3D 16384 (0x4000)  <--- instead of 65536
        width =3D 4 (0x4)                 <--- instead of 2
        mappings =3D 1 (0x1)
        big-endian =3D 0 (0x0)
        id0 =3D 0 (0x0)                   <--- instead of 0x0001
        id1 =3D 0 (0x0)                   <--- instead of 0x227e
        id2 =3D 0 (0x0)                   <--- instead of 0x2220
        id3 =3D 0 (0x0)                   <--- instead of 0x2200
        unlock-addr0 =3D 1365 (0x555)
        unlock-addr1 =3D 682 (0x2aa)
        name =3D "r2d.flash"              <--- instead of "FROM (Area0)"
        mmio 0000000000000000/0000000000800000

Not shown: size is num-blocks * sector-length =3D 512 * 16384 =3D 8MiB
instead of 16MiB.

Which properties would you like me to change, and how?
