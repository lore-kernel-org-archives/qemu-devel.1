Received: from eggs.gnu.org ([2001:4830:134:3::10]:42585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1gCMBV-0008Uk-KT
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:02:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andre.przywara@arm.com>) id 1gCMBO-0003Iw-DI
	for qemu-devel@nongnu.org; Tue, 16 Oct 2018 06:02:41 -0400
Date: Tue, 16 Oct 2018 11:02:00 +0100
From: Andre Przywara <andre.przywara@arm.com>
Message-ID: <20181016110200.0b20a7f3@donnerap.cambridge.arm.com>
In-Reply-To: <65e2edeee9d94a288938da9cec4b16bb@dornerworks.com>
References: <40eb19fb56b24e10a5eaa99ccb78aff6@dornerworks.com>
	<73dcea68-2342-63b7-9691-a151f00a42e8@redhat.com>
	<65e2edeee9d94a288938da9cec4b16bb@dornerworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] hw/arm/boot: Increase compliance with
 kernel arm64 boot protocol.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Julien Grall <julien.grall@arm.com>, Peter Maydell <peter.maydell@linaro.org>

On Tue, 16 Oct 2018 01:19:35 +0000
Stewart Hildebrand <Stewart.Hildebrand@dornerworks.com> wrote:

Hi,

Stewart, thanks a lot for picking this up!

> On Monday, October 15, 2018 6:05 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> > Hi Stewart,
> >=20
> > On 15/10/2018 23:26, Stewart Hildebrand wrote: =20
> > > +            /* For the virt board, we write our startup
> > > "bootloader" at the very
> > > +             * bottom of RAM, so that bit can't be used for the
> > > image. To avoid
> > > +             * overlap in case the image requests to be loaded
> > > at an offset
> > > +             * smaller than our bootloader, we increment the
> > > load offset to the
> > > +             * next 2MB.
> > > +             */
> > > +            if (kernel_load_offset < FIXUP_MAX) { =20
> >=20
> > I don't understand how this is related to FIXUP_MAX... =20
>=20
> You're right, my apologies, it's not directly related.
> write_bootloader() calculates the size of the bootloader like so:
>     len =3D 0;
>     while (insns[len].fixup !=3D FIXUP_TERMINATOR) {
>         len++;
>     }
>=20
> The size of the bootloader then would be len * sizeof(uint32_t)
>=20
> It would be nice not to have to repeat that logic in
> load_aarch64_image(). I'll send out a v2 after I take some time to
> wrap my head around it...=20

I wonder if this could be done much easier, since TEXT_OFFSET must
actually be page aligned. So all we would need is an *upper bound* for
the bootloader size, as long as that is below 4K we wouldn't even loose
anything.

Cheers,
Andre.

> >  =20
> > > +                kernel_load_offset +=3D 2 << 20; =20
> >=20
> > You can use +=3D 2 * MiB; which is easier to review. =20
>=20
> OK, I will include this in v2.
