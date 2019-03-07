Received: from eggs.gnu.org ([209.51.188.92]:47376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1xLN-0004Sv-2W
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:02:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h1xLJ-0003qy-PH
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 13:02:08 -0500
References: <20190307093723.655-1-armbru@redhat.com>
	<20190307093723.655-3-armbru@redhat.com>
	<87h8cft2x6.fsf@dusky.pond.sub.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <88775547-9284-dbaf-e352-29060553f683@redhat.com>
Date: Thu, 7 Mar 2019 19:01:56 +0100
MIME-Version: 1.0
In-Reply-To: <87h8cft2x6.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, philmd@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org

On 03/07/19 11:05, Markus Armbruster wrote:
> Markus Armbruster <armbru@redhat.com> writes:
>=20
>> From: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>
>> We reject undersized images.  As of the previous commit, even with a
>> decent error message.  Still, this is a potentially confusing
>> stumbling block when you move from using -bios to using -drive
>> if=3Dpflash,file=3Dblob,format=3Draw,readonly for loading your firmwar=
e
>> code. To mitigate that we automatically pad in the read-only case and
>> warn the user when we have performed magic to enable things to Just
>> Work (tm).
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Reviewed-by: Laszlo Ersek <lersek@redhat.com>
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>=20
> I think this convenience feature is a bad idea, and this patch should
> not be applied.

I'm fine with that.

Thanks,
Laszlo


>  Here are my reasons.
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
>=20
> 3. Convenience magic has bitten us in the posterior so many times.  Jus=
t
>    say no unless there's a really compelling use case.  Where's the use
>    case for this one?  We've rejected undersized images for ages, and
>    nobody complained.  Why add convenience magic now?
>=20
>=20
> [*] Message-ID: <87r2bl5oah.fsf@dusky.pond.sub.org>
> https://lists.nongnu.org/archive/html/qemu-devel/2019-03/msg01115.html
>=20
