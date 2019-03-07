Received: from eggs.gnu.org ([209.51.188.92]:53173)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1uR3-000225-IT
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:55:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1h1uR2-0006XI-2S
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 09:55:49 -0500
Date: Thu, 7 Mar 2019 15:55:32 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190307145532.GG5786@linux.fritz.box>
References: <20190307093723.655-1-armbru@redhat.com>
	<20190307093723.655-3-armbru@redhat.com>
	<87h8cft2x6.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <87h8cft2x6.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC PATCH v6 2/4] hw/block: Pad undersized
 read-only images with 0xFF
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, alex.bennee@linaro.org, lersek@redhat.com, philmd@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

Am 07.03.2019 um 11:05 hat Markus Armbruster geschrieben:
> Markus Armbruster <armbru@redhat.com> writes:
>=20
> > From: Alex Benn=E9e <alex.bennee@linaro.org>
> >
> > We reject undersized images.  As of the previous commit, even with a
> > decent error message.  Still, this is a potentially confusing
> > stumbling block when you move from using -bios to using -drive
> > if=3Dpflash,file=3Dblob,format=3Draw,readonly for loading your firmwa=
re
> > code. To mitigate that we automatically pad in the read-only case and
> > warn the user when we have performed magic to enable things to Just
> > Work (tm).
> >
> > Signed-off-by: Alex Benn=E9e <alex.bennee@linaro.org>
> > Reviewed-by: Laszlo Ersek <lersek@redhat.com>
> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>=20
> I think this convenience feature is a bad idea, and this patch should
> not be applied.  Here are my reasons.
>=20
> 1. As I explained in my disccussion of v5[*], there is no single true
>    way to pad.  This patch pads with 0xFF.  When working with physical
>    devices, you'd sometimes pad that way, but at other times, you'd pad
>    differently.
>=20
> 2. Except this patch doesn't *actually* pad with 0xFF.  The block layer
>    silently pads with zeros up to the next multiple of 512.  Evidence:
>=20
>     $ yes | dd of=3D4090b.img bs=3D1 count=3D4090
>     4090+0 records in
>     4090+0 records out
>     4090 bytes (4.1 kB, 4.0 KiB) copied, 0.0186459 s, 219 kB/s
>     $ qemu-io -f raw -c 'read -v 4000 96' 4090b.img
>     00000fa0:  79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a  y.y.y.y=
.y.y.y.y.
>     00000fb0:  79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a  y.y.y.y=
.y.y.y.y.
>     00000fc0:  79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a  y.y.y.y=
.y.y.y.y.
>     00000fd0:  79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a  y.y.y.y=
.y.y.y.y.
>     00000fe0:  79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a 79 0a  y.y.y.y=
.y.y.y.y.
>     00000ff0:  79 0a 79 0a 79 0a 79 0a 79 0a 00 00 00 00 00 00  y.y.y.y=
.y.......
>     read 96/96 bytes at offset 4000
>     96 bytes, 1 ops; 0.0001 sec (694.444 KiB/sec and 7407.4074 ops/sec)
>=20
>    This patch then pads some more with 0xFF to the flash memory size.
>=20
>    Because of that the way the magic padding works makes no sense, to b=
e
>    frank.  Going back to v3's zero padding would at least be explainabl=
e
>    without blushing.
>=20
>    I consider the block layer's padding a misfeature here, but right no=
w
>    we got to play the hand we've been dealt.

That will be solved as soon as the block layer is consistently converted
to byte granularity. We've already converted a lot, but bdrv_getlength()
is still sector (512 bytes) granularity.

You could argue that file-posix should just reject files that are not
sector aligned, but that's probably not right either because image
formats don't necessarily have that alignment for their files.

Maybe disk device should reject being attached to nodes that aren't a
multiple of their physical and logical sector size. A 512-byte aligned
image is probably suitable for most disks, but might not be for a virtual
native 4k disk.

> 3. Convenience magic has bitten us in the posterior so many times.  Jus=
t
>    say no unless there's a really compelling use case.  Where's the use
>    case for this one?  We've rejected undersized images for ages, and
>    nobody complained.  Why add convenience magic now?

I agree.

Kevin
