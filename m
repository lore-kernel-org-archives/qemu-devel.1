Received: from eggs.gnu.org ([2001:4830:134:3::10]:36604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkpnV-0006OG-Rq
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:55:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dkpnR-0006q3-Sz
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:55:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dkpnR-0006nZ-7S
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 06:55:33 -0400
Message-ID: <1503572130.22313.8.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 24 Aug 2017 12:55:30 +0200
In-Reply-To: <CAFEAcA9Lz=pBZxYqHk7kdaU_LsvE34+DJmTm_jHSFeKzoCM3xw@mail.gmail.com>
References: <20170807163121.797e7ad6@nial.brq.redhat.com>
	<CAFEAcA8=+8cPjKayq3Bre7y9=6jzFgjCCjRkNUeHxArJu9Ue6A@mail.gmail.com>
	<be880655-0c04-8369-01fc-76dd6241ca78@redhat.com>
	<1503316706.26016.11.camel@redhat.com>
	<CAFEAcA9Lz=pBZxYqHk7kdaU_LsvE34+DJmTm_jHSFeKzoCM3xw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] AVMF & OVMF blobs in QEMU tree???
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Laszlo Ersek <lersek@redhat.com>, Igor Mammedov <imammedo@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

  Hi,

> Having all our precompiled blobs be in a submodule would
> maybe be handy for properly keeping them separate from the
> QEMU code -- would that be useful for downstream distro
> packagers?

I like the clear separation.

Also you don't have to fetch the firmware submodule if you don't need
the prebuilds.

It would be a good opportunity to cleanup the mess we have in pc-bios/
right now.

Clear disadvantage is that firmware updates will become more
complicated then as two repos must be updated.  So either two pull
requests per firmware update, or write access to the firmware binary
repo for all firmware maintainers.

Or maybe make the firmware sources submodules of the firmware binary
repo instead of the qemu repo.

> In any case this seems like a good opportunity to write down
> exactly what our policy about ROM blobs is (eg where they
> are, how we update them, requirement for source, whether
> we allow source to be in a submodule not on qemu.org...)

Tried to write down the current state.

cheers,
  Gerd

---------------------- docs/firmware.txt ------------------------

prebuilt firmware in qemu
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The process of building firmware isn't as easy as building qemu
itself, for example because you must have cross compilers installed
when building firmware for other architectures.=C2=A0=C2=A0So qemu ships
prebuilt firmware binaries for convenience reasons.


directories
-----------

pc-bios/
=C2=A0=C2=A0=C2=A0=C2=A0Firmware binaries.
=C2=A0=C2=A0=C2=A0=C2=A0Also other files like keymaps and logos which are=
 copied to
=C2=A0=C2=A0=C2=A0=C2=A0$prefix/share/qemu by "make install".

pc-bios/optionrom/
=C2=A0=C2=A0=C2=A0=C2=A0Firmware sources, part of the qemu project.

roms/
=C2=A0=C2=A0=C2=A0=C2=A0Firmware sources, third-party projects, as git su=
bmodules.


third-party git repos
---------------------

For third party firmware sources it is recommended to have a git
mirror on git.qemu.org.=C2=A0=C2=A0In case the firmware license is GPL th=
e git
mirror is mandatory for GPL compilance reasons:=C2=A0=C2=A0We ship binari=
es, so
we must provide sources too.


building the firmware
---------------------

Firmware builds should be done using rules in roms/Makefile.=C2=A0=C2=A0T=
hat
serves as documentation how the firmware is built, and it also makes
firmware updates easier for the maintainer.

"make -C roms" prints a list of firmware build targets.
"make -C roms $target" kicks a build.


notes for specific firmwares
----------------------------

ipxe: see https://wiki.qemu.org/IpxeDownstreamForQemu
